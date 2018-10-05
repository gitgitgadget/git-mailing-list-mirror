Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD601F453
	for <e@80x24.org>; Fri,  5 Oct 2018 12:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeJETNl (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 15:13:41 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36958 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeJETNk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 15:13:40 -0400
Received: by mail-qt1-f172.google.com with SMTP id d14-v6so4869863qto.4
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YjO2S8U3h75t+MONA9I98ejDayf8qUiU3suNZ0/sw84=;
        b=WC9wUsyZarDtQqRD1IK/pYg/Lp1gyf32qkLrNqXeFnwcr3WTQS26wSM+DwEQ7USF/X
         14tSsr42gq7HdaDOI4KeSKinv348qkXhDvf1EzHoDDl7d2MI2e+1U1Ru0QPsbF3cYOsI
         Q7gHlK8ZM4tfSyeLoXKNppkSYqTbnKGx7l7QrVRwPJGvW0n4TQZABn9ogCjPMro6WGE6
         h7KWMyHcF5C6xUATFN4kzxfczWA7Mpu+/HJ/5SR/6RyrFg6c5y42H+/0Amgq9B711AIN
         SG/8kJJ0EMit/xUOHDUsOVPDzR2u399cT+o61tleFNVfYfFG4Vfkt0K4aEGNRCcdG4MK
         xSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YjO2S8U3h75t+MONA9I98ejDayf8qUiU3suNZ0/sw84=;
        b=NcZn8LZvCEu/FeXajpMe6W/67tN9ttGfvBgfXIYT/2pbEPxnDX0dOeNW3obhU5OwBf
         1euvpEsijFFdofMuvPfGLMW3Wh6UB/N/188CJhFMlEc9yS9Ok/3/zeZ0A1nKF5OdNa+b
         5WmOtK5tX5C25FINvPqgpFzFt9z/mUx6l6M5/TG8b+SGfn5E+tCELwCCcesXs33GxprW
         HMvbtBsNJYBvXHYJ5PE+t4nXaQCGL7REi5x1l3PrNiH7fl6GEUGCqL8Bh7DA0lEI4csD
         B1VcxEjUDVBr9e1Tb2TcGC9OD9dbYUus+lhu4KE8DvNzRp4Uql9nQffkSi8/Rc+x2k4U
         ByFQ==
X-Gm-Message-State: ABuFfoiQzenUazrcWyIWsXu2gzrNabEbufe5Tdj1dLN5ihpKTegwteoD
        KgDtutpsJXaHIR7G7gVlEPc=
X-Google-Smtp-Source: ACcGV62WAKM+LJ7f3czmbJtuEQsJo6j6amUmgyWkUQJOYU10EpOst6M/ddNtKUD/4/4Pd9WCq9wHhg==
X-Received: by 2002:aed:2e04:: with SMTP id j4-v6mr8575430qtd.47.1538741711764;
        Fri, 05 Oct 2018 05:15:11 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id p51-v6sm4390482qta.61.2018.10.05.05.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 05:15:10 -0700 (PDT)
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f27fd384-6cfa-5acb-3e2b-72668f04d689@gmail.com>
Date:   Fri, 5 Oct 2018 08:15:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/2018 6:59 PM, René Scharfe wrote:
> Am 01.10.2018 um 22:37 schrieb René Scharfe:
>> Am 01.10.2018 um 21:26 schrieb Derrick Stolee:
>>> Good catch! I'm disappointed that we couldn't use type-checking here, as
>>> it is quite difficult to discover that the types are wrong here.
>> Generics in C are hard, and type checking traditionally falls by the
>> wayside.  You could use macros for that, like klib [*] does, but that
>> has its own downsides (more object text, debugging the sort macros
>> themselves is harder).
>>
>> [*] https://github.com/attractivechaos/klib/blob/master/ksort.h
> We could also do something like this to reduce the amount of manual
> casting, but do we want to?  (Macro at the bottom, three semi-random
> examples at the top.)

I like the idea! It certainly can assist in some of the repeat work when 
preparing to QSORT, and make it less error-prone.

> ---
>   bisect.c          | 11 +++--------
>   commit-graph.c    |  9 ++-------
>   commit-reach.c    | 12 +++++-------
>   git-compat-util.h | 12 ++++++++++++
>   4 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index e8b17cf7e1..06be3a3c15 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -192,16 +192,11 @@ struct commit_dist {
>   	int distance;
>   };
>   
> -static int compare_commit_dist(const void *a_, const void *b_)
> -{
> -	struct commit_dist *a, *b;
> -
> -	a = (struct commit_dist *)a_;
> -	b = (struct commit_dist *)b_;
> +DEFINE_SORT(sort_by_commit_dist, struct commit_dist, a, b, {
>   	if (a->distance != b->distance)
>   		return b->distance - a->distance; /* desc sort */
>   	return oidcmp(&a->commit->object.oid, &b->commit->object.oid);
> -}
> +})
>   
>   static struct commit_list *best_bisection_sorted(struct commit_list *list, int nr)
>   {
> @@ -223,7 +218,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
>   		array[cnt].distance = distance;
>   		cnt++;
>   	}
> -	QSORT(array, cnt, compare_commit_dist);
> +	sort_by_commit_dist(array, cnt);
>   	for (p = list, i = 0; i < cnt; i++) {
>   		struct object *obj = &(array[i].commit->object);
>   
> diff --git a/commit-graph.c b/commit-graph.c
> index 7f4519ec3b..a2202414e0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -550,12 +550,7 @@ static void write_graph_chunk_large_edges(struct hashfile *f,
>   	}
>   }
>   
> -static int commit_compare(const void *_a, const void *_b)
> -{
> -	const struct object_id *a = (const struct object_id *)_a;
> -	const struct object_id *b = (const struct object_id *)_b;
> -	return oidcmp(a, b);
> -}
> +DEFINE_SORT(sort_oids, struct object_id, a, b, return oidcmp(a, b))
>   
>   struct packed_commit_list {
>   	struct commit **list;
> @@ -780,7 +775,7 @@ void write_commit_graph(const char *obj_dir,
>   
>   	close_reachable(&oids);
>   
> -	QSORT(oids.list, oids.nr, commit_compare);
> +	sort_oids(oids.list, oids.nr);
>   
>   	count_distinct = 1;
>   	for (i = 1; i < oids.nr; i++) {
> diff --git a/commit-reach.c b/commit-reach.c
> index 2f5e592d16..3aef47c3dd 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -527,17 +527,15 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>   	return is_descendant_of(commit, list);
>   }
>   
> -static int compare_commits_by_gen(const void *_a, const void *_b)
> -{
> -	const struct commit *a = *(const struct commit * const *)_a;
> -	const struct commit *b = *(const struct commit * const *)_b;
> -
> +DEFINE_SORT(sort_commits_by_gen, struct commit *, ap, bp, {
> +	const struct commit *a = *ap;
> +	const struct commit *b = *bp;
>   	if (a->generation < b->generation)
>   		return -1;
>   	if (a->generation > b->generation)
>   		return 1;
>   	return 0;
> -}
> +})

Here, to make the macro version compile you need to cast ap and bp, 
which gives us a level of type-safety that wasn't there before. That can 
help us find errors at compile-time!

>   
>   int can_all_from_reach_with_flag(struct object_array *from,
>   				 unsigned int with_flag,
> @@ -580,7 +578,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
>   		nr_commits++;
>   	}
>   
> -	QSORT(list, nr_commits, compare_commits_by_gen);
> +	sort_commits_by_gen(list, nr_commits);
>   
>   	for (i = 0; i < nr_commits; i++) {
>   		/* DFS from list[i] */
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5f2e90932f..f9e78d69a2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1066,6 +1066,18 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
>   		qsort(base, nmemb, size, compar);
>   }
>   
> +#define DEFINE_SORT(name, elemtype, one, two, code)			\
> +static int name##_compare(const void *one##_v_, const void *two##_v_)	\
> +{									\
> +	elemtype const *one = one##_v_;					\
> +	elemtype const *two = two##_v_;					\
> +	code;								\
> +}									\
> +static void name(elemtype *array, size_t n)				\
> +{									\
> +	QSORT(array, n, name##_compare);				\
> +}
> +

I would use this macro.

Thanks,

-Stolee

