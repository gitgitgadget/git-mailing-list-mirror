Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1C3D6462
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163826; cv=none; b=ON2QNDaV0gOEO0n/06FBZgOBTpYNKNDEkr7qXf0Q1VTyytL5OK3agHj1PHv8bmuya5GID0zY6NYW4FauumrzEDam4pOZ4JrCgM5jBIIT38li6pL7VVU1Rhdq5fjb8PRBJjm7LKcZ80ckJlF5DuE2XRctt9aMDWkfPUDjTbdlXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163826; c=relaxed/simple;
	bh=LnNiLUiW+Q+CAbVblb1S4lgQ25ZFp2rIZDGtWg4C2J4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SasY4oCLII9i1rCZIkAbPoppVYPgcIurzFPMERstUfNVRehjhy74gK27xRqyTm9SiC0PuDPNwqJIj0D2tatf8htLVK/csLbyFnxOhyWiXXWqSUoRPaEL2++pyd9bVufi05arph2LQckjMvwRULhk3RmOvKoUvX5sewRSjMQnkBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLQ6Z6qV; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLQ6Z6qV"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so4707972eec.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163821; x=1776768621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8de+hRjnSkNuC72iUgRK4UQnGhxlGDlO9MUlwpWRK3A=;
        b=sLQ6Z6qV96xMTlW46CxzcXBPTn4wSkSuuUXVLB8Dqx/C1MEKIWivabtuAIZj0NLH6/
         NWDv2Z0DZzFKAYiR0o3ygjdbhDes/QEL87hl3R7mOKmKVD2Oic1g/u3AAOpyKYI4HlId
         x3fbvajPdy7DmgRDYmdJaGTddzOzVn7oTIJ/FlTnB7yRr7AmOkHP8C+zsrm51RUm485V
         HeNHwXsJmCyI0zX77blT22uvTcpjQN/G7DHZL0vSjOrOMgv4u9pCYiu19qaS3K1Yi8Gq
         kbwBsx47b5y9dBsa34AVtZVwK6jDKlUtXGQLvUXjaweUbCOHYUwbjILYbrM9BYjKUzUe
         eX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163821; x=1776768621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8de+hRjnSkNuC72iUgRK4UQnGhxlGDlO9MUlwpWRK3A=;
        b=Q4EqjhRXn0fCn+0hAJc63vppPgvGA/BA+1qNyY6BzvsVmChbncOx/ZDEVMqIfym1b/
         VS9m80J60R+uCZJzutY5/0XQ9lwpl0ZypXP2+efZFBNDea+ld62L1STVXjlEpK29jt4D
         WZ0K7DyWgahLa2NBNaDNc655bPNrtyH6hlCUMdaECnMZqzMJ108JsmpshVTAwqiOC5aL
         InGcKSTAq7RUTce+yoNWDRK5W19yh6JsrNbLza2o2HHzpvEvIJU2e/PzHNOznlRjsybz
         Bnq2MVoCOGg9qGx75NFx5OtZds2LOXBvGSthfC94BcpRpML6EYhAS2N6I+daKrSQCLnH
         xEQg==
X-Gm-Message-State: AOJu0Yz9vpw8H+D3MvRxHSfixM5E83Vdr1O6n6nsv28gL/I3CkUbcBQ8
	xmQfvRD3TRGpTip7j5ou3XRGTHtlIZn5xcWsy3n5387I7jhofyLAwhLXhFjYjw==
X-Gm-Gg: AeBDievVNdm6xh4VI/eZM0/4lLZGK9BZUOrDE6dBUYuUq3ouKZfNsL9QUu5w349Zyb7
	W6BbCPux+igOasH0s/2RJ/BCu+Kjq28+2Mthjh7OBGUdh4acz02LKT4Qn/nvfP7x8HLecjbdrqx
	BphWJKFm9Ri5QzGPEd8t/4RyaxUg5izQoTwDdItGDsoK+CQzjyGy1xcgq1RtJxLV8ZBdgMWXfWp
	oAqeEAhdM6uElWS5fHddOpqeP62XgnggdDcyBAnG0gxzCUZ4+SFdrH8PkiRKyfDO8h+ygaEEer+
	n2gGJvt0Y2Rj6y5YNCxu2tEsKv5lR4lw02+oHdN+WPMaVaERd7YncBMZYOoyvmmSiCc0PlYyMty
	3GJAB6+y3SnzCi20kyjjIRTGiQxHF2LJJmID6LsYpeeRzNQg3WdC2aiRx1OfrpULWEYZ3yo7wt9
	4w+vdHamahjMOBNxeSgcxibk0FznXU
X-Received: by 2002:a05:7301:1f05:b0:2da:1a81:588 with SMTP id 5a478bee46e88-2da1a906cbdmr3877997eec.14.1776163821488;
        Tue, 14 Apr 2026 03:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa42dasm20709139eec.7.2026.04.14.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:50:20 -0700 (PDT)
Message-Id: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
References: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 10:50:15 +0000
Subject: [PATCH v11 0/4] checkout: 'autostash' for branch switching
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>

Harald Nordgren (4):
  stash: add --label-ours, --label-theirs, --label-base for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 ++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  33 ++---
 builtin/checkout.c              | 147 ++++++++++------------
 builtin/stash.c                 |  32 +++--
 sequencer.c                     |  87 ++++++++++---
 sequencer.h                     |   8 ++
 t/t3420-rebase-autostash.sh     |  24 +++-
 t/t3903-stash.sh                |  29 +++++
 t/t7201-co.sh                   | 208 ++++++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 ++
 xdiff-interface.h               |   1 +
 xdiff/xmerge.c                  |   6 +-
 14 files changed, 499 insertions(+), 159 deletions(-)


base-commit: 9e8f4e9c04e3efa494e78b710e0c5f6cc77a0a5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v11
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v10:

 1:  aa519c50be = 1:  9ab5431b47 stash: add --label-ours, --label-theirs, --label-base for apply
 2:  8173a4eb72 = 2:  e7f8328e3c sequencer: allow create_autostash to run silently
 3:  f36fedd8c2 = 3:  3242fd3261 sequencer: teach autostash apply to take optional conflict marker labels
 4:  b6e5546d74 ! 4:  97a5d87c81 checkout: -m (--merge) uses autostash when switching branches
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	int do_merge = 1;
      +	int created_autostash = 0;
      +	struct strbuf old_commit_shortname = STRBUF_INIT;
     ++	struct strbuf autostash_msg = STRBUF_INIT;
      +	const char *stash_label_base = NULL;
       
       	trace2_cmd_mode("branch");
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	if (do_merge) {
       		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		if (ret && opts->merge) {
     -+			create_autostash_ref_silent(the_repository,
     -+						   "CHECKOUT_AUTOSTASH_HEAD");
     ++			strbuf_addf(&autostash_msg,
     ++				    "autostash while switching to '%s'",
     ++				    new_branch_info->name);
     ++			create_autostash_ref_silent_with_msg(the_repository,
     ++							    "CHECKOUT_AUTOSTASH_HEAD",
     ++							    autostash_msg.buf);
      +			created_autostash = 1;
      +			ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
      +		}
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +						       "CHECKOUT_AUTOSTASH_HEAD",
      +						       new_branch_info->name,
      +						       "local",
     -+						       stash_label_base);
     ++						       stash_label_base,
     ++						       autostash_msg.len ? autostash_msg.buf : NULL);
       			branch_info_release(&old_branch_info);
      +			strbuf_release(&old_commit_shortname);
     ++			strbuf_release(&autostash_msg);
       			return ret;
       		}
       	}
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +	}
      +	apply_autostash_ref_with_labels(the_repository, "CHECKOUT_AUTOSTASH_HEAD",
      +				       new_branch_info->name, "local",
     -+				       stash_label_base);
     ++				       stash_label_base,
     ++				       autostash_msg.len ? autostash_msg.buf : NULL);
      +
      +	discard_index(the_repository->index);
      +	if (repo_read_index(the_repository) < 0)
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
       	branch_info_release(&old_branch_info);
      +	strbuf_release(&old_commit_shortname);
     ++	strbuf_release(&autostash_msg);
       
       	return ret || writeout_error;
       }
      
       ## sequencer.c ##
     +@@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list, int offset)
     + static void create_autostash_internal(struct repository *r,
     + 				      const char *path,
     + 				      const char *refname,
     ++				      const char *message,
     + 				      bool silent)
     + {
     + 	struct strbuf buf = STRBUF_INIT;
     +@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     + 		struct object_id oid;
     + 
     + 		strvec_pushl(&stash.args,
     +-			     "stash", "create", "autostash", NULL);
     ++			     "stash", "create",
     ++			     message ? message : "autostash", NULL);
     + 		stash.git_cmd = 1;
     + 		stash.no_stdin = 1;
     + 		strbuf_reset(&buf);
     +@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     + 
     + void create_autostash(struct repository *r, const char *path)
     + {
     +-	create_autostash_internal(r, path, NULL, false);
     ++	create_autostash_internal(r, path, NULL, NULL, false);
     + }
     + 
     + void create_autostash_ref(struct repository *r, const char *refname)
     + {
     +-	create_autostash_internal(r, NULL, refname, false);
     ++	create_autostash_internal(r, NULL, refname, NULL, false);
     + }
     + 
     + void create_autostash_ref_silent(struct repository *r, const char *refname)
     + {
     +-	create_autostash_internal(r, NULL, refname, true);
     ++	create_autostash_internal(r, NULL, refname, NULL, true);
     ++}
     ++
     ++void create_autostash_ref_silent_with_msg(struct repository *r,
     ++					  const char *refname,
     ++					  const char *message)
     ++{
     ++	create_autostash_internal(r, NULL, refname, message, true);
     + }
     + 
     + static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     + 				    const char *label_ours, const char *label_theirs,
     +-				    const char *label_base)
     ++				    const char *label_base,
     ++				    const char *stash_msg)
     + {
     + 	struct child_process child = CHILD_PROCESS_INIT;
     + 	int ret = 0;
      @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     + 		strvec_push(&store.args, "stash");
     + 		strvec_push(&store.args, "store");
     + 		strvec_push(&store.args, "-m");
     +-		strvec_push(&store.args, "autostash");
     ++		strvec_push(&store.args, stash_msg ? stash_msg : "autostash");
     + 		strvec_push(&store.args, "-q");
       		strvec_push(&store.args, stash_oid);
       		if (run_command(&store))
       			ret = error(_("cannot store %s"), stash_oid);
     @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
       	}
       
       	return ret;
     +@@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
     + 	strbuf_trim(&stash_oid);
     + 
     + 	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
     +-				      NULL, NULL, NULL);
     ++				      NULL, NULL, NULL, NULL);
     + 
     + 	unlink(path);
     + 	strbuf_release(&stash_oid);
     +@@ sequencer.c: int apply_autostash(const char *path)
     + 
     + int apply_autostash_oid(const char *stash_oid)
     + {
     +-	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
     ++	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
     + }
     + 
     + static int apply_save_autostash_ref(struct repository *r, const char *refname,
     + 				    int attempt_apply,
     + 				    const char *label_ours, const char *label_theirs,
     +-				    const char *label_base)
     ++				    const char *label_base,
     ++				    const char *stash_msg)
     + {
     + 	struct object_id stash_oid;
     + 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
     +@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     + 
     + 	oid_to_hex_r(stash_oid_hex, &stash_oid);
     + 	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
     +-				       label_ours, label_theirs, label_base);
     ++				       label_ours, label_theirs, label_base,
     ++				       stash_msg);
     + 
     + 	refs_delete_ref(get_main_ref_store(r), "", refname,
     + 			&stash_oid, REF_NO_DEREF);
     +@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     + 
     + int save_autostash_ref(struct repository *r, const char *refname)
     + {
     +-	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
     ++	return apply_save_autostash_ref(r, refname, 0,
     ++					NULL, NULL, NULL, NULL);
     + }
     + 
     + int apply_autostash_ref(struct repository *r, const char *refname)
     + {
     +-	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
     ++	return apply_save_autostash_ref(r, refname, 1,
     ++					NULL, NULL, NULL, NULL);
     + }
     + 
     + int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     + 				    const char *label_ours, const char *label_theirs,
     +-				    const char *label_base)
     ++				    const char *label_base,
     ++				    const char *stash_msg)
     + {
     + 	return apply_save_autostash_ref(r, refname, 1,
     +-					label_ours, label_theirs, label_base);
     ++					label_ours, label_theirs, label_base,
     ++					stash_msg);
     + }
     + 
     + static int checkout_onto(struct repository *r, struct replay_opts *opts,
     +
     + ## sequencer.h ##
     +@@ sequencer.h: void commit_post_rewrite(struct repository *r,
     + void create_autostash(struct repository *r, const char *path);
     + void create_autostash_ref(struct repository *r, const char *refname);
     + void create_autostash_ref_silent(struct repository *r, const char *refname);
     ++void create_autostash_ref_silent_with_msg(struct repository *r,
     ++					  const char *refname,
     ++					  const char *message);
     + int save_autostash(const char *path);
     + int save_autostash_ref(struct repository *r, const char *refname);
     + int apply_autostash(const char *path);
     +@@ sequencer.h: int apply_autostash_oid(const char *stash_oid);
     + int apply_autostash_ref(struct repository *r, const char *refname);
     + int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     + 				    const char *label_ours, const char *label_theirs,
     +-				    const char *label_base);
     ++				    const char *label_base,
     ++				    const char *stash_msg);
     + 
     + #define SUMMARY_INITIAL_COMMIT   (1 << 0)
     + #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
      
       ## t/t3420-rebase-autostash.sh ##
      @@ t/t3420-rebase-autostash.sh: create_expected_failure_apply () {
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
      +	test_cmp expect one
      +'
      +
     ++test_expect_success 'checkout -m autostash message includes target branch' '
     ++	git checkout -f main &&
     ++	git clean -f &&
     ++
     ++	fill 1 2 3 4 5 >one &&
     ++	git checkout -m side >actual 2>&1 &&
     ++	git stash list >stash-list &&
     ++	test_grep "autostash while switching to .side." stash-list &&
     ++	git stash drop &&
     ++	git checkout -f main &&
     ++	git reset --hard
     ++'
     ++
      +test_expect_success 'checkout -m stashes on staged conflicting changes' '
      +	git checkout -f main &&
      +	git clean -f &&

-- 
gitgitgadget
