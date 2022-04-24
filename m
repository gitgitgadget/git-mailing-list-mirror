Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5068C433F5
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 06:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiDXGug (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 02:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiDXGue (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 02:50:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D645F8E3
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:47:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b12so5354792plg.4
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DWpU8DE1RD5Lzk2g/x5qwFbS9dj6YEKqbobDa9QJP8o=;
        b=NiUkT7AyGYbp/zu4ko9Kp8xkqpWj28dC4+nxu/FVB47EnuVp2YIMV/oh2syDui8j1a
         xMm1yUkp4hMKmE4JM3nWpR3Vu12C4Y1q4SC2fCbNL/WCGMuZFHnOcGL84N0J6Jt6olkr
         PfxBSGUlBQurWVW9gTzgKHaMA7uGCNZhg5ianKADARAv8qi+wRel2oefpljBaOr3KgZe
         J4vUOV8b/dleV4vqAw4T+byRV5DyeIZaqhk2SWKv+pcCkPIjx6IikGgzQJifnbt+k9e7
         UPq+hwwRzAwWLAy1aNi8yVDCeSAT01DA2FbPViOXf6PG1XQQMM+aWhy6LJosWWEuIR5s
         vowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DWpU8DE1RD5Lzk2g/x5qwFbS9dj6YEKqbobDa9QJP8o=;
        b=fbdHRk3jEkIinqjCmCbcMSDkzEeRNtdNaxK8MXyeZ4ka5x/h8+uYMtIItcGSmOg1FE
         R1RlLudi0R5i4upur+4XtdjVMoGSp4/XSMs0mMBzsFgDxDwLQ/Pm3zkmEi9Jwan3PncL
         kVvNEE2OdbMZ3aB6M9jS6Anw+fYhoOSGYNZ2B9/SwE+wvq8vNcrp7FX2XWDiySNFiyLt
         WA/gaqdwPoweugeZwRn6yvbdY1tAF80A0IQHTgw8zNdYAJLryQwck10BiChmQQrTFdJJ
         L3VmYSCUSXJ/LGPL2Hqe06KAQbCo5voSQnwLkgWTAiS7l9SdnaBITTg36GRMpEpXhE7j
         Rdcg==
X-Gm-Message-State: AOAM531MkuQTawSAxLgy7oHmKwOFOrVIcpBXY9PBS5ly2ycW12fBXpSj
        YWIHpA0zYAsCbB6V9pt6kkfMpFthUwgFPFaFOds=
X-Google-Smtp-Source: ABdhPJwCFIWdRyn5bbxEoSSdVqat7n2pcYT3W5x9tDVz0BlbMlYqb1+5nvtCGGJn9N9XP8vg9pVd1Q==
X-Received: by 2002:a17:902:e34b:b0:15d:4d1:614 with SMTP id p11-20020a170902e34b00b0015d04d10614mr1315970plc.14.1650782854539;
        Sat, 23 Apr 2022 23:47:34 -0700 (PDT)
Received: from kong-HP (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm7727737pfh.84.2022.04.23.23.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:47:33 -0700 (PDT)
Date:   Sun, 24 Apr 2022 14:47:30 +0800
From:   FanJun Kong <bh1scw@gmail.com>
To:     git@vger.kernel.org
Cc:     FanJun Kong <bh1scw@gmail.com>
Subject: Re: help for git format-patch lost diffstat
Message-ID: <20220424064730.fdhrgkkkegxbnn3l@kong-HP>
References: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

BTW:

I tried 4 different version of git:

git version 2.34.1  fedora
git version 2.32.0 (Apple Git-132)
git version 2.36.0  ubuntu
git version 2.30.2  debian

The result of test is all the same.

On 24 Apr 22 ◦ 14:41, FanJun Kong wrote:
> Hi, 
> 
> Here are steps of what I am doing:
> 
> First, I created two commits to a demo project.
> 
> when I use command:
> git format-patch --cover-letter -1
> 
> cat 0000-cover-letter.patch
> 
> From 2e62ef46d5627319c4cb11be81079e3364fca40c Mon Sep 17 00:00:00 2001
> From: FanJun Kong <bh1scw@gmail.com>
> Date: Sun, 24 Apr 2022 14:31:45 +0800
> Subject: [PATCH 0/1] *** SUBJECT HERE ***
> 
> *** BLURB HERE ***
> 
> FanJun Kong (1):
>   Second commit.
> 
>    1.c | 4 ++++
>    1 file changed, 4 insertions(+)
> 
> --
> 2.32.0 (Apple Git-132)
> 
> ok, you can see the cover letter has diffstat, just above "--".
> 
> Then I change command to:
> 
> git format-patch --cover-letter -2
> 
> cat 0000-cover-letter.patch
> 
> From 2e62ef46d5627319c4cb11be81079e3364fca40c Mon Sep 17 00:00:00 2001
> From: FanJun Kong <bh1scw@gmail.com>
> Date: Sun, 24 Apr 2022 14:34:48 +0800
> Subject: [PATCH 0/2] *** SUBJECT HERE ***
> 
> *** BLURB HERE ***
> 
> FanJun Kong (2):
>   First commit.
>   Second commit.
> 
> --
> 2.32.0 (Apple Git-132)
> 
> Comparing with last command, I just want to get 2 patches,
> but this time the diffstat is missing.
> 
> I am not sure if this is a bug or I miss some options.
> 
> I googled this issue, but not got too much.
> 
> Thanks for your time.
> Fanjun Kong
