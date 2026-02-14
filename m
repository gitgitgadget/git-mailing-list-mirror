Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C65312834
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108473; cv=none; b=o47OkMA7vZq/4PelUi0+okUo/9zuY6cj7Q/UQqXg6+wr5mysfr/RBe5RQU+hx3dKEwK8TEQU7wF/VHy0uZ0TlcrivxUOsmI6bg/QZF+MKpAP0h+kTPWlP2951m1EAIkfDiqEF/x51i+XTtwuIf5KxQUq73J0qsqDnIzFC//ftuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108473; c=relaxed/simple;
	bh=d0agdnYeBHKdzr2XbraWnACf0sm1RvvPm0cjXirkGZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LG11aul2V0v6UrVI0O0p6gy9kYYmj/DIRgFkvqDnQTBoAyIgVu1DWyUxBWVDVdGD31lDFsecVS/rfUcvuBOIQ3enR5qipoDo4TZuet4DmrYno6f0tPumsGPAwEJ7Uzf4v7pVRznsN3r51L3w5Q2/C4TTgQiR0OVaJoDZGhrlo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3BFEzJr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3BFEzJr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso15495485e9.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771108470; x=1771713270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6p90rGCiUViqHsg9UZX/PMDuPnY5XaeDVWEVd+B6vJs=;
        b=Z3BFEzJrE41PTIOOkfdAXVoSE0kDyy4vm2STusPNBYpDUiUrPjZuO6L1egyR+jPQ3u
         6GULnhCkDEbpI/J3Xk3wnMf4ZUxxB/dV0dP8QscyVHWCbPzu4ky0m7b/TLMgu/O8IsE+
         m6JE6OAtDLV2WrOirhcDTZY3S6BS5z79ZrsWsAaoIDrWgDShx5uTTdA1l5rPLT4CRrbw
         k7GG3REKY8WYqzQK2OzpPOGAgR+zDmbMZ2ua0PqXQF1ReghMGxkCGyGgwV6alTudGt+n
         z+QSyjjePPiNmWFaRp9mQWzzpk9ku4FolW4+OSr4y0hHu+LJJwAnodHQzh6hDjf1nLML
         LtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771108470; x=1771713270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6p90rGCiUViqHsg9UZX/PMDuPnY5XaeDVWEVd+B6vJs=;
        b=wd5ejgZIf1HwOubSRdepnxynQAtqOpktVpRXXI818jbJijmJdB7AEACBtivbBuhnYn
         lxu059njCFj7G6YK8EYE1q5SE2/EOvwY64yXdqXKEaN5ATqvaycb2Stx9grdhBUVzp/L
         y4rsQdLe5/L4uFKC4gf+9D4Ve44OUaUPZRU1EmYDJ44/73GX43gST6mg0W3KfqYusfJt
         cloZSKEm3XSSQUYzlxhGZQyKuF87JA8jUfjvA86egO6KsrSjcsCGxrZe3e9vgQmlvAaB
         qYLUYs4eMqJLhD+XrrfnNxYate1jkGR0fmDCnzmNTnie5sjSdRUia5eipbK+6PsrDIpQ
         eZUA==
X-Gm-Message-State: AOJu0YzAmkouC+JfCOGH3ljxnUtmZcvXM7KAxwbo4xymq7Qf2SNLe0Pn
	akRu+gg8zNjbeh0Mc6IEsN+eLqSDbJpjn8vmfIM1iv5FnFHqgQIflOC/
X-Gm-Gg: AZuq6aJLr7+jnaYctZ5VbjYwdYuV33xkOIRcP5rL2tHIpiS83mNrtFJC+ErAkwcZSiS
	hmWx3YPBKqOKj9q2qykmCWsqv3ZYJzTZZFwn7JUzuUV7PQGfDgayy3OrKQqDV9fLIjYA+CjWXif
	WuLqvl4aUmTFmfnxzcUYl1LArJYxuXCBH/6g/hRtto2zdAUyK6NlFST7WWkwEvQb8p56G1y/1e/
	b/e4xbjDDNftn0bxW1Ht0AzdNFkN9Ir7FCKebscS/82zSEJdtnsYvIhNRF8rzJdxRwRGU5J0nZ5
	nPMbD3zTDAgfDJ3Xr6M17e09ZV2x2uxAzjlyz7GlnnMW8MWTPK5JrY39cdIhWLXkdaCAe76oD9A
	LioQU0kCM/eObgon8WpBwhrnyJ1awmxALl4p1Q+GaAecs3+PAxVtDk1VvZi9RJmjAtN2WESVTAB
	LLKTTlBOgasKPDd4HQV0BS/q0vxQ74Ul/tJR0M7J2ivg==
X-Received: by 2002:a05:600c:870b:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48373a5d456mr112649625e9.24.1771108469867;
        Sat, 14 Feb 2026 14:34:29 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ffee:e476:e6e4:b574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm83591645e9.10.2026.02.14.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:34:28 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 14 Feb 2026 23:34:14 +0100
Subject: [PATCH v6 1/6] setup: don't modify repo in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-kn-alternate-ref-dir-v6-1-86a82c77cf59@gmail.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com, 
 ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3524; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=d0agdnYeBHKdzr2XbraWnACf0sm1RvvPm0cjXirkGZ0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmQ+HKJaDMWOoFHXKQa+EczcTO9RpzHqnG7t
 Acviq4X1KPfYIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpkPhyAAoJED7VnySO
 Rox/2aIL/jwSooB0uFck/MIzImitkgIkM/BVxOVBWAN4yRZ/7CnPlzkq8SQ2DZJBcpaEcJ+bAtb
 7esr1q8WdukOWUhi9ZgJjhzrGzyMqPGR0YYOxB5xyrznylYER+nyIIyzlxZeR5ae7u/bzDGsRow
 keGXT+LwIorjUeHxpoq/Fnw2PwZJys5ojIfPJQGD3GNq2lV7KCOQ8DQso/8EgXo0oEbuzkaQhcA
 18L603wOi++uWGekfNQJJOmFtgDbba6tuLRw7khzbFsLGYuS3k5NUQ7+JJef7DLAiKPH+NXm/DZ
 qzFPhT3Kvo9Gt2ED3bFeb72WRsGlL1fG5pHeVEGdfRZT5JsBITzO09A6Yc7AtZqHtnEWWd8bzJn
 P0idlJKy7c9NkyGaRXvIkgs5nKdqpDC2tworDgLT+haSblD600X1YJCg4QdvX7ylhKXZf8M7e25
 ibd9fU/8ZlEzTA4VoaGsaWrdMgFzh30+DpV/iw+D1mqoQPB8LxSGQtU/YeZI6/FDT6nrr8OU+76
 X0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `create_reference_database()` function is used to create the
reference database during initialization of a repository. The function
calls `repo_set_ref_storage_format()` to set the repositories reference
format. This is an unexpected side-effect of the function. More so
because the function is only called in two locations:

  1. During git-init(1) where the value is propagated from the `struct
     repository_format repo_fmt` value.

  2. During git-clone(1) where the value is propagated from the
     `the_repository` value.

The former is valid, however the flow already calls
`repo_set_ref_storage_format()`, so this effort is simply duplicated.
The latter sets the existing value in `the_repository` back to itself.
While this is okay for now, introduction of more fields in
`repo_set_ref_storage_format()` would cause issues, especially
dynamically allocated strings, where we would free/allocate the same
string back into `the_repostiory`.

To avoid all this confusion, clean up the function to longer take in and
set the repo's reference storage format.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/clone.c | 2 +-
 setup.c         | 7 ++-----
 setup.h         | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..cd43bb5aa2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1442,7 +1442,7 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(the_repository->ref_storage_format, NULL, 1);
+	create_reference_database(NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/setup.c b/setup.c
index b723f8b339..1fc9ae3872 100644
--- a/setup.c
+++ b/setup.c
@@ -2359,14 +2359,12 @@ static int is_reinit(void)
 	return ret;
 }
 
-void create_reference_database(enum ref_storage_format ref_storage_format,
-			       const char *initial_branch, int quiet)
+void create_reference_database(const char *initial_branch, int quiet)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
 	int reinit = is_reinit();
 
-	repo_set_ref_storage_format(the_repository, ref_storage_format);
 	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
 
@@ -2701,8 +2699,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(repo_fmt.ref_storage_format,
-					  initial_branch, flags & INIT_DB_QUIET);
+		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory();
 
 	if (repo_settings_get_shared_repository(the_repository)) {
diff --git a/setup.h b/setup.h
index d55dcc6608..ddb9f6701c 100644
--- a/setup.h
+++ b/setup.h
@@ -240,8 +240,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 void initialize_repository_version(int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
-void create_reference_database(enum ref_storage_format ref_storage_format,
-			       const char *initial_branch, int quiet);
+void create_reference_database(const char *initial_branch, int quiet);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.52.0

