Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EB2EC0A6
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009043; cv=none; b=h7XcSh1mauigqHeMxEhwG+N/g2aoBKu7rfB0gA1aJdZjWT6aNgDHzSoHe8TOFp9EeoEjo7CUsW41QrQlOfaJnXVWJh9D93LZNFT9HjHs5iV0OSMFD/ijRH43eUDE/NuCP1emmdwMrKJa53E8pZjf4FUKtGuqlr5cdP3ymuF1HhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009043; c=relaxed/simple;
	bh=OdE6YLIfbFMoHnCjvxAaaBTlwBHp2CVEgRIQOS6V7wU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BgkJ7257crE0t31pDO89y1nuGfEV4Fqak+UzCTiLjccdgkHHtJ4w2mI3k5gppEXxt50XHrskKVLUVnkBgDjkovIBhE02jrbH8SFT8Zly6H0l5wJeTXCvAPNL5mWw0tQgfISZVTny5kFzYgp+N2mZbTeYFwzUf0vcnAKwN2mLz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPoCLUbX; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPoCLUbX"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dca5f64e86so4371498a34.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009040; x=1778613840; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fAokTVTfoL+x51KRRgsdgBknTsauqutBD2n4kM5i3E=;
        b=MPoCLUbXxDCCsgTU/KdFrnN8rMgpLvCMsOvgyzpHuRRp+63NKTFkqibnVDHlipRQ7O
         KC3UUb6GbTliMoa2wobnssMqOqMJvExU+fP8TXeSitFjAOFRY9S9eS5Lun603ql+hF9t
         eKNz6k/ZsYlc3P6DtW0g6x5DKThogozjf/ooWJi9cMTTkb6Sw2k11FUbyDpOBJTt+JSF
         D6K4je9QQXCMGEHkP83S1eSwMTB3sHbDd3EJfkrAY3hg9VVgGPoH43RT5bFLp07x4Qjq
         YV4jI32kWgFP9dSFyoQwfDf8svMmx8iv0n5a4jLxW1I6Upu9gVV4WWxaa2bH4g4jdpS/
         WqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009040; x=1778613840;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fAokTVTfoL+x51KRRgsdgBknTsauqutBD2n4kM5i3E=;
        b=K600rXKkiyExeNF2pygZIKb/FJL8CbaJAsvilxOnlnaQbb98OUybsyvvjjwizT5/r9
         4WonCU04nGep0U0iLPn5L+KzGii+lTTDskLxl2sFaesm/czH8QJpHQz8gSCvrVHV3IpX
         XJP4rdLixRtCT2qmdf8CF4Kk3/PjRfvOVrYWhGCizwhiSThQqkcwxlfxU6iHteHgtOxE
         HnvyLJeyhNSyquboaLB0cZiIXjbsLFMhP5Mi+yy3/UaRQKI43wb4nNmxvpN3dEO60oyB
         oxjxHOvb8SYMMyLclNXgibcsuvKV6XM4PVk6GNlHa7nTPqmz5dabnj5un8bUO/uD2hH8
         3tGA==
X-Gm-Message-State: AOJu0YxnlZpdBkBvy+BZ2ad+5H/a0j0XAF4Bs8UXRkioyuDLv2i8WCr0
	MyfiGjzL1B6jOzdvSWa2+hhj8W3Bm2gnVnMa0Cb7uw0HXqLPDhAxIbCW1sYdxw==
X-Gm-Gg: AeBDieuD6ONNfWb2hF9mW/lyp6IBCQmzCRjnzuV1cK5VLvmObAC35HMOTy6nljZLsSI
	cVN5gW4q05QziMQCXNP7HAigiSdsY9bWHuBZoACNXQ8pqxDhUI5JyVjUh5lhuQf7m8mZ4cejCXT
	l3uDWQII2N9leKdRIFarjmwX+xzuEMW13KnvOGTkguDVzse8Yfvc2cQuIO1xpSV4PI3nY3sTS/f
	fn0AJkFtc3wbcENz4pazxyiuiMYPmYInGAjKMvloP5P0FIAqFVJXPwQXjepG2OIhq1SP1G4rewp
	c5HJb1Xk2S6IsaOke+ErStPeu0UsTeAyeiEKPvdSuswArj5FvgNlaQsRIv2Bv5sSxPY5TPQgnQU
	rzmV77Z+0YEyQ3dP0gWmuhn6BF5xEZ26qgO2gJywLsRHeKhDdoHEvM0BXk0B2WJ++gPJxW81nRv
	BAyCXcZlVLxkKx2Wf/RZx6YuSGjvp7WHlGX8Om
X-Received: by 2002:a05:6830:2704:b0:7d7:f13a:761c with SMTP id 46e09a7af769-7e1df15829emr30299a34.23.1778009040136;
        Tue, 05 May 2026 12:24:00 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.21])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decac248d1sm10922596a34.15.2026.05.05.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:23:59 -0700 (PDT)
Message-Id: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
References: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 19:23:52 +0000
Subject: [PATCH v4 0/6] fetch: add fetch.pruneBranches config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>

I ran this on one of my repos and wiped out the local master branch! That
was a bad surprise, so I made an update now to treat the default branch in a
special way (never prune it).

 * Resolve each remote's HEAD and collect the targets into a
   protected_default_refs set in collect_forked_set.
 * In prune_merged_branches, skip a candidate when its upstream is a
   protected default ref and the local branch name matches the default
   branch's leaf name (so a local main tracking origin/main is spared, but a
   renamed trunk tracking origin/main is not).
 * Also skip when the candidate's push ref points at a protected default
   ref, so a topic branch configured to push to origin/main is never pruned.
 * Tests: spare the local default branch; only protect by matching leaf name
   (not by upstream alone); spare a branch whose push ref is the remote
   default.

Harald Nordgren (6):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  fetch: add --prune-merged
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/fetch-options.adoc |   8 +
 Documentation/git-branch.adoc    |  32 ++++
 builtin/branch.c                 | 289 +++++++++++++++++++++++++++++--
 builtin/fetch.c                  |  20 +++
 t/t3200-branch.sh                | 247 ++++++++++++++++++++++++++
 t/t5510-fetch.sh                 |  31 ++++
 7 files changed, 623 insertions(+), 11 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v4
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v3:

 1:  77e67d4b8b = 1:  77e67d4b8b branch: add --forked <remote>
 2:  807c9f981f = 2:  807c9f981f branch: let delete_branches warn instead of error on bulk refusal
 3:  49dc853403 ! 3:  77beb620d7 branch: add --prune-merged <remote>
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
       }
       
      -static int list_forked_branches(int argc, const char **argv)
     ++static void collect_default_branch_refs(const struct string_list *remote_names,
     ++					struct string_list *out)
     ++{
     ++	struct ref_store *refs = get_main_ref_store(the_repository);
     ++	struct string_list_item *item;
     ++
     ++	for_each_string_list_item(item, remote_names) {
     ++		struct strbuf head = STRBUF_INIT;
     ++		const char *target;
     ++
     ++		strbuf_addf(&head, "refs/remotes/%s/HEAD", item->string);
     ++		target = refs_resolve_ref_unsafe(refs, head.buf,
     ++						 RESOLVE_REF_NO_RECURSE,
     ++						 NULL, NULL);
     ++		if (target && starts_with(target, "refs/remotes/"))
     ++			string_list_insert(out, target);
     ++		strbuf_release(&head);
     ++	}
     ++}
     ++
      +static void collect_forked_set(int argc, const char **argv,
     ++			       struct string_list *protected_default_refs,
      +			       struct string_list *out)
       {
       	struct string_list remote_names = STRING_LIST_INIT_NODUP;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      -	for_each_string_list_item(item, &out)
      -		puts(item->string);
      +	string_list_sort(out);
     ++
     ++	if (protected_default_refs)
     ++		collect_default_branch_refs(&remote_names, protected_default_refs);
       
       	string_list_clear(&remote_names, 0);
       	string_list_clear(&tracking_refs, 0);
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +	if (!argc)
      +		die(_("--forked requires at least one <remote>"));
      +
     -+	collect_forked_set(argc, argv, &out);
     ++	collect_forked_set(argc, argv, NULL, &out);
      +	for_each_string_list_item(item, &out)
      +		puts(item->string);
      +
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +				 int quiet)
      +{
      +	struct string_list candidates = STRING_LIST_INIT_DUP;
     ++	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
      +	struct strvec deletable = STRVEC_INIT;
      +	struct string_list_item *item;
      +	int n_not_merged = 0;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +	if (!argc)
      +		die(_("--prune-merged requires at least one <remote>"));
      +
     -+	collect_forked_set(argc, argv, &candidates);
     ++	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
      +
      +	for_each_string_list_item(item, &candidates) {
      +		const char *short_name = item->string;
      +		struct strbuf full = STRBUF_INIT;
      +		struct branch *branch;
      +		const char *push_ref;
     ++		const char *upstream;
      +
      +		strbuf_addf(&full, "refs/heads/%s", short_name);
      +		if (branch_checked_out(full.buf)) {
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +		strbuf_release(&full);
      +
      +		branch = branch_get(short_name);
     ++		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
     ++		if (upstream &&
     ++		    string_list_has_string(&protected_default_refs, upstream)) {
     ++			const char *leaf = strrchr(upstream, '/');
     ++			if (leaf && !strcmp(leaf + 1, short_name))
     ++				continue;
     ++		}
     ++
      +		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
      +		if (!push_ref)
      +			continue;
      +		if (refs_ref_exists(get_main_ref_store(the_repository),
      +				    push_ref))
      +			continue;
     ++		if (string_list_has_string(&protected_default_refs, push_ref))
     ++			continue;
      +
      +		strvec_push(&deletable, short_name);
      +	}
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +
      +	strvec_clear(&deletable);
      +	string_list_clear(&candidates, 0);
     ++	string_list_clear(&protected_default_refs, 0);
      +	return ret;
      +}
      +
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	test_when_finished "rm -rf pm-pushdiff" &&
      +	git clone pm-upstream pm-pushdiff &&
      +	git -C pm-pushdiff config push.default current &&
     -+	git -C pm-pushdiff branch --track topic-a origin/main &&
     ++	git -C pm-pushdiff branch --track topic-a origin/one &&
      +
      +	git -C pm-pushdiff branch --force --prune-merged origin &&
      +
      +	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
      +'
     ++
     ++test_expect_success '--prune-merged spares the local default branch' '
     ++	test_when_finished "rm -rf pm-default" &&
     ++	git clone pm-upstream pm-default &&
     ++	git -C pm-default config push.default current &&
     ++	git -C pm-default checkout --detach &&
     ++	git -C pm-default branch --prune-merged origin &&
     ++	git -C pm-default rev-parse --verify refs/heads/main
     ++'
     ++
     ++test_expect_success '--prune-merged protects only the default branch by name, not by upstream' '
     ++	test_when_finished "rm -rf pm-default-alias" &&
     ++	git clone pm-upstream pm-default-alias &&
     ++	git -C pm-default-alias config push.default current &&
     ++	git -C pm-default-alias branch --track trunk origin/main &&
     ++	git -C pm-default-alias checkout --detach &&
     ++	git -C pm-default-alias branch --force --prune-merged origin &&
     ++	git -C pm-default-alias rev-parse --verify refs/heads/main &&
     ++	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
     ++'
     ++
     ++test_expect_success '--prune-merged spares branches whose push ref is the default branch' '
     ++	test_when_finished "rm -rf pm-pushdefault" &&
     ++	git clone pm-upstream pm-pushdefault &&
     ++	git -C pm-pushdefault branch --track topic origin/one &&
     ++	git -C pm-pushdefault config --add remote.origin.push refs/heads/topic:refs/heads/main &&
     ++	git -C pm-pushdefault update-ref -d refs/remotes/origin/one &&
     ++	git -C pm-pushdefault update-ref -d refs/remotes/origin/main &&
     ++	git -C pm-pushdefault checkout --detach &&
     ++	git -C pm-pushdefault branch --prune-merged origin &&
     ++	git -C pm-pushdefault rev-parse --verify refs/heads/topic
     ++'
      +
       test_done
 4:  938bf7c794 = 4:  98cfdb87d2 fetch: add --prune-merged
 5:  b2e7c97298 ! 5:  c645526bb5 branch: add branch.<name>.pruneMerged opt-out
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      +		struct strbuf key = STRBUF_INIT;
       		struct branch *branch;
       		const char *push_ref;
     + 		const char *upstream;
      +		int opt_out = 0;
       
       		strbuf_addf(&full, "refs/heads/%s", short_name);
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       			continue;
       		}
       		strbuf_release(&full);
     +@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int force,
     + 		if (upstream &&
     + 		    string_list_has_string(&protected_default_refs, upstream)) {
     + 			const char *leaf = strrchr(upstream, '/');
     +-			if (leaf && !strcmp(leaf + 1, short_name))
     ++			if (leaf && !strcmp(leaf + 1, short_name)) {
     ++				strbuf_release(&key);
     + 				continue;
     ++			}
     + 		}
       
     - 		branch = branch_get(short_name);
       		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
      -		if (!push_ref)
      +		if (!push_ref) {
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      +			strbuf_release(&key);
      +			continue;
      +		}
     ++		if (string_list_has_string(&protected_default_refs, push_ref)) {
     ++			strbuf_release(&key);
     + 			continue;
     +-		if (string_list_has_string(&protected_default_refs, push_ref))
     ++		}
      +
      +		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
      +		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       	}
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--prune-merged deletes when push ref differs from upstream'
     - 	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
     +@@ t/t3200-branch.sh: test_expect_success '--prune-merged spares branches whose push ref is the defaul
     + 	git -C pm-pushdefault rev-parse --verify refs/heads/topic
       '
       
      +test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
 6:  6462642cd0 ! 6:  690242d89b branch: add --all-remotes flag
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
       static void parse_forked_args(int argc, const char **argv,
       			      struct string_list *remote_names,
       			      struct string_list *tracking_refs)
     -@@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref, void *cb_data)
     - 	return 0;
     +@@ builtin/branch.c: static void collect_default_branch_refs(const struct string_list *remote_names,
     + 	}
       }
       
      -static void collect_forked_set(int argc, const char **argv,
      +static void collect_forked_set(int argc, const char **argv, int all_remotes,
     + 			       struct string_list *protected_default_refs,
       			       struct string_list *out)
       {
     - 	struct string_list remote_names = STRING_LIST_INIT_NODUP;
      @@ builtin/branch.c: static void collect_forked_set(int argc, const char **argv,
       	};
       
     @@ builtin/branch.c: static void collect_forked_set(int argc, const char **argv,
      +	if (!argc && !all_remotes)
      +		die(_("--forked requires at least one <remote> or --all-remotes"));
       
     --	collect_forked_set(argc, argv, &out);
     -+	collect_forked_set(argc, argv, all_remotes, &out);
     +-	collect_forked_set(argc, argv, NULL, &out);
     ++	collect_forked_set(argc, argv, all_remotes, NULL, &out);
       	for_each_string_list_item(item, &out)
       		puts(item->string);
       
     @@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
      +				 int all_remotes, int force, int quiet)
       {
       	struct string_list candidates = STRING_LIST_INIT_DUP;
     - 	struct strvec deletable = STRVEC_INIT;
     + 	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int force,
       	int n_not_merged = 0;
       	int ret = 0;
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
      +	if (!argc && !all_remotes)
      +		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
       
     --	collect_forked_set(argc, argv, &candidates);
     -+	collect_forked_set(argc, argv, all_remotes, &candidates);
     +-	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
     ++	collect_forked_set(argc, argv, all_remotes, &protected_default_refs,
     ++			   &candidates);
       
       	for_each_string_list_item(item, &candidates) {
       		const char *short_name = item->string;

-- 
gitgitgadget
