Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19AF1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDRVDD (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:03:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40682 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbeDRVDC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:03:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so8376454wrc.7
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZajtS4cXXvOFKkbDiAwH/iLfx5t7Zkv9njAWCLVmuz4=;
        b=lAr8YPlrEMatjlCkUYudGZR0xL4Co0z2mo+cdPsIKqrK0SkKDBfnWO9J7jZjr952aO
         xLGxBD9zirCexgnQBxrJgWixD89iHnvEz7xr3DYkgUiN/WrSMdhINed2CHcq9zfBXlHq
         F0trQA1wxlZHXhGFuqwuwfcb26wh0T4dxwCYVGCg8hNDJlo259v6qr1sZykKG/Q0Dz3s
         9Fe9/Vnk8RHdloHE7uAfkVI5s4LUlvRrnFvG808qtQoWNMn/sPeb++Klp+RV84ng+/FH
         ozu0N+nACj8Dm2NeNvrtc5kKo9xkXkm4ux7BIFQq8HQJeUri0zLyuk3bk+IWWqnUun5G
         F3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ZajtS4cXXvOFKkbDiAwH/iLfx5t7Zkv9njAWCLVmuz4=;
        b=rmAZsXz2Icws6ppONc+K1XFofXSvuSdgx+J2wtDqIHtnDRV33QsfZW3FzASxzuwtYj
         LotsYiqYXrFfgovxBYP7tzdklKvPS0YyezkY0InihbeJ832PbQ6a/GW2svLZdqDytQyE
         5GIDirfq3+W5WixvDo7lraf38+2w9/9pKlVPIcFCDnHF2GHLQkiuiJ98HPOd2q/rqCgx
         PXh5llA9rqiNWtlEkBaV60w3/yEMroOzNhAlXwkDHDZRq2KdmEo9ALL/N8rUYaJHg5AQ
         cP2OsiFctxDtbEEwCGvZQDB/IULJ+dOPy+jK0qgqNaO3S7FY0rHtBi1PReosR4m5p9AW
         W0xA==
X-Gm-Message-State: ALQs6tAIGAeKuHm/Ar+4pKebjpmHpuyV0D7NTaBXlr2s2Ggc7lJNcHp7
        kQAE7bBM1XYH1TvHtCW8jA73Mlrl
X-Google-Smtp-Source: AIpwx48BUyJaazH+gwuKAIdLBSrFFmZUJj3nT7AdJtpoSui49S14YGNHU+kYVB+gghlHi809QN4ExA==
X-Received: by 2002:adf:d1cc:: with SMTP id m12-v6mr2120277wri.214.1524085381462;
        Wed, 18 Apr 2018 14:03:01 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id 58-v6sm4120032wrv.41.2018.04.18.14.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:03:00 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff\@peff.net" <peff@peff.net>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 5/9] ref-filter: use generation number for --contains
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-6-dstolee@microsoft.com>
Date:   Wed, 18 Apr 2018 23:02:59 +0200
In-Reply-To: <20180417170001.138464-6-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 17 Apr 2018 17:00:27 +0000")
Message-ID: <86r2ncgrcs.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here I can offer only the cursory examination, as I don't know this area
of code in question.

Derrick Stolee <dstolee@microsoft.com> writes:

> A commit A can reach a commit B only if the generation number of A
> is larger than the generation number of B. This condition allows
> significantly short-circuiting commit-graph walks.
>
> Use generation number for 'git tag --contains' queries.
>
> On a copy of the Linux repository where HEAD is containd in v4.13
> but no earlier tag, the command 'git tag --contains HEAD' had the
> following peformance improvement:
>
> Before: 0.81s
> After:  0.04s
> Rel %:  -95%

A question: what is the performance after if the "commit-graph" feature
is disabled, or there is no commit-graph file?  Is there performance
regression in this case, or is the difference negligible?

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  ref-filter.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index cffd8bf3ce..e2fea6d635 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1587,7 +1587,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
>  /*
>   * Test whether the candidate or one of its parents is contained in the list.
                                 ^^^^^^^^^^^^^^^^^^^^^

Sidenote: when examining the code after the change, I have noticed that
the above part of commit header for the comtains_test() function is no
longer entirely correct, as the function only checks the candidate
commit, and in no place it access its parents.

But that is not your problem.

>   * Do not recurse to find out, though, but return -1 if inconclusive.
>   */
>  static enum contains_result contains_test(struct commit *candidate,
>  					  const struct commit_list *want,
> -					  struct contains_cache *cache)
> +					  struct contains_cache *cache,
> +					  uint32_t cutoff)
>  {
>  	enum contains_result *cached = contains_cache_at(cache, candidate);
>  
> @@ -1603,6 +1604,10 @@ static enum contains_result contains_test(struct commit *candidate,
>  
>  	/* Otherwise, we don't know; prepare to recurse */
>  	parse_commit_or_die(candidate);
> +
> +	if (candidate->generation < cutoff)
> +		return CONTAINS_NO;
> +

Looks good to me.

The only [minor] question may be whether to define separate type for
generation numbers, and whether to future proof the tests - though the
latter would be almost certainly overengineering, and the former
probablt too.

>  	return CONTAINS_UNKNOWN;
>  }
>  
> @@ -1618,8 +1623,18 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  					      struct contains_cache *cache)
>  {
>  	struct contains_stack contains_stack = { 0, 0, NULL };
> -	enum contains_result result = contains_test(candidate, want, cache);
> +	enum contains_result result;
> +	uint32_t cutoff = GENERATION_NUMBER_INFINITY;
> +	const struct commit_list *p;
> +
> +	for (p = want; p; p = p->next) {
> +		struct commit *c = p->item;
> +		parse_commit_or_die(c);
> +		if (c->generation < cutoff)
> +			cutoff = c->generation;
> +	}

Sholdn't the above be made conditional on the ability to get generation
numbers from the commit-graph file (feature is turned on and file
exists)?  Otherwise here after the change contains_tag_algo() now parses
each commit in 'want', which I think was not done previously.

With commit-graph file parsing is [probably] cheap.  Without it, not
necessary.

But I might be worrying about nothing.

>  
> +	result = contains_test(candidate, want, cache, cutoff);

Other than the question about possible performace regression if
commit-graph data is not available, it looks good to me.

>  	if (result != CONTAINS_UNKNOWN)
>  		return result;
>  
> @@ -1637,7 +1652,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  		 * If we just popped the stack, parents->item has been marked,
>  		 * therefore contains_test will return a meaningful yes/no.
>  		 */
> -		else switch (contains_test(parents->item, want, cache)) {
> +		else switch (contains_test(parents->item, want, cache, cutoff)) {
>  		case CONTAINS_YES:
>  			*contains_cache_at(cache, commit) = CONTAINS_YES;
>  			contains_stack.nr--;
> @@ -1651,7 +1666,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
>  		}
>  	}
>  	free(contains_stack.contains_stack);
> -	return contains_test(candidate, want, cache);
> +	return contains_test(candidate, want, cache, cutoff);

Simple change. It looks good to me.

>  }
>  
>  static int commit_contains(struct ref_filter *filter, struct commit *commit,
