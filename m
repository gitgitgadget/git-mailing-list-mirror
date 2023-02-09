Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8C7C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjBIVbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBIVbW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 16:31:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0E5ACC1
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 13:31:21 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id ch10so2598842qtb.11
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 13:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkauYITKBLV7Xn1IvfWFezy7dcbe+gLsib9HRx3M0ms=;
        b=X+/txNQY647ILjKHS6lP1chKylN9iMNYRUTa5oulR99r4F9V1X5ia4BIbpi+OIzgUt
         qr1lDer7krL0Kzyh0hqiFg+OVahV10bBfptz5Waj8vCrLtGNIpg25xUEUatMkxAZyEGl
         uI8810yXcOIFskp+Jxc3OVEhBx3vdq3VpRnQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkauYITKBLV7Xn1IvfWFezy7dcbe+gLsib9HRx3M0ms=;
        b=lYwb91gLVxF/rJVUs91T0vkBdwRZToTUSy5iEuYVC+2tIZ0S40wK4/UOKEvJJvvzx1
         fCxIJwykdvTZNEdk3wQzQO1ypSs4oupA5Ic/vDrprgT8Rk+Zc+DKH9FrjFEE7HqG8y1X
         NrvBCsDHS2CIuNx8srtgZiX5kSJQD6cy9BTw2qfp7an7nJOpA7TuPMI/kVHwKxvUPHZ6
         pXgE9Egs+asHjWS2w0G7k00mNfEVa74tC6Pw8utXc8cvS26S/1Yut03uvKMSHaoPAkDB
         O+oY0ydVXKkurB0BWIyCFsdxaROSnY/2Vd2xEeca2g21XNL1bZ0Pyck3CdkjB3nrLhGK
         31Qg==
X-Gm-Message-State: AO0yUKXHRSzmY716ELkj0P0ziNfFRsX/nUx9hBevB6woi35C20ZYB2UO
        nQs2qM1TFfSSv6Lbt+q/45d5xtxDHEANHiUk
X-Google-Smtp-Source: AK7set/UOnj9nJ6B/huEl7WJX47UtTXDThSV18DxIbjewJKfm6gLGmQ/3FaElkYNWd8u5Uh34i8atQ==
X-Received: by 2002:a05:622a:60f:b0:3b9:a754:30db with SMTP id z15-20020a05622a060f00b003b9a75430dbmr23327047qta.13.1675978280644;
        Thu, 09 Feb 2023 13:31:20 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id y10-20020ac8128a000000b003b68ea3d5c8sm2025905qti.41.2023.02.09.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:31:19 -0800 (PST)
Date:   Thu, 9 Feb 2023 16:31:18 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: The sad state of git.wiki.kernel.org
Message-ID: <20230209213118.lhyjdndhs5ouk36w@meerkat.local>
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
 <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
 <CAP8UFD1q7-XbX4C_NjyL7A-6n6Nc4MgSbUKnzQOiRyKRMtLv_w@mail.gmail.com>
 <20230206214101.fe6rismtfzv4k75n@meerkat.local>
 <Y+KT9pHivnUyyu0K@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+KT9pHivnUyyu0K@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2023 at 01:09:58PM -0500, Jeff King wrote:
> > Okay, here's what I have:
> > 
> > https://archive.kernel.org/oldwiki/git.wiki.kernel.org/
> > 
> > It's just a static scrape excluding all Special: and User: pages, and carrying
> > a very large "OBSOLETE CONTENT" warning.
> 
> That looks just fine to me. Thanks for taking care of this!

This is now done. Thank you, everyone.
The git.wiki.kernel.org site is now permanently archived.

-Konstantin
