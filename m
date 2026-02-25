Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AC38E5F3
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012453; cv=none; b=dU50jkTJr91eYvH/Qo5jLmxim2Gb70H5d1kzdX7CItfdR0L9ic72Wyj4xPRp4ik5lCEsE883aabDG1cYSuVmPN5cTjKPy3V/8bshrMySWxbc7fSxFgH9UlqXa4O3ppbuK4e781Z8VyQsES3LI5WtC7cJ6heScEwPHvuoYZKOLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012453; c=relaxed/simple;
	bh=3pAVZqyYQd44HjXJ3zB97rsDR3C2TAjGHqsd+Z7tbtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkHZhV1ZIo7AnwraUBUEyQ1hAIc1ictpkysjsbEUiaXmhjgiIz16rV3Ct1bHKgiwhuLyIWyK097jzXx1qKyZLnhOwRtmPvaqCHEJXhP207wJVHdkBkyKdO23lPMZ+01I4s4U3Hh2kfNQ3prWOuUy3VoPezTdogIAywEeI/dOh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhI0tlQN; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhI0tlQN"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-482f454be5bso6307675e9.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 01:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012450; x=1772617250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g764AcE8tF1f80OWvHYEL0ofqMQL+KicfXN9lnSr5Zs=;
        b=HhI0tlQNAqK4v9H7vZqpFhekfpC1K1iHXEC75nA/0eNBOiaR9TP0xpuft8gdx1mrVF
         4LVop8b4EhxbKkKu06PsYy07le0gA5SqpMme6cnrytBpfEYraCGwGmhEMuuNLZ1naMCH
         TN0PabEJ9fwUZLog3kSbt4epvclSUaT1lmG2oAO9D6TfvzOT/P/9+lnrhopgIc1/e+5E
         8ERsSVLI/HftbFkoJl+D3nGf1gmscT6rGh2uH/GEfefJqvJQi5IonUv2RKuOk6/ruvNN
         irhQNZAkQz/lSX7lYmOVX42dPiSkl4kFbrlgEoZAZ3fmvhzmXX7DXzo7N4X8u4tZiAdL
         JHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012450; x=1772617250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g764AcE8tF1f80OWvHYEL0ofqMQL+KicfXN9lnSr5Zs=;
        b=KMFgbrZ/M7l2XbtYg7ji+gCjulnzVZpE6ynPzIltVIc1ykDVH4Y439owLdLZseh0Ms
         ol52uWpIZ3yA5ejZybndyuV3PCM7E8Z8L4FaMmCxtdjZw+NXa8LNZ8m2kluwJpGSYzjM
         Cr0b1Me2IwBYZq3ZwGzb1oowzl+kInfPr9qU9nA81DF4f1JkyzJJ8xgcJCXckc6r8mO2
         YQ1EfB7mgzEEyJJyExRaLh7V5aiXaNG0QbbIJGQ1oATrE/pH0LWVvWGGl7jww0gRDyne
         BYfe+Vjl9RHiwe1cwJ0fYladTinqoX54NV0s1cj/fDUTrhLeuUmp7eK5MdzhjE60uG1y
         NcuA==
X-Gm-Message-State: AOJu0YwZHrTPZEYAvhRXIdUkisdE2mTZrx6/WEAe4qEQJCuTBK88c9hn
	j7OOqx3EhswlbaQteIhSE9H+UtRIOPzR8kW53DC1A/dDZfZG+95wNQEt
X-Gm-Gg: ATEYQzyRP+gKuO+a8Hl0jU785vydLPjFCDDDu/HPHF/FtdJT+vyWKZFpfvUie1ADtya
	PsWbDQft2cTfXaqz9C3+0krSe5Q+Docmot2fkLStvc6kIUaS2lvtIDcj+lkv14pAcvF0IwYW3iW
	fKMGNLRkPYySbSTvc6N/57dE3TKOnJjs+/U86p5yl2R/zqnsu3dokugDMlcuL5ItWDFSfmhLam6
	Fd/JBu9LOOhLWECuMIDZ41aQgr6ZRW83RP6rZhAFQ/zQD0bbPi778rIOzSzH6fw1WzJEcjhMfPm
	t1Ld9tPRiuCPsksSKHEIjy9ljjiZ+SHzUBH6JGYH1z2lKaN+DojiHY3aDvGDBACSIG/Vz0Z+JGU
	4zLa+5TzVwGLLCqVHFPtYyxP+enJrXnvcbfm8bv4ZGL+crvHrwjXKt3ZUd7ML5EO6R/3DEQAFub
	IJsOxsVB+Sn551Q2mfVfJVb55D+w01pok=
X-Received: by 2002:a05:600c:3552:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-483bd725417mr54419165e9.3.1772012450146;
        Wed, 25 Feb 2026 01:40:50 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d32e:ae2b:c73c:65c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm12956025e9.2.2026.02.25.01.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:40:49 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Feb 2026 10:40:42 +0100
Subject: [PATCH v9 2/6] refs: extract out `refs_create_refdir_stubs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-kn-alternate-ref-dir-v9-2-3fe118e40e28@gmail.com>
References: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
In-Reply-To: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3pAVZqyYQd44HjXJ3zB97rsDR3C2TAjGHqsd+Z7tbtI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmew5xDhNxdBTh68620zmBmGie+YGccjqk/i
 dTUdmTCUlpTQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnsOcAAoJED7VnySO
 Rox/IvEL/3lqIBOUPTgbKpVtYJMG5kyUzxhyn6ABLVxZtp5V7KceHax+gfTUuxs5cJA57mysmg5
 dz7IgKh47orFZSo/JESj2//8FWoW6lsUJz4WGFJ7a4yakqZgDTVHDqYRHZJIpJrfuvRI3mHgK+v
 L7jC3zP6OdO6cFGaiAR0qae+Bj49q0FEFhqyUYWwK/aDpugwDUjSVVN9k5cKQUs/V4po5tCRUNR
 A/PCyWc/1RqMed3yd04EIRieRrsDVi4CDhOCahk82kIejoiMEJ5Efk2/p7crDFDKwxGtlNc/hBI
 +TL92Am9ZTBYmVymhojeFL1ZpqJjz/XI4Mw/Cwit5SPYT0U6XV9gZGKPvNnu+FLuKjAM2SvFzof
 FrmmFT7tNAxl6rn66AIFsw5pSpR4WlLiXD6haL2CRZf5UxfFQORccgNgwE1GKYnwbH7AxbIkO2t
 ZI7EhhmpBTJs87f0piz8HTNI0HiL20gB8vNKqFU+ogb8BnnVPbEPwrZwI/RCc0DbCT5+x2xXOs2
 rw=
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
index f0abfa1d93..a35fdc6642 100644
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
+ * If provided with a 'refs_heads_content', we create the 'refs/heads/head' file
+ * with the provided message.
+ */
+void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
+			      const char *refs_heads_content);
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

