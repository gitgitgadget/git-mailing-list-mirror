Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8E2882B4
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776607495; cv=none; b=MOyNuww4Z52kSEzACT03bt9tdallqSGQXDEokPdZ5Jl2H8RXgFrnHZRJlY8ROU7azVaqQybm6+pQWRluqPIJbiea6Estaf+MzTSQOvN8F0mC3F3YMpR/DDemnNwmgNnGEUZB+Qh1ub9DFmidfJ2MoXvgqj2Xphy1vUuNYgejlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776607495; c=relaxed/simple;
	bh=auDNWtxMu56z3L2lQAfbSTse3O4xUJjp1YrpX2sve1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKFjr77zpiqmMsPb3YIbDsgrAjNh81Tcquu6BpWC3jsLmXWZSjUWwcwJvX/TTVHlZAmJ4mL++8G+6lAewxxoEcNdWW4IsQhyt1MIo6nbNnIiG8h3pX2Mm7wPJCu7/4hGyYQMVHzuja3ykEnQdhGwecHOOulPD1RBby8M8xrDPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfBCoKj2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfBCoKj2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488c2690057so20768735e9.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776607492; x=1777212292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u0k7kSmWKXgySvtYiD3nC3tKvsMLuoqoc1mpvbzY9As=;
        b=MfBCoKj2Z1HWTzbbW+qSn5i3e107hxWTg+mFBBz6YluyIalPNY+u6mzIh5HdRqspm+
         PrBefMzlVojs54Q5Cp4KKR7AtqGEnMDpPr8Cdul9pnnG2FXMdt4U8w9Mfd/Dg2SP6a9J
         SdnRMrz9b0+KRdal8mlSIUDakpE0cwfSbvIGSXXz1C6+ik9zLzS0BLMmE2bGMuSwdXse
         Gm35eYIqpU7vCd7b3CjL7cd/Ea/9rzdPZSrA2ziuAb3cYTQmU+aEfp9md0yIIObXUcEp
         jNS7TweSsGaWVUQPDkITgIQVBST0pTHTNUuUMMOrqFv8rGIcJndbhkxxSXT6dACtADIz
         y1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776607492; x=1777212292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0k7kSmWKXgySvtYiD3nC3tKvsMLuoqoc1mpvbzY9As=;
        b=ksnGHw5eA1olwKNm/7qDjt3hKSRDWKAHpRp/EsgzjIxVJycF7GJOzatanwulaj6cSc
         FVQqgLV5aoJdUF07rBvOjPMGQrdhGm+fPb7n3olclOhwvs+g34ByA69eB3iMrM8uaioe
         TxVVY7VVo1GQ1m138M41nEGYcIFIGs/MikG/VWDtum7JuwCSoL32lojpWV/JX41KpO5J
         eqGchB/tt48LtpCco7UtaPqaxbU8KCXUy+GKEmrGSXQUhTOW2jZOwB7rJy0Quni+5Hfx
         KVDwcESss8KaMOK24GWyW2VtZhsMrqLqkG6bS/mmuLFNo/lOlnj9ZpCSWHcg3vJdqc0X
         6yCw==
X-Forwarded-Encrypted: i=1; AFNElJ8tMqy+N9Y5VHaVFS7JTN0oMlkfm9oy8TBpqwAtvEfTNjgZOMDfqkA3ukthF2ObbOMl8KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHU8f/6SRwuErNE3DWry43FVoC8fuEwArwoLi5oirMuTBUof0
	MrAa+V/HI/xyDfoyO7Uw6j8zs2QpLNSNAGKwLydNOcWGRh+IeDZA2krP
X-Gm-Gg: AeBDiettunGMMnL86/Dwv2HuG5DZotYDp0myxp+F7at+4OoCE6URLSwkR7UYtqz8j01
	bjcGIgFA07Q7YRBV/G5dlH0XjSUVkSPvHisu850zgZpVBOXkZiOYX8o8AgYbIs4fvZhDYTzLTRa
	7fqAQg6pf49EZZsukAnGi5Hxb0oClI1lRWO2KGMoaUySohykiXljGPev3K7WdSesdYNiEcJZ6X9
	qREk0QOIE0sjZA33cOicWOrGiSgdPREsIGPaIcfbka+hefO3NNn2DduHN6zIcDHwRIH+s60lDxo
	5zKGtvEsvEXOoJl8WQg2ot6mHo44u2LjMXihEHmfM2ScGpsKPZ1QZph2pTyiGaVg7XOze2eocH4
	ciKsdWkyUF+mQh6nHdJdHMI+QDbFC+xoutHpSxtmVJHKn9fzwPGg8jW6nGExyGBIAwtsrtP/S5G
	eFk8gcqo9JTJMF83hibJld/UoAR5wY9MdY8fs1Qc7F5iH8FgZ3cINtcSqx5Izb7JHrLlAwxEzV0
	YFPGerhVTBQ0w==
X-Received: by 2002:a05:600c:154e:b0:488:aa3d:faca with SMTP id 5b1f17b1804b1-488fb771a4emr116189065e9.18.1776607491390;
        Sun, 19 Apr 2026 07:04:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm21821047f8f.7.2026.04.19.07.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 07:04:49 -0700 (PDT)
Message-ID: <a010a4ad-403a-4b6f-9a92-a33323eca0f2@gmail.com>
Date: Sun, 19 Apr 2026 15:04:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git
 cherry`
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
 <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 18/04/2026 01:32, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In partial clones, `git cherry` fetches necessary blobs on-demand one
> at a time, which can be very slow.  We would like to prefetch all
> necessary blobs upfront.  To do so, we need to be able to first figure
> out which blobs are needed.

"git rebase" without "--reapply-cherry-picks" suffers from this problem 
as well as it does the equivalent of "git log --cherry-pick". Is there 
any way to share prefetch_cherry_blobs() with the cherry-pick detection 
in revision.c?

Thanks

Phillip

> `git cherry` does its work in a two-phase approach: first computing
> header-only IDs (based on file paths and modes), then falling back to
> full content-based IDs only when header-only IDs collide -- or, more
> accurately, whenever the oidhash() of the header-only object_ids
> collide.
> 
> patch-ids.c handles this by creating an ids->patches hashmap that has
> all the data we need, but the problem is that any attempt to query the
> hashmap will invoke the patch_id_neq() function on any colliding objects,
> which causes the on-demand fetching.
> 
> Insert a new prefetch_cherry_blobs() function before checking for
> collisions.  Use a temporary replacement on the ids->patches.cmpfn
> in order to enumerate the blobs that would be needed without yet
> fetching them, and then fetch them all at once, then restore the old
> ids->patches.cmpfn.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/log.c     | 125 ++++++++++++++++++++++++++++++++++++++++++++++
>   t/t3500-cherry.sh |  18 +++++++
>   2 files changed, 143 insertions(+)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 8c0939dd42..df19876be6 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -21,10 +21,12 @@
>   #include "color.h"
>   #include "commit.h"
>   #include "diff.h"
> +#include "diffcore.h"
>   #include "diff-merges.h"
>   #include "revision.h"
>   #include "log-tree.h"
>   #include "oid-array.h"
> +#include "oidset.h"
>   #include "tag.h"
>   #include "reflog-walk.h"
>   #include "patch-ids.h"
> @@ -43,9 +45,11 @@
>   #include "utf8.h"
>   
>   #include "commit-reach.h"
> +#include "promisor-remote.h"
>   #include "range-diff.h"
>   #include "tmp-objdir.h"
>   #include "tree.h"
> +#include "userdiff.h"
>   #include "write-or-die.h"
>   
>   #define MAIL_DEFAULT_WRAP 72
> @@ -2602,6 +2606,125 @@ static void print_commit(char sign, struct commit *commit, int verbose,
>   	}
>   }
>   
> +/*
> + * Enumerate blob OIDs from a single commit's diff, inserting them into blobs.
> + * Skips files whose userdiff driver explicitly declares binary status
> + * (drv->binary > 0), since patch-ID uses oid_to_hex() for those and
> + * never reads blob content.  Use userdiff_find_by_path() since
> + * diff_filespec_load_driver() is static in diff.c.
> + *
> + * Clean up with diff_queue_clear() (from diffcore.h).
> + */
> +static void collect_diff_blob_oids(struct commit *commit,
> +				   struct diff_options *opts,
> +				   struct oidset *blobs)
> +{
> +	struct diff_queue_struct *q;
> +
> +	/*
> +	 * Merge commits are filtered out by patch_id_defined() in patch-ids.c,
> +	 * so we'll never be called with one.
> +	 */
> +	assert(!commit->parents || !commit->parents->next);
> +
> +	if (commit->parents)
> +		diff_tree_oid(&commit->parents->item->object.oid,
> +			      &commit->object.oid, "", opts);
> +	else
> +		diff_root_tree_oid(&commit->object.oid, "", opts);
> +	diffcore_std(opts);
> +
> +	q = &diff_queued_diff;
> +	for (int i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		struct userdiff_driver *drv;
> +
> +		/* Skip binary files */
> +		drv = userdiff_find_by_path(opts->repo->index, p->one->path);
> +		if (drv && drv->binary > 0)
> +			continue;
> +
> +		if (DIFF_FILE_VALID(p->one))
> +			oidset_insert(blobs, &p->one->oid);
> +		if (DIFF_FILE_VALID(p->two))
> +			oidset_insert(blobs, &p->two->oid);
> +	}
> +	diff_queue_clear(q);
> +}
> +
> +static int always_match(const void *cmp_data UNUSED,
> +			const struct hashmap_entry *entry1 UNUSED,
> +			const struct hashmap_entry *entry2 UNUSED,
> +			const void *keydata UNUSED)
> +{
> +	return 0;
> +}
> +
> +/*
> + * Prefetch blobs for git cherry in partial clones.
> + *
> + * Called between the revision walk (which builds the head-side
> + * commit list) and the has_commit_patch_id() comparison loop.
> + *
> + * Uses a cmpfn-swap trick to avoid reading blobs: temporarily
> + * replaces the hashmap's comparison function with a trivial
> + * always-match function, so hashmap_get()/hashmap_get_next() match
> + * any entry with the same oidhash bucket.  These are the set of oids
> + * that would trigger patch_id_neq() during normal lookup and cause
> + * blobs to be read on demand, and we want to prefetch them all at
> + * once instead.
> + */
> +static void prefetch_cherry_blobs(struct repository *repo,
> +				  struct commit_list *list,
> +				  struct patch_ids *ids)
> +{
> +	struct oidset blobs = OIDSET_INIT;
> +	hashmap_cmp_fn original_cmpfn;
> +
> +	/* Exit if we're not in a partial clone */
> +	if (!repo_has_promisor_remote(repo))
> +		return;
> +
> +	/* Save original cmpfn, replace with always_match */
> +	original_cmpfn = ids->patches.cmpfn;
> +	ids->patches.cmpfn = always_match;
> +
> +	/* Find header-only collisions, gather blobs from those commits */
> +	for (struct commit_list *l = list; l; l = l->next) {
> +		struct commit *c = l->item;
> +		bool match_found = false;
> +		for (struct patch_id *cur = patch_id_iter_first(c, ids);
> +		     cur;
> +		     cur = patch_id_iter_next(cur, ids)) {
> +			match_found = true;
> +			collect_diff_blob_oids(cur->commit, &ids->diffopts,
> +					       &blobs);
> +		}
> +		if (match_found)
> +			collect_diff_blob_oids(c, &ids->diffopts, &blobs);
> +	}
> +
> +	/* Restore original cmpfn */
> +	ids->patches.cmpfn = original_cmpfn;
> +
> +	/* If we have any blobs to fetch, fetch them */
> +	if (oidset_size(&blobs)) {
> +		struct oid_array to_fetch = OID_ARRAY_INIT;
> +		struct oidset_iter iter;
> +		const struct object_id *oid;
> +
> +		oidset_iter_init(&blobs, &iter);
> +		while ((oid = oidset_iter_next(&iter)))
> +			oid_array_append(&to_fetch, oid);
> +
> +		promisor_remote_get_direct(repo, to_fetch.oid, to_fetch.nr);
> +
> +		oid_array_clear(&to_fetch);
> +	}
> +
> +	oidset_clear(&blobs);
> +}
> +
>   int cmd_cherry(int argc,
>   	       const char **argv,
>   	       const char *prefix,
> @@ -2673,6 +2796,8 @@ int cmd_cherry(int argc,
>   		commit_list_insert(commit, &list);
>   	}
>   
> +	prefetch_cherry_blobs(the_repository, list, &ids);
> +
>   	for (struct commit_list *l = list; l; l = l->next) {
>   		char sign = '+';
>   
> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index 78c3eac54b..17507d9a28 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh
> @@ -78,4 +78,22 @@ test_expect_success 'cherry ignores whitespace' '
>   	test_cmp expect actual
>   '
>   
> +# Reuse the expect file from the previous test, in a partial clone
> +test_expect_success 'cherry in partial clone does bulk prefetch' '
> +	test_config uploadpack.allowfilter 1 &&
> +	test_config uploadpack.allowanysha1inwant 1 &&
> +	test_when_finished "rm -rf copy" &&
> +
> +	git clone --bare --filter=blob:none file://"$(pwd)" copy &&
> +	(
> +		cd copy &&
> +		GIT_TRACE2_EVENT="$(pwd)/trace.output" git cherry upstream-with-space feature-without-space >actual &&
> +		test_cmp ../expect actual &&
> +
> +		grep "child_start.*fetch.negotiationAlgorithm" trace.output >fetches &&
> +		test_line_count = 1 fetches &&
> +		test_trace2_data promisor fetch_count 4 <trace.output
> +	)
> +'
> +
>   test_done

