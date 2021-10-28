Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83063C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578DD60EB4
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 19:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJ1TJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 15:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1TJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 15:09:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207FCC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 12:07:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so28582889edj.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:mime-version:content-language
         :content-transfer-encoding;
        bh=/4h6Ig9/1TYzlysypwCY/C1tnxwIfBtGK2fHrOK9AAc=;
        b=B5Hqsk49Osz2673v9uBRzeEeVa26BEBhIM1vhKlAWWLtVRQhC+tRhNA4h7Pa1RUY3H
         Z7QgfCQ5JJD5h/henfS7FBJ3gdEUHFcF9FfbtGCu6I/lP2lP39xKbPtRTaKzyAn4rHp2
         na/beWucDXmqGBMaO+73LhPw45lBkRwRVLeWKQWoy3nS4wjwqVgBDNOY/Nw6Lx4uR/5Q
         skdIxkWhXDsw1pgBly/nsTXYXuHXCHDX5oe/cKttv69CF/dd92pe5pTH11mSKgCn33RJ
         kmiqWpGEp8lvxOKclnG6/q2f71yGnPQpP13s6zCZeHFtBM6s4WeTyDM5Kpp5HwGjI7m2
         NVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=/4h6Ig9/1TYzlysypwCY/C1tnxwIfBtGK2fHrOK9AAc=;
        b=JCR4GtXUAErA4K2WaST8O9DsND/i94iAmKqpcErY026VAQ2JgcfulmeVusmSU9FeRm
         fPsEVtJVzpcX8m/bfu2Trb9GB1AkCl6aVM5MB5rkgraPgvLNzKHMy0D88UfaozS3Ku3H
         Dy2NWNUP8NAQ2Gw248AnD1Uinj5TPVtpnJjmGlMSxziLdAKVL9Pv4LJtCrYcZebJi5PR
         kR1UuBnJ20BAQhyMCnZXQmGd3w8NHO7g84/YpZ9w2fJB7n35868HuPg6BYExnWoKgFlR
         cfFyhSbJ957dM3TfqV8byo3Th/S7DbXXT9+S9qjKVGb4jtVCFj0df4hPFY6hoiGfweZD
         hIow==
X-Gm-Message-State: AOAM533JtI0KGXbYpABSfFptD4bIuWr0c9+9GeDIzZQWB8HT2JG/nnOc
        9a6teBc8+Hr+/uf+dav3xc13YJwbJMY=
X-Google-Smtp-Source: ABdhPJyp68ZvAO6SkF+b/TzdvpF1sDrvQcuLQ604XzFBLFfT0rtTZrdaScR6lfhX/OJFPBiHrmqLWw==
X-Received: by 2002:a17:906:f41:: with SMTP id h1mr7922193ejj.255.1635448047704;
        Thu, 28 Oct 2021 12:07:27 -0700 (PDT)
Received: from [192.168.178.26] (ip5b40c175.dynamic.kabel-deutschland.de. [91.64.193.117])
        by smtp.gmail.com with ESMTPSA id qf38sm1834483ejc.116.2021.10.28.12.07.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 12:07:27 -0700 (PDT)
To:     git@vger.kernel.org
From:   Federico Kircheis <federico.kircheis@gmail.com>
Subject: git aliases and GIT_PREFIX
Message-ID: <2e328484-d0e3-8801-61da-07544cc93eef@gmail.com>
Date:   Thu, 28 Oct 2021 21:03:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello to everyone,

today I reported what I believed to be a bug on

  https://github.com/git-for-windows/git/issues/3496

and learned about GIT_DIR when working with aliases and git worktree.



It's annoying that GIT_DIR it is defined only if (as far as I've 
understood) working from a worktrees or submodule, as it does not seem 
to be related to those type of repositories.

This is also irritating because apparently working aliases breaks when 
being executed from those repositories.


I believe it would be better if GIT_DIR it's either always set or never 
(could someone enlighten me why the variable is needed in first place?).

If it is consistently set, it would make it much easier to notice that 
an alias is actually broken.



Best

Federico


PS: I'm not subscribed to the mailing list (yet), so please keep me in CC.
