Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B30C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 11:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E892661058
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 11:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhKKLXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhKKLXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 06:23:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F17C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 03:20:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so3938097pjb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=u294hlsWec7v3KZCZW+6Dhe9iLiATQZz1g/gzjNXqAM=;
        b=X58NwY42SV27woMn8pApKuENGPsABKIBs/V+uff0+RoA3LDdLQmB5nRmiPz6uoI9Bz
         l3UEtD8ifJGeZPqm2UuJWD0QSYJvga1yUVDKENvRobzM0FbvlOK4RE2MbwLWA1Vqj2NN
         lL1w/BzWPlrz7BV62YAkYmbsSMrA6WSn8Bj6mcWO/vX++YTadWDxYOWNK+cpfjNEMT0I
         kPlyu4878gcEW2eXgL+VrmWnLWRNoPbrT+eG4q3XQkgkcIvQi1MMHOiNvOpp6s8ExSx1
         oqZF8fxFbB1PmwQNbGSiSHsjTLL99xO0Ztxv3D+8l8CQfImaR7r6HZp4SIhjrKWZbkNU
         6yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=u294hlsWec7v3KZCZW+6Dhe9iLiATQZz1g/gzjNXqAM=;
        b=hSOREmADABiLg2tGOwO/nwsXio9Dwlqy7h5NVm/zN4i4dcAlsPyv8Dvw66JYbzBXOG
         9tQG5zDMzUjeFxBbg5YL0DxccCJUgy18UpHshqqvt6cgDmoRdq9aUNQUds2Nb1+ZsnJ+
         OvV/BgVjj0VtyRWwGD1qXoZsHXfEJxicFL8jMOiI6ywTF3ypR5wTv3cNx61HcBUmQgZk
         jmODZXUSrvrfnI+CZQSEej9QqWUd7fSj5mYJtvS9CHfdcrm/Nirfzg1362PY/7RmLuUb
         IKJoLUos/cdbC7zWJfBsFPvzFih4aks6UNFlAKrdwzCtE/ITX/25X57V2Yicrj9aWZ5r
         NiZQ==
X-Gm-Message-State: AOAM533jqpm/rghYh/cl21Pysh/dgftTpEy7UaZ3E8mB6qGNH7nN68KY
        vKc0t1H7gRfRRokUv2Y6DBM=
X-Google-Smtp-Source: ABdhPJz0fqNgaTeyeJLF32KBKhinGJ8yPQNCoRjxuADX1RLW9ShamBkxSYfGSB9TntB9dGCNPYpBvA==
X-Received: by 2002:a17:90b:3142:: with SMTP id ip2mr25710806pjb.207.1636629651968;
        Thu, 11 Nov 2021 03:20:51 -0800 (PST)
Received: from ?IPV6:2405:201:4018:300c:e49c:6471:81f1:6968? ([2405:201:4018:300c:e49c:6471:81f1:6968])
        by smtp.gmail.com with ESMTPSA id l4sm3102668pfc.121.2021.11.11.03.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 03:20:51 -0800 (PST)
Message-ID: <5aa1fb67-6bd8-6de3-8271-369722b6ebef@gmail.com>
Date:   Thu, 11 Nov 2021 16:50:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Saksham Mittal <saksham.mittal000@gmail.com>
Subject: Re: Possible merge bug
To:     schiff.michael@gmail.com
Cc:     git@vger.kernel.org
References: <CAJcz5TVsv20+FmHR67_UhL_7rhEGvfPHeP3RMiRtnSGAEKiwBg@mail.gmail.com>
Content-Language: en-IN
In-Reply-To: <CAJcz5TVsv20+FmHR67_UhL_7rhEGvfPHeP3RMiRtnSGAEKiwBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I wrote a small script as well that automates testing this use case as well, but I don't really know what the policy is on attachments in git, seeing as how it's my first time contributing to git.

I am on git version 2.33.1 on Fedora 35, but I am not seeing the bug while running the script. So, I grabbed the git source code and built it. This version is 2.34.0.rc2.9.g4d53e91c6b, not quite your version but I tried to go back to the commit you mentioned and build it, but I faced some errors and no binary would build.

Anyway, the version I built and tested also did not permit auto merge and required me to manually make changes as well, so the issue seems to have been fixed.

You can take a look at my script as well, I followed your instructions as best I could and built this:

#!/bin/bash

git --version

mkdir sample
cd sample
git init
echo -e "a\nb\nc\n" > test
git add .
git commit -m "abc"

git branch b1
git switch b1

echo -e "b\na\nc" > test
git add .
git commit -m "bac"

git switch main
git branch b2
git switch b2

echo -e "b\nc\na" > test
git add .
git commit -m "bca"

git switch main
git merge b1
git merge b2

git log --graph --oneline --all


Cheers,

Saksham Mittal



