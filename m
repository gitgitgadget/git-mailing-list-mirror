Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDE34D382
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925211; cv=none; b=ivBC5hVT4Eo9H/X0k0qpe/nVnMg7oqBCtChZ68VpXMmbej78WTQpWmwgm8DFHpgQ+4kWrixjrQNHTwOD14W+6IZBzGnF+iNxFqRbMRi+F5RvGrQDkWthvWSPQOn+ZHVffmSBTklbxzAdDjIjXnR6aEEoL4Q15/B6hzLThxpbzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925211; c=relaxed/simple;
	bh=rY392n9b6eAlwnudVUP9RL0mDx2Nr530DKj3NAEh9lQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C111UQ4QJfgJjw3nae7CJjVnNTSQzSDQn5mXQc+/TX4rHy29a+bjD0zjcFoqasj7TKVTLBAGRfGTgNxQOcsJ9A5Y0Ls1RxU9ypn0HsyYzuoQi8tXcn0y7jJbTPYd66SJ1T9IwyjGnqVu2pZCpGcwQOjfj0NNKKRAbqwUOaYp8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC4KMRIz; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC4KMRIz"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so6337965c88.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925202; x=1791530002; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EBCqv2hSk+dzqGPOEy5CnMtAkJ0QGs0DxLEXX6HAczo=;
        b=hC4KMRIzvdsPa4pUigx3fWnIdwL4ffvLJiT12IFtCqhKMUaU9oN3+0sAFbGz7Ilv+r
         BSDZn3wiohLpA4dUVlzxfzGadoSjOMbQR1QrK1W3C/blKdYVk97Vw5lN3zdVKiPYhLw3
         pWLG1C3ol6Wmzcd0Glt2cJ9mOu63zyrh9RUL6i11GqbVnOeOZx87johPqZZXs1euiEz9
         EijI7e405i6IJSKTYzSbbe0w6GurgLyaJ0bycYd0loioqhzs1Rp7V2QXOKzhECLYd8w2
         GqhoQA0psOBRreEKJiUkdAzGXKjfjQHoMAdBHDVEm9LJXalxrhamVZNs4tFDWVPvlYap
         qmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925202; x=1791530002;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBCqv2hSk+dzqGPOEy5CnMtAkJ0QGs0DxLEXX6HAczo=;
        b=zV3+uEEXaMqZtfoThXQu7tXeT1bar5/sfZPV2NkqE72pV5+MDTZ81mOtI0VOXx4uEQ
         0ze12O8Vj7H+n1I9vOh42lZ7dE+M5XjXkDpGZw/GD13YLcpmagKbXCpiFZwsHm2ppA1u
         AE5Gb4ZE0QOBvN2oku+KCoX724PXzad+m4se8SdAP3QFD2QpVI95C6lnx55xZi7nj2DC
         PVJt1lehHt0G4awjXdXedsvy/T7vV8yhKeeUoll9LwbNb6Y+SC3xF+qVS6yRC71qKgyf
         IASUCuWud2OGlOoZZIldlyAxtRV+k2seQ414ylNX5rtaAq+aZ9obM0MrcqFPuS/dkhTl
         VOFg==
X-Gm-Message-State: AFuF++lz2nNGMWtP5705O9B7ieE0YaOlv/D5ON+Klll/R3oyaA0zWB2z
	v6D8zew7Q+3FBSzdTUZiGhAd5qzP98nY9kjhpTU/+q/sphrd2WjlzB3B2ZB5Gw==
X-Gm-Gg: AYBFou06jKod8P3aRP/gxk+wZUXLreNjU4ybo1CnDppOJqM2nG4cWpmRDf4SMDTnThX
	jDDLHuFJW/oqyD/eTl9E8ZDYhhRhDGYkJNG6E0CJhE74zol4czqql0Wo3RyFnaGZr0xxlOFVhhX
	OmsfPSva4/BCLdZCryfCVtLUkiGNcyc17W82W2wH9ss45F7nWBkcNd2Te9QCEwMbMJWk0mQl8ih
	i2qr4kHszFoPpaMHEQ4C9C4JoWp2pITvltJePVyuYl43/IA83j7u0xVMog7SnufHX1muFUTP+GN
	8fqIWSnC5rF6j8i4XL+D/fLkfjvlCe5mMygkkcjFjMe7GSf1wVDQfAbNMWXI9Du9uVGvxrQJVUp
	xulpDzrBWVLiLCEkC3VL1iGy2l/+qkGvrrurc9DrREG2JDNdvHo5RG9vwbWT5059DPaj9WJmc6g
	7QPda2Q/kMG8qRqboeN2WMjQjnrcoZ8j33nbvgxZSc2lLYY7o3GKZZlI+b9aO1WzI/o62ME2ZBz
	ds=
X-Received: by 2002:a05:7022:fa1:b0:138:148:6a28 with SMTP id a92af1059eb24-14f5b710271mr2617042c88.18.1790925201408;
        Fri, 02 Oct 2026 00:13:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.209.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f410725e2sm3532620c88.0.2026.10.02.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:13:20 -0700 (PDT)
Message-Id: <d48a7004e409952cd1be104840a83168e5e72659.1790925198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:13:15 +0000
Subject: [PATCH v5 1/4] fetch: add remote.<name>.refmap
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a per-remote config variable, remote.<name>.refmap, that provides
the default value for --refmap the same way remote.<name>.fetch
already provides the default refspecs to fetch. Like --refmap itself,
it only maps refs that are actually being fetched, so it has nothing
to do when there is nothing explicit to fetch, on the command line or
via remote.<name>.fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |  5 +++++
 Documentation/fetch-options.adoc |  3 +++
 builtin/fetch.c                  |  8 +++++---
 remote.c                         | 12 +++++++++++-
 remote.h                         |  6 ++++++
 t/t5510-fetch.sh                 | 17 +++++++++++++++++
 6 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..103eada406 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.refmap::
+	The default value of the `--refmap` option for linkgit:git-fetch[1].
+	Used to map remote refs being fetched to remote-tracking refs to
+	store. See the `--refmap` entry in linkgit:git-fetch[1].
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 035f780e58..538914bc6e 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -244,6 +244,9 @@ endif::git-pull[]
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
++
+`remote.<name>.refmap` provides the default value for this option, the
+same way `remote.<name>.fetch` provides the default refspecs to fetch.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..7651b41139 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -509,6 +509,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -552,14 +554,14 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr)
-			fetch_refspec = &refmap;
+		if (effective_refmap && effective_refmap->nr)
+			fetch_refspec = effective_refmap;
 		else
 			fetch_refspec = &remote->fetch;
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
-	} else if (refmap.nr) {
+	} else if (effective_refmap && effective_refmap->nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
 		/* Use the defaults */
diff --git a/remote.c b/remote.c
index fe62068463..017cd9d13e 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init_push(&ret->push, the_hash_algo);
 	refspec_init_fetch(&ret->fetch, the_hash_algo);
+	refspec_init_fetch(&ret->refmap, the_hash_algo);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
 	string_list_init_dup(&ret->negotiation_include);
@@ -176,6 +177,7 @@ static void remote_clear(struct remote *remote)
 
 	refspec_clear(&remote->push);
 	refspec_clear(&remote->fetch);
+	refspec_clear(&remote->refmap);
 
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
@@ -539,6 +541,12 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		refspec_append(&remote->fetch, v);
 		free(v);
+	} else if (!strcmp(subkey, "refmap")) {
+		char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		refspec_append(&remote->refmap, v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -988,7 +996,9 @@ void ref_push_report_free(struct ref_push_report *report)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return refspec_find_match(&remote->fetch, refspec);
+	if (remote->fetch.nr)
+		return refspec_find_match(&remote->fetch, refspec);
+	return refspec_find_match(&remote->refmap, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
diff --git a/remote.h b/remote.h
index cca02033b9..ac485a584d 100644
--- a/remote.h
+++ b/remote.h
@@ -90,6 +90,12 @@ struct remote {
 
 	struct refspec fetch;
 
+	/*
+	 * How to map refs fetched without an explicit destination into our
+	 * own namespace, the same as the --refmap command line option.
+	 */
+	struct refspec refmap;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a8d38d9176..bd853d0a84 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,23 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success 'remote.*.refmap acts like --refmap on the command line' '
+	test_when_finished "git -C three config --unset remote.origin.refmap" &&
+	git branch -f side &&
+	git -C three config remote.origin.refmap \
+		"refs/heads/*:refs/remotes/other/*" &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
+		test "$o" = "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+		git rev-parse --verify refs/remotes/other/main
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

