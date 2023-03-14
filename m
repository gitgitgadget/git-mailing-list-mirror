Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E1C6FD1C
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 08:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCNIYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 04:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCNIXm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 04:23:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F6C99249
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 01:22:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q189so8398024pga.9
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678782138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+noIavCs3xQWa4S5aJog3tln0BIKdq9gKAv0091JOxc=;
        b=jdy9UFsUnGmhwoe6W2uNmJI40to3zgjtKiipuSR9E6hY/X7+UA4ju0riHkQq76ki51
         pAjExwl8ziEPnXyl/r431+Yb94DvrQcokIZOgYC0FpvfNFVLtHEtKhzTV+NVwOy2x75s
         +EMsz5AvwzdDvHKl5m7DTD3RaEYxoi5gI44ueJgkou1211T7diFF7gpFcEMAZAuYMjoV
         tGlLOQ4yv9J/l+Eu31j14NjJeFoR8k4BcFAf1WMwtj/HdxLwqLGOlOzVeAbfi76qsRoM
         GUn+evZRqdwQm3K/m1/JS8EfUh5xr5zo4VQ7d7pVcTz131tS3mxsoxwnlLpCMKo4BsUq
         pqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+noIavCs3xQWa4S5aJog3tln0BIKdq9gKAv0091JOxc=;
        b=RT0PrTTj7HeJLONlOUAajI177/CjsjPiB87nLFEi8iCUG1pTsFwswihw3DdQ7KrynC
         fUy4XTa9S5hw/IRicQK88XXruyjdMr4Fk/LRwxADjjjSMy3bHtL+mdMMCVui1LFlXasB
         kiQ+135v4GpvfpKaxf45RoNdRPboCxTjIubwa1yoGaOPijR9QtSFmLnoiqJSPI48qwbu
         aEm+GD+OlqZnGpvmYRsKeSHyNGbmGzeDZ2LZm4zC2OkrJa1kTPO6gz3HE7B9smrrpCrQ
         Mz23Bh/2+NpJTByalC4bUdZrU8CKrltmZmV15ObFhbEQ0lpUvR0ehrcU96zHGU53Wzmb
         l9Jg==
X-Gm-Message-State: AO0yUKXk9wHgt3tlhbeFz0i5ide7Tmww/gUba5VI1VQwJvFAAseHcz79
        PTlDJOt88TtATPd7NybWGjw5VSK9tnc=
X-Google-Smtp-Source: AK7set/61uOu3e9CcaWY+zCllL8wOMzcjIYWofdB5hB5hjSd+Lgv88LXUGkkbARL8KAlLnlV1ZQ1mA==
X-Received: by 2002:aa7:9546:0:b0:624:ac1a:a9dd with SMTP id w6-20020aa79546000000b00624ac1aa9ddmr4697171pfq.31.1678782138355;
        Tue, 14 Mar 2023 01:22:18 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id m6-20020aa78a06000000b005cc52ea452csm1010111pfa.100.2023.03.14.01.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:22:17 -0700 (PDT)
Message-ID: <73a7f949-e828-fd9c-4be5-63f60b53eb41@gmail.com>
Date:   Tue, 14 Mar 2023 15:22:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Git fetch slow on local repository with 600k refs
Content-Language: en-US
To:     =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     =?UTF-8?B?5aec5rWp5ZOy?= <jianghaozhe1@xiaomi.com>
References: <e28a23e8eb044d26947462b8619e88bd@xiaomi.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e28a23e8eb044d26947462b8619e88bd@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/23 18:54, 程洋 wrote:
> 19:12:55.931180 common-main.c:48             | d0 | main                     | version      |     |           |           |              | 2.33.1.558.g2bd2f258f4.dirty
> 19:12:55.931215 common-main.c:49             | d0 | main                     | start        |     |  0.000335 |           |              | git fetch --no-tags git://10.13.8.10/miui/gerrit/base-test.git refs/changes/27/2741927/1:refs/changes/27/2741927/1
> 19:12:55.931302 compat/linux/procinfo.c:170  | d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sudo bash miauthd miauthd systemd]
> 19:12:55.931381 git.c:456                    | d0 | main                     | cmd_name     |     |           |           |              | fetch (fetch)
> 19:12:55.931566 builtin/fetch.c:1579         | d0 | main                     | region_enter | r0  |  0.000692 |           | fetch        | label:remote_refs
> 19:12:55.936781 connect.c:167                | d0 | main                     | data         |     |  0.005907 |  0.005215 | transfer     | ..negotiated-version:2
> 19:12:55.940447 builtin/fetch.c:1582         | d0 | main                     | region_leave | r0  |  0.009573 |  0.008881 | fetch        | label:remote_refs
> 19:12:56.221133 run-command.c:739            | d0 | main                     | child_start  |     |  0.290252 |           |              | [ch0] class:? argv:[git rev-list --objects --stdin --not --all --quiet --alternate-refs --unsorted-input]
> 19:12:58.014792 run-command.c:995            | d0 | main                     | child_exit   |     |  2.083899 |  1.793647 |              | [ch0] pid:81860 code:0
> 19:12:58.014855 builtin/fetch.c:1321         | d0 | main                     | region_enter | r0  |  2.083980 |           | fetch        | label:consume_refs
> 19:12:58.015412 builtin/fetch.c:1326         | d0 | main                     | region_leave | r0  |  2.084538 |  0.000558 | fetch        | label:consume_refs
> 19:12:58.015466 run-command.c:739            | d0 | main                     | child_start  |     |  2.084590 |           |              | [ch1] class:? argv:[git maintenance run --auto --no-quiet]
> 19:12:58.018879 common-main.c:48             | d1 | main                     | version      |     |           |           |              | 2.33.1.558.g2bd2f258f4.dirty
> 19:12:58.018911 common-main.c:49             | d1 | main                     | start        |     |  0.000324 |           |              | /usr/libexec/git-core/git maintenance run --auto --no-quiet
> 19:12:58.019011 compat/linux/procinfo.c:170  | d1 | main                     | cmd_ancestry |     |           |           |              | ancestry:[git bash sudo bash miauthd miauthd systemd]
> 19:12:58.019087 git.c:456                    | d1 | main                     | cmd_name     |     |           |           |              | maintenance (fetch/maintenance)
> 19:12:58.019276 git.c:714                    | d1 | main                     | exit         |     |  0.000690 |           |              | code:0
> 19:12:58.019284 trace2/tr2_tgt_perf.c:213    | d1 | main                     | atexit       |     |  0.000698 |           |              | code:0
> 19:12:58.019386 run-command.c:995            | d0 | main                     | child_exit   |     |  2.088507 |  0.003917 |              | [ch1] pid:81878 code:0
> 19:12:58.019411 git.c:714                    | d0 | main                     | exit         |     |  2.088538 |           |              | code:0
> 19:12:58.019419 trace2/tr2_tgt_perf.c:213    | d0 | main                     | atexit       |     |  2.088545 |           |              | code:0

From above, I see that the hot paths are `git maintenance run` and
`git rev-list`, right?

Next time, try to send only plain-text email in this ML, as vger isn't
happy with HTML emails (most likely spam).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

