Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608288;
	b=x3tpD8J9JXcm7lK1Ymvy5Bt52gdn102kOsm+87axXBBLRtp/6JTRSEEaK+/PfCi0MQJ9
	 SfjsTZQuP1XvM9/gqQClEPl8NCdAo7JIj+w9A+9CeTfmZ9lxkVuEI/uTXMfxA+ourumYc
	 odCbNn9CerBJkCjJOWQSbD0NnahiUnKfUB23xr5vXfi+QSoaCEURjS3GJSORrFYXsRZKs
	 fdQaWTkiQYclWRO9NouzVo7drhLcAE7TFWR+iyfzILW8oCkejW0VRua8byypJOn51GnKT
	 7mbZZOFhxu/rXFvFpl9gecTe85b/QzXkVKrciWFg1D5/1Fhct07of20WRrITDNl635g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608288;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZVA+qqeSM57XuafhBi9Q9bZQlz5H+4XZYJ5vX7Nj0fo=;
	b=Lt0/hO6Sxj5lO5QKsOXxnUq6bxe9YqA/jLdBhmLSlPHBeC/RxSb/LQ8fDGc1riAYrRzi
	 Yl+RG9VL64krQtguC0n4ibivAX66G1TEacp4kKJx5ogq3OkQQXjRmToYqZpDP7x8AuMKi
	 7SHmzyyTWDh6QQk8QzsSg1d83hsPfs9ApW+GL8tHPhrSOq47kAyRZbE5hQic0c/88iM4g
	 H/805SSI0MzGOaoIawzeInjOtOcWA//Y1KpJUuTWcRgS3dz1A9hywF7xLiT/JFZHwZt7z
	 Sm1CgekT1NHiXnmPplW5+NRhgz16ki6q8/jSERYyLEL/zs8UPlNXAzgsv/5VeLaqsnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=SuQ9pAoi;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620C606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 22:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E620C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=SuQ9pAoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794608281;
	bh=pLbbE9sx2t3pGmzDBvXAYvR+h1o1Tf7RDBRgxag4K8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=SuQ9pAoiHZM0VW2ZqZQEQwgdqE7z1EdE4nM/WM398EjGr2Cm9aPHENbBCpVSRCLBt
	 JlJlK77kpOrGA0APDFPR6G/s886ww6MvTW8G/d6UEHwwLTTg8kPZsBKeYVo2ca0/No
	 KQXrXH+XHMZDPcic6yV6wuQaWHn839bZ5C5vvdnDwUzgRm9zM3QorNCVRiYjayfZLP
	 1XYPMEzFZLyJVKQWGaVvLWftuMfXr/7IGPNteQ8UGZonSgrC3MJ9nGkVJU3HcX9qs2
	 buOzls4bwdWAyLMYcbdblAknaSEP88xMAk30DLbmfpsPfX3FA55Uq9C1yijXee9Ose
	 d7sbVMZ82vai5L11I/ZPu+5QrlGVo8qvPg2dsMNXXi2j1uBbQZHjLwY5pga2pmp/N3
	 iblO6+wuaEfDoas/mMpw5miT+94G9HdMTxVA3apf5Hp28LvhHOY87fdqn0bzB/MS+W
	 hIgFFjgIMvFf3/oSbaBAZ2TgmrwgyWpdX4yVM8C91rBE9wIG8x4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f0c7:7240:9733:e326])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 543D3200AA;
	Fri, 13 Nov 2026 22:18:01 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH v2] setup: fix hash algorithm detection
Date: Fri, 13 Nov 2026 22:17:53 +0000
Message-ID: <20261113221753.3408862-1-sandals@crustytoothpaste.net>
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
and several others discovered along the way.

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 setup.c         | 22 +++++++++++--------
 t/t0001-init.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/setup.c b/setup.c
index 61bcdafe82..14c6e1a67d 100644
--- a/setup.c
+++ b/setup.c
@@ -2817,19 +2817,20 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 * Otherwise, if the user has specified one on the command line, use it.
 	 */
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
@@ -2899,6 +2900,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 * current ref storage format does not change.
 	 */
 	if (repo_fmt->version >= 0) {
+		if (hash != repo_fmt->hash_algo)
+			die(_("attempt to reinitialize repository with different hash"));
 		if (ref_storage_format != repo_fmt->ref_storage_format)
 			die(_("attempt to reinitialize repository with different reference storage format"));
 		if ((ref_storage_payload || repo_fmt->ref_storage_payload) &&
@@ -2908,6 +2911,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	}
 
 	free(repo_fmt->ref_storage_payload);
+	repo_fmt->hash_algo = hash;
 	repo_fmt->ref_storage_format = ref_storage_format;
 	repo_fmt->ref_storage_payload = ref_storage_payload;
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..d8244a2dec 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -516,6 +516,22 @@ test_expect_success 're-init from a linked worktree' '
 	)
 '
 
+test_expect_success 'git init uses default object format' '
+	test_when_finished "rm -rf repo" &&
+	(
+		sane_unset GIT_DEFAULT_HASH &&
+		git init repo &&
+		if test_have_prereq WITH_BREAKING_CHANGES
+		then
+			echo sha256
+		else
+			echo sha1
+		fi >expect &&
+		git -C repo rev-parse --show-object-format >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'init honors GIT_DEFAULT_HASH' '
 	test_when_finished "rm -rf sha1 sha256" &&
 	GIT_DEFAULT_HASH=sha1 git init sha1 &&
@@ -602,6 +618,48 @@ do
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
