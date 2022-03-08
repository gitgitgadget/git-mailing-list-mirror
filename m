Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86299C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347584AbiCHOkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347565AbiCHOk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54FA38D8A
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u10so27262695wra.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=kk1MRlblAYjK5sXEUGfrwQYKU7ShZoPcHeq9ONQsuPc=;
        b=AN5GCAGO/1HeLtc8QBEwOK0Xq9EM9a4oriratGCQzZFLt3rJNor0qiQ365wquBBNYD
         XP8DtgtlP25e7WgWPBhRUy6xOi5paL0Zf20UDvigwSbMwXGN/b5pvcTf4d6UloAP8a1g
         jg+OgMRYdSuJK65WnJXD7qORfE2AMSED1+zgFdjGgV0cLuklzZ4sQmGht/wZLPZS0FSy
         3ZYwIyp1OSSGfrVFYlpyjmgBij5/Q9tMOlv+44dmsmcAM8NxJepVbcMKijgiqtwlOO96
         5qx6dghNejidvvmEP/VEZAPrJiyzNWffAk+HZ54On31qV844P6qRyE1KRnapxqJenQJJ
         pdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=kk1MRlblAYjK5sXEUGfrwQYKU7ShZoPcHeq9ONQsuPc=;
        b=cNX2pe+lsmbGRsDLE7/sCrmAhnfUPML1m3kV2OI+7TP7OFD8EB0cegkauYVcWiEYWm
         medGpV59NeIlyaQHct23w4wgF/9imosh8VWKFPnl96mlGALgW1PhsmgRFtk2niqMv3EE
         w2DpyfprXrF2+mKBAHrP/o8hA9DjbkVXnT69Lhh1pNmBggObcqL8fGBhNEsJt4XWqvxO
         wssx/M0y9RVYjxya6FR1d8Rg6no0YR+GrCZOr+xOhObospHkqKxn0/eaBfmF06Uhabx2
         MHs9fhpimzORoOyKzJeqWCeXE5irUCRF9NBZ6XtHzvj1hiSge9YVvxQ7hkkUpGo4fvdU
         prrQ==
X-Gm-Message-State: AOAM531TzE4W28y5ZGv6WzTDKtlZQa1WInuEzykDZpZ1G0q6p/eqpUXi
        ApTmhPGfh4uZFj7ocyzt556I17FIv6o=
X-Google-Smtp-Source: ABdhPJyZ/db1PC1J/ppNDbV/iReOhIz0ufxZ6C17mNJfbsbNYR2kLaWVvxrDly30ShuLYmAQHfA49Q==
X-Received: by 2002:adf:90e2:0:b0:1e3:f5a:553c with SMTP id i89-20020adf90e2000000b001e30f5a553cmr12185852wri.476.1646750367299;
        Tue, 08 Mar 2022 06:39:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm2275307wmn.46.2022.03.08.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:26 -0800 (PST)
Message-Id: <782182a26e37eb8e84aef7d8cc67cf276b2abb54.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:14 +0000
Subject: [PATCH v3 07/12] list-objects: handle NULL function pointers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

If a caller to traverse_commit_list() specifies the options for the
--objects flag but does not specify a show_object function pointer, the
result is a segfault. This is currently visible by running 'git bundle
create --objects HEAD'.

We could fix this problem by supplying a no-op callback in
builtin/bundle.c, but that only solves the problem for one builtin,
leaving this segfault open for other callers.

Replace all callers of the show_commit and show_object function pointers
in list-objects.c to be local methods show_commit() and show_object()
which check that the given contex has non-NULL functions before passing
the necessary data. One extra benefit is that it reduces duplication
due to passing ctx->show_data to every caller.

Test that this segfault no longer occurs for 'git bundle'.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               |  2 ++
 list-objects.c         | 27 ++++++++++++++++++++++-----
 t/t6020-bundle-misc.sh | 12 ++++++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index a0bb687b0f4..7ba60a573d7 100644
--- a/bundle.c
+++ b/bundle.c
@@ -544,6 +544,8 @@ int create_bundle(struct repository *r, const char *path,
 		die("revision walk setup failed");
 	bpi.fd = bundle_fd;
 	bpi.pending = &revs_copy.pending;
+
+	revs.blob_objects = revs.tree_objects = 0;
 	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
 	object_array_remove_duplicates(&revs_copy.pending);
 
diff --git a/list-objects.c b/list-objects.c
index 9422625b39e..0af0bef1dbc 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -21,6 +21,23 @@ struct traversal_context {
 	struct filter *filter;
 };
 
+static void show_commit(struct traversal_context *ctx,
+			struct commit *commit)
+{
+	if (!ctx->show_commit)
+		return;
+	ctx->show_commit(commit, ctx->show_data);
+}
+
+static void show_object(struct traversal_context *ctx,
+			struct object *object,
+			const char *name)
+{
+	if (!ctx->show_object)
+		return;
+	ctx->show_object(object, name, ctx->show_data);
+}
+
 static void process_blob(struct traversal_context *ctx,
 			 struct blob *blob,
 			 struct strbuf *path,
@@ -60,7 +77,7 @@ static void process_blob(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, path->buf, ctx->show_data);
+		show_object(ctx, obj, path->buf);
 	strbuf_setlen(path, pathlen);
 }
 
@@ -194,7 +211,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		show_object(ctx, obj, base->buf);
 	if (base->len)
 		strbuf_addch(base, '/');
 
@@ -210,7 +227,7 @@ static void process_tree(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(obj, base->buf, ctx->show_data);
+		show_object(ctx, obj, base->buf);
 
 	strbuf_setlen(base, baselen);
 	free_tree_buffer(tree);
@@ -228,7 +245,7 @@ static void process_tag(struct traversal_context *ctx,
 	if (r & LOFR_MARK_SEEN)
 		tag->object.flags |= SEEN;
 	if (r & LOFR_DO_SHOW)
-		ctx->show_object(&tag->object, name, ctx->show_data);
+		show_object(ctx, &tag->object, name);
 }
 
 static void mark_edge_parents_uninteresting(struct commit *commit,
@@ -402,7 +419,7 @@ static void do_traverse(struct traversal_context *ctx)
 		if (r & LOFR_MARK_SEEN)
 			commit->object.flags |= SEEN;
 		if (r & LOFR_DO_SHOW)
-			ctx->show_commit(commit, ctx->show_data);
+			show_commit(ctx, commit);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
 			/*
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index b13e8a52a93..6522401617d 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -475,4 +475,16 @@ test_expect_success 'clone from bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unfiltered bundle with --objects' '
+	git bundle create all-objects.bdl \
+		--all --objects &&
+	git bundle create all.bdl \
+		--all &&
+
+	# Compare the headers of these files.
+	head -11 all.bdl >expect &&
+	head -11 all-objects.bdl >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

