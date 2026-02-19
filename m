Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FDD30B53C
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493913; cv=none; b=kuJS3r63AROKCvLhbBnRjDBHjy1ilfxtOmxWzCwhGxpA8zpQ4P9SMp5//HRaFCxS+iFHM2pAZ7y0rhF+/4FhzD1dn+OmEmgEJ56CN4zAYZM6T69u1dkQE2CMPAQYjPEjTLHIGzQ4e01LJ6qXoQnFM+kgvWDWJ64A6ABzDL4nTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493913; c=relaxed/simple;
	bh=aVVimAxQnXEvoKwM7HBg4GCwFAV+lY4LIvEgckb8BJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhLWRUXjhlxRgrqDE6+CXUvV1My+qjHf/lAdrlloKZ13IbDTDsq8A7yMc3hJG9BiLN5QLKTuSZUoUMy2wC/xvFXdpWUkQuxgMalvMn2C71L6TI8mwm7tpViRPdwinwFWJ5EVFHT59pP3UVYzfC1i4TdL3A3p0/aJrfyTqxUYtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX8Z7cl3; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX8Z7cl3"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so4618165e9.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493910; x=1772098710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXd9qnY9ATdfU8cQUOpxucYYkGsNs4F1l957wBTcmQs=;
        b=lX8Z7cl3g4k4XtNdDtlP/ZHAluRgveBgk8eNtkPcI2QhPMG2uHmzs3D9cYyCKgPwHu
         HNWWhj99ZPEZs2t7t6PVN1hlQM8KtT8oa/H8BROeBQcdHjXNs8KEH0RAa3hF1cfEm6a8
         XmmBohs3M1t/ePIB1aFo0eR+tZAiksjkSasKg+qkJQRMQFooS6NdxNachJ+M/zIQs3Pm
         OvqjCSwpwi91vnJ7SigStWA0/DywdMk8EkGVPg5Qs5VF2SoSQl6Wq3cCUbTNRzbjVTjr
         tvDydn99cZzHd0RCnRigMhORnMECmdvtNbh+9omcD0vdYTk2dl52/eVjB7ESpq+srsNO
         GZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493910; x=1772098710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXd9qnY9ATdfU8cQUOpxucYYkGsNs4F1l957wBTcmQs=;
        b=a9PFCt5VvK7ZD+J0l9bgi3vQx0FD28DvfV4RfWzKtH2lxPDeygiK7lKIWKemLfbCFD
         xjH2wy/3e/0Yk9lTkWkafFBdC+lPoBZ6cMq7YKr1LKWrcVfXOw216udfIt5rXbTuPxY4
         ZRt5QZlsxUcJRIMFoUXYdFQIkMjEVtBO8y4hww0zxvf/Iaw7ue4xxPLY5DR5qNDHTc8J
         iMsQRihq24acfD87NMmB2y529HZsfqO+KNpBIc34iPyKWrv7IMWQWamVoArARScN00N4
         1fDTx7EBbcebumMThIMHuzd5miZVOvUtkF/my7AkpRJWqH+cYf65lGdMJTKHbe9KtsrO
         6nQg==
X-Gm-Message-State: AOJu0YzL80aCY/lTaJrHTDoGT48JtejVgrdMKTcGaRUZ+UYPakaAajl+
	uk9pR2VacYIuNSzNHibIYm9oOr/tILStXWugH/TJCxaWwT80HAoW6JiC
X-Gm-Gg: AZuq6aIPUZGQC/0kEewdYGVzGPG/Br+L7d4P1ns04bG8PdCkURRjOSfLGniK168YlkX
	9vaTgY+8pwFXbGyFGcAH57NZHhqFrH3J60HYIgLSBjlVEozmFJMbMqup4rqX7bUq068U+cvz5YQ
	h3JZQZcOXkIhMMbfCNY6Y+aFnx0Tz2+WUvynVUAG2zXuXAT991qCJWkkxbpJyeGX8hz/Mo5Y//O
	ZPRcK7aT3FETJCoGLcJT1KcZP9f6HhLfLjphsZAciBSwObpvMQDGaRRU+QmXC3TULUT8hVA30y2
	EpWq0e5wkyldk0CRZcYl1dgFK4Z4rQW2B3L+hbb3gebK5nl6a0VIUTZqcActfHvle/ggzVDDCkA
	6friz5OacpXt4PmxCCVdS3MkTyPOUDTa3yAea7nIEhlwhoylKM9umY9dWAnadv7wohKqJfDv43S
	XdHxOy6z0jrqmmQlRLcmbWmCw/OX9O4pLxhU9Qx7IY
X-Received: by 2002:a05:600c:45c8:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-48379b9913cmr302076095e9.15.1771493909906;
        Thu, 19 Feb 2026 01:38:29 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1ea7:2b8f:9148:411a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm694274985e9.7.2026.02.19.01.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:38:29 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 19 Feb 2026 10:38:21 +0100
Subject: [PATCH v7 2/6] refs: extract out `refs_create_refdir_stubs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-kn-alternate-ref-dir-v7-2-16f27860dbdf@gmail.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4490; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=aVVimAxQnXEvoKwM7HBg4GCwFAV+lY4LIvEgckb8BJA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmW2hIU/tAQpYL33fmq0C4lCCfJAij8gU2aO
 BR4yZezsiuxw4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpltoSAAoJED7VnySO
 Rox/L94MAImL1zeexpfqW20iV3GeiHmABk2JpwghblGk254flf2EpP59Rs0HOxWWwRlE0Q/jJus
 PO5vYbJ2JlUYmU8d9G47Z/V2oqDBpIMQV7Osoii1GCo2zj5KuL3+prxGamie9QfFjRPdG04lCv8
 lfCyyf7T9orRRv+Yw0m8C/I66FC47v4i0ktjAHXFcma/L4B/PKe6MtRjsTqVMsfZ4/EMXh1nnBM
 r0lPAyQB8XyewBV1no8jnW8YVkSW13pQ8TDyBeUqJoHrd0oSsnIuhukW226otb2+BR2FSmStDvi
 7c2xDHozmiuD8DS9wxuBpZJ7c77XqvwYbgcgklmdNKitlbmZ+QYE7zG/B0VfEjbpvn/2YWQ5qLE
 6ScpPaNA2pdugjhm2ZdT+xViQxeoA5S068W+JKY0Bn4zrDb+1GUi7po9ruFV1anEV5Bgf5qvQIK
 8g1G1ja+CLIblgl6K4eLOQH5sNARnTQSpCO/RqBi7wQmN63Xk8X8gcXe3lThbf01avqMYcI9Y+5
 Jg=
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

