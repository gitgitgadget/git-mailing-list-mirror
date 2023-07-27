Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD822C00528
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjG0T0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjG0T0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 15:26:34 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679DD2703
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 12:26:33 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563ab574cb5so912604a12.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690485993; x=1691090793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIqdVPymLEFYzMMm65Zor4h2PBKJyqjImOGUgNSzNNY=;
        b=Qegty3DKpcb03+4IzYTAiyksG9M3Ah7ixaDufcWFzvtUgSQesJ9Nhq9dPvU2EErIv3
         jXdmoMv4g6zGubVnv43VrYjfagpm4hmWXk8wmkZ77JBtJZINTPu+4jBoWeNRXlXxM5f2
         IPuBpMFIHWBb2h9oxZK+TevJL2DyOIZz2phPLyJYtWT33lk83cFbw0unv0OyxIL17RNu
         Aq+diMrI70/sJbiXsp1TUcwVLLG2fsAEwh93pmKAuD9n5dwrARnVFUnlNSQ0iGVgGe9O
         U49B//ubjyqYC2boGFJT6qTbJ7jwRkvs3BZ7XuKRihEG0HsSLwxXXvN3HMsGmM3wl8nu
         faKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485993; x=1691090793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIqdVPymLEFYzMMm65Zor4h2PBKJyqjImOGUgNSzNNY=;
        b=KMA8fga6wXM8WygssRNMNUZXb3GpICEgqzcO8fXpS1CAy0dAGsDkJ84D9RokBMfTjI
         EGe5i9HYPPtqHO6bf5YPGF7ddJUIfSUeyNGe4Pml3iddKZXuMd37roItTwmfsD11O6jd
         4Oomcn+0zwuR2cy1Th8fSvp51NDfc2HFkiaE9COi2+ytG+kpfWkJhjRdcXoO5s3XY6Or
         ydAu8bydaLIZZpyX9GCqKwr0Fkz5ElDm8FfPVDcahqY1ZuhIee8NTwo2527G+EycYTf+
         CKxBPUFJiRDD5LnNaCXfZXNvlmGPOqu2+tq3W/Pzmw+kXV/u3r/swHtdO7objpZkcoSz
         Kisg==
X-Gm-Message-State: ABy/qLbBJzdlGUmOW0mnY3cdqwjfCmtpETmIVpPIoInsp3xl6dTHVtzz
        UTWCmX/pmk8rx4n1bsb9sD3kmD3ra6Q=
X-Google-Smtp-Source: APBJJlG3FcEkzstjloQ+2vgiFb0kGh70lUycULwK1t0GLnrgWLAb86qfJ3NZf9uHH3rv+dj6zfboB6xeoPY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:ceca:b0:1bb:b74c:88fa with SMTP id
 d10-20020a170902ceca00b001bbb74c88famr1020plg.6.1690485992831; Thu, 27 Jul
 2023 12:26:32 -0700 (PDT)
Date:   Thu, 27 Jul 2023 12:26:31 -0700
In-Reply-To: <xmqqbkfzfdzo.fsf_-_@gitster.g>
Mime-Version: 1.0
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
 <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> <xmqqbkfzfdzo.fsf_-_@gitster.g>
Message-ID: <owlylef1f95k.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 7/5] SubmittingPatches: explain why 'next' and above are
 inappropriate base
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index d1e3783978..559c02c90c 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -57,10 +57,14 @@ latest HEAD commit of `maint` or `master` based on the following cases:
>  
>  This also means that `next` or `seen` are inappropriate starting points
>  for your work, if you want your work to have a realistic chance of
> -graduating to `master`.  They are simply not designed to provide a
> -stable base for new work, because they are (by design) frequently
> -re-integrated with incoming patches on the mailing list and force-pushed
> -to replace previous versions of these branches.
> +graduating to `master`.  They are simply not designed to be used as a
> +base for new work; they are only there to make sure that topics in
> +flight work well together. This is why both `next` and `seen` are
> +frequently re-integrated with incoming patches on the mailing list and
> +force-pushed to replace previous versions of themselves. A topic that is
> +literally built on top of `next` cannot be merged to 'master' without

s/'master'/`master`

(Sorry I missed this in my patch.)
