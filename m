Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E95C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B8863220
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 08:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhKOI5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 03:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhKOI5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 03:57:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9FC061766
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 00:54:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m24so3902732pls.10
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 00:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=nbwlaF7x3JQAcrUgZawqwYn0xVGR3OKPSk78UkgIkyE=;
        b=QBY739AThmYvjy/ASvsH3k9+TH+Le75qoVIr0e+0AnSagD7jBfLcEkv6odOVSf3e1C
         nox3kdLIs44K/HRAp9xaM9Nnx6x4kOzibaElGSLNnczhKT5TWjKuNsx78PiuNPulDund
         PuU8SM57/48oqhlmKW0Sl7e7n3Phvn1NtkidJFIWhUy5UDsOTa9bxhhGOXqdnLXfusWU
         h9+RyI5PRxrTaQx4gyMr4xkDN3oJiHMym4yaaoQr6pyAlGGUvcHIKl3SBFLnG4b00FrX
         bNucXCHnDdH5m/UXWQUOgLRPIerOqDt13Pc9jS+3C1yi00Uek34MvaAqoAUy/K8O3KnO
         w3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nbwlaF7x3JQAcrUgZawqwYn0xVGR3OKPSk78UkgIkyE=;
        b=cnpDqXg8AMXJP+4baknze+4w9mFtROT7/ZZX1CHQxl7lKDMU/rI9PTlZFRqOqcp+6d
         4zKopJPgGQGR0Jpj7/a8sk41c8UfdYEnG59A5XVGQfpLCPw4V0HUh2Vl8t4GXjH6lNL9
         m3+JMLFvlqxDF0HgsOR/0wimLRk/HlcyFqCXWdQytQ82CkD3+BW8CVse56ke0QURi1yg
         FnQz7H1XpBVwnMfp9TFecZj6RPPyz8VgTHn2RUtQNXgrtTXiYkROvcP0a1brEHaACcI8
         odcsjjAwL9ozKSs+F88dtIxfExbm55Ndtk5wGl0ZJL66I6AHVv1pxpGBQbKwYupcvg0J
         x2rw==
X-Gm-Message-State: AOAM532oyH2mLvQIzaDSnlIc9DVbGtfpokYvZjKRW7xAePNFo/DVp6Rm
        mva1dUaB67QakKHGN5/gFeV9PdgmT4E=
X-Google-Smtp-Source: ABdhPJz14+7nuDeBOqJ0a8S4mxqJ/6i5fzWFyd0Xa63X0xRz2ZErS0W+JN9eKJZU5dF/gBPekV7cIw==
X-Received: by 2002:a17:90b:4c44:: with SMTP id np4mr44041555pjb.195.1636966490223;
        Mon, 15 Nov 2021 00:54:50 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-69.three.co.id. [180.214.233.69])
        by smtp.gmail.com with ESMTPSA id f22sm10397007pfj.49.2021.11.15.00.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:54:49 -0800 (PST)
Message-ID: <30188556-935e-f5cf-c9e0-4ff8a528e5d8@gmail.com>
Date:   Mon, 15 Nov 2021 15:54:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: git pull bug report
Content-Language: en-US
To:     Erwin Villejo <erwinvillejo@gmail.com>, git@vger.kernel.org
References: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CADL96rvRX2R_4Wm23tz88hDUztcpK531RU+Ops2UVoiOW0bCHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/11/21 15.42, Erwin Villejo wrote:
>> What did you do before the bug happened? (Steps to reproduce your issue)
> * make local changes, stage, and commit
> * local is ahead of upstream. confirmed by `git status`:
> 
> ```
> $ git status
> On branch main
> Your branch is ahead of 'github/main' by 1 commit.
>    (use "git push" to publish your local commits)
> ```
> 
> * try to pull upstream to local
> 
>> What did you expect to happen? (Expected behavior)
> No-op (and NO failure) since local is ahead of upstream.
> 
>> What happened instead? (Actual behavior)
> `git pull` fails with error:
> 
> ```
> $ git pull
> hint: You have divergent branches and need to specify how to reconcile them.
> hint: You can do so by running one of the following commands sometime before
> hint: your next pull:
> hint:
> hint:   git config pull.rebase false  # merge (the default strategy)
> hint:   git config pull.rebase true   # rebase
> hint:   git config pull.ff only       # fast-forward only
> hint:
> hint: You can replace "git config" with "git config --global" to set a default
> hint: preference for all repositories. You can also pass --rebase, --no-rebase,
> hint: or --ff-only on the command line to override the configured default per
> hint: invocation.
> fatal: Need to specify how to reconcile divergent branches.
> ```
> 
>> What's different between what you expected and what actually happened?
> I expected no failure and no-op since local is ahead of upstream.
> Instead, `git pull`
> fails because it thinks the branches have diverged.
> 
>> Anything else you want to add:
> I found this bug in VSCode. VSCode runs `git pull` first before `git
> push` when pushing to upstream.
> This bug causes pushing via VSCode to always fail, although it can be
> worked around by simply opening
> a terminal and running `git push` manually.

You need to do the prompt above, so not a bug.

When reconciling, do you want merge or rebase?

-- 
An old man doll... just what I always wanted! - Clara
