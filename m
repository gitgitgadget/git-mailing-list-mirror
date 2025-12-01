Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D42E62A2
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588306; cv=none; b=cYG0T3OVIQtFhCJqU1TDJOTl2+K2E4f3M/ufu+WZYPiGqQHaIsDNahwjyz4HJ6RdE/SkksQglaXPiw3hDhU2A6k2wlD+QucfiaZpl2XRm9nADaST5Veuh+I7fN5ftKwitsEPeQHkhNAPN/XsuZdOafu9aHZptuq1t2LVJSozoiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588306; c=relaxed/simple;
	bh=IFEc1v068vfW0MJMB+g4z2uNjuIFoyd5cvXHblAjUqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVBIfN/hPh4zoSGJkft5INCDTg6SyBKv6nMqgEvW4yhrMUma9TRymOuTyHlbg8gagMFcRPoUH6xNwOGeLqud+bgYmmWMCyZ4xtVoHIAScpMc5SRUeUX3/Q+C34elVGtTbRSH9hPloilizQoBl/XZ2jmfwmvt81XankommmFBojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nftpuKgW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nftpuKgW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so40725415e9.3
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764588302; x=1765193102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ldv5zf62Awz9G2CkMTF5UA9wXOZNexA/Z72lzgrMm/o=;
        b=nftpuKgWrGdudFDR/dNl0LcRPc4AW3ctCAqNkCFXZXS5QRkDGDTVqF3SA8xdfu3TOS
         08S3xNb4mzJV7x72kv5+ae1vWfVHUAEVkLs7AW5ZGDER7jl1jL42tW8UEKTHl/If9XW0
         Ind3MsN/cJxOEKmQuo9ETIRj0haPVrGH21BlrOexcIxC+mAnEBkPtaMcahlKAhdLFcU5
         gcb//McOWOoGDmVy1FRPxt4YFvbfdIGy8Mn/1s3FuOoell6C1ZAy1xVGAtiii3ze6TqP
         DwBE4UUc/965MzQnLbr1TOYZhzdLQ1ukAOPEFnrjFQgODuIZmr79sTA71CC3Nhvcdopl
         Kc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764588302; x=1765193102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ldv5zf62Awz9G2CkMTF5UA9wXOZNexA/Z72lzgrMm/o=;
        b=Q0ayeW1LobUIAQv76mrC6h8pVvoYEzLOI1tDwHe9ozk6OCCYue6RXhi+pj1/TrL1jt
         oKzbronqVP1Yfykx59iO3ZEoapV3FQmwSIv00UkakiWbPaA5QEOMbqwqieV7EHQ3gymM
         H7bNEznnQ01FEsSD73xXkFFGkBJMC0sCxKCNwb9lo3iTnyQm5GRLnBeKApBzhKfsho4a
         bol2CQGbAFFtBKa1yrR6bqc3rVy6WJiO4aiAxhrrSgh+/9/vWJ6FU/TPxPKQbajRMJUh
         J+tMcR7HSXpIACdIIBqtue20hJEPOzjqIGjXn89+uc2sUitTGK1P/DjjjKRCaQ6JS/UL
         R0Dw==
X-Gm-Message-State: AOJu0YxTR5UTimEaVU7n+2BU7owlPbje900A6VnBPCQYj8EaSyUtqhz/
	NpWOg/4vaFuniCv1db0viXmevCnux3lmu1UHC1KktC0+QgixCKX8yI+R
X-Gm-Gg: ASbGncvDqg4vkSplJ2NTFz9a9XpDa1lCKJ1RpTNWpwqN/CDY2ItoTKTUOjHqna7NR+j
	4IBz4U4wkh89Lmorfnak7Q9F6H2WgXxKzE+a1vkw0Ovesg8ahMc86tNdaTIniu0Tc9KcoTywpv2
	QxlRKJT4QodFmbRrZCCnrZSsziuFMxDEcB4k+6tGxTgz/WJASus6AgN1dO/4lV7b5MCFPzY5wkT
	FaC/UK0OAfMJqsZkNdtCF8sGhxE0R/1AdIxf++NVOk2z55AYKKlxYSc8rPbyYPENxGw+pALHSmI
	EYJWBJnJ60EKG6Kn4EXad/1Qz0LpTjq3Dk6zrQiKxeWPgY+KD/6v/EjTqtg8Vm4O3of6qBr+CJi
	L+O6njwOgR1rWnCfIqwTzgYiEpPnnc1nsGox3jAuozlokAD5O05Le6XelN3AI+wJa0B7t7Uw2f7
	Jz5W2Wf8xJXZg=
X-Google-Smtp-Source: AGHT+IGFFv+hJnShqMdh1soy2HDuaKcnBjaZDBAd7exgf83kRAY+iyfXrmV/ROsa9qgKjMTDzYmerA==
X-Received: by 2002:a05:6000:25c4:b0:425:769e:515a with SMTP id ffacd0b85a97d-42cc1d1969emr41237407f8f.42.1764588301947;
        Mon, 01 Dec 2025 03:25:01 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca40945sm26395595f8f.30.2025.12.01.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 03:25:01 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 01 Dec 2025 12:24:59 +0100
Subject: [PATCH v3 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-kn-alternate-ref-dir-v3-2-c11b946bc2fa@gmail.com>
References: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
In-Reply-To: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, gitster@pobox.com, toon@iotcl.com, 
 sunshine@sunshineco.com, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8470; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IFEc1v068vfW0MJMB+g4z2uNjuIFoyd5cvXHblAjUqw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGktewtlVGL7O2xtqcU+GC3Wg4pidIw4zYAAq
 vrcO4EhTRZo2YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpLXsLAAoJED7VnySO
 Rox/5fgL/jQ8gdj8LmlS/zKkf97Mb4Zaa22o4JUa6Vk2Wtx7ff8PzjaRu2qmJuJ6mWMHSj43hv6
 Y7NCLx+jAvUajn4Ei6V9j7ih2eVHYiwsH5gtxsgW8m6eTwdBp9GlHLDjp5H50XQO3vyBHn6+9xI
 e4winHN0bceZXr0exsf0q279kfKN15dxL3AJHhRapGArze+4FrTrCoulBM329nLT0vFC80n5EwO
 xlmgy3iHWVeu235+LbhEYVmGwE1zaR29O3zfoA2gAukMaqfLloC95yWb7lrJYwTH74FGXF6cPcs
 aOdiL6pRLem/8OgpyHAdxI3VGZxwf5IBkfAwZ0myTBnyfl2RDMmHzxb9dziGNiEAgLefjTW1YVx
 XX+SqnhdITKmxVotbwIHf1BuDhBR3dRLSJDOOiaTiRNwhvJuSFh5im/VHeKlv9CSQd3UzNFvYwI
 zITGJkUKYGHEnVUxgTB2rFHKIyMY2tDHfAe+Msaz8TRavyqMNjXTdFWJFaoebicsQPDa0SVQCu4
 qA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git allows setting a different object directory via
'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
This asymmetry makes it difficult to test different reference backends
or use alternative reference storage locations without modifying the
repository structure.

Add a new environment variable 'GIT_REF_URI' that specifies both the
reference backend and directory path using a URI format:

    <ref_backend>://<URI-for-resource>

When set, this variable is used to obtain the main reference store for
all Git commands. The variable is checked in `get_main_ref_store()`
when lazily assigning `repo->refs_private`. We cannot initialize this
earlier in `repo_set_gitdir()` because the repository's hash algorithm
isn't known at that point, and the reftable backend requires this
information during initialization.

When used with worktrees, the specified directory is treated as the
reference directory for all worktree operations.

Add a new test file 't1423-ref-backend.sh' to test this environment
variable.

Helped-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git.adoc |   8 ++++
 environment.h          |   1 +
 refs.c                 |  57 ++++++++++++++++++++++-
 t/meson.build          |   1 +
 t/t1423-ref-backend.sh | 121 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..8c6a3f6042 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g., the value
 	repositories will be set to this value. The default is "files".
 	See `--ref-format` in linkgit:git-init[1].
 
+`GIT_REF_URI`::
+    Specify which reference backend to be used along with its URI. Reference
+    backends like the files, reftable backend use the $GIT_DIR as their URI.
++
+Expects the format `<ref_backend>://<URI-for-resource>`, where the
+_<ref_backend>_ specifies the reference backend and the _<URI-for-resource>_
+specifies the URI used by the backend.
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/environment.h b/environment.h
index 51898c99cd..9bc380bba4 100644
--- a/environment.h
+++ b/environment.h
@@ -42,6 +42,7 @@
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_REF_URI_ENVIRONMENT "GIT_REF_URI"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/refs.c b/refs.c
index 23f46867f2..da76e0c54a 100644
--- a/refs.c
+++ b/refs.c
@@ -2186,15 +2186,70 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
 	return maybe_debug_wrap_ref_store(dir, ref_store);
 }
 
+static struct ref_store *get_ref_store_from_uri(struct repository *repo,
+						const char *uri)
+{
+	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
+	enum ref_storage_format format;
+	struct ref_store *store = NULL;
+	char *format_string;
+	char *dir;
+
+	if (!uri) {
+		error(_("reference backend uri is not provided"));
+		goto cleanup;
+	}
+
+	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
+		error(_("invalid reference backend uri format '%s'"), uri);
+		goto cleanup;
+	}
+
+	format_string = ref_backend_info.items[0].string;
+	if (!starts_with(ref_backend_info.items[1].string, "//")) {
+		error(_("invalid reference backend uri format '%s'"), uri);
+		goto cleanup;
+	}
+	dir = ref_backend_info.items[1].string + 2;
+
+	if (!dir[0]) {
+		error(_("invalid path in uri '%s'"), uri);
+		goto cleanup;
+	}
+
+	format = ref_storage_format_by_name(format_string);
+	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
+		error(_("unknown reference backend '%s'"), format_string);
+		goto cleanup;
+	}
+
+	store = get_ref_store_for_dir(repo, dir, format);
+
+cleanup:
+	string_list_clear(&ref_backend_info, 0);
+	return store;
+}
+
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	char *ref_uri;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = get_ref_store_for_dir(r, r->gitdir, r->ref_storage_format);
+	ref_uri = getenv(GIT_REF_URI_ENVIRONMENT);
+	if (ref_uri) {
+		r->refs_private = get_ref_store_from_uri(r, ref_uri);
+		if (!r->refs_private)
+			die("failed to initialize ref store from URI: %s", ref_uri);
+
+	} else {
+		r->refs_private = get_ref_store_for_dir(r, r->gitdir,
+							r->ref_storage_format);
+	}
 	return r->refs_private;
 }
 
diff --git a/t/meson.build b/t/meson.build
index a5531df415..a66f8fafff 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -208,6 +208,7 @@ integration_tests = [
   't1420-lost-found.sh',
   't1421-reflog-write.sh',
   't1422-show-ref-exists.sh',
+  't1423-ref-backend.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
new file mode 100755
index 0000000000..f36125bf64
--- /dev/null
+++ b/t/t1423-ref-backend.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+
+test_description='Test different reference backend URIs'
+
+. ./test-lib.sh
+
+test_expect_success 'empty uri provided' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "invalid reference backend uri format" err
+	)
+'
+
+test_expect_success 'invalid uri provided' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="reftable@/home/reftable" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "invalid reference backend uri format" err
+	)
+'
+
+test_expect_success 'empty path in uri' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="reftable://" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "invalid path in uri" err
+	)
+'
+
+test_expect_success 'uri ends at colon' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="reftable:" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "invalid reference backend uri format" err
+	)
+'
+
+test_expect_success 'unknown reference backend' '
+	test_when_finished "rm -rf repo" &&
+	git init --ref-format=files repo &&
+	(
+		cd repo &&
+		GIT_REF_URI="db://.git" &&
+		export GIT_REF_URI &&
+		test_must_fail git refs list 2>err &&
+		test_grep "unknown reference backend" err
+	)
+'
+
+ref_formats="files reftable"
+for from_format in $ref_formats
+do
+	for to_format in $ref_formats
+	do
+		if test "$from_format" = "$to_format"
+		then
+			continue
+		fi
+
+		test_expect_success "read from $to_format backend" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
+				git refs list >expect &&
+				GIT_REF_URI="$to_format://$BACKEND_PATH" git refs list >actual &&
+				test_cmp expect actual
+			)
+		'
+
+		test_expect_success "write to $to_format backend" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				git refs list >expect &&
+
+				BACKEND_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
+				GIT_REF_URI="$to_format://$BACKEND_PATH" git tag -d 1 &&
+
+				git refs list >actual &&
+				test_cmp expect actual &&
+
+				GIT_REF_URI="$to_format://$BACKEND_PATH" git refs list >expect &&
+				git refs list >out &&
+				cat out | grep -v "refs/tags/1" >actual &&
+				test_cmp expect actual
+			)
+		'
+	done
+done
+
+test_done

-- 
2.51.2

