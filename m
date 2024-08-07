Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFC1448C6
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059780; cv=none; b=FgqrGVR4ciird2K+hTUbc9nFSMlwc5wn53PKx/fg5EeXt3qTQh+5Ouu2G/osq2SIRaXvpYLybSpAbQnypBWKs9Du2AIAbW01uY82cioGNIoSU8oBROthVqB2R3J4kM2CuV1CiUVAmz7BQdWS6w4nTI6iIWefebppshuu33hrFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059780; c=relaxed/simple;
	bh=XtjUQu3lf8BLsyCL/irBiEaJrJUc3B1URRDicP4fVU4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BV9dgDwhGmAV2O+Atqud36qEQydabQNTTzoDaGjT7+UXBi9tNOZB5eLpApI05e2wn/tOZnikUXs0yh5IbIDbn3OsmOkBgeXlrh0WrUPNeLog3YRxDEe7XPLnneEikQ4NL2Uw0iOVxv2VxRRsNAxXNWZGkD22RJdgDz6BDW7RYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjMivH+J; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjMivH+J"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so232403e87.1
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723059774; x=1723664574; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0BELqsI7pxS11x2iqrrc1eRCoMowfT+roLVQ52N3J8=;
        b=cjMivH+J1+aEXxNUHdmTVj+xKkOn5eRQ/G8utvtZdUvOSiL5kJYtcVQSamuTAA4pVe
         6TjpXWn85ASh7NXCtwyioCb4zffbFHNfuTnV5SWv0lwWtSJstCdRdxwUdpRtH3hCZ+4A
         ilLDcG8WSG9OZKDfPilvaKcCxwnAZbwkrGNnyDAq++lEim1HWlTDgfWtdFvKeJdFQdCN
         uXNkZQhLRyiFgxiiO+aN9000dX3WrOLEcSZiUd+Yto3BzWbkELoGBmBeRAMwbQ7e1P+1
         ULSZqmUZARTmVFqCtsGSV0d7TqMKIyLX/kdbnnk1duOMFVHpEvepHgFHgp8puHGEES17
         pDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723059774; x=1723664574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0BELqsI7pxS11x2iqrrc1eRCoMowfT+roLVQ52N3J8=;
        b=HDUwcf2z5E6zBb68g6xUE2RbFvb91PiTsGv2H2aPmnAPYSaZh5qcGCvQjXyMb8UGHK
         T0Pwg5GxuXBtMEeIVgs6VKpwoEhSKFuDI/xlx84tSxSpRH6B/rbBbDXfQ3t787of7Ftq
         LEXi82i5et8iU9uZKdqdievz4Grz65wS9DLIhJZuIw9lJ9xLMbog4EPFAUo0JxcEwhjD
         FLjCgI0Fin8Mat17hUDtOrAe/9cTYCCh+jnSe/SoKmcg5Eq4alcDB9JqMBRY1AHkFx4z
         qRbfbzrAPT1Fxcc08bDiGh/c37LIdWTpTTQRzSNYQtoRGgePngE/8nxprcTMDoZUOztK
         ZT7Q==
X-Gm-Message-State: AOJu0YwWlmBZ9m8JiI0BYUAqCKwL6yrBo7r5VaGPIqAptUYtE0m+fHY+
	iullDfFkX8dlzXymOOHrm+xN5525quk5N3KJ9TYv4aRCzEGSxLw3EhjCgQ==
X-Google-Smtp-Source: AGHT+IEs+sMyWSlSFngmYhKwETVLzlMg+5LpTclz60iY1ASO6lvs26mlwaTwkoAay9IHk8Hj/c2VtA==
X-Received: by 2002:a05:6512:1094:b0:52e:f950:31e9 with SMTP id 2adb3069b0e04-530bb36677cmr12839531e87.4.1723059773275;
        Wed, 07 Aug 2024 12:42:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0c314sm16686752f8f.12.2024.08.07.12.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:42:52 -0700 (PDT)
Message-Id: <0b6e732ad7e6c37dc02c53f6b48404846576c0b2.1723059769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
References: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
	<pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Aug 2024 19:42:47 +0000
Subject: [PATCH v3 2/3] refs: add referent to each_ref_fn
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
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    Linus Arver <linusarver@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Add a parameter to each_ref_fn so that callers to the ref APIs
that use this function as a callback can have acess to the
unresolved value of a symbolic ref.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 bisect.c                    |  3 ++-
 builtin/bisect.c            |  4 +++-
 builtin/checkout.c          |  2 +-
 builtin/describe.c          |  2 +-
 builtin/fetch.c             |  3 ++-
 builtin/fsck.c              |  4 ++--
 builtin/gc.c                |  1 +
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      |  5 +++--
 builtin/receive-pack.c      |  2 +-
 builtin/remote.c            |  4 +++-
 builtin/repack.c            |  1 +
 builtin/replace.c           |  1 +
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       |  8 ++++----
 builtin/show-ref.c          |  3 ++-
 builtin/submodule--helper.c |  1 +
 builtin/worktree.c          |  1 +
 commit-graph.c              |  1 +
 delta-islands.c             |  2 +-
 fetch-pack.c                |  2 ++
 help.c                      |  2 +-
 http-backend.c              |  4 ++--
 log-tree.c                  |  2 +-
 ls-refs.c                   |  4 ++--
 midx-write.c                |  2 +-
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  2 +-
 object-name.c               |  2 +-
 pseudo-merge.c              |  1 +
 reachable.c                 |  2 +-
 ref-filter.c                |  4 ++--
 reflog.c                    |  1 +
 refs.c                      | 14 +++++++-------
 refs.h                      |  2 +-
 refs/files-backend.c        |  2 +-
 refs/iterator.c             |  2 +-
 remote.c                    |  4 ++--
 replace-object.c            |  1 +
 revision.c                  |  2 +-
 server-info.c               |  2 +-
 shallow.c                   |  2 ++
 submodule.c                 |  2 ++
 t/helper/test-ref-store.c   |  2 +-
 upload-pack.c               |  8 ++++----
 walker.c                    |  1 +
 worktree.c                  |  2 +-
 48 files changed, 78 insertions(+), 54 deletions(-)

diff --git a/bisect.c b/bisect.c
index 135f94ba097..4406fc44cf9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -448,7 +448,7 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	clear_commit_weight(&commit_weight);
 }
 
-static int register_ref(const char *refname, const struct object_id *oid,
+static int register_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			int flags UNUSED, void *cb_data UNUSED)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
@@ -1170,6 +1170,7 @@ int estimate_bisect_steps(int all)
 }
 
 static int mark_for_removal(const char *refname,
+			    const char *referent UNUSED,
 			    const struct object_id *oid UNUSED,
 			    int flag UNUSED, void *cb_data)
 {
diff --git a/builtin/bisect.c b/builtin/bisect.c
index dabce9b542b..453a6cccd70 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -356,6 +356,7 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 }
 
 static int inc_nr(const char *refname UNUSED,
+		  const char *referent UNUSED,
 		  const struct object_id *oid UNUSED,
 		  int flag UNUSED, void *cb_data)
 {
@@ -545,7 +546,7 @@ finish:
 	return res;
 }
 
-static int add_bisect_ref(const char *refname, const struct object_id *oid,
+static int add_bisect_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			  int flags UNUSED, void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
@@ -1162,6 +1163,7 @@ static int bisect_visualize(struct bisect_terms *terms, int argc,
 }
 
 static int get_first_good(const char *refname UNUSED,
+			  const char *referent UNUSED,
 			  const struct object_id *oid,
 			  int flag UNUSED, void *cb_data)
 {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3cf44b4683a..562778885e1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1045,7 +1045,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		report_tracking(new_branch_info);
 }
 
-static int add_pending_uninteresting_ref(const char *refname,
+static int add_pending_uninteresting_ref(const char *refname, const char *referent UNUSED,
 					 const struct object_id *oid,
 					 int flags UNUSED, void *cb_data)
 {
diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2d..d95a9109eed 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -145,7 +145,7 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const struct object_id *oid,
+static int get_name(const char *path, const char *referent UNUSED, const struct object_id *oid,
 		    int flag UNUSED, void *cb_data UNUSED)
 {
 	int is_tag = 0;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 693f02b9580..c297569a473 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -286,7 +286,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	return ent;
 }
 
-static int add_one_refname(const char *refname,
+static int add_one_refname(const char *refname, const char *referent UNUSED,
 			   const struct object_id *oid,
 			   int flag UNUSED, void *cbdata)
 {
@@ -1464,6 +1464,7 @@ static void set_option(struct transport *transport, const char *name, const char
 
 
 static int add_oid(const char *refname UNUSED,
+		   const char *referent UNUSED,
 		   const struct object_id *oid,
 		   int flags UNUSED, void *cb_data)
 {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2ed..ef6ee1268bd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -521,7 +521,7 @@ static int fsck_handle_reflog(const char *logname, void *cb_data)
 	return 0;
 }
 
-static int fsck_handle_ref(const char *refname, const struct object_id *oid,
+static int fsck_handle_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			   int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object *obj;
@@ -576,7 +576,7 @@ static void get_default_heads(void)
 		strbuf_worktree_ref(wt, &ref, "HEAD");
 		fsck_head_link(ref.buf, &head_points_at, &head_oid);
 		if (head_points_at && !is_null_oid(&head_oid))
-			fsck_handle_ref(ref.buf, &head_oid, 0, NULL);
+			fsck_handle_ref(ref.buf, NULL, &head_oid, 0, NULL);
 		strbuf_release(&ref);
 
 		if (include_reflogs)
diff --git a/builtin/gc.c b/builtin/gc.c
index 72bac2554fc..65be7c31b33 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -836,6 +836,7 @@ struct cg_auto_data {
 };
 
 static int dfs_on_ref(const char *refname UNUSED,
+		      const char *referent UNUSED,
 		      const struct object_id *oid,
 		      int flags UNUSED,
 		      void *cb_data)
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 70e9ec4e477..52016f1cf7d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -337,7 +337,7 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 	return a->taggerdate != b->taggerdate;
 }
 
-static int name_ref(const char *path, const struct object_id *oid,
+static int name_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 		    int flags UNUSED, void *cb_data)
 {
 	struct object *o = parse_object(the_repository, oid);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f395488971f..c481feadbfa 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -771,7 +771,7 @@ static enum write_one_status write_one(struct hashfile *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path UNUSED, const struct object_id *oid,
+static int mark_tagged(const char *path UNUSED, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id peeled;
@@ -3129,7 +3129,7 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *tag UNUSED, const struct object_id *oid,
+static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id peeled;
@@ -4076,6 +4076,7 @@ static void record_recent_commit(struct commit *commit, void *data UNUSED)
 }
 
 static int mark_bitmap_preferred_tip(const char *refname,
+				     const char *referent UNUSED,
 				     const struct object_id *oid,
 				     int flags UNUSED,
 				     void *data UNUSED)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 339524ae2a8..6e0f462efbb 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -300,7 +300,7 @@ static void show_ref(const char *path, const struct object_id *oid)
 	}
 }
 
-static int show_ref_cb(const char *path_full, const struct object_id *oid,
+static int show_ref_cb(const char *path_full, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED, void *data)
 {
 	struct oidset *seen = data;
diff --git a/builtin/remote.c b/builtin/remote.c
index 08292498bde..9a3db1b0f13 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -543,6 +543,7 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
+				  const char *referent UNUSED,
 				  const struct object_id *oid UNUSED,
 				  int flags UNUSED, void *cb_data)
 {
@@ -585,7 +586,7 @@ struct rename_info {
 	uint32_t symrefs_nr;
 };
 
-static int read_remote_branches(const char *refname,
+static int read_remote_branches(const char *refname, const char *referent UNUSED,
 				const struct object_id *oid UNUSED,
 				int flags UNUSED, void *cb_data)
 {
@@ -971,6 +972,7 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
+				      const char *referent UNUSED,
 				      const struct object_id *oid UNUSED,
 				      int flags, void *cb_data)
 {
diff --git a/builtin/repack.c b/builtin/repack.c
index f0317fa94ad..d9ea6cecbf9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -667,6 +667,7 @@ struct midx_snapshot_ref_data {
 };
 
 static int midx_snapshot_ref_one(const char *refname UNUSED,
+				 const char *referent UNUSED,
 				 const struct object_id *oid,
 				 int flag UNUSED, void *_data)
 {
diff --git a/builtin/replace.c b/builtin/replace.c
index 1ef833c07f5..34cc4672bc1 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -49,6 +49,7 @@ struct show_data {
 };
 
 static int show_reference(const char *refname,
+			  const char *referent UNUSED,
 			  const struct object_id *oid,
 			  int flag UNUSED, void *cb_data)
 {
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2e64f5bda70..a7084ca157f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -211,7 +211,7 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const struct object_id *oid,
+static int show_reference(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED, void *cb_data UNUSED)
 {
 	if (ref_excluded(&ref_excludes, refname))
@@ -220,7 +220,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int anti_reference(const char *refname, const struct object_id *oid,
+static int anti_reference(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED, void *cb_data UNUSED)
 {
 	show_rev(REVERSED, oid, refname);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d72f4cb98de..3427c1572e5 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -410,7 +410,7 @@ static int append_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const struct object_id *oid,
+static int append_head_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			   int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id tmp;
@@ -425,7 +425,7 @@ static int append_head_ref(const char *refname, const struct object_id *oid,
 	return append_ref(refname + ofs, oid, 0);
 }
 
-static int append_remote_ref(const char *refname, const struct object_id *oid,
+static int append_remote_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			     int flag UNUSED, void *cb_data UNUSED)
 {
 	struct object_id tmp;
@@ -451,7 +451,7 @@ static int append_tag_ref(const char *refname, const struct object_id *oid,
 static const char *match_ref_pattern = NULL;
 static int match_ref_slash = 0;
 
-static int append_matching_ref(const char *refname, const struct object_id *oid,
+static int append_matching_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			       int flag, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
@@ -468,7 +468,7 @@ static int append_matching_ref(const char *refname, const struct object_id *oid,
 	if (wildmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
-		return append_head_ref(refname, oid, flag, cb_data);
+		return append_head_ref(refname, NULL, oid, flag, cb_data);
 	if (starts_with(refname, "refs/tags/"))
 		return append_tag_ref(refname, oid, flag, cb_data);
 	return append_ref(refname, oid, 0);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 839a5c29f31..04e0db707c6 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -63,7 +63,7 @@ struct show_ref_data {
 	int show_head;
 };
 
-static int show_ref(const char *refname, const struct object_id *oid,
+static int show_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flag UNUSED, void *cbdata)
 {
 	struct show_ref_data *data = cbdata;
@@ -97,6 +97,7 @@ match:
 }
 
 static int add_existing(const char *refname,
+			const char *referent UNUSED,
 			const struct object_id *oid UNUSED,
 			int flag UNUSED, void *cbdata)
 {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 880ab4456ee..1cdcc465b1c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -609,6 +609,7 @@ static void print_status(unsigned int flags, char state, const char *path,
 }
 
 static int handle_submodule_head_ref(const char *refname UNUSED,
+				     const char *referent UNUSED,
 				     const struct object_id *oid,
 				     int flags UNUSED,
 				     void *cb_data)
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1d51e54fcdc..2e16218c655 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -626,6 +626,7 @@ static void print_preparing_worktree_line(int detach,
  * Returns 0 on failure and non-zero on success.
  */
 static int first_valid_ref(const char *refname UNUSED,
+			   const char *referent UNUSED,
 			   const struct object_id *oid UNUSED,
 			   int flags UNUSED,
 			   void *cb_data UNUSED)
diff --git a/commit-graph.c b/commit-graph.c
index 79b0e72cc42..aa6e08eb39c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1847,6 +1847,7 @@ struct refs_cb_data {
 };
 
 static int add_ref_to_set(const char *refname UNUSED,
+			  const char *referent UNUSED,
 			  const struct object_id *oid,
 			  int flags UNUSED, void *cb_data)
 {
diff --git a/delta-islands.c b/delta-islands.c
index ffe1ca28144..84435512593 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -390,7 +390,7 @@ static void add_ref_to_island(kh_str_t *remote_islands, const char *island_name,
 	rl->hash += sha_core;
 }
 
-static int find_island_for_ref(const char *refname, const struct object_id *oid,
+static int find_island_for_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			       int flags UNUSED, void *cb)
 {
 	struct island_load_data *ild = cb;
diff --git a/fetch-pack.c b/fetch-pack.c
index 732511604b1..58b4581ad80 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -183,6 +183,7 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 }
 
 static int rev_list_insert_ref_oid(const char *refname UNUSED,
+				   const char *referent UNUSED,
 				   const struct object_id *oid,
 				   int flag UNUSED,
 				   void *cb_data)
@@ -610,6 +611,7 @@ static int mark_complete(const struct object_id *oid)
 }
 
 static int mark_complete_oid(const char *refname UNUSED,
+			     const char *referent UNUSED,
 			     const struct object_id *oid,
 			     int flag UNUSED,
 			     void *cb_data UNUSED)
diff --git a/help.c b/help.c
index a6b4d3b1ebd..c03863f2265 100644
--- a/help.c
+++ b/help.c
@@ -804,7 +804,7 @@ struct similar_ref_cb {
 	struct string_list *similar_refs;
 };
 
-static int append_similar_ref(const char *refname,
+static int append_similar_ref(const char *refname, const char *referent UNUSED,
 			      const struct object_id *oid UNUSED,
 			      int flags UNUSED, void *cb_data)
 {
diff --git a/http-backend.c b/http-backend.c
index 461424972b6..79ce097359b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -512,7 +512,7 @@ static void run_service(const char **argv, int buffer_input)
 		exit(1);
 }
 
-static int show_text_ref(const char *name, const struct object_id *oid,
+static int show_text_ref(const char *name, const char *referent UNUSED, const struct object_id *oid,
 			 int flag UNUSED, void *cb_data)
 {
 	const char *name_nons = strip_namespace(name);
@@ -568,7 +568,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 	strbuf_release(&buf);
 }
 
-static int show_head_ref(const char *refname, const struct object_id *oid,
+static int show_head_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			 int flag, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
diff --git a/log-tree.c b/log-tree.c
index 52feec4356a..40306434556 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -145,7 +145,7 @@ static int ref_filter_match(const char *refname,
 	return 1;
 }
 
-static int add_ref_decoration(const char *refname, const struct object_id *oid,
+static int add_ref_decoration(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			      int flags UNUSED,
 			      void *cb_data)
 {
diff --git a/ls-refs.c b/ls-refs.c
index 2dd925b43d0..c824aea7146 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -77,7 +77,7 @@ struct ls_refs_data {
 	unsigned unborn : 1;
 };
 
-static int send_ref(const char *refname, const struct object_id *oid,
+static int send_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flag, void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
@@ -135,7 +135,7 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 	oid_is_null = is_null_oid(&oid);
 	if (!oid_is_null ||
 	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
-		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
+		send_ref(namespaced.buf, NULL, oid_is_null ? NULL : &oid, flag, data);
 	strbuf_release(&namespaced);
 }
 
diff --git a/midx-write.c b/midx-write.c
index 478b42e7209..56d1717f9f1 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -655,7 +655,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	trace2_region_leave("midx", "prepare_midx_packing_data", the_repository);
 }
 
-static int add_ref_to_pending(const char *refname,
+static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
 			      const struct object_id *oid,
 			      int flag, void *cb_data)
 {
diff --git a/negotiator/default.c b/negotiator/default.c
index e3fa5c33249..c479da9b091 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -38,7 +38,7 @@ static void rev_list_push(struct negotiation_state *ns,
 	}
 }
 
-static int clear_marks(const char *refname, const struct object_id *oid,
+static int clear_marks(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED,
 		       void *cb_data UNUSED)
 {
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index f109928ad0b..f65d47858b4 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -75,7 +75,7 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 	return entry;
 }
 
-static int clear_marks(const char *refname, const struct object_id *oid,
+static int clear_marks(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		       int flag UNUSED,
 		       void *cb_data UNUSED)
 {
diff --git a/notes.c b/notes.c
index 1ba6412aae8..da42df282d5 100644
--- a/notes.c
+++ b/notes.c
@@ -932,7 +932,7 @@ out:
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname,
+static int string_list_add_one_ref(const char *refname, const char *referent UNUSED,
 				   const struct object_id *oid UNUSED,
 				   int flag UNUSED, void *cb)
 {
diff --git a/object-name.c b/object-name.c
index 527b853ac45..7cca43020f2 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1365,7 +1365,7 @@ struct handle_one_ref_cb {
 	struct commit_list **list;
 };
 
-static int handle_one_ref(const char *path, const struct object_id *oid,
+static int handle_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED,
 			  void *cb_data)
 {
diff --git a/pseudo-merge.c b/pseudo-merge.c
index f0fde13c471..77a83b9c5ce 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -201,6 +201,7 @@ void load_pseudo_merges_from_config(struct string_list *list)
 }
 
 static int find_pseudo_merge_group_for_ref(const char *refname,
+					   const char *referent UNUSED,
 					   const struct object_id *oid,
 					   int flags UNUSED,
 					   void *_data)
diff --git a/reachable.c b/reachable.c
index 46613a6bb6f..3e9b3dd0a46 100644
--- a/reachable.c
+++ b/reachable.c
@@ -79,7 +79,7 @@ static void add_rebase_files(struct rev_info *revs)
 	free_worktrees(worktrees);
 }
 
-static int add_one_ref(const char *path, const struct object_id *oid,
+static int add_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 		       int flag, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info *)cb_data;
diff --git a/ref-filter.c b/ref-filter.c
index 8c5e673fc0a..39997890feb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2865,7 +2865,7 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int filter_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int filter_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
@@ -2900,7 +2900,7 @@ struct ref_filter_and_format_cbdata {
 	} internal;
 };
 
-static int filter_and_format_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+static int filter_and_format_one(const char *refname, const char *referent UNUSED, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref_filter_and_format_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *ref;
diff --git a/reflog.c b/reflog.c
index 5ca944529b3..d592c1cfb56 100644
--- a/reflog.c
+++ b/reflog.c
@@ -300,6 +300,7 @@ int should_expire_reflog_ent_verbose(struct object_id *ooid,
 }
 
 static int push_tip_to_list(const char *refname UNUSED,
+			    const char *referent UNUSED,
 			    const struct object_id *oid,
 			    int flags, void *cb_data)
 {
diff --git a/refs.c b/refs.c
index bb90a188758..0a5c12cf16b 100644
--- a/refs.c
+++ b/refs.c
@@ -414,7 +414,7 @@ int refs_ref_exists(struct ref_store *refs, const char *refname)
 					 NULL, NULL);
 }
 
-static int for_each_filter_refs(const char *refname,
+static int for_each_filter_refs(const char *refname, const char *referent,
 				const struct object_id *oid,
 				int flags, void *data)
 {
@@ -424,7 +424,7 @@ static int for_each_filter_refs(const char *refname,
 		return 0;
 	if (filter->prefix)
 		skip_prefix(refname, filter->prefix, &refname);
-	return filter->fn(refname, oid, flags, filter->cb_data);
+	return filter->fn(refname, referent, oid, flags, filter->cb_data);
 }
 
 struct warn_if_dangling_data {
@@ -435,7 +435,7 @@ struct warn_if_dangling_data {
 	const char *msg_fmt;
 };
 
-static int warn_if_dangling_symref(const char *refname,
+static int warn_if_dangling_symref(const char *refname, const char *referent UNUSED,
 				   const struct object_id *oid UNUSED,
 				   int flags, void *cb_data)
 {
@@ -506,7 +506,7 @@ int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void *cb_da
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
 	if (!refs_read_ref_full(refs, buf.buf, RESOLVE_REF_READING, &oid, &flag))
-		ret = fn(buf.buf, &oid, flag, cb_data);
+		ret = fn(buf.buf, NULL, &oid, flag, cb_data);
 	strbuf_release(&buf);
 
 	return ret;
@@ -1547,7 +1547,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
 				    &oid, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
+		return fn("HEAD", NULL, &oid, flag, cb_data);
 
 	return 0;
 }
@@ -2387,7 +2387,7 @@ struct do_for_each_reflog_help {
 	void *cb_data;
 };
 
-static int do_for_each_reflog_helper(const char *refname,
+static int do_for_each_reflog_helper(const char *refname, const char *referent,
 				     const struct object_id *oid UNUSED,
 				     int flags,
 				     void *cb_data)
@@ -2593,7 +2593,7 @@ struct migration_data {
 	struct strbuf *errbuf;
 };
 
-static int migrate_one_ref(const char *refname, const struct object_id *oid,
+static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			   int flags, void *cb_data)
 {
 	struct migration_data *data = cb_data;
diff --git a/refs.h b/refs.h
index 0ecba21b4a7..158e0a12197 100644
--- a/refs.h
+++ b/refs.h
@@ -298,7 +298,7 @@ struct ref_transaction;
  * arguments is only guaranteed to be valid for the duration of a
  * single callback invocation.
  */
-typedef int each_ref_fn(const char *refname,
+typedef int each_ref_fn(const char *refname, const char *referent,
 			const struct object_id *oid, int flags, void *cb_data);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5ed69c23f74..ad5f0c21771 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3046,7 +3046,7 @@ static int files_transaction_abort(struct ref_store *ref_store,
 	return 0;
 }
 
-static int ref_present(const char *refname,
+static int ref_present(const char *refname, const char *referent UNUSED,
 		       const struct object_id *oid UNUSED,
 		       int flags UNUSED,
 		       void *cb_data)
diff --git a/refs/iterator.c b/refs/iterator.c
index 75fbe5d72ab..8e999d81fc6 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -450,7 +450,7 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		retval = fn(iter->refname, iter->oid, iter->flags, cb_data);
+		retval = fn(iter->refname, iter->referent, iter->oid, iter->flags, cb_data);
 		if (retval) {
 			/*
 			 * If ref_iterator_abort() returns ITER_ERROR,
diff --git a/remote.c b/remote.c
index f43cf5e7a4d..4a1269a47ab 100644
--- a/remote.c
+++ b/remote.c
@@ -2354,7 +2354,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	return 1;
 }
 
-static int one_local_ref(const char *refname, const struct object_id *oid,
+static int one_local_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			 int flag UNUSED,
 			 void *cb_data)
 {
@@ -2439,7 +2439,7 @@ struct stale_heads_info {
 	struct refspec *rs;
 };
 
-static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
+static int get_stale_heads_cb(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
diff --git a/replace-object.c b/replace-object.c
index 59252d565ef..9a3cdd809a9 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -9,6 +9,7 @@
 #include "commit.h"
 
 static int register_replace_ref(const char *refname,
+				const char *referent UNUSED,
 				const struct object_id *oid,
 				int flag UNUSED,
 				void *cb_data)
diff --git a/revision.c b/revision.c
index 1c0192f5225..6b33bd814f7 100644
--- a/revision.c
+++ b/revision.c
@@ -1648,7 +1648,7 @@ struct all_refs_cb {
 	struct worktree *wt;
 };
 
-static int handle_one_ref(const char *path, const struct object_id *oid,
+static int handle_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 			  int flag UNUSED,
 			  void *cb_data)
 {
diff --git a/server-info.c b/server-info.c
index f61296a60d0..1508fa6f825 100644
--- a/server-info.c
+++ b/server-info.c
@@ -147,7 +147,7 @@ out:
 	return ret;
 }
 
-static int add_info_ref(const char *path, const struct object_id *oid,
+static int add_info_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
 			int flag UNUSED,
 			void *cb_data)
 {
diff --git a/shallow.c b/shallow.c
index 31a6ca40fe2..b8cd051e3b6 100644
--- a/shallow.c
+++ b/shallow.c
@@ -612,6 +612,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 }
 
 static int mark_uninteresting(const char *refname UNUSED,
+			      const char *referent UNUSED,
 			      const struct object_id *oid,
 			      int flags UNUSED,
 			      void *cb_data UNUSED)
@@ -727,6 +728,7 @@ struct commit_array {
 };
 
 static int add_ref(const char *refname UNUSED,
+		  const char *referent UNUSED,
 		   const struct object_id *oid,
 		   int flags UNUSED,
 		   void *cb_data)
diff --git a/submodule.c b/submodule.c
index ab99a302530..7c0f5db861d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -953,6 +953,7 @@ static void free_submodules_data(struct string_list *submodules)
 }
 
 static int has_remote(const char *refname UNUSED,
+		      const char *referent UNUSED,
 		      const struct object_id *oid UNUSED,
 		      int flags UNUSED, void *cb_data UNUSED)
 {
@@ -1273,6 +1274,7 @@ int push_unpushed_submodules(struct repository *r,
 }
 
 static int append_oid_to_array(const char *ref UNUSED,
+			       const char *referent UNUSED,
 			       const struct object_id *oid,
 			       int flags UNUSED, void *data)
 {
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 637b8b294e9..65346dee551 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -156,7 +156,7 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 	return refs_rename_ref(refs, oldref, newref, logmsg);
 }
 
-static int each_ref(const char *refname, const struct object_id *oid,
+static int each_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flags, void *cb_data UNUSED)
 {
 	printf("%s %s 0x%x\n", oid_to_hex(oid), refname, flags);
diff --git a/upload-pack.c b/upload-pack.c
index 0052c6a4dce..f03ba3e98be 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -857,7 +857,7 @@ static void send_unshallow(struct upload_pack_data *data)
 	}
 }
 
-static int check_ref(const char *refname_full, const struct object_id *oid,
+static int check_ref(const char *refname_full, const char *referent UNUSED, const struct object_id *oid,
 		     int flag, void *cb_data);
 static void deepen(struct upload_pack_data *data, int depth)
 {
@@ -1208,7 +1208,7 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 	return 0;
 }
 
-static int check_ref(const char *refname_full, const struct object_id *oid,
+static int check_ref(const char *refname_full, const char *referent UNUSED,const struct object_id *oid,
 		     int flag UNUSED, void *cb_data)
 {
 	const char *refname = strip_namespace(refname_full);
@@ -1276,14 +1276,14 @@ static void write_v0_ref(struct upload_pack_data *data,
 	return;
 }
 
-static int send_ref(const char *refname, const struct object_id *oid,
+static int send_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
 		    int flag UNUSED, void *cb_data)
 {
 	write_v0_ref(cb_data, refname, strip_namespace(refname), oid);
 	return 0;
 }
 
-static int find_symref(const char *refname,
+static int find_symref(const char *refname, const char *referent UNUSED,
 		       const struct object_id *oid UNUSED,
 		       int flag, void *cb_data)
 {
diff --git a/walker.c b/walker.c
index 0fafdc97cf1..807a7a38813 100644
--- a/walker.c
+++ b/walker.c
@@ -221,6 +221,7 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 }
 
 static int mark_complete(const char *path UNUSED,
+			const char *referent UNUSED,
 			 const struct object_id *oid,
 			 int flag UNUSED,
 			 void *cb_data UNUSED)
diff --git a/worktree.c b/worktree.c
index f3c4c8ec54d..fd05f3741c6 100644
--- a/worktree.c
+++ b/worktree.c
@@ -546,7 +546,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 					    refname.buf,
 					    RESOLVE_REF_READING,
 					    &oid, &flag))
-			ret = fn(refname.buf, &oid, flag, cb_data);
+			ret = fn(refname.buf, NULL, &oid, flag, cb_data);
 		if (ret)
 			break;
 	}
-- 
gitgitgadget

