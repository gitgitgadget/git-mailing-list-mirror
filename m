Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503782;
	b=ddbVoB5KXwdfFyZPXjSElGwKOsszZ0692Bwwr3ft6EKpqQNixHxUxbuQg6gUqbN2zPbw
	 N7xy13PGhn2qVoWi/5mGSXzkUzAyjfW4mZuuJqGf0qgpQQiD3IRr8smw/hFsHzbxtB8EC
	 aC6gWpw+CCg/vdNnSG65HEueI7UrZBK1Pmxi7DBSLazuGIsLddJCMxJP8nBXIE6TP0zZG
	 shAI/8fr1jbnjXcI+JwUkKjpyvNrZPdXuQNrPEZgD4Xet8k98W85nPl7CulgWvvaYnnXa
	 Zz3g4UPFMBdPbTYgeTB9xB95M+C6Ik8XRUnQn4XBqQGV7JkGRsCpEBJksm+rr7KN+lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=pQyE6J5UG2eEQ4ZsWMoFs+KUibIxG7fBvqF5nn2OnIw=;
	b=ayh42VAXPSorC6GdcNiPc/FRlq0mtKpd+wfZgbqmFGqGXEkEsecb4/ObbNiduoG8w0OE
	 FHkPJCptLAN27DDYwFL3O5ZHKt3VMNRxgxAN07fwYhYTKW3rOtHWIurm2qt26LIbEbtkL
	 Q2uN8sStF3IMuz6lOQ9HkviXkmz6qpi4iRVlQZDSaybq+rjVpHoRc65qoficyc94k4kDa
	 djEG544rAhY6ZyHfvwVLOVlONpOJnW0aOZZkiZFWSt37oVxaHtqG4bDQnnr2b+0yDuiSv
	 X+26Lu8vVzzunLK25qRENkm5L3I7bmVHux6+XBwUODSB0Yio2QDoqGbT2K5eJFOwtOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qnzA/tb2";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D05606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D05606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qnzA/tb2
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35b2c599f43so721017eec.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792503781; x=1793108581; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pQyE6J5UG2eEQ4ZsWMoFs+KUibIxG7fBvqF5nn2OnIw=;
        b=qnzA/tb2EdJforBY4fSSSoj/JBgOyC7avZ+TuxdNXvLxuA3Q1/1rGssxevMZffwkRc
         q8NwRkZuqodpLOirdk70jtiNkmlA60nZso1OYoQCZfvaSt+UbFNVOC6ThOH3oaex5aHV
         JyUfadkY13ZFNUTQFSptJkBuA/jyVlj7MeWp6dR1rqllKXWZE1yHoae5YxaQoQNqvDlV
         c9KfctbIemhXiYos5W/pBFuVNsDvjnhDi7gOBNwR/obcqj1k/7vxhIVRid8OL0qJceo8
         CN2Rs9e45Ukdi0SL76JEE0GPMR+l6a4H3rKlHLUJdyYrw67+IEJ5PFL7ICsmVpCT3rQA
         ts2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503781; x=1793108581;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQyE6J5UG2eEQ4ZsWMoFs+KUibIxG7fBvqF5nn2OnIw=;
        b=hbDnCRNnXaCepXIWactoBwxv5pTK4MkhI+QJksM17LFVMwKXHkvhyyj4m04WFYtH0s
         QREFmHQFDJH7jq2DG0LosFpeuPatzC2WAg4vgnQ6zIeaOfx5L42q5PAKamlQlhaWbV1o
         qYgzDnjpvXuouZkN87tz5+C0GdGi8wZ78pJXe0IjeqwqENuWFqU9Neebk6pcPWwk7K6n
         CHNWmhvQnCmxpov8B4n+t9u65iWgA4+mau0H7MEH7qedpYYibDGqi96dqOpLC3UFsNI7
         hyDs9S9CxMqaQ7V8gwkKhchfC1sfw2Sg4HcWoNxpv3CzuuNTDXG2ohMiBr6pjzQx7JhI
         G6Nw==
X-Gm-Message-State: AFq9FYKGiciYzi9L6bNlJkEWk+M6t01JrQTJO4ojWCslhPqcuWJqS8ue
	mvFEDZ6ri0zaguvaVzVHDhMYhvWGdKI4Khy8OCnETn9L63GlZpZWHUzmOCGWxg==
X-Gm-Gg: AYBFou0qt4cD9s2k24qNG986rc+AsYMYsnMJ0sPW8PHf0LZH1po1TSppO2g0SvqXHHz
	3eP0IaE7A/DQePhEdm55BCkaMRGWxTdHPw8gukTRFksryvCAhD+KxhF5Xjgxd3cZQLvKGSB+XpR
	oMg3ubd518J69opgyM0NbHSce18hHYqN7A3hNDhNbrSUt3yXkx/wweLf/cYFGOEELbQF69J+kZP
	SdHV2SxlG5To4qraOUzwYI3rc0PS78kIUYcesD/Tr6LhVdUmZ0WzzFs4qqwqIeqGkb9UMnzyhq6
	5Z0AUMwU+1Ab8FkopPzX3i/BARumVwq7mJlfgiLFhYuCO+C2WscjgKMJ2qH459cwkkfV4LhMjCt
	4PFZGNJh12GpEDLMaSvlRKfazOinE2/ahpacvZuWpUygmMNpktVJm5MMzYnBJ2lFaNMxjagB0y5
	i/UaIhKxXiaKHZNfr/WlQ++aHZG5UKMNA+Qf4HekTDYtjIO2Drtsq14KITAGwH6/sZrsvDc8U=
X-Received: by 2002:a05:7300:d405:b0:35c:8d1f:5634 with SMTP id 5a478bee46e88-361a126e38amr15209373eec.12.1792503780407;
        Tue, 20 Oct 2026 06:43:00 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.77.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36632d8b273sm5467338eec.15.2026.10.20.06.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:42:59 -0700 (PDT)
Message-Id: <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 13:42:53 +0000
Subject: [PATCH v10 0/5] fetch: avoid fetching every branch of a new remote in a shallow repo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

Changes in v10:

 * Resolve merge conflict after master integrated
   ch/fetch-followremotehead-lazy-validation.

Changes in v9:

 * Moved the do_fetch() if/else-if/else split out of the preliminary
   helper-extraction commit and into the refmap-inference commit that needs
   it. Preliminary commit is now a simpler refactor.

Changes in v8:

 * Split into a preliminary collect_upstream_from_remote() helper commit
   plus a simplified refmap-inference commit.
 * Fixed a regression that could drop the current branch's @{upstream} when
   remote.<name>.fetch was narrowed.
 * Threaded struct repository * through instead of hardcoding
   the_repository.
 * Minor naming and comment cleanups.

Changes in v7:

 * Fixed fatal: --refmap option is only meaningful with command-line
   refspec(s) firing just from configuring remote.<name>.refmap alone, with
   nothing else to fetch.
 * When both remote.<name>.fetch and remote.<name>.refmap are configured, a
   refspec-less fetch follows .fetch as usual, .refmap only remaps something
   already being fetched by name. Added tests.

Changes in v6:

 * Remove leftover reference to deleted default-branch logic in commit
   message.

Changes in v5:

 * Renumber test file from t5585 to t5586.

Changes in v4:

 * Removed the automatic default-branch fetch. A fresh remote fetches
   nothing until you track a branch explicitly.
 * Fixed fetch report showing "new ref HEAD" instead of "new branch "
 * Reworded remote..refmap docs and commit message.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (5):
  fetch: add remote.<name>.refmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |   5 ++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  92 ++++++++++++++++++++----
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  51 ++++++++++++-
 remote.h                         |  19 +++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 |  63 ++++++++++++++++
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 456 insertions(+), 23 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v10
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v9:

 1:  2a48c21bc8 = 1:  ba7f1354cd fetch: add remote.<name>.refmap
 2:  50382bce7e ! 2:  aa20604144 fetch: extract collect_upstream_from_remote() helper
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       		if (transport->remote->fetch.nr) {
       			refspec_ref_prefixes(&transport->remote->fetch,
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     - 				do_set_head = 1;
     + 			else
     + 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
       		}
      -		if (branch && branch_has_merge_config(branch) &&
      -		    !strcmp(branch->remote_name, transport->remote->name)) {
 3:  9ad8ad3eb4 ! 3:  9fb7e77a86 fetch: infer branches to fetch from a refmap-only remote
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
       
       	if (rs->nr) {
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
     --	} else {
      +	} else if (transport->remote->fetch.nr) {
     - 		struct string_list tracked = STRING_LIST_INIT_DUP;
     - 		struct string_list_item *item;
     - 
     --		if (transport->remote->fetch.nr) {
     --			refspec_ref_prefixes(&transport->remote->fetch,
     --					     &transport_ls_refs_options.ref_prefixes);
     --			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     --				do_set_head = 1;
     --		}
     ++		struct string_list tracked = STRING_LIST_INIT_DUP;
     ++		struct string_list_item *item;
     ++
      +		refspec_ref_prefixes(&transport->remote->fetch,
      +				     &transport_ls_refs_options.ref_prefixes);
     -+		if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     -+			do_set_head = 1;
     - 
     - 		/*
     - 		 * The configured refspec may not cover the current
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 			strvec_push(&transport_ls_refs_options.ref_prefixes,
     - 				    item->string);
     - 		string_list_clear(&tracked, 0);
     -+	} else {
     ++		/*
     ++		 * See remote.c's handling of remote.<name>.followRemoteHEAD
     ++		 * for the analogous, still-unresolved case.
     ++		 */
     ++		if (transport->remote->follow_remote_head)
     ++			follow_remote_head = transport->remote->follow_remote_head;
     ++		else if (config->follow_remote_head_seen)
     ++			follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
     ++		else
     ++			follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
     ++
     ++		/*
     ++		 * The configured refspec may not cover the current
     ++		 * branch's upstream (e.g. a narrowed -t refspec), so
     ++		 * make sure we can still fetch it regardless.
     ++		 */
     ++		collect_upstream_from_remote(the_repository, &tracked,
     ++					      transport->remote, NULL);
     ++		for_each_string_list_item(item, &tracked)
     ++			strvec_push(&transport_ls_refs_options.ref_prefixes,
     ++				    item->string);
     ++		string_list_clear(&tracked, 0);
     + 	} else {
      +		/*
      +		 * The --refmap command line option, if given, takes
      +		 * precedence over remote.<name>.refmap.
      +		 */
      +		struct refspec *effective_refmap = refmap.nr ? &refmap :
      +			&transport->remote->refmap;
     -+		struct string_list tracked = STRING_LIST_INIT_DUP;
     -+		struct string_list_item *item;
     -+
     + 		struct string_list tracked = STRING_LIST_INIT_DUP;
     + 		struct string_list_item *item;
     + 
     +-		if (transport->remote->fetch.nr) {
     +-			refspec_ref_prefixes(&transport->remote->fetch,
     +-					     &transport_ls_refs_options.ref_prefixes);
      +		if (effective_refmap->nr) {
      +			branches_tracking_remote(the_repository,
      +						  transport->remote, &tracked);
     -+			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     -+				do_set_head = 1;
     + 			/*
     + 			 * See remote.c's handling of remote.<name>.followRemoteHEAD
     + 			 * for the analogous, still-unresolved case.
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
     + 			else
     + 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
      +		} else {
      +			collect_upstream_from_remote(the_repository, &tracked,
      +						      transport->remote, NULL);
     -+		}
     -+		for_each_string_list_item(item, &tracked)
     -+			strvec_push(&transport_ls_refs_options.ref_prefixes,
     -+				    item->string);
     -+		string_list_clear(&tracked, 0);
     - 
     - 		/*
     - 		 * If there are no refs specified to fetch, then we just
     + 		}
     +-
     +-		/*
     +-		 * The configured refspec may not cover the current
     +-		 * branch's upstream (e.g. a narrowed -t refspec), so
     +-		 * make sure we can still fetch it regardless.
     +-		 */
     +-		collect_upstream_from_remote(the_repository, &tracked,
     +-					      transport->remote, NULL);
     + 		for_each_string_list_item(item, &tracked)
     + 			strvec_push(&transport_ls_refs_options.ref_prefixes,
     + 				    item->string);
      
       ## remote.c ##
      @@ remote.c: void collect_upstream_from_remote(struct repository *repo,
 4:  75169f668e = 4:  80028d4f86 remote: add "git remote add --limited-fetch"
 5:  9ee090d3d0 = 5:  552bf08971 remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget
