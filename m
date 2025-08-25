Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCBF9C0
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131249; cv=none; b=e8ds4CuJbE8ixsUYyQCgVjtX0NUjnm+45t6iMpQQz+Z4rKbt62hIgY9NGFbIL37yihY77su5I5jS2aWWleR1x36suUK4nZ/JkZdcxH9/vstj8eqsQG8kk8nm7ZoNF0Cb4lSuJeOI6Signz0HHe+Uahi51Zaqe2VP1PeFGAKbq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131249; c=relaxed/simple;
	bh=DsjyaDqomNYs2iNm/ntDwZ7w14GW5fxvqYn/fbRuuao=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VHmOYWnvPk5UJUJX1+8X7pOxn75oxbp3FQFtRnFYZMbBOkoTTK6q05xe3QakXI0YyKCAeTa8mVI/KP/MzvvKq8g4KkkzM2iDeCfYIzK9wDdhZ7SYPpkKTGd1v+p06ODuaKj0jwETs6EINXFh1vmoAH0/E1COClqjWh/an++Ggts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca0rT8Bk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca0rT8Bk"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e86faa158fso594331185a.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756131247; x=1756736047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4aTpl1UQrKPkg3wjCeCyRqgyJGXJ6KpbCWtVqbz/hSk=;
        b=ca0rT8Bk4n/c+WprOO/RfHn1eHkem/dtiGVLdba1XhLuQa9LHfAVl0uRKKoIYpPtto
         Zds9XtaDVVvUq8Q2r8PnPChAjlO26f8Zw/JDoqQWkE8GjZV2zRCb6KCGjXl7Yu/dR2yA
         VAsYtdeNtZblB4hja0Iae6/mS+KqTCQxnirl6MZcvYSsfzj1fODxUdvZEm7FrSaacwYO
         IVH58s1PRkpCo7SsVbJqc3I9V+/rN8tgnXAVr78IaG8IxAY2ZtEk/3Mns+aUPqcFk6b2
         /PET78SOF8aA5U2/pVs6uaCWPH4MYdT7OwT+UEmbbOvuQx/F+3C8/gpWR26E6kWgVwpR
         wHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131247; x=1756736047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4aTpl1UQrKPkg3wjCeCyRqgyJGXJ6KpbCWtVqbz/hSk=;
        b=J7H5zEaMYfrC5VwLRttZQ7lBA2yrW8WCJWf0weNiaIDiY2emqWUTljm08nlC6arvY1
         JByvGN2UcFGWKTSt1DUe8vy+I5zrgVvEWAt3S8ciux43Qdaw9HOkr1SiFIOy5x704ZUb
         cqBC3Wg2sMVfz6uheDEeXnbWWRNxFRJzPhq/i2tWRFF30VIpJ7hUEaY2DcF20FCEfpZ0
         LiNPsMX4ACohNvGx0jc+Or86cXBprDM0HW2/kBU2sK4eLhO4WjaNmEjhVuNV1fqRdssu
         eu5FK2QYxsuwHnUr1PLBSkrM78dL62O157jEE3xzALl3guX2cFC/D8B4n8XQxBMnI/un
         IP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5fq9GrMxIKnNPBBUw7p+ui3twpYUQU8pbQh+vZpYFixmjd26HLcKqeSqouwhlaQb0Iww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIkUQwjdWmM267P/Ngu7/0o46L1bScSgyw5NEG99HX8cq2Bnv
	qAmnLSkUQp1zBIMqxwvnPkq3RmbRGmRSynEvBOuhiwLumj8uNiZpW3vwEPYTKg==
X-Gm-Gg: ASbGncvJIhMAjqa2j7zn5VkUqJP8EbpKepdpDbVG7oRa+bfaotadOD4/MOaoRnT2+Oo
	lS7GTRsPaCgVdOp2v8fRhFy9GwMLo/4iGEyYUxcf7JlBmz6cuEtLm/We6qWRqesONCMRfua9qWU
	yumMlRgiSzApL4j20MfTTQqZln8cPv3X4F5O/25isgBJXOKZ7LYeGXf80DCfi8tGVse9EwzKXSs
	fnqOgWh1xRViX+eRTfEhiylOs/jYoCUtYYW00s9db1OZgoXblxFTHyyZRmxauK28g8kKZRmTNhL
	oQOqG8cpB9tExnanUYrnkb20VjKhTRUoOAQa7/9CBWWHfxmUpjp09K+BMe8YRQ7rjSKVx6iw6zv
	PJNTAmHMGCws9ViJkNTVxGwxR0OT+DhKmExY=
X-Google-Smtp-Source: AGHT+IGNeBaBAILiNa+pY+6KdOoMz0QEAGgqX+Vz0/ZiFm3kh5FNQETn6WOpXRsSMvkRv3KUFRCLXA==
X-Received: by 2002:a05:620a:4508:b0:7e8:62e9:7fb5 with SMTP id af79cd13be357-7ea11672932mr1263666185a.33.1756131246424;
        Mon, 25 Aug 2025 07:14:06 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf4365e79sm493116085a.73.2025.08.25.07.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 07:14:05 -0700 (PDT)
Message-ID: <930745d3-85a6-467b-a87b-b57e9623a604@gmail.com>
Date: Mon, 25 Aug 2025 10:13:43 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] line-log: avoid unnecessary tree diffs when
 processing merge commits
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
 <20250824190644.2573279-2-szeder.dev@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250824190644.2573279-2-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/24/2025 3:06 PM, SZEDER Gábor wrote:
> In process_ranges_merge_commit(), the line-level log first creates an
> array of diff queues by iterating over all parents of a merge commit
> and computing a tree diff for each.  Then in a second loop it iterates
> over those diff queues, and if it finds that none of the interesting
> paths were modified in one of them, then it will return early.  This
> means that when none of the interesting paths were modified between a
> merge and its first parent, then the tree diff between the merge and
> its second (Nth...) parent was computed in vain.

Great find! This goes all the way back to the original implementation
in 12da1d1f6f (Implement line-history search (git log -L), 2013-03-28)
where this detail could easily be missed in the rest of the scaffolding
to implement the feature.

This is an understandable mistake to make as it can take some time to
understand Git's simplified history computation and how it short-
circuits these merge diffs in most cases.
>   Summary
>     './git -C ~/src/git log -L:'lookup_commit(':commit.c v2.51.0' ran
>       2.25 ± 0.03 times faster than './git_v2.51.0 -C ~/src/git log -L:'lookup_commit(':commit.c v2.51.0'

>   Summary
>     './git -C ~/src/linux.git log -L:build_restore_work_registers:arch/mips/mm/tlbex.c v6.16' ran
>       1.32 ± 0.01 times faster than './git_v2.51.0 -C ~/src/linux.git log -L:build_restore_work_registers:arch/mips/mm/tlbex.c v6.16'

Great stats!
> And since now each iteration computes a tree diff and processes its
> result, there is no reason to store the diff queues for each merge
> parent anymore, so replace that diff queue array with a loop-local
> diff queue variable.  With this change the static free_diffqueues()
> helper function in 'line-log.c' has no more callers left, remove it.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  line-log.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/line-log.c b/line-log.c
> index 07f2154e84..cf30915c94 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1087,13 +1087,6 @@ static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
>  	return new_filepair;
>  }
>  
> -static void free_diffqueues(int n, struct diff_queue_struct *dq)
> -{
> -	for (int i = 0; i < n; i++)
> -		diff_queue_clear(&dq[i]);
> -	free(dq);
> -}
> -
>  static int process_all_files(struct line_log_data **range_out,
>  			     struct rev_info *rev,
>  			     struct diff_queue_struct *queue,
> @@ -1209,7 +1202,6 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
>  static int process_ranges_merge_commit(struct rev_info *rev, struct commit *commit,
>  				       struct line_log_data *range)
>  {
> -	struct diff_queue_struct *diffqueues;
>  	struct line_log_data **cand;
>  	struct commit **parents;
>  	struct commit_list *p;
> @@ -1220,20 +1212,19 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  	if (nparents > 1 && rev->first_parent_only)
>  		nparents = 1;
>  
> -	ALLOC_ARRAY(diffqueues, nparents);
>  	CALLOC_ARRAY(cand, nparents);
>  	ALLOC_ARRAY(parents, nparents);
>  
>  	p = commit->parents;
>  	for (i = 0; i < nparents; i++) {
> +		struct diff_queue_struct diffqueue = DIFF_QUEUE_INIT;
> +		int changed;
>  		parents[i] = p->item;
>  		p = p->next;
> -		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
> -	}
> +		queue_diffs(range, &rev->diffopt, &diffqueue, commit, parents[i]);
>  
> -	for (i = 0; i < nparents; i++) {
> -		int changed;
> -		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
> +		changed = process_all_files(&cand[i], rev, &diffqueue, range);
> +		diff_queue_clear(&diffqueue);
>  		if (!changed) {
>  			/*
>  			 * This parent can take all the blame, so we
> @@ -1267,7 +1258,6 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  		free(cand[i]);
>  	}
>  	free(cand);
> -	free_diffqueues(nparents, diffqueues);
>  	return ret;
>  
>  	/* NEEDSWORK evil merge detection stuff */

This diff is a lot cleaner than I expected it to be. Excellent!

I applied this patch locally and tested it on a few repos I have
to give extra confidence to your patch.

For an internal monorepo, I was able to measure these results:

Benchmark 1: old
  Time (mean ± σ):     19.709 s ±  0.014 s    [User: 18.846 s, System: 0.862 s]
  Range (min … max):   19.681 s … 19.725 s    10 runs
 
Benchmark 2: new
  Time (mean ± σ):      9.061 s ±  0.015 s    [User: 8.487 s, System: 0.574 s]
  Range (min … max):    9.042 s …  9.089 s    10 runs
 
Summary
  'new' ran
    2.18 ± 0.00 times faster than 'old'

I did also want to check to see the impact of f32dde8c12 (line-log:
integrate with changed-path Bloom filters, 2020-05-11), and having
computed filters diminished the size of your impact somewhat:

Your Git example:

Benchmark 1: old
  Time (mean ± σ):     279.2 ms ±   2.2 ms    [User: 231.0 ms, System: 47.9 ms]
  Range (min … max):   275.5 ms … 282.6 ms    10 runs
 
Benchmark 2: new 
  Time (mean ± σ):     242.4 ms ±   3.6 ms    [User: 191.8 ms, System: 50.4 ms]
  Range (min … max):   237.3 ms … 249.9 ms    12 runs
 
Summary
  'new ' ran
    1.15 ± 0.02 times faster than 'old'

Your Linux example:

Benchmark 1: old
  Time (mean ± σ):      1.694 s ±  0.008 s    [User: 1.524 s, System: 0.169 s]
  Range (min … max):    1.688 s …  1.714 s    10 runs
 
Benchmark 2: new 
  Time (mean ± σ):      1.644 s ±  0.008 s    [User: 1.482 s, System: 0.161 s]
  Range (min … max):    1.636 s …  1.663 s    10 runs
 
Summary
  'new ' ran
    1.03 ± 0.01 times faster than 'old'

My internal monorepo example:

Benchmark 1: old
  Time (mean ± σ):      3.749 s ±  0.007 s    [User: 3.188 s, System: 0.559 s]
  Range (min … max):    3.736 s …  3.759 s    10 runs
 
Benchmark 2: new
  Time (mean ± σ):      2.713 s ±  0.005 s    [User: 2.318 s, System: 0.394 s]
  Range (min … max):    2.706 s …  2.723 s    10 runs
 
Summary
  'new' ran
    1.38 ± 0.00 times faster than 'old'

Rerunning with "-c commitGraph.readChangedPaths=false" resulted
in numbers closer to your examples (940ms->420ms for Git and
2.6->2.1s for Linux). I expect most users to be in the situation
where there are no changed-path Bloom filters, so this is very
good to deliver that value.

At first, I found this to be concerning: we only store filters
for the diff between a commit and its first parent, so this cost
of visiting the later parents should be _much worse_ in those
cases. However, it turns out that the way that the filters are
handled in line_log_process_ranges_arbitrary_commit() avoids a
call to process_ranges_merge_commit() if the filter says that the
first parent is TREESAME on the given path.

This means that a good chunk of the performance benefits in
f32dde8c12 (line-log: integrate with changed-path Bloom filters,
2020-05-11) are _actually_ due to avoiding this extra work for
multiple parents. Thanks for digging in and bringing this benefit
to all users!

Thanks,
-Stolee


