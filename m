Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7298AC001B0
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGZSAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGZSAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 14:00:42 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BE212F
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 11:00:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-576a9507a9bso18372317b3.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690394439; x=1690999239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSLCSEjKzTNIQgMWmFtpzAFG5umxGdkcVi0/DolB0PY=;
        b=CDDCigwEUhZ5nAfJ2rMN+ttHO2C2E3JjTSaZaaEfsfvNGOoK7qHKljUeX20b4sLyZF
         VkpAWNbC20zNi6+GX6+3//k0LxrDtRyPhu6GpporpyjwgJ3DhB5dlnGJ3Et07psFixGl
         WjZeLWlu5rAE9I5IrISXBknOzqQTp7SSzTitGn0HO/2bbmDHOC48uF3/4CP5LIY2Orog
         SA9m1EYE/4bcbLOTl0jZKDrZ8QRo22HxiFib6CU3FYWikuoDvHvC7Vl4dAebAmWy2zmX
         tkhMKD03PD5fjgkze9DPAgvm9+qpvIP2H7yu31hptUnIDYGjZldcVxflopSpBv3MdBa/
         Ba6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690394439; x=1690999239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSLCSEjKzTNIQgMWmFtpzAFG5umxGdkcVi0/DolB0PY=;
        b=SrYddxrUszz2QyhFi+8Q+14X32/xHVQ/pEeHtu6jBzLLifc9V+ZLGv9GCjkm0+/eju
         i3bqULZYUo5AaaS6LuKwi09Tnx0ZeYRCEHe6EKbO59kvkg+HDtgER3POm68Ya2UXRSTg
         VS8j6sJj/cVn7SH2hWrO1fZ0es/SuIZUhaIoPG13l8nbtXYDsjbkdMSvNg8GBw/sSd1q
         4s4t9mw2KkLVSbgtdP/7m7hJzmQRwWB2nAS5AytRqbwyIYzPjyMiMXzKeLND605hLt5J
         R4Sr83F3k5E6m/cFOdOVj8hoSz9m8kIoFBeN1Dkzx9VIgjIQwQmRjIxrtBXUdPZdfTrC
         Vh9g==
X-Gm-Message-State: ABy/qLYn/yRiqpElYXh6M+33KsgXH+cHNobmCf3uxp3nzcjRibHBhwjr
        gp12C6nyNhjfapXqaMQsKW0wMmtxLOIJz4lAjfokZw==
X-Google-Smtp-Source: APBJJlHJ/Sgsm43YURYvMKkVhMfM0uq9w0QSZGrdRar1+IlLPqqXPnbwrKnVvO8nagAzrvh2o47noQ==
X-Received: by 2002:a0d:e602:0:b0:579:e976:c976 with SMTP id p2-20020a0de602000000b00579e976c976mr393274ywe.2.1690394439597;
        Wed, 26 Jul 2023 11:00:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s65-20020a0dd044000000b005832fe29034sm4292139ywd.89.2023.07.26.11.00.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:00:39 -0700 (PDT)
Date:   Wed, 26 Jul 2023 14:00:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2023
Message-ID: <ZMFfRiTSXcrkzdAJ@nand.local>
References: <ZMATKIaU1A1D0wJg@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMATKIaU1A1D0wJg@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2023 at 02:23:36PM -0400, Taylor Blau wrote:
> Participants should fill out the following forms:
>
>   - https://forms.gle/xiRcJWBAWJjWR7Zh6 (participants)
>   - https://forms.gle/rQ5oWVSVBwyPZ1K29 (topics)
>
> The participants and topics lists are being recorded in the
> spreadsheet below, and this is also the place to record your vote(s)
> on topic selection.
>
>   http://bit.ly/git-contributors-summit-2023

FYI, I added the first week of October as a potential set of dates as
well.

I configured the participants form to accept at most one response per
person, but with the ability to edit any existing response.

This configuration seems to require a Google account, please let me know
if that's an issue for anyone.

Thanks,
Taylor
