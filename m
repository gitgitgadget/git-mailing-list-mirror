Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDEC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 17:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiHQRge (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbiHQRgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 13:36:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CAEA1A53
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:36:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k14so12651858pfh.0
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=0jfsMPjk5mZH0qGaH3yjNv5kWoZyiS4dsXLE2yR65cA=;
        b=MI15K+r6jq7cD1HmWgqLOBcYqr/O4mz0gif+8VE3S10o9fGdw2H/hkaBOmcWK81nm+
         xpKSnAG54Dvqkf77LTXnza2r2taDN+3KmHjR/kY9g3S+TZJrNHSaFWJWoOnYtwbFxrxH
         O0RVHKYRGcnV/kkocFdjTIQX+CUKu+KwrnDow29yQbUjBK1aLaPxURPU1MczVi5qraR5
         iJH4301LQKp4RhKFy4UYWM6O8TTwG7+RjR22kgot4y1YBikmT1cd9oGS+R1jSOfKaYTy
         kDcpEJAFZizP9kZn2T8xbeeBUDJl4Oy/Cn06dFX/FYnslvkYC1IOC1SvbwSPQlLdfs1F
         JE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0jfsMPjk5mZH0qGaH3yjNv5kWoZyiS4dsXLE2yR65cA=;
        b=5b+wt9TTgCq1t1PkYSrhvPIoCKs8+52NM9YrBOluOwtn7kdpp41IpNQNPbOyKAj5U1
         RY22l6WCgktRo058b+f3ESiuOmnCHyg2Z534m0+UQgQEGxT4l5aoZXrAnE+tux4h83iq
         FNGCWGYi0n0NHbTfmqUvINnlZMFRjn7yKcH68ZaMqvHonExZu6NXi0Skh3Gsjd9W93ng
         JUd1r8WRE0qLHjrPO/g20SpH2SXjHvbBLS1kzTpT8Dtf0VPb32m1hUH5xW8KNew+2vC0
         EuXj786R9ni/1uH8NkHxCwHkdeBHJGKL0cw2FJJDlFI4SC0TbLNLBctdKXvvMm1VjQzf
         gWnQ==
X-Gm-Message-State: ACgBeo2SdMbSykot6Z69aHfKNid4BUyQbznIbc1M5AX+Mbr9inI/kjyw
        DpcwLVsyWFjWpm32QZsRUidz
X-Google-Smtp-Source: AA6agR4PfmnqzXMPlng978c3YZYE+/fHZAV/vDlHP99sbXpereQc/wgTacrSEqxSYStoM4USxE3OYw==
X-Received: by 2002:a63:170d:0:b0:415:f76d:45e1 with SMTP id x13-20020a63170d000000b00415f76d45e1mr22576389pgl.171.1660757789493;
        Wed, 17 Aug 2022 10:36:29 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id cs7-20020a17090af50700b001f7613a9d0dsm1772943pjb.52.2022.08.17.10.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 10:36:28 -0700 (PDT)
Message-ID: <6c39fc96-2e88-297e-38df-4bcb88447972@github.com>
Date:   Wed, 17 Aug 2022 10:36:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/5] scalar unregister: stop FSMonitor daemon
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <fc4aa1fde31fa0726cde2c1d4e41f3f140fff6f6.1660694290.git.gitgitgadget@gmail.com>
 <2cbbd732-b9e7-fe8b-9c77-f86a856d06c7@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <2cbbd732-b9e7-fe8b-9c77-f86a856d06c7@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 8/16/2022 7:58 PM, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Especially on Windows, we will need to stop that daemon, just in case
>> that the directory needs to be removed (the daemon would otherwise hold
>> a handle to that directory, preventing it from being deleted).
> 
>> +static int stop_fsmonitor_daemon(void)
>> +{
>> +	assert(fsmonitor_ipc__is_supported());
>> +
>> +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
>> +		return run_git("fsmonitor--daemon", "stop", NULL);
>> +
>> +	return 0;
>> +}
>> +
>>  static int register_dir(void)
>>  {
>>  	if (add_or_remove_enlistment(1))
>> @@ -281,6 +291,9 @@ static int unregister_dir(void)
>>  	if (add_or_remove_enlistment(0))
>>  		res = error(_("could not remove enlistment"));
>>  
>> +	if (fsmonitor_ipc__is_supported() && stop_fsmonitor_daemon() < 0)
>> +		res = error(_("could not stop the FSMonitor daemon"));
>> +
> 
> One thing that is interesting about 'scalar unregister' is that it does
> not change config values. At that point, we don't know which config values
> are valuable to keep or not because the user may have set them before
> 'scalar register', or otherwise liked the config options.
> 
> Here, the reason to stop the daemon is so we unlock the ability to delete
> the directory on Windows.
> 
> Should this become part of cmd_delete() instead of unregister_dir()? Or,
> do we think that users would opt to run 'scalar unregister' before trying
> to delete their directory manually?

After reading this, my first thought was that 'scalar unregister' should
still turn off the FSMonitor daemon because, in addition to allowing for
directory deletion in 'scalar delete', it's "cleaning up" some
optionally-enabled behavior associated with Scalar (a la
'toggle_maintenance(0)'). However, given that 'unregister' doesn't clear
'core.fsmonitor', it really *isn't* comparable to 'toggle_maintenance(0)'.

So I think you're right that it should only be associated with enlistment
deletion (although I think 'delete_enlistment()' is the place for that -
right before 'remove_dir_recursively()' - rather than 'cmd_delete()').

Thanks!

> 
> Thanks,
> -Stolee

