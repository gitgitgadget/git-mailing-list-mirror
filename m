Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337925;
	b=QG+9wNBCr/hxZzf3ChKMD/hfgbVVn33oMftHn2hVqCVpHUsuiQCKZDkpP7OI5ULXGYVt
	 Ud5UmaePaolzs2nzOTAiEuxsjG1k7n9Ufh/foHIpu2Vn+ZFKRd+BvJZqsYkAYlRhfIfzz
	 xBnZckj1b5mtxeJlrpzecrIKFATvGVGOqRw+zzsLuLujUsUnz5KXeiAloLIXt4C0P6jM9
	 /+4gaSRbIxsLukYtt3x8YaZfnsJszVuFL3JXPKELLycfYuNu610VF2DDer9phofcoxWkb
	 ZviV5xZMwfjgfrXFIwRpZBtn5xy+Zmnhh3xlOyhamu09uy1soBEBQTHsfUhC6jhoJ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=nFE8sZKbA2lGwci815KRX/7xlhaiezAohBEGnPfG9qk=;
	b=Pif8Ktku0F/yoQyBzK0Y8tQWl+20qC6IMaJIZuhSsdxc7tKJOUJx8sZuchbSi5YZdN9j
	 IxZ45Y/CM5Z06hz063kdy14URyaohRXi8EqghKrDlY7QQXjsEbFi+upRnohTE2VVdW8dv
	 3SRxvl4vNtWZWrCMQN7MUunDB/corKolYKRIK8BMtSKdSQ/HcfqcT4PgO/NAbMHOloy4Z
	 1yF+GXEC3q/vQvM6wwVUzx3taj0yMK1z+Nhmfz+GvsfkQvEsVzGva+XdbugVYkbsG4D/H
	 EMTDItYMSAxXnFFxr1xPea4FW5eD/cV6LpT1Oa44UN7BrZWrp8gmaj8EcR5lHXy4KWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XEK0rQAy;
	arc=none smtp.remote-ip=209.85.167.182
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE2606A332
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBE2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XEK0rQAy
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4d7034a99a9so1337597b6e.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337924; x=1794942724; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nFE8sZKbA2lGwci815KRX/7xlhaiezAohBEGnPfG9qk=;
        b=XEK0rQAyCcrZkAMaQiHdExhwHdR7lTWoyM28ButpGAaJ/sd7VuTwRNqMlIVoELydvn
         7iecs8jXpsYGkvYBS2ddxznRYFZYZ/3aUvqvhABz6eTHf7g6Tsoljo+c2y3kw1i5DlBM
         1dhg06eP2VxH0IeUI/tLIToFEqQi56HNy5/jM069D6GpKyguEvmXpai3oIu4rjpe+oAA
         pn7eoqGZJNgjQD8TSTwguxY7nejUDS6kA6UsDQd6Aorz7gr5yhwoxxp8uZj/nMB2/4i/
         iK3DwNMChAZ7ghqUBParm/YNj1NC9izI6pf7RRpV/YyfAlbZPzYwWd73UWqvtu1yfBVu
         Ocpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337924; x=1794942724;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFE8sZKbA2lGwci815KRX/7xlhaiezAohBEGnPfG9qk=;
        b=yms94nvOeMWiDzyzNVqsBgMzxAOSm+ccenhMbYcIjN0qPBtKT/RnsxQxqLTUFkvlXv
         /o0c3sRVEVjjj44InVhA9f6CLdgkIlAkgB4XypSjpxxgTP0LTpy84ZcN6siWaRfCRIOp
         33ffLLn3sFsiHQ1Lm9PVzJfEbpxUfZwUev0W6VHAE5HnY1zca3PIZbpQ2YT/XNikgQvO
         7YMqRGk3KWZGXU/qf3hjvOCLex9sWmzycCsyoOb1BVHlgXPC0oaz9M1ZphHjJAVnjYnL
         bk9KyFuMm0ih5IVsyCKU9THTtMoReAaCAw8g1/ItzibREhUfABNkMzU/GpEvnab8WKEH
         imXA==
X-Gm-Message-State: APuU4Z8BBRdHTC6rycJy7UdYznEq/Ce9M97BOeC9+ufmE051kxN7mJje
	aCiyNqhIkboQ8lXZbSOsAJ5/uxSXU3sb/ray/DLp56vOMadYwa6uswi1lIjONg==
X-Gm-Gg: AYBFou390/LPGIvFf3+ENbc+1tAKFM5yyXUIx13RhjPV4JyI7HH/rgl/O3GE9aWoEpJ
	JNiC3b/PvRfFCfLzCLfXw6OiZeBWBBM+NQRAijv0avrMUf4d/C2Nm+Lwt9SD4jrNMHetCSb+65Z
	yj7cg0nKSpQoIxNoYSykBL2o9V3jm/AnkxhlLBa931PDSwMYLKveS/hJqhoOl8yQiXlWO1+z0K1
	q8N+SiO+PZhF5195vVS+F0+ctEtzP+YDEZ4iIKnJrpJ/nXZ8mGjHbXbmpSQKtrmz1IGfKOm5gvk
	umDkeYqK+l9wbOMuY399kyPHBIKhkHq+MXuGpnZB/DBHzdlOb7UlpUtEhL674KSW4XoMb5ZgZo6
	ao4WTsJa5oN6Oj4SW9VSvhhRVsDSOsN9H1t6friQCLO71UX465vY3/G+Iy8SSZfiZyMuFQpr2w/
	GllSCOWUl719HUmqwN87jA/dKslZW1Kr4r1hcEjbHYgkcw2HlpR0AMZCeebhUnxtr1hcPf5gvr+
	hAebrH4bmjJQUzXJU0c1bWH9jbf7/TCm1xpug9+2QWELZT9yAgo0Fi9UXgC0NS4oFU+FvrCv4AD
	0tCP9Tngs0qpi1g2v+3Qoqzfx307Bfc=
X-Received: by 2002:a05:6808:470b:b0:55c:7ce:cb77 with SMTP id 5614622812f47-5683cd6327cmr2775847b6e.36.1794337924122;
        Tue, 10 Nov 2026 11:12:04 -0800 (PST)
Received: from [127.0.0.1] ([52.154.21.60])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504e7dasm2818864b6e.5.2026.11.10.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:12:02 -0800 (PST)
Message-Id: <6aad1a1cd34a65939be6f64a0d8950e0bc23870a.1794337920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
From: "Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 19:11:58 +0000
Subject: [PATCH 1/3] checkout: make orphaned commit checks configurable
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    wyattj.holden@gmail.com,
    Wyatt Holden <wyattholden@microsoft.com>

From: Wyatt Holden <wyattholden@microsoft.com>

When leaving a detached HEAD, checkout enumerates refs and walks
history to warn about commits left behind. This work can dominate
checkout time even after the working tree has been updated.

In an automated checkout of an internal monorepo, unpack_trees ended
about 12 seconds into a roughly 204-second run. Stack dumps captured
the main thread in orphaned_commit_warning(), enumerating loose refs
and opening ref files. Using --quiet reduced the observed checkout
time to about 14 seconds, but also suppressed unrelated output.
These observations motivate an opt-out; they do not establish how
much of the delay came from enumeration versus history traversal.

Add checkout.orphanedCommitWarning, enabled by default, so checkout
and switch can skip the check while retaining normal checkout output.
Automated callers can opt out when they do not need a warning about
leaving detached commits behind.

Follow the configuration precedent of 06b324c1d71 (status: add
status.aheadbehind setting, 2019-06-18). Unlike status, introduce no
dedicated command-line option; callers can use git -c for a one-off
override.

Add a Trace2 region around the check to make its cost visible in
future investigations and to verify that disabling the setting skips
the routine rather than merely hiding its warning. Document the
setting and test both checkout and switch.

Signed-off-by: Wyatt Holden <wyattholden@microsoft.com>
---
 Documentation/config/checkout.adoc | 11 +++++++++++
 builtin/checkout.c                 | 18 ++++++++++++++++--
 t/t2020-checkout-detach.sh         | 29 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/checkout.adoc b/Documentation/config/checkout.adoc
index e35d212969..cacd10449a 100644
--- a/Documentation/config/checkout.adoc
+++ b/Documentation/config/checkout.adoc
@@ -22,6 +22,17 @@ commands or functionality in the future.
 	option in `git checkout` and `git switch`. See
 	linkgit:git-switch[1] and linkgit:git-checkout[1].
 
+`checkout.orphanedCommitWarning`::
+	When leaving a detached `HEAD`, linkgit:git-checkout[1] and
+	linkgit:git-switch[1] check whether any commits are being left
+	behind that are not reachable from any ref or the new `HEAD`,
+	and warn if so. This check can be expensive in large repositories.
+	Set this variable to `false` to skip the check and its warning
+	without suppressing other checkout output. Defaults to `true`.
++
+When disabled, commits left behind can still be found in the `HEAD`
+reflog until its entries expire. See linkgit:git-reflog[1].
+
 `checkout.workers`::
 	The number of parallel workers to use when updating the working tree.
 	The default is one, i.e. sequential execution. If set to a value less
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c0f0d2c700..7cc9e97612 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -51,6 +51,7 @@ struct checkout_opts {
 	int patch_interhunk_context;
 	int auto_advance;
 	int quiet;
+	int orphaned_commit_warning;
 	int merge;
 	int force;
 	int force_detach;
@@ -99,6 +100,7 @@ struct checkout_opts {
 	.patch_context = -1, \
 	.patch_interhunk_context = -1, \
 	.auto_advance = 1, \
+	.orphaned_commit_warning = 1, \
 }
 
 #define MERGE_WORKING_TREE_UNPACK_FAILED (-2)
@@ -1132,6 +1134,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	struct rev_info revs;
 	struct object *object = &old_commit->object;
 
+	trace2_region_enter("checkout", "orphaned_commit_warning", the_repository);
 	repo_init_revisions(the_repository, &revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
 
@@ -1155,6 +1158,7 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	/* Clean up objects used, as they will be reused. */
 	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
 	release_revisions(&revs);
+	trace2_region_leave("checkout", "orphaned_commit_warning", the_repository);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
@@ -1253,8 +1257,14 @@ static int switch_branches(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
-		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
+	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit &&
+	    new_branch_info->commit != old_branch_info.commit) {
+		if (opts->orphaned_commit_warning)
+			orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
+		else
+			describe_detached_head(_("Previous HEAD position was"),
+					       old_branch_info.commit);
+	}
 
 	if (autostash_res == STASH_APPLY_CONFLICT && !opts->quiet)
 		fputc('\n', stderr);
@@ -1295,6 +1305,10 @@ static int git_checkout_config(const char *var, const char *value,
 		opts->dwim_new_local_branch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.orphanedcommitwarning")) {
+		opts->orphaned_commit_warning = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 28bbbe6c05..d21dbd5b72 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -164,6 +164,35 @@ test_expect_success 'checkout does not warn leaving reachable commit' '
 	check_no_orphan_warning stderr
 '
 
+for command in checkout switch
+do
+	test_expect_success "$command honors checkout.orphanedCommitWarning" '
+		git checkout --detach "$orphan2" &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-enabled-$command" \
+			git -c checkout.orphanedCommitWarning=true \
+			$command main 2>stderr &&
+		check_orphan_warning stderr "2 commits" &&
+		test_grep "\"label\":\"orphaned_commit_warning\"" \
+			trace-enabled-$command &&
+
+		git checkout --detach "$orphan2" &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-disabled-$command" \
+			git -c checkout.orphanedCommitWarning=false \
+			$command main 2>stderr &&
+		check_no_orphan_warning stderr &&
+		test_grep "Switched to branch" stderr &&
+		test_grep ! "\"label\":\"orphaned_commit_warning\"" \
+			trace-disabled-$command &&
+		check_not_detached
+	'
+
+	test_expect_success "$command rejects invalid checkout.orphanedCommitWarning" '
+		test_must_fail git -c checkout.orphanedCommitWarning=invalid \
+			$command main 2>stderr &&
+		test_grep "bad boolean config value.*checkout.orphanedcommitwarning" stderr
+	'
+done
+
 cat >expect <<'EOF'
 Your branch is behind 'main' by 1 commit, and can be fast-forwarded.
   (use "git pull" to update your local branch)
-- 
gitgitgadget

