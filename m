Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F56C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 11:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhLKLJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 06:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhLKLJG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 06:09:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83EC061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 03:09:06 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso9620301pjb.0
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 03:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PwP7sWri+mJqBEeqRhfRkQBsQKTXtacGA8j5RaHTbrw=;
        b=f6tlrSNIvtPH4R6w2OgF13kZeDOicAtljUA4F29/e1bu+rmE8MVCthrosV+TgQpa6v
         ZuMCNByhz9Aj3KWgbdhrYxO24XEmprUGrrkaH3IQnDWFBsqF42rRbvnEiQcqXiGK5IL5
         xrOORMl4jz6aoz3HHSCTcqDT040q9h9vAELfuY2xzvoGqgWya9+2JEosoFmTMM/sgRiZ
         iC5BG8ewZE99vZ5NSM20GZ8y/JhxKQuyqwv8NIp9XsDGgSUGGJ12AWUuTYQl0kbNPAL1
         7kiDmEURccKtdkLFwj/hcltRlwKij0eC2/rBujMmgc6R5uyquNR7+qGkYHRXpJ7kUlkv
         liRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PwP7sWri+mJqBEeqRhfRkQBsQKTXtacGA8j5RaHTbrw=;
        b=zboafoqhhdfewELbiubEJGeBgHCZehNRzUmBuCztijGcymbBWvjG+5Sbq5eLXVOYEX
         I68JR+s9jaSOwBfp2ix++MzS9mNdKQyLbjzp5puvl/wWXXG5NUG6Lr66iS8gCBUB2sa1
         80JQzviwKkEZRX1qwY8KE9OC7PThggCqCVZbbisY/73gdwQ4L5CY9mcQWA747vgEvUmn
         obndesw13K4YBEplBG1l8jde8i4AHVxu+woIaVPcMM2tTmX7h3QiuLvPqHQ4EBCewyJA
         0TP0KE6MoQjihei8s2pduUouOR907wQ5SoknxD45Fsudz3topcAkf8wCDmoH27wx8GAB
         bw3Q==
X-Gm-Message-State: AOAM531d7IPJuQ6rDPStW+x2/AqY+E8edOcBydO4DSbFAZbt/ygK3Kuq
        s06krD/nv+xCABRWWaPwdVM=
X-Google-Smtp-Source: ABdhPJyHT6XJys1z2E7iunkedfD6YC9qzmeCzSwd2CtHlZ5+H7B281Ktd7RR9MHBAckFulas/Ks3ng==
X-Received: by 2002:a17:90a:7e89:: with SMTP id j9mr6060800pjl.162.1639220945363;
        Sat, 11 Dec 2021 03:09:05 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-4.three.co.id. [116.206.28.4])
        by smtp.gmail.com with ESMTPSA id u22sm6704439pfk.148.2021.12.11.03.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Dec 2021 03:09:05 -0800 (PST)
Message-ID: <29e4f791-e543-f90c-8926-b7e7b0f9397c@gmail.com>
Date:   Sat, 11 Dec 2021 18:08:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g> <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqq8rwu278d.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/21 03.04, Junio C Hamano wrote:
> We ship contrib/ stuff within our primary source tree but except for
> the completion scripts that are tested from our primary test suite,
> their test suites are not run in the CI.
> 
> Teach the main Makefile a "test-extra" target, which goes into each
> package in contrib/ whose Makefile has its own "test" target and
> runs "make test" there.  Add a "test-all" target to make it easy to
> drive both the primary tests and these contrib tests from CI and use
> it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

No test failures found with test-all on my system.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
