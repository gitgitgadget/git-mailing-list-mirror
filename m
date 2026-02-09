Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416E37FF60
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652708; cv=none; b=NuZyqpmVm+RWhRJzm48Ko+3BzFc3kNMK7XhrDNhHS370CR2eZ5i3f3b9Rk79ZVscbSK3Xjyb/QdvnQTMf4+M80EStE6YluBm19uR7OKyl3EdnszMsLeNFL5aJY0yhXL4+lVXO4aNoqmMT7S0EZH0F8q2BAiqyobNTNp9F11m4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652708; c=relaxed/simple;
	bh=Kj8PcxlYBRS8OZ3TfBohS4mhrLNQiLi5Przsom4XyJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otoPTVFLdIUXhRyGfZvPxtYRGj8ddapCWiCD7rvs9p8mc1ranDHTZzaaigkNT1eU8JNr2nlvOrSIcctm+3kvfvSrvO3ChUxYGEmWH2iSS6uKCFOG5+F9B/C9NI6R+uqT4M9tbCi40PIud9hzyXupdri3YYs1iG+jsJLN0sPHMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgr8Bakw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgr8Bakw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-480142406b3so35742905e9.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770652706; x=1771257506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVMJdwY+BD+/HSMfPwGMn6wMSdAJa/qnqOLPPYrjBFg=;
        b=Tgr8Bakw9yXmh7DuJcV28h9kLz52FUIP5DheEwc5lQPY6Ec+U66e1o+rCl2Yum2qfv
         jGurDLlrYwW8OAMM+I0yoqWRfUqueq1pTvMPFsvJcADxYTFouNjDJJFpu7B3yyjvujZA
         xNmaG0wu8E5moYZcaWKCbmCj4wFD4Jxqbh6bqaKJGFTNh7sjYAdwjJqCdrHvGWw7hjMQ
         IihRpGppC4PfzcEkSGJ0M67qYZlLw5mqMlxRXyGFQ0swySMcHGtPVGfFJpV3GGSYX7WJ
         GUdUdMy8pFvIb4cZePubDdSRLDbDQFpH7Udxe1rf7zoZRT+R67kzAYM61uyvapwDSwKW
         b5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770652706; x=1771257506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UVMJdwY+BD+/HSMfPwGMn6wMSdAJa/qnqOLPPYrjBFg=;
        b=wCj0jUwm6Y1yCTM/QP5bawdOX2DnUm+eNUsQLZl5KApUcjabvMJQsfKyFYNy7bDMYF
         GNzRm1qKdiBHY3Smigw5ge8OXSio2pdq4R2sHWJ4VMvY8L0raLJUQGyFbXR2OPM0Hp5I
         QvHI8l1Ng23tqPrQEd7gU7habLxNKJnHtUAfmzrojjezIjdkDXJ53vFAqRVBpxBpgInU
         QqrsDeGElInEX5Kmrst/4rkLlW0TswamUVDyB6wcg0zXQshr9rlWBWWnYsmu0EXS5Zp5
         ufwPkh+8tHolUN/ItSpOES1372V00qVoucwF3Il1h3X/C/NKGxMPALfSA0/eagxSsdek
         NCaQ==
X-Gm-Message-State: AOJu0YzEYiyrMI7aj6D4LT2H87IGE92dq8y+ka9wOFpIfcv44awTiIPw
	eTB5//WiPUGWD24+DHCYxQ6qbNNU1/ejgQJtWzvrgtlZkMzY2MKt5NYm
X-Gm-Gg: AZuq6aIUZG2e6ZB/pH5y1Bd7xC99VoGGyKtBVeQQEIRYJcCylukjxBwUkCdeJIi/G8L
	3PtetgVZa2BTE4c4mfe6WbY1/88V0iKJiXQEkl5c/ph5LCLlUzhPNXNFileOR8Q25K7M1qZVsDm
	UC2/j0HJk76hQ18NH5pnerK+cGw/jLbhfCaeIsScIO078dUIph1XBYTbSG1CWT79p7LPkmZb+Un
	zPWCnMeagNOZcWNFVOOBs4/ZhElqRmUBeC5RJ9ljSD1ppSDYzrRzFSEE9nX5SYt4eTHWNFdjVF0
	oAWsinm0YNZrDmZdnhxx4xkDZuV8cPhOzGH1WAsPgeHNVqtPVH8mK0z8txoVtgE8tQ2GN4/4sMD
	9lQiE0QLQnfHge9xqp+buJ7jKta929IO998gWdr61mv57Qjul0/wfsX6zuWghrXpbmNjDosLurU
	5Mn7+9R3+EPFzNhXvOWbekxQk2HWVAKg==
X-Received: by 2002:a05:600c:c16b:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48320214793mr175673545e9.24.1770652706180;
        Mon, 09 Feb 2026 07:58:26 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9616:5969:7cd9:8b71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096f127sm128163635e9.6.2026.02.09.07.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:58:25 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Feb 2026 16:58:19 +0100
Subject: [PATCH v5 2/4] refs: forward and use the reference storage payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9081; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Kj8PcxlYBRS8OZ3TfBohS4mhrLNQiLi5Przsom4XyJw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmKBBzSrRXbfOUMMN3vswIkoNUTaRWZ14MJJ
 EQHH8oMO0AppYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpigQcAAoJED7VnySO
 Rox/T4IL/iOB84VkKy+4oHMaiDmkU1Gn81nChvL7WeZYtW8de/vzgjZW3EV7u18dG5vq+j6TUxP
 VGwerFS1W7nWUdSFqGWQc1jW1bcxxQyHoX880p4tjAivyPeETWLP57xmjxVCtzXmXn3K08uzMYm
 kOOXwA4rIUvAF0Q/IPNma2TxTfB46VxtV3rVZLLhMqweCZvR+8onXEKN+gT+s6FFhqlWmDTl3RZ
 Oz8bMVcYkgDEX520FEwNXksolVweMEQPv8AlA/AsABU39nvUAFVSMe9XFifnXeyRfDb9IrCYPk4
 MJ9TKz2dGIWW1KvaJ6g1WWaWkoJ8Q/P8NX2wLkW3ptToA49VREAqkS9X/iDUUZaSclwrMUH06sB
 f1gogFHKMVXq2CR2BY6Aq/AmhWhbrie1GJVUXD6lB5Qzw2JBtAAisxWtVJuEe3Q152DUSr7ohTK
 BJKZ3DE1WVB3cb0ZJfJbxcdvfxN+7Bbgubu/oQCSyu7K0GRgbR/SyKgVSp3+6CDqB3xVZaEGTw3
 Co=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

An upcoming commit will add support for providing an URI via the
'extensions.refStorage' config. The URI will contain the reference
backend and a corresponding payload. The payload can be then used for
providing an alternate locations for the reference backend.

To prepare for this, modify the existing backends to accept such an
argument when initializing via the 'init()' function. Both the files
and reftable backends will parse the information to be filesystem paths
to store references.

To enable this, provide a 'refs_compute_filesystem_location()' function
which will parse the current 'gitdir' and the 'payload' to provide the
final reference directory and common reference directory (if working in
a linked worktree).

The documentation and tests will be added alongside the extension of the
config variable.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 33 ++++++++++++++++++++++++++++++++-
 refs/files-backend.c    | 17 ++++++++++++-----
 refs/packed-backend.c   |  1 +
 refs/packed-backend.h   |  1 +
 refs/refs-internal.h    | 15 +++++++++++++++
 refs/reftable-backend.c | 24 ++++++++++++++----------
 6 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 36f3441632..d9df25d7c0 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
@@ -2224,7 +2225,7 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	if (!be)
 		BUG("reference backend is unknown");
 
-	refs = be->init(repo, gitdir, flags);
+	refs = be->init(repo, NULL, gitdir, flags);
 	return refs;
 }
 
@@ -3425,3 +3426,33 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
 
 	strbuf_release(&path);
 }
+
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(refdir, gitdir);
+	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
+
+	if (!payload)
+		return;
+
+	if (!is_absolute_path(payload)) {
+		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
+		strbuf_realpath(ref_common_dir, sb.buf, 1);
+	} else {
+		strbuf_realpath(ref_common_dir, payload, 1);
+	}
+
+	strbuf_reset(refdir);
+	strbuf_addbuf(refdir, ref_common_dir);
+
+	if (*is_worktree) {
+		char *wt_id = strrchr(gitdir, '/') + 1;
+		strbuf_addf(refdir, "/worktrees/%s", wt_id);
+	}
+
+	strbuf_release(&sb);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 240d3c3b26..b192ce606d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * set of caches.
  */
 static struct ref_store *files_ref_store_init(struct repository *repo,
+					      const char *payload,
 					      const char *gitdir,
 					      unsigned int flags)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
-	struct strbuf sb = STRBUF_INIT;
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
+	bool is_worktree;
+
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
 
-	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
+	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
 	refs->store_flags = flags;
-	get_common_dir_noenv(&sb, gitdir);
-	refs->gitcommondir = strbuf_detach(&sb, NULL);
+	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
 	refs->packed_ref_store =
-		packed_ref_store_init(repo, refs->gitcommondir, flags);
+		packed_ref_store_init(repo, payload, refs->gitcommondir, flags);
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
@@ -126,6 +131,8 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
 			      &refs->gitcommondir);
 
+	strbuf_release(&refdir);
+
 	return ref_store;
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..028fbc0585 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -212,6 +212,7 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 }
 
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload UNUSED,
 					const char *gitdir,
 					unsigned int store_flags)
 {
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 9481d5e7c2..2c2377a356 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -14,6 +14,7 @@ struct ref_transaction;
  */
 
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload,
 					const char *gitdir,
 					unsigned int store_flags);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7d2a6e50b..bd09b1280c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -389,6 +389,7 @@ struct ref_store;
  * the ref_store and to record the ref_store for later lookup.
  */
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
+					    const char *payload,
 					    const char *gitdir,
 					    unsigned int flags);
 /*
@@ -666,4 +667,18 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					  unsigned int initial_transaction,
 					  struct strbuf *err);
 
+/*
+ * Given a gitdir and the reference storage payload provided, retrieve the
+ * 'refdir' and 'ref_common_dir'. The former is where references should be
+ * stored for the current worktree, the latter is the common reference
+ * directory if working with a linked worktree. If working with the main
+ * worktree, both values will be the same.
+ *
+ * This is used by backends such as {files, reftable} which store references in
+ * dedicated filesystem paths.
+ */
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d8651fe779..964b0b50fc 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -372,18 +372,24 @@ static int reftable_be_fsync(int fd)
 }
 
 static struct ref_store *reftable_be_init(struct repository *repo,
+					  const char *payload,
 					  const char *gitdir,
 					  unsigned int store_flags)
 {
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	int is_worktree;
+	bool is_worktree;
 	mode_t mask;
 
 	mask = umask(0);
 	umask(mask);
 
-	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
+
+	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
 	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
@@ -419,14 +425,11 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
 	 * This stack contains both the shared and the main worktree refs.
-	 *
-	 * Note that we don't try to resolve the path in case we have a
-	 * worktree because `get_common_dir_noenv()` already does it for us.
 	 */
-	is_worktree = get_common_dir_noenv(&path, gitdir);
+	strbuf_addbuf(&path, &ref_common_dir);
 	if (!is_worktree) {
 		strbuf_reset(&path);
-		strbuf_realpath(&path, gitdir, 0);
+		strbuf_realpath(&path, ref_common_dir.buf, 0);
 	}
 	strbuf_addstr(&path, "/reftable");
 	refs->err = reftable_backend_init(&refs->main_backend, path.buf,
@@ -443,10 +446,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	 * do it efficiently.
 	 */
 	if (is_worktree) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/reftable", gitdir);
+		strbuf_addstr(&refdir, "/reftable");
 
-		refs->err = reftable_backend_init(&refs->worktree_backend, path.buf,
+		refs->err = reftable_backend_init(&refs->worktree_backend, refdir.buf,
 						  &refs->write_options);
 		if (refs->err)
 			goto done;
@@ -456,6 +458,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
+	strbuf_release(&ref_common_dir);
+	strbuf_release(&refdir);
 	strbuf_release(&path);
 	return &refs->base;
 }

-- 
2.52.0

