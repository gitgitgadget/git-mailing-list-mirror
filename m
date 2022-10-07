Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1FEC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJGJ7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGJ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 05:59:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF9011A18
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 02:59:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so6511018wrr.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TtiPrbNftct4gDWxKeX7PMqeLJz436fWNGuZbb/T/WM=;
        b=ZtESrpRFaBIbIbACusVWCn6VNwGhdwLCdtfEh9imw+mVv34sgSkDP0ZKmKitsDrJUx
         yKMJt30TwgyDVpQDcyHZDXGn9iqGOriTBmM0+xa6exdGb6IAciM8FkUR3i/DUhf5GrtR
         tIz15dNNAbna7vL9VfvyVoBJM3/yD0kxZLCOn4+Qar/NftUEg7z+DNkRmC1nwr8TeQBC
         EURr6bCnuWHMJ4Sezz+Jco0Jhmte2tC7lH6vK+SGjTBuX71v5Kx77DPomwHorvNYwOy2
         XD2eakcEftHC+8mDpK6u57QGV8wNjnzH+PTLjtPq9vpjEl/R2fCFkb6nPErHK4lQwnZY
         Njdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtiPrbNftct4gDWxKeX7PMqeLJz436fWNGuZbb/T/WM=;
        b=FaHMQD3s4jvEzBqT5ooykC+sSq3d09SPDKkvBuIwrh3niHxSMmBxxyXTQrZrYiXbep
         B6YuF3+eNbxSEnRh9qkQZIAQSLP7gz1HViVonj+rB5WI/L7sOK1hkV6Xlt9jp7QbJfcT
         YjujOLbTMzcYYOzKoQk8xrWshMqpGloreNMPNLwqCFMeCDH+j2QK69Wbum2sPvSAYnl+
         TzqkgTghG9e+FLhaC6tGpBTMt2LkmpT1+0JGKsj0UOzERGbJpLseVOcAD7y6dalWBule
         ycYnRuEQEiuiCQFkgHZXIbZ1yXCTI1xiQE79S7zBwcKb7FG/UN3jrWSywbfX/0HNtUgW
         QT+Q==
X-Gm-Message-State: ACrzQf0wkFcOm14IkA3Rrqtfyvw4iIPNQCSvqIGLkInp9Asja1Tz8mcG
        5HCt7zbqQCOjYm3T9iGkXZY=
X-Google-Smtp-Source: AMsMyM4RYM4eFpIwlneqjzkJ56wTDMFJztEcKSP530VloH5kUgvAEjfqqNPS8ocf4Y7Z6E8SaqLhZw==
X-Received: by 2002:adf:d1cf:0:b0:22e:4125:1152 with SMTP id b15-20020adfd1cf000000b0022e41251152mr2655897wrd.558.1665136786792;
        Fri, 07 Oct 2022 02:59:46 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id j13-20020a5d604d000000b0022ae4f8395dsm1530259wrt.96.2022.10.07.02.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 02:59:46 -0700 (PDT)
Message-ID: <52ca644a-0719-0ee6-56bd-a4b2686ae204@gmail.com>
Date:   Fri, 7 Oct 2022 10:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/15] run-command API: pass functions & opts via struct
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/2022 12:27, Ævar Arnfjörð Bjarmason wrote:
> This series changes the run-command API so that we pass options via a
> struct instead of via the argument list, the end result is that an API
> user looks like e.g.:
> 	
> 	+       const struct run_process_parallel_opts opts = {
> 	+               .tr2_category = "submodule",
> 	+               .tr2_label = "parallel/update",
> 	+
> 	+               .jobs = update_data->max_jobs,
> 	+
> 	+               .get_next_task = update_clone_get_next_task,
> 	+               .start_failure = update_clone_start_failure,
> 	+               .task_finished = update_clone_task_finished,
> 	+               .data = &suc,
> 	+       };
> 	[...]
> 	-       run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
> 	-                                  update_clone_start_failure,
> 	-                                  update_clone_task_finished, &suc, "submodule",
> 	-                                  "parallel/update");
> 	+       run_processes_parallel(&opts);
> 

Overall this looks good, I've left a few comments as I feel some of the 
patches are either redundant or could be helpfully squashed into an 
adjacent patch to reduce the amount of churn within this series.

Best Wishes

Phillip

> These patches are derived from earlier patches I sent for passing the
> the "ungroup" parameter to this API[1], that's currently done with a
> global variable, because we needed a minimal change for a regression
> fix.
> 
> I'm submitting this now in the rc phase because there's another
> concurrent series that could make use of this[2]. The alternative
> would be for it to add an extra parameter to the two functions (one
> after this series).
> 
> The upcoming migration to the new hook API and config-based hooks[3]
> will also benefit significantly from this. I have a version of that
> topic rebased on top of this, having this first gets rid of a lot of
> churn, adding an optional callback just requires adding things to the
> struct introduced here, not changing every single caller.
> 
> (Passing) CI at:
> https://github.com/avar/git/tree/avar/hook-run-process-parallel-tty-regression-2-argument-passing
> 
> 1. https://lore.kernel.org/git/cover-v3-0.2-00000000000-20220527T090618Z-avarab@gmail.com/
> 2. https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/
> 3. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com/
> 
> Brief commentary on individual patches below:
> 
> Ævar Arnfjörð Bjarmason (15):
>    hook tests: fix redirection logic error in 96e7225b310
>    submodule tests: reset "trace.out" between "grep" invocations
> 
> These bugfixes could be split out I suppose, but since we're changing
> this area 1/15 seemed prudent, 2/15 is required for a later test
> addition
> 
>    run-command tests: test stdout of run_command_parallel()
> 
> Tighten up tests, was ejected from the "ungroup" topic.
> 
>    run-command test helper: use "else if" pattern
>    run-command tests: use "return", not "exit"
> 
> Just setup for later changes.
> 
>    run-command API: have "run_processes_parallel{,_tr2}()" return void
> 
> Turns out we've never used the boilerplate return value for anything
> useful ever.
> 
>    run-command API: make "jobs" parameter an "unsigned int"
>    run-command API: don't fall back on online_cpus()
> 
> This allows us to make the "opts" struct "const", which helps a lot in
> passing it around later on.
> 
>    run-command.c: add an initializer for "struct parallel_processes"
>    run-command API: add nascent "struct run_process_parallel_opts"
>    run-command API: make run_process_parallel{,_tr2}() thin wrappers
>    run-command API: have run_process_parallel() take an "opts" struct
>    run-command API: move *_tr2() users to "run_processes_parallel()"
> 
> This is arguably one logical change (and at some point I had it as
> such), but as the diff would be really large I've tried to split this
> into easily digestable steps.
> 
>    run-command.c: don't copy *_fn to "struct parallel_processes"
>    run-command.c: don't copy "ungroup" to "struct parallel_processes"
> 
> The only reason for copying various parameters into "struct
> parallel_processes" was because we passed them as positionals, now
> that we have an "opts" struct we can just pass that along instead.
> 
> This leaves the "struct parallel_processes" in run-command.c purely
> for managing our own internal state.
> 
> By avoiding this copying we also cut down a lot on the boilerplate
> needed to add a new parameter.
> 
>   builtin/fetch.c             |  25 +++---
>   builtin/submodule--helper.c |  16 +++-
>   hook.c                      |  23 +++---
>   run-command.c               | 152 ++++++++++++++----------------------
>   run-command.h               |  71 ++++++++++++-----
>   submodule-config.c          |   2 +
>   submodule.c                 |  18 +++--
>   t/helper/test-run-command.c |  77 +++++++++++-------
>   t/t0061-run-command.sh      |  25 +++---
>   t/t1800-hook.sh             |   2 +-
>   t/t5526-fetch-submodules.sh |  16 +++-
>   11 files changed, 247 insertions(+), 180 deletions(-)
> 

