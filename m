Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA1C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 07:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiG0Hw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiG0Hw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 03:52:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57A28702
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 00:52:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso1381081pjr.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=3dJM9pa5YCZ9RIlRw7XxIlHSoqc5pggEsKsWHYkDYJE=;
        b=lerMPdTJFXzKjIga2Qj6ZsEK0wOl4VGo8/56txWjUDGS2pA3pNt6Ilq0u0nYmD/ZZa
         hAdBv7oRaCP347Dz4f5T8/2ChEfisa8TI2dhuse8cAfTci8fJBQseMMThFAoM6JUwjFR
         8WzqYr0wOFvx/6HI8E00SQ5F3myJLm+evF1aFPdB3xk2tmMp28rIgaItewOGv0KJZeuV
         V3Eo+uxLaqLa8oFHTOflbhM1PIr/MkXJsfQBubq8Mlx4jM3sKHwTvAMF52YoPNOwTvtf
         09UwVNPzFehY6aeecmnXV1cpSOU6iwyZ3tnq7VpN3jMylpmOvZBFelqWaJe81agHOg1p
         ir5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=3dJM9pa5YCZ9RIlRw7XxIlHSoqc5pggEsKsWHYkDYJE=;
        b=OB9yCXhedsNlJtdZY7fLOA0/ptxvbc5OE9j0+3aOfDeswlEpPB3uivKippn/nOgp77
         2MekvjVX/FKE5P8c6c9pAt3AOacgPCZ2NViqLibjqrDtqLTnaUsteoxcC3IVZ9tF+w1w
         OAMiVPQYQOmTFTZRsVd76QoyA0SacEWDyDCZF/r8PkE0jbslYSWg8To1ghrrHsJNJHoJ
         JtpW/0cL2AuP9GJ24aurjEuQA98l8+4JZQINYK096e3w+g/hFcF+DnTUzt3ftGdVUZue
         WqheVDs2wj/m4GCbnVMS26E2/KmN7wxf6Y1ryJtbUNPilM8Y335xdhGzYEOU7maDfaY3
         YqOg==
X-Gm-Message-State: AJIora9tHh8f3tUGO5TeTAqTNZJVcIHvCLBGXyilhk6mCPb7hjMtMMtD
        9UXO7Ajy5mx2BCOkNfBFtQAEu3GwpmaQRw==
X-Google-Smtp-Source: AGRyM1uExjPO3HCP9uF3mHO0ZzqNG/4EfO2anMhAxk+qUslVurbIErbCtnRTFx9jZtyRgjCiHVXTfA==
X-Received: by 2002:a17:903:1c6:b0:16d:a4b:cab1 with SMTP id e6-20020a17090301c600b0016d0a4bcab1mr20386446plh.116.1658908376830;
        Wed, 27 Jul 2022 00:52:56 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b0016d987d7f76sm3594088plb.11.2022.07.27.00.52.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 00:52:56 -0700 (PDT)
Message-ID: <834d6b3e-9f1e-c848-a584-0161c503a7d9@gmail.com>
Date:   Wed, 27 Jul 2022 15:52:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [GSoC] Week 5 and week 6 status update
Content-Language: en-US
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
In-Reply-To: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

Here is Shaoxuan Yuan.

I'm writing to share my latest progress [1] from GSoC week 5 and week 6.

You can read them when you are free, and generously give me some
advice if possible!

---
Summary of the two weeks

At this stage, the main focus is on making `git-sparse-checkout` work
better with `git-mv`. After getting the "from out-of-cone to in-cone"
series merged [2] into master, I'm working to make the complementary
"from in-cone to out-of-cone" [3] possible. It's now a [PATCH v1].
Read the previous blogs on GSoC to get a better context.

In the meantime, I'm also experimenting with `git-rm` to integrate with
`sparse-index`. `git-rm` turns out to be a slightly less complex command
in terms of its interaction with `sparse-checkout`, so working with it
at the same time gives me some insight into `sparse-index`, without
worrying too much about its compatibility with `sparse-checkout`.

[1] https://ffyuanda.github.io/blog/GSoC-week-5-6/
[2] https://github.com/git/git/commit/0455aad1e39f21acbaa8a84129fec8eb77682e0d
[3] https://lore.kernel.org/git/20220719132809.409247-1-shaoxuan.yuan02@gmail.com/

--
Thanks,
Shaoxuan

