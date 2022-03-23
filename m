Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C975C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343737AbiCWUMp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiCWUMo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:12:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0426CA5E
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:11:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so2627953plg.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ac3ycxSXE0Q6o2Caea9ac0fNmOGVbbi0BXcXYpwM+5w=;
        b=HsbTq9+xKgZC+ZrSKt/CTjk2kPWKmJC0qo7s5Ub6LI09RsqKqXZLRQpNQfiGVYtkm0
         sOGjig9wx6RPH4TMfb9lq2khRiDmLOSwUQXC0e6qacGJQZCnUVyhSOgIBeIB9g/qM83p
         9w++pB+XJrZ0cW9Q3SJhGih+noYwHfn7WtCNCQffvNRIVEJ5o/nA/ERTsDiPHS9AoYz6
         2Vk61XnzLE7Zg7rKZ11mCvNliO6S+1Wd5LvZ3QnUmdp0ozUajU8RIHecazGCXkWOqUHK
         p1ytEjHbDiqG4TcpBy3V/0obx1HsQPO9URH9p5NTGS/nsEXZieQ5EtrS3popuNo5PhxS
         t3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ac3ycxSXE0Q6o2Caea9ac0fNmOGVbbi0BXcXYpwM+5w=;
        b=L6XMldk2hhzabslFJmAvDif4lnXBJxXsBAoSyL9ZUCJuOVgvi6oQQ75Geuyt1coExr
         LvaFn4024+QvFSUAakDdUJBfwFI1VFpUs6ZtA3Jtr/xO9MKAIMypPEvRzeZHELkPB8GM
         1g6H0zTv+FWFdcMm3zziSoKjKUDFCT7tttEU9wwDatVlLX5FpS9VjRiAYtWkpthPe9MV
         eIOxiYX/9mDzMlkPHYy29IDUfqAR2lZxtZx54kLN2lRLML4NLnZ+fNciQWqg5IERZ1Je
         Mk8rqk8ndVQb2Hq1zUkDMSNXQ98nn3wk2Rs0dltlyCYU+HVHsqfK2OCj2pnYuv9+L6i8
         Lttg==
X-Gm-Message-State: AOAM5301xkOs5gsa+fZ43oRm4B9jX8NAw3URm6KCtMxzf/Y4dIylbHdD
        LIbtAyAg1CIW2icLIrdQ0bFIzOfh/FYJ
X-Google-Smtp-Source: ABdhPJwE3y3uH5RBcKuSmbuJP74hUtIEw99vUuqlBqn+eXCUQK4eC+VjdIMoTng/cTeGzIVTfaK5pw==
X-Received: by 2002:a17:902:7d93:b0:14d:d401:f59b with SMTP id a19-20020a1709027d9300b0014dd401f59bmr1885323plm.14.1648066271744;
        Wed, 23 Mar 2022 13:11:11 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id ml16-20020a17090b361000b001c6c9141b0csm485315pjb.45.2022.03.23.13.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 13:11:11 -0700 (PDT)
Message-ID: <fcfdcbb9-761a-0d34-7d36-61e0ef279922@github.com>
Date:   Wed, 23 Mar 2022 13:11:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     lessleydennington@gmail.com, gitster@pobox.com
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:
> prepare_repo_settings() initializes a `struct repository` with various
> default config options and settings read from a repository-local config
> file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
> in git repos), prepare_repo_settings was changed to issue a BUG() if it
> is called by a process whose CWD is not a Git repository. This approach
> was suggested in [1].
> 
> This breaks fuzz-commit-graph, which attempts to parse arbitrary
> fuzzing-engine-provided bytes as a commit graph file.
> commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> since we run the fuzz tests without a valid repository, we are hitting
> the BUG() from 44c7e62 for every test case.
> 
> Fix this by refactoring prepare_repo_settings() such that it sets
> default options unconditionally; if its process is in a Git repository,
> it will also load settings from the local config. This eliminates the
> need for a BUG() when not in a repository.
> 

I think the decision of whether to go with this approach or the alternative
listed below depends on the validity of a 'repository' without a gitdir. 

As far as I can tell, there is an implicit conflict between the changes in:

1. b66d84756f (commit-graph: respect 'commitGraph.readChangedPaths',
   2020-09-09)
2. 44c7e62e51 (repo-settings: prepare_repo_settings only in git repos,
   2021-12-06) (as you pointed out in your message)

The former says that commit-graph should use a repository setting (implying
it needs a valid repository), and the latter says that you need a valid
gitdir to get repository settings.

So to me, how to proceed depends on whether a repository can be "valid"
without a gitdir or not:

* If it is valid (or not-completely-broken/semi-valid - i.e., not a BUG()),
  then your approach is probably fine - the 'BUG()' should be removed from
  'prepare_repo_settings()'. But, to make sure we don't run into this
  question again, 'prepare_repo_settings()' should be audited for any
  settings/setup that implicitly require a gitdir and updated accordingly,
  along with a comment somewhere saying that the 'gitdir' isn't required.
* If it is not valid, then this use in 'fuzz-commit-graph' tests is fragile
  (even if it's not a problem right now) - 'prepare_repo_settings()' could
  start needing the gitdir, or "the_hash_algo" could become invalid, or some
  other problem could arise from the invalid repo and the tests would break.

I don't have a good answer to this question, but someone with more
experience in this area might be able to help.

> Concerns:
> 
> Are any callers strictly dependent on having a BUG() here? I suspect
> that the worst that would happen is that rather than this BUG(), the
> caller would later hit its own BUG() or die(), so I do not think this is
> a blocker. Additionally, every builtin that directly calls
> prepare_repo_settings is either marked as RUN_SETUP, which means we
> would die() prior to calling it anyway, or checks on its own before
> calling it (builtin/diff.c). There are several callers in library code,
> though, and I have not tracked down how all of those are used.
> 
> Alternatives considered:
> 
> Setting up a valid repository for fuzz testing would avoid triggering
> this bug, but would unacceptably slow down the test cases.
> 
> Refactoring parse_commit_graph() in such a way that the fuzz test has an
> alternate entry point that avoids calling prepare_repo_settings() might
> be possible, but would be a much larger change than this one. It would
> also run the risk that the changes would be so extensive that the fuzzer
> would be merely testing its own custom commit-graph implementation,
> rather than the one that's actually used in the real world.
> 

If the 'repository' really is *completely* invalid without a gitdir, I don't
think the refactor of 'commit-graph.c' would necessarily be too bad -
certainly not so extensive that it's not testing "real world" behavior:

* Make 'parse_commit_graph()' only call 'prepare_repo_settings()' if the
  repo has a valid gitdir (guarded like 'git diff' is)
* Guard all use use of 'r' in 'parse_commit_graph()' based on the existence
  of 'gitdir', with fallbacks on e.g. global config settings. From what I
  can see, the only usage is:
    * The check for 'r->settings.commit_graph_read_changed_paths'
    * The call to 'get_configured_generation_version()'
    * The use of 'the_hash_algo->raw_sz'

> [1]: https://lore.kernel.org/git/xmqqcznh8913.fsf@gitster.g/
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  repo-settings.c | 111 ++++++++++++++++++++++++------------------------
>  1 file changed, 55 insertions(+), 56 deletions(-)
> 
> diff --git a/repo-settings.c b/repo-settings.c
> index b4fbd16cdc..d154b37007 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -17,9 +17,6 @@ void prepare_repo_settings(struct repository *r)
>  	char *strval;
>  	int manyfiles;
>  
> -	if (!r->gitdir)
> -		BUG("Cannot add settings for uninitialized repository");
> -
>  	if (r->settings.initialized++)
>  		return;
>  
> @@ -28,27 +25,63 @@ void prepare_repo_settings(struct repository *r)
>  	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
>  	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
>  
> -	/* Booleans config or default, cascades to other settings */
> -	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
> -	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
> +	if (r->gitdir) {
> +		/* Booleans config or default, cascades to other settings */
> +		repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
> +		repo_cfg_bool(r, "feature.experimental", &experimental, 0);
>  
> -	/* Defaults modified by feature.* */
> -	if (experimental) {
> -		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
> -	}
> -	if (manyfiles) {
> -		r->settings.index_version = 4;
> -		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
> -	}
> +		/* Defaults modified by feature.* */
> +		if (experimental) {
> +			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
> +		}
> +		if (manyfiles) {
> +			r->settings.index_version = 4;
> +			r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
> +		}
> +
> +		/* Boolean config or default, does not cascade (simple)  */
> +		repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
> +		repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
> +		repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
> +		repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
> +		repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
> +		repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
> +		repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
>  
> -	/* Boolean config or default, does not cascade (simple)  */
> -	repo_cfg_bool(r, "core.commitgraph", &r->settings.core_commit_graph, 1);
> -	repo_cfg_bool(r, "commitgraph.readchangedpaths", &r->settings.commit_graph_read_changed_paths, 1);
> -	repo_cfg_bool(r, "gc.writecommitgraph", &r->settings.gc_write_commit_graph, 1);
> -	repo_cfg_bool(r, "fetch.writecommitgraph", &r->settings.fetch_write_commit_graph, 0);
> -	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
> -	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
> -	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
> +		/*
> +		 * Non-boolean config
> +		 */
> +		if (!repo_config_get_int(r, "index.version", &value))
> +			r->settings.index_version = value;
> +
> +		if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
> +			int v = git_parse_maybe_bool(strval);
> +
> +			/*
> +			 * If it's set to "keep", or some other non-boolean
> +			 * value then "v < 0". Then we do nothing and keep it
> +			 * at the default of UNTRACKED_CACHE_KEEP.
> +			 */
> +			if (v >= 0)
> +				r->settings.core_untracked_cache = v ?
> +					UNTRACKED_CACHE_WRITE : UNTRACKED_CACHE_REMOVE;
> +			free(strval);
> +		}
> +
> +		if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
> +			int fetch_default = r->settings.fetch_negotiation_algorithm;
> +			if (!strcasecmp(strval, "skipping"))
> +				r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
> +			else if (!strcasecmp(strval, "noop"))
> +				r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
> +			else if (!strcasecmp(strval, "consecutive"))
> +				r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
> +			else if (!strcasecmp(strval, "default"))
> +				r->settings.fetch_negotiation_algorithm = fetch_default;
> +			else
> +				die("unknown fetch negotiation algorithm '%s'", strval);
> +		}
> +	}
>  
>  	/*
>  	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
> @@ -60,40 +93,6 @@ void prepare_repo_settings(struct repository *r)
>  	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
>  		r->settings.core_multi_pack_index = 1;
>  
> -	/*
> -	 * Non-boolean config
> -	 */
> -	if (!repo_config_get_int(r, "index.version", &value))
> -		r->settings.index_version = value;
> -
> -	if (!repo_config_get_string(r, "core.untrackedcache", &strval)) {
> -		int v = git_parse_maybe_bool(strval);
> -
> -		/*
> -		 * If it's set to "keep", or some other non-boolean
> -		 * value then "v < 0". Then we do nothing and keep it
> -		 * at the default of UNTRACKED_CACHE_KEEP.
> -		 */
> -		if (v >= 0)
> -			r->settings.core_untracked_cache = v ?
> -				UNTRACKED_CACHE_WRITE : UNTRACKED_CACHE_REMOVE;
> -		free(strval);
> -	}
> -
> -	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
> -		int fetch_default = r->settings.fetch_negotiation_algorithm;
> -		if (!strcasecmp(strval, "skipping"))
> -			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
> -		else if (!strcasecmp(strval, "noop"))
> -			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
> -		else if (!strcasecmp(strval, "consecutive"))
> -			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
> -		else if (!strcasecmp(strval, "default"))
> -			r->settings.fetch_negotiation_algorithm = fetch_default;
> -		else
> -			die("unknown fetch negotiation algorithm '%s'", strval);
> -	}
> -
>  	/*
>  	 * This setting guards all index reads to require a full index
>  	 * over a sparse index. After suitable guards are placed in the
> 
> base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7

