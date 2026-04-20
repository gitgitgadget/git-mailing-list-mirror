Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261D3939D7
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679950; cv=none; b=cH2dglaNstRQ3U9Z/SsL5uVHEXgd2BHbHnys0QWCNiacbrCPLzdRAnNyEqWxpVAB47xDw0v+2aapWHgbHGa0LLJF+Gypv541yzZhIzo2SewXwmRi+33c7mcbbvQcl3EqjziUgjN0tu+p1rNigtGk8o5x0i7pTT57nKZrzttMiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679950; c=relaxed/simple;
	bh=iSS7Hscdi3Jfc7Qt8Y7PZYDkWI4AyrxPGDfDYUvwflE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4dK/+ziMBwww2zx3fRlXEOAldlMWt20HauKoSmC1h+4WzGG8HSfIHr6IVuvT0JTZdjKLXOdLZgwmikuZQhyWs5tCV25M2DXhH7N8R+aVxRjwyl8RCgMGwlW2ZHI75u1TVN5dWPbkLJDhhwzq0XAy3vEOAyGX1kwyrOKzKYsx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUsS/zjC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUsS/zjC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1890336f8f.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679946; x=1777284746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdLdbCvG2MITcbz+fb+bL8q31Ndsi+8yKM0VTRWc6Iw=;
        b=JUsS/zjC7RLE5QrJ/ffPIVPNbt3SNv/F0VDaA6UajtJ120K5CEHsQnDUVsgOGYYt5b
         H9n4/zB2CuQYv2rdGK2irFQLW5IWAc8ktt+XUqGdTjkpiSGvJ15QgSquutduj5cxm2Fz
         PJ2taGuR3Mjlt+Ixd0+/DM4saCesKtdwHQR+cOI17YYGVHKW9IFzva5iJsoy4HTCqUyG
         9RE8V1qlFDOIWpKSc65bMgrxnKGGF90QkC929JEMCKKzVT58ABJXjELgTn7+a/xz6XIW
         NASWXjujV76kscniVOta6IcyGAb2X69xn08k0csUpE1bUbh/JuhuwBkag/BIs+FL31++
         x9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679946; x=1777284746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CdLdbCvG2MITcbz+fb+bL8q31Ndsi+8yKM0VTRWc6Iw=;
        b=H710g5z4Zh9GfHrdxNi07rN5K4uvbUYhRd7a/scZYSsn2DVdhtqD7xb37+HSLQuWbF
         w7kvsb3ZKkGq9q3bpdaOtUQ5g7qZdK5DkuEvnLZU71EJbxfpgU9hryCfoUo9OQyJujYc
         aLOtlq3Qhb5chxWlKwDsFgUKsZ8xLX7jN9qVfco3VBWlbjmZjrhAX+cfAOC7oyxyNicF
         qGZqlzhjHvx8NbZwohYN0Knf3lBuRF5uOG2sABhZ2XlNGELj953suwHJ8ZMypBudA40t
         hryTzom/9JKLLH3MlxhKbbQHgi0jMTU8+GY+yidyirjMg8MsSLDE791jrcFlFkLZ+Ldi
         W7AQ==
X-Gm-Message-State: AOJu0Yzqiq1Xp7YTOwxw+Hg+13Kj9vn8t+F59mPf2izKlgljQLVQ/yL6
	ZN4Gg6l6hj4ubmNFlDs9tko03gXo0x6beoluyDRfDs0OaA1Ae+GEcV5Bk3WPLw==
X-Gm-Gg: AeBDievCdt3MFwks09FxhpghIY+ZWXLfUIRULi7HtpxjnCLcaCenC0XX0DdaqWroQD7
	k5Ozt6LYyJdAkW42j/UFNp0Opqpcod1mM+CwCU2fm05eAAagkp+ULrkkU3JUuD50E+1Df8fyOOR
	Vctf6XE2CJbVRQhunE+d2TzfsN+rBUvZMT6TZFwwQyj2U1YasFv82iw9o66A0OxA15KsjTir1sH
	kt+7jI5hXNC0pWcV+4iCcYfLyRbpBKk4eP7gaWgDDeyCfnoNC/hz5hyuRhxix/6BO2sUjJ+SAU0
	cMndnahPXKcC3vJ1pbm04xTz4YtogAgiYM0XZcsscHrN8RxNaMv/ChHu8DaZjkfg5SCloz65xf/
	riTuWrNha/sMtLcea5QkxnOCRj/m3s68ZUDCUjdMlDtKOTP49nWiiVBU39paVBveS/SURtak7ny
	yedXgeLo893eC1CnIN2bR0OxMzhyItPTN3iPoSv+c=
X-Received: by 2002:a05:6000:2689:b0:43d:75ec:26ec with SMTP id ffacd0b85a97d-43fe3e09823mr18566219f8f.31.1776679945607;
        Mon, 20 Apr 2026 03:12:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:22 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:12:00 +0200
Subject: [PATCH 2/8] refs: extract out reflog config to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-2-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6904; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=iSS7Hscdi3Jfc7Qt8Y7PZYDkWI4AyrxPGDfDYUvwflE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl+//5w2+8gSNo8zAvIxuhXjo9xUyrkJh9w
 j3ycI0PfMCHuokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fv/AAoJED7VnySO
 Rox/4OUL/1zu9p2wVbKOj+jfHuI/YAvYWYfHeXmxCcxcvkElKj7WGIGnP0AHWiw42RlIwe2/mlt
 lKA66yYCUhgzmjD6NQvtotwsaPElBn9/zpc60gNqPVlqkcnSskpvgVeR2JkFY6YFDltYi2eYiCI
 R+j5xF0vgW4z8bBNKzMnBVctTP/smX1F3mwF0DJIiCTmBtpypzjWRICN0C6exW7tMf+rkRoxfYV
 JFwMEHEw7SsUTwkWm+4RJmylprwSlLNMtaThnLxaha56azrCCVIxodAdcLVrwAKWJL+JXzvqwob
 YjU5Qk3JpKH/QjQOJcH2m0rI4BaBsjk1grCqkXiGoJH4iQ+hBLPUjgNtotVPMCSUugFcFNrfh3s
 SJpBUo4fVq/IftThYp+PBrSWlYm/aVxlDdyE0pTNbVo3ImLNkdAMh6zuOzfF9kVPGjrmWz3DsEI
 4wLVhWJcKciH1xhrpxoIGwUVuqjNMfhEHXWe6GIwErYEpxvP3pNxTkOD5D12bcc+j9QYPwqoQB7
 J8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference backends need to know when to create reflog entries, this
is dictated by the 'core.logallrefupdates' config. Instead of relying on
the backends to call `repo_settings_get_log_all_ref_updates()` to obtain
this config value, let's do this in the generic layer and pass down the
value to the backends.

Instead of passing this in as a new argument, let's create a new
`ref_init_options` structure which will house information required to
initialize a reference backend. Move the access flags here as well.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  7 ++++++-
 refs/files-backend.c    | 10 ++++++----
 refs/packed-backend.c   |  4 ++--
 refs/packed-backend.h   |  3 ++-
 refs/refs-internal.h    | 17 ++++++++++++++++-
 refs/reftable-backend.c |  6 +++---
 6 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index bfcb9c7ac3..aa66c6b28e 100644
--- a/refs.c
+++ b/refs.c
@@ -2295,6 +2295,10 @@ static struct ref_store *ref_store_init(struct repository *repo,
 {
 	const struct ref_storage_be *be;
 	struct ref_store *refs;
+	struct ref_store_init_options options = {
+		.access_flags = flags,
+		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
+	};
 
 	be = find_ref_storage_backend(format);
 	if (!be)
@@ -2304,7 +2308,8 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
 	 * allow the backend to handle how it wants to deal with worktrees.
 	 */
-	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
+	refs = be->init(repo, repo->ref_storage_payload, gitdir, &options);
+
 	return refs;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3b0c25f84..407b97cc44 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -108,7 +108,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
 static struct ref_store *files_ref_store_init(struct repository *repo,
 					      const char *payload,
 					      const char *gitdir,
-					      unsigned int flags)
+					      const struct ref_store_init_options *options)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
@@ -120,11 +120,13 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 					 &ref_common_dir);
 
 	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
-	refs->store_flags = flags;
+
 	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
 	refs->packed_ref_store =
-		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
-	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+		packed_ref_store_init(repo, payload, refs->gitcommondir, options);
+	refs->store_flags = options->access_flags;
+	refs->log_all_ref_updates = options->log_all_ref_updates;
+
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 23ed62984b..195600cdad 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -218,14 +218,14 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 struct ref_store *packed_ref_store_init(struct repository *repo,
 					const char *payload UNUSED,
 					const char *gitdir,
-					unsigned int store_flags)
+					const struct ref_store_init_options *options)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_store_init(ref_store, repo, gitdir, &refs_be_packed);
-	refs->store_flags = store_flags;
+	refs->store_flags = options->access_flags;
 
 	strbuf_addf(&sb, "%s/packed-refs", gitdir);
 	refs->path = strbuf_detach(&sb, NULL);
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 2c2377a356..1db48e801d 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -3,6 +3,7 @@
 
 struct repository;
 struct ref_transaction;
+struct ref_store_init_options;
 
 /*
  * Support for storing references in a `packed-refs` file.
@@ -16,7 +17,7 @@ struct ref_transaction;
 struct ref_store *packed_ref_store_init(struct repository *repo,
 					const char *payload,
 					const char *gitdir,
-					unsigned int store_flags);
+					const struct ref_store_init_options *options);
 
 /*
  * Lock the packed-refs file for writing. Flags is passed to
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2d963cc4f4..eed13af4eb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -385,6 +385,21 @@ struct ref_store;
 				 REF_STORE_ODB | \
 				 REF_STORE_MAIN)
 
+/*
+ * Options for initializing the ref backend. All backend-agnostic information
+ * which backends required will be held here.
+ */
+struct ref_store_init_options {
+	/* The kind of operations that the ref_store is allowed to perform. */
+	unsigned int access_flags;
+
+	/*
+	 * Denotes under what conditions reflogs should be created when updating
+	 * references.
+	 */
+	enum log_refs_config log_all_ref_updates;
+};
+
 /*
  * Initialize the ref_store for the specified gitdir. These functions
  * should call base_ref_store_init() to initialize the shared part of
@@ -393,7 +408,7 @@ struct ref_store;
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
 					    const char *payload,
 					    const char *gitdir,
-					    unsigned int flags);
+					    const struct ref_store_init_options *options);
 /*
  * Release all memory and resources associated with the ref store.
  */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index daea30a5b4..bdc3e0aa19 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -369,7 +369,7 @@ static int reftable_be_config(const char *var, const char *value,
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *payload,
 					  const char *gitdir,
-					  unsigned int store_flags)
+					  const struct ref_store_init_options *options)
 {
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct strbuf ref_common_dir = STRBUF_INIT;
@@ -386,8 +386,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
-	refs->store_flags = store_flags;
-	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	refs->store_flags = options->access_flags;
+	refs->log_all_ref_updates = options->log_all_ref_updates;
 
 	switch (repo->hash_algo->format_id) {
 	case GIT_SHA1_FORMAT_ID:

-- 
2.53.GIT

