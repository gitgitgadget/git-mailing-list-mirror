Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823D339395
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789829250; cv=none; b=UMzI2wKzH4KGOR46CAOWmdIvMbhjiUkBZj2dfyhxy+kR5NnSjaQ1hyqmrce86JmPTwvfk/k+r3dYMpWz5Xg4yEJS/hqeMRTSTh42gl5NL2ncphYB/gZMfdy+y/Ae/i2NDWvGpLXjsr+3DnY72jELkRvU97rtpbxVLX9g2rcPCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789829250; c=relaxed/simple;
	bh=13ojMzAOZIChMs1CcZlVaRDH0zeXLz0HEKduAV501yI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=C3fyF6bHrDfpM447FMoa/E8gn3pgyZpa+9HhXXpTocgY+Zcx5TtHh0iVdI+co9GBryDOKhN7XJW9Q3ffxz7dDcyftnWVshla40sd8CoYPppUn85b23m/BJUIXv26dVX/X+lkhW1/01A3QTlqIlVbHl4jUnVbYvathz+ZIMoNK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isXwcWRI; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isXwcWRI"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b355ffso1051804b3a.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789829248; x=1790434048; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OF3CLkjXtY8PdP3T/Xl9A00jYEkZ4DrXCvjPVBgOOs0=;
        b=isXwcWRId9bgEvqCG32q7r8Ie3hmbPMElb/m8isxplR+GD0fw8eYlMlFJU1CNFec5z
         25KjtrFZTvIeQU/Cm9bej4eHm2aQ1yeW7mFjXQyVRpsLUXWDvKl2N95OdEtANH0piNl7
         cFBXcqJDjEtM4HI/DfIRyJBcp0Y+dQ4kby/terNbm0B5inPs7G9CHyBvZ/eXD5eJqBPC
         rxgBOrgATpdY2oAuZraNdRRyCK4XiECsCOGhZo0vjPktXT8eDulFF7Vvr43TYusRwEXJ
         /z0N0GOCFIK8W6l3MI+SFGvRknZC5Vf7IqMAO/+sllgEpVewZhrExcUiwa0peKj0Ph+r
         eNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789829248; x=1790434048;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OF3CLkjXtY8PdP3T/Xl9A00jYEkZ4DrXCvjPVBgOOs0=;
        b=yGH2HACwTDnzh1klMN2hu9MjRRpT1I4egK1jzDQP/sLNAvJgSVfetgAe16WafiFmg0
         MYT/DtoZgIIwxDtpayiQD8JrsTmLZQyJtazOoc9l4fNt9UWBKgEh48JB5a6H25bfPbLz
         Ew590XJM0zpAS6BO7RqJJkUVTPrMVXUXSxNKOu7ezy4H1guUw31vDezvkXEurvLxaqBd
         L123nIEmFNs77IwwfytKdFSqiPgXR1NFK3i6nSoHqgpmrC7BVBynfw+tozDn4qP55YtB
         P7FjFbkkxQzo/01XI1alCKU5sO5lFHJPAmskBDAmgCypu+5YwNA4X/1GumYU8daCmSqu
         lq6Q==
X-Gm-Message-State: AFuF++lybFVP9rYil9PTR/FgalLvh0axA4boGO+gGngk9DPjVF9xwH7o
	l0MpVF/PjqigP1vhFeuRQVNbLcVVXg/3QTR4FLLYAbI0wVz9o5IEsr+/IVf1Cw==
X-Gm-Gg: AYBFou0IfI3IjJte7la1k0wL9PKmADVJ2zFMmrVlvNaqwGHDFlrRdP2qrKwI59fILx5
	8OdOWDBUyTxvlId+WFkY5oqgjCwzeN9dZx4jKgZ1rMC9e+hu3JGKEu7NvHYFUerOG25lhOAMmOX
	lo6nyeVgTJcUomOyWj1+oN+BJ0jktH0sIadLHwHWiSUBN45/9ShBjGJ1MCLxZ8sAN+vgDaDRS+6
	8GhCFj2l8Fp50xSW9GRnLE3YUqhcoQkMxAeQ2SWyNrTcZXFtHnc4cGsERb7VPUihDP32+yDUdZM
	08TvBgYYwt1DrEW7QfAiwtgc/nMVIiHPFSjl/ZzjKhE9G55OWmQLe7XyCAB5KFZAyZmu8vV9t8X
	B9+00VLGEhbDprnswy//sI4yh3aUU6mhyjSRbT53/LLyNewagGbOh2vHUU9qaLRFwcudOF7bz2f
	6JYprNxupI9TlsiZM4Nd1nlqwaFsBk2bu0OAWR7iAwQ56LY4LcjZe/8Y5t0QtNCvKzjJE7QfTj2
	u5I3ySKnQQ=
X-Received: by 2002:a05:6a20:144d:b0:3dd:a008:dc39 with SMTP id adf61e73a8af0-3dda008e131mr4964268637.39.1789829248181;
        Sat, 19 Sep 2026 07:47:28 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.13.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef9bsm6669273eec.25.2026.09.19.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:47:27 -0700 (PDT)
Message-Id: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Sep 2026 14:47:26 +0000
Subject: [PATCH] fetch: add config to avoid fetching every branch in shallow
 repo
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

In a shallow, sparsely checked out clone of a repository with many
branches, plain git pull can take minutes or hang outright, even
though only one branch is actually being worked on.

Add fetch.shallow, off by default. When enabled, a fetch or pull for
a shallow repository that isn't already scoped to specific refs
fetches only the current branch's tracked upstream, instead of every
branch the remote has. git pull ultimately runs such a fetch under
the hood, so this fixes pull the same way. It has no effect once the
repository is no longer shallow, and no effect on a fetch of a remote
the current branch doesn't track, both fall back to the existing
behavior.

This is opt-in rather than automatic because it changes what a plain
fetch or pull leaves in refs/remotes/<name>/ for anyone who currently
relies on it syncing every branch of a shallow remote, not just the
one they are on. Scoping remote.<name>.fetch by hand already covers
this for a single remote, but that requires knowing the config exists
and applies it permanently, even to branches that are not currently
checked out.

The remote's recorded default branch (remotes/<name>/HEAD) is kept up
to date the same way it always is, only the other branches are
skipped.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    fetch: add fetch.shallow so pull doesn't fetch every branch on shallow
    repo
    
    Add fetch.shallow config for big shallow repo, so git fetch/pull doesn't
    hang by fetching every branch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v1
Pull-Request: https://github.com/git/git/pull/2412

 Documentation/config/fetch.adoc |  15 ++++
 builtin/fetch.c                 |  18 +++-
 t/t5537-fetch-shallow.sh        | 146 ++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index 00435e9a16..e63e54a463 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -145,3 +145,18 @@ remove the value for the `fetch.bundleCreationToken` value before fetching.
 `never`;;
 	Never create or modify the `remotes/<name>/HEAD` symbolic-ref.
 --
+
+`fetch.shallow`::
+	If true, and the repository is a shallow repository (see
+	linkgit:git-clone[1] `--depth`), a fetch or `git pull` that names no
+	explicit refspec and would otherwise fall back to the remote's
+	configured `remote.<name>.fetch` refspec instead fetches only the
+	current branch's upstream, when that upstream is on the remote being
+	fetched. This avoids negotiating history for every branch the remote
+	advertises, which can be slow on a shallow repository that tracks
+	many disjoint shallow histories. It has no effect on a fetch that
+	names an explicit remote or refspec, and no effect on a repository
+	that is not shallow. Defaults to false.
++
+`remotes/<name>/HEAD` is still kept up to date per `fetch.followRemoteHEAD`
+while this is in effect, only the other branches are skipped.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..b22f7fe5f4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -111,6 +111,7 @@ struct fetch_config {
 	int recurse_submodules;
 	int parallel;
 	int submodule_fetch_jobs;
+	int shallow;
 };
 
 static int git_fetch_config(const char *k, const char *v,
@@ -175,6 +176,11 @@ static int git_fetch_config(const char *k, const char *v,
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.shallow")) {
+		fetch_config->shallow = git_config_bool(k, v);
+		return 0;
+	}
+
 	if (!strcmp(k, "fetch.followremotehead")) {
 		if (!v)
 			return config_error_nonbool(k);
@@ -1958,15 +1964,19 @@ static int do_fetch(struct transport *transport,
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
 		struct branch *branch = branch_get(NULL);
+		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
+			!strcmp(branch->remote_name, transport->remote->name);
+		int narrow_to_tracked_ref = config->shallow &&
+			is_repository_shallow(the_repository) && tracks_this_remote;
 
 		if (transport->remote->fetch.nr) {
-			refspec_ref_prefixes(&transport->remote->fetch,
-					     &transport_ls_refs_options.ref_prefixes);
+			if (!narrow_to_tracked_ref)
+				refspec_ref_prefixes(&transport->remote->fetch,
+						     &transport_ls_refs_options.ref_prefixes);
 			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 				do_set_head = 1;
 		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
+		if (tracks_this_remote) {
 			int i;
 			for (i = 0; i < branch->merge_nr; i++) {
 				strvec_push(&transport_ls_refs_options.ref_prefixes,
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index f323ceebd2..8143af9fc3 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -13,6 +13,24 @@ commit() {
 	git commit -m "$1"
 }
 
+check_upstream_refs () {
+	git for-each-ref --format="%(refname)" refs/remotes/upstream/ >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+check_upstream_head () {
+	git symbolic-ref refs/remotes/upstream/HEAD >actual &&
+	echo "refs/remotes/upstream/$1" >expect &&
+	test_cmp expect actual
+}
+
+check_same_tip () {
+	git log --oneline -1 "$1" >expect &&
+	git -C "$2" log --oneline -1 "$3" >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'setup' '
 	commit 1 &&
 	commit 2 &&
@@ -261,6 +279,134 @@ test_expect_success 'fetch --deepen does not truncate' '
 	test_cmp expect actual
 '
 
+test_expect_success 'fetch.shallow setup' '
+	git branch narrow-side &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git narrow-default &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git narrow-enabled &&
+	(
+		cd narrow-default &&
+		git remote add upstream ../.git &&
+		git fetch --depth=1 upstream main:refs/remotes/upstream/main &&
+		git branch --set-upstream-to=upstream/main main
+	) &&
+	(
+		cd narrow-enabled &&
+		git remote add upstream ../.git &&
+		git fetch --depth=1 upstream main:refs/remotes/upstream/main &&
+		git branch --set-upstream-to=upstream/main main &&
+		git config fetch.shallow true
+	)
+'
+
+test_expect_success 'a refspec-less fetch expands to the configured refspec by default' '
+	(
+		cd narrow-default &&
+		git fetch upstream &&
+		check_upstream_refs <<-\EOF
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/narrow-side
+		EOF
+	)
+'
+
+test_expect_success 'fetch.shallow=true limits a refspec-less fetch to the tracked branch' '
+	(
+		cd narrow-enabled &&
+		git fetch upstream &&
+		check_upstream_refs <<-\EOF
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+	)
+'
+
+test_expect_success 'fetch.shallow=true still creates refs/remotes/<remote>/HEAD' '
+	(
+		cd narrow-enabled &&
+		git symbolic-ref -d refs/remotes/upstream/HEAD &&
+		git fetch upstream &&
+		check_upstream_head main
+	)
+'
+
+test_expect_success 'fetch.shallow=true with followRemoteHEAD=always corrects a stale HEAD' '
+	test_when_finished \
+		"git -C narrow-enabled update-ref -d refs/remotes/upstream/stale-branch" &&
+	(
+		cd narrow-enabled &&
+		git update-ref refs/remotes/upstream/stale-branch refs/remotes/upstream/main &&
+		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/stale-branch &&
+		git -c fetch.followRemoteHEAD=always fetch upstream &&
+		check_upstream_head main
+	)
+'
+
+test_expect_success 'fetch.shallow=true still updates the tracked branch' '
+	commit 5 &&
+	git -C narrow-enabled fetch upstream &&
+	check_same_tip main narrow-enabled refs/remotes/upstream/main
+'
+
+test_expect_success 'fetch.shallow=true keeps git pull narrowed too' '
+	test_when_finished "git branch -D narrow-side" &&
+	commit 6 &&
+	(
+		cd narrow-enabled &&
+		git pull &&
+		check_upstream_refs <<-\EOF
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+	) &&
+	check_same_tip main narrow-enabled HEAD
+'
+
+test_expect_success 'fetch.shallow=true has no effect on a non-shallow repository' '
+	git clone --no-local --branch main --single-branch .git narrow-full &&
+	(
+		cd narrow-full &&
+		git rev-parse --is-shallow-repository >actual &&
+		echo false >expect &&
+		test_cmp expect actual &&
+		git remote add upstream ../.git &&
+		git fetch upstream &&
+		git branch --set-upstream-to=upstream/main main &&
+		git config fetch.shallow true
+	) &&
+	test_when_finished "git branch -D narrow-full-side" &&
+	git branch narrow-full-side &&
+	(
+		cd narrow-full &&
+		git fetch upstream &&
+		check_upstream_refs <<-\EOF
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/narrow-full-side
+		EOF
+	)
+'
+
+test_expect_success 'fetch.shallow=true only narrows a fetch of the tracked remote' '
+	test_when_finished "git branch -D other-side" &&
+	git branch other-side &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git narrow-other-remote &&
+	(
+		cd narrow-other-remote &&
+		git remote add upstream ../.git &&
+		git config fetch.shallow true &&
+		git fetch upstream &&
+		check_upstream_refs <<-\EOF
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		refs/remotes/upstream/other-side
+		EOF
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
gitgitgadget
