Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5A18DF8E
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924319; cv=none; b=aCI+zTZrp55gb/27oQqjghXvAuTq99VB88od4HDk97nsOhlwb/jIq1RAMu5GhsTUbVCJvPIfA0J/zSQ7dJfcr20orpB5JoANZHEIIduk5HjOxWSW+O9/vzbnXS8Pk2HcBmYPl0ot0r6w9WADXtU0xz47hfmE9jviAArLKjCf2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924319; c=relaxed/simple;
	bh=JAJOkwrVzWz/5/6v6q0wSaJygEgnanZC79jYsGhVboc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VorMwBaa5x/k9vhAtaXEJ3n9awXkUFhxighiPRaOEwyACedASR3RBWYLa/5hYcNj6nwkZtZJG3+eU4kIqgLqERQqpZ09mLbjuW7c0eOM+BM9UMjUJ9g6g/GS6Vnqbeq/q94cRgzJChz80vxsvyPqQhSMI9LZHavFsqrpQE6jmWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KEyV4b5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3V7VXlV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KEyV4b5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3V7VXlV"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E16BF13900F4;
	Thu, 29 Aug 2024 05:38:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 29 Aug 2024 05:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924315; x=1725010715; bh=TcQur1p8L8
	bU3BkUjgyzGUNQjOl+/FFO3SXzc9sojc0=; b=KEyV4b5JULdqBbmrQgRUptbNjd
	ApQxvDNaf5DR+pkj/0bPZU8jHI9/Bzdn7L8Ha8diUGZzj3fe/Jtj+Hoke0TqwuOC
	lW5pkNh7DRNsrpMsvGxmT5xJh6UxqXYTU1jMlwC2/urp5tJnBLdz8KMgCKHuUUjK
	00qGCC/Y0PuWbyuku03inqG4y5bu0h4X35WFFklIEeqopq5l3l6C6y90sTfAnrvB
	j7ngdSuy9bL1mmxlgIvCIm1O8PHoJHa4IYJhUseTgKrjqwZibfqGE17Quq59bwAd
	4I8MlhJaeeYMI2LR6/GzgcIEPOo+wmc9aoMBt2CgNi0PxqRo2E8/NKenLP4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924315; x=1725010715; bh=TcQur1p8L8bU3BkUjgyzGUNQjOl+
	/FFO3SXzc9sojc0=; b=O3V7VXlV/T1NvS8rCZrhquxdazoMwiomVku5e5bOG069
	OO6VkCZovsk80wgN09EvY3jXGTKhZFI2ONN9l1D9oVNziLzbQuXP5W56jTBk4Eu8
	mbQnrB6CVf4ix+Hty+UdSl/CM1YE1MHaDIp++Sn00nAHd9+53hGjDvS7dy0TEFnG
	owGVvHKkPNLPbvke+9HhyrV/46DGG+NmTf2q+5LkWW1V1mSiTzLNeQPxPywfxcZq
	6Kd5nVbiWYt+EjL7EZSpzPsNb+nw7pJ4RtVYc48HGddK2lXCvU66m1BAoUcVcHqx
	bEZYrUx7KCJgLIIZoSMVltNPaP+lCVyUuYWONMYHRw==
X-ME-Sender: <xms:m0HQZoJ2IVuXrhBzp5kHroyBWvJleaYVNAM9fN0jdq-JH2O8zg93Iw>
    <xme:m0HQZoJdhiGtsMJITCY5wpBEcE-Bx4WANgyJMB4oqemB2qVrG191ZOSntGo3xGNYJ
    rupY3HZFrhK8Sn3xw>
X-ME-Received: <xmr:m0HQZov0cOXheC0zVqegFAiS3TkQ5m5U-Q0j7tgswuPqHIzrpoNCJS6vATwTpA-NMyjiqcDvKNAMyIcDzu8jBiyx3EX1rzSIppVBTVr5IpUMy-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:m0HQZlZt1GtSrTmRqrtbib5brp06tHWB6pkxt4herArXzyzGFCEW3Q>
    <xmx:m0HQZvaVOV9MrZGGQmiXc2bLC3O7xlAmUqlbhu8VIUsWa7UNv4ekMg>
    <xmx:m0HQZhB67lvCfYQrd5epClAC-27vaUh6LhuHb_4G3eGu-8II4ciCRg>
    <xmx:m0HQZlbqkT-GPFt4QXn11J-x-IPRVt2iQHjhrQV7CMxhvXhObeihNg>
    <xmx:m0HQZukr6T3PfjjwZdAcm_Bcjc-mWcZsRY65ZVOzilw3TslSlxX2Hp7t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58aa4f52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:26 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 03/21] environment: make `get_object_directory()` accept a
 repository
Message-ID: <bb01e4fab9dd612a0b868b7eddeecc0fcaab3dfb.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

The `get_object_directory()` function retrieves the path to the object
directory for `the_repository`. Make it accept a `struct repository`
such that it can work on arbitrary repositories and make it part of the
repository subsystem. This reduces our reliance on `the_repository` and
clarifies scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c     | 4 ++--
 builtin/count-objects.c    | 2 +-
 builtin/multi-pack-index.c | 2 +-
 builtin/pack-objects.c     | 2 +-
 builtin/prune.c            | 8 ++++----
 builtin/repack.c           | 7 ++++---
 bulk-checkin.c             | 4 ++--
 environment.c              | 7 -------
 environment.h              | 1 -
 fetch-pack.c               | 2 +-
 http-backend.c             | 2 +-
 object-file.c              | 4 ++--
 pack-write.c               | 2 +-
 packfile.c                 | 2 +-
 prune-packed.c             | 4 +++-
 repository.c               | 7 +++++++
 repository.h               | 1 +
 server-info.c              | 3 ++-
 setup.c                    | 2 +-
 tmp-objdir.c               | 7 ++++---
 20 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 7102ee90a00..d7ebdf5c0d8 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -95,7 +95,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_graph_verify_usage, options);
 
 	if (!opts.obj_dir)
-		opts.obj_dir = get_object_directory();
+		opts.obj_dir = repo_get_object_directory(the_repository);
 	if (opts.shallow)
 		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
 	if (opts.progress)
@@ -275,7 +275,7 @@ static int graph_write(int argc, const char **argv, const char *prefix)
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
 	if (!opts.obj_dir)
-		opts.obj_dir = get_object_directory();
+		opts.obj_dir = repo_get_object_directory(the_repository);
 	if (opts.append)
 		flags |= COMMIT_GRAPH_WRITE_APPEND;
 	if (opts.split)
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ec6098a149d..bd99eeaa954 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -116,7 +116,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		report_linked_checkout_garbage(the_repository);
 	}
 
-	for_each_loose_file_in_objdir(get_object_directory(),
+	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
 				      count_loose, count_cruft, NULL, NULL);
 
 	if (verbose) {
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8805cbbeb3b..0b82f7480da 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -63,7 +63,7 @@ static int parse_object_dir(const struct option *opt, const char *arg,
 	char **value = opt->value;
 	free(*value);
 	if (unset)
-		*value = xstrdup(get_object_directory());
+		*value = xstrdup(repo_get_object_directory(the_repository));
 	else
 		*value = real_pathdup(arg, 1);
 	return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 778be80f564..44341b206d4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3940,7 +3940,7 @@ static int add_loose_object(const struct object_id *oid, const char *path,
  */
 static void add_unreachable_loose_objects(void)
 {
-	for_each_loose_file_in_objdir(get_object_directory(),
+	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
 				      add_loose_object,
 				      NULL, NULL, NULL);
 }
diff --git a/builtin/prune.c b/builtin/prune.c
index 57fe31467fe..47eeabbd13a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -193,12 +193,12 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		revs.exclude_promisor_objects = 1;
 	}
 
-	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
-				      prune_cruft, prune_subdir, &revs);
+	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
+				      prune_object, prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(get_object_directory());
-	s = mkpathdup("%s/pack", get_object_directory());
+	remove_temporary_files(repo_get_object_directory(the_repository));
+	s = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
 	remove_temporary_files(s);
 	free(s);
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 62cfa50c50f..40feacb73f8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1240,7 +1240,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (write_midx && write_bitmaps) {
 		struct strbuf path = STRBUF_INIT;
 
-		strbuf_addf(&path, "%s/%s_XXXXXX", get_object_directory(),
+		strbuf_addf(&path, "%s/%s_XXXXXX", repo_get_object_directory(the_repository),
 			    "bitmap-ref-tips");
 
 		refs_snapshot = xmks_tempfile(path.buf);
@@ -1249,7 +1249,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strbuf_release(&path);
 	}
 
-	packdir = mkpathdup("%s/pack", get_object_directory());
+	packdir = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
 	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
@@ -1519,7 +1519,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(get_object_directory(), NULL, NULL, flags);
+		write_midx_file(repo_get_object_directory(the_repository),
+				NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9089c214fa4..2753d5bbe4a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -75,7 +75,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 		close(fd);
 	}
 
-	strbuf_addf(&packname, "%s/pack/pack-%s.", get_object_directory(),
+	strbuf_addf(&packname, "%s/pack/pack-%s.", repo_get_object_directory(the_repository),
 		    hash_to_hex(hash));
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
@@ -113,7 +113,7 @@ static void flush_batch_fsync(void)
 	 * to ensure that the data in each new object file is durable before
 	 * the final name is visible.
 	 */
-	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
 	temp = xmks_tempfile(temp_path.buf);
 	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
 	delete_tempfile(&temp);
diff --git a/environment.c b/environment.c
index 7c4a142ca25..0a2057399e0 100644
--- a/environment.c
+++ b/environment.c
@@ -273,13 +273,6 @@ const char *get_git_work_tree(void)
 	return the_repository->worktree;
 }
 
-const char *get_object_directory(void)
-{
-	if (!the_repository->objects->odb)
-		BUG("git environment hasn't been setup");
-	return the_repository->objects->odb->path;
-}
-
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
diff --git a/environment.h b/environment.h
index d778614158f..91125d82991 100644
--- a/environment.h
+++ b/environment.h
@@ -106,7 +106,6 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-const char *get_object_directory(void);
 char *get_index_file(void);
 char *get_graft_file(struct repository *r);
 void set_git_dir(const char *path, int make_realpath);
diff --git a/fetch-pack.c b/fetch-pack.c
index 58b4581ad80..fddb90f2e78 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1839,7 +1839,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		string_list_append_nodup(pack_lockfiles,
 					 xstrfmt("%s/pack/pack-%s.keep",
-						 get_object_directory(),
+						 repo_get_object_directory(the_repository),
 						 packname));
 	}
 	string_list_clear(&packfile_uris, 0);
diff --git a/http-backend.c b/http-backend.c
index 79ce097359b..73eec4ea3d8 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -601,7 +601,7 @@ static void get_head(struct strbuf *hdr, char *arg UNUSED)
 
 static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
 {
-	size_t objdirlen = strlen(get_object_directory());
+	size_t objdirlen = strlen(repo_get_object_directory(the_repository));
 	struct strbuf buf = STRBUF_INIT;
 	struct packed_git *p;
 	size_t cnt = 0;
diff --git a/object-file.c b/object-file.c
index c5994202ba0..fa4121b98ad 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2053,7 +2053,7 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 		else if (errno == EACCES)
 			return error(_("insufficient permission for adding "
 				       "an object to repository database %s"),
-				     get_object_directory());
+				     repo_get_object_directory(the_repository));
 		else
 			return error_errno(
 				_("unable to create temporary file"));
@@ -2228,7 +2228,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		prepare_loose_object_bulk_checkin();
 
 	/* Since oid is not determined, save tmp file to odb path. */
-	strbuf_addf(&filename, "%s/", get_object_directory());
+	strbuf_addf(&filename, "%s/", repo_get_object_directory(the_repository));
 	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
 
 	/*
diff --git a/pack-write.c b/pack-write.c
index d07f03d0ab0..6cd3f9ef4c6 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -473,7 +473,7 @@ char *index_pack_lockfile(int ip_out, int *is_well_formed)
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
-				       get_object_directory(), name);
+				       repo_get_object_directory(the_repository), name);
 		return NULL;
 	}
 	if (is_well_formed)
diff --git a/packfile.c b/packfile.c
index cf12a539eac..df4ba677197 100644
--- a/packfile.c
+++ b/packfile.c
@@ -30,7 +30,7 @@ char *odb_pack_name(struct strbuf *buf,
 		    const char *ext)
 {
 	strbuf_reset(buf);
-	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(the_repository),
 		    hash_to_hex(hash), ext);
 	return buf->buf;
 }
diff --git a/prune-packed.c b/prune-packed.c
index e54daf740a2..4418268207f 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
@@ -37,7 +39,7 @@ void prune_packed_objects(int opts)
 	if (opts & PRUNE_PACKED_VERBOSE)
 		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
 
-	for_each_loose_file_in_objdir(get_object_directory(),
+	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
 				      prune_object, NULL, prune_subdir, &opts);
 
 	/* Ensure we show 100% before finishing progress */
diff --git a/repository.c b/repository.c
index acf654d7ab6..914ee25a1f0 100644
--- a/repository.c
+++ b/repository.c
@@ -105,6 +105,13 @@ const char *repo_get_common_dir(struct repository *repo)
 	return repo->commondir;
 }
 
+const char *repo_get_object_directory(struct repository *repo)
+{
+	if (!repo->objects->odb)
+		BUG("git environment hasn't been setup");
+	return repo->objects->odb->path;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index 404435ad029..778f1511ab1 100644
--- a/repository.h
+++ b/repository.h
@@ -208,6 +208,7 @@ extern struct repository *the_repository;
 
 const char *repo_get_git_dir(struct repository *repo);
 const char *repo_get_common_dir(struct repository *repo);
+const char *repo_get_object_directory(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/server-info.c b/server-info.c
index 1508fa6f825..ffca36f4675 100644
--- a/server-info.c
+++ b/server-info.c
@@ -342,7 +342,8 @@ static int write_pack_info_file(struct update_info_ctx *uic)
 
 static int update_info_packs(int force)
 {
-	char *infofile = mkpathdup("%s/info/packs", get_object_directory());
+	char *infofile = mkpathdup("%s/info/packs",
+				   repo_get_object_directory(the_repository));
 	int ret;
 
 	init_pack_info(infofile, force);
diff --git a/setup.c b/setup.c
index fe4a5dfc43b..1ebcab625fe 100644
--- a/setup.c
+++ b/setup.c
@@ -2282,7 +2282,7 @@ static void create_object_directory(void)
 	struct strbuf path = STRBUF_INIT;
 	size_t baselen;
 
-	strbuf_addstr(&path, get_object_directory());
+	strbuf_addstr(&path, repo_get_object_directory(the_repository));
 	baselen = path.len;
 
 	safe_create_dir(path.buf, 1);
diff --git a/tmp-objdir.c b/tmp-objdir.c
index a8e4553f274..b648bf97992 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -132,7 +132,8 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	 * can recognize any stale objdirs left behind by a crash and delete
 	 * them.
 	 */
-	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
+	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX",
+		    repo_get_object_directory(the_repository), prefix);
 
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
@@ -152,7 +153,7 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	}
 
 	env_append(&t->env, ALTERNATE_DB_ENVIRONMENT,
-		   absolute_path(get_object_directory()));
+		   absolute_path(repo_get_object_directory(the_repository)));
 	env_replace(&t->env, DB_ENVIRONMENT, absolute_path(t->path.buf));
 	env_replace(&t->env, GIT_QUARANTINE_ENVIRONMENT,
 		    absolute_path(t->path.buf));
@@ -267,7 +268,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	}
 
 	strbuf_addbuf(&src, &t->path);
-	strbuf_addstr(&dst, get_object_directory());
+	strbuf_addstr(&dst, repo_get_object_directory(the_repository));
 
 	ret = migrate_paths(&src, &dst);
 
-- 
2.46.0.421.g159f2d50e7.dirty

