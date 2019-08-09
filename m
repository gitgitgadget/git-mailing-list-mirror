Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B011F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406240AbfHILO4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:14:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42997 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHILO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 07:14:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so6792046qtp.9
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v2fEeX2D2JX6Y6iaayNaUgjjBCCuF+vx1cmtlFL7pMY=;
        b=kGhpx1h9x8bHcLTT3/sSFukEEnkchquzvcaR4IWK5Ks3ApVCDSM+yncbZJ7YQ/ueAf
         o11WyUlm3FfkcHhCORIc4g8WllKj73H4vSRW3JlQNU1kbXQH5cMdvZCE75oc1lqiwxm4
         ZhihMCxA+sNV+4O7v6lkKmxT8ZNOjRlYnjR1FN+C3aimJjylxVh0OxrxP1Lrk4CvcqC7
         gJQG7u/OlVPr2rc8Sfg6yoScqQyymbkDr7M+8gFc8+ijp7qQsI6Vzo1iOCm55NU+qjEU
         WNjatGu11cAEdqOZkJWf4gsjXnG7PPJ5R9f3yMMSoMC6YTvDo1VL6khBp6c0bPV0pMNQ
         VAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2fEeX2D2JX6Y6iaayNaUgjjBCCuF+vx1cmtlFL7pMY=;
        b=srO5kWjs2SI7eAxc3Hk37b7wZD7obipSETqu2gLotBxrFqhORadwCtJS3o7BLTNtO/
         MQcFqbCnFvGXzv0NabWqLbnv2H5wtFI+TiCQv3q6QpE6+enSoJWQ2WOPH74597bLcS89
         JJ5u8H9iAs+itfwObnlzpf+5JFZOJ9hdMFAplc6TKIDouNfubgG2zZ7d6pxHSYmlg4I9
         0v/6W7tpTm8x2dVdtN2cEXnAsRe36JVlyQ2JKeMMJtXYRSPoB2T1J9dq7s/yKSfptmDt
         +0bXrf+Q2RFOaBhlQHykVrMCJjb6G2VASZMgad85MS8W8QGOtl1LMCotarnbKDwjdFwA
         vmsw==
X-Gm-Message-State: APjAAAV8zvlTsBPnacIfmmxT7+9+vIi9l3YuW+W8L2DxQkGz0aYYbsDr
        TzX8C4V0fZ2PLMJhapbFarnn1A==
X-Google-Smtp-Source: APXvYqzJ74H1AyMO05OAYuixP+JzzAOXBHwrogh5NTvbQ1B/YuL/thmhdRllWZVRegDLFp9UyxtU1A==
X-Received: by 2002:a0c:9807:: with SMTP id c7mr17279711qvd.26.1565349294813;
        Fri, 09 Aug 2019 04:14:54 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id i8sm5267415qkm.46.2019.08.09.04.14.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 04:14:54 -0700 (PDT)
Date:   Fri, 9 Aug 2019 07:14:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reload .gitattributes after patching it
Message-ID: <20190809111452.GA93559@syl.local>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809100217.427178-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, Aug 09, 2019 at 10:02:17AM +0000, brian m. carlson wrote:
> When applying multiple patches with git am, or when rebasing using the
> am backend, it's possible that one of our patches has updated a
> gitattributes file. Currently, we cache this information, so if a
> file in a subsequent patch has attributes applied, the file will be
> written out with the attributes in place as of the time we started the
> rebase or am operation, not with the attributes applied by the previous
> patch. This problem does not occur when using the -m or -i flags to
> rebase.

Ah. Thanks for a description of the issue.

> To ensure we write the correct data into the working tree, expire the
> cache after each patch that touches a path ending in ".gitattributes".

OK, that seems like a sensible direction...

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  apply.c           | 11 +++++++++++
>  convert.c         |  9 ++++++++-
>  convert.h         |  6 ++++++
>  t/t3400-rebase.sh | 23 +++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index cde95369bb..b959b88b8e 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4643,6 +4643,7 @@ static int apply_patch(struct apply_state *state,
>  	struct patch *list = NULL, **listp = &list;
>  	int skipped_patch = 0;
>  	int res = 0;
> +	int flush_attributes = 0;
>
>  	state->patch_input_file = filename;
>  	if (read_patch_file(&buf, fd) < 0)
> @@ -4670,6 +4671,14 @@ static int apply_patch(struct apply_state *state,
>  			patch_stats(state, patch);
>  			*listp = patch;
>  			listp = &patch->next;
> +
> +			if (!flush_attributes && patch->new_name) {
> +				char *dummy = strip_path_suffix(patch->new_name, GITATTRIBUTES_FILE);

It's a shame that 'strip_path_suffix' doesn't take a 'char *out', and
accept NULL for that (which would save us the assignment and subsequent
'free'). In either case, this is certainly the appropriate function.

But, I'm not sure if 'dummy' is the best name for this variable or not.
My first thought was that I'd expect this to be named 'suffix' (or the
less descriptive 'p'), but I don't know if the change is warranted.
What *are* we supposed to call this variable?
"path_after_gitattributes" ;-)?

> +				/* The patch applied to a .gitattributes file. */
> +				if (dummy)
> +					flush_attributes = 1;
> +				free(dummy);
> +			}
>  		}
>  		else {
>  			if (state->apply_verbosity > verbosity_normal)
> @@ -4746,6 +4755,8 @@ static int apply_patch(struct apply_state *state,
>  	if (state->summary && state->apply_verbosity > verbosity_silent)
>  		summary_patch_list(list);
>
> +	if (flush_attributes)
> +		reset_parsed_attributes();
>  end:
>  	free_patch_list(list);
>  	strbuf_release(&buf);
> diff --git a/convert.c b/convert.c
> index 94ff837649..030e9b81b9 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1293,10 +1293,11 @@ struct conv_attrs {
>  	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
>  };
>
> +static struct attr_check *check;
> +
>  static void convert_attrs(const struct index_state *istate,
>  			  struct conv_attrs *ca, const char *path)
>  {
> -	static struct attr_check *check;
>  	struct attr_check_item *ccheck = NULL;
>
>  	if (!check) {
> @@ -1339,6 +1340,12 @@ static void convert_attrs(const struct index_state *istate,
>  		ca->crlf_action = CRLF_AUTO_INPUT;
>  }
>
> +void reset_parsed_attributes(void)
> +{
> +	attr_check_free(check);
> +	check = NULL;
> +}
> +

Makes sense.

>  int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
>  {
>  	struct conv_attrs ca;
> diff --git a/convert.h b/convert.h
> index 831559f10d..3710969d43 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -94,6 +94,12 @@ void convert_to_git_filter_fd(const struct index_state *istate,
>  int would_convert_to_git_filter_fd(const struct index_state *istate,
>  				   const char *path);
>
> +/*
> + * Reset the internal list of attributes used by convert_to_git and
> + * convert_to_working_tree.
> + */
> +void reset_parsed_attributes(void);
> +
>  /*****************************************************************
>   *
>   * Streaming conversion support
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 80b23fd326..062dc41df7 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -301,6 +301,29 @@ test_expect_success 'rebase --am and --show-current-patch' '
>  	)
>  '
>
> +test_expect_success 'rebase --am and .gitattributes' '
> +	test_create_repo attributes &&
> +	(
> +		cd attributes &&
> +		test_commit init &&
> +		test_config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
> +		test_config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
> +
> +		test_commit second &&
> +		git checkout -b test HEAD^ &&
> +
> +		echo "*.txt filter=test" >.gitattributes &&
> +		git add .gitattributes &&
> +		test_commit third &&
> +
> +		echo "This text is smudged." >a.txt &&
> +		git add a.txt &&
> +		test_commit fourth &&
> +		git rebase master &&
> +		grep "smudged" a.txt
> +	)
> +'
> +

This definitely exercise the behavior here. Thanks for adding a test
while you're at it.

>  test_expect_success 'rebase--merge.sh and --show-current-patch' '
>  	test_create_repo conflict-merge &&
>  	(

I wouldn't be opposed to renaming 'dummy' to be something else, but in
the case that you don't feel a re-roll is necessary, please consider my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
