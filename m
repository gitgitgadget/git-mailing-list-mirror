Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273860;
	b=3h3khAy+I3U8t6OhGZ4xJGisqEG6zgROuGw4y3i+nzJU69GhtgolKXthvzDQOVLA8rIO
	 8PY7VNsyW9b1q4oi4uhN32LBv9Y5E/7W24Fl1ckMqHNDTaMXvyaV6EQ9KGB4THgxm0ER9
	 N5dBVEvNdkbLL47TwUVyav6xQnkLhwyWd+3kqcUg1XC1OgVeJNEW7Gmspfl5spOVDgFKr
	 k7hGRKZKYEq4hsy//ZpGYq1FeONH0tdkHd8IJU71AzKrZ+yINDUey1UrioW4aTTtCbEiW
	 WVOQ4CnH8awVAjbCuAsTrgf2qxpWKDzYKsY8RXywf41bIHE7bzhURjLVWEFdl683UPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Pwf63wfINFE28PMqoZJheA5eOJmjAxg+1OB2OypN4xE=;
	b=vVrFP42YEj3wG/XyFlVe5ox/OJFBunt6jzfQ+caAKQnvTuH8q9gyseHa5lst4qb64K7b
	 WEHGgYG/AP2gkNplCoxFkKRG7M8/v1t3hHVxNGn+SYlxXZEK2xOTMrMk+E1NJ+h+y9OIY
	 EVnG9pd94uPNBsCaZ2bWwGAi2UZYtRmICi4teorq+4cy2RffGUc7vvkTeoLqGUtgHTSPg
	 GqhHWkLySwp9r8jiScU8lPGBb+QDrH7scULov2uCJZ46O9acPkR6OCBZov0bBBPJL/a8d
	 Ne7mUNuWxnPi1bcHfYJSxEgaGmTixvU+sEeiooTBasFjBzOrThdOZmGlzcbKf7K9fOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lU2OGIiV;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65069606A32A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65069606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lU2OGIiV
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-53dda625f63so1220773b6e.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795273859; x=1795878659; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pwf63wfINFE28PMqoZJheA5eOJmjAxg+1OB2OypN4xE=;
        b=lU2OGIiV6FBJSDjFaCoSeLnu3pHU3lXhsr00Tfkhmr069HTUGFjzTfI3+qg1bPO/c9
         /YnoPpwTh6HG7FohdtmM9ogJzmAu4brqg7V27XKQq/Dzy1eQa+mID/LTWHMrzsTnQrAm
         sX+QPpF028zGCHai73h4MRSSsK5QTTEyByKtqGCCPAqPxtuRse3sjhRjfzfsgAc9mDwE
         kVY9qdFM0Q22bm0Do6eDYU11EVcOnGdWPI6mMhP/03CiADpQusM70Z/huhgJWSJaJ8rL
         cGuWaTEAqO0vdr7wiPRwAEQfXL6ZXmoDl6VzRQUnHeBbGuJpsy10qGflbLW9xFJIc+7K
         yYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795273859; x=1795878659;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pwf63wfINFE28PMqoZJheA5eOJmjAxg+1OB2OypN4xE=;
        b=JySl+/u8WB8wEz5D3PYdF0ys/8+PrLvAJZkG+XC/KO5gNPuxfQv8m/LH0zbUC3vLxR
         MTXK3a8KXCzwvrqNZlK8bUjaAKqsCjzin3nEW+3YQtNZAm8jeb879P4hMfIriit2kslK
         ux5zoqCl1TOCnB3DyYm1suZi0CN6A1KgG/zvn26pSqmX5pnCxHDAnxC0v+t27SG9jKpn
         gHLGhZdMon6zf3p4K4/F2l8kL1CNrkT54vH9VS+y+1UDImyX0uktAEpl9JmjXwhZWJ3t
         /kOLVdYwMgl78ZPPKiaeCCEB2tyEFFdPraeX/iCmxdGNFeT6v7Q64gVABEzZvrUBApB0
         +YlA==
X-Gm-Message-State: APuU4Z/Xl+nM2YN25+mqxZUkSngV0EfBJTuuFUtE/8FPZ1YNSiKL/NPM
	ZXvYjWo9EcCR8SFhSl3Fl/M0KJqbUwtPi8LphC+kTggqEOzUCE89ue/BQUNJiMhg
X-Gm-Gg: AZFdTZev/k/qXoUWiijf4rctTEWi84t+HkskQooO/zOfS2f+XK6tsstdPFgkxTrCk/w
	EaFMxyIbpLE5qKm4T0KVvIUmIaf/h/Cia/UVye7TN2g/5lN8XI/KgRiCYo8VVeTdSrB6wU+6pGD
	M3Y2L66dE/CR+KIXUkQYTRrSFcBEgZ+5fQMxCLrRWCFa+3qsGDen1fqP6szvYxliDWBMGKumNjz
	kyh458ojMkem82ThseBJKMGGGM4LuaNw8p7BZr5CwCmB2MVHp+ooKw16OujwMhjMhkTGRzm0Scn
	U04RjeAi0AwMUFY0McmRKk4jGRMiAuV3iad+b82mx4bdAsdAdwVzalkSJl+pWBAHKIxb4qL0DdB
	807KMJ8dsMoS/L81nT3BL4zq2GwDYUKggTa8a8o9C5cATYSBGaq9h7/wbwaxLX6JH+QtbxKiqNN
	Krc8wvUTNDaKuLP4c15SBEI57qIMRpDP3uUkdtzJUqGBsVfcN9AdtK7rqV/6DWIv5/aGtB+69PT
	uGbuKhAfKq35HyLf322YxI87P9rK45cjXGMqtdJaQlgZuXquAYQRHRvKLjQHCahL+mCJbAr7gCO
	48jO7ZBs509v0sm2lW6poQyFU2j8CAY=
X-Received: by 2002:a05:6808:4fde:b0:551:a229:c8a2 with SMTP id 5614622812f47-57a0ac26fc3mr7513511b6e.64.1795273859211;
        Sat, 21 Nov 2026 07:10:59 -0800 (PST)
Received: from [127.0.0.1] ([9.234.15.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35c5ac5dsm4937699b6e.15.2026.11.21.07.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 07:10:57 -0800 (PST)
Message-Id: <435ca42ec99d0eed613621186306cb68def30e6c.1795273853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
	<pull.2306.v2.git.1795273853.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 15:10:51 +0000
Subject: [PATCH v2 1/3] submodule: make submodule.<name>.gitdir relative for
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
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

For a linked worktree, always keep `submodule.<name>.gitdir` relative
to ensure it continues to work when the worktree is moved along with
the main worktree. (This benefit also requires
worktree.useRelativePaths to be set to true.)

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/submodule--helper.c                | 71 ++++++++++++++--------
 t/t7425-submodule-gitdir-path-extension.sh | 19 ++++++
 2 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 461b682d0d..c3b3a2865f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -37,6 +37,7 @@
 #include "wildmatch.h"
 #include "strbuf.h"
 #include "url.h"
+#include "worktree.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -507,50 +508,63 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 
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
+	} else {
+		strbuf_addstr(&tmp, modules_dir);
+		modules_dir = tmp.buf;
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
@@ -563,17 +577,22 @@ static void create_default_gitdir_config(const char *submodule_name)
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

