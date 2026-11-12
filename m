Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484990;
	b=w/Mai+YB4Wq3UtKKfxWYBfDxhI94w4OjDOEzfJ5cl2AqNz6Xoh1guE8jzkeRjfhmr+zc
	 eB1ur6Pl0KrEGE0ebeYZq5V3WSgZY2e6g2gn2uOWkfRt9YF99gt+tANJW2sQ+HvXbxh6J
	 tfp1cMLADsmDQWsS8Bx30C6s6A309vXA8gFP0sz/dygFMIsXn3EtoKT+VDwY5w863/LrS
	 wifeyxwIihUAE1RWN6L5YcE7ymQrwl51ux6aelOzWE/fdsE+RZmRjCWyGpEZSHW/gkIeu
	 C0bBZar4lEyRVJrorAqrAwvpv5r3o0Et4kpxfEiV4WC0oH4FjHvxPr/eK3JTLvQUKtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=an2VDnhMeFo3iUyXlEb+jFFzn/850iC+7Ipyrgv8IQI=;
	b=oY9RNnyAkCPJagemBh2o+jhMa6zvgWYDy6NLcBOU97GPh9R4EaUPGrR96otRQqSbvUT3
	 uubC72C4262Wfp/CNGlYxhXC0MyGWiUdEi2eWt/AnKR6JJdgce4I+sthtgLNBD4y4b11c
	 yJuCQl7Z2d9podllczObm+vOIODHUKB8zl7aSlvf2UjeRE1LPXM44y3iyZVAY4Vs61uvk
	 J06shvZ+Hpy5DAJ4na7kwWnBQKeBJejprGZYSasOf35EFzrgFnZhVseyGO3VyjYhNsZvu
	 uNXRfDOUY3prDwQmJ8WICHlPTSN4s+1lEus+uVitsMmYODRZOH4Zj82nokKgZLN4KlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuDLIZNL;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D6E606A8A1
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 12:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64D6E606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuDLIZNL
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67be1e468a8so3375132d50.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 04:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484989; x=1795089789; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=an2VDnhMeFo3iUyXlEb+jFFzn/850iC+7Ipyrgv8IQI=;
        b=uuDLIZNL4gHYj0jNNX9uTb9Hf6zI88KwBNQkSJWMWKoOz9EIORSz93ZZMKbl9+h31q
         KNWX8+KLsXyus/wj7Nq43P1zuKuedW8EMdqvTYF6wQKIBoKbGmYw9NLY+G1HVguo8mh5
         Q9C3iOk3Hq89d1JzMEEq1Ng28CMbOk98GLXQOfxUP9aIMzdC7TCan8l7n8m5yeCrBjuq
         r1i4Tu7Ijs026GMD4LONMokyolgnT1Gvu80lLF7+3ZjGlrAhMVjxs0w3rQt1BfkMizAz
         NYx1p2gNbksicITfmvzB6JROHfTV7NZlwNgLA+f56Xt6HzVp3P+OVBvYyR5Tit6m25VQ
         kFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484989; x=1795089789;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=an2VDnhMeFo3iUyXlEb+jFFzn/850iC+7Ipyrgv8IQI=;
        b=T9yS+bD3RxxE6XKdk2BmdLixufWDgT4GTEtSV3QREeON7zOkYo7j9qadO9bRbl0RNA
         /4ffyxEDAF+D4e9ZucgY2BzREH6STZn69aAfnsBP4n1qzuj5r2J1H/Wjde8mjuOCd/Od
         2E51RzIi44OrvBes5ZhWPOYfYxvclGgL2lyMpXA4Lhojsz3c/cBMjExrZsL+yhXbYZRa
         gt8iu5w3JohBuE+g9QBNSTlERRZHQ3snw3RHNzoHURKd/5aXhjlttv5nEg4OKs343uy8
         J7ON10vC6h75EVp9QGA074g9hcvNTPN1lcSxAf0KKtM0H48PAzFgk67iDxgfeeXi7Bs5
         LeMg==
X-Gm-Message-State: APuU4Z+a9cMHQ7hCPXywR+99igN2t9+my+6+uwTdRIsFk8UsSURWbDwe
	LXtXv5OCw/r6QCKnfbWQxI2pqrvCVp5p7T2ZFUBs5ZtmpLj/N4C8OUOi7de2Ww3o
X-Gm-Gg: AYBFou3EPmsd58WzIWa2BCvxhDgA1Ff18Dd8KD5+pAmEoC7sHyMm0s6e3jnbZLbTt4S
	vW3pULmQRVW7i+e+VXqeIkSbiyDnuQt+md5UnyVqZTPxjwFGyvvUmczB5IIDwUjzYjUOGIGszVj
	+SZoijqrhPerLke+qUzUZ2s4AWs8sKuAIXWcKs4Z4Lkq06TnCQqLjtCIA2lRb6zy8Dj8rKsxJ5t
	ZjuA/Y+oOBedmQtYDH46pzLFA9/D6NBy6hZUzCmk8b8urWf4qCwlKJTb6EMAn7D0F1yAWQNBKKC
	L8Z6j3sAGhaL+vnFtrucFeRw8zfWbeYgt3oIMZtUKH9dhYLkL8pmIapsDxF5T388bLHmsiFKmN0
	DCjIQ9IYF5+wTxsjK5yyEy7RRB8Z1UwLznSkhKfL0psaGEls/+PDVUHkxQAbTXl9HoYAx2Zfdo2
	QkPXQ8pWAHaBtdO/0X+SgasV9KEeOfnJBYzrHwEr4rPmttvsy35qeLZhELuksAgRTLG4cmUbQ/I
	J850JKZMhE2ZnOYSkUtTlsdMjLqHZNqKuQ6KWaXWkcBfMit3HMCcmmssbLilUII+GmQ7pJ/f3M7
	6gvU4avIw4qE4IVBYr9wpnBfAuuc8Kax+BS81h7tvCr19dIdvzx5U8Xq9g==
X-Received: by 2002:a05:690e:1385:b0:67c:c1d:e5ff with SMTP id 956f58d0204a3-67c67a44ec8mr4372134d50.0.1794484989330;
        Thu, 12 Nov 2026 04:03:09 -0800 (PST)
Received: from [127.0.0.1] ([172.206.245.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02fcc4b7sm44919346d6.44.2026.11.12.04.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:03:08 -0800 (PST)
Message-Id: <f9adc6c85c4b098a0df8cf18783d1969a68fc048.1794484985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Nov 2026 12:03:03 +0000
Subject: [PATCH 1/3] submodule: make submodule.<name>.gitdir relative for
 worktrees
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

For a linked worktree, always keep `submodule.<name>.gitdir` relative
to ensure it continues to work when the worktree is moved along with
the main worktree. (This benefit also requires
worktree.useRelativePaths to be set to true.)

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/submodule--helper.c                | 68 +++++++++++++---------
 t/t7425-submodule-gitdir-path-extension.sh | 19 ++++++
 2 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 461b682d0d..56d7720e93 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -37,6 +37,7 @@
 #include "wildmatch.h"
 #include "strbuf.h"
 #include "url.h"
+#include "worktree.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -507,50 +508,60 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 
 static void create_default_gitdir_config(const char *submodule_name)
 {
+	struct worktree *wt = get_current_worktree(the_repository);
+	const char *modules_dir;
+	struct strbuf tmp = STRBUF_INIT;
 	struct strbuf gitdir_path = STRBUF_INIT;
 	struct git_hash_ctx ctx;
 	char hex_name_hash[GIT_MAX_HEXSZ + 1], header[128];
 	unsigned char raw_name_hash[GIT_MAX_RAWSZ];
 	int header_len;
 
-	/* Case 1: try the plain module name */
-	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
-	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
-		strbuf_release(&gitdir_path);
-		return;
+	modules_dir = worktree_git_path(wt, "modules/");
+	if (is_absolute_path(modules_dir)) {
+		modules_dir = relative_path(modules_dir, wt->path, &tmp);
 	}
 
+	/* Case 1: try the plain module name */
+	strbuf_addstr(&gitdir_path, modules_dir);
+	strbuf_addstr(&gitdir_path, submodule_name);
+	if (!validate_and_set_submodule_gitdir(&gitdir_path,
+					       submodule_name))
+		goto cleanup;
+
 	/* Case 2.1: Try URI-safe (RFC3986) encoding first, this fixes nested gitdirs */
 	strbuf_reset(&gitdir_path);
-	repo_git_path_append(the_repository, &gitdir_path, "modules/");
+	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
-	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
-		strbuf_release(&gitdir_path);
-		return;
-	}
+	if (!validate_and_set_submodule_gitdir(&gitdir_path,
+					       submodule_name))
+		goto cleanup;
 
 	/* Case 2.2: Try extended uppercase URI (RFC3986) encoding, to fix case-folding */
 	strbuf_reset(&gitdir_path);
-	repo_git_path_append(the_repository, &gitdir_path, "modules/");
+	strbuf_addstr(&gitdir_path, modules_dir);
 	strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
-	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
-		return;
+	if (!validate_and_set_submodule_gitdir(&gitdir_path,
+					       submodule_name))
+		goto cleanup;
 
 	/* Case 2.3: Try some derived gitdir names, see if one sticks */
 	for (char c = '0'; c <= '9'; c++) {
 		strbuf_reset(&gitdir_path);
-		repo_git_path_append(the_repository, &gitdir_path, "modules/");
+		strbuf_addstr(&gitdir_path, modules_dir);
 		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_rfc3986_unreserved);
 		strbuf_addch(&gitdir_path, c);
-		if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
-			return;
+		if (!validate_and_set_submodule_gitdir(&gitdir_path,
+						       submodule_name))
+			goto cleanup;
 
 		strbuf_reset(&gitdir_path);
-		repo_git_path_append(the_repository, &gitdir_path, "modules/");
+		strbuf_addstr(&gitdir_path, modules_dir);
 		strbuf_addstr_urlencode(&gitdir_path, submodule_name, is_casefolding_rfc3986_unreserved);
 		strbuf_addch(&gitdir_path, c);
-		if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name))
-			return;
+		if (!validate_and_set_submodule_gitdir(&gitdir_path,
+						       submodule_name))
+			goto cleanup;
 	}
 
 	/* Case 2.4: If all the above failed, try a hash of the name as a last resort */
@@ -563,17 +574,22 @@ static void create_default_gitdir_config(const char *submodule_name)
 	git_hash_final(raw_name_hash, &ctx);
 	hash_to_hex_algop_r(hex_name_hash, raw_name_hash, the_hash_algo);
 	strbuf_reset(&gitdir_path);
-	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", hex_name_hash);
-	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
-		strbuf_release(&gitdir_path);
-		return;
-	}
+	strbuf_addstr(&gitdir_path, modules_dir);
+	strbuf_addstr(&gitdir_path, hex_name_hash);
+	if (!validate_and_set_submodule_gitdir(&gitdir_path,
+					       submodule_name))
+		goto cleanup;
 
 	/* Case 3: nothing worked, error out */
 	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
 	      "Please ensure it is set, for example by running something like: "
-	      "'git config submodule.%s.gitdir .git/modules/%s'"),
-	    submodule_name, submodule_name, submodule_name);
+	      "'git config submodule.%s.gitdir %s%s'"),
+	    submodule_name, submodule_name, modules_dir, submodule_name);
+
+cleanup:
+	strbuf_release(&gitdir_path);
+	strbuf_release(&tmp);
+	free_worktree(wt);
 }
 
 static void init_submodule(const char *path, const char *prefix,
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index ea86ecf7ee..02123b8468 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -279,6 +279,25 @@ test_expect_success '`git clone --recurse-submodules` respects init.defaultSubmo
 	)
 '
 
+test_expect_success 'git submodule init make gitdir relative' '
+	test_when_finished "rm -rf repo-clone-init-wt" &&
+	git clone upstream repo-clone-init-wt &&
+	(
+		cd repo-clone-init-wt &&
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submodulePathConfig true &&
+		git worktree add wt &&
+		cd wt &&
+		git submodule init &&
+		git config submodule.sub1.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub1" >expect &&
+		test_cmp expect actual &&
+		git config submodule.sub2.gitdir >actual &&
+		echo "../.git/worktrees/wt/modules/sub2" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'submodule--helper migrates legacy modules' '
 	(
 		cd upstream &&
-- 
gitgitgadget

