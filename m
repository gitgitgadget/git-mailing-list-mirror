Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF561548C
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108473; cv=none; b=O3rZZfX3AKm4iudQViwkD/1QnX75ikTtkbxa4eZy+NcNNsyxJtzUW8Wz4bLv3JXN4d4zQ5Jv83NLIaXXmwxGLY/I6wnnZClMcHV+k0cdZnpYAyv2SzIiKk6x5ZMsit4/HWroD4ebtxkNNpZDb+UJiH4jJPH10NoZgcoh40EezDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108473; c=relaxed/simple;
	bh=kEi+uDuvxwPMOraGR6F5bS3uRaepQxJZHvw+6kzLqOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUcEV0ZVwCurnpHAcV5R8L4bS6UdKny9ZXmFzn2UEgkn14PscqfiemjtAw5jpRKxRdl1u/qWwvt99ck7K9HwUz1Se+PXSLOXRhnWLrMjk377tVZu7h/7Q3pa3Ug4j8m37p8cgP97Lmfh4nDIWvrT1/HvQYDJpCY5Go9KU6cZVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5RXkgNO; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5RXkgNO"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so9175465e9.0
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771108471; x=1771713271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJoI8AnprpH+LCLNLxXe0uihiRPd43tfA5E7LNoyZkw=;
        b=f5RXkgNOO+F7bISPg1RH98MsG+ckgF/rVEKKMKsxEuwMrZMzbPjbrDdpz7CwDUHKuU
         gc7bOfEvbBsIjhKTCjwjXMjWLwW/3s6bFKJ+sB2h8oaRhk5oy1jf1OyNnBVMbr/bqYel
         Fum/btNyvumLys9JU2SHpT72tV6kupaDu49NndgtCa8LJGiLcspgBXvnE4x+cpIMcnWd
         shqfghFcBkOivKkYT2p8lt2L1IXlINFllkmh+qdBrUpjlZepf8Bn6Si209klTvNEmpZR
         KBFp9Vp6FSfiS3zg0WduELgdDGdP1WyOeh8urGVUB4FPICge7i7Fqqi2i24Dx8MwiAb+
         6jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771108471; x=1771713271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OJoI8AnprpH+LCLNLxXe0uihiRPd43tfA5E7LNoyZkw=;
        b=If+B5X18MOTSEQkiLLx4vYt8TjLLnsqsHF1C+GUr8PNqfwtfvt6s58caR8QjeatiPI
         EgB7oG/oRRDwWvmrwAgYsNYfqxMJtWoC/KJMICRr2Y5sc8Tkskyp7e5f+E2juD7C52iY
         1riR1ZGZKkdnDbLgrsH5zAgo0GNCf095EFKWhTQQIXSvE6CgRTZU2bp1LsU43YqFFqKD
         0/kfpoCw1AKtroihoGGP3PsIVl1OeQ5IrEt7gB0WqTAlzCbGOlnX1TnvemmLAhLVYZsq
         xvs7cHVoO4tf4FDgUT6QfInUTBESiPs5OGfPKpNeaY0B+xsr5+YCVOZbZpL89b97CXbe
         oR8A==
X-Gm-Message-State: AOJu0YypVa5rrO7XWwWkV4E36tSsBLD3PmCNXLw5g1f2/kgznswFnKYJ
	sCU2jXxOW6EwVJKmxRjksaO+qZHDcxXCgdPFnGhrhKHmgjHYkZbBLxtW
X-Gm-Gg: AZuq6aJWYBFEeLaAIEx7KlAMAjqkAc/aUDoSrjMumW4qyvo2WpEuZSjdPwuplEUlGsl
	6f76MJv60WiuaRqAVHPURsHOzXc2XdH5WW5GHNLh+V5pvwRecGe4SnlyaptJz4F6c85dcVMqpQg
	JydpDPBvU3CUbbnetUd6RV609bqgi9v8fgp6eJkriS/O9na4gWTAgVoLOcowJfVHfLOkDVCkjZR
	rF3BUzMIKUtEH4L7nwWjqQGU2r4nLGFlQ0fcjJiejETzYyA5ODS/176uFBBhQgyJPGBAuNjs+is
	bhz+bK1PWEvM/AUhSOuo1QhtCqlkyFChR8C98MR2pHH1qYQ6IC0U5MtcHR8veBUSXXN9WlnAWk6
	dLGVupDUyjct/kFiqoDD8Y9qUtNWqNiS5B4oKWNfeFt6ysm7C8jk/CNfkVnZ2UuHGuWG3KbqlzC
	b433tRpGY4JyGb9MM7rlAVbewU3AZQwCCxUJP9pbAw0A==
X-Received: by 2002:a05:600c:c095:b0:483:7f4e:fef6 with SMTP id 5b1f17b1804b1-4837f4f00f8mr26889055e9.26.1771108470624;
        Sat, 14 Feb 2026 14:34:30 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ffee:e476:e6e4:b574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm83591645e9.10.2026.02.14.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:34:30 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 14 Feb 2026 23:34:15 +0100
Subject: [PATCH v6 2/6] refs: extract out `refs_create_refdir_stubs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-kn-alternate-ref-dir-v6-2-86a82c77cf59@gmail.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com, 
 ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4488; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=kEi+uDuvxwPMOraGR6F5bS3uRaepQxJZHvw+6kzLqOA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmQ+HLmW//8gsZwFQ0a+VZ7t1+gUWIQr8pIs
 0xYQnLeueD6LYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpkPhyAAoJED7VnySO
 Rox/N5cL+gOzmga3yyhe2deURVv7wu0FjUQaq/33p5BHncfkFXl0KYUK6SIxgiLBFtrwwOnky0b
 o2ZImJ7mum/CMzsP8LfGPYGVhQ2lr596POd6MKMMHD/AAFadW8BcwEizSYe5bs0lmVrC2Qo2WmZ
 LY9g6rE5gBG5QjCRsG2f2ukubdgUbZfdDxJpi9Am6wpgdrjyeFwJrE/YTEX4Dv5L2YFwOrEIZ0t
 fMOdTM/LtDw+vC+0y/hulGfr/y/4uH8Oj2iF7KtR9jqiam0aZKUlfp6JupZDatZoKDCM2OLADP4
 Zv+oKQ4p3T6RdKGkh5hAlXfHojXrs0j80U+gjba2dTLSSvp/dIUmRigE0AZNRIYBbEo9T7NfP3/
 aLt7YThadzWMyASWiEJX6S6xqvQYhyl++iWe0OstcSpO0puK+C2YnMYzW6LTlfY8jhkEYkrHCk0
 KmvM84qx3wlCHqSrerqin0CNnlsYt3bSVtLzsuzqSb9beY6j0HZFt8sCaQRn3YABpDd6Clp8XM8
 Og=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

For Git to recognize a directory as a Git directory, it requires the
directory to contain:

  1. 'HEAD' file
  2. 'objects/' directory
  3. 'refs/' directory

Here, #1 and #3 are part of the reference storage mechanism,
specifically the files backend. Since then, newer backends such as the
reftable backend have moved to using their own path ('reftable/') for
storing references. But to ensure Git still recognizes the directory as
a Git directory, we create stubs.

There are two locations where we create stubs:

- In 'refs/reftable-backend.c' when creating the reftable backend.
- In 'clone.c' before spawning transport helpers.

In a following commit, we'll add another instance. So instead of
repeating the code, let's extract out this code to
`refs_create_refdir_stubs()` and use it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/clone.c         |  7 +------
 refs.c                  | 23 +++++++++++++++++++++++
 refs.h                  | 13 +++++++++++++
 refs/reftable-backend.c | 14 ++------------
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index cd43bb5aa2..697c5bb5cb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1225,12 +1225,7 @@ int cmd_clone(int argc,
 	initialize_repository_version(GIT_HASH_UNKNOWN,
 				      the_repository->ref_storage_format, 1);
 
-	strbuf_addf(&buf, "%s/HEAD", git_dir);
-	write_file(buf.buf, "ref: refs/heads/.invalid");
-
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/refs", git_dir);
-	safe_create_dir(the_repository, buf.buf, 1);
+	refs_create_refdir_stubs(the_repository, git_dir, NULL);
 
 	/*
 	 * additional config can be injected with -c, make sure it's included
diff --git a/refs.c b/refs.c
index 627b7f8698..77b93d655b 100644
--- a/refs.c
+++ b/refs.c
@@ -2163,6 +2163,29 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	return NULL;
 }
 
+void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
+			      const char *refs_heads_content)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_addf(&path, "%s/HEAD", refdir);
+	write_file(path.buf, "ref: refs/heads/.invalid");
+	adjust_shared_perm(repo, path.buf);
+
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/refs", refdir);
+	safe_create_dir(repo, path.buf, 1);
+
+	if (refs_heads_content) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/refs/heads", refdir);
+		write_file(path.buf, "%s", refs_heads_content);
+		adjust_shared_perm(repo, path.buf);
+	}
+
+	strbuf_release(&path);
+}
+
 /* backend functions */
 int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index f0abfa1d93..9d8890fdff 100644
--- a/refs.h
+++ b/refs.h
@@ -1427,4 +1427,17 @@ void ref_iterator_free(struct ref_iterator *ref_iterator);
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);
 
+/*
+ * Git only recognizes a directory as a repository if it contains:
+ * - HEAD file
+ * - refs/ folder
+ * While it is necessary within the files backend, newer backends may not
+ * follow the same structure. To go around this, we create stubs as necessary.
+ *
+ * If provided with a 'refs_heads_msg', we create the 'refs/heads/head' file
+ * with the provided message.
+ */
+void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
+			      const char *refs_heads_msg);
+
 #endif /* REFS_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index fe74af73af..d8651fe779 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -491,18 +491,8 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	safe_create_dir(the_repository, sb.buf, 1);
 	strbuf_reset(&sb);
 
-	strbuf_addf(&sb, "%s/HEAD", refs->base.gitdir);
-	write_file(sb.buf, "ref: refs/heads/.invalid");
-	adjust_shared_perm(the_repository, sb.buf);
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
-	safe_create_dir(the_repository, sb.buf, 1);
-	strbuf_reset(&sb);
-
-	strbuf_addf(&sb, "%s/refs/heads", refs->base.gitdir);
-	write_file(sb.buf, "this repository uses the reftable format");
-	adjust_shared_perm(the_repository, sb.buf);
+	refs_create_refdir_stubs(the_repository, refs->base.gitdir,
+				 "this repository uses the reftable format");
 
 	strbuf_release(&sb);
 	return 0;

-- 
2.52.0

