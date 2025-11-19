Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0D303CAA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588941; cv=none; b=bRoPemU+qnVZqj+y/Y4MFGeSKoyOptst8Tz8gAibvveOuz25J9aoMP0DTy9V5lKQVN1XQxTJXcJIAhbrIlvpNfURNAM0RJ7dMrsSCVxCgVtO5lFWXLrhOd3czxlicUBDRLHEEK/PiT/zvZF/EVvD+FkGFD6npLEyfBEW2faOVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588941; c=relaxed/simple;
	bh=H7FTLeX+jW3eHPmLY/rhz38vK/YqxO7x0X4AhgYeYgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlYmcTIVhQ7atZZ2wQskwmTDC0VuHqN/XrboibKvlPv2id0dyHRfNW06idIJomYSFIcLHpJGjijxO+68Pnk9nNTYBhWoyGg8qs/9d+r+IuzTuQ7n04qqGSjaGR1mEfDdGplHtV+Fq/h+USBXuZ2LTZNxjVtGOoKesMLx7NlJlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LO6t9FQx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO6t9FQx"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so222500a12.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588938; x=1764193738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwO47DKMK4Wj6T392YwCAVLRaNoP2VWAcOwzT9HmuEg=;
        b=LO6t9FQx//SUQBNrhcD1uCIyeG2mVVwmCq1qZeRKH7Mig0qvfk1tYpjxyhCHaUA48I
         VgMwbpbtVZL0p5ZT1VNDMhUn4hhFuDOdONphUSzuDhPAoinzzYPV6/Ahmgvgcr+EVbaC
         UviLuIG6M76nwjEopmIaKosKlxuijtqlmkJzUM6EM/SOvYUA0YRAI9PNfeDFC62XF8z2
         oZrRVBWV79Q+yahjBqgIOGBPT7WDV6Kq4lIvvy/Hp9xnmnFvo8Yi8qizqIWSS2XZDX53
         cF1bnZ+Qww17WySSkxOUDg3+MAG6j3pRY+LvxF7zUwiOp+7c5gLFfVsxEADKbJCwLU/h
         3WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588938; x=1764193738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lwO47DKMK4Wj6T392YwCAVLRaNoP2VWAcOwzT9HmuEg=;
        b=oAPE7YEkeebqGZnZEOg43OHmlOwiQMOI2uMXK8wCIHs16ghCffxTpYr5eNrHD+6opZ
         sDAicTDSkxVpT0b9Hes605bbG/iGPcBpwtuNl2uE8/0ayafPEyhw0SN/3FQtmEW1mkJM
         iUyCFYhcnx2IEQmMBlvqnM9LB73pqTJCzEMhFYdUCTOEdCROUm4uMTPoFOw0BrUb/g2l
         bJXt2xb/NQS4HqzC6FPNBNz3l4wiJidZlBVMkVOJiac4jUFPDdiDAA60wjcyuh5CQMvJ
         YV4C5akFcjc3qTjdC31sdRqo9OOvoziBH4AhRIsYzHILufvChKvFozlkJWZrGsndATEb
         zaGw==
X-Gm-Message-State: AOJu0Yxlj+WyCP3ysNLFmVKteJ7Moaf8EQeVtv1t6pb0CDDhAWV/FrrT
	WwnPIx66YGEMYxNydtBoBvAo2009rq77utnpeXygceYlie2+c8ctRpoDd8lSNg==
X-Gm-Gg: ASbGncu/9VXR68FfPLPQ7nr2wSvnaQ7spD5mZo8SWvBXjIFqhNYkg2AxMWvbHGGkM4z
	GOQV+pcFh9DkgehTRqel29FGghVpPpJOpAGLtXViTi1Fzr1708Bm/GLCRmqzJE4wXQ0K61wKV8m
	GPbGOAmjOTfneL7FsdPezKvnVKy+bAPRVnNxs8RLrmHrkhCFTErSUQW+ivZ0GLdfcuj05PwlrKJ
	Rxg9jEqIjs4ADJ6S9TOSY0o6pnnYtS4AHvPRppNMYNRZyY90Vk4AIrVXF6mfWZ0dNKXR9w9Svuj
	zC1H/luHce9PoHxao9G6APmCs47hguY03ghkgNmyb2Ete9Q9UNistqS45seDCof8GsvUpXg0PBe
	IAPm3A5vX5qCHbq+WRE1CjdPdrsc+dwlD/HibbqiyHMqn7APDbnvONUUHZSFS3jDBIyRcvAMqxu
	hz/4ShTGE1Lzz/VESKEUj4xnkq+w==
X-Google-Smtp-Source: AGHT+IHIg38cA4FbX0qL3QHHyhDryBG1XunLt+on0gWtlzbWjzUBb1Xk1B5Tck5xDu/JM3SFt7p0UA==
X-Received: by 2002:a05:6402:2115:b0:641:15d:6b97 with SMTP id 4fb4d7f45d1cf-64538199e68mr203854a12.2.1763588937935;
        Wed, 19 Nov 2025 13:48:57 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:119:a01c:1871:c4bb:6fef:656d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d307sm528090a12.19.2025.11.19.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:48:57 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Nov 2025 22:48:53 +0100
Subject: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend and
 directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7867; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=H7FTLeX+jW3eHPmLY/rhz38vK/YqxO7x0X4AhgYeYgo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkeO0YJ2Vubn7i3PTCBlDTe/4E1eq3RGZvgW
 15TW3MBrypD0IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHjtGAAoJED7VnySO
 Rox/foIMAIa4jraBQMLhedpZf7G11ihzYiZ8uVADMaYvRwNVq+M89JPc9M5sMkgzEIPjvGgbUqm
 hwWOwmqvRlAFfsYuq4ZnEWhQAtAMfWXpF6BzDCGPVjCfIQr7t3woSszA2cAMh2fkqQRvb5I6bQU
 4c10rgoY5QuzJi3HgFVer0dOzOSFS/4Cj9+s6ryuou5VSCzyFvxnVDCGCzzm7iPRGnQC28X+YS6
 TwjkgQ8JzMrI2359wicY4dM2rIdURhFizHpa/P3myTzAgWUaTkJ2EzKLgYgq6D/+ZL0eAeYdav+
 Ud5IopqCrQ20YNaH5YLgsR+hEjuc9j+2jg/0H0l4JAk75tyaLg/az3sMnWl7wcpzZsn5noe2Tqp
 jZ0ExqmnsmxQ02wXGPnd5xybvDZPTqAWmt3FkBljOA/ZIVOTbt3UhrnJpGbli3+2MJtdSF18uuA
 Dcy6gv6CP0ni/TI06t5dWultnc74cEJJwfwCVHkvSBxijC4NMleLy8SuGjb9cI8UWHpFrNdA615
 +o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git allows setting a different object directory via
'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
This asymmetry makes it difficult to test different reference backends
or use alternative reference storage locations without modifying the
repository structure.

Add a new environment variable 'GIT_REF_URI' that specifies both the
reference backend and directory path using a URI format:

    <ref_backend>://<path>

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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git.adoc |   8 ++++
 environment.h          |   1 +
 refs.c                 |  53 +++++++++++++++++++++++-
 t/meson.build          |   1 +
 t/t1423-ref-backend.sh | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..a1d1078f42 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g., the value
 	repositories will be set to this value. The default is "files".
 	See `--ref-format` in linkgit:git-init[1].
 
+`GIT_REF_URI`::
+    Specify which reference backend and path to be used, if not specified the
+    backend is inferred from the configuration and $GIT_DIR is used as the
+    path.
++
+Expects the format '<ref_backend>://<path>', where the 'backend' specifies the
+reference backend and the 'path' specifies the directory used by the backend.
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
index 23f46867f2..0922f08c9f 100644
--- a/refs.c
+++ b/refs.c
@@ -2186,15 +2186,66 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
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
+	if (!uri || !uri[0]) {
+		error("reference backend uri is empty");
+		goto cleanup;
+	}
+
+	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
+		error("invalid reference backend uri format '%s'", uri);
+		goto cleanup;
+	}
+
+	format_string = ref_backend_info.items[0].string;
+	dir = ref_backend_info.items[1].string + 2;
+
+	if (!dir || !dir[0]) {
+		error("invalid path in uri '%s'", uri);
+		goto cleanup;
+	}
+
+	format = ref_storage_format_by_name(format_string);
+	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
+		error("unknown reference backend '%s'", format_string);
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
index 0000000000..e271708e02
--- /dev/null
+++ b/t/t1423-ref-backend.sh
@@ -0,0 +1,109 @@
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
+		! git refs list 2>err &&
+		test_grep "reference backend uri is empty" err
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
+		! git refs list 2>err &&
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
+		! git refs list 2>err &&
+		test_grep "invalid path in uri" err
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
+		! git refs list 2>err &&
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
+		test_expect_success 'read from other reference backend' '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=files repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=reftable >out &&
+				REFTABLE_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
+				git refs list >expect &&
+				GIT_REF_URI="reftable://$REFTABLE_PATH" git refs list >actual &&
+				test_cmp expect actual
+			)
+		'
+
+		test_expect_success 'write to other reference backend' '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=files repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=reftable >out &&
+				git refs list >expect &&
+
+				REFTABLE_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
+				GIT_REF_URI="reftable://$REFTABLE_PATH" git tag -d 1 &&
+
+				git refs list >actual &&
+				test_cmp expect actual &&
+
+				GIT_REF_URI="reftable://$REFTABLE_PATH" git refs list >expect &&
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

