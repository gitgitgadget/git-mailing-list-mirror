Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28C3191BA
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108475; cv=none; b=Wn0V12xiJoGdaG5jgoUhwdqQIvfDOqxr5fKIrU2x4hmqnP4HGHfVpnJW4v4xj7fUrHz+KleoC32KLlb2z0KCuL6H1xh7X+zSahEfMaxdUb5XqFq26/Gcl5lvLCflGxvtGZlhm4X3gRAGJOCIdH3Jcw2B+IFs/gyjbc3O0Hpuyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108475; c=relaxed/simple;
	bh=ceEBUIEljfRvGDNBSdNRhwzLw4H+biioAxRWRUqs/D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAQwgcDcPfzGGIQB1jxQIMa/W5aYIM46P3Zzq8ZlF5mHafXcLorAy5t4W47tgVByrITEM1neQstDai2YclWQ+YeE8GLFK/HNWsAQDkmBJYp9h01paZv1QxDwwVuwP7w9Ox6SLwsPKvetE2ap/7ZaQkyrguJPKbqzFBsTyZmslu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDd0G/Sv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDd0G/Sv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso3949305e9.2
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771108472; x=1771713272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhystp4vmNg9p4rhgXarpnIFXw01FwyhAolPCJnEEtg=;
        b=YDd0G/SvvdCze42zyr0LSrnzKbwI2zP7lGpnva2NEyYZLOxZaAi+dB/MzeXXHwWMp7
         kwD+nb3VPjvbqs+FN61ARg8/PLlEV6fIxI1bWYuhEjeU/eNRIZHNA43LNWTav/NPio3P
         0bXE9OXXH6QCXgXrvL767IJ5ftTBZCnqK6QGvofgr2hkt/syuwxettEXf3Hh14i79058
         P+GaLcdO9JjQg19cFAk8Ls4w9rW2PsWOlNQYQeZDOzGUx+RjoaiHD9EUN4tqv65KGQNh
         vQIbSixiwFofr9r4fm0s/I+fy5eG1lhb9Wh4oNQvCGdILjDo8fVfdr6x13RCSiJEH+cu
         tffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771108472; x=1771713272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nhystp4vmNg9p4rhgXarpnIFXw01FwyhAolPCJnEEtg=;
        b=oTWHml9DbYnusDDnJyEeLZT/aQHRCh1SOdhNhTWUW8k/ozEMDhzrz5NcQ7FnPsi8yn
         XdM47MN8l8iNr9q/WDuCc8UqYBuEzmLeDuO441imj1SsT8pCFPElkwTIyLE8FIrXHwBr
         TicjpfBeXYeQN6DT28CRv12GWPpm/Cw/WYZeLbh7hh+ZNfm1ZdlsPDrotbXzJeAkEElT
         nPK0RRg6mSiDvg7WUSQ/D8Zb3S6M9T/WHnar9bg2b2+MnJEqBEuSv19sbYpG/tpdlEjG
         Guf8TkYSTdTqYQ8IdkYsVkCj/Rm5aub3qQW36TMlxXYOq04pdOPsaFIac+4zZH6ti4tS
         TvEw==
X-Gm-Message-State: AOJu0YzlxV3ACTTary3jm6HNWD5m6WpivcvnjKrPnl63GlPd7w3WffMh
	QCgsGJnw71NCaWNkAtLbY4GpN3gJ4Xo/6Kvb2uZBXKi2PfmSMcqW7+XEnj6Nui5J
X-Gm-Gg: AZuq6aKtJ9P8d/cEMNe7trF7jFXU0660nET8W7ikdHP/IXcQUg3OXR8njcSwMQVTCxr
	Z+O7uIhoqKGS5BH5G/A6R3qBAknkZEB2qhAcORIdRH7+ke8BfV68TBR35EKIwVjLdsbOitThm6t
	MWhWTFE6dww5Qmma0U8zi7VIxoVXqVW3zke8EDuBvEx2wCHJQ/392BtRcc6LJh8jAV0BVzCcsRJ
	hYQq8D7i3nTmTyvH7Qjb/JM2MnDPeO2AjPY6xn5IeYfqtTeq8LkKx+PiD1SdYEWVJagwomdc2hM
	dKbHj6p0v1+Jp8CWQ0AXnn99KpaPZTBvgfw9tuMj9smn7GmDIC0ylVnWGgI+y9mBdy07tnpHHo0
	icxlyoK+q7sRQF9iP3tWLswX2IzEP0/dSTvAQrjRK11oM0dvyob06YnYI4Fw0BsfMTlwLHlW1pD
	eAs8iKwRGl1xfWEH7iEU5sAnA5N6lawTEyKgBGAHQEDQ==
X-Received: by 2002:a05:600c:8b4c:b0:480:39ad:3b7c with SMTP id 5b1f17b1804b1-4837106152cmr113868625e9.16.1771108471572;
        Sat, 14 Feb 2026 14:34:31 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ffee:e476:e6e4:b574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm83591645e9.10.2026.02.14.14.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:34:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 14 Feb 2026 23:34:16 +0100
Subject: [PATCH v6 3/6] refs: receive and use the reference storage payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-kn-alternate-ref-dir-v6-3-86a82c77cf59@gmail.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com, 
 ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9635; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ceEBUIEljfRvGDNBSdNRhwzLw4H+biioAxRWRUqs/D8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmQ+HLVY5+m95W1W9uDkYbWo0lXs3h1VyQFG
 Hh9KrzdBadWV4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpkPhyAAoJED7VnySO
 Rox/3HYL/2TLu4bU9XHD+jEqWvvr+5loKPRRLyV+XQhy3Zh7RJdGgqo+GAiCmxREnTIOchFwy0y
 85RJacuptjP+V+mbl8aNKqHYFRuEn3P5phibwrYAtZD5Vs75trriaEf/pyFSQeTG2I5xbgc8NT6
 veorJQZvpdXs/gDTTNUGjJWSQlsSHtncb1K/yO2QMupWzOcWFme0Yir5osb8iFavEMyYLU9ZAIG
 H0sxXJNHVmFvrbA6nf1sQPXYZDh8RVIPz1ZWZ31Wzqd4e6dehXLuY5lYk2NvRTfUXXH4LShU+4W
 v0eiH0x/lMdE511pIFeh9WIDWlyvC7QYlb8dGIW45bi62ZxhrhqgNSnErX2lCGg7iPJEJukUOkP
 WZivccSwvcYNJF0taPQPgmErLPG82Qjx7zjkbMf672JSg1ai7eWIARXTk5tCoXvZJnksmVgRY64
 kM6M7wuEYB45Y/RedT57Hx7hLRJzwTnqrY8jANrHnSRjY3DN/A8umZWHjlMKQSWz34viojsI067
 Ak=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

An upcoming commit will add support for providing an URI via the
'extensions.refStorage' config. The URI will contain the reference
backend and a corresponding payload. The payload can be then used for
providing an alternate locations for the reference backend.

To prepare for this, modify the existing backends to accept such an
argument when initializing via the 'init()' function. Both the files
and reftable backends will parse the information to be filesystem paths
to store references. Given that no callers pass any payload yet this is
essentially a no-op change for now.

To enable this, provide a 'refs_compute_filesystem_location()' function
which will parse the current 'gitdir' and the 'payload' to provide the
final reference directory and common reference directory (if working in
a linked worktree).

The documentation and tests will be added alongside the extension of the
config variable.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 40 +++++++++++++++++++++++++++++++++++++++-
 refs/files-backend.c    | 17 ++++++++++++-----
 refs/packed-backend.c   |  5 +++++
 refs/packed-backend.h   |  1 +
 refs/refs-internal.h    | 14 ++++++++++++++
 refs/reftable-backend.c | 24 ++++++++++++++----------
 6 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 77b93d655b..11d028232b 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
@@ -2247,7 +2248,7 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	if (!be)
 		BUG("reference backend is unknown");
 
-	refs = be->init(repo, gitdir, flags);
+	refs = be->init(repo, NULL, gitdir, flags);
 	return refs;
 }
 
@@ -3425,3 +3426,40 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "unknown failure";
 	}
 }
+
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
+
+	if (!payload) {
+		/*
+		 * We can use the 'gitdir' as the 'refdir' without appending the
+		 * worktree path, as the 'gitdir' here is already the worktree
+		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
+		 */
+		strbuf_addstr(refdir, gitdir);
+		return;
+	}
+
+	if (!is_absolute_path(payload)) {
+		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
+		strbuf_realpath(ref_common_dir, sb.buf, 1);
+	} else {
+		strbuf_realpath(ref_common_dir, payload, 1);
+	}
+
+	strbuf_addbuf(refdir, ref_common_dir);
+
+	if (*is_worktree) {
+		const char *wt_id = strrchr(gitdir, '/');
+		if (!wt_id)
+			BUG("worktree path does not contain slash ");
+		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
+	}
+
+	strbuf_release(&sb);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 240d3c3b26..b40d6feb1f 100644
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
+		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
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
index 4ea0c12299..e7bb9f10f9 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -211,7 +211,12 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 	return snapshot->refs->base.repo->hash_algo->hexsz;
 }
 
+/*
+ * Since packed-refs is only stored in the common dir, don't parse the
+ * payload and rely on the files-backend to set 'gitdir' correctly.
+ */
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
index c7d2a6e50b..9a635f4e6c 100644
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
@@ -666,4 +667,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					  unsigned int initial_transaction,
 					  struct strbuf *err);
 
+/*
+ * Given a gitdir and the reference storage payload provided, retrieve the
+ * 'refdir' and 'ref_common_dir'. The former is where references should be
+ * stored for the current worktree, the latter is the common reference
+ * directory if working with a linked worktree. If working with the main
+ * worktree, both values will be the same.
+ *
+ * This is used by backends that store store files in the repository directly.
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

