Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636C1B3F2C
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875240; cv=none; b=uToU2S9KfTAXDxLOMprLdqYS5/TIczwUzVBrC6CrYWWha7+sjkLFPdv9eBpFJULuANrn0Jt+l9++kpmltVshTBjc6rAUCNra7zlx/yPaC0MlvQPNLm5z0mNJo/EQckpGv0tGS2hcPanEJTZ3j/+FoaroC1g7poRXzxzsfk+/m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875240; c=relaxed/simple;
	bh=sC1qPnnKQeOQYDrXbAXx6gVzRGpv8AwcwFtbxbl4Dhk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FLAZUiu8lBoGLuKYx14Hx+DWbTBrI+pl+C2KhG4t3Ayr1GvLBEixyZblxX4rfM8yPJ9dYzMxzvc71TVr4cEZ+UMkBG9O3Iqg/ORDLwopINSX53gbEu8xZ/T10LWqwK2a7W/XvufLWhIzOKN60bgtU8tavq0dfUeYY5VzfywYHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtH6GTAd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtH6GTAd"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f74e613a10so23318051fa.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725875235; x=1726480035; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pu04koAuRpnnmdGifFUwofIVXdbsrH8yWtP+GJCnQ24=;
        b=ZtH6GTAdlF38CekBGerQWo2KvHe05nlTw9Rqdj3CsPONmUXaNSoUucahURXk+vPHmZ
         jUYetUor01B6NNHBKVSxLpzZgu01UCqjUQUgns1YCQ4dB4SUFgfUqJUKeiq0rfltX8da
         pBXtt5e5qzishi018KKA1ibCemWpntrBduYT76EDemm+9frcEMgfevBvhChyDn7yubrN
         HVRK295vtxhhrwqmZPZZiyqUALyhyasuXfGUfJ/LBXfMP/NDgBL6vGdlWnRGDs7NABLl
         f2rt4MH5mGSp2D+eUITAOy6JvUo7kZBmiax498WK1nwxxXoLBTEUwo2DD4yS1hxEQeW9
         n5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875235; x=1726480035;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu04koAuRpnnmdGifFUwofIVXdbsrH8yWtP+GJCnQ24=;
        b=eRWf5d7PxtLJjXLmxn9yIrW/OU81y3nxOS6PYDaNnoWmSIFiF5dN9Y/+jrI0lRZmAT
         UT9yGHBAzrcVB4pWwdtKWcUcsHfVCtNkxI/7OQkBm8l+hbdUvmycfqDlTfmbwCJpwDHt
         18oU8GdbPIGuXnhsCimNMiJ83Ve/9oOVjp0UlGY47KozOh8nB42pKXuOfqhv11RIQBm1
         og8UIuntN5vOFMz9kFvRf1YIa/PdRvGoh0DZ9O3k0C+0+n+lnWh1JFXl1X/Mjxiyq/S1
         EF++v9mvASulbHkqxakY0EKqB9zYhQLky9uf7KUaAwGwef7Ky7Mf7q2tLofSjKoW7XTv
         EpcA==
X-Gm-Message-State: AOJu0YyP45VDR2WVFSGWlrVbWteFmUGSO70i3KJZ7bpEyACB7y4XHGwe
	RAzTxNUmVBIfSOLxExQf+R+A43zE50Ve5ySOe/+cDhEfx5w3wHTmvua0PQ==
X-Google-Smtp-Source: AGHT+IErfYvpj8Nsv9+yrq3lSSKBRhiAMySF+1z8nB1kLfIxi/0jnigP218etsIk3aF1Ggx3lGwdyw==
X-Received: by 2002:a2e:be08:0:b0:2ef:28ed:1ff2 with SMTP id 38308e7fff4ca-2f75a96d9ffmr70067801fa.9.1725875234395;
        Mon, 09 Sep 2024 02:47:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2539bsm316461866b.85.2024.09.09.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:47:13 -0700 (PDT)
Message-Id: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 09:47:12 +0000
Subject: [PATCH] remote: introduce config to set prefetch refs
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
    "Derrick Stolee [ ]" <stolee@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

This commit introduces a new configuration option,
remote.<name>.prefetchref, which allows users to specify specific
ref patterns to be prefetched during a git fetch --prefetch
operation.

The new option accepts a space-separated list of ref patterns.
When the --prefetch option is used with git fetch, only the refs
matching these patterns will be prefetched, instead of the
default behavior of prefetching all fetchable refs.

Example usage in .git/config:
[remote "origin"]
    prefetchref = "refs/heads/main refs/heads/feature/*"

This change allows users to optimize their prefetch operations, potentially
reducing network traffic and improving performance for large repositories
with many refs.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    remote: introduce config to set prefetch refs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1782%2Fpastelsky%2Fsk%2Fremote-prefetchref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1782/pastelsky/sk/remote-prefetchref-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1782

 Documentation/config/remote.txt |  6 +++
 builtin/fetch.c                 | 29 +++++++++++++-
 remote.c                        |  8 ++++
 remote.h                        |  3 ++
 t/t7900-maintenance.sh          | 70 +++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 8efc53e836d..b25d76dd3b1 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -33,6 +33,12 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.prefetchref::
+    Specify the refs to be prefetched when fetching from this remote.
+    The value is a space-separated list of ref patterns (e.g., "refs/heads/master refs/heads/develop*").
+    These patterns are used as the source part of the refspecs for prefetching.
+    This can be used to optimize fetch operations by specifying exactly which refs should be prefetched.
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2b5aee5bf2..6e584fa2ebb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -434,6 +434,30 @@ static void find_non_local_tags(const struct ref *refs,
 	oidset_clear(&fetch_oids);
 }
 
+static void apply_prefetch_refspec(struct remote *remote, struct refspec *rs)
+{
+	if (remote->prefetch_refs.nr > 0) {
+		int i;
+		for (i = 0; i < remote->prefetch_refs.nr; i++) {
+			const char *src = remote->prefetch_refs.items[i].string;
+			struct strbuf dst = STRBUF_INIT;
+
+			strbuf_addf(&dst, "refs/prefetch/%s/", remote->name);
+			if (starts_with(src, "refs/heads/")) {
+				strbuf_addstr(&dst, src + 11);
+			} else if (starts_with(src, "refs/")) {
+				strbuf_addstr(&dst, src + 5);
+			} else {
+				strbuf_addstr(&dst, src);
+			}
+
+			refspec_appendf(rs, "%s:%s", src, dst.buf);
+			strbuf_release(&dst);
+		}
+	}
+}
+
+
 static void filter_prefetch_refspec(struct refspec *rs)
 {
 	int i;
@@ -502,8 +526,11 @@ static struct ref *get_ref_map(struct remote *remote,
 	int existing_refs_populated = 0;
 
 	filter_prefetch_refspec(rs);
-	if (remote)
+	if (remote) {
 		filter_prefetch_refspec(&remote->fetch);
+		if (prefetch)
+			apply_prefetch_refspec(remote, rs);
+	}
 
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
diff --git a/remote.c b/remote.c
index 8f3dee13186..b46d62b2c47 100644
--- a/remote.c
+++ b/remote.c
@@ -141,6 +141,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
+	string_list_init_dup(&ret->prefetch_refs);
 	refspec_init(&ret->push, REFSPEC_PUSH);
 	refspec_init(&ret->fetch, REFSPEC_FETCH);
 
@@ -166,6 +167,7 @@ static void remote_clear(struct remote *remote)
 	free((char *)remote->uploadpack);
 	FREE_AND_NULL(remote->http_proxy);
 	FREE_AND_NULL(remote->http_proxy_authmethod);
+	string_list_clear(&remote->prefetch_refs, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -456,6 +458,12 @@ static int handle_config(const char *key, const char *value,
 		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prefetchref")) {
+		if (!value)
+			return config_error_nonbool(key);
+		string_list_split(&remote->prefetch_refs, value, ' ', -1);
+		return 0;
+	}
 	else if (!strcmp(subkey, "url")) {
 		if (!value)
 			return config_error_nonbool(key);
diff --git a/remote.h b/remote.h
index b901b56746d..c18e68e0d8d 100644
--- a/remote.h
+++ b/remote.h
@@ -5,6 +5,7 @@
 #include "hashmap.h"
 #include "refspec.h"
 #include "strvec.h"
+#include "string-list.h"
 
 struct option;
 struct transport_ls_refs_options;
@@ -77,6 +78,8 @@ struct remote {
 
 	struct refspec fetch;
 
+	struct string_list prefetch_refs;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index abae7a97546..2ad5b922d83 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -245,6 +245,76 @@ test_expect_success 'prefetch multiple remotes' '
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
 '
 
+test_expect_success 'prefetch only acts on remote.<name>.prefetchref refs if present' '
+	test_create_repo prefetch-test-mixed-patterns &&
+	(
+		cd prefetch-test-mixed-patterns &&
+		test_commit initial &&
+		git clone . clone1 &&
+		git clone . clone2 &&
+
+		git remote add remote1 "file://$(pwd)/clone1" &&
+		git remote add remote2 "file://$(pwd)/clone2" &&
+
+		# Set single prefetchref pattern for remote1 and multiple for remote2
+		git config remote.remote1.prefetchref "refs/heads/foo" &&
+		git config remote.remote2.prefetchref "refs/heads/feature/* refs/heads/topic" &&
+
+		# Create branches in clone1 and push
+		(
+			cd clone1 &&
+			git checkout -b foo &&
+			test_commit foo-commit &&
+			git checkout -b feature/a &&
+			test_commit feature-a-commit &&
+			git checkout -b other &&
+			test_commit other-commit &&
+			git push origin foo feature/a other
+		) &&
+
+		# Create branches in clone2 and push
+		(
+			cd clone2 &&
+			git checkout -b topic &&
+			test_commit master-commit &&
+			git checkout -b feature/x &&
+			test_commit feature-x-commit &&
+			git checkout -b feature/y &&
+			test_commit feature-y-commit &&
+			git checkout -b dev &&
+			test_commit dev-commit &&
+			git push origin topic feature/x feature/y dev
+		) &&
+
+		# Run maintenance prefetch task
+		GIT_TRACE2_EVENT="$(pwd)/prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
+
+		# Check that only specified refs were prefetched
+		fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+		test_subcommand git fetch remote1 $fetchargs <prefetch.txt &&
+		test_subcommand git fetch remote2 $fetchargs <prefetch.txt &&
+		ls -R .git/refs/prefetch &&
+
+		# Verify that only specified refs are in the prefetch refs for remote1
+		 git rev-parse refs/prefetch/remotes/remote1/foo &&
+		test_must_fail git rev-parse refs/prefetch/remotes/remote1/feature/a &&
+		test_must_fail git rev-parse refs/prefetch/remotes/remote1/other &&
+
+				# Verify that only specified refs are in the prefetch refs for remote2
+		git rev-parse refs/prefetch/remotes/remote2/feature/x &&
+		git rev-parse refs/prefetch/remotes/remote2/feature/y &&
+		git rev-parse refs/prefetch/remotes/remote2/topic &&
+		test_must_fail git rev-parse refs/prefetch/remotes/remote2/dev &&
+
+		# Fetch all refs and compare
+		git fetch --all &&
+		test_cmp_rev refs/remotes/remote1/foo refs/prefetch/remotes/remote1/foo &&
+		test_cmp_rev refs/remotes/remote2/feature/x refs/prefetch/remotes/remote2/feature/x &&
+		test_cmp_rev refs/remotes/remote2/feature/y refs/prefetch/remotes/remote2/feature/y &&
+		test_cmp_rev refs/remotes/remote2/topic refs/prefetch/remotes/remote2/topic
+	)
+'
+
 test_expect_success 'loose-objects task' '
 	# Repack everything so we know the state of the object dir
 	git repack -adk &&

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
