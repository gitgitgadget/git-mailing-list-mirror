Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E741A4E7
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134169; cv=none; b=Yp1PQXa5Uw2ijO1HqHyGQKbtrRHE+qOmk7rzm0ITh+Couh+JU+WFjq7PkJ0eiWw9pUtYCsd+nFHQ/6dx7MofIE3iwPpMaOA9VN2MQOCnoev7P06bjVS9yrhkzamBySI++pW4ftDOzkAY/RNsLnyAVa2b+6hc0LHblmPER9nWGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134169; c=relaxed/simple;
	bh=TXel3Ne/oeAPjb1TkbJREw329zPVnaWLyUTU35VC2qs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ukwpQKb2OvibmqVfF9YNwV0H7Q2taHciQrHX572gkgGNxEyMAATQRYmb0hfATicXeVLLzwUcxabrFc8CxiMShMq5bJ7glPyWtrcy4cNbdh3SRR1cS1xelVpwKLirVqz3Fy9g0s/dzWER8B/wrRFGR3y0pnWdER3DHt7EsBhX3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCMZGJzZ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCMZGJzZ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e63ee7b4cso515019285a.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792134167; x=1792738967; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ovr9lQYpw1rWqIQnUWU3DNmb3YCEiWTGO0IREjva2Jk=;
        b=eCMZGJzZPeOUpBsw2CYA5QVlZLPaDUKJm0WqacSDlc7aqbLTU7LBqa6gB9bgdvCzDl
         XkhLaE4ZAo1RoylP0GxOu35kfwGKcDPufJYR+FCcK4XMPhzySvsh3GlOy7To1M6Kmyba
         h/Hng9twSgBlBuyAG3B4zM0YOAJ43MakFEQS9VDopkrvUev9o29PKUzOgSY1/0jtHGX4
         V3BpqyYbU+Ndi+bzfbbUHnR32Upz7l7wlmkM4YlFeX43YfPUUbgjhv/Gb8MBLGbeQKIC
         wcL3g2vcJYuD8bS+KIWgBgs463dkoC/Iq1pMsALGPoCFboaPibFRWdJkNklAU/EBb3YJ
         Fw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792134167; x=1792738967;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ovr9lQYpw1rWqIQnUWU3DNmb3YCEiWTGO0IREjva2Jk=;
        b=MYgciqHW2xEdTUxGfRputxLLHqXK8Uv1azXUoCJ1cnDyw1cVXUqCrqliBAMevMsZsG
         KWK9dGlkJoJmsZAx9/+fuvvb26/nxIEwhE7Ue67CVfxwldu1oJsF1w/FKZBHJNFmAb7s
         Ls+bJzNU/HYeVwtqqO6Ox41leqGOoXMK79Z/gNuHvZrx52MIJpZTH/f/q30z66BqYpLT
         AUjLiRSBVGwdVKaFIUD+jKSwf1uL0zK3fsgy6y/VyGOmwDTQW/jJfuUHWRHA7kBnu6NF
         ehNdw6Fks2v/55rLda6kzDmJCs+csnRdCZ17SMI3w1t5pBmdsXpZ+GSjz4eP4W3mcJe1
         PzLA==
X-Gm-Message-State: AFq9FYJ1pnlAbfTLo5NfX+Vkf5kMuVi12eTqr1n1vYlOoIO3I0CRCHOg
	t94e00H9xNNb+Ob6AlhSLmXK1B6RIyMQ/GinRusOpbCAr1G4DTbKuSqd85aMkQ==
X-Gm-Gg: AYBFou1CuNtaCArb+bfW1UcADIvoL5eulhL/EACs8d5xZx4gUadtb78kXRKA0Tt6tjC
	vwjHg+bsWjsOb/MjR2OjW/kbjlqFYjSHILRNP3FS2h2hmvMMnH6DkDEttoJkeBvFXIPm1JINzuM
	xTfY6sacjAzgIZqr3lEQjjleyezI2q3FsETJzWxf37RxMgHBpAbh7DLD1Us/ZYOoAOFzP5OgIrr
	wPDAD7Wo9Hjl6vZv6fuABca0t/jvabhVjdkb+hhzDg9tKPBZr2+5sd/XFGjbdVo80bFmZJP/jNE
	5dgCNZ6QIQifwb0Lt+IsNjrBZORrBUkGciKNz99dNgFgLPu3PHxyrET5429XHt2294GeH7ID5z2
	uk6Rtjv6qc31gyjCVR3744zWKke2xPcCXQ/oSCY0dcWoSxsiRzsi96+fbfR8dJleHTxAzX4Jk2/
	YPPl6EX6O5NGHbT0wqE//U2DOBMgwaWZzujlLlCtqLxGm+mLSi8+0VpPH6k/V/ishbG71Sw9w=
X-Received: by 2002:a05:620a:3705:b0:93c:c27f:961b with SMTP id af79cd13be357-93ebd20b8fbmr3513706085a.44.1792134167000;
        Fri, 16 Oct 2026 00:02:47 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a17f226sm138346685a.17.2026.10.16.00.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:02:46 -0700 (PDT)
Message-Id: <pull.2450.git.git.1792134165785.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 07:02:45 +0000
Subject: [PATCH] branch: let inherit track a remote-tracking start point
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

With branch.autoSetupMerge=inherit, "git switch topic" creates a local
topic branch from origin/topic with no upstream, and warns that no
remote is set. "git switch -c topic origin/topic" and an explicit
"--track=inherit" do the same.

A remote-tracking branch has no upstream of its own to copy. Make
inherit use it as the upstream directly, as the default "true" does,
so that inherit sets up tracking in every case the default does.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    branch: let inherit track a remote-tracking start point
    
    With branch.autoSetupMerge=inherit, make git switch -c new_branch
    upstream/master work without a warning, and sets the remote branch
    upstream/master as the upstream.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2450%2FHaraldNordgren%2Fhn%2Fbranch-inherit-remote-tracking-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2450/HaraldNordgren/hn/branch-inherit-remote-tracking-v1
Pull-Request: https://github.com/git/git/pull/2450

 Documentation/config/branch.adoc |  2 +-
 Documentation/git-branch.adoc    |  4 +++-
 branch.c                         |  3 +++
 t/t2060-switch.sh                | 17 +++++++++++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index c2acd89c99..6d9fbe5353 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -10,7 +10,7 @@
 `always`;; automatic setup is done when the starting point is either a
 	local branch or remote-tracking branch
 `inherit`;; if the starting point has a tracking configuration, it is copied to the new
-	branch
+	branch. A remote-tracking starting point is tracked directly, as with `true`.
 `simple`;; automatic setup is done only when the starting point
 	is a remote-tracking branch and the new branch has the same name as the
 	remote branch.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index bfdf459329..238d99fd27 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -280,7 +280,9 @@ remove it anyway.
 The exact upstream branch is chosen depending on the optional argument:
 `-t`, `--track`, or `--track=direct` means to use the start-point branch
 itself as the upstream; `--track=inherit` means to copy the upstream
-configuration of the start-point branch.
+configuration of the start-point branch. A remote-tracking start-point
+has no upstream of its own, so `--track=inherit` uses it as the upstream
+directly.
 +
 The `branch.autoSetupMerge` configuration variable specifies how `git switch`,
 `git checkout` and `git branch` should behave when neither `--track` nor
diff --git a/branch.c b/branch.c
index 22f4f46b96..2c23179775 100644
--- a/branch.c
+++ b/branch.c
@@ -263,6 +263,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	if (!track)
 		BUG("asked to set up tracking, but tracking is disallowed");
 
+	if (track == BRANCH_TRACK_INHERIT && !starts_with(orig_ref, "refs/heads/"))
+		track = BRANCH_TRACK_REMOTE;
+
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index cec2fe6876..da9d01ab84 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -146,6 +146,23 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'autoSetupMerge=inherit tracks a remote-tracking start point' '
+	git clone . downstream &&
+	(
+		cd downstream &&
+		git config branch.autoSetupMerge inherit &&
+		git switch -c new_branch origin/main &&
+		git status >../actual &&
+		cat >expect <<-EOF &&
+		On branch new_branch
+		Your branch is up to date with ${SQ}origin/main${SQ}.
+
+		nothing to commit, working tree clean
+		EOF
+		test_cmp expect ../actual
+	)
+'
+
 test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
 	test_when_finished "
 		git worktree remove wt1 ||:

base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
gitgitgadget
