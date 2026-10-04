Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF60415F17
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102691; cv=none; b=t8WIJIIl6XBzp2MDxsoyR+pZ1eDvtryquAEaNH1udcTVlTjMW/8In/nMyQkno/+/gESXtZ67bQl9Vw9LTMqMWLcfHvlrNQornZegJzyOIT5wi+G6YZmxsqOk/b83eM/kaVxVYWVYJ1UKfj7eBE9OaCTnOnRJqZX3xoyyJXXD6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102691; c=relaxed/simple;
	bh=qrC79qzcL1NKl8LIZoRKmlEZbpYvcWvFCP3+B6oemV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fiUv1ccEkjxzF8N6LPcgW5BntGFlr+Ebvvov4bGV/7uow/YhriyuOJQu/5j2qbqfvLojQD3R7/LG+ppNP12z7cgd0XOj+aaaqTdlXwlFaierSoY3rIjw6MBtlIoUEa4lZzebklWylocTXu+NvtLjkGKWrQ7E28fOSES57kL+b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXmMo041; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXmMo041"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-34bb8b31647so1530285eec.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791102688; x=1791707488; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F+fsmru50FdVEOQ51lCOYoCZ90QnWFi+8Q353oRKLN8=;
        b=RXmMo041quA1z/T06Tbzk1yY3F1ZSAOJDBV7xzKvkhAgllhWTU2/Q4T3y1DzWBDGye
         euTPN+OYTLGpqJYXUKEdAoYwbKOVIFlIyWqeiTsWMByaaDROvvVstiFvW+DkFX9Fma3y
         zq+W0peLfUi/a1S3tRPB1dojRwjjdQul6suGdF3XsS7QqocNNRn7N3b5+skNZPWf73Am
         FOOYXeuD0ZMQMWW4Z2tPGFoLeETuEeQypvr9U0yj/ttuag5ZZSurxi8ekgdl3Y/pHuNB
         6yRLn0JJQc5PSbNT1XdBH6mZ0MGzlVnnkm6M0xcamOuaJdQo/nCoLm/daREvt6dgZ5fh
         wYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102688; x=1791707488;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+fsmru50FdVEOQ51lCOYoCZ90QnWFi+8Q353oRKLN8=;
        b=DB4c1ap6zUlc7XEURdzJKlJj7mwZDZ720cU4AxqYdygOieUlVW8XgjFE6ZfX+32wI5
         6scoYSJN9b/FdOhIto7XZebALHaUY25hep3cq1wVF7+JRcWISpztcAJDa6eGve2QrATm
         NqgFlBT8NJjeUNBpGvVorFVmk2zm68sjpow9C5F1dqITII/OAEWItxBkvSEjmklxkXVk
         1VdidI1TeziE2R3tSN529LPskGLQBnG3dVTCMAIIl0KnNEfrisV4zfMuAasEr/gl/8NC
         Y0T3kSGDTJrR3p6p3Q1ggiXpCQ4TLH63CscOG9p0VjpBxPhm2vBgWkP8qoV66Abh3sAA
         HpVw==
X-Gm-Message-State: AFuF++mVIrYOXaSo6xTgoRRmDdaC22+sm2d/IU8djWkDsJ6U1JJnp/Xh
	zEjK11IFD/1oFldR0keSuBdTk8f3f7GsVlYSof9s7P9T5rJLjZxkxXZLAxZMUg==
X-Gm-Gg: AYBFou3JmSLCXZhZGT+IVnEEXD55/WGBhcyGo4mxoiAR0IQlrTE05cbHjLfWRtiCTUJ
	AK551botX9AcN4Edn7DTXpfNfi7iQdP64iVK1f2PWdKmxDfh7i7K2JlghaHcBAbiUcLgobAtkeD
	L/Egv5lNeMipzeDnt3XgBcj8KyRfkztuJzeljNUEeGbIwNYJLJv63TwlT8Exu1CTZa3tdqu6fYZ
	PpkljxsbdMw+Cv+troB66dKnYkOdCzNvIHksqPDzmu0zWzIyrj9VVvTAvyecauj5z9ZhIpqIhBH
	TJWU0KyZgbt4jFyIYnxVWXSQmx+EkICOk2n7bFc7N0p4zXaneLlkSvyTMlElxbYtSWk1tu/+G/i
	KBDlHonChjwPuneqgIgZp8M2XQu9X6ta3KTWArzhrzskClveSDuzYY5Psc61AZE755GRmY1VbhL
	e8YeWlORVkHEFZvpWwVPx6uRyMfWB1TalDuUbRv7yRLZFTFRvUY2rS+GseVqjHrXB8+/qrQGuzO
	cne29EeaWul
X-Received: by 2002:a05:701b:2513:b0:13d:31c5:815e with SMTP id a92af1059eb24-151c32d97cdmr6283869c88.17.1791102687493;
        Sun, 04 Oct 2026 01:31:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcec9a95sm12178526c88.15.2026.10.04.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:31:26 -0700 (PDT)
Message-Id: <5c31a51bb7ad9d8e7e88522e3e4903a07d830568.1791102684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 08:31:21 +0000
Subject: [PATCH v6 1/4] fetch: add remote.<name>.refmap
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
index b2decc6cfd..04d0a78ecf 100644
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
index 300bd5396d..36fa9319e1 100755
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

