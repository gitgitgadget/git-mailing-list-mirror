Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392E1367B6A
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953524; cv=pass; b=mqvfr7h4EeIanzNhYILUIay8qCtHNph+bycb7ywdW2Ej5JN/9wRXf6/1LqnCWDt1/tAWmVhUR3sSEqMzcJCt/GkOA3UEuxWm9Zu/DHRStbgzEDCEhLdcmP4t36TViEwfUBTdYY5RTewlMBiFpBdagFLk8YgU7F9oCV7RAipWFMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953524; c=relaxed/simple;
	bh=XbdJnhEtPIrI4A4ERJAlqVmSj2fDtOrir4xmd5Jh5mg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZzvHiKCkkg1bVIRjXMCgEDfAwAbMAi82nc8MIIGrbCziF4FC2TKts/SOP+GYKEfjvHEbCqds+m+pT2z3lV0kqCvB4nQH8pwrOYFPGMhxtNXbosFNbEDWZM4vnOYJP4kOWBRSG62iPO9owwRdEGn91vB1b3frNTxCPufr/NUjN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyuiFkbD; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyuiFkbD"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9639130b20fso3122448241.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 14:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780953521; cv=none;
        d=google.com; s=arc-20240605;
        b=YGvmudF0aXZ2Zp0oYEP8FBdJ7bNhTZ6C8QZo8RCKEWO+j/Px5w3ODUCB14L3pPX+AA
         CCVhFTs+igSlbwQg7Re8vLoryVuZG3++43Wbsz1gNsk27JyxDLXemwN8rE0+wO/xvR29
         2STtkdTZwLBFORYVth7yzEAr6MGIZ2DcTAQphyyGems1zrKpPe/U3/l7UjPxGe1TjZrx
         PAbVvxYstn3aFMr/dYiXn21z6clC2Xvh0DIAvkSHuVYsZqkL8a6O8B/tfLJU8nu/5sZx
         jWCWwAxV2Oih5nhx90kgIpjieSvZ+3FasBVIVrEMED3OWK6RJABnTkap5x8HIUR1nQ43
         XhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FGfL+A0do7ELDdG225Cl+J4wp35b0FkZCIYpW1AfUrU=;
        fh=maxZP+n+WTuobMEtSYF3yYJTu+Zrcjkxys+lEOGUd1Q=;
        b=U16I839QWq2ClskrQzi+6qJD8Lp4wvWXIsnOgEgA4H7kz9Cx6FQdQfvuH0ypFo9oiv
         vTrE2KpuKNzU1IsbrfkVoa70GW3m/3cJBvHV/4UdPaLdtE8Pts/TrrS0iqCeJMZggTAm
         Md5ZmM7uol2xSBpHi/SN5VTlDMlQFSp00EWKO1NvAk86SdjsUIscnk0l2d9ocaEV2uDm
         wXL1FU3yUjr2AyBngvy2D9lNCnMLqDBgHnHk0ZYumiOqCQSaElzFOCIVufTfDqAWj5TU
         whdaWZpFrsMVdgQpNUOcHfLjTq+p/artfdBFM1dC8DdwM0ysa/UM1s/IP3Oy3zMk8i9b
         E8/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780953521; x=1781558321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGfL+A0do7ELDdG225Cl+J4wp35b0FkZCIYpW1AfUrU=;
        b=DyuiFkbDmcaKmE7oP4z2RpcmxhZX2McW4y1rdbVdPDBPSAjNZem8V7qzWIEd7kR2+L
         E537ixRrY/skxMMiFX1vBRsiBAhCWnokDXl0klYdLsmD4Hzph7sLaQhFnd6bQKm4YFbu
         fMrhmveisaf33cIPqUtQqSCiiAoeRx8jrf51eNdZ+fMb+L/7x2ovjOJ+wUmKBBFeTlaW
         ncKMUMKtgDmeJx9yjROzNGGYbXVfChCEnSKzwbM2OtA3Ob5hwmO+wmsg+4Px15TylqCQ
         kBfVb+KIN2SsZPoBdBL9GCWUMhKjvXFonWksP4UxMEmjWu/ZYviCwr5Af+KEYPRrGgcy
         XRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780953521; x=1781558321;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGfL+A0do7ELDdG225Cl+J4wp35b0FkZCIYpW1AfUrU=;
        b=iT16ZTrXwk8B8OG7irRl74nbJ0dxAGOB3WSRoez6ckhw6FXvyv1PgOzYOmhAnDXMYq
         Cg9D4fRJkJgoPEXiq6h+HgDUGXZmbc6mgSj1Y9WanJgceIBf8m0uEBEuze/PvDfTkWlV
         P2KLDNSpeunFxAbL6kcA21lhlrZz0VY3m9ORPVc9swsHdbgjls2Qg4Uhki5EOxarHskY
         oPvjVG4pmaIqUzjbdJIVFW1qLg/+FL/INQP3d/tqRKLndTqac+eMklhxDjqjtGO52aUV
         fFY7kEQkTh96DBoKwgquS9lBMZ7J0pf1jTTGKSLK/lTL6W/9lqp5Br26S/FC5fmbmEfZ
         DMMw==
X-Forwarded-Encrypted: i=1; AFNElJ+JjRaVm4V/GVxhH9KfwdskS0qYHt+Lr2l6Bar15/sBF4tNByqZGMmXt3SJwXO1dJxRh7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YfvIY1sg/rQvShu6OVz8Z67b0Y56apyhK7gBQEd3nFZJinjt
	O9K0oEEwr/LczXO5Mmrpiir2OH9Vd5WTOh+P043gtfA4kvwh41KP7YUEnLVcTFxUvFaPzLvQfhE
	t+FNWhla2dm/OkO/pDuTPlbLS3CJRIUg=
X-Gm-Gg: Acq92OF773GyGvZ1T4+k34KKjyiDgfjx/QhucHXD1tGzspPDof+TePbn8k6aZn/ZOEl
	+9snTOJh+Wny42SBxdswcj+cEmuox5SAfEo69T7E/0urPoc1ehm1jnp7Tu3NyPE0CJYfupbc6au
	p57uOA7z6QitXe/e+2o95Q9WGXOup2evXXSp9xQM1R+98xPU9VUFPbYKs8oIKDFJHCOz9u/EcWD
	dej1Hik8MVI2ENKtvaCL+qzZ+yWvoBfhgEWIvMJXCr7vQTzBb9YJ7Q0Ca3hVduY+ua/6i5kvmyS
	ZtEyPblRwcH/tldwtC2C2KtqCeQG/lNdHZXg3dba7Tk37gexjZVxobjNcNa2a/muya2KHRk9AZ8
	IlbGo0fBd
X-Received: by 2002:a05:6102:c91:b0:6ef:fca1:13f2 with SMTP id
 ada2fe7eead31-6fefc8b5b6amr9422301137.7.1780953520988; Mon, 08 Jun 2026
 14:18:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 14:18:39 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 14:18:39 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
References: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jun 2026 14:18:39 -0700
X-Gm-Features: AVVi8CcUxGGwAIlYlQRZJFTbCzR4-vuM_WUmo9nmkcDn3DDRyWsfjqrm6uevL6E
Message-ID: <CAOLa=ZS_U+u43SV9ELSEU6AT7rzEQ44BuHPAi1BAHEGQAnPoPw@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: reuse --contains traversal results
To: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fb099e0653c48d31"

--000000000000fb099e0653c48d31
Content-Type: text/plain; charset="UTF-8"

Tamir Duberstein <tamird@gmail.com> writes:

> git branch and git for-each-ref call repo_is_descendant_of() for each
> candidate selected by --contains or --no-contains. Each call starts a
> new graph walk, so refs with shared history repeatedly traverse the same
> commits.
>
> ffc4b8012d (tag: speed up --contains calculation, 2011-06-11) introduced
> the tag traversal that caches positive and negative answers across
> candidates. ee2bd06b0f (ref-filter: implement '--contains' option,
> 2015-07-07) preserved the branch and tag implementations when ref-filter
> learned --contains. 008ed7df930 (tag.c: use the correct algorithm for
> the '--contains' option, 2015-10-18) noted that they should be unified.
>

Nicely explained. We should've merged this long ago, so this is a
worthwhile change.

> Use the memoized traversal for every ref-filter contains check and
> remove the implementation selector. The cache records answers for one
> fixed target list, so document that callers must clear it before
> changing the list.
>
> The memoized depth-first walk assumes acyclic ancestry, but replacement
> refs can create cycles. Track commits while they are on the walk. If a
> cycle is found, discard partial cache entries and use
> repo_is_descendant_of() for that candidate.
>
> The branch and for-each-ref path passed repo_is_descendant_of() through
> a Boolean interface. In configurations where it returned -1 for missing
> ancestry, ref-filter treated the error as "contains". The memoized path
> instead fails when ancestry cannot be parsed, as git tag already did.
> During review of the 2018 reachability series, making parse failures
> fatal was explicitly deferred because that series was intended to
> preserve behavior. Unifying the implementations now makes all callers
> fail consistently instead of preserving that accidental Boolean
> interpretation.
>
> The added p1500 case uses up to 8,192 packed refs along one first-parent
> history. It improves from 0.68 to 0.03 seconds.
>
> On a checkout with 62,174 remote-tracking refs, I ran:
>
>     hyperfine --warmup 0 --runs 3 \
>         --command-name parent \
>         '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
>         --command-name this-commit \
>         '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'
>
> The results were:
>
>              parent       this commit
>   elapsed    104.365 s     467.7 ms
>   user        93.702 s     220.2 ms
>   system       0.723 s     182.7 ms
>
> The wall-time standard deviations were 11.356 seconds and 133.8
> milliseconds, respectively, for a 223x speedup. Both commands produced
> output with SHA-256
> 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.
>
> Both revisions were rebuilt with the default -O2 flags using Apple clang
> 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6) with a
> 16-core Apple M4 Max (12 performance and four efficiency cores) and 128
> GB RAM.
>
> Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Karthik.188@gmail.com/
> Link: https://lore.kernel.org/git/20180723204112.233274-1-jonathantanmy@google.com/
> Link: https://lore.kernel.org/git/24424e55-7fa8-d05b-bc39-e14b4d5abcb6@gmail.com/
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  builtin/tag.c                  |  1 -
>  commit-reach.c                 | 45 +++++++++++++++++++++++++++++++-----------
>  commit-reach.h                 | 15 ++++++++++----
>  ref-filter.c                   |  6 ++++--
>  ref-filter.h                   |  7 +++----
>  t/helper/test-reach.c          | 10 ++--------
>  t/perf/p1500-graph-walks.sh    | 24 +++++++++++++++++++++-
>  t/t6301-for-each-ref-errors.sh | 18 +++++++++++++++++
>  t/t6302-for-each-ref-filter.sh | 21 ++++++++++++++++++++
>  t/t6600-test-reach.sh          |  6 ++----
>  10 files changed, 117 insertions(+), 36 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index d51c2e3349..9f34d948d4 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -71,7 +71,6 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
>
>  	if (verify_ref_format(format))
>  		die(_("unable to parse format string"));
> -	filter->with_commit_tag_algo = 1;

We were selectively using the algo for `git tag`, like mentioned I guess
we'll entirely remove `with_commit_tag_algo` below somewhere

>  	filter_and_format_refs(filter, FILTER_REFS_TAGS, sorting, format);
>
>  	free(to_free);
> diff --git a/commit-reach.c b/commit-reach.c
> index 9b3ea46d6f..6e599a3670 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -6,7 +6,6 @@
>  #include "decorate.h"
>  #include "hex.h"
>  #include "prio-queue.h"
> -#include "ref-filter.h"
>  #include "revision.h"
>  #include "tag.h"
>  #include "commit-reach.h"
> @@ -708,7 +707,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
>
>  /*
>   * Test whether the candidate is contained in the list.
> - * Do not recurse to find out, though, but return -1 if inconclusive.
> + * Do not recurse to find out, though, but return CONTAINS_UNKNOWN if
> + * inconclusive.

Okay so the code does return CONTAINS_UNKNOWN which is an enum beginning
at 0, so this makes sense.

>   */
>  static enum contains_result contains_test(struct commit *candidate,
>  					  const struct commit_list *want,
> @@ -743,9 +743,9 @@ static void push_to_contains_stack(struct commit *candidate, struct contains_sta
>  	contains_stack->contains_stack[contains_stack->nr++].parents = candidate->parents;
>  }
>
> -static enum contains_result contains_tag_algo(struct commit *candidate,
> -					      const struct commit_list *want,
> -					      struct contains_cache *cache)
> +static enum contains_result contains_algo(struct commit *candidate,
> +					  struct commit_list *want,
> +					  struct contains_cache *cache)
>  {
>  	struct contains_stack contains_stack = { 0, 0, NULL };
>  	enum contains_result result;
> @@ -765,6 +765,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  	if (result != CONTAINS_UNKNOWN)
>  		return result;
>
> +	*contains_cache_at(cache, candidate) = CONTAINS_IN_PROGRESS;
>  	push_to_contains_stack(candidate, &contains_stack);
>  	while (contains_stack.nr) {
>  		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
> @@ -776,8 +777,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  			contains_stack.nr--;
>  		}
>  		/*
> -		 * If we just popped the stack, parents->item has been marked,
> -		 * therefore contains_test will return a meaningful yes/no.
> +		 * A parent may have just been popped and marked, or may still
> +		 * be active when replacement refs create a cycle.
>  		 */
>  		else switch (contains_test(parents->item, want, cache, cutoff)) {
>  		case CONTAINS_YES:
> @@ -787,21 +788,41 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  		case CONTAINS_NO:
>  			entry->parents = parents->next;
>  			break;
> +		case CONTAINS_IN_PROGRESS:
> +			/*
> +			 * Partial negative answers are not safe across a cycle.
> +			 * Discard them and use the cycle-safe reachability walk.
> +			 */
> +			goto cycle;
>

If I understand this correctly, we now use CONTAINS_IN_PROGRESS to
showcase a commit for which we still don't have a result. Since any
commit with UNKNOWN will start a recursive search through its parents.

So with this if we encounter a CONTAINS_IN_PROGRESS while recursion,
this would indicate that we hit a cyclic graph and so go to the fallback
of using repo_is_descendant_of(). So this avoids an infinite recursion
in such instances. Makes sense.

>  		case CONTAINS_UNKNOWN:
> +			*contains_cache_at(cache, parents->item) =
> +				CONTAINS_IN_PROGRESS;
>  			push_to_contains_stack(parents->item, &contains_stack);
>  			break;
>  		}
>  	}
>  	free(contains_stack.contains_stack);
>  	return contains_test(candidate, want, cache, cutoff);
> +
> +cycle:
> +	free(contains_stack.contains_stack);
> +	clear_contains_cache(cache);
> +	init_contains_cache(cache);
> +
> +	result = repo_is_descendant_of(the_repository, candidate, want);
> +	if (result < 0)
> +		exit(128);
> +	*contains_cache_at(cache, candidate) =
> +		result ? CONTAINS_YES : CONTAINS_NO;
> +	return result ? CONTAINS_YES : CONTAINS_NO;
>  }
>
> -int commit_contains(struct ref_filter *filter, struct commit *commit,
> -		    struct commit_list *list, struct contains_cache *cache)
> +int commit_contains(struct commit *commit, struct commit_list *list,
> +		    struct contains_cache *cache)
>  {
> -	if (filter->with_commit_tag_algo)
> -		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
> -	return repo_is_descendant_of(the_repository, commit, list);
> +	if (!list)
> +		return 1;
> +	return contains_algo(commit, list, cache) == CONTAINS_YES;
>  }
>
>  int can_all_from_reach_with_flag(struct object_array *from,
> diff --git a/commit-reach.h b/commit-reach.h
> index 3f3a563d8a..144dc56275 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -5,7 +5,6 @@
>  #include "commit-slab.h"
>
>  struct commit_list;
> -struct ref_filter;
>  struct object_id;
>  struct object_array;
>
> @@ -73,13 +72,21 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
>  enum contains_result {
>  	CONTAINS_UNKNOWN = 0,
>  	CONTAINS_NO,
> -	CONTAINS_YES
> +	CONTAINS_YES,
> +	CONTAINS_IN_PROGRESS
>  };
>
>  define_commit_slab(contains_cache, enum contains_result);
>
> -int commit_contains(struct ref_filter *filter, struct commit *commit,
> -		    struct commit_list *list, struct contains_cache *cache);
> +/*
> + * Return whether "commit" is a descendant of any commit in "list". An empty
> + * list matches.
> + *
> + * "cache" records answers for one fixed "list". Clear it before changing the
> + * list.
> + */
> +int commit_contains(struct commit *commit, struct commit_list *list,
> +		    struct contains_cache *cache);
>
>  /*
>   * Determine if every commit in 'from' can reach at least one commit
> diff --git a/ref-filter.c b/ref-filter.c
> index 1da4c0e60d..7788147959 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2991,11 +2991,13 @@ static struct ref_array_item *apply_ref_filter(const struct reference *ref,
>  			return NULL;
>  		/* We perform the filtering for the '--contains' option... */
>  		if (filter->with_commit &&
> -		    !commit_contains(filter, commit, filter->with_commit, &filter->internal.contains_cache))
> +		    !commit_contains(commit, filter->with_commit,
> +				     &filter->internal.contains_cache))
>  			return NULL;
>  		/* ...or for the `--no-contains' option */
>  		if (filter->no_commit &&
> -		    commit_contains(filter, commit, filter->no_commit, &filter->internal.no_contains_cache))
> +		    commit_contains(commit, filter->no_commit,
> +				    &filter->internal.no_contains_cache))
>  			return NULL;
>  	}
>
> diff --git a/ref-filter.h b/ref-filter.h
> index 120221b47f..9e14afca9c 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -73,10 +73,9 @@ struct ref_filter {
>  	struct commit_list *reachable_from;
>  	struct commit_list *unreachable_from;
>
> -	unsigned int with_commit_tag_algo : 1,
> -		match_as_path : 1,
> -		ignore_case : 1,
> -		detached : 1;
> +	unsigned int match_as_path : 1,
> +		     ignore_case : 1,
> +		     detached : 1;
>  	unsigned int kind,
>  		lines;
>  	int abbrev,

Nit: With the changes above. I do wish it was split into two commits.
1. Fix cyclic recursions in the algo.
2. Use the algo for all filter types.

> diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
> index 5d86a96c17..82235f713e 100644
> --- a/t/helper/test-reach.c
> +++ b/t/helper/test-reach.c
> @@ -6,7 +6,6 @@
>  #include "gettext.h"
>  #include "hex.h"
>  #include "object-name.h"
> -#include "ref-filter.h"
>  #include "setup.h"
>  #include "string-list.h"
>  #include "tag.h"
> @@ -138,16 +137,11 @@ int cmd__reach(int ac, const char **av)
>
>  		printf("%s(X,_,_,0,0):%d\n", av[1], can_all_from_reach_with_flag(&X_obj, 2, 4, 0, 0));
>  	} else if (!strcmp(av[1], "commit_contains")) {
> -		struct ref_filter filter = REF_FILTER_INIT;
>  		struct contains_cache cache;
>  		init_contains_cache(&cache);
>
> -		if (ac > 2 && !strcmp(av[2], "--tag"))
> -			filter.with_commit_tag_algo = 1;
> -		else
> -			filter.with_commit_tag_algo = 0;
> -
> -		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
> +		printf("%s(_,A,X,_):%d\n", av[1],
> +		       commit_contains(A, X, &cache));
>  		clear_contains_cache(&cache);
>  	} else if (!strcmp(av[1], "get_reachable_subset")) {
>  		const int reachable_flag = 1;

Makes sense.

> diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
> index 5b23ce5db9..ac68fdbacd 100755
> --- a/t/perf/p1500-graph-walks.sh
> +++ b/t/perf/p1500-graph-walks.sh
> @@ -5,6 +5,8 @@ test_description='Commit walk performance tests'
>
>  test_perf_large_repo
>
> +contains_ref_limit=8192
> +
>  test_expect_success 'setup' '
>  	git for-each-ref --format="%(refname)" "refs/heads/*" "refs/tags/*" >allrefs &&
>  	sort -r allrefs | head -n 50 >refs &&
> @@ -32,10 +34,25 @@ test_expect_success 'setup' '
>  		echo "X:$line" >>test-tool-tags || return 1
>  	done &&
>
> +	git rev-list --first-parent --max-count=$contains_ref_limit HEAD >contains-commits &&
> +	contains_ref_count=$(wc -l <contains-commits) &&
> +	test "$contains_ref_count" -gt 0 &&
> +	contains_base=$(tail -n 1 contains-commits) &&
> +	export contains_base &&
> +	awk "{
> +		printf \"update refs/contains-perf/%04d %s\\n\", NR, \$1
> +	}" contains-commits |
> +		git update-ref --stdin &&
> +	git pack-refs --include "refs/contains-perf/*" &&
> +
>  	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
>  	git update-ref refs/heads/disjoint-base $commit &&
>
> -	git commit-graph write --reachable
> +	git commit-graph write --reachable &&
> +
> +	git for-each-ref --contains="$contains_base" \
> +		refs/contains-perf/ >actual &&
> +	test_line_count = $contains_ref_count actual

Shouldn't this be a separate test and not a part of the setup?

>  '
>
>  test_perf 'ahead-behind counts: git for-each-ref' '
> @@ -62,6 +79,11 @@ test_perf 'contains: git tag --merged' '
>  	xargs git tag --merged=HEAD <tags
>  '
>
> +test_perf 'contains: git for-each-ref --contains' '
> +	git for-each-ref --contains="$contains_base" \
> +		refs/contains-perf/ >/dev/null
> +'
> +

Ah! we also have this, so perhaps moving the `test_line_count` here and
dropping it above would be better.

>  test_perf 'is-base check: test-tool reach (refs)' '
>  	test-tool reach get_branch_base_for_tip <test-tool-refs
>  '
> diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
> index e06feb06e9..169cc70c23 100755
> --- a/t/t6301-for-each-ref-errors.sh
> +++ b/t/t6301-for-each-ref-errors.sh
> @@ -52,6 +52,24 @@ test_expect_success 'Missing objects are reported correctly' '
>  	test_must_be_empty brief-err
>  '
>
> +test_expect_success 'missing ancestors are reported by contains filters' '
> +	test_when_finished "git update-ref -d refs/heads/missing-parent" &&
> +	{
> +		echo "tree $(git rev-parse HEAD^{tree})" &&
> +		echo "parent $MISSING" &&
> +		git cat-file commit HEAD |
> +			sed -n -e "/^author /p" -e "/^committer /p" &&
> +		echo &&
> +		echo "missing parent"
> +	} > commit &&
> +	broken=$(git hash-object -t commit -w commit) &&
> +	git update-ref refs/heads/missing-parent "$broken" &&
> +	test_must_fail git for-each-ref --contains=HEAD \
> +		refs/heads/missing-parent >out 2>err &&
> +	test_must_be_empty out &&
> +	test_grep "unable to parse commit $MISSING" err
> +'
> +
>  test_expect_success 'ahead-behind requires an argument' '
>  	test_must_fail git for-each-ref \
>  		--format="%(ahead-behind)" 2>err &&
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 7f060d97bf..423505d1fb 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -177,6 +177,27 @@ test_expect_success 'filtering with --contains and --no-contains' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'contains handles cyclic replacement histories' '
> +	one=$(git rev-parse one) &&
> +	three=$(git rev-parse three) &&
> +	test_when_finished "
> +		git replace -d $one
> +		git replace -d $three
> +		git tag -d cycle-a cycle-b
> +	" &&
> +	git tag cycle-a "$one" &&
> +	git tag cycle-b "$three" &&
> +	git replace --graft "$one" "$three" two &&
> +	git replace --graft "$three" "$one" &&
> +	cat >expect <<-\EOF &&
> +	refs/tags/cycle-a
> +	refs/tags/cycle-b
> +	EOF
> +	git for-each-ref --format="%(refname)" --contains=two \
> +		"refs/tags/cycle-*" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success '%(color) must fail' '
>  	test_must_fail git for-each-ref --format="%(color)%(refname)"
>  '
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index b5b314e570..1ecc2571c2 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -286,8 +286,7 @@ test_expect_success 'commit_contains:hit' '
>  	X:commit-9-3
>  	EOF
>  	echo "commit_contains(_,A,X,_):1" >expect &&
> -	test_all_modes commit_contains &&
> -	test_all_modes commit_contains --tag
> +	test_all_modes commit_contains
>  '
>
>  test_expect_success 'commit_contains:miss' '
> @@ -303,8 +302,7 @@ test_expect_success 'commit_contains:miss' '
>  	X:commit-9-3
>  	EOF
>  	echo "commit_contains(_,A,X,_):0" >expect &&
> -	test_all_modes commit_contains &&
> -	test_all_modes commit_contains --tag
> +	test_all_modes commit_contains
>  '
>
>  test_expect_success 'rev-list: basic topo-order' '
>
> ---
> base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
> change-id: 20260607-ref-filter-memoized-contains-7cb6b3bccad1
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>

Overall the patch looks great. The perf improvements are also very
welcome. Some small nits from me.

Thanks

--000000000000fb099e0653c48d31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 61d6fd7cc8c323a5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vbk1hMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mendxQy80aGpydk94cGNCY0t4MFR0eGhIT2d1ZVk4agpiZWVTS2t2aDNS
eDV0TklmWnNMQzdFZ1krM09EenQvbUh5b1RjWmw2YmF1RVZLNXJJNUEwRjJwMXpQSE9BMjZUClZk
UC9LczRyR2JLaUdHM0FhMWhVZ3JVMmdTV3NnWEVZbktZNjJmU2NEelNhRWovUzh6bkh3M2Q4VEJV
WCtDSkgKdWVQV1lzeHpjV0pQNVJFV2pQMVZCaFNoUC94ZEhsV28yd3RRRy80elhpWmpNeWgzRW42
Q1Q4cXl6aGhoaGMvbwpUWkRyZlEzbHZmbkEzSnZhVEx1NGNaZ2V0cU5ITHhkMmZkZUt4ZW1HQjdT
QVQ0aHhzRWRBWlRSZzF1emZhb2dTClQ5QjN4bDUza045RjZEdHhqS0VGRjZPSndWdjV3UGlhcm9S
NUw0M2JkL3U4a1Bhci9ub09LZ0JzZ1RIUnVLbSsKZERPclFIMThRMlhVcy9MVUhpQnQxNmFjelFx
M1c1TjhyQml4ZndzYmhqOWNhVENwbmxURjV1MkQ5WVNFblFhcApuNy9rYk0xeHR0ZlZNTW51Uk9E
RGFFaXJnM3dOU1NaMk9HN1pneTk0U2VHSzRMTlhob3VUTWJIZmdHT1I5Q1ZICkpTVWdLWGJidzM0
T29pRmlxV1dXRjZIeUUxR2tVSWpzWWxaT0EwRT0KPW5wa3cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fb099e0653c48d31--
