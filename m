Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497A61F453
	for <e@80x24.org>; Mon,  1 Oct 2018 19:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeJBCFT (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 22:05:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44598 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBCFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 22:05:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so1470617qka.11
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XeCaTOlyRBJjP/MkHKjnTVdU895WHl0XYX9bqM9N114=;
        b=iIAln+cRmpybR09NLe2ndDLE7MfbN/rO298Zyv95DFHxo2SkSniT+Znd2MrcUvzyLI
         xo3oFTTEhZyKkB7ztrzRTw0YPciTRWCmO3qEYOXIqGuG+Br1IoV8v5079x04r5TOVUi8
         O0aCsyGdhUlLCN/24SmqqdqrskXAwCk2J858wY2mNfxzDp6m27zLp0/N6nz4E3KKTLuh
         C1xyZNbM8y2m8+2bD3i8kTh5k8SBLHeHlaORXEUqp8fXig8yhwVcbJrUgu/UNtc/bDHM
         RWWUj9oG6YMib9oRgyTSQf1Kxog29T13N4MQYPRMjjflYNtb6D23qE73gsWMW+Y+HN3K
         r1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XeCaTOlyRBJjP/MkHKjnTVdU895WHl0XYX9bqM9N114=;
        b=JJecw4zeTqqalikLvbi7WamPl7I3dtI/LH1TnjTWMn3K638tQhQY2mHzVV5GHGmdDz
         UoPWBTqvSK7ADVHLhI3o752h0jjPf9tvW7HJYV2mv0kX7q+JYvFYa3iZy+ZlxTSzJh+w
         eheBsIDe2f461hCPsNow2FAZuwQsuq23DH37gWJDF4c/MKshcYBHprFH/X04xB8+HbXq
         CmkCgMhBuRNL4gjvIDDjs7Mw096Yw6AaheZnkzEqZcGslI6+LGevYOvtd8J2CX+YUj04
         qmHp9fosxlPFCi8VbAQxK26B9IILaS//kj2s9KpQ5ECqpPapMGPfTfskNMRfb3f9NDK6
         IQBA==
X-Gm-Message-State: ABuFfoj5tbvQ6EsnklOXNLd6jtRfkPjUYt6CZkUJnNWxNuZh/AfwGUIZ
        riKUu51BWaowvSTMgL8UxOg=
X-Google-Smtp-Source: ACcGV62HB5tnHueWeI2vlkNp+joflu3wI1d3EA9smDIFXuROBAsduFdg/rRHTG3iEHm+/m4gN0/yMQ==
X-Received: by 2002:a37:1b99:: with SMTP id m25-v6mr9558818qkh.7.1538421961548;
        Mon, 01 Oct 2018 12:26:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f5be:873:b4e5:f5e1? ([2001:4898:8010:0:def4:873:b4e5:f5e1])
        by smtp.gmail.com with ESMTPSA id c43-v6sm3762566qtd.85.2018.10.01.12.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 12:26:00 -0700 (PDT)
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
Date:   Mon, 1 Oct 2018 15:26:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/1/2018 3:16 PM, René Scharfe wrote:
> Am 28.06.2018 um 14:31 schrieb Derrick Stolee via GitGitGadget:
>> diff --git a/commit-reach.c b/commit-reach.c
>> index c58e50fbb..ac132c8e4 100644
>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -513,65 +513,88 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>>   	return is_descendant_of(commit, list);
>>   }
>>   
>> -int reachable(struct commit *from, int with_flag, int assign_flag,
>> -	      time_t min_commit_date)
>> +static int compare_commits_by_gen(const void *_a, const void *_b)
>>   {
>> -	struct prio_queue work = { compare_commits_by_commit_date };
>> +	const struct commit *a = (const struct commit *)_a;
>> +	const struct commit *b = (const struct commit *)_b;
> This cast is bogus.  QSORT gets handed a struct commit **, i.e. an array
> of pointers, and qsort(1) passes references to those pointers to the
> compare function, and not the pointer values.

Good catch! I'm disappointed that we couldn't use type-checking here, as 
it is quite difficult to discover that the types are wrong here.


> As a result it's unlikely that the array is sorted in the intended
> order.  Given that, a silly question: Is sorting even necessary here?

The reason to sort is to hopefully minimize the amount we walk by 
exploring the "lower" commits first. This is a performance-only thing, 
not a correctness issue (which is why the bug exists). Even then, it is 
just a heuristic.
> Anyway, the patch below should fix it.
>
> -- >8 --
> Subject: [PATCH] commit-reach: fix cast in compare_commits_by_gen()
>
> The elements of the array to be sorted are commit pointers, so the
> comparison function gets handed references to these pointers, not
> pointers to commit objects.  Cast to the right type and dereference
> once to correctly get the commit reference.
>
> Found using Clang's ASan and t5500.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Has this patch a performance impact?
>
>   commit-reach.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 00e5ceee6f..2f5e592d16 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -529,8 +529,8 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>   
>   static int compare_commits_by_gen(const void *_a, const void *_b)
>   {
> -	const struct commit *a = (const struct commit *)_a;
> -	const struct commit *b = (const struct commit *)_b;
> +	const struct commit *a = *(const struct commit * const *)_a;
> +	const struct commit *b = *(const struct commit * const *)_b;

I would expect s/* const */**/ here, but I'm guessing your formulation 
is a bit extra careful about types.

Thanks!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
