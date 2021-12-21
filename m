Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67BAC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 11:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhLULkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 06:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbhLULka (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 06:40:30 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6DC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:40:29 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id m12so20942142ljj.6
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 03:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nW73vSQCRoDRWh6T62PXAgsTHiF3qC53BhacKzvplJ4=;
        b=TOaOVPBpSwvT8mRipw1FoXKoUA2mtDodyGeplsBGy/OeWMylvWUfo/DB6k8czZplUq
         F2Gqpxs1fe/v86swFpt+siOQA5ZJcQkQSYYRZ+HYqBErE77lsf+Vp14IUuZQlgN/3xqG
         bqJ+F/ZaouLIrR7Y6AdReLS0tAHHVmsx9dNhAWcld9E1LtnEfvymrCX1qQ8eWluCQHIo
         1vV8YOYFSlBWGjbTxt7w+mp5OsOh797cvadCKVMHzVYTt2kwdU3OQi18DmOPIUfxA77B
         uM9fIx0laMhM3NO+1+R3fpTZbm6bu1474kHa6yIQ3fmPQX7fYOaVyKlH2abGitexuATk
         gMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nW73vSQCRoDRWh6T62PXAgsTHiF3qC53BhacKzvplJ4=;
        b=QevgvxQhwt0NJbkEfQUj8Hvh9BZUyFGFWKg+MeIk2xoZzTlSPdWry0kbdnpwrIYXBs
         9n8gJEo78B9q2HENTehY2gx5sdM5v6MpsrtzzPVjNt05QvP/57feV9Xv6BAzil2dTaq3
         0Z/rFRg6I02FfQDHtQpfpu0oFKkh/6hPV781ML8Ssy+oKplqiGyxHS/vLVZ6T4E4kWsS
         XtxawB3BP3srY6yZ6SsqFCistIFkc1U31NKjbH3PMNsJKV2bLIF/bpHflvM3d6ywW+pt
         DGO3OrkgNuTRpRXjuPXAXCFsEHJfjEB0Qjb1HftU+OTCLoG87B3lHr/kPzm6pjFCAQ65
         Wt1w==
X-Gm-Message-State: AOAM532yACMChEc4MQA0O3Ro0SeuHNfI0rB4A0V1Yv5DagDCzg1nV3ze
        tndA9hB+fQe4augYqIHpr3yIfbgmixMYuIn1hi0=
X-Google-Smtp-Source: ABdhPJw1pUFR9IsgkAvuQeTk1l8izdBTsNBMo8N7w9AcrRF6vvlsIgrG2vCz/gF6AiXOf5/97Dkl7K543Dpbz01Kutg=
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr2232246ljp.481.1640086828040;
 Tue, 21 Dec 2021 03:40:28 -0800 (PST)
MIME-Version: 1.0
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 21 Dec 2021 19:40:17 +0800
Message-ID: <CAO0brD1f+w_J1jVzsBb0ewc7Ndwiz5pLC2QOG11r5-H0XetOAQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] unpack-objects.c: add dry_run mode for get_data()
To:     l.s.r@web.de
Cc:     avarab@gmail.com, chiyutianyi@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, hanxin.hx@alibaba-inc.com, peff@peff.net,
        philipoakley@iee.email, stolee@gmail.com, zhiyou.jx@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Clever.  Looks good to me.
>
> For some reason I was expecting this patch to have some connection to
> one of the earlier ones (perhaps because get_data() was mentioned),
> but it is technically independent.

I think I should adjust the order of this patch to move it forward.

Thanks
-Han Xin
