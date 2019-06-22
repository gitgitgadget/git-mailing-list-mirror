Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C071F461
	for <e@80x24.org>; Sat, 22 Jun 2019 00:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFVA0c (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 20:26:32 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49428 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfFVA0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 20:26:31 -0400
Received: by mail-vk1-f202.google.com with SMTP id o202so3056007vko.16
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=syWJA7ivaybXCyir31+qK6yShExm4Rq6nF2cjz1r/Fs=;
        b=vZ36E9J5Hw+sYqoJSQJe8IFrhwGnqhniJCDvQz7aUyVg+KgnKrbmouoZEpMKgLBiRe
         g8Jdk5r2ZOsjkv65KiHkDuMEGwKpDMCdDPGFyjuACI0Wky5S6Az6tbDre0zUJrHCQupm
         Xzpa3LWoPFAyKKP0BdoJRMHwWL3Q2RzxErEhltt3zWLRefKdlb75tRskEngAlIDrnLvX
         dT4PLfP6Cze8T3+GtflNcOOkWkkXnGybHiKayBBsj4BFTtmqpWzF97rUbY6mAwSvS5bH
         QlBbOY1dslgpA5YVchS5iFkZCTYlIA/gdhMxlb2hq0dhKOx4oUGSwCCCDtJz/2JUqO4I
         ufHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=syWJA7ivaybXCyir31+qK6yShExm4Rq6nF2cjz1r/Fs=;
        b=dz2CgiMCiKG9ZTzIuL53CZpnc2B7NSac9cHfoFIXXq8qv6Lp55nja6p2jI94Kpgm4V
         prfMt8iZx3tIxGDQnN8RCOBpCAto8r4etiYBuuRbCqv9DvnzlOSdHtJtQ127t+np2EmB
         DhPbSTQyVYKhEEgj+/gpArA0yZRqCGtokHhI1epTlhyytDHYAUY9t6ma+vGDXCQ3JKoy
         JQeZ2n75NY8Z/CShfUBFhMtM6BWguINv26XO0lO/AchE6oXuqCOlGDhUGifwqiIkM2en
         55J4RxrAqWW3BcMMhtt0dubm7OqKM9pW0iGE8eBdFQqbPI/xSCAY41PoezXyce1x9Uo5
         qhFw==
X-Gm-Message-State: APjAAAWdTC92DwHGu5+3dTHU7bgmkZEhpnIFEEivmpHSISgrX/F40WhV
        mx5gkpA4vfyWsQlJG/tHV8cKjvkffSKdpQso4EI5
X-Google-Smtp-Source: APXvYqwfd+O5BMMS0ErWUTTNcO5rVAyVhpU2IIgiPcH7+wli7zwGi0qsLhJBhM1EADr/JaQPPcFvFWfL8miIpAvxgUeh
X-Received: by 2002:a1f:20f:: with SMTP id 15mr10674249vkc.15.1561163190082;
 Fri, 21 Jun 2019 17:26:30 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:26:26 -0700
In-Reply-To: <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com>
Message-Id: <20190622002626.245441-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <47a2680875e6f68fbf1f2e5a5a2630d263cdf426.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: [PATCH v4 04/10] list-objects-filter: implement composite filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Allow combining filters such that only objects accepted by all filters
> are shown. The motivation for this is to allow getting directory
> listings without also fetching blobs. This can be done by combining
> blob:none with tree:<depth>. There are massive repositories that have
> larger-than-expected trees - even if you include only a single commit.

First of all, patches 2 and 3 are straightforward and LGTM. On to patch
4...

[snip]

> The current usage requires passing the filter to rev-list in the
> following form:
> 
> 	--filter=<FILTER1> --filter=<FILTER2> ...
> 
> Such usage is currently an error, so giving it a meaning is backwards-
> compatible.
> 
> The URL-encoding scheme is being introduced before the repeated flag
> logic, and the user-facing documentation for URL-encoding is being
> withheld until the repeated flag feature is implemented. The
> URL-encoding is in general not meant to be used directly by the user,
> and it is better to describe the URL-encoding feature in terms of the
> repeated flag.

As of this commit, we don't support such arguments passed to rev-list in
this way, so I would write these paragraphs as:

  A combined filter supports any number of subfilters, and is written in
  the following form:

    combine:<filter 1>+<filter 2>+<filter 3>

  Certain non-alphanumeric characters in each filter must be
  URL-encoded.

  For now, combined filters must be specified in this form. In a
  subsequent commit, rev-list will support multiple --filter arguments
  which will have the same effect as specifying one filter argument
  starting with "combine:".

> Helped-by: Emily Shaffer <emilyshaffer@google.com>
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  list-objects-filter-options.c       | 106 ++++++++++++++++++-
>  list-objects-filter-options.h       |  17 ++-
>  list-objects-filter.c               | 159 ++++++++++++++++++++++++++++
>  t/t6112-rev-list-filters-objects.sh | 151 +++++++++++++++++++++++++-
>  url.c                               |   6 ++
>  url.h                               |   8 ++
>  6 files changed, 441 insertions(+), 6 deletions(-)
> 
> @@ -28,22 +34,20 @@ static int gently_parse_list_objects_filter(
>  	struct strbuf *errbuf)
>  {
>  	const char *v0;
>  
>  	if (filter_options->choice) {
>  		strbuf_addstr(
>  			errbuf, _("multiple filter-specs cannot be combined"));
>  		return 1;
>  	}
>  
> -	filter_options->filter_spec = strdup(arg);
> -

This line has been removed from gently_parse_list_objects_filter()
because this function gains another caller that does not need it.
To compensate, this line has been added to both its existing callers.

> @@ -31,27 +32,37 @@ struct list_objects_filter_options {
>  	 * the filtering algorithm to use.
>  	 */
>  	enum list_objects_filter_choice choice;
>  
>  	/*
>  	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
>  	 */
>  	unsigned int no_filter : 1;
>  
>  	/*
> -	 * Parsed values (fields) from within the filter-spec.  These are
> -	 * choice-specific; not all values will be defined for any given
> -	 * choice.
> +	 * BEGIN choice-specific parsed values from within the filter-spec. Only
> +	 * some values will be defined for any given choice.
>  	 */
> +
>  	struct object_id *sparse_oid_value;
>  	unsigned long blob_limit_value;
>  	unsigned long tree_exclude_depth;
> +
> +	/* LOFC_COMBINE values */
> +
> +	/* This array contains all the subfilters which this filter combines. */
> +	size_t sub_nr, sub_alloc;
> +	struct list_objects_filter_options *sub;
> +
> +	/*
> +	 * END choice-specific parsed values.
> +	 */
>  };

I still think it's cleaner to just have a "left subfilter" and "right
subfilter", but I don't feel strongly about it. In any case, this is an
internal detail and can always be changed in the future.

> +	/*
> +	 * Optional. If this function is supplied and the filter needs to
> +	 * collect omits, then this function is called once before free_fn is
> +	 * called.
> +	 */
> +	void (*finalize_omits_fn)(struct oidset *omits, void *filter_data);

This is needed because a combined filter's omits actually lie in the
subfilters. Resolving it this way means that callers must call
list_objects_filter__free() before using the omits set. Can you add
documentation to __init() (which is the first function to take in the
omits set) and __free() describing this?

(As stated in the test below, we cannot just share one omits set amongst
all the subfilters - see filter_trees_update_omits and the call site
that relies on its return value.)

Here comes the tricky part...

> +static int should_delegate(enum list_objects_filter_situation filter_situation,
> +			   struct object *obj,
> +			   struct subfilter *sub)
> +{
> +	if (!sub->is_skipping_tree)
> +		return 1;
> +	if (filter_situation == LOFS_END_TREE &&
> +		oideq(&obj->oid, &sub->skip_tree)) {
> +		sub->is_skipping_tree = 0;
> +		return 1;
> +	}
> +	return 0;
> +}

Optional: I think this should be called "test_and_set_skip_tree" or
something like that, made to return the inverse of its current return
value, and documented:

  Returns the value of sub->is_skipping_tree at the moment of
  invocation. If iteration is at the LOFS_END_TREE of the tree currently
  being skipped, first clears sub->is_skipping_tree before returning.

> +static enum list_objects_filter_result process_subfilter(
> +	struct repository *r,
> +	enum list_objects_filter_situation filter_situation,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	struct subfilter *sub)
> +{
> +	enum list_objects_filter_result result;
> +
> +	/*
> +	 * Check should_delegate before oidset_contains so that
> +	 * is_skipping_tree gets unset even when the object is marked as seen.
> +	 * As of this writing, no filter uses LOFR_MARK_SEEN on trees that also
> +	 * uses LOFR_SKIP_TREE, so the ordering is only theoretically
> +	 * important. Be cautious if you change the order of the below checks
> +	 * and more filters have been added!
> +	 */
> +	if (!should_delegate(filter_situation, obj, sub))
> +		return LOFR_ZERO;
> +	if (oidset_contains(&sub->seen, &obj->oid))
> +		return LOFR_ZERO;
> +
> +	result = list_objects_filter__filter_object(
> +		r, filter_situation, obj, pathname, filename, sub->filter);
> +
> +	if (result & LOFR_MARK_SEEN)
> +		oidset_insert(&sub->seen, &obj->oid);
> +
> +	if (result & LOFR_SKIP_TREE) {
> +		sub->is_skipping_tree = 1;
> +		sub->skip_tree = obj->oid;
> +	}
> +
> +	return result;
> +}

Looks good.

> +static enum list_objects_filter_result filter_combine(
> +	struct repository *r,
> +	enum list_objects_filter_situation filter_situation,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	struct oidset *omits,
> +	void *filter_data)
> +{
> +	struct combine_filter_data *d = filter_data;
> +	enum list_objects_filter_result combined_result =
> +		LOFR_DO_SHOW | LOFR_MARK_SEEN | LOFR_SKIP_TREE;
> +	size_t sub;
> +
> +	for (sub = 0; sub < d->nr; sub++) {
> +		enum list_objects_filter_result sub_result = process_subfilter(
> +			r, filter_situation, obj, pathname, filename,
> +			&d->sub[sub]);
> +		if (!(sub_result & LOFR_DO_SHOW))
> +			combined_result &= ~LOFR_DO_SHOW;
> +		if (!(sub_result & LOFR_MARK_SEEN))
> +			combined_result &= ~LOFR_MARK_SEEN;
> +		if (!d->sub[sub].is_skipping_tree)
> +			combined_result &= ~LOFR_SKIP_TREE;
> +	}
> +
> +	return combined_result;
> +}

And also looks good. Might be confusing for tree skipping to be
communicated through is_skipping_tree instead of the return value, but
is_skipping_tree needs to be set anyway for other reasons, so that's
convenient.
