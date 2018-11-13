Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E7F1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbeKNBVY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 20:21:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33442 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbeKNBVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 20:21:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id o89so19996354qko.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 07:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rHosgsucSlhJjzvH/lgzv4pVfUfyOlifRmxKHnkcV5Q=;
        b=t+mvMxNz9aYvKxtL5IuUJuM3TwYm/JQnlC1pTNI6D/IlE01e0J65lWoZH1+37BEAGd
         UxDbq3sOdSe0+S7LLeHtGmUUeE1658HWQGdsCizavU9bAUpBNc/spMWp2i0rp3FpSEhp
         UaAT56ZgwqxWMvRlOeqd/jnYkkEBjqPj9AztFGCptQYanNT+YKZLftPcDy6EIekP+kqr
         3I5gxEw1oRIt0aTGTqvZ/ayTA1BZWNwyXadCazzLkdJRfonKaOdFTwokvjFfp4BC9DsM
         /G9SkTbPNkGZGIG8fNKu/3Rrn0CN61yZQCUlxQ/6xD6eYvILm1UiXLPWV/DOxqb7UgiT
         XEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rHosgsucSlhJjzvH/lgzv4pVfUfyOlifRmxKHnkcV5Q=;
        b=rLa/vfKVsaSog3BndXNi/pe3PSWWxzsWX19ukdM+ELa9TCfYRrkZr0iDxAsu4g1z8G
         UjFLd1wkye9BBSAvgntluAHcjsk//+85nDaoUk5VauAVB9hHsBsyRk9GGyP3IBn7fL8M
         tsj9scDJ8D0XzPTOzjncNVOW4ABsY5OuYpGbL2LPmY6AeYv+EtYXS1zO52JkXWzeUyt6
         YnzQ2AoW2j7HUY4q8vbnq09IQ+NkAeAFa744mKwYLoI0oMPc48ZW0rw9mSzwqoEIVnfE
         CLcqZ83RX2FD1ZcldE2XamN9Niq8domd4geOL1IViYCEj0PQTsjNhLUCMIo/5rk9P5QA
         NEvA==
X-Gm-Message-State: AGRZ1gLPpjQ4idaQCKu4LSY9T+jD0H0IbLW2BBMADdoMARUY2XOv6B4p
        8m7C5Ge+dlvrGTbaQstbPXo=
X-Google-Smtp-Source: AJdET5cGHLU/k/f2+vY8FkjXoOpuTI9B3Be7hV8WfESuNdi+TnLTRAM7TO6lbm27Cy/sCbdD9gXEfQ==
X-Received: by 2002:ac8:181c:: with SMTP id q28mr5449303qtj.223.1542122567013;
        Tue, 13 Nov 2018 07:22:47 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f11-v6sm8914921qth.28.2018.11.13.07.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:22:46 -0800 (PST)
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
Date:   Tue, 13 Nov 2018 10:22:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181113003938.GC170017@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/12/2018 7:39 PM, Jonathan Nieder wrote:
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

Why introduce a new setting to disable writing the IEOT extension 
instead of just using the existing index.threads setting?  If 
index.threads=1 then the IEOT extension isn't written which (I believe) 
will accomplish the same goal.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>   Documentation/config.txt |  7 +++++++
>   read-cache.c             | 11 ++++++++++-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d702379db4..cc66fb7de3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2195,6 +2195,13 @@ index.recordEndOfIndexEntries::
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
> index 4bfe93c4c2..290bd54708 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2707,6 +2707,15 @@ static int record_eoie(void)
>   	return 0;
>   }
>   
> +static int record_ieot(void)
> +{
> +	int val;
> +
> +	if (!git_config_get_bool("index.recordoffsettable", &val))
> +		return val;
> +	return 0;
> +}
> +
>   /*
>    * On success, `tempfile` is closed. If it is the temporary file
>    * of a `struct lock_file`, we will therefore effectively perform
> @@ -2767,7 +2776,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   
>   #ifndef NO_PTHREADS
>   	nr_threads = git_config_get_index_threads();
> -	if (nr_threads != 1) {
> +	if (nr_threads != 1 && record_ieot()) {
>   		int ieot_blocks, cpus;
>   
>   		/*
> 
