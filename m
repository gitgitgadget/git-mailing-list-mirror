Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777534E74B
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286537; cv=none; b=VF45bDJ09paom/bUq5EwctnLCjerSLUKW8ZErFmJbF20Z8omfwGDYYA3Q5x1kbWfnApyTpmo3iY6V8sXMNEcNHHzKVBA03LHUKFoCkH6nlmztdyu4R303slCDvXxkkHOK+eYw/mDpa1iMDIs7h6480MuI3T0FsXNw0b45NKptEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286537; c=relaxed/simple;
	bh=TbIrlzJjgXVMlOZxss5mCpB2iHtkFVz/+miIiYS0o9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSbLbxL9wYQYge8yeMNiY4NwCrVK5gCZVY54HpL9FjZiMuVnZasRuoP/K56YjtH7LLxnRHsQzs9fxpzqh/OOIAYXz/jPw3ayzy2VI86aI20CstQZnKkgPe9Omkbd9gzYrd1KsUu1Nq0KPxcuDIctIGTkjVVf+g81znyiCAB84is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWacaLw2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWacaLw2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48909558b3aso100632165e9.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286534; x=1777891334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+LeRUARsCUVGeOSHInEicMUg+JEZeWMyLkeZ4i3ZkI=;
        b=eWacaLw25T2huLmKzZdICT609Qkv8xMpHBJr4LMM224ZqPZl0V0iB1sZgufbjvpdju
         jUp6qwNv2/7jAYZOR1GLZiTKpXghO5p9U1eUZBEcpgW3xJ/Y2oZbMAIFbCC4S6q9fzgT
         eLoEeKtudPxQd30dBPo8pHA11YAdSpNaFXsaIeEKFP2LBzTbHZy1vLGcKEH10kWJBIIT
         NpewTfgYezm3PkTJYomKp+kb3r4OiU6tNZkYTOkyN/Zt4Ykd+jjvdHKbwsS0b+l/PVOG
         eCdH3k2FWAqB6waqejSObH7lQMsVr127DeNWUGXbS8bkZT0H0wJ7U3qkdBgl4NNSCeXY
         irAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286534; x=1777891334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+LeRUARsCUVGeOSHInEicMUg+JEZeWMyLkeZ4i3ZkI=;
        b=aLYsHcYG223+YN8okLDCxKp7Q25/x+HE8zuTXz5phg42F/W3J6bqIrU6SiDJ0ibC1f
         hFNtSj3SZ8twNND+SzLjKTvXLBlOPcHZUL4YiyZRJyCd7AbfX9HtNrGoYuxEMx4PYnIT
         MuWdSHKFC2dPJqU0AIlRKw8DmH5tsQ8eKRi2S8Fue/prnC7roRPjlJNqKpCmDZwk+Ifh
         a80ASqWadw1fI6odnf6+vHifrXpApYQRd7SGXtiof0T4MyI4Y1S1UbRE/MoGzd/ZOEUC
         7ju/wcwoyH8nDf9pv+7b7KErCHL56OQAbio0LgjnRACA+7Tp1LInEWBCL3ufRt9UFuRp
         2iCQ==
X-Gm-Message-State: AOJu0YzDfFNI1Ev2Sh3YXBrNcGI66dp1nmzZastmuPWY/K5bGdc7V2Ty
	owKxIua0w1ZoBX9ChhEuAi1jjgQPvZ9utMOs7XGGvzezcmX/5jfi6q8lFd5n2A==
X-Gm-Gg: AeBDieuyaJQK24nKgRX7H+dTy0SxkeK6Q75sU+evIHxtR5G75FkIgh1ZgBlvENKP5PE
	eAAShNECKOA7xp1ghjtjEcMXPNTt2nB+bAkMp1usLRwF/N5DqTzixwRITvGAupaLuEUuhyj+dS+
	31aHAyMiJq/RHG1LqpcmtFkK2wfO5SRxrgQmYnnlVqRTuV1DNsygZzXQfJ/gITKYZMGXDZkQ13C
	6NIRhdUCETzP6lnpks73h20g9cEoBmEykyZvaFMRzfqqaKPPrvs/UL34LJWJD0Dug35kLFJEBQS
	Tj1TfPrxmxZIRNnJVineWKX7QLndPVXBrYDjfjR0qCYrW5djjkuki8nGrSx5UZAixUGBSYktCgM
	hlOwVM8B03CZ5zk7kHeN1/nt/jOpnqrxkgae3SYnBDOODBOefMjR3tAK8WSqSq/QRLGWto6kEr7
	26bMn/o0J2vuH2INO6vWEDuzb+vYYwBETrhtJmZX1y
X-Received: by 2002:a05:6000:2c0b:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-43fe3dfbff5mr66793317f8f.31.1777286533648;
        Mon, 27 Apr 2026 03:42:13 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:04 +0200
Subject: [PATCH v3 3/9] refs: extract out reflog config to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-3-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=TbIrlzJjgXVMlOZxss5mCpB2iHtkFVz/+miIiYS0o9M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPX+a58lPziDFjSYEsnm6euPOIT8VXWhGx
 XWynkEBl8pV7okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z1/AAoJED7VnySO
 Rox/Or4L/i49A51Tv9fogVQMacU3J5lTPlb2cWJ9gv/wdkYX8Lgu+huAvLswhL3WYhVEiTe07zu
 efm0l0ziecnPQzSA2AxDGIR44z8SEICrvjS6Uw9bN15NdOowcQnoj7QLJkvtD7xQeTtea2xorTK
 IwnS06/pC+mNlKIwRUzgcrO1Dvj+7vZL54+LNF/X0kwEdc0XwF7i23P7msx6FQgmi4iG3ujCAc1
 grVFa9cdDBnuDZQrjdy52SNtczn49iD4cfdLAQiD7eqE9fuOuIJnku0OMzVfy35oOU3ryxtMQzI
 LNlaps2aC0c2GHNwKQIppOWKNfW0UClDAaUdIQlN2iqa1txfqpdW7pVeuQrMykfCy0fx04jMYan
 o/jKSTEIsSUrzCsk221iGWoOf11yVsf7bru/7+uuKZFUblBCXcy2GhTxKMWQxFyXfw8bGfLxGkJ
 cCquNN6+q94XeXYO9vXI9W4brTpbaJaDYDRjhl7qefjbftRnD85N1mK2yq9MooB//MaG8hQa197
 CI=
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
index 72afe62cee..4b2faf4777 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -125,7 +125,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
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

