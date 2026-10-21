Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585665;
	b=xGHswFu7+6Quhd4CuJ1LjfiDA1zccvjqpFDA0Mb61Srnv1OZqxcv9jUBF1hPHh0l3Aqy
	 AaCYCjBBwzc+UCOoRtHZaO/hmdAFcqqSNe9YB2uitgq7BSknDleJeYN7KJDdBVC60grws
	 K2sa8Nye6Ow6qK2V1ntj6RuHzJRVbsVbYIi5iXqGWYYHej2B+YbFDiHoYXxYnQUDKCr4l
	 iO7R8tCQFEKk6jY5szNGp4g4HjRi7QBNT8EjjSmWkoBxlcrfPfn8muEchWkYQVCRNv6i2
	 e3G2pGkiYr8w4uAN61M7txbPzr6dhqEWw3REajfbUfUgDKEJiAdWqyTojt5/j65buKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=BIShlO7EAlWdcPVyD2d6swTg6QUOUq4EzeuSjCZPqY8=;
	b=HSEI8l7ChxXevvCkOODyEzinpV3BIoACHWUWeGhtay9+cExnQ8HSEnl9s0YLGx72vet1
	 OJ2GVIBAyDwtDOGsd57MTjmb0N2YLmJSTPAsDl5+JbZieWo+TEaalna4IhiLIcREV3ljn
	 UIW/N8tdvBt7ly8EsChgflimgis9ZKML229/QWNd3RP56I2vZIIV4h/VI4inoHggbKb4D
	 L17dFjxoYEWJR4OosFLZoaKrvgwNYov3W1vVvPojaZr35QBfu7PGc9lpmtbU0N6tZQ7fI
	 Ob2vMIT7xupA1QcWL42hZh95Tt1nyMQ8WIqv/uDtDJ7FWrshI5UF+Qpe9GPI54+k5pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7eLfBtw;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91D606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B91D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i7eLfBtw
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93cc1ab5f6cso74356385a.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585664; x=1793190464; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BIShlO7EAlWdcPVyD2d6swTg6QUOUq4EzeuSjCZPqY8=;
        b=i7eLfBtwnjvxfc1rnwEuzUbfSkxhEq/WfygkTo4hUe2cMBzOJJUwNMysocx/BJ3LOf
         7tQadSnblrJhEyLL6UPb43u9/RdJ4A2+F8l82qd96CDhsB4w8ttIfwl62uL/clvGtCZM
         tXAWKnH6u5iSntgQwPZJHEjeaUJHOVYj3+fSRakVcVGE2sV0C0zYErxsT4O19A5YVnvr
         WN6sYH6H3DFWyvojYmJLPxVV58DqjU+icmZw0csTXFz0nkPPo7cKYieZjRoXedUFRbG9
         Mac8Y76SuCRgOwLwUKjtbJoObMFY8n7xQKW+3L1G/ZW3O+I8b7EC9w7FfSA8tMxJd4MP
         wBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585664; x=1793190464;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIShlO7EAlWdcPVyD2d6swTg6QUOUq4EzeuSjCZPqY8=;
        b=DWQBuINlxUg+6VzKDoa1fGRRzi78A2QuZClUVjJ/6khDRmpP3tJzbfRg6tgt45wTFz
         NeQZSSBlghtXQ/4BGgbV9eI+/maBt61pLiFGHgnR3Y9qi62u1ml54l+sh7u16nxh4J8i
         iUf76IhLNqNre/01lZeG2ovxWWQVgb0DZrGez3vXOqv59qDBRqyJ4pYig5BhWG6kbRud
         I96Clc/CipQAsd3goyP7C3UmgPm7RSVKgyL5IAG0nAzeBByg9J8GNXgjBrjz3xd3AchX
         cEtApYzzPL3SgJ5yx2RtQSHzvpkB3cSnSRoH2tgMkMqCvxjqExnmKaimWynuPNicZUTh
         aUNw==
X-Gm-Message-State: AFq9FYJmVCN8xE8EQzTZMcXYaZCmG4g0EEgUBE9LUnsjPssvC3nalPUo
	ipSmCpmZgWCc7awUIPDFrsX0a8Va/c9STNwyPnKlm+AFbHUBxDwaDW+f+UvzSFnQ
X-Gm-Gg: AYBFou2k3IYCGFCrDR5L57QAb2O3MFRdLSmJB2LzUEuFTIUY36TVEa2kP5jW+nByRsD
	Q3ExOxRxpZCChhFnE2vgiwjztjt4Zot27uyXQV7afnmsftLtLtSuMesjU1/Gw3FSSez4SsiY1OB
	7MUUKeSvhHIZUCr9tm1qp2nQxyC9ULtscmlNt5holcTW3Q1q4gvtVvehvAosqxh27yv3LPtbvLC
	OrJLlRACnmbfQN4Jo0wFtnElpC6Zsouoge/VuCzM7cUZlp/kFPgWVNOnv0DYXvSWl15fDIlACxx
	qWJE5rsr5FMVMq03/iaa4D09LqdKJSa14u5pk60kzki3G1kpxM3J9I/tl8npo6kr+5WWextOWur
	U8Bh7N4AsuY4SNN76wgQ9HBs1iyGitUCeNB/Ylub91NYgBfAcdu/YdBGmbG34q1kvTk+uC7Kbaz
	Cq+zjqSJzJrSqu9cICXTQhR1jAyjZZ0ZKCp35vmg+3y9B2Z43U4gqblvHGOQqyH1+L+ykQDigr6
	u5aorHpJhtrrsjOoGcZuUbPxdGLn22pePTdPd1DgrXsfiVDUNlBaU+SrvQ=
X-Received: by 2002:a05:620a:2913:b0:93f:4cfb:2a8a with SMTP id af79cd13be357-93f57f1f019mr397629485a.26.1792585663785;
        Wed, 21 Oct 2026 05:27:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.158.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56dfdb2esm245776085a.28.2026.10.21.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:27:43 -0700 (PDT)
Message-Id: <pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com>
In-Reply-To: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 12:27:42 +0000
Subject: [PATCH v2] status: compare against both upstream and push branch by
 default
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Commit 3ea95ac9c5 (status: add status.compareBranches config for
multiple branch comparisons, 2026-02-26) added status.compareBranches
so that "git status" can show comparison of the current branch with
its upstream in addition to where the branch is pushed to, which is
great to support the triangular workflow. It however did not make it
the default to show both.

Showing both without any configuration was the original proposal for
that commit. But some found the comparison with the push branch to be
noise. So the comparison was made opt in [1], with the idea of
flipping the default later if people like the option.

Make "@{upstream} @{push}" the default. With push.default left at
"simple", @{push} is either the same as @{upstream} or does not
resolve at all, so the output stays the same. It only changes for
those who set push.default to "current" or "matching", or configure a
push refspec, in two cases:

  - In a triangular workflow, a comparison with the push branch is
    shown after the one with the upstream.

  - A branch without an upstream is compared with the branch it is
    pushed to, where nothing was shown before.

Those who find the comparison with the push branch to be noise can
set status.compareBranches to "@{upstream}" to get the old output
back. Having configured push.default and a push remote to get there,
they are the users best placed to find that setting. Those who are
just starting to push somewhere other than where they pull from
benefit the most from seeing both comparisons without having to
discover the variable first.

No existing test relied on the old default, since none of them had a
push branch different from the upstream without also setting
status.compareBranches. Add tests for the new default on a branch
whose upstream and push branch are the same, on a branch in a
triangular workflow, and on a branch without an upstream. The existing
test that sets the variable to "@{upstream}" uses a branch where both
are the same, so it passes with either default. Add one on a
triangular branch to show that it restores the old output.

[1] https://lore.kernel.org/git/xmqq8qe0f2iq.fsf@gitster.g/

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    status: compare against both upstream and push branch by default
    
    Make @{upstream} @{push} the default for status.compareBranches. With
    the default push.default of simple the output does not change. With
    current or matching, a branch pushed somewhere other than its upstream
    now shows both comparisons.
    
    Changes in v2:
    
     * Kept the existing tests unchanged, including the explicit
       "@{upstream} @{push}" config and the "@{upstream}" test on main
     * Added tests for the new default with the same upstream and push
       branch, in a triangular workflow, and without an upstream
     * Added a test showing that "@{upstream}" restores the old output on a
       triangular branch
     * Reworded the commit message to point to 3ea95ac9c5 and explain which
       setups see a change

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2458%2FHaraldNordgren%2Fstatus-compare-branches-default-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2458/HaraldNordgren/status-compare-branches-default-v2
Pull-Request: https://github.com/git/git/pull/2458

Range-diff vs v1:

 1:  2de975c175 ! 1:  39512b9ea1 status: compare against both upstream and push branch by default
     @@ Metadata
       ## Commit message ##
          status: compare against both upstream and push branch by default
      
     -    In a triangular workflow, where a branch is pulled from one place and
     -    pushed to another, "git status" only compares the branch to its
     -    upstream. It says nothing about the branch it is pushed to unless
     -    status.compareBranches is configured.
     +    Commit 3ea95ac9c5 (status: add status.compareBranches config for
     +    multiple branch comparisons, 2026-02-26) added status.compareBranches
     +    so that "git status" can show comparison of the current branch with
     +    its upstream in addition to where the branch is pushed to, which is
     +    great to support the triangular workflow. It however did not make it
     +    the default to show both.
      
     -    Show both comparisons by default. When the two resolve to the same
     -    branch, which is the common case, only one comparison is shown, so the
     -    output for most users does not change. Setting status.compareBranches
     -    to "@{upstream}" gives the previous output.
     +    Showing both without any configuration was the original proposal for
     +    that commit. But some found the comparison with the push branch to be
     +    noise. So the comparison was made opt in [1], with the idea of
     +    flipping the default later if people like the option.
     +
     +    Make "@{upstream} @{push}" the default. With push.default left at
     +    "simple", @{push} is either the same as @{upstream} or does not
     +    resolve at all, so the output stays the same. It only changes for
     +    those who set push.default to "current" or "matching", or configure a
     +    push refspec, in two cases:
     +
     +      - In a triangular workflow, a comparison with the push branch is
     +        shown after the one with the upstream.
     +
     +      - A branch without an upstream is compared with the branch it is
     +        pushed to, where nothing was shown before.
     +
     +    Those who find the comparison with the push branch to be noise can
     +    set status.compareBranches to "@{upstream}" to get the old output
     +    back. Having configured push.default and a push remote to get there,
     +    they are the users best placed to find that setting. Those who are
     +    just starting to push somewhere other than where they pull from
     +    benefit the most from seeing both comparisons without having to
     +    discover the variable first.
     +
     +    No existing test relied on the old default, since none of them had a
     +    push branch different from the upstream without also setting
     +    status.compareBranches. Add tests for the new default on a branch
     +    whose upstream and push branch are the same, on a branch in a
     +    triangular workflow, and on a branch without an upstream. The existing
     +    test that sets the variable to "@{upstream}" uses a branch where both
     +    are the same, so it passes with either default. Add one on a
     +    triangular branch to show that it restores the old output.
     +
     +    [1] https://lore.kernel.org/git/xmqq8qe0f2iq.fsf@gitster.g/
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       
       	upstream_ref = branch_get_upstream(branch, NULL);
      
     - ## t/t5505-remote.sh ##
     -@@ t/t5505-remote.sh: setup_url_pushremote () {
     - 		git checkout -b topic --track origin/main &&
     - 		git commit --allow-empty -m topic-change &&
     - 		git config push.default current &&
     --		git config status.compareBranches "@{upstream} @{push}" &&
     - 		git config branch.topic.pushRemote "$fork_url" &&
     - 		git push
     - 	)
     -
       ## t/t6040-tracking-info.sh ##
      @@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches deduplicates when upstream and push
       	test_cmp expect actual
       '
       
     --test_expect_success 'status.compareBranches with only upstream shows only upstream' '
     --	test_config -C test status.compareBranches "@{upstream}" &&
     --	git -C test checkout main &&
     --	git -C test status >actual &&
     --	cat >expect <<-EOF &&
     --	On branch main
     --	Your branch is up to date with ${SQ}origin/main${SQ}.
     --
     --	nothing to commit, working tree clean
     --	EOF
     --	test_cmp expect actual
     --'
     --
     - test_expect_success 'status.compareBranches with only push shows only push' '
     - 	test_config -C test push.default current &&
     - 	test_config -C test status.compareBranches "@{push}" &&
     -@@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches with only push shows only push' '
     - 	test_cmp expect actual
     - '
     - 
     --test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
     -+test_expect_success 'status shows ahead of both upstream and push branch by default' '
     - 	test_config -C test push.default current &&
     --	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     - 	git -C test checkout -b feature3 origin/main &&
     - 	git -C test push origin HEAD &&
     - 	(cd test && advance work) &&
     ++test_expect_success 'status shows one comparison by default when upstream and push are the same' '
     ++	git -C test checkout main &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch main
     ++	Your branch is up to date with ${SQ}origin/main${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     + test_expect_success 'status.compareBranches with only upstream shows only upstream' '
     + 	test_config -C test status.compareBranches "@{upstream}" &&
     + 	git -C test checkout main &&
      @@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches shows ahead of both upstream and pus
       	test_cmp expect actual
       '
       
     -+test_expect_success 'status.compareBranches with only upstream shows only upstream' '
     ++test_expect_success 'status shows ahead of both upstream and push branch by default' '
     ++	test_config -C test push.default current &&
     ++	git -C test checkout feature3 &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature3
     ++	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
     ++
     ++	Your branch is ahead of ${SQ}origin/feature3${SQ} by 1 commit.
     ++	  (use "git push" to publish your local commits)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'status.compareBranches with only upstream hides a different push branch' '
      +	test_config -C test push.default current &&
      +	test_config -C test status.compareBranches "@{upstream}" &&
      +	git -C test checkout feature3 &&
     @@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches shows ahea
       test_expect_success 'checkout with status.compareBranches shows both branches' '
       	test_config -C test push.default current &&
       	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     +@@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches with behind push branch and no upstr
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'status shows push branch by default without upstream' '
     ++	test_config -C test push.default current &&
     ++	test_config -C test remote.pushDefault origin &&
     ++	git -C test checkout feature15 &&
     ++	git -C test status >actual &&
     ++	cat >expect <<-EOF &&
     ++	On branch feature15
     ++	Your branch is behind ${SQ}origin/feature15${SQ} by 1 commit, and can be fast-forwarded.
     ++	  (use "git pull origin feature15" to update your local branch)
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     + test_expect_success 'status.compareBranches behind upstream-equals-push suggests plain pull' '
     + 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
     + 	git -C test checkout -b feature16 origin/main &&


 Documentation/config/status.adoc | 11 +++---
 remote.c                         |  1 +
 t/t6040-tracking-info.sh         | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index b5dd85b761..1d847d3a8a 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -23,8 +23,9 @@ status.compareBranches::
 	are supported. They are interpreted as `branch@{upstream}` and
 	`branch@{push}` for the current branch.
 +
-If not set, the default behavior is equivalent to `@{upstream}`, which
-compares against the configured upstream tracking branch.
+If not set, the default behavior is equivalent to `@{upstream} @{push}`,
+which compares against both the configured upstream and push tracking
+branches.
 +
 The entries are shown in the order they appear in the configuration.
 Duplicate entries that resolve to the same ref are suppressed after
@@ -36,11 +37,11 @@ Example:
 +
 ----
 [status]
-	compareBranches = @{upstream} @{push}
+	compareBranches = @{upstream}
 ----
 +
-This would show comparisons against both the configured upstream and push
-tracking branches for the current branch.
+This would only show the comparison against the configured upstream
+tracking branch for the current branch.
 
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
diff --git a/remote.c b/remote.c
index 49ee2ea318..0d97cb9100 100644
--- a/remote.c
+++ b/remote.c
@@ -2472,6 +2472,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		string_list_remove_empty_items(&branches, 0);
 	} else {
 		string_list_append(&branches, "@{upstream}");
+		string_list_append(&branches, "@{push}");
 	}
 
 	upstream_ref = branch_get_upstream(branch, NULL);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..3d61297c37 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -331,6 +331,18 @@ test_expect_success 'status.compareBranches deduplicates when upstream and push
 	test_cmp expect actual
 '
 
+test_expect_success 'status shows one comparison by default when upstream and push are the same' '
+	git -C test checkout main &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is up to date with ${SQ}origin/main${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'status.compareBranches with only upstream shows only upstream' '
 	test_config -C test status.compareBranches "@{upstream}" &&
 	git -C test checkout main &&
@@ -380,6 +392,36 @@ test_expect_success 'status.compareBranches shows ahead of both upstream and pus
 	test_cmp expect actual
 '
 
+test_expect_success 'status shows ahead of both upstream and push branch by default' '
+	test_config -C test push.default current &&
+	git -C test checkout feature3 &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature3
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature3${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with only upstream hides a different push branch' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream}" &&
+	git -C test checkout feature3 &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature3
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'checkout with status.compareBranches shows both branches' '
 	test_config -C test push.default current &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
@@ -707,6 +749,21 @@ test_expect_success 'status.compareBranches with behind push branch and no upstr
 	test_cmp expect actual
 '
 
+test_expect_success 'status shows push branch by default without upstream' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	git -C test checkout feature15 &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature15
+	Your branch is behind ${SQ}origin/feature15${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull origin feature15" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'status.compareBranches behind upstream-equals-push suggests plain pull' '
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&
 	git -C test checkout -b feature16 origin/main &&

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
