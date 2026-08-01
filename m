Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E6326928
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599622; cv=none; b=S3Hy9QmzNHn+Zdl77BXrLxMJr9sPZr1FlKcTgfarRRLz/5CX6XVfFUht2R3a9hef4wS9fPBwOnffU9nUG7hd3Pl8izgCX5pegK6K1fbAASuZe39jK1P5JwPZoyZZBJeLrGsfkatNVe5a/0oDRvKUH0hRbbnZqKOxjFyDU3AYs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599622; c=relaxed/simple;
	bh=TW5QNs7Z+DGOQht4YImLweO7N6n/FJgC43KKsn4oxrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAebnvbTqED8itbnsAbd45sEEBVno5KNhpN/2kB4EMO1eiHj+n1unhtfu+N3p+85i7x0bfX5ycc5FyiYXisJUa3GmWPFu1zN/z9ZBQXexFlSQBae06RYc1ApzQJsEtrwf6UO0+o/eaCWvW7ST/Vkjvupytxynk+wkdyxppbXWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=INH99cQ1; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=iC6fvUVS; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="INH99cQ1";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="iC6fvUVS"
DKIM-Signature: a=rsa-sha256; b=INH99cQ1PlidhH6JZJ0226CqzFVVLbjXOoJ3UdPUfHYjj39ppclIBaty3RGCfW9DqRqF+V+WEQgIBbXgXJDbUVRK1mkTsqrrk2hCxZ5eATlsuQ0xwGO/TwPR5vYWZAzmnIS7dOqLoV3ykAyptaYE5+673+xcdl1IJ10hxvfSqlzesDoqd7u001fGjGUVNvb3yBnUfM8jTNeKLlg/IxjWrz84AK+fNDoPi3Ufhs6n1n5/4K4huV+dPX7sSdEta8YeLQkVe6vvq6lwlreEwcP+roSD4sZTKa33dXWIX1HvNJ+VGZa/3KVAC0lY7xjXo8Lce7WAN/pg8AB90xS4uMkZ1A==; s=purelymail1; d=malon.dev; v=1; bh=TW5QNs7Z+DGOQht4YImLweO7N6n/FJgC43KKsn4oxrc=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=iC6fvUVSAbOpingJYi9sz0L/kEh/M9L0HLyySj4LARfmpume4LsuAaj3TmrFoa8HQt1Y0nPvj1CgvGIPUHcAc0SkE1I/KCgADRlytEUz7Meupb+lAd8BFnyqreU2NTFC3NucgvPY/qc09Bpsjfup/Oq5JOajSQggaMxXjh3+PjqrVnzZ7WlnNpbaF30oUkf6xqk4x7uc7Qv0zukonzYnl0eBFzd+QeQTI+h0CHo2/7fUDPM7kt2Hc2zSql6py5SrnguLTDW+bzMy09tQEloqwayfcIvF0P4peGJMlNLXDbSpuUrMWogReePbQrfL/mLNpZdQ+cy0ExWWAC1/IaZAqA==; s=purelymail1; d=purelymail.com; v=1; bh=TW5QNs7Z+DGOQht4YImLweO7N6n/FJgC43KKsn4oxrc=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2019824003;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 01 Aug 2026 15:53:32 +0000 (UTC)
Message-ID: <e9e36105-7a77-4e5f-8d75-7b160e1d7095@malon.dev>
Date: Sat, 1 Aug 2026 23:53:24 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] repository: move fetch_if_missing into struct
 repository
Content-Language: en-US
To: git@vger.kernel.org
Cc: ps@pks.im, five231003@gmail.com, hariom18599@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260715011850.3181131-1-cat@malon.dev>
 <20260716072954.582235-1-cat@malon.dev>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260716072954.582235-1-cat@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 15:29, Tian Yuchen wrote:
> The global variable 'fetch_if_missing' controls whether a missing
> object check should prompt a lazy fetch from a promisor remote.
> In order to continue the libification effort, move it into
> 'struct repository' and initialize it to 1 by default to keep the
> previous behavior.
> 
> Note that in builtin/fsck.c and builtin/index-pack.c, when running
> related commands with the '-h' parameter, the 'repo' pointer is not
> passed in. To prevent null pointer dereferences, we defer
> operations on the repo until after parameter parsing is complete.
> 
> Additionally, update the partial clone documentation to reflect
> that this is now a per-repository flag.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
> 
> Change since V1:
> 
> - Following Patrick's advice, use the_repository whenever possible
>    without re-introducing #define USE_THE_REPOSITORY_VARIABLE.
> 
>   Documentation/technical/partial-clone.adoc |  2 +-
>   builtin/fetch-pack.c                       |  2 +-
>   builtin/fsck.c                             |  6 +++---
>   builtin/index-pack.c                       |  7 ++++---
>   builtin/pack-objects.c                     | 14 +++++++-------
>   builtin/prune.c                            |  2 +-
>   builtin/rev-list.c                         | 10 +++++-----
>   git.c                                      |  2 +-
>   midx-write.c                               |  2 +-
>   odb.c                                      |  4 +---
>   odb.h                                      |  8 --------
>   repository.c                               |  1 +
>   repository.h                               |  6 ++++++
>   revision.c                                 |  2 +-
>   setup.c                                    |  2 +-
>   15 files changed, 34 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
> index e513e391ea..18718a3840 100644
> --- a/Documentation/technical/partial-clone.adoc
> +++ b/Documentation/technical/partial-clone.adoc
> @@ -159,7 +159,7 @@ and prefetch those objects in bulk.
>   - `repack` in GC has been updated to not touch promisor packfiles at all,
>     and to only repack other objects.
>   
> -- The global variable "fetch_if_missing" is used to control whether an
> +- The per-repository flag "fetch_if_missing" is used to control whether an
>     object lookup will attempt to dynamically fetch a missing object or
>     report an error.
>   +
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 316badd969..c5edd7b80f 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -67,7 +67,7 @@ int cmd_fetch_pack(int argc,
>   	struct packet_reader reader;
>   	enum protocol_version version;
>   
> -	fetch_if_missing = 0;
> +	the_repository->fetch_if_missing = 0;
>   
>   	packet_trace_identity("fetch-pack");
>   
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 248f8ff5a0..aa31c69486 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1017,15 +1017,15 @@ int cmd_fsck(int argc,
>   		.ref = NULL
>   	};
>   
> -	/* fsck knows how to handle missing promisor objects */
> -	fetch_if_missing = 0;
> -
>   	errors_found = 0;
>   	disable_replace_refs();
>   	save_commit_buffer = 0;
>   
>   	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
>   
> +	/* fsck knows how to handle missing promisor objects */
> +	repo->fetch_if_missing = 0;
> +
>   	fsck_options_init(&fsck_walk_options, repo, FSCK_OPTIONS_DEFAULT);
>   	fsck_walk_options.walk = mark_object;
>   
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 0793dc595c..74f9694662 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1898,15 +1898,16 @@ int cmd_index_pack(int argc,
>   	int report_end_of_input = 0;
>   	int hash_algo = 0;
>   
> +	show_usage_if_asked(argc, argv, index_pack_usage);
> +
>   	/*
>   	 * index-pack never needs to fetch missing objects except when
>   	 * REF_DELTA bases are missing (which are explicitly handled). It only
>   	 * accesses the repo to do hash collision checks and to check which
>   	 * REF_DELTA bases need to be fetched.
>   	 */
> -	fetch_if_missing = 0;
> -
> -	show_usage_if_asked(argc, argv, index_pack_usage);
> +	if (repo)
> +		the_repository->fetch_if_missing = 0;
>   
>   	disable_replace_refs();
>   
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 8a1709a1ab..c6536b1f65 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4059,7 +4059,7 @@ static void add_unreachable_loose_objects(struct rev_info *revs);
>   
>   static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
>   {
> -	int prev_fetch_if_missing = fetch_if_missing;
> +	int prev_fetch_if_missing = the_repository->fetch_if_missing;
>   	struct rev_info revs;
>   
>   	/*
> @@ -4067,7 +4067,7 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
>   	 * walk is best-effort though we don't want to perform backfill fetches
>   	 * for them.
>   	 */
> -	fetch_if_missing = 0;
> +	the_repository->fetch_if_missing = 0;
>   
>   	repo_init_revisions(the_repository, &revs, NULL);
>   	/*
> @@ -4115,7 +4115,7 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
>   	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
>   			   stdin_packs_hints_nr);
>   
> -	fetch_if_missing = prev_fetch_if_missing;
> +	the_repository->fetch_if_missing = prev_fetch_if_missing;
>   }
>   
>   static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
> @@ -4451,14 +4451,14 @@ static int option_parse_missing_action(const struct option *opt UNUSED,
>   
>   	if (!strcmp(arg, "allow-any")) {
>   		arg_missing_action = MA_ALLOW_ANY;
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   		fn_show_object = show_object__ma_allow_any;
>   		return 0;
>   	}
>   
>   	if (!strcmp(arg, "allow-promisor")) {
>   		arg_missing_action = MA_ALLOW_PROMISOR;
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   		fn_show_object = show_object__ma_allow_promisor;
>   		return 0;
>   	}
> @@ -5247,7 +5247,7 @@ int cmd_pack_objects(int argc,
>   				  exclude_promisor_objects_best_effort,
>   				  "--exclude-promisor-objects-best-effort");
>   	if (exclude_promisor_objects) {
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   
>   		/* --stdin-packs handles promisor objects separately. */
>   		if (!stdin_packs) {
> @@ -5256,7 +5256,7 @@ int cmd_pack_objects(int argc,
>   		}
>   	} else if (exclude_promisor_objects_best_effort) {
>   		use_internal_rev_list = 1;
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   		option_parse_missing_action(NULL, "allow-any", 0);
>   		/* revs configured below */
>   	}
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 55635a891f..a7e4678d11 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -194,7 +194,7 @@ int cmd_prune(int argc,
>   	if (show_progress == -1)
>   		show_progress = isatty(2);
>   	if (exclude_promisor_objects) {
> -		fetch_if_missing = 0;
> +		repo->fetch_if_missing = 0;
>   		revs.exclude_promisor_objects = 1;
>   	}
>   
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 8f63003709..a6a0c5559e 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -509,25 +509,25 @@ static inline int parse_missing_action_value(const char *value)
>   
>   	if (!strcmp(value, "allow-any")) {
>   		arg_missing_action = MA_ALLOW_ANY;
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   		return 1;
>   	}
>   
>   	if (!strcmp(value, "print")) {
>   		arg_missing_action = MA_PRINT;
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   		return 1;
>   	}
>   
>   	if (!strcmp(value, "print-info")) {
>   		arg_missing_action = MA_PRINT_INFO;
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   		return 1;
>   	}
>   
>   	if (!strcmp(value, "allow-promisor")) {
>   		arg_missing_action = MA_ALLOW_PROMISOR;
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   		return 1;
>   	}
>   
> @@ -745,7 +745,7 @@ int cmd_rev_list(int argc,
>   	for (i = 1; i < argc; i++) {
>   		const char *arg = argv[i];
>   		if (!strcmp(arg, "--exclude-promisor-objects")) {
> -			fetch_if_missing = 0;
> +			the_repository->fetch_if_missing = 0;
>   			revs.exclude_promisor_objects = 1;
>   		} else if (skip_prefix(arg, "--missing=", &arg)) {
>   			parse_missing_action_value(arg);
> diff --git a/git.c b/git.c
> index 36f08891ef..315d2e160e 100644
> --- a/git.c
> +++ b/git.c
> @@ -202,7 +202,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   			if (envchanged)
>   				*envchanged = 1;
>   		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
> -			fetch_if_missing = 0;
> +			the_repository->fetch_if_missing = 0;
>   			setenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
>   			if (envchanged)
>   				*envchanged = 1;
> diff --git a/midx-write.c b/midx-write.c
> index 19e1cd10b7..e7313c9d2c 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -865,7 +865,7 @@ static void find_commits_for_midx_bitmap(struct commit_stack *commits,
>   	 * complain later that we don't have reachability closure (and fail
>   	 * appropriately).
>   	 */
> -	fetch_if_missing = 0;
> +	ctx->repo->fetch_if_missing = 0;
>   	revs.exclude_promisor_objects = 1;
>   
>   	if (prepare_revision_walk(&revs))
> diff --git a/odb.c b/odb.c
> index 965ef68e4e..664256e1a4 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -528,8 +528,6 @@ void disable_obj_read_lock(void)
>   	pthread_mutex_destroy(&obj_read_mutex);
>   }
>   
> -int fetch_if_missing = 1;
> -
>   static int register_all_submodule_sources(struct object_database *odb)
>   {
>   	int ret = odb->submodule_source_paths.nr;
> @@ -595,7 +593,7 @@ static int do_oid_object_info_extended(struct object_database *odb,
>   			continue;
>   
>   		/* Check if it is a missing object */
> -		if (fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
> +		if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
>   		    !already_retried &&
>   		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
>   			promisor_remote_get_direct(odb->repo, real, 1);
> diff --git a/odb.h b/odb.h
> index 0030467a52..1dca583fcb 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -14,14 +14,6 @@ struct repository;
>   struct strbuf;
>   struct strvec;
>   
> -/*
> - * Set this to 0 to prevent odb_read_object_info_extended() from fetching missing
> - * blobs. This has a difference only if extensions.partialClone is set.
> - *
> - * Its default value is 1.
> - */
> -extern int fetch_if_missing;
> -
>   /*
>    * Compute the exact path an alternate is at and returns it. In case of
>    * error NULL is returned and the human readable error is added to `err`
> diff --git a/repository.c b/repository.c
> index 187dd471c4..b959f7a028 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -73,6 +73,7 @@ void initialize_repository(struct repository *repo)
>   	ALLOC_ARRAY(repo->index, 1);
>   	index_state_init(repo->index, repo);
>   	repo->check_deprecated_config = true;
> +	repo->fetch_if_missing = 1;
>   	repo_config_values_init(&repo->config_values_private_);
>   
>   	/*
> diff --git a/repository.h b/repository.h
> index 36e2db2633..e8bd6ef0e7 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -169,6 +169,12 @@ struct repository {
>   	/* True if commit-graph has been disabled within this process. */
>   	int commit_graph_disabled;
>   
> +	/*
> +	 * Controls whether the repository should lazily fetch missing
> +	 * objects from promisor remotes. Defaults to 1.
> +	 */
> +	int fetch_if_missing;
> +
>   	/*
>   	 * Lazily-populated cache mapping hook event names to configured hooks.
>   	 * NULL until first hook use.
> diff --git a/revision.c b/revision.c
> index e91d7e1f11..5f70aa81e6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2714,7 +2714,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>   		revs->ignore_missing = 1;
>   	} else if (opt && opt->allow_exclude_promisor_objects &&
>   		   !strcmp(arg, "--exclude-promisor-objects")) {
> -		if (fetch_if_missing)
> +		if (the_repository->fetch_if_missing)
>   			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
>   		revs->exclude_promisor_objects = 1;
>   	} else {
> diff --git a/setup.c b/setup.c
> index b4652651df..ce2a80ac31 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1064,7 +1064,7 @@ static void setup_git_env_internal(struct repository *repo,
>   		set_alternate_shallow_file(repo, shallow_file, 0);
>   
>   	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>   }
>   
>   static void set_git_dir_1(struct repository *repo, const char *path)

What are everyone's thoughts on this patch? It seems like it's been a 
while since it received responses. ^^

Regards, yuchen
