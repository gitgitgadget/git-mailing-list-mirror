Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078A245005
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286535; cv=none; b=t/2jasOIE4D8IBYx5xsH2Gb9WpoY3YIJqJNOfRAQMenvJkIAvfff5//GNaNHtUuvmVaoT5SkjYWJ+yJuMdFbkI8T6UCS4P+7/S6RlR2G8sfn1xw8yfIM8oHvKWYMDCGH0iE4jhasgdt270/pcGktarTfiI1+qm+AXvSA36oqHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286535; c=relaxed/simple;
	bh=msSsZA4AQq4WoKs2tEBzzQ401OVU3CFejk2HumEvxQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7FYTzTD/2EkhXAEGh5sOMjvGR4PposHmBzsGqB3tOKOIRkl3TRdVSsZvpFS6/FhiX5O51NHRZVWkXdGpuL2Ns9Dis0F1Fh+E8OQj+gaCvrNWjHbOQsnI1wQAoOQX+TObr+b04P+N5hYUk3scRPc0jXJCxQyWEHr8P5tribShnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pa0i339K; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pa0i339K"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d73422431so9326403f8f.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286532; x=1777891332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kxK0tCkx4Poi406wByxo6s809CGgfPPJuVJY6SwR3s=;
        b=Pa0i339K2fyi6oIGCxhDTHYotIG2ZFLKtM8tnKcUXMLtdU+Mo+ns5UQM3veaE0ntFT
         VEqp0WfomDZTZxXAXbIm0fA+URmLuDNDgLgcu567wP0Ur0CAoHvk6JdHJWE1O57bKlJW
         byCo9UietIgo6md+49he4nsoKwNAZ733NfhTgb3ij0t/2YS+GDnqCEHGJ5ok5fvS61Jf
         Z/euq3S/7NkhfDUwGYTVgarZIEB+OI2JnUKHcWNhkrVhCdPh5qCWf9vdh0CnRv0H9HiD
         IKGuus1LhYj5Lx6xwOX9fqXUfru5lAya3ip1XXRcUQta5W2dffMmHTFaSva8l4mTftdl
         TmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286532; x=1777891332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0kxK0tCkx4Poi406wByxo6s809CGgfPPJuVJY6SwR3s=;
        b=b9fuf9jYD4IIB9H0+579ZWPa/FBKPtvC0em0Bv5sZ4Exqd/IOfimUTrfwGqwCg00eE
         pmZ+UO3UHT2cyKH7wHOSxzwh0Ppt5t1a7dlEQto8EIF7HZAEkeSSKOrTYunweOjoPWnQ
         vZxFPlx7q/WEQdwSd3exc36A4U6kY58Lu+fcZt3wqKdGmTuWrzMWVkBZYjVWnvok2Pnw
         TG8Hw9LinLDqUYLe0yGnJGUVufvekXijnNLpzPe3AGPsKdO3ZUCl45pm9e28mranTtxp
         1fksZbMhSPD2I467ioJet2evL5HbDA+7ytl7+9+UMQN6+Z/BRDabcY7SWPT8QLK1L3DR
         AVYg==
X-Gm-Message-State: AOJu0YzEMxyYVixfTH1JLq98e+7tBUIwjaCqbpmuFg8+GDSRK9wXsGgQ
	wnbM3NFRbqP5FEhNBil2Cy0qQDwUxIzFVPXalzFdvPu4pcoKH76GZFP0+lJtgw==
X-Gm-Gg: AeBDievGZx65rnFqzOafjfwXm3CwCVpalR/floVdgkACfOooRlow8H/Xv3snG73+o4O
	eLErgtZSfoRjrfEenPDNAC9rYk2wKYNffXuKP6Yf+MzeJHrv77O34+hrpAY+YQ1dxKtEa7XGbO8
	KMbl7hi12Om+toCpavpgwc2UOzGN4VZSFjQJOCcxsO2tV+AkYojH0faq78ZJC7KkAxhL/FQi7Ob
	QUJ8u5Os4xkc+uTpkHZe+slu6PKsl6n/TZ59HGqgnEmR5ct3DCYUsLRw2x65oV1xJ/rFDs0Rkzo
	SLqqGxqWRFGVkQM3T91k5VrBMSGHfgFiUt0ifvEqp4ndr1XlJdUOcFWIfRido4SpbKd7BAtlX2Q
	b0arU9JaxlucP+vhdPwgndLTwU1ISOv2QEfacj2GAcfXdGVTXsPvDq2NoBbaOYn864goEgxzfBf
	9aNO2rXE5QZ31hgJcGZ8Aegi7PUMIfElB6gubQZup5
X-Received: by 2002:a05:6000:1869:b0:43b:6a16:17e with SMTP id ffacd0b85a97d-43fe3dd4f06mr67891348f8f.11.1777286532175;
        Mon, 27 Apr 2026 03:42:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:03 +0200
Subject: [PATCH v3 2/9] refs: introduce `ref_store_init_options`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-2-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6472; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=msSsZA4AQq4WoKs2tEBzzQ401OVU3CFejk2HumEvxQA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPX6R12Oo3joTetTKSu/iT8cJGhYDCiMPV
 qcvBJo6Q47RZ4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z1+AAoJED7VnySO
 Rox/+QcL/3/X+0Ph726dDnnawJukbC6y05phay4eCtUsdSo1tfL7R4pimH8Z5RiaEZ4l+jSF9QX
 nemPeTZIp88QgOlj6GaitcaMfd1myQCGUa/EkMivy+GS/w3Wct4QMPlgHPs/FhJrZ4bQtfRyivm
 lCs3TwVs8bLoPKaRoyZtbY+tWXswsA7ZVBPxtL7QH48mr94WRJyeYPrJB7iKT2vJoFZYLdkEofw
 jDrqeIekHzwegGxU9hE9z5W37YVqAee+MNyf1p1S4VImYtzLJU/aCsda1gSWSGp2Q3eWuJms1oU
 fzkjxEPvJBlIgo7APSv+/vSsPyHAIV39I8MVVT0/wPGOXfr0/uPOuTuBqEAHB7KKDqt5+3+l6KS
 GJSL4Niu8u0eh8rBIj0s4WGZu70nEJDkOc8fBDoB6QQvR483DX4PTyxMoqNAr6bzDLNzpqwXYuE
 zI9EfwxhTi+L7p43KjcY1mSuzxznn3JS1YGdtxf3KQQLb8JTp8Qf14egMG7xARaSWWUZ3s14xK6
 7w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Reference backends are initiated via the `init()` function. When
initiating the function, the backend is also provided flags which denote
the access levels of the initiator. Create a new structure
`ref_store_init_options` to house such options and move the access flags
to this structure.

This allows easier extension of providing further options to the
backends. In the following commit, we'll also provide config around
reflog creation to the backends via the same structure.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  6 +++++-
 refs/files-backend.c    |  8 +++++---
 refs/packed-backend.c   |  4 ++--
 refs/packed-backend.h   |  3 ++-
 refs/refs-internal.h    | 11 ++++++++++-
 refs/reftable-backend.c |  4 ++--
 6 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index bfcb9c7ac3..8992dd6ae8 100644
--- a/refs.c
+++ b/refs.c
@@ -2295,6 +2295,9 @@ static struct ref_store *ref_store_init(struct repository *repo,
 {
 	const struct ref_storage_be *be;
 	struct ref_store *refs;
+	struct ref_store_init_options opts = {
+		.access_flags = flags,
+	};
 
 	be = find_ref_storage_backend(format);
 	if (!be)
@@ -2304,7 +2307,8 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
 	 * allow the backend to handle how it wants to deal with worktrees.
 	 */
-	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
+	refs = be->init(repo, repo->ref_storage_payload, gitdir, &opts);
+
 	return refs;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3b0c25f84..72afe62cee 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -108,7 +108,7 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
 static struct ref_store *files_ref_store_init(struct repository *repo,
 					      const char *payload,
 					      const char *gitdir,
-					      unsigned int flags)
+					      const struct ref_store_init_options *opts)
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
+		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
+	refs->store_flags = opts->access_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 23ed62984b..35a0f32e1c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -218,14 +218,14 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 struct ref_store *packed_ref_store_init(struct repository *repo,
 					const char *payload UNUSED,
 					const char *gitdir,
-					unsigned int store_flags)
+					const struct ref_store_init_options *opts)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_store_init(ref_store, repo, gitdir, &refs_be_packed);
-	refs->store_flags = store_flags;
+	refs->store_flags = opts->access_flags;
 
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
index 2d963cc4f4..f49b3807bf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -385,6 +385,15 @@ struct ref_store;
 				 REF_STORE_ODB | \
 				 REF_STORE_MAIN)
 
+/*
+ * Options for initializing the ref backend. All backend-agnostic information
+ * which backends required will be held here.
+ */
+struct ref_store_init_options {
+	/* The kind of operations that the ref_store is allowed to perform. */
+	unsigned int access_flags;
+};
+
 /*
  * Initialize the ref_store for the specified gitdir. These functions
  * should call base_ref_store_init() to initialize the shared part of
@@ -393,7 +402,7 @@ struct ref_store;
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
 					    const char *payload,
 					    const char *gitdir,
-					    unsigned int flags);
+					    const struct ref_store_init_options *opts);
 /*
  * Release all memory and resources associated with the ref store.
  */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index daea30a5b4..ad4ee2627c 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -369,7 +369,7 @@ static int reftable_be_config(const char *var, const char *value,
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *payload,
 					  const char *gitdir,
-					  unsigned int store_flags)
+					  const struct ref_store_init_options *opts)
 {
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct strbuf ref_common_dir = STRBUF_INIT;
@@ -386,8 +386,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
-	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	refs->store_flags = opts->access_flags;
 
 	switch (repo->hash_algo->format_id) {
 	case GIT_SHA1_FORMAT_ID:

-- 
2.53.GIT

