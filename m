Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30B37FF74
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652710; cv=none; b=T8ft1naIerbAbVsYfcIMkkHed9mpfLI2qo/uKTVbi155G5Y/RztT+Sq2+iz7YsQnph0zEheXPv969EUyW6cQWVKv2pu26XY4cKbeFEVfDokeXFaCIqdj0fm1uz8olbysv80iuJ9iQaEVh/BZ1Jl2suk2peW5OgSnte8puoM6az4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652710; c=relaxed/simple;
	bh=SmjIxOwE4yDkUOif+V81xTn5BCazfxPaJnWrmzMosjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4w8QKmoGBg7njHTaPDXbx45EJijPbPszNgBce/GYUpPjx0h5BPJpVEWZAdLtv5cyAtiCwp3/Nt6bYW6cIxLmBEFHHar6KK1S9Jt1HZISKS70DguLznpqYAymJ5mMlQF+fui3T37V9X2r2Er9Kxoc/3pt6rtfJ7dBT/IgkPyYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTxWXf8x; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTxWXf8x"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso44223115e9.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770652709; x=1771257509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwfCDUZHk9Rf3GUGOIEFuyarCaZbxtq0kJIl5UgJeBw=;
        b=eTxWXf8xHqyIgyUdYGMpLHkNJcoAckbjSryS1PY0ALR3taBqYkXjQsbLQtP7kjyz57
         8mgkl9uwlsO4i/qIMPSEEE5vu88Ysq2Vr34xg4r38jGt9I0VyKog8XLi2N+6f7/dRpju
         UYHnn8JIkAPjDv+KpQmq/ns6ioJfy2LIL9wB7xsKHHvNAP9f8IzeybIWQB22Y8vKFsLG
         eikkkNoR/0fnBaeVm7ikjORzTFNr3A1gmzXDwJ1Db+ET0s1cPCikhTS8mi/wVdb3yox5
         gFBKEEUmrEqmc8JhgMA8HsA5DifpQ4IsATkZ7YkmDtwx/IWiqyPcw6LtlP9xZvnYc7Vq
         1HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770652709; x=1771257509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WwfCDUZHk9Rf3GUGOIEFuyarCaZbxtq0kJIl5UgJeBw=;
        b=TAPiprwaYy34sfKxRL9LbXJ97MVzmm7+DkpHgVF76QxbdYrzpAY20YgfK+u6F2ro3h
         m+DkrqCl+SVkvJ+3Cen6arja7AFzXeYnfejxJaEJdnQuEWTGbHJF173ZPc4Bm+Ug7xMP
         U11RzWPLwWo6cIoD3qUrsrw+TnLP3iDo7S2P98Nf0Jqkioh32D+ljqGWuJWyg211dATN
         KOsx3hV1KS95PhZ+KPp/HMxpaUL+7QWTOxHvfGa5EgU2FgsRbOpQPrmRoP2qvrJRBECO
         qWE0jcgiD7AYE8wzYFMYLOJA1/QOy1PQnzcMOUYX8hmfRB0S2XuWRzIflioq+VAdjfEa
         +u3A==
X-Gm-Message-State: AOJu0Ywe4U69wjcBlPyJtY9pGf50Df2WNLJZTJZ2eWocDd6PalPSegXW
	eB2W+/gO+66cDHWOs4Msgej7LnyPTMbnrhuT2yryz/EsRP7UxRKd3GoM
X-Gm-Gg: AZuq6aLhyLhW2TuUp1saJgEB11zyaGrMYTLFYn3XNgCRFeNQSLg6LZJPD80ofMY1PrH
	bYo8OGC7lM6Szn6Ikmp+rC3t570+4OyZxxF0TrblGD+GgGkWIo2PGicnmtQ9QQc+NE7T6G8HxXk
	BleVr6MdTiGRGq+OKBRdNSlqhMRHSdWCGbaQRH3b1xGQtzmbk15vRaA1B086PDWOaZ4nAzUDzoj
	2IMJx5tjnPuzsrW7YTvQcFuFmZ5Wboo9+WaB+Vy6rhNbiGLSYScDFnmB+m6EBrQqNYbc1jjo9pw
	fktkw4OfYW0NaorSbpZaiY1prNzP25HGJOPLUqWMyWCHWWWl5z5jVRabMnGcNX2yiNNMOlkbkee
	keOhyapQhLdM63EMHXKvDZvADvIi8dHv4m7Fk8nAThvfRmm4zYRWukRzNnQdInwcat0ysMOboWd
	rbm4VIzZM7TFJp0WInMfk=
X-Received: by 2002:a05:600c:1d89:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-48320366734mr155463775e9.0.1770652708363;
        Mon, 09 Feb 2026 07:58:28 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9616:5969:7cd9:8b71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096f127sm128163635e9.6.2026.02.09.07.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:58:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 09 Feb 2026 16:58:21 +0100
Subject: [PATCH v5 4/4] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260209-kn-alternate-ref-dir-v5-4-740899834ceb@gmail.com>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10117;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=SmjIxOwE4yDkUOif+V81xTn5BCazfxPaJnWrmzMosjQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmKBB1buURIkAGJMUDYZYFunauFH0+lrhw/k
 U0rmDrDmp4yXIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpigQdAAoJED7VnySO
 Rox/aTgL/RDKAKoaUN7Y7BLVMnBKyXU33z+AZHkD04Vnrl5KeedJRg2HAk/cYsWlkxWQagj1z4q
 9haP5rQVlehDArG+FwrgkUYNDCFSDd05lTTj5pDbchbOmtTKno4Ra0JNd0GHW4+h3SLnCj1BbP1
 33bODWQ7tfeHeseyOQV2Srvs9oihCTKrzTWeLnBJNm0/x4KvtLHY5ytsQF1JK2ex1LLYKsshaZb
 4WBHRbeGORu0LQcb+upUqDgh9OM+0sEa6CBrJCeENGI51Dv/YunIl/uELKkJWe+8/a2p3AxHHCO
 go0VnQusabcxT1bNB+k+zcWS6z2XMjuw356T4fLtcg3q5sdI63HDKqiJcKbfTL+nfZWYsAy9V4B
 sX1++6zKjSrGsoFEZFn1Hd+1DlKUIigm3fxKWBqL4b80huUTPKVuoIIQ6DNqhUMAKenYcuNZmig
 QLFQgHZbVzzx+zfAh2PQv9ICHGPWC73fS1UQ75mJTKyXeap7Tl0Jga5daQ/DdLLc+CcyMd6cdC5
 /k=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git allows setting a different object directory via
'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
the previous commit we extended the 'extensions.refStorage' config to
also support an URI input for reference backend with location.

Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
takes in the same input as the config variable. Having an environment
variable allows us to modify the reference backend and location on the
fly for individual Git commands.

Helped-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git.adoc |  5 +++
 environment.h          |  1 +
 setup.c                | 20 +++++++++++
 t/t1423-ref-backend.sh | 96 ++++++++++++++++++++++++++++++++------------------
 4 files changed, 88 insertions(+), 34 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..66442735ea 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -584,6 +584,11 @@ double-quotes and respecting backslash escapes. E.g., the value
 	repositories will be set to this value. The default is "files".
 	See `--ref-format` in linkgit:git-init[1].
 
+`GIT_REFERENCE_BACKEND`::
+    Specify which reference backend to be used along with its URI.
+    See `extensions.refStorage` option in linkgit:git-config[1] for more
+    details. Overrides the config variable when used.
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/environment.h b/environment.h
index 27f657af04..540e0a7f6d 100644
--- a/environment.h
+++ b/environment.h
@@ -42,6 +42,7 @@
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/setup.c b/setup.c
index 44e393c251..b4a7b82cca 100644
--- a/setup.c
+++ b/setup.c
@@ -1838,6 +1838,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
+	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -1995,6 +1996,25 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
+	/*
+	 * The env variable should override the repository config
+	 * for 'extensions.refStorage'.
+	 */
+	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+	if (ref_backend_uri) {
+		char *backend, *location;
+		enum ref_storage_format format;
+
+		parse_reference_uri(ref_backend_uri, &backend, &location);
+		format = ref_storage_format_by_name(backend);
+		if (format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format: '%s'"), backend);
+		repo_set_ref_storage_format(the_repository, format, location);
+
+		free(backend);
+		free(location);
+	}
+
 	setup_original_cwd();
 
 	strbuf_release(&dir);
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 9c777b79f3..10a9bb1a9b 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -11,16 +11,25 @@ test_description='Test reference backend URIs'
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
 #   <cmd> is the git subcommand to be run in the repository.
+#   <via> if 'config', set the backend via the 'extensions.refStorage' config.
+#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
 run_with_uri() {
 	repo=$1 &&
 	backend=$2 &&
 	uri=$3 &&
 	cmd=$4 &&
+	via=$5 &&
 
-	git -C "$repo" config set core.repositoryformatversion 1
-	git -C "$repo" config set extensions.refStorage "$uri" &&
-	git -C "$repo" $cmd &&
-	git -C "$repo" config set extensions.refStorage "$backend"
+	git -C "$repo" config set core.repositoryformatversion 1 &&
+	if test "$via" = "env"
+	then
+		test_env GIT_REFERENCE_BACKEND="$uri" git -C "$repo" $cmd
+	elif test "$via" = "config"
+	then
+		git -C "$repo" config set extensions.refStorage "$uri" &&
+		git -C "$repo" $cmd &&
+		git -C "$repo" config set extensions.refStorage "$backend"
+	fi
 }
 
 # Test a repository with a given reference storage by running and comparing
@@ -30,44 +39,57 @@ run_with_uri() {
 #   <repo> is the relative path to the repo to run the command in.
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
+#   <via> if 'config', set the backend via the 'extensions.refStorage' config.
+#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
 #   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
 test_refs_backend() {
 	repo=$1 &&
 	backend=$2 &&
 	uri=$3 &&
-	err_msg=$4 &&
+	via=$4 &&
+	err_msg=$5 &&
+
 
-	git -C "$repo" config set core.repositoryformatversion 1 &&
 	if test -n "$err_msg";
 	then
-		git -C "$repo" config set extensions.refStorage "$uri" &&
-		test_must_fail git -C "$repo" refs list 2>err &&
-		test_grep "$err_msg" err
+		if test "$via" = "env"
+		then
+			test_env GIT_REFERENCE_BACKEND="$uri" test_must_fail git -C "$repo" refs list 2>err
+		elif test "$via" = "config"
+		then
+			git -C "$repo" config set extensions.refStorage "$uri" &&
+			test_must_fail git -C "$repo" refs list 2>err &&
+			test_grep "$err_msg" err
+		fi
 	else
 		git -C "$repo" refs list >expect &&
-		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
+		run_with_uri "$repo" "$backend" "$uri" "refs list" "$via">actual &&
 		test_cmp expect actual
 	fi
 }
 
-test_expect_success 'URI is invalid' '
+methods="config"
+for method in $methods
+do
+
+test_expect_success "$method: URI is invalid" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "reftable@/home/reftable" \
+	test_refs_backend repo files "reftable@/home/reftable" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
-test_expect_success 'URI ends with colon' '
+test_expect_success "$method: URI ends with colon" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "reftable:" \
+	test_refs_backend repo files "reftable:" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
-test_expect_success 'unknown reference backend' '
+test_expect_success "$method: unknown reference backend" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "db://.git" \
+	test_refs_backend repo files "db://.git" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
@@ -86,7 +108,7 @@ do
 	for dir in "$(pwd)/repo/.git" "./"
 	do
 
-		test_expect_success "$read from $to_format backend, $dir dir" '
+		test_expect_success "$method: $read from $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -101,7 +123,7 @@ do
 			)
 		'
 
-		test_expect_success "$write to $to_format backend, $dir dir" '
+		test_expect_success "$method: $write to $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -113,20 +135,22 @@ do
 				git refs migrate --dry-run --ref-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
-				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" &&
+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method" &&
 
 				git refs list >expect &&
-				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "tag -d 1" &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"tag -d 1" "$method" &&
 				git refs list >actual &&
 				test_cmp expect actual &&
 
 				git refs list | grep -v "refs/tags/1" >expect &&
-				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "refs list" >actual &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"refs list" "$method" >actual &&
 				test_cmp expect actual
 			)
 		'
 
-		test_expect_success "with worktree and $to_format backend, $dir dir" '
+		test_expect_success "$method: with worktree and $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo wt" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -138,22 +162,26 @@ do
 				git refs migrate --dry-run --ref-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
-				git config set core.repositoryformatversion 1 &&
-				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"worktree add ../wt 2" "$method" &&
 
-				git worktree add ../wt 2
-			) &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"for-each-ref --include-root-refs" "$method" >actual &&
+				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
+					"for-each-ref --include-root-refs" "$method" >expect &&
+				! test_cmp expect actual &&
 
-			git -C repo for-each-ref --include-root-refs >expect &&
-			git -C wt for-each-ref --include-root-refs >expect &&
-			! test_cmp expect actual &&
-
-			git -C wt rev-parse 2 >expect &&
-			git -C wt rev-parse HEAD >actual &&
-			test_cmp expect actual
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"rev-parse 2" "$method" >actual &&
+				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
+					"rev-parse HEAD" "$method" >expect &&
+				test_cmp expect actual
+			)
 		'
 	done # closes dir
 done # closes to_format
-done # closes from_format
+done # closes to_format
+
+done # closes method
 
 test_done

-- 
2.52.0

