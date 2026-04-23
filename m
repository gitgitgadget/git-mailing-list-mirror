Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222C23DEAD5
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933645; cv=none; b=qF+X/cqPJjVNlKcA9HjL6Si3jw25UVkTRUml2W4syEM4FIlmEEKN1wkq3GaDJCZFuUr2l1rLi/gNp7GHPmcGq6rJCHoMEjMxm8R3OjpflF+XnNXCdfIXAHL7BHxiZHkd/8/aRfJbX/GfsDchMX7bc2YQIBqeR2e6W4e8iZFCnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933645; c=relaxed/simple;
	bh=MEwnxkW6/gSp+7PkhIK07wqH558H8Mt8KYZfpIPWxPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/jUGq260laEf3BfwCsc8Vl8JTnZpXOeW+mCF1rY+kgcmSeEOF8qxCZeC7YiXJM/zvcIuuAZT0ajbQT4/psCpAioMOgjGU7P7FSLMBCjtnV+X/fjZtJdrs1et3MQ2vr1UDXOvrRvUcRcEbu5iDhD1vkcn3TPD+G3B1rlv2w9BcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+UZtM6r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+UZtM6r"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so83239905e9.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933642; x=1777538442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpLhhuTRukXFDEeEDyXZU5dhtW3P+you+q8JQGUyEwU=;
        b=h+UZtM6rfcc+RRsxIqTCTJ2Vcb4i2FzfQ3oabLzaKjtXEgYeD9K/01eWrtkKB/Su2K
         JvT6/S6xh7R80tDiGgqw8AnPkceLN60TQ+0x9bV9yu065Q2Pr2yfZhUC9XRAA8gHqTJO
         uZcBv8qI6owM4BRDLHppb06fal62eJ9+l4tDsIrAgpoMsld3xACw5KcdzMUG7YLDK+yi
         dDP+ZOnDWugGJZI5+4qP58E5YbRFxhUxo0F2RunOAujqy65uPwqh2iZM8CT9TTb4lbZy
         usgOD+lalC/bxoU5K9BGrb/1nenufqf33XpYgfKVP24PmBh4NTb7BBlTF4u1XfVz3271
         ohFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933642; x=1777538442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kpLhhuTRukXFDEeEDyXZU5dhtW3P+you+q8JQGUyEwU=;
        b=etjaCa/qmNLjheghZhBl2Ti3XUpvUCBibLdvfwh3T3090kdnilKt/9q/InRCMAjGEB
         41FbBF6nNQppdz3H6UAlMZQGdTsV21cxqs3fjSH3cDNUlX921CaDct1mLICVYoYID2Kr
         gA5qrZysaMYSeLUyu1zpeqN5RDtrXSVQdQ2nM66cgHWyOvYFItw0xKGsFVoHb1D3XlBJ
         BLqHFHmlZmwilPPcyNsJ+RjzPKBhQy0Qq0UOBCs7HF/kDDAgZDC2NwLeXoxQfZYZtQjz
         a/+iuzaSFP/KBkN4nSan6R8mSufZ8shiPT1KrwscvKm+CmbMdIri9o5913z+CHYSRgcF
         usHw==
X-Gm-Message-State: AOJu0Yx/78NKcO75G4DG+K7EVOvdU/J9uzSCqs9Zlu/marRtoPG8mxOm
	9N5wZ903I3qspXpUSporVGggNhDoh2phDQzoZplhgzJB8xku6jG9iJDMGoKGkQ==
X-Gm-Gg: AeBDievC1cnFiOYLZ0X9DaWu2sL0yQxag8QkFU5195uy2oUvj+L82/40eBNUFxdbX5/
	XWK7SJuRVgAuP+BKN2Qk6/C7AljoDbVATUCF8dYb2PTgaAY86EMxZcCsWV6nfp3b0u5ZQPWdRtG
	tCVMghcBlal5KqDIKHeAS0gHWmX8ODzeA37lSSDM7PF8q36LF1aon8azbI1waJWsg0dk2kqqqLK
	P5Gq22ONQJSBHWtIjtxVWBs41nsftYWeR0GFFb3YINdwx8QTSX1qrvf9iRvb7nj/WqFzQPchilU
	/QDoGNmtdQk1JlJZkvH3f1qgLabm12ExNnIOMY2D2CXH8QtpLCE4SNLlJ0OlBP+pBhJW+NQUA/E
	Zk4V52uQrSdgepOiwIFV+CXHWpAvnHHzpBjnlWiks/NKPnH+UrC9bNyfKjerUEzLB9glMb3qRjR
	3qVa+JJVC6x2UitoYG1GDVpRH86nB/kcbvTZVRkm+W
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488fb78ea6fmr373793585e9.29.1776933642091;
        Thu, 23 Apr 2026 01:40:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:32 +0200
Subject: [PATCH v2 3/9] refs: extract out reflog config to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-3-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=MEwnxkW6/gSp+7PkhIK07wqH558H8Mt8KYZfpIPWxPI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wNQqz+XwXdkNGbqmR0mnpk+YogwGS1lY
 b2Q/Tf/1imGWokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsDAAoJED7VnySO
 Rox/5eAL/1Z3OfqTfJxyP7vhJ0OVcI1WK44evWlN2yk2I0g1mXIlB2CZvKr6Z+YxSZ5KRQR1J+n
 wjpfduLqujmNnsLkr7K4U22qtS9upOU5GjAhKpPYOt/jegSqX9uUyZPzcVug28mmh09UxfaJ/Jt
 CWTxWqIMoosInk5TsHAIz0PGVXB4IimgIwegUHNdpQPQbHIUyIYlgUAqvD5qH+D/wp7U4zym/Pt
 T40VOMI/jsS88IUoHWQhztwzWbaGHo3mS9o0pl6cCia8asFAGhNiLkGctCqxGq5p8DR9Pk4gRLd
 mZlun6216dQCJlZ4Y15ukzt8PilVoLLSnOC2H277046qAq1sxMRI97kWcSxeliSKYPDti8ZfOMk
 f/3oT/itzFtTxQzsJlENX0cng+QD7OQ0260RyFqDGjsdrgjjaq6qvIToQt5rKd8icS+s0icc28g
 BKGzYwGnVz133BvnBKK+ZiBa3wayxMB1xCAE2B+W2Y5md8BZ84z7mal67oxIbAG3iPB9mgRyzB5
 q8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference backends need to know when to create reflog entries, this
is dictated by the 'core.logallrefupdates' config. Instead of relying on
the backends to call `repo_settings_get_log_all_ref_updates()` to obtain
this config value, let's do this in the generic layer and pass down the
value to the backends.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 1 +
 refs/files-backend.c    | 2 +-
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 8992dd6ae8..6b506aeea3 100644
--- a/refs.c
+++ b/refs.c
@@ -2297,6 +2297,7 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	struct ref_store *refs;
 	struct ref_store_init_options opts = {
 		.access_flags = flags,
+		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
 	};
 
 	be = find_ref_storage_backend(format);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 78150ad209..9b1fa955f8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -125,7 +125,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, payload, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
-	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	refs->log_all_ref_updates = opts->log_all_ref_updates;
 
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f49b3807bf..d103387ebf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -392,6 +392,12 @@ struct ref_store;
 struct ref_store_init_options {
 	/* The kind of operations that the ref_store is allowed to perform. */
 	unsigned int access_flags;
+
+	/*
+	 * Denotes under what conditions reflogs should be created when updating
+	 * references.
+	 */
+	enum log_refs_config log_all_ref_updates;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index ad4ee2627c..93374d25c2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -386,7 +386,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
-	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	refs->log_all_ref_updates = opts->log_all_ref_updates;
 	refs->store_flags = opts->access_flags;
 
 	switch (repo->hash_algo->format_id) {

-- 
2.53.GIT

