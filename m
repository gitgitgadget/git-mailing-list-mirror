Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EFBC19F21
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiHDUOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUOG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:14:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23276AA16
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:14:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e23so689341qts.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iJyvS5toyjWKlWaqGQ25kHnY10MNLcGJyfsl+/IW2mY=;
        b=h//o1SyarHPrNsYt4oVYXC8dpnGMRarehPrZCdSIChMrxTpmO4FEkH7vyjXikRoVBb
         2KU2gsGd8Oqp/hqf6rAib0WzIequqdk/RdQixKzm3y3ZnK+HU5o+K7hDJzxZcnSrklvn
         VDa1FowJC79MW9NcT8/PvjCuWWw2sJPYvwolKUXChFiVYRt83Mpy1Pak+V00y1Bt0zOb
         yxwcH8O4iJ8IlMO8GRYz33tu3CCghmzbEyw+tEecLWCIIltDhOtIYrY3LKF04dcSFtKi
         USSxvvxP19Rk/KfgzNDa9txirN/hwfF3C+hsOqiXHB15fHmr7mUCw/nBurUd3sUjy9yt
         cq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iJyvS5toyjWKlWaqGQ25kHnY10MNLcGJyfsl+/IW2mY=;
        b=npV5eJtMylv6WHQzU1iJGprkDm2+4DVUMIwb3T25Zke/7AjBY69HC/KsHG0SNhLQv0
         gNCdqi6x7o2a34CDjZoUBmqUzTLArY2SoW83SrrqODLLfkw/vZ5FFHbK5K6+XkYCc4hq
         trRmb9Q+JKz75wcmOpvpLq8zyYvQADN4u7sS8p4g1Zlh0uwRQmypEnnk5nqjxx2YLVfF
         ZlqvTeQLAYQrAIDFG1sDzRlDszc9AzSXGL2LTrFjXqwvJ/Ujv0iXAsUsRCPcrCOyJPo0
         c4jWi+Xemhwn53eKVH4Y3p6bel7zkDFaDKBMZqoJqLZJ8hyHAllaPPPB9cdlt/eq+rCb
         jbRQ==
X-Gm-Message-State: ACgBeo2fqYjeZu5ge9YPAr6krzXNVn6ddC5OdsYjHTdecunKijK8jDis
        7WJGQVaTatSDxJrYEzhjESayIYQ3hPmd
X-Google-Smtp-Source: AA6agR4rdEcfkVNFRQVnYWIh726R3soK01BlNMpahwtHtfxsYghCQO6SLvdZEdmz4l48DLw504bAKg==
X-Received: by 2002:a05:622a:1710:b0:342:72ed:5b63 with SMTP id h16-20020a05622a171000b0034272ed5b63mr874145qtk.6.1659644044969;
        Thu, 04 Aug 2022 13:14:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id c25-20020ac84e19000000b00338ae1f5421sm1258394qtw.0.2022.08.04.13.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 13:14:04 -0700 (PDT)
Message-ID: <87d46db2-8e09-e5a7-b6bb-e94bf05df305@github.com>
Date:   Thu, 4 Aug 2022 16:14:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Bugreport: pack-objects died of signal 11
Content-Language: en-US
To:     Emily Noneman <emily.noneman@gmail.com>, Jeff King <peff@peff.net>,
        Paul Horn <git@knutwalker.engineer>
Cc:     git@vger.kernel.org
References: <977a6e0e-251c-4fa5-8b3b-fa3e2a761926@www.fastmail.com>
 <YtCMklbIoTAN/WRs@coredump.intra.peff.net>
 <ecb6fa27-b918-4234-8e44-13c2a3e76e07@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ecb6fa27-b918-4234-8e44-13c2a3e76e07@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 2:21 PM, Emily Noneman wrote:
> The stack trace:
> Thread 2 received signal SIGSEGV, Segmentation fault.
> git_config_check_init (repo=0x0) at config.c:2538
> 2538        if (repo->config && repo->config->hash_initialized)
> (gdb) bt
> #0  git_config_check_init (repo=0x0) at config.c:2538
> #1  0x00000001001197a8 in repo_config_get_string (repo=0x0, key=0x1002a3c49 "status.showuntrackedfiles", dest=0x0, dest@entry=0x7ff7bfefc1f0) at config.c:2574
> #2  0x000000010014a85b in new_untracked_cache_flags (istate=0x0) at dir.c:2781
> #3  new_untracked_cache (istate=0x0, flags=-1) at dir.c:2797
> #4  0x00000001001d68f1 in tweak_untracked_cache (istate=0x7ff7bfefc7e0) at read-cache.c:1996

Here is where things are confusing:

* tweak_untracked_cache() takes an 'istate' that is non-NULL here.

* The next spot in the stack is new_untracked_cache() with a NULL 'istate'.

The only way these are connected is by a missing stack frame (probably
optimized out) calling add_untracked_cache(). Still, it should be
passing 'istate' throughout this process.

The repo_config_get_string() call must also be coming from
new_untracked_cache_flags() which is again a missing stack frame,
but is called from new_untracked_cache(). Strangely, it's using
a NULL 'repo' here which should have come from 'istate->repo', so
we should have had a segfault earlier.

Sorry for the drive-by commentary without any solution. This is
just genuinely puzzling to me.

Thanks,
-Stolee

