Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6397DC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 06:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2756117A
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 06:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhKJGij (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 01:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhKJGii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 01:38:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59934C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 22:35:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v127so1138189wme.5
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 22:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QiRhaQWGyMCKoU5ZabsXRbJhlfXytz1jbncQyH7i5pg=;
        b=bAjDGDTNIsqqleOAr0i2kBtEg4DVaZS/2mVSz0asnpgb6dYo4TbCCS6NBVPlfxhDK6
         4Sbs+HExXXd/nDpN4uHeeocshZD6KDOUNQubPWUZFjeXKxIu1WA2VOIm2gJwAbLumd7B
         4OSJ4urdSi67Z3FtOAFIxsIBhwp8T9U/Ps0Kutw6K+B4AzUxsm3ZogYOG0fRpHIgPTB/
         OpKWitBhTe1bSay+7AxAKuhWbqSxjwgkbOLnIFkTv7sWd+SHw1g/uIvk7cfnG4yzD0oN
         ZuhCDgPbEdEsIXET8bqLkOjtl8fLA7RsnuKsmfoDjylpspKFALE5ORF8Irgmcb0wvvS+
         v1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QiRhaQWGyMCKoU5ZabsXRbJhlfXytz1jbncQyH7i5pg=;
        b=157gxSl7cJA6x6bRSZcv2/pHgFBxPvhxyKimOLgPl5ys2/XcQQo45Lg8ut8/hB94Mj
         au7mEVV17T+/wCsGgzYnFHnWi95BkWXAjU93kwDjsUiWfdf7wp+UGlyIPMePNqohsW9x
         V0PGMg9F4fNgm+uAsI45E+vXNyiGgcQsovR58XKuLHbSFTBD9w/CEj/CeZROr4BOeEa/
         l77Gg91oBagtjk1ofnKnFzHNsPxxiTNsrXLVxoz8wSPpbC5YWpOU/XC4CjjTHnBn1WeN
         CBiuOh8dMlCO0YKuVmmCiCuvzQ2MF3Qy+/r5fst5edyuKiNx4HJz24uL8fRDmnQfoxI2
         rA+g==
X-Gm-Message-State: AOAM533Q15GxxXUQT8z8caLnwvYL21z8Nta4MnBnWgq6BtwHWG52ZdSg
        bkAwM0OjJ0w4LXw8UL/zk27qEqpvUNY=
X-Google-Smtp-Source: ABdhPJw+Qc63nm+eJOlJoGKwKd8a0ijSXHnnFTFcf62kfWpgg0WU4ghCQmAbtz4WmqJs7yIdWW2A4Q==
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr13558908wmq.175.1636526149833;
        Tue, 09 Nov 2021 22:35:49 -0800 (PST)
Received: from gmail.com (193-81-59-46.adsl.highway.telekom.at. [193.81.59.46])
        by smtp.gmail.com with ESMTPSA id p12sm26152307wrr.10.2021.11.09.22.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:35:49 -0800 (PST)
Date:   Wed, 10 Nov 2021 07:35:47 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <20211110063547.xcpjjzoobha3eeff@gmail.com>
References: <xmqq4k8kzuz2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4k8kzuz2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 04:59:29PM -0800, Junio C Hamano wrote:
> A release candidate Git v2.34.0-rc2 is now available for testing
> 
> Fixes since v2.33
> -----------------
> 
>  * Doc update plus improved error reporting.

This should be something like

 * Warn when iconv(3) fails to reencode log messages.

> 
>  * Recent "diff -m" changes broke "gitk", which has been corrected.
> 
>  * Regression fix.

I assume that generic merge messages like "Regression fix." or "Doc update."
are meant to be dropped or replaced, maybe

  * Fix a v2.33.0 regression where "git send-email" would use wrong values for
    sendemail.* options that are defined in multiple configuration files.

>  * One CI task based on Fedora image noticed a not-quite-kosher
>    consturct recently, which has been corrected.

I guess consturct -> construct

>    (merge 4b540cf913 vd/pthread-setspecific-g11-fix later to maint).
