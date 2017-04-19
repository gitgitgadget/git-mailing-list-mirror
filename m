Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F56B1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762436AbdDSLC4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:56 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36131 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762427AbdDSLCx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id 34so3582253pgx.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wzkFKnGsOOYHfIdpebUS5IQpIzBWd5xBCm2/sWr+i0=;
        b=l9TBG42Lm+GN2QzWFDjFUg5JlZZvNSTu7/tD5lD0KT7BBcivJQkpDGc3ajugOUfsIW
         V0GPNhEh7/yNH0tUvw6ADzpcE/ODaoI8hsDeFJwgglCjMrfb5fkTjZqmEGIJM4YnEgsq
         /n/msWjEtTsR3hf98qE5MgvivHpNrjCxzjmswWRpEhxKZmzcmL/fAWfOB9hhQg7Nzzn3
         oj0bOGywG5omc04XBJvVdlgZWuF+cyg03qQb6m0KaPbvRzqIfEWVZOiJ0RnInXAM749y
         bXmrR4Zi0xJ/aBjF69Y6OAHm3LwmpkxC7mSM5J1kFLUTLSJkud2xeYEiGCmkUIz8GuU9
         KDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wzkFKnGsOOYHfIdpebUS5IQpIzBWd5xBCm2/sWr+i0=;
        b=TYYBSQDfJXSQecgzxyBmf1Fk+QUhMq5qyzUwDTu2q3291iOutxLYBdGWqpHAJzsSS1
         L+3myr1OTUTLafHFudc3ODKcVie4Wewjez4Pn4Xs8yit+5tbIMLG/3hlkneQekFQIeja
         32rx5A5i8luc4Gjspa0fOd6mK6NE5n4z8XGBjAyUhMkEciUo8C9etRvfVX0RSWXtVvMF
         KJ1ZXO2WIMt9ZuzUhJNqL88OxJJgdFFSwL2m2i+arg866NfCU04hU6I0j4J3Rz0hh0WH
         UYqG+reviaxDQvZ+M4WHhL9j3FRo+ht8dflM3jbjMvWoQx2lLvVA5onIukFI8YPU4nlj
         QlmQ==
X-Gm-Message-State: AN3rC/7JU1JXOddYtG3QJDZTv00fAXyC9qYW8bnKy+8l64ca1TEziCyZ
        S9mDQ6C5tYwm9g==
X-Received: by 10.98.30.3 with SMTP id e3mr2507044pfe.48.1492599772806;
        Wed, 19 Apr 2017 04:02:52 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id u8sm3977173pfk.103.2017.04.19.04.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 09/12] revision.c: --all adds HEAD from all worktrees
Date:   Wed, 19 Apr 2017 18:01:42 +0700
Message-Id: <20170419110145.5086-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unless single_worktree is set, --all now adds HEAD from all worktrees.

Since reachable.c code does not use setup_revisions(), we need to call
other_head_refs_submodule() explicitly there to have the same effect on
"git prune", so that we won't accidentally delete objects needed by some
other HEADs.

A new FIXME is added because we would need something like

    int refs_other_head_refs(struct ref_store *, each_ref_fn, cb_data);

in addition to other_head_refs() to handle it, which might require

    int get_submodule_worktrees(const char *submodule, int flags);

It could be a separate topic to reduce the scope of this one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 reachable.c      |  1 +
 refs.c           | 22 ++++++++++++++++++++++
 refs.h           |  1 +
 revision.c       | 13 +++++++++++++
 submodule.c      |  2 ++
 t/t5304-prune.sh | 12 ++++++++++++
 6 files changed, 51 insertions(+)

diff --git a/reachable.c b/reachable.c
index a8a979bd4f..a3b938b46c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -177,6 +177,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	/* detached HEAD is not included in the list above */
 	head_ref(add_one_ref, revs);
+	other_head_refs(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/refs.c b/refs.c
index 537052f7ba..23e3607674 100644
--- a/refs.c
+++ b/refs.c
@@ -1780,3 +1780,25 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
 	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
 }
+
+int other_head_refs(each_ref_fn fn, void *cb_data)
+{
+	struct worktree **worktrees, **p;
+	int ret = 0;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct ref_store *refs;
+
+		if (wt->is_current)
+			continue;
+
+		refs = get_worktree_ref_store(wt);
+		ret = refs_head_ref(refs, fn, cb_data);
+		if (ret)
+			break;
+	}
+	free_worktrees(worktrees);
+	return ret;
+}
diff --git a/refs.h b/refs.h
index e06db37118..cc71b6c7a0 100644
--- a/refs.h
+++ b/refs.h
@@ -247,6 +247,7 @@ int refs_for_each_remote_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
 
 int head_ref(each_ref_fn fn, void *cb_data);
+int other_head_refs(each_ref_fn fn, void *cb_data);
 int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
diff --git a/revision.c b/revision.c
index c329070c89..040a0064f6 100644
--- a/revision.c
+++ b/revision.c
@@ -2105,6 +2105,13 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	int argcount;
 
 	if (submodule) {
+		/*
+		 * We need some something like get_submodule_worktrees()
+		 * before we can go through all worktrees of a submodule,
+		 * .e.g with adding all HEADs from --all, which is not
+		 * supported right now, so stick to single worktree.
+		 */
+		assert(revs->single_worktree != 0);
 		refs = get_submodule_ref_store(submodule);
 	} else
 		refs = get_main_ref_store();
@@ -2122,6 +2129,12 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(refs, revs, *flags, refs_for_each_ref);
 		handle_refs(refs, revs, *flags, refs_head_ref);
+		if (!revs->single_worktree) {
+			struct all_refs_cb cb;
+
+			init_all_refs_cb(&cb, revs, *flags);
+			other_head_refs(handle_one_ref, &cb);
+		}
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
diff --git a/submodule.c b/submodule.c
index a31f68812c..8c5af6e7f3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1225,6 +1225,8 @@ static int find_first_merges(struct object_array *result, const char *path,
 			oid_to_hex(&a->object.oid));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
+	/* FIXME: can't handle linked worktrees in submodules yet */
+	revs.single_worktree = path != NULL;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
 
 	/* save all revisions from the above list that contain b */
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index cba45c7be9..683bdb031c 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -292,4 +292,16 @@ test_expect_success 'prune: handle index in multiple worktrees' '
 	test_cmp second-worktree/blob actual
 '
 
+test_expect_success 'prune: handle HEAD in multiple worktrees' '
+	git worktree add --detach third-worktree &&
+	echo "new blob for third-worktree" >third-worktree/blob &&
+	git -C third-worktree add blob &&
+	git -C third-worktree commit -m "third" &&
+	rm .git/worktrees/third-worktree/index &&
+	test_must_fail git -C third-worktree show :blob &&
+	git prune --expire=now &&
+	git -C third-worktree show HEAD:blob >actual &&
+	test_cmp third-worktree/blob actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

