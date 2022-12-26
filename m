Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB2EC4167B
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 02:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiLZCPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 21:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZCPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 21:15:50 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE69C41
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 18:15:47 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v23so9614606pju.3
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 18:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSXDCqNX4MYt6oFCV6A9V9+yIfmGQ/xUzoOe9Kg03Sg=;
        b=Rq5wxpCGqWZMmrSOwjExt24hOvo5P1NcoKeywHdZjXieBRopMjrjYjh27XVthayAX6
         Pj1K653Lku0RV80+YZaBn/r2QxssD4xdyeGhzKtLKwOhABZvUN3ideCYimB4jjJoiMHZ
         kP6Bq5a7GQzE1BhK0MF9qgEcyl9v25ABGCID+BuEXX+FS+gUW2bGOcdPRgM24adU58o2
         0bFYHpi2TBHr66us7ZRGNDvEf665qYiXy0GgqDNPfBmRQXz6/PpFiVAxfqdswhvmWbBE
         KISGt8POVi1e1sOMyB5FkhZ1cntItuB2Hadv/fSJ9QA0B0eJDHjrgisJOG37KIj7gXaX
         HdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSXDCqNX4MYt6oFCV6A9V9+yIfmGQ/xUzoOe9Kg03Sg=;
        b=FSpsbjNWYan0ktn8hKP3TBppn3Jt1vEyRfGQkY1pLp+Uuk8fLeKZ5hkxiA4911NFuI
         yMmQ4T02na7PCswtzxvbEZQhf9V+FJILS2ee8aoHI3JRsZwQs4UNijkgTfeEAEECRQim
         Ng4k5/yDAVKplU6fsbq5GVG/VMO4sijWtFiDYB4MAqYgIidvkHD3cEUTuBNMmbxqnxYD
         xNpk8p4FoCpK6jNTuoh/z4uWQpR570kB5rvog3D5WUKbLmmoapJoVYMrlBNUidxjFG5j
         UZltnA4C9W6dH8QHllIhHk43t7/8zHhLfYu79PQw8U8gQtd6LZk8LFHup243HaPhjiYD
         XkSA==
X-Gm-Message-State: AFqh2kqpPagsfmlPPrF6rj21tstInnIu92vJX8s8v20E30rHymmZAtSb
        aupaM3qmPjBfOyKdhZ4rFuc=
X-Google-Smtp-Source: AMrXdXvSIPGggF9EA4kw0pPjSaPKNHRAG7mNmY9ud56R8SvdpwMPpmhJttqCzPur1o4tYnH3SWp7FA==
X-Received: by 2002:a17:90a:1b82:b0:219:70f1:cef with SMTP id w2-20020a17090a1b8200b0021970f10cefmr18994693pjc.46.1672020946845;
        Sun, 25 Dec 2022 18:15:46 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-80.three.co.id. [180.214.233.80])
        by smtp.gmail.com with ESMTPSA id om7-20020a17090b3a8700b001fde655225fsm12944648pjb.2.2022.12.25.18.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 18:15:46 -0800 (PST)
Message-ID: <9f76490b-c46b-cb17-6aa6-12e1793c996c@gmail.com>
Date:   Mon, 26 Dec 2022 09:15:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Bug Report
Content-Language: en-US
To:     Jensen Bean <jensen.bean@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CANqKdC_ZULE4ABFTrRfC2JMkJp=i83MJy+PZ-hdWzWGO97gYHQ@mail.gmail.com>
 <ca897325-f04d-3b13-9fed-c30d09f28d1c@gmail.com>
 <CANqKdC-gHgQHn5DMoOREY52y7PpRLMpNAjX3qeA5iy9z_GXdzw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CANqKdC-gHgQHn5DMoOREY52y7PpRLMpNAjX3qeA5iy9z_GXdzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/25/22 16:02, Jensen Bean wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> What did you do before the bug happened? (Steps to reproduce your issue)
> download git
> What did you expect to happen? (Expected behavior)
> CTRL button to work
> What happened instead? (Actual behavior)
> CTRL button stops working
> What's different between what you expected and what actually happened?
> the CTRL button doesn't work when I have git installed
> Anything else you want to add:
> Deleting git and all its files has been the only thing that works so far
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> Confusing experience, wasn't sure what to actually do
> 
> [System Info]
> git version:
> git version 2.38.1.windows.1
> cpu: x86_64
> built from commit: b85c8f604d375d4d773a36842964e8a7ec056aae
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 22621
> compiler info: gnuc: 12.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
> 
> 
> [Enabled Hooks]
> not run from a
> git repository - no hooks to show
> git-bugreport-2022-12-25-0152.txt[+] [unix] (01:52 25/12/2022)
> 

Thanks for the bug report but you need to send it to Git mailing list, in
order for developers there to see the report and act on it.

Also, when replying, don't top-post; reply inline with appropriate context
instead. If you top-post, I'm going to cut the whole context below.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

