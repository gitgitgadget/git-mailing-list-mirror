Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AEEC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 17:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiBZRb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 12:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiBZRb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 12:31:27 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7237BE0
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 09:30:53 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s1so10204290iob.9
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVe5r/zcg0gyjDejj07uYsRrqBGjwnXoVxCLgo9Oy/0=;
        b=Hof69sR/+WJe9sBplJTdNbuFnY3CBTjqktS8lR1PD8BhHAiwqxV5Z8bUbL/c6mIz71
         CS0hZONQiWu0JsBrJTXiwEBsRLbn4IhbThcR9NRjkyTLiny769DbJg67YQk109bspbR4
         zF5Roopwjo3W+DRuu6tCYqQdrXCj/bwI5RHxXxHpbj3s4Mmuw6Eziw9CzcdhS2pJ2hWL
         /n5pCG25VXXjekOC4+3MQBC+B1uoyOMB6FRRMAw+2ulsnVzctpjw4501LfUlDpNHxxEr
         wxJSFLpaYpbEDucyfaWZ3CNG/qPToYPkJQutx9dfhErBy1Xr+BN2XLsh77YTIcwTTJ0B
         J5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVe5r/zcg0gyjDejj07uYsRrqBGjwnXoVxCLgo9Oy/0=;
        b=FTe2IPph5SvH74KXUyjz0S6PYHQhnGHAJzHMhCYtkIvJ3qMTQYfZ4SWH7osyBr9U8O
         LvyKIKy3rdRFnD4m/BWBTdVs3T1cxdcqan+UCDrisCZ3odR7sCYs3B/Dssxl5ZyQruTv
         MjPFPCpH8kQJpjR8crn6jqFes+sfdF8iWNaVI8nQQB1tb6UWdeTKqa5d4NguvePhYaja
         I229Ko7si4TRyGmcpnbKIa8a+2wVBGFSKGZ2bIzlRPrSBz+p1c24gHY/UXvSwFkTb5vT
         /p/PyzFcyVFyHTNBavdWK7dF0hm0Dqmkz8bhaznIX2qZxA7GHGVETm/8esCdV1taYmDH
         u/CQ==
X-Gm-Message-State: AOAM533Xerc9DGT2ds3ZIl4FoYWj61mxBv+V/SCl+bwYDVdTJmDqoZyd
        PLWksHPrvP2Jvaz+PWj8FK7rh5xfgzD0BRPY
X-Google-Smtp-Source: ABdhPJxIX/qWTW6Xe58aNu0d4nUJirv9h/vj8QcdgY67iguM8l/KcPc5tkqZ/IM/Eq3CzAXRSDw7ng==
X-Received: by 2002:a02:c551:0:b0:314:ac09:428d with SMTP id g17-20020a02c551000000b00314ac09428dmr10433430jaj.0.1645896652601;
        Sat, 26 Feb 2022 09:30:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e02055000b002c2877213bdsm3500621ils.3.2022.02.26.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 09:30:52 -0800 (PST)
Date:   Sat, 26 Feb 2022 12:30:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] [GSoC][PATCH 0/2] t0000-t0050:
 avoid pipes with Git on LHS
Message-ID: <Yhpjy77nWZc4oTll@nand.local>
References: <20220224054720.23996-1-shivam828787@gmail.com>
 <CAC316V4F0UTEk8+=oThMNeQpsUjs78EkY2Qrw6rz7TCKXSyqzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC316V4F0UTEk8+=oThMNeQpsUjs78EkY2Qrw6rz7TCKXSyqzA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 11:21:05AM +0530, Shubham Mishra wrote:
> for further reference, you can follow the discussion on my last
> patchset - https://lore.kernel.org/git/20220222114313.14921-1-shivam828787@gmail.com/

In the future, you can use `--in-reply-to` to make sure that subsequent
versions are attached to the previous version's thread.

Thanks,
Taylor
