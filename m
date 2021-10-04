Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E47C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3442961373
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhJDKAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhJDKAv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 06:00:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67644C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 02:59:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s15so1546601wrv.11
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p0tPvH42PzsH/a5WVCAl13RRfb8J35u0MecsggOVShQ=;
        b=ksjUCFyTQjoObmjBOiXzt4Aj6/iiu0lh91i0ph0NXtIiq/p3dxHXSQ80p5vz5M4dVj
         KyuMqrgWev0uIGHLfyhHtiWd1907iL4gRPe8rlNlwpYHQ/Cy9Jo7J8pYQDLIjrjL3jds
         b95dFP3fJr+wh1d3jl+Hj5dBwnCzz+vB3FcwZtncU1rxKoY+eU0WsRV8Xnd50XaN6T6y
         B/xi3jN8k1vp0WQc0gVtw7+aA06DWHXy64umQK+cf1nkZS4q0wpu/YbEMEUEVmXTNhPY
         WB5PC7qKXS396ESyHWHpFwQc8s3iY2W1B4EiwE1bYhNX1OLoKCr5YlOgku+4I3on4gKE
         QIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p0tPvH42PzsH/a5WVCAl13RRfb8J35u0MecsggOVShQ=;
        b=wQMDsJsfPaRqgwQU57bbPqrGpGUo7aNgd9oa/sjNiI/urUuFgt4yIDEXfXiEBuJzMg
         J3fuKxn8JABD89iekBjAd0jVT2YBwmaSXdtJoO6tnVPpbZDuv5k/Mx+83Ht0jh9kBxoJ
         85cgOwa1TaAr5voPqGyz/+ELIMvlD/TC5ZjvAuaTnf15Lc3ekikLzbbw2VKNWWAYewYG
         /nKXid96knSZ1hOgjgP6jQdnKl1jqgPRxdFgOsFN0MYiBgYYMI7DrjZD3ylC/E6npD5O
         3WDcLuMZLWRCK6Yrag0m9Gqthxl5cMmTMgRpqKqU7m1hsCzvEpQr4g28Hedd2W+TtWWU
         kbsg==
X-Gm-Message-State: AOAM532OCjMw30A6cGVryFBP4J8AguWrT1wI3MASXYru+3pCHhEJQXGE
        /qGh21YLzDNXk090ktiRGeY=
X-Google-Smtp-Source: ABdhPJzzCNoVP8eFM/0mLHD6V7wRmkMGJVke+7gaY+ywI2ABcLDvLrf7wqBuJDW0cGau+D9QH0Ms+w==
X-Received: by 2002:adf:a38d:: with SMTP id l13mr8620301wrb.103.1633341541064;
        Mon, 04 Oct 2021 02:59:01 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id d8sm14830300wrv.80.2021.10.04.02.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 02:59:00 -0700 (PDT)
Message-ID: <648396f6-56ce-b727-4567-2b6eba2f4f46@gmail.com>
Date:   Mon, 4 Oct 2021 10:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/11] reset_head(): fix checkout
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <c8f641132160d6bbd72a5e4921f1c9f0b3d40242.1633082702.git.gitgitgadget@gmail.com>
 <xmqqee947aqn.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqee947aqn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/10/2021 21:26, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The reset bit should only be set if flags contains RESET_HEAD_HARD.
>> The test for `!deatch_head` dates back to the original implementation
>> of reset_head() in ac7f467fef ("builtin/rebase: support running "git
>> rebase <upstream>"", 2018-08-07) and was correct until e65123a71d
>> ("builtin rebase: support `git rebase <upstream> <switch-to>`",
>> 2018-09-04) started using reset_head() to checkout <switch-to> when
>> fast-forwarding.
> 
> Sorry, but it is not quite clear what exactly is "fix checkout" in
> the context of this change, even with the above paragraph that
> describes the internals but not any end-user visible effect.

"git checkout" refuses to overwrite untracked files but reset_head() 
does when checking out a branch.

> Can this step come with its own addition to t/ to demonstrate the
> breakage that is fixed?

I can add a test to check that a checkout does not remove untracked 
files. However such a test would pass on top of 
en/remaving-untracked-fixes without the fix in this patch. I cannot 
think of a way to specifically test that unpack_tree_opts.reset == 0 
unless RESET_HEAD_HARD is given after en/removing-untracked-fixes is 
merged. Elijah's fixes will stop the "reset" mode of reset_head() from 
wiping untracked files which is good. The reset flag to unpack trees 
also affects unmerged entries but rebase does not try to checkout 
anything if the index contains unmerged entries.

Best Wishes

Phillip

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   reset.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/reset.c b/reset.c
>> index 79310ae071b..fc4dae3fd2d 100644
>> --- a/reset.c
>> +++ b/reset.c
>> @@ -57,7 +57,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>>   	unpack_tree_opts.update = 1;
>>   	unpack_tree_opts.merge = 1;
>>   	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
>> -	if (!detach_head)
>> +	if (reset_hard)
>>   		unpack_tree_opts.reset = 1;
>>   
>>   	if (repo_read_index_unmerged(r) < 0) {
