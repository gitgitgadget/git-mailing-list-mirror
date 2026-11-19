Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050385;
	b=Y2tKfl06bfaIlplXk1tAHShe5DrJuGAXLPkMETUWeNdEZG1jiN4mLPXJFqRNhPsvnvEq
	 CSoAhomovKEcTKGeDmBS8LT94TtgS4aAT/MEluY0Qz/XcWEjxmKowmvxIpCMeht4g7g9X
	 Zhe/248Lac4i+waRM4sd+V01cly6RjE9SNF4FxQl8kf10EOXbXywWd/4n2A1r/3Xr/QuI
	 4I+xM8UsxTVz0Z1+L3m3Yp6FFNev8DEykMuVCWur7JJowKHEcT5sLpyIiDhjIPnACfD91
	 3mbkxMl67Z6KM8xWyOkxTk99kOabKor69QOY1xOIueDsmFaRaew/QzOsruyxQj6zchw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050385;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1n/yyqlQIHO9AQ32biL3pQuHach2CjNrWamKIvTCJ/w=;
	b=iKErX+mo7ynP+Gcrz7bZDArIOWNn4z7jAb2fRBa5W6K2PFxSQyb2FvdXUOH8/VQVGG9b
	 v2PFNek1ge8LvpK/4blLTdOWyvFKLwN8VGHyDg7kfEs9KAtl1l28e9Sg5RvWLqcT6Ves3
	 FzVvyr+mc05JGl4Uox22jYQkwgRC0M1fo5agkC+sKB8CFj3ICQoS3GgUfRCwlGXLrW2x3
	 6GhhDfmB4F+n6ZW+2OzIvenhXqmsJ2hh7IWB3ofqn+k/XU1XkVdLyqeNQuSeE7zNUsk1w
	 q7s+juy6UG2LRLkSw6fCxfRENPw8CFe6H6L6ksrn64fiAsIn2FhjPygnUJokkhUUZ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=EaBL+koL;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1C8606A334
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 01:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1C8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=EaBL+koL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1795050376;
	bh=vwD+e15Y2QSMGiMZ7lucwcFwRvcSI7Xdqgj2r6WdGOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=EaBL+koLxq8lgBgJG5x+qgW9/rWNvaB+FefrDmkG0gHjXt1S+5/+IceXWZPT/K3wi
	 eS2T7y3Hmp3U2aMGoabgjCLb3SdrHVBhgWAXi9+eaK7MsG0MjosxE4yu8tAkk2hWmO
	 AqTQR1BmbdxLAJ2G/yij57Val5nCSVV6Xw4eAo3a+LgV3AI9k9iTP9CddMecElUgHl
	 8mfQ8Bdo23ad7EMeV+WZcIZVb1LKGSpCM7a773ygxNpsgOVweq6VwLEDEROE1/8vUv
	 4ZgkhymVYLwf24TjAFOVa8NuPzR6yOuouj+xVH51DvR2Ulkdm0l1wYlUr5Ycg+X29f
	 eiMjsmPOKoJcVRe5eDmOK8IGx3DyVg1wdga2qS68uyo+Prioldm32ZzlFNxyCzDm4O
	 q1zjDP+YodK84RHShSOVlgPdv0EB03ErN/S49BUDMYEnMq4mWEKIUejUjQAFNdxQrd
	 SaIxZEPK39h6JwioqJ4LbtQ+zIvR512qcXnAVnE97LqHxPeQa6M
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7c90:2995:a14c:f1da])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DDAE0200BF;
	Thu, 19 Nov 2026 01:06:16 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH v3] setup: fix hash algorithm detection
Date: Thu, 19 Nov 2026 01:06:12 +0000
Message-ID: <20261119010612.687733-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
References: <20261108011633.1772000-1-sandals@crustytoothpaste.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our current hash algorithm selection code has a few different problems.
First, we do not actually default to GIT_HASH_DEFAULT.  Second, if we
have an algorithm chosen by init.defaultObjectFormat and we re-init a
repository, we will change the hash algorithm, which is very much not
desired.

Let's restructure this code slightly.  First, if an algorithm was
selected on the command line, assume that's what the user wanted.
Otherwise, the other options should only be chosen if our repository
doesn't exist (that is, repo_fmt->version is -1) or it's specifically
detected as having no hash algorithm.  In that case, first use the
environment, then the config, and finally, the default algorithm.

Then, if the algorithm does not match the repository, complain loudly
and refuse to reinitialize the repository with a different hash
algorithm.

With this change, we will choose SHA-256 in breaking changes mode and in
Git 3.0, which is what we want.  Add several tests to cover this case
and several others discovered along the way.  Remove the now-inaccurate
comment.

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes since v2:
* Remove comment.
* Use `$GIT_TEST_BUILTIN_HASH`.

 setup.c         | 27 ++++++++++++-------------
 t/t0001-init.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/setup.c b/setup.c
index cedc031c54..5d7e8d590e 100644
--- a/setup.c
+++ b/setup.c
@@ -2887,25 +2887,21 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 
 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
 
-	/*
-	 * If we already have an initialized repo, don't allow the user to
-	 * specify a different algorithm, as that could cause corruption.
-	 * Otherwise, if the user has specified one on the command line, use it.
-	 */
 	env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
-	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
-		die(_("attempt to reinitialize repository with different hash"));
-	else if (hash != GIT_HASH_UNKNOWN)
-		repo_fmt->hash_algo = hash;
-	else if (env) {
+	if (hash != GIT_HASH_UNKNOWN) {
+		/* nothing to do */
+	} else if (repo_fmt->version >= 0 &&
+		   repo_fmt->hash_algo != GIT_HASH_UNKNOWN) {
+		hash = repo_fmt->hash_algo;
+	} else if (env) {
 		int env_algo = hash_algo_by_name(env);
 		if (env_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown hash algorithm '%s'"), env);
-		if (repo_fmt->version < 0 ||
-		    repo_fmt->hash_algo == GIT_HASH_UNKNOWN)
-			repo_fmt->hash_algo = env_algo;
+		hash = env_algo;
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
-		repo_fmt->hash_algo = cfg.hash;
+		hash = cfg.hash;
+	} else {
+		hash = GIT_HASH_DEFAULT;
 	}
 
 	/*
@@ -3022,6 +3018,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 * current storage formats do not change.
 	 */
 	if (repo_fmt->version >= 0) {
+		if (hash != repo_fmt->hash_algo)
+			die(_("attempt to reinitialize repository with different hash"));
 		if (ref_storage_format != repo_fmt->ref_storage_format)
 			die(_("attempt to reinitialize repository with different reference storage format"));
 		if ((ref_storage_payload || repo_fmt->ref_storage_payload) &&
@@ -3038,6 +3036,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 
 	free(cfg.ref_storage_payload);
 	free(repo_fmt->ref_storage_payload);
+	repo_fmt->hash_algo = hash;
 	repo_fmt->ref_storage_format = ref_storage_format;
 	repo_fmt->ref_storage_payload = ref_storage_payload;
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 9e57a06cea..d89f60bab9 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -516,6 +516,17 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success 'git init uses default object format' '
+	test_when_finished "rm -rf repo" &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init repo &&
+		echo "$GIT_TEST_BUILTIN_HASH" >expect &&
+		git -C repo rev-parse --show-object-format >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'init honors GIT_DEFAULT_HASH' '
 	test_when_finished "rm -rf sha1 sha256" &&
 	GIT_DEFAULT_HASH=sha1 git init sha1 &&
@@ -602,6 +613,48 @@ do
 	'
 done
 
+test_expect_success 'init refuses to reinitialize with different hash' '
+	test_when_finished "rm -rf repo" &&
+	sane_unset GIT_DEFAULT_HASH &&
+	for algo in sha1 sha256
+	do
+		if test "$algo" = sha1
+		then
+			other=sha256
+		else
+			other=sha1
+		fi &&
+		git init --object-format="$algo" repo &&
+		cat >expect <<-EOF &&
+		fatal: attempt to reinitialize repository with different hash
+		EOF
+		test_must_fail git init --object-format="$other" repo 2>err &&
+		test_cmp expect err &&
+		rm -fr repo || return 1
+	done
+'
+
+test_expect_success 're-init does not modify hash from config' '
+	test_when_finished "rm -rf repo" &&
+	sane_unset GIT_DEFAULT_HASH &&
+	for algo in sha1 sha256
+	do
+		if test "$algo" = sha1
+		then
+			other=sha256
+		else
+			other=sha1
+		fi &&
+		git init --object-format="$algo" repo &&
+		test_config_global init.defaultObjectFormat "$other" &&
+		git init repo &&
+		echo "$algo" >expect &&
+		git -C repo rev-parse --show-object-format >actual &&
+		test_cmp expect actual &&
+		rm -fr repo || return 1
+	done
+'
+
 test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
 	test_when_finished "rm -rf explicit-v0" &&
 	git init --object-format=sha256 explicit-v0 &&
