Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8518E772
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565405; cv=none; b=iAoy1pfM9fSbIpeRr6lLXyN0VARz0odx/i6Vsjcve2i0eoWqZL71MiVPzrtqMPKjT4j9H4TehjUNHwl4NaloBXRAT0JUCCgio2VgH2wy8eyBb9N3Gu1uQvxOGzRl2sGN0Ogg3AobPiCvwVI2dfrTEFluYixj1h1a7zdD9PfMvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565405; c=relaxed/simple;
	bh=5iN0C0PQciYq5bRpATCtlTMutwp1aruukDtTWQPm8YY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V6BFKOq2UW43kJ9KnaQn//g2AP5Y7Z6LB78slw0Xg8HW+nd3OJE+ehSEtREAEHs2lQrKI4KA4yVIdWy4NFX9ybIj+I/hrbDD1Z04qN2VAth7hhybILlJgUU3knBxBc9amvZbkRyL3QxFvDzMYtIWxqNvzIAxIdjLmjAJ3/2J2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTE675Hc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTE675Hc"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so3551526a12.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725565401; x=1726170201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNQikHffZzEZ6loyKEtwww+29utEElwuVH3we1UMBXI=;
        b=BTE675Hch5TGIP7TRFWwn6rLIyXqa4vUpbkG0Ndng7tgl9xlBjefeGZvg2SPY8gyvH
         Ta/0G6e4gh4uqAb8oLPIc1RgOs1+drju7d0V863HP3efUXBugKWFxeZNcmH+4LTwnOCV
         X4M66jDzLoMXn+q6pPEDywZ3TwaHHZ/rLKp9ySneibsLWbPGETBCC2TV6bubkQPcu8lb
         KtHQO903G3NY/ZuXar1pe2aN9aUGvsikaUXnKy86Huh3fBgLtRYFEzcD+C33VvyRR/6H
         37qZPycsyokR7Y6AGSRfgx485PnP5YX1+NkVnqLIwIijP9GywubEm9KEzcXx5mwN4e4A
         bdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725565401; x=1726170201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNQikHffZzEZ6loyKEtwww+29utEElwuVH3we1UMBXI=;
        b=bl/s0IxfMM6P5Yp9NeUksAHG+Om6rF72QxBCiAkIsIxRLHA2YHc4zAmQL4//Jpx6w0
         OvWNs/aq8JQBoS2EZM7nS8CYvKG8ql7VKOziNpD3WDqR3B+qYvzDAHxKiwW5pYvw41/y
         AN0i3wLIvF++LvIr2XkMGIPRGh+7KsaQvMdWnpZWAGR3QrEs1iTLYqhw8uMjqbHtM4Uv
         S/F3qO+AG2QOxhxUaXb2W6+E5vkeg53Po0IVhSLAqTIOd/HODCjhXbSS7yS2QrJR8ygt
         oC1dDBXkI8rtACuJced8sQVMNfa02R9ywL6hgGEYfP6fUr9mz5Ep9ifqi+61hW0EgRi8
         hrHA==
X-Gm-Message-State: AOJu0YxJ77OH+1tY7ML3s5JiMj7TPYzE/NwKIyNUVRg6nbh51g+QePLB
	+wB9SpbZ27gllqDq3tDe67D0zSiZ0ilGgdQsMTm2jcfi0do+cHKse3GmpA==
X-Google-Smtp-Source: AGHT+IHJSjFw7UxX/GtXWAt/twYqcwayAcoWdZ/fST19kG5yeua2zawnfeKy3sZZF8ViyRArGc0WGg==
X-Received: by 2002:a05:6402:4014:b0:5c2:6e51:9d1a with SMTP id 4fb4d7f45d1cf-5c3c1f9cbbdmr7465210a12.14.1725565400512;
        Thu, 05 Sep 2024 12:43:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc52924csm1581118a12.19.2024.09.05.12.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:43:19 -0700 (PDT)
Message-Id: <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com>
In-Reply-To: <pull.1779.v3.git.1725554758463.gitgitgadget@gmail.com>
References: <pull.1779.v3.git.1725554758463.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 19:43:18 +0000
Subject: [PATCH v4] remote: prefetch config
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
    Derrick Stolee <stolee@gmail.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1779%2Fpastelsky%2Fsk%2Fmaintenance-prefetch-remote-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1779/pastelsky/sk/maintenance-prefetch-remote-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1779

Range-diff vs v3:

 1:  c348f8efd33 ! 1:  80af121f835 remote: prefetch config
     @@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
       	if (remote->skip_default_update)
       		return 0;
       
     -+	if (!remote->prefetch)
     ++	if (!remote->prefetch_enabled)
      +		return 0;
      +
       	child.git_cmd = 1;
     @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
       	CALLOC_ARRAY(ret, 1);
       	ret->prune = -1;  /* unspecified */
       	ret->prune_tags = -1;  /* unspecified */
     -+	ret->prefetch = 1;
     ++	ret->prefetch_enabled = 1;
       	ret->name = xstrndup(name, len);
       	refspec_init(&ret->push, REFSPEC_PUSH);
       	refspec_init(&ret->fetch, REFSPEC_FETCH);
     @@ remote.c: static int handle_config(const char *key, const char *value,
       	else if (!strcmp(subkey, "prunetags"))
       		remote->prune_tags = git_config_bool(key, value);
      +	else if (!strcmp(subkey, "prefetch"))
     -+		remote->prefetch = git_config_bool(key, value);
     ++		remote->prefetch_enabled = git_config_bool(key, value);
       	else if (!strcmp(subkey, "url")) {
       		if (!value)
       			return config_error_nonbool(key);
     @@ remote.h: struct remote {
       
       	struct refspec fetch;
       
     -+	int prefetch;
     ++	int prefetch_enabled;
      +
       	/*
       	 * The setting for whether to fetch tags (as a separate rule from the


 Documentation/config/remote.txt   |  5 ++++
 Documentation/git-maintenance.txt |  7 +++---
 builtin/gc.c                      |  3 +++
 remote.c                          |  3 +++
 remote.h                          |  2 ++
 t/t7900-maintenance.sh            | 42 +++++++++++++++++++++++++++++++
 6 files changed, 59 insertions(+), 3 deletions(-)

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
index 427faf1cfe1..8da78290929 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1027,6 +1027,9 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	if (remote->skip_default_update)
 		return 0;
 
+	if (!remote->prefetch_enabled)
+		return 0;
+
 	child.git_cmd = 1;
 	strvec_pushl(&child.args, "fetch", remote->name,
 		     "--prefetch", "--prune", "--no-tags",
diff --git a/remote.c b/remote.c
index 8f3dee13186..fc6eee21408 100644
--- a/remote.c
+++ b/remote.c
@@ -140,6 +140,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	CALLOC_ARRAY(ret, 1);
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
+	ret->prefetch_enabled = 1;
 	ret->name = xstrndup(name, len);
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
@@ -456,6 +457,8 @@ static int handle_config(const char *key, const char *value,
 		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prefetch"))
+		remote->prefetch_enabled = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
 		if (!value)
 			return config_error_nonbool(key);
diff --git a/remote.h b/remote.h
index b901b56746d..c448e5e6f9d 100644
--- a/remote.h
+++ b/remote.h
@@ -77,6 +77,8 @@ struct remote {
 
 	struct refspec fetch;
 
+	int prefetch_enabled;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..7484e1f1d46 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -245,6 +245,48 @@ test_expect_success 'prefetch multiple remotes' '
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
+		# Check that if remotes were prefetched properly
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+		test_subcommand ! git fetch remote1 $fetchargs <prefetch.txt &&
+		test_subcommand git fetch remote2 $fetchargs <prefetch.txt &&
+		test_subcommand git fetch remote3 $fetchargs <prefetch.txt &&
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
