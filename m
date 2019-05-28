Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0797E1F462
	for <e@80x24.org>; Tue, 28 May 2019 21:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfE1VyI (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:54:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34629 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfE1VyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:54:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so152607pfa.1
        for <git@vger.kernel.org>; Tue, 28 May 2019 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJVXoppb65Nyrc9atpcfb8LP4rGwufTAi+eSm3UG+/s=;
        b=PMMhFxh//9YJWkobf+dqFfigljVExighBmoHIe2lbAwQIg/8rI31nxDvv/Lz+0J0Dz
         Ivy3WhF8pP1MiAju4XzTrmoVqtFE89+xATEv/882y0Sj+FoSoYnRRC3z3SzH0v0K4Iz4
         YtdH2UEsaMQUBCW2HwfW1NFEZin9lvxvqvPTWYwcCg38ucHeAD15GGPvcN9LjUlLzeg6
         MF9oOxFnFLo1Pks78ypU7CWW7VAf6/ibrMucwutoVA4MQBntJBae9WCpKUTON2ecLc16
         DlUbab1pRoEL1D+8CoKSoFI8RgZjJHZfmcuqvLuvcJmJrKrbFYOqZP8NnjlWLHzaqNmU
         cZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJVXoppb65Nyrc9atpcfb8LP4rGwufTAi+eSm3UG+/s=;
        b=m2VEyuD0BlpFZ3XCK2UnyMgSfy2/y7X3zXd51CQ+4qK1bj3wA/uUwij99WEUl8l/Mq
         Py8q7EAAsu4JDFM+3JU746u7ycVGGTPHgf0bEeOzEXlrT3Gt5Gx4buCfO8t3Xf5FSqPH
         Y72lTKi+FyFTc/RG9aqL7PCO9E7ITuiVlOOYjfHjHoKRchneq6gJCXcIqUzCXsx1ci9U
         bjX+PnZn05RIgp7yj4RZzlivXnop7B/0fbYORTaGWYI85+AnBk+sKAr44BFbyovoaSrn
         ViFRiQbzPL4OUbgh3f5CmLDbpJXKLBDPCNEnZdo9dMmWk3xvpr5ol1gIecMXZrdbjfd2
         G6Pg==
X-Gm-Message-State: APjAAAV54jdT4YjdVZqDaQAsa2/296ViVtauDxjFrmzM50DPnhz15/Q+
        BPLzEeBdSQz1Snx4kEdS0vEyng==
X-Google-Smtp-Source: APXvYqzCFXfAmL6vVQfrMLGSxrg8YIbu1s2jRHAX0eaZY19r28+PHmXvHuedp0+e7nHzdDt8I1AzuA==
X-Received: by 2002:a65:500d:: with SMTP id f13mr60211586pgo.151.1559080446224;
        Tue, 28 May 2019 14:54:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id h60sm5670770pjb.10.2019.05.28.14.54.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 14:54:05 -0700 (PDT)
Date:   Tue, 28 May 2019 14:53:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, matvore@comcast.net
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190528215359.GB133078@google.com>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 05:21:52PM -0700, Matthew DeVore wrote:
> Allow combining filters such that only objects accepted by all filters
> are shown. The motivation for this is to allow getting directory
> listings without also fetching blobs. This can be done by combining
> blob:none with tree:<depth>. There are massive repositories that have
> larger-than-expected trees - even if you include only a single commit.
> 
> The current usage requires passing the filter to rev-list, or sending
> it over the wire, as:
> 
> 	combine:<FILTER1>+<FILTER2>
> 
> (i.e.: git rev-list --filter=combine:tree:2+blob:limit=32k). This is
> potentially awkward because individual filters must be URL-encoded if
> they contain + or %. This can potentially be improved by supporting a
> repeated flag syntax, e.g.:
> 
> 	$ git rev-list --filter=tree:2 --filter=blob:limit=32k
> 
> Such usage is currently an error, so giving it a meaning is backwards-
> compatible.
> 
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  Documentation/rev-list-options.txt     |  12 ++
>  contrib/completion/git-completion.bash |   2 +-
>  list-objects-filter-options.c          | 161 ++++++++++++++++++++++++-
>  list-objects-filter-options.h          |  14 ++-
>  list-objects-filter.c                  | 114 +++++++++++++++++
>  t/t6112-rev-list-filters-objects.sh    | 159 +++++++++++++++++++++++-
>  6 files changed, 455 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index ddbc1de43f..4fb0c4fbb0 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -730,20 +730,32 @@ specification contained in <path>.
>  +
>  The form '--filter=tree:<depth>' omits all blobs and trees whose depth
>  from the root tree is >= <depth> (minimum depth if an object is located
>  at multiple depths in the commits traversed). <depth>=0 will not include
>  any trees or blobs unless included explicitly in the command-line (or
>  standard input when --stdin is used). <depth>=1 will include only the
>  tree and blobs which are referenced directly by a commit reachable from
>  <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
>  while also including trees and blobs one more level removed from an
>  explicitly-given commit or tree.
> ++
> +The form '--filter=combine:<filter1>+<filter2>+...<filterN>' combines
> +several filters. Only objects which are accepted by every filter are
> +included. Filters are joined by '{plus}' and individual filters are %-encoded
> +(i.e. URL-encoded). Besides the '{plus}' and '%' characters, the following
> +characters are reserved and also must be encoded:
> +`~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+ as well as all characters with ASCII code
> +&lt;= `0x20`, which includes space and newline.
> ++
> +Other arbitrary characters can also be encoded. For instance,
> +'combine:tree:3+blob:none' and 'combine:tree%3A2+blob%3Anone' are
> +equivalent.
>  
>  --no-filter::
>  	Turn off any previous `--filter=` argument.
>  
>  --filter-print-omitted::
>  	Only useful with `--filter=`; prints a list of the objects omitted
>  	by the filter.  Object IDs are prefixed with a ``~'' character.
>  
>  --missing=<missing-action>::
>  	A debug option to help with future "partial clone" development.
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3eefbabdb1..0fd0a10d0c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1529,21 +1529,21 @@ _git_difftool ()
>  __git_fetch_recurse_submodules="yes on-demand no"
>  
>  _git_fetch ()
>  {
>  	case "$cur" in
>  	--recurse-submodules=*)
>  		__gitcomp "$__git_fetch_recurse_submodules" "" "${cur##--recurse-submodules=}"
>  		return
>  		;;
>  	--filter=*)
> -		__gitcomp "blob:none blob:limit= sparse:oid= sparse:path=" "" "${cur##--filter=}"
> +		__gitcomp "blob:none blob:limit= sparse:oid= sparse:path= combine: tree:" "" "${cur##--filter=}"
>  		return
>  		;;
>  	--*)
>  		__gitcomp_builtin fetch
>  		return
>  		;;
>  	esac
>  	__git_complete_remote_or_refspec
>  }
>  
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index e46ea467bc..d7a1516188 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -1,19 +1,24 @@
>  #include "cache.h"
>  #include "commit.h"
>  #include "config.h"
>  #include "revision.h"
>  #include "argv-array.h"
>  #include "list-objects.h"
>  #include "list-objects-filter.h"
>  #include "list-objects-filter-options.h"
>  
> +static int parse_combine_filter(
> +	struct list_objects_filter_options *filter_options,
> +	const char *arg,
> +	struct strbuf *errbuf);
> +
>  /*
>   * Parse value of the argument to the "filter" keyword.
>   * On the command line this looks like:
>   *       --filter=<arg>
>   * and in the pack protocol as:
>   *       "filter" SP <arg>
>   *
>   * The filter keyword will be used by many commands.
>   * See Documentation/rev-list-options.txt for allowed values for <arg>.
>   *
> @@ -31,22 +36,20 @@ static int gently_parse_list_objects_filter(
>  
>  	if (filter_options->choice) {
>  		if (errbuf) {
>  			strbuf_addstr(
>  				errbuf,
>  				_("multiple filter-specs cannot be combined"));
>  		}
>  		return 1;
>  	}
>  
> -	filter_options->filter_spec = strdup(arg);
> -
>  	if (!strcmp(arg, "blob:none")) {
>  		filter_options->choice = LOFC_BLOB_NONE;
>  		return 0;
>  
>  	} else if (skip_prefix(arg, "blob:limit=", &v0)) {
>  		if (git_parse_ulong(v0, &filter_options->blob_limit_value)) {
>  			filter_options->choice = LOFC_BLOB_LIMIT;
>  			return 0;
>  		}
>  
> @@ -74,37 +77,183 @@ static int gently_parse_list_objects_filter(
>  		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
>  					  &sparse_oid, &oc))
>  			filter_options->sparse_oid_value = oiddup(&sparse_oid);
>  		filter_options->choice = LOFC_SPARSE_OID;
>  		return 0;
>  
>  	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
>  		filter_options->choice = LOFC_SPARSE_PATH;
>  		filter_options->sparse_path_value = strdup(v0);
>  		return 0;
> +
> +	} else if (skip_prefix(arg, "combine:", &v0)) {
> +		int sub_parse_res = parse_combine_filter(
> +			filter_options, v0, errbuf);
> +		if (sub_parse_res)
> +			return sub_parse_res;
> +		return 0;

Couldn't the three lines above be said more succinctly as "return
sub_parse_res;"?

> +
>  	}
>  	/*
>  	 * Please update _git_fetch() in git-completion.bash when you
>  	 * add new filters
>  	 */
>  
>  	if (errbuf)
>  		strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
>  
>  	memset(filter_options, 0, sizeof(*filter_options));
>  	return 1;
>  }
>  
> +static int digit_value(int c, struct strbuf *errbuf) {
> +	if (c >= '0' && c <= '9')
> +		return c - '0';
> +	if (c >= 'a' && c <= 'f')
> +		return c - 'a' + 10;
> +	if (c >= 'A' && c <= 'F')
> +		return c - 'A' + 10;

I'm sure there's something I'm missing here. But why are you manually
decoding hex instead of using strtol or sscanf or something?

> +
> +	if (!errbuf)
> +		return -1;
> +
> +	strbuf_addf(errbuf, _("error in filter-spec - "));
> +	if (c)
> +		strbuf_addf(
> +			errbuf,
> +			_("expect two hex digits after %%, but got: '%c'"),
> +			c);
> +	else
> +		strbuf_addf(
> +			errbuf,
> +			_("not enough hex digits after %%; expected two"));
> +
> +	return -1;
> +}
> +
> +static int url_decode(struct strbuf *s, struct strbuf *errbuf) {
> +	char *dest = s->buf;
> +	char *src = s->buf;
> +	size_t new_len;
> +
> +	while (*src) {
> +		int digit_value_0, digit_value_1;
> +
> +		if (src[0] != '%') {
> +			*dest++ = *src++;
> +			continue;
> +		}
> +		src++;
> +
> +		digit_value_0 = digit_value(*src++, errbuf);
> +		if (digit_value_0 < 0)
> +			return 1;
> +		digit_value_1 = digit_value(*src++, errbuf);
> +		if (digit_value_1 < 0)
> +			return 1;
> +		*dest++ = digit_value_0 * 16 + digit_value_1;
> +	}
> +	new_len = dest - s->buf;
> +	strbuf_remove(s, new_len, s->len - new_len);
> +
> +	return 0;
> +}
> +
> +static const char *RESERVED_NON_WS = "~`!@#$^&*()[]{}\\;'\",<>?";
> +
> +static int has_reserved_character(
> +	struct strbuf *sub_spec, struct strbuf *errbuf)
> +{
> +	const char *c = sub_spec->buf;
> +	while (*c) {
> +		if (*c <= ' ' || strchr(RESERVED_NON_WS, *c))
> +			goto found_reserved;
> +		c++;
> +	}
> +
> +	return 0;
> +
> +found_reserved:

What's the value of doing this in a goto instead of embedded in the
while loop?

> +	if (errbuf)
> +		strbuf_addf(errbuf,
> +			    "must escape char in sub-filter-spec: '%c'",
> +			    *c);
> +	return 1;
> +}
> +
> +static int parse_combine_filter(
> +	struct list_objects_filter_options *filter_options,
> +	const char *arg,
> +	struct strbuf *errbuf)
> +{
> +	struct strbuf **sub_specs = strbuf_split_str(arg, '+', 2);
> +	int result;
> +
> +	if (!sub_specs[0]) {
> +		if (errbuf)
> +			strbuf_addf(errbuf,
> +				    _("expected something after combine:"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	result = has_reserved_character(sub_specs[0], errbuf);
> +	if (result)
> +		goto cleanup;
> +
> +	/*
> +	 * Only decode the first sub-filter, since the rest will be decoded on
> +	 * the recursive call.
> +	 */
> +	result = url_decode(sub_specs[0], errbuf);
> +	if (result)
> +		goto cleanup;
> +
> +	if (!sub_specs[1]) {
> +		/*
> +		 * There is only one sub-filter, so we don't need the
> +		 * combine: - just parse it as a non-composite filter.
> +		 */
> +		result = gently_parse_list_objects_filter(
> +			filter_options, sub_specs[0]->buf, errbuf);
> +		goto cleanup;
> +	}
> +
> +	/* Remove trailing "+" so we can parse it. */
> +	assert(sub_specs[0]->buf[sub_specs[0]->len - 1] == '+');
> +	strbuf_remove(sub_specs[0], sub_specs[0]->len - 1, 1);
> +
> +	filter_options->choice = LOFC_COMBINE;
> +	filter_options->lhs = xcalloc(1, sizeof(*filter_options->lhs));
> +	filter_options->rhs = xcalloc(1, sizeof(*filter_options->rhs));
> +
> +	result = gently_parse_list_objects_filter(filter_options->lhs,
> +						  sub_specs[0]->buf,
> +						  errbuf) ||
> +		parse_combine_filter(filter_options->rhs,
> +				      sub_specs[1]->buf,
> +				      errbuf);

I guess you're recursing to combine filter 2 onto filter 1 which has
been combined onto filter 0 here. But why not just use a list or array?

> +
> +cleanup:
> +	strbuf_list_free(sub_specs);
> +	if (result) {
> +		list_objects_filter_release(filter_options);
> +		memset(filter_options, 0, sizeof(*filter_options));
> +	}
> +	return result;
> +}
> +
>  int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
>  			      const char *arg)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> +	filter_options->filter_spec = strdup(arg);
>  	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
>  		die("%s", buf.buf);
>  	return 0;
>  }
>  
>  int opt_parse_list_objects_filter(const struct option *opt,
>  				  const char *arg, int unset)
>  {
>  	struct list_objects_filter_options *filter_options = opt->value;
>  
> @@ -127,23 +276,29 @@ void expand_list_objects_filter_spec(
>  	else if (filter->choice == LOFC_TREE_DEPTH)
>  		strbuf_addf(expanded_spec, "tree:%lu",
>  			    filter->tree_exclude_depth);
>  	else
>  		strbuf_addstr(expanded_spec, filter->filter_spec);
>  }
>  
>  void list_objects_filter_release(
>  	struct list_objects_filter_options *filter_options)
>  {
> +	if (!filter_options)
> +		return;
>  	free(filter_options->filter_spec);
>  	free(filter_options->sparse_oid_value);
>  	free(filter_options->sparse_path_value);
> +	list_objects_filter_release(filter_options->lhs);
> +	free(filter_options->lhs);
> +	list_objects_filter_release(filter_options->rhs);
> +	free(filter_options->rhs);

Is there a reason that the free shouldn't be included in
list_objects_filter_release()? Maybe this is a common style guideline
I've missed, but it seems to me like I'd expect a magic memory cleanup
function to do it all, and not leave it to me to free.

>  	memset(filter_options, 0, sizeof(*filter_options));
>  }
>  
>  void partial_clone_register(
>  	const char *remote,
>  	const struct list_objects_filter_options *filter_options)
>  {
>  	/*
>  	 * Record the name of the partial clone remote in the
>  	 * config and in the global variable -- the latter is
> @@ -171,14 +326,16 @@ void partial_clone_register(
>  }
>  
>  void partial_clone_get_default_filter_spec(
>  	struct list_objects_filter_options *filter_options)
>  {
>  	/*
>  	 * Parse default value, but silently ignore it if it is invalid.
>  	 */
>  	if (!core_partial_clone_filter_default)
>  		return;
> +
> +	filter_options->filter_spec = strdup(core_partial_clone_filter_default);
>  	gently_parse_list_objects_filter(filter_options,
>  					 core_partial_clone_filter_default,
>  					 NULL);
>  }
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index e3adc78ebf..6c0f0ecd08 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -7,20 +7,21 @@
>  /*
>   * The list of defined filters for list-objects.
>   */
>  enum list_objects_filter_choice {
>  	LOFC_DISABLED = 0,
>  	LOFC_BLOB_NONE,
>  	LOFC_BLOB_LIMIT,
>  	LOFC_TREE_DEPTH,
>  	LOFC_SPARSE_OID,
>  	LOFC_SPARSE_PATH,
> +	LOFC_COMBINE,
>  	LOFC__COUNT /* must be last */
>  };
>  
>  struct list_objects_filter_options {
>  	/*
>  	 * 'filter_spec' is the raw argument value given on the command line
>  	 * or protocol request.  (The part after the "--keyword=".)  For
>  	 * commands that launch filtering sub-processes, or for communication
>  	 * over the network, don't use this value; use the result of
>  	 * expand_list_objects_filter_spec() instead.
> @@ -32,28 +33,35 @@ struct list_objects_filter_options {
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
>  	char *sparse_path_value;
>  	unsigned long blob_limit_value;
>  	unsigned long tree_exclude_depth;
> +
> +	/* LOFC_COMBINE values */
> +	struct list_objects_filter_options *lhs, *rhs;
> +
> +	/*
> +	 * END choice-specific parsed values.
> +	 */
>  };
>  
>  /* Normalized command line arguments */
>  #define CL_ARG__FILTER "filter"
>  
>  int parse_list_objects_filter(
>  	struct list_objects_filter_options *filter_options,
>  	const char *arg);
>  
>  int opt_parse_list_objects_filter(const struct option *opt,
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 8e8616b9b8..b97277a46f 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -453,34 +453,148 @@ static void filter_sparse_path__init(
>  
>  	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
>  	d->array_frame[d->nr].defval = 0; /* default to include */
>  	d->array_frame[d->nr].child_prov_omit = 0;
>  
>  	ctx->filter_fn = filter_sparse;
>  	ctx->free_fn = filter_sparse_free;
>  	ctx->data = d;
>  }
>  
> +struct filter_combine_data {
> +	/* sub[0] corresponds to lhs, sub[1] to rhs. */

Jeff H had a comment about this too, but this seems unwieldy for >2
filters. (I also personally don't like using set index to incidate
lhs/rhs.) Why not an array of multiple `struct sub`? There's a macro
utility to generate types and helpers for an array of arbitrary struct
that may suit...

> +	struct {
> +		struct filter_context ctx;
> +		struct oidset seen;
> +		struct object_id skip_tree;
> +		unsigned is_skipping_tree : 1;
> +	} sub[2];
> +
> +	struct oidset rhs_omits;
> +};
> +
> +static void add_all(struct oidset *dest, struct oidset *src) {
> +	struct oidset_iter iter;
> +	struct object_id *src_oid;
> +
> +	oidset_iter_init(src, &iter);
> +	while ((src_oid = oidset_iter_next(&iter)) != NULL)
> +		oidset_insert(dest, src_oid);
> +}
> +
> +static void filter_combine_free(void *filter_data)
> +{
> +	struct filter_combine_data *d = filter_data;
> +	int i;
> +
> +	/* Anything omitted by rhs should be added to the overall omits set. */
> +	if (d->sub[0].ctx.omits)
> +		add_all(d->sub[0].ctx.omits, d->sub[1].ctx.omits);
> +
> +	for (i = 0; i < 2; i++) {
> +		list_objects_filter__release(&d->sub[i].ctx);
> +		oidset_clear(&d->sub[i].seen);
> +	}
> +	oidset_clear(&d->rhs_omits);
> +	free(d);
> +}
> +
> +static int should_delegate(enum list_objects_filter_situation filter_situation,
> +			   struct object *obj,
> +			   struct filter_combine_data *d,
> +			   int side)
> +{
> +	if (!d->sub[side].is_skipping_tree)
> +		return 1;
> +	if (filter_situation == LOFS_END_TREE &&
> +		oideq(&obj->oid, &d->sub[side].skip_tree)) {
> +		d->sub[side].is_skipping_tree = 0;
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static enum list_objects_filter_result filter_combine(
> +	struct repository *r,
> +	enum list_objects_filter_situation filter_situation,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	struct filter_context *ctx)
> +{
> +	struct filter_combine_data *d = ctx->data;
> +	enum list_objects_filter_result result[2];
> +	enum list_objects_filter_result combined_result = LOFR_ZERO;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {

I suppose your lhs and rhs are in sub[0] and sub[1] in part for the sake
of this loop. But I think it would be easier to understand what is going
on if you were to perform the loop contents in a helper function (as the
name of the function would provide some more documentation).

> +		if (oidset_contains(&d->sub[i].seen, &obj->oid) ||
> +			!should_delegate(filter_situation, obj, d, i)) {
> +			result[i] = LOFR_ZERO;
> +			continue;
> +		}
> +
> +		result[i] = d->sub[i].ctx.filter_fn(
> +			r, filter_situation, obj, pathname, filename,
> +			&d->sub[i].ctx);
> +
> +		if (result[i] & LOFR_MARK_SEEN)
> +			oidset_insert(&d->sub[i].seen, &obj->oid);
> +
> +		if (result[i] & LOFR_SKIP_TREE) {
> +			d->sub[i].is_skipping_tree = 1;
> +			d->sub[i].skip_tree = obj->oid;
> +		}
> +	}
> +
> +	if ((result[0] & LOFR_DO_SHOW) && (result[1] & LOFR_DO_SHOW))
> +		combined_result |= LOFR_DO_SHOW;
> +	if (d->sub[0].is_skipping_tree && d->sub[1].is_skipping_tree)
> +		combined_result |= LOFR_SKIP_TREE;
> +
> +	return combined_result;
> +}

I see that you tested that >2 filters works okay. But by doing it the
way you have it seems like you're setting up to need recursion all over
the place to check against all the filters. I suppose I don't see the
benefit of doing all this recursively, as compared to doing it
iteratively.

 - Emily
