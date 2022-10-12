Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB04C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJLNjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLNjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:39:15 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FE7B6013
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:39:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so26252390wrp.10
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :reply-to:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZcpmPypeiLIjfCuWcEVXmYumdnEpmxu7StYu2JZCoyo=;
        b=qIMDLNq5qvX1vm3gPbVBSCUXLsQBgw5qlehmAPe010kqPdVI+2OOigeSLeUExLTtPA
         DxWQnpmIASWCOgQjkbM4ajlbP0x82kJh434TQzvtODDmRI6FDL86Jj85uh6Lma0nIknM
         KUfuDt6N+mWKqa6DPMnzS7u9XRjW3/Ewe7QLmGi4O8ncSBN3ZiVm/W0/ac81uV3oB8A3
         drP6bFAU1a1NMqCACKOtT4vWOLFnuGE3GQogusmY4hI7HEMwlDOobAoQysqVKcba914E
         Q3w0xw/BRdnp61WkDYhLp6P/KqVWGWlAOJsNAGk12XF9TrHUPPwajJvSV6DuCMZ3GFb4
         V80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :reply-to:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcpmPypeiLIjfCuWcEVXmYumdnEpmxu7StYu2JZCoyo=;
        b=5Ld1UoEdxdYr4dwagqgINE3bUtKxKYlTwAp9R41adGUQP1402tmQuLbIm/FqP2h2RX
         uRA6MIxY7IrSpKNhfhUExbpFjF0vdXnv1mdV3uY+ejK7gyAiXKtDmuW2e9NJkNQMVU3i
         1sC2aOcEJeJY9OeY7A4ZProTfLlLo6zh9r+dDrJxCIq87I66i7SofUXJPYbw7hVerUwu
         5bJa2ZXB7INabQkWfArTVDDIrEo2xr+PUHoMQRhJyAWpkwWw9S6x2IQLc27FF7EPS+cz
         B3friyiSsTmKQM8R6+rEK/8r9HtI/24gweptLGfxRb+jCJrUASx1owFa+fqfYDQjfrwr
         2FQA==
X-Gm-Message-State: ACrzQf3gyqYDw/E2OlMAlOK32wJt+kWaiVYk8BZPf5YVupijUB1lntCJ
        BXJncOfYGCTBBiBDpZyWzH0=
X-Google-Smtp-Source: AMsMyM7W8qbdzLWXepNSgqieFcwBhyy1k14tp4JaFqWjdU/EvKUqdpn0T3KPo5vgcLM7YfveXjG98Q==
X-Received: by 2002:adf:cf07:0:b0:22e:3ea0:4fa9 with SMTP id o7-20020adfcf07000000b0022e3ea04fa9mr17351298wrj.147.1665581952793;
        Wed, 12 Oct 2022 06:39:12 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id g14-20020a056000118e00b0022cc3e67fc5sm13906333wrx.65.2022.10.12.06.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:39:12 -0700 (PDT)
Message-ID: <9b4df247-c67c-8e5c-9c2e-1972db6a02e6@gmail.com>
Date:   Wed, 12 Oct 2022 14:39:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/22] run-command API: pass functions & opts via
 struct
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com>
 <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 12/10/2022 10:01, Ævar Arnfjörð Bjarmason wrote:
> This series changes the run-command API so that we pass options via a
> struct instead of via the argument list, the end result is that an API
> user looks like e.g.:
> 
>       +       const struct run_process_parallel_opts opts = {
>       +               .tr2_category = "submodule",
>       +               .tr2_label = "parallel/update",
>       +
>       +               .processes = update_data->max_jobs,
>       +
>       +               .get_next_task = update_clone_get_next_task,
>       +               .start_failure = update_clone_start_failure,
>       +               .task_finished = update_clone_task_finished,
>       +               .data = &suc,
>       +       };
>       [...]
>       -       run_processes_parallel_tr2(suc.update_data->max_jobs, update_clone_get_next_task,
>       -                                  update_clone_start_failure,
>       -                                  update_clone_task_finished, &suc, "submodule",
>       -                                  "parallel/update");
>       +       run_processes_parallel(&opts);

I thought the first version was longer than it needed to be and now it 
has grown by 50%. I think there are a number of changes here that are 
not related to converting run_processes_parallel() to take a struct of 
options. My feeling is that the test cleanups are worthwhile but the 
changes in patches 8-10 are needed and patches 12-14 would be better 
squashed together.

I'm afraid that I'm think this fits a pattern of submitting series that 
incorporate unrelated changes and so end up longer than they need to be. 
I think this leads to poorer reviews and a greater change of regressions 
because reviewers are overwhelmed by the sheer volume of changes they're 
expected to review. I find it particularly fustrating to review code in 
one patch only to find it is deleted in the next patch.

I think the overall goal here is worthwhile, but I'd really like to see 
a much shorter more focused series. In general two shorter series are 
much more likely to receive good quality reviews than one longer series 
making the same changes.

Best Wishes

Phillip

