Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CE51F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeKTXg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:36:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32955 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKTXg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:36:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so2707946qko.0
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 05:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=091jMX6vqbyiFtRcA/AcokVMnWiZ2VmvqMpj2WAuoNA=;
        b=firm4yTZhoy8KIVIEB2Y63S7+/iDIFyj5mm82hOc6qqsgWBevW6qE+K3Z836p/w/wN
         1ngBEvEPvxdq0BC0Rn+6AcYpFIQmBAwaIbHqzyXVG+uPpQgX6iput339bIDQ5RXJp9JA
         MqzumbJSyEuouYwOEUr3ZrkTXalQyQ9doq5/L/9/ER2IL3/Yy4dwzDU4D1zBK0TcX09V
         znYd3BdGLx69/vZ82e13fFbSy4KJmtxCU9HIkhY4NDoU6IZkICTrGTWsstgK6KRx4ryL
         T9AyhC8YLbCyUeESXzw5Xv8+cERZIR9GZKIJlkNH+cWsbu83Fx9Sed+nlEpZImyO4lDi
         GMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=091jMX6vqbyiFtRcA/AcokVMnWiZ2VmvqMpj2WAuoNA=;
        b=sEhF3VglER+/AXiiJlfhuhzMt+FYEUrHnlWs/mBCfQgqLMCRHwWehjw8E7eLSFg9cM
         /DAZR28Pjoc67PCz/6pte49rmLjhrpgW9RyeygHZf1hCAuxIcWweZ8SCx843mfzpImJQ
         TmBkLAbIVIfkSJIT0COWbwav2iucZ74wptsa62FuxJ4rIghWpvQq31Fwxhs34rgTF3GC
         hzyTkwW+Pv0ixWHRRC8L8qpa+jy61wjHNQeRRaQnkR5f6vxXvstM5paR5KqpM8zUoRYe
         o0NyDxzWU8XeOl/EPozGfBlL2ZlJIlZ0/xOL1Phy3qVL6x6pMqwoiU2y8MMLr1zCjvQ2
         ZcPw==
X-Gm-Message-State: AA+aEWZm382/cqo1RkGz8Hte0oqTYzhTTcfgtfoGIxiWBrlPpHnc7VVJ
        f8i1GW0bA2gtqLy5ju3Wi9Y=
X-Google-Smtp-Source: AFSGD/Xjs6LWF+dc900ONQEY799kUfAfpA2cTFOrUDGpFGT241jtySeQS7rS5V1LVpuZR3CpZxqY4w==
X-Received: by 2002:a37:d91:: with SMTP id 139mr1748647qkn.26.1542719271830;
        Tue, 20 Nov 2018 05:07:51 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x57sm28756301qtx.96.2018.11.20.05.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:07:51 -0800 (PST)
Subject: Re: [PATCH 2/5] ieot: default to not writing IEOT section
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com> <20181120061221.GC144753@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <05e7df80-0dfc-c1ec-df14-c196357524f4@gmail.com>
Date:   Tue, 20 Nov 2018 08:07:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181120061221.GC144753@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/2018 1:12 AM, Jonathan Nieder wrote:
> As with EOIE, popular versions of Git do not support the new IEOT
> extension yet.  When accessing a Git repository written by a more
> modern version of Git, they correctly ignore the unrecognized section,
> but in the process they loudly warn
> 
> 	ignoring IEOT extension
> 
> resulting in confusion for users.  Introduce the index extension more
> gently by not writing it yet in this first version with support for
> it.  Soon, once sufficiently many users are running a modern version
> of Git, we can flip the default so users benefit from this index
> extension by default.
> 
> Introduce a '[index] recordOffsetTable' configuration variable to
> control whether the new index extension is written.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> As with patch 1/5, no change from v1 other than rebasing.
> 
>   Documentation/config/index.txt |  7 +++++++
>   read-cache.c                   | 11 ++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
> index 8e138aba7a..de44183235 100644
> --- a/Documentation/config/index.txt
> +++ b/Documentation/config/index.txt
> @@ -5,6 +5,13 @@ index.recordEndOfIndexEntries::
>   	reading the index using Git versions before 2.20. Defaults to
>   	'false'.
>   
> +index.recordOffsetTable::
> +	Specifies whether the index file should include an "Index Entry
> +	Offset Table" section. This reduces index load time on
> +	multiprocessor machines but produces a message "ignoring IEOT
> +	extension" when reading the index using Git versions before 2.20.
> +	Defaults to 'false'.
> +
>   index.threads::
>   	Specifies the number of threads to spawn when loading the index.
>   	This is meant to reduce index load time on multiprocessor machines.
> diff --git a/read-cache.c b/read-cache.c
> index 1e9c772603..f3d5638d9e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2698,6 +2698,15 @@ static int record_eoie(void)
>   	return 0;
>   }
>   
> +static int record_ieot(void)
> +{
> +	int val;
> +

Initialize stack val to zero to ensure proper default.

> +	if (!git_config_get_bool("index.recordoffsettable", &val))
> +		return val;
> +	return 0;
> +}
> +
>   /*
>    * On success, `tempfile` is closed. If it is the temporary file
>    * of a `struct lock_file`, we will therefore effectively perform
> @@ -2761,7 +2770,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   	else
>   		nr_threads = 1;
>   
> -	if (nr_threads != 1) {
> +	if (nr_threads != 1 && record_ieot()) {
>   		int ieot_blocks, cpus;
>   
>   		/*
> 
