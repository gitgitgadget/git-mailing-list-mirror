Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C534A76B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833709; cv=none; b=X/Yo4Dhg510nmGnAedc6yYoNrwi1XOrAHC2U0fHZn5jpFM4sDP6PfJLEUbBgwY8R6+eOMJrVLU6UK47FCpYHxeRzPPQXM1bnntVF+eeZ4aNhfVRL4DBNvTJJ2z3J7VzfGRO5gR5bVeP0V0+O1jUbFRFYHx2bWZZi0NbmXfcNVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833709; c=relaxed/simple;
	bh=aVVimAxQnXEvoKwM7HBg4GCwFAV+lY4LIvEgckb8BJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auwrZd5iJJTLAsSIyZWT1i4cKhoJ7wjFBDVAHK02mgvryQpDdcboVPrqpLOjduJydTvaC/t2hEzsdvROKlf3HzhZafKLHzPML0CKgt8vyPrLQteq4mg0XcusEEetH2INlBxZgIeWRgvliJfc92L3fc2ahK/CcoscvFnaFVd3UBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5U+kKmf; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5U+kKmf"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so23615875e9.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833707; x=1772438507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXd9qnY9ATdfU8cQUOpxucYYkGsNs4F1l957wBTcmQs=;
        b=i5U+kKmfSq7j4oC4P1FRhaOL6Q/sdYhtipf7RzDniCG1/pIW3S7Op+pDNM00AqVpK2
         zM3dAOAN7rY/G0PfJiLcuoXa1Btb/Z9fq4nC2doTm8JQ7KxxQCoFG5RZWYq4t62FiNjA
         fXO7xg2SJgAggBfZThNBpf+bxy/mEkjS/nBuYdK/hd7eqCO8RwPLvXZyGR4pq4UwBiUi
         r+AiInnB29H0Cl1ZkDgoFRfPlm0Kc+yIkLWbcJubrKQo2KRM5CXM97d8VqWEZiVxrrNO
         B+xMqHqJStNN2x2Qth+0QUYXqz0aCCCZhRUe3FpeB4ARhIcLo+6/DDKreyQqgqNe/Fw4
         Mypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833707; x=1772438507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXd9qnY9ATdfU8cQUOpxucYYkGsNs4F1l957wBTcmQs=;
        b=SisJBF0LcNuGsPl5B7cPG+GruJjuLjFL5D2JVCOcOD0w38gpK2gRk6we8FxGkHB6VQ
         vokhbb7vxmPCViwMirwot+Iy1xkrd/m/wytM2z2PcaIuLzUjC7AuT2hvmHGCA/N4WZGk
         poM4jMJHe3nlZ2v7U5gfXKvxPW6tCHc6TS0+yTK8VejnqrwMf1IXdquG5bqFv2pGNOgX
         9O0vJRRb5ihYgvW3hLGahUvUZBRchI3KHmkqUu52ZpE2Jz2iP0kkQH4EfVIh2v8OJu5R
         UJIAlsgbG+CGLZtGyXUiWBa8sCTfdTqHYLrHs/FIEeI2w3HOsPhBeKXhLdRu1WP5M1P9
         czJg==
X-Gm-Message-State: AOJu0YynAKloG5A+pdjyZOJmef4tug9Pun9/sJamycX/T7Jg7i2TkXO6
	m++Tepw7dnZ/Bi0lvbmPA4gGIJ4OIanLcpHBqF3TTXvxWN+Wy9KsgM6H
X-Gm-Gg: AZuq6aL+KkdIh7hEWkyAbgTSGqUVfMxive3FM8B6bfBTC+50HaOKLxEy2vSNC7kzikB
	+ABE7HIiV/ooHgYBf6HCQENYN9yQM1ulkYHnG97iyc5fQ9TBgWV5Qu/Plj3WwUImqgFFvYkVyEQ
	uvKOIpP0l8Db2Z1fKCvitVgfDUc38cVQjg0fM/s/B+yVoGYOFKE7+o8bclxjDOMOIG4RDeM2sn6
	vAADaEr+eX8BCVh8caVxzupdW7QV9lXKwNvOWKWdQhrO3q11RbyoK+80qkG8P23KR1J2GEMH5tP
	SHOVrGozPkggQhOBZXMz4LhkXdPXVHPgpca/NszHlBZH6IA1z0kzKFAYcI6QbErT+Gtq7mK0gng
	7RfPKbsgXG6uvINRLj6+aMsQLBmiW60ZGiP0U3A66bdXs6HqzQ/SBfsXOnZIGUNmhb8yEs/UIbO
	+PYlkV4e+lkK/yJNSUOHgeAyMrSSjqzGA=
X-Received: by 2002:a05:600c:820e:b0:471:1765:839c with SMTP id 5b1f17b1804b1-483a95eb319mr135152575e9.20.1771833706463;
        Mon, 23 Feb 2026 00:01:46 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:f529:6f94:a480:7bd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3db3369sm117333775e9.0.2026.02.23.00.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:01:46 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 23 Feb 2026 09:01:37 +0100
Subject: [PATCH v8 2/6] refs: extract out `refs_create_refdir_stubs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-kn-alternate-ref-dir-v8-2-0509c132a203@gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4490; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=aVVimAxQnXEvoKwM7HBg4GCwFAV+lY4LIvEgckb8BJA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmcCWcmb5m9QfhgkJsxf04T/tr60pJIFSaWz
 nxc7rxeij6gfokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnAlnAAoJED7VnySO
 Rox/R90L/j1wDLrEcBw8gU04SPAbAPS2E29NlTRqOT6giReVDyRRfGM6dnVqL5/6nsxg5+qet/E
 TMEg0ad5rI/MJpCrF5Qm9O7uZi0knYuZIztcNqiFlSF7qLBhzvNLqnKScS54Jv2jHIQscOPlZGb
 yOcJlf2+cZUSvLLMplnCymWJ2lfnsEzfqD63pReSA3nC6X+7o6bb7Oia1puN0i2zw0gQkYBsbH1
 L7eeTPeMjRxNWMQT1ZRqkYVfZmzeG5UiF3eInLWTA7KnB4YF9i7OzBMepG3+NMkA2rREZExTpSE
 057fkZz+R8UsaNKdKqTyiBR1S62HqYKCVUvEsYB0sbhfzhfJNJ2gRxMT8+HAWFNTBLEWOH7uWIB
 LwHLhljsiJcusQ0X/zkediYLqW0Paxfx03FKEU0NX1nt+F8YHFflNQjkmjJvye0kEOQHx6/9D/I
 WPx4Zqgt7idctibbOB7GGUQmIxeNugu62Kn0q2LtQmXASgujCoYCEZUUVDvX/bUzxlX4O/QKDA4
 fc=
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
2.53.GIT

