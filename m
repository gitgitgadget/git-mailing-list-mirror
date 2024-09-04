Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505561DFE2D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472806; cv=none; b=uWtSwkF1JLynnAeoc5Hh4f3vdyGXbnZE3Y3sy1StrfV25jIHNF+64GxLSzYLZc6bJfhWm7oWQbifAaGigI5WLiiRFL+1Yd/1mM4yAJGooAAGtKD3kSVT+aMtU5eUgK09T2uApwPs4JSiQ3+UTAVwUNJlZq2mzytAkPMzsNnx0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472806; c=relaxed/simple;
	bh=59mRVRmZ2EJNpvk/7I2hlXdCDE3+v6nFQMlTGCs6fwI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=k7Wax2Z4Y5ps3gxhtb5q8dEkfG7qn2Vh/OTfOEebS5/mJxE5RCLL+e91mRslpJxdZzDNrqrsf+YARScHI5Y3azsJTOQhSAcLGDKQpr+T3e6f2G7BWBLatcnX4Bc8s1Vt7wp89UjzJSZn2dvndPVh+9I8gzahXDNiYYKJjHxegAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et9WvbiN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et9WvbiN"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so1557085a12.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725472802; x=1726077602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uXAcKSmoixRxQyYWTExC3JWRdl1/0J4xaR1dpVKqaXg=;
        b=et9WvbiNfdlvzSGEIAs+Ju5W8mJhXJeULPH+ewvsvvZjdl2KFZ2Eq5BKfbGToNAK8B
         y410DKRX4DafsPqq2H89Vl8MsWiYP9NpdfxfWxSBxk3ql1ucz67fAxW4rsXo0bh9kbYa
         5zl58gyEzaxEpcginhj1Np+rvN7bG9eZ0Ol4rUvzaLj4wDrsVwWoXrAPHN6tSsOEs1dU
         mCt0kNVYGzsAVgrJfBUUCHgl3IOut2LuZMVkz/WdY7qM5QTqtHXN38ltLeOvLq5O1iEw
         vy4xgRRVAXeGr/oeer5LgAveHMWkdxqe4zaDiubr4rqayk0oYZd5U+lEWdOBpfpBDQVe
         oJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472802; x=1726077602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXAcKSmoixRxQyYWTExC3JWRdl1/0J4xaR1dpVKqaXg=;
        b=hADOccTegqj95NpNUWTdeUILMbevhs75v0dfpwiTaFTEzuamKMUAJFyMFDYPTmFeBT
         eJ6K2HJY0QULRBuzvQM3X+Pt3ayyx7bwq8xApfkriLZLUcXJOeU+A4EbXTy2HcsV51ip
         /pJQDSkPyRP2a/ji5xEynPW1wtQWd3iKjp+AnFE7UNlqT5yfvbs9AgBXagclpG5q0fDM
         oC+DPRR7EUmh42jX/ibzRBJkoml2SIrJqAGQjcf1aWXue/rExU9kTiilYUdjUmVVswvA
         +IRPz5zs3pJNpnkuCyDs0mZA5/DuweICE6cq5biSiFsFr80ijgdh9M1A9BZBlJy7OHgv
         spVA==
X-Gm-Message-State: AOJu0Yy23MW0h12F+JNHVxzbFh7dbanSm5COrmJKK4XzdttEUpqSnM4O
	7jbMHPmQf+fSLg8mEBNH06PeIjelW7RtY8ZOn9tZq/uykzm370IpWIeBXQ==
X-Google-Smtp-Source: AGHT+IEsHB27cJfz/fJEoCyzeMjBmTMC0b9/KNb2CKc0xW7GOVnFtpN9hNq3tABctVwNWerkzDIajA==
X-Received: by 2002:a05:6402:5ce:b0:5c0:ba23:a55e with SMTP id 4fb4d7f45d1cf-5c21eda0c36mr18280031a12.38.1725472801188;
        Wed, 04 Sep 2024 11:00:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc528c3asm174737a12.14.2024.09.04.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:00:00 -0700 (PDT)
Message-Id: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Sep 2024 17:59:59 +0000
Subject: [PATCH] remote: prefetch config
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
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Junio C Hamano [ ]" <gitster@pobox.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

Large repositories often contain numerous branches and refs, many of
which individual users may not need. This commit introduces a new
configuration option (`remote.<remote>.prefetch`) to allow
users to specify which remotes to prefetch during
the maintenance task.

Key behaviors:
1. If `remote.<remote>.prefetch` is unset or true, running
   `git-maintenance` will prefetch all refs for the remote.
2. If `remote.<remote>.prefetch` is set to false, the remote
   will be ignored for prefetching.

In a future change, we could also allow restricting the refs that are
prefetched per remote using the `prefetchref` config option per remote.

Both of these options in unison would allow users to optimize their
prefetch operations, reducing network traffic and disk usage.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    remote: prefetch config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1779%2Fpastelsky%2Fsk%2Fmaintenance-prefetch-remote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1779/pastelsky/sk/maintenance-prefetch-remote-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1779

 Documentation/config/remote.txt   |  5 +++
 Documentation/git-maintenance.txt |  7 +++--
 builtin/gc.c                      |  3 ++
 remote.c                          |  3 ++
 remote.h                          |  9 ++++++
 t/t7900-maintenance.sh            | 51 +++++++++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 8efc53e836d..c2b3876192c 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.prefetch::
+	If false, refs from the remote would not be prefetched for
+	the prefetch task in linkgit:git-maintenance[1]. If not set,
+	the value is assumed to be true.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 51d0f7e94b6..2fd38706ea2 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -97,9 +97,10 @@ commit-graph::
 
 prefetch::
 	The `prefetch` task updates the object directory with the latest
-	objects from all registered remotes. For each remote, a `git fetch`
-	command is run. The configured refspec is modified to place all
-	requested refs within `refs/prefetch/`. Also, tags are not updated.
+	objects from all registered remotes unless they've disabled prefetch
+	using `remote.<remote>.prefetch` set to `false`. For each such remote,
+	a `git fetch` command is run. The configured refspec is modified to place
+	all requested refs within `refs/prefetch/`. Also, tags are not updated.
 +
 This is done to avoid disrupting the remote-tracking branches. The end users
 expect these refs to stay unmoved unless they initiate a fetch.  However,
diff --git a/builtin/gc.c b/builtin/gc.c
index 427faf1cfe1..88b8d80aff6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1027,6 +1027,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	if (remote->skip_default_update)
 		return 0;
 
+	if (remote->prefetch == 0)
+		return 0;
+
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "fetch", remote->name,
 		     "--prefetch", "--prune", "--no-tags",
diff --git a/remote.c b/remote.c
index 8f3dee13186..05edb3a5f40 100644
--- a/remote.c
+++ b/remote.c
@@ -140,6 +140,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	CALLOC_ARRAY(ret, 1);
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
+	ret->prefetch = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
@@ -456,6 +457,8 @@ static int handle_config(const char *key, const char *value,
 		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prefetch"))
+		remote->prefetch = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
 		if (!value)
 			return config_error_nonbool(key);
diff --git a/remote.h b/remote.h
index b901b56746d..57d21a7bfe7 100644
--- a/remote.h
+++ b/remote.h
@@ -77,6 +77,15 @@ struct remote {
 
 	struct refspec fetch;
 
+	/*
+	 * This setting for whether to prefetch from a remote
+	 * when a fetch is invoked with a prefetch flag.
+	 *  -1 = unset
+	 *   0 = don't prefetch from this remote
+	 *   1 = prefetch from this remote
+	 */
+	int prefetch;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..7bc349ec546 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -245,6 +245,57 @@ test_expect_success 'prefetch multiple remotes' '
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
+test_expect_success 'prefetch respects remote.*.prefetch config' '
+	test_create_repo prefetch-test-config &&
+	(
+		cd prefetch-test-config &&
+		test_commit initial &&
+		test_create_repo clone1 &&
+		test_create_repo clone2 &&
+		test_create_repo clone3 &&
+
+		git remote add remote1 "file://$(pwd)/clone1" &&
+		git remote add remote2 "file://$(pwd)/clone2" &&
+		git remote add remote3 "file://$(pwd)/clone3" &&
+
+		git config remote.remote1.prefetch false &&
+		git config remote.remote2.prefetch true &&
+		# remote3 is left unset
+
+		# Make changes in all clones
+		git -C clone1 switch -c one &&
+		git -C clone2 switch -c two &&
+		git -C clone3 switch -c three &&
+		test_commit -C clone1 one &&
+		test_commit -C clone2 two &&
+		test_commit -C clone3 three &&
+
+		# Run maintenance prefetch task
+		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
+
+		# Check that remote1 was not fetched (prefetch=false)
+		test_subcommand ! git fetch remote1 --prefetch --prune --no-tags \
+			--no-write-fetch-head --recurse-submodules=no --quiet \
+			<prefetch.txt &&
+
+		# Check that remote2 was fetched (prefetch=true)
+		test_subcommand git fetch remote2 --prefetch --prune --no-tags \
+			--no-write-fetch-head --recurse-submodules=no --quiet \
+			<prefetch.txt &&
+
+		# Check that remote3 was fetched (prefetch unset, default to true)
+		test_subcommand git fetch remote3 --prefetch --prune --no-tags \
+			--no-write-fetch-head --recurse-submodules=no --quiet \
+			<prefetch.txt &&
+
+		# Verify that changes are in the prefetch refs for remote2 and remote3, but not remote1
+		test_must_fail git rev-parse refs/prefetch/remotes/remote1/one &&
+		git fetch --all &&
+		test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
+		test_cmp_rev refs/remotes/remote3/three refs/prefetch/remotes/remote3/three
+	)
+'
+
 test_expect_success 'loose-objects task' '
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
