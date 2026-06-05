Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB151862A
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667354; cv=none; b=FtiZKzFuYNb45g9QXhRAxkRneBXEhkyymswhY5AoRXY25MgDEhitEHAzFRa1UB3G/nWZX5rVJ8NzbNLX6oUdOg4g2bb+ukTX48yGdUd41G676qmATPBeCvIaPrisrAsqNMeo8wo31yuQfEY/QWFt9gOZYOZq7Prh23Th+CMLl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667354; c=relaxed/simple;
	bh=N/3lrk8gMu2/2CYPuYgge8axW/257qPsodWT/CxNGb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9zMZ9cOByh1vt3BBe2Tr9gFJ21O6fadQSJgBYSsDakBnwGQIS59fvy3H4CfPYzYSchJK+kc30J8vO/mUJsL8rzSOo9f7owY6hatTmb+M5XMtQ5Nu5st3nNvMB6vGLeoxvWdp/PYr9b7en0Oy6cF0o3Swr69u0R9wmjvymT9OcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc61YSLF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc61YSLF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ee6d32402so1081654f8f.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 06:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780667349; x=1781272149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBH+yudApMKiTLr/woegsdS6HwPNn4Z66p/yPluuCeA=;
        b=Lc61YSLFkYTEEyRPwK92D+d9jBGKUcudWqRG/63CNGH8cLH8r/VYJB2UpF7zWcw3u6
         WZPn91apjrbkVqHlV7VXWuOMBqmlbe6GSNkSNQPQwSTvdGLBVgcBn/WfSjrog48iD0wf
         dLsKd8elsRPgGL1NlV52exMPbSGBPcvjmGBxjQpHDZCH6+ud8wRWnBh0KdKIkicFFD3m
         Il1LaL6bgs9sg1zlaUF/NGFNWEjqu6r+foqhGwJlE3SowuGGjp2QRSjlHpPAf+VkiFvy
         pVy7c49RNqNlk++vWAbKnoXAB0TNiFrE8DMqFWGaC4+rLMet22z2bLIYOBkq88kIHWsz
         wBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667349; x=1781272149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBH+yudApMKiTLr/woegsdS6HwPNn4Z66p/yPluuCeA=;
        b=Iu56Bfmv+tqITW6mUndtM92J6DNkdkAAgeoTfyLxBXd9w8liy6zVuqAfXsHL9j5Un7
         t4RFpV4Ys3LrLhNmVvjlHMRI8yQSs+6WGThyw5CKv7nGx4CwUmDyluold0H23eci3IMh
         cwtOE+eT57EPIvxg83zIDLAzAaGpfOPJjThHxaUalgI54pceu1FX2u4HRCGTBmDL0Goh
         7WaAoWTLMwK0bhBkDXACF7Uc9lLQNn6nKLArveF1MopXX8xzIn0WsQkX5gLiFcAmVh/3
         Tf0e74XqzJC2ByN9UTbUUYEjvhx26A39di+X/S7ZG8cKePeN8pSoAUOdrAS9nigB5Ao0
         yK1A==
X-Forwarded-Encrypted: i=1; AFNElJ8C8aPXOoJPiDrSGb2CKuOXepT/hD+QprRVG9kUVHsdo9SXWQ2ka3KG8l6MxoyrpYbP30E=@vger.kernel.org
X-Gm-Message-State: AOJu0YziaEOHMqQG8mt2e04FTKGoLrn5UfK3eEahBtyJtFuRvpYx6yXS
	+J+na+8cS7Dw8mPBstdMNP6wjfJKhhbqvLLsf+o08d+UMIUcLyw5l8nD
X-Gm-Gg: Acq92OH5ZS0SdBOHI4LtgKJpgcVZUrAZdRcfhxEADCDDj5UVCV16K0eHxyFEEaeajme
	yeyJtlPgC+j6Nxo5fJeiBkVPHyM5ZBsMqsB4QsqHukTnN8MfHU6YH6O1VJGRg0fFUKhyhH1R7Nx
	0D9pGSIyEygYvoYcAUjEoEY/BqU65ODkNMtHp1Q+5RGS6/0MNck8I92WWsejN/8YwQNsGNNJwex
	vvPnjiWdA5r5P1BHjRtu5qOiwTcD9wQUJgjttQMMuSBOr4JhgTIG4eoTK69H8BxS+9R3lSFsG//
	Vzn3IjHtKljvDlQNSe/Dm1DjH6tZc2YOpj7NFZOn5l+Eg222+NDgtDDXaODPo7BQNmj07w/kNvq
	5SWfqFrRd0m0THuF54fZ9vqF0Vqj/TX5fbDjo01Ex6gmr37B7WIlhYPvVQz7P4XnWfZC8UYjCBJ
	BcXezkAINWZjvAqAqeU5qKQntHRmdBafxBKe24BPOD8juvTTGhMfhK8tWYYf6vtsE4ZGb46NvYM
	rWDHsjdngSpug==
X-Received: by 2002:adf:f250:0:b0:45e:f271:5019 with SMTP id ffacd0b85a97d-46030506f41mr4563137f8f.14.1780667348628;
        Fri, 05 Jun 2026 06:49:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm13259621f8f.32.2026.06.05.06.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:49:07 -0700 (PDT)
Message-ID: <9f5c36a9-a3b8-403d-9c59-40367eb895bd@gmail.com>
Date: Fri, 5 Jun 2026 14:48:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v12 1/6] branch: add --forked filter for --list mode
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
 <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
 <8834c424fbd27800636fe21ae73e9cdce75b558a.1780477479.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8834c424fbd27800636fe21ae73e9cdce75b558a.1780477479.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 03/06/2026 10:04, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a --forked option to "git branch" list mode that keeps only
> branches whose configured upstream matches <branch>. The argument
> can be a ref (e.g. "origin/main", "master") or a shell-style
> glob (e.g. "origin/*"). The option can be repeated to widen the
> filter.

Do we want to support a remote name as an alias for $remote/HEAD to 
match "git checkout -b $remote"?

> Because it is a filter on list mode, --forked composes with the
> existing list-mode filters, so
> 
>      git branch --merged origin/main --forked 'origin/*'
> 
> lists branches forked from origin that have already been
> integrated into origin/main, and --no-merged inverts the question.

Nice
> This is the building block for --prune-merged, which deletes the
> listed branches once they have landed on their upstream.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   Documentation/git-branch.adoc |   7 ++
>   builtin/branch.c              | 147 +++++++++++++++++++++++++++++++++-
>   ref-filter.c                  |  10 +--
>   ref-filter.h                  |   2 +
>   t/t3200-branch.sh             |  92 +++++++++++++++++++++
>   5 files changed, 249 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
> index c0afddc424..8002d7f38c 100644
> --- a/Documentation/git-branch.adoc
> +++ b/Documentation/git-branch.adoc
> @@ -14,6 +14,7 @@ git branch [--color[=<when>] | --no-color] [--show-current]
>   	   [--merged [<commit>]] [--no-merged [<commit>]]
>   	   [--contains [<commit>]] [--no-contains [<commit>]]
>   	   [--points-at <object>] [--format=<format>]
> +	   [(--forked <branch>)...]

Should this come before --format? I think it logically belongs with 
--merged and --contains which also filter the output.

>   	   [(-r|--remotes) | (-a|--all)]
>   	   [--list] [<pattern>...]
>   git branch [--track[=(direct|inherit)] | --no-track] [-f]
> @@ -199,6 +200,12 @@ This option is only applicable in non-verbose mode.
>   	Print the name of the current branch. In detached `HEAD` state,
>   	nothing is printed.
>   
> +`--forked <branch>`::
> +	List only branches whose configured upstream matches
> +	_<branch>_. The argument can be a ref (e.g. `origin/main`,
> +	`master`) or a shell-style glob (e.g. `'origin/*'`). The
> +	option can be repeated to widen the filter.

This is fine but do we want to add a sentence to the DESCRIPTION as well 
where it talks about "--contains" and "--merged"?

>   `-v`::
>   `-vv`::
>   `--verbose`::
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 1572a4f9ef..12711b29cf 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -28,9 +28,10 @@
>   #include "help.h"
>   #include "advice.h"
>   #include "commit-reach.h"
> +#include "wildmatch.h"
>   
>   static const char * const builtin_branch_usage[] = {
> -	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
> +	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
>   	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
>   	N_("git branch [<options>] [-l] [<pattern>...]"),
>   	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
> @@ -442,8 +443,12 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>   	return strbuf_detach(&fmt, NULL);
>   }
>   
> +static void filter_array_by_forked(struct ref_array *array,
> +				   const struct string_list *upstreams);

We try to avoid forward declarations unless they're really needed - can 
we add the new functions up here instead?

>   static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
> -			   struct ref_format *format, struct string_list *output)
> +			   struct ref_format *format, struct string_list *output,
> +			   const struct string_list *forked_upstreams)
>   {
>   	int i;
>   	struct ref_array array;
> @@ -463,6 +468,9 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>   
>   	filter_refs(&array, filter, filter->kind);
>   
> +	if (forked_upstreams->nr)
> +		filter_array_by_forked(&array, forked_upstreams);

This gets a bit messy below where free elements when we filter "array". 
It would be much nicer to do the filtering in apply_ref_filter() so that 
we don't have to allocate those in the first place. I think it would 
make it simpler to implement --prune-merged as collect_forked_set() 
would become a call to filter_refs() and we could support --forked in 
"git for-each-ref".

> +static int parse_one_forked_arg(const char *arg, struct upstream_pattern *out)
> +{
> +	struct object_id oid;
> +	char *full_ref = NULL;
> +
> +	if (has_glob_specials(arg)) {
> +		out->name = xstrdup(arg);
> +		out->is_wildcard = 1;
> +		return 0;
> +	}
> +
> +	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
> +			  &full_ref, 0) == 1 &&
> +	    (starts_with(full_ref, "refs/heads/") ||
> +	     starts_with(full_ref, "refs/remotes/"))) {
> +		out->name = xstrdup(short_upstream_name(full_ref));

I don't think abbreviating the refname here is a good idea as short 
names are inherently ambiguous - in principle you could have a remote 
tracking branch and a local branch with the same short name. It also 
means we end up reconstructing the full name in a later patch, instead 
we should just call short_upstream_name() where we need the abbreviated 
name.

> +static int upstream_matches(const char *short_upstream,
> +			    const struct upstream_pattern *patterns,
> +			    size_t nr)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < nr; i++) {
> +		const struct upstream_pattern *p = &patterns[i];
> +		if (p->is_wildcard) {
> +			if (!wildmatch(p->name, short_upstream, WM_PATHNAME))
> +				return 1;
> +		} else if (!strcmp(p->name, short_upstream)) {
> +			return 1;
> +		}
> +	}

This is quadratic but maybe we can assume the user wont pass "--forked" 
too many times. If this ever becomes a problem we could use an strset 
for the exact matches and then we only need to loop over the wildmatch 
patterns but we probably don't need to worry about that now.

> +static int branch_upstream_matches(const char *full_refname,
> +				   const struct upstream_pattern *patterns,
> +				   size_t nr_patterns)
> +{
> +	const char *short_name;
> +	struct branch *branch;
> +	const char *upstream;
> +
> +	if (!skip_prefix(full_refname, "refs/heads/", &short_name))
> +		return 0;
> +	branch = branch_get(short_name);
> +	if (!branch)
> +		return 0;
> +	upstream = branch_get_upstream(branch, NULL);
> +	if (!upstream)
> +		return 0;
> +	return upstream_matches(short_upstream_name(upstream),

This would be simpler if we matched on full names.

> +static void filter_array_by_forked(struct ref_array *array,
> +				   const struct string_list *upstreams)
> +{
> +	struct upstream_pattern *patterns = NULL;
> +	size_t nr_patterns = 0;
> +	int i, kept = 0;
> +
> +	parse_forked_args(upstreams, &patterns, &nr_patterns);
> +
> +	for (i = 0; i < array->nr; i++) {
> +		struct ref_array_item *item = array->items[i];
> +		if (branch_upstream_matches(item->refname,
> +					    patterns, nr_patterns))
> +			array->items[kept++] = item;
> +		else
> +			free_ref_array_item(item);
> +	}
> +	array->nr = kept;

As I said above this would be nicer if it was implemented in 
apply_ref_filter().

> @@ -714,6 +847,7 @@ int cmd_branch(int argc,
>   	/* possible actions */
>   	int delete = 0, rename = 0, copy = 0, list = 0,
>   	    unset_upstream = 0, show_current = 0, edit_description = 0;
> +	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;

Personally I'd use a strvec here as we don't need the "util" member of 
the string list but I'm probably biased as I don't really like the 
string list api.

I like the idea of making this just another filter to "--list". The 
basics of the implementation look reasonable - it should be straight 
forward to match on full refs and move the relavent code into filter-refs.c

Thanks

Phillip

>   	const char *new_upstream = NULL;
>   	int noncreate_actions = 0;
>   	/* possible options */
> @@ -767,6 +901,8 @@ int cmd_branch(int argc,
>   		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
>   		OPT_BOOL(0, "edit-description", &edit_description,
>   			 N_("edit the description for the branch")),
> +		OPT_STRING_LIST(0, "forked", &forked_upstreams, N_("branch"),
> +			N_("list local branches whose upstream matches <branch> (repeatable)")),
>   		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>   		OPT_MERGED(&filter, N_("print only branches that are merged")),
>   		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
> @@ -815,7 +951,8 @@ int cmd_branch(int argc,
>   		list = 1;
>   
>   	if (filter.with_commit || filter.no_commit ||
> -	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
> +	    filter.reachable_from || filter.unreachable_from ||
> +	    filter.points_at.nr || forked_upstreams.nr)
>   		list = 1;
>   
>   	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
> @@ -880,7 +1017,8 @@ int cmd_branch(int argc,
>   		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>   		ref_sorting_set_sort_flags_all(
>   			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
> -		print_ref_list(&filter, sorting, &format, &output);
> +		print_ref_list(&filter, sorting, &format, &output,
> +			       &forked_upstreams);
>   		print_columns(&output, colopts, NULL);
>   		string_list_clear(&output, 0);
>   		ref_sorting_release(sorting);
> @@ -1020,5 +1158,6 @@ int cmd_branch(int argc,
>   
>   out:
>   	string_list_clear(&sorting_options, 0);
> +	string_list_clear(&forked_upstreams, 0);
>   	return ret;
>   }
> diff --git a/ref-filter.c b/ref-filter.c
> index 1da4c0e60d..65e7bc6785 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3035,7 +3035,7 @@ static int filter_one(const struct reference *ref, void *cb_data)
>   }
>   
>   /*  Free memory allocated for a ref_array_item */
> -static void free_array_item(struct ref_array_item *item)
> +void free_ref_array_item(struct ref_array_item *item)
>   {
>   	free((char *)item->symref);
>   	if (item->value) {
> @@ -3078,7 +3078,7 @@ static int filter_and_format_one(const struct reference *ref, void *cb_data)
>   
>   	strbuf_release(&output);
>   	strbuf_release(&err);
> -	free_array_item(item);
> +	free_ref_array_item(item);
>   
>   	/*
>   	 * Increment the running count of refs that match the filter. If
> @@ -3098,7 +3098,7 @@ void ref_array_clear(struct ref_array *array)
>   	int i;
>   
>   	for (i = 0; i < array->nr; i++)
> -		free_array_item(array->items[i]);
> +		free_ref_array_item(array->items[i]);
>   	FREE_AND_NULL(array->items);
>   	array->nr = array->alloc = 0;
>   
> @@ -3171,7 +3171,7 @@ static void reach_filter(struct ref_array *array,
>   		if (is_merged == include_reached)
>   			array->items[array->nr++] = array->items[i];
>   		else
> -			free_array_item(item);
> +			free_ref_array_item(item);
>   	}
>   
>   	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
> @@ -3667,7 +3667,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
>   
>   	strbuf_release(&err);
>   	strbuf_release(&output);
> -	free_array_item(ref_item);
> +	free_ref_array_item(ref_item);
>   }
>   
>   static int parse_sorting_atom(const char *atom)
> diff --git a/ref-filter.h b/ref-filter.h
> index 120221b47f..3883b9dc62 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -155,6 +155,8 @@ void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
>   			    struct ref_format *format);
>   /*  Clear all memory allocated to ref_array */
>   void ref_array_clear(struct ref_array *array);
> +/*  Free a single item from a ref_array */
> +void free_ref_array_item(struct ref_array_item *item);
>   /*  Used to verify if the given format is correct and to parse out the used atoms */
>   int verify_ref_format(struct ref_format *format);
>   /*  Sort the given ref_array as per the ref_sorting provided */
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e7829c2c4b..4e7deddc04 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1717,4 +1717,96 @@ test_expect_success 'errors if given a bad branch name' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--forked: setup' '
> +	test_create_repo forked-upstream &&
> +	test_commit -C forked-upstream base &&
> +	git -C forked-upstream branch one base &&
> +	git -C forked-upstream branch two base &&
> +
> +	test_create_repo forked-other &&
> +	test_commit -C forked-other other-base &&
> +	git -C forked-other branch foreign other-base &&
> +
> +	git clone forked-upstream forked &&
> +	git -C forked remote add other ../forked-other &&
> +	git -C forked fetch other &&
> +	git -C forked branch local-base &&
> +	git -C forked branch --track local-one origin/one &&
> +	git -C forked branch --track local-two origin/two &&
> +	git -C forked branch --track local-foreign other/foreign &&
> +	git -C forked branch detached &&
> +	git -C forked branch --track local-trunk local-base
> +'
> +
> +test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
> +	git -C forked branch --forked origin/one --format="%(refname:short)" >actual &&
> +	echo local-one >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked <glob> filters by wildmatch' '
> +	git -C forked branch --forked "origin/*" --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-one
> +	local-two
> +	main
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked <local-branch> matches branches with local upstream' '
> +	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
> +	echo local-trunk >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked can be repeated to widen the filter' '
> +	git -C forked branch --forked origin/one --forked other/foreign --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-foreign
> +	local-one
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked combines literal and glob arguments' '
> +	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-foreign
> +	local-trunk
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
> +	git -C forked branch --forked "*/*" --format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-foreign
> +	local-one
> +	local-two
> +	main
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked composes with --no-merged' '
> +	test_when_finished "git -C forked checkout detached" &&
> +	git -C forked checkout local-one &&
> +	test_commit -C forked local-only &&
> +	git -C forked branch --forked "origin/*" --no-merged origin/one \
> +		--format="%(refname:short)" >actual &&
> +	echo local-one >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked rejects unknown branch/pattern' '
> +	test_must_fail git -C forked branch --forked nope 2>err &&
> +	test_grep "not a valid branch or pattern" err
> +'
> +
> +test_expect_success '--forked requires a value' '
> +	test_must_fail git -C forked branch --forked 2>err &&
> +	test_grep "requires a value" err
> +'
> +
>   test_done

