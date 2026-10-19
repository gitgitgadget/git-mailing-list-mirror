Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432652;
	b=fpovtULEAIfT5yOmumitRr2/r5YHGQA2iKB7HANFjNH3RhonDC8hshEqbUWuE0eBojXd
	 FY607h9QfTkJf5n3dp+ahShyin/cMOK4WfrMux/U3ISoCgZHxyN4NHhOKLTtd3P2qkWb1
	 T0gYeFQwAB2UIfdHwVRw31j3VD5pdRhWBJMDPd9OjI2cGTy+cRNbvPcziQ8iWJwomScms
	 pRgpK0/NoVN01lBMJPC3H60edC3sardo9pWu5zmmWp5mCkmD015lBcJWkMncMrZPqQjXr
	 VpLOz3KYLinwMITq5FePPs4eGLgzWDuSD065J7PJKkzQf8KU8O33anHV8W2ObAydmRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kH1yUTEppmD819tIF5/+lh1pEaa0qODCTaCZHdvPj8c=;
	b=FJ5FcCnV/M7t70N6VEMWmtSPUbR+VXo9UcRrBGA8YI98tr6V0d3B+g5ucR0EDMlQiiyZ
	 2MJmpB3KzOY135B9RQvjLLBG4igfUWiNpHj5wJkXOzLrbe+PZbjpXDgqBbYmaCgxVe2tm
	 uC1btfrvWnPKgRBF3xWXpypC2/l1fBPxitZ+l16xqn69GdxxvzsLASze8U/jRf4BEsTIj
	 mdPAfJ23PE+awvR79AHeJ2hBtNPU/xQkkkHahC1F4rGxtMzN0uIk/HaMpGCFGzH8JjZmw
	 DpAEVvmzdJCDnDP7sbIYfFGB6sDeQHYULcSEtpXdIMxar3T5qeplB0G5ecDmMb1t6iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NBmCpugr;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF439606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF439606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NBmCpugr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so14278965e9.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432650; x=1793037450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kH1yUTEppmD819tIF5/+lh1pEaa0qODCTaCZHdvPj8c=;
        b=NBmCpugrgQqMZQ8OnSf1fgLUaVF9mn8di6qTmo54gXyqmn2APBsuZPTlhwy17j9dd4
         CU8KBeNXAPEZAa9YQPzELQWtS3R+raQu85iRfGfgIMmOL8h8DFgozmxZmdlCmGbgaKs8
         9pI5kHutcAJu6cNJgUH5iOswH6vDw5sSyOToQeInFUzmaZoLNiJjClSqG51P1HQBjSDv
         7Htvhsz1iNQuFqi2KZWsYG30gIuWU0Ag021S6SincTJJrtQQ4UOqMkBIM7ItJjgN7OcR
         bcFENF1QF8NFm4ePgHoFnZDZSF9bg0+65Gh8RJQ32yWdCE273u38Rpmay+S7mL7O3GHA
         sQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432650; x=1793037450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kH1yUTEppmD819tIF5/+lh1pEaa0qODCTaCZHdvPj8c=;
        b=oq0eS/9pDNfUB0P1A5JwvcxStzqineLQ3DJGOuMw48jeivwM1ATlqL4+tSULvHTcyL
         syp8BIjaYU7liEs9ybz5ecSG44wTx4kHiWOELIncOn3HuN9X+60CgVF52vSCWpBO7djy
         8/IZZehkOzY+xIah3oeiZzBXR2K1LmWhE7zsxdzPdBEyP6PkQmB/8s82Pb6Y+YUyM357
         E0IHIl+kdFmDdeYVNxdYF+hcPrtf3logQHBYOzGNVLb1zSw6pq1mTyzazrngEfnRe84T
         HdK1dPkwdYtTZ5Nnto3AWO+160YQRemrEV+t4+6J9dOHoreG81tn0Xs0NTlYK+iH/lYB
         npvQ==
X-Gm-Message-State: AFq9FYIXP3Vu6gQULli6I7oCOGAxFkKG2onFtmq1R21p2/Rya8R7eGFT
	dMED3+mSjpnHcW+QSqxCM2Ab4mbrTzDDw5X2ITjiHSl/V7B4n8fPzn2otabyvw==
X-Gm-Gg: AYBFou3z2ly9ROYGxzT78CSMKVgmDMY85iHxIH8qhPvyC3I0iLrMa9qs/nhTztiBgcB
	2A2OV2JP6vqDj/pUUv34ePlmdPI09J7f6Ic0xoezTrNSgDw6OGqgDjkAt4aUJoSNWE0hmjEtwla
	ELktNksgnokmYscb4P6xOSMVfyjL0jRNyXBYjlnlsYt6m5FoFvgRwIxnRdGRbW+V+/pwmHKuV/k
	o7hVGyWB13ooI/4V01a6naDfg7A8BSsxbe2ImpMTMB0ZtrjHyuqSV4cqqO/0cnwLYelIGqX9RC6
	pTUYckowRQAs/XT6/hSbs5KEAJ1YDMbHE6o5MME3pNmaUPiHIQWxIWGgUxskd8/vz/YbjnfB3HL
	/f1ZYxT9aCSChSinF3FePG2l+PNaNM4CnOMYUkD3hxaqsJMjGqw6T/vYLWD+yOrQqoVP4FgxY7N
	bpc0e/5nmy+mIvdqR3/w90YxJ9j+wAqmFsNbCSa8X2Ww6TH1sIm9htJzhh3mGQCUwA/N+vvSsTf
	LflfzniGE8DiG1j/6NO+YQqt2Le1Nc=
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr144851795e9.24.1792432649949;
        Mon, 19 Oct 2026 10:57:29 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.1.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e19ad17esm69729595e9.3.2026.10.19.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:57:29 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] status: reword message for a missing upstream branch
Date: Mon, 19 Oct 2026 19:57:22 +0200
Message-ID: <20261019175722.5223-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clone an empty repository, make a commit and run "git status":

    $ git init --bare empty.git
    $ git clone empty.git work && cd work
    $ git commit --allow-empty -m initial
    $ git status
    On branch master
    Your branch is based on 'origin/master', but the upstream is gone.
      (use "git branch --unset-upstream" to fixup)

The upstream is not gone, it was never there: the remote is empty,
so origin/master has not been created yet. The advice is also not
what the user needs; "git push" creates origin/master and the
message goes away.

The message was added in f2e087395b (branch: report invalid tracking
branch as gone, 2013-08-26), assuming that a configured upstream that
cannot be resolved must have been deleted. But "git clone" of an empty
repository configures the upstream anyway, and Git has no way to tell
"deleted" from "not created yet".

Since we cannot tell the two cases apart, change the message for both,
including the "deleted" case that has been reported as "gone" since
2013, so that it is correct either way:

    Your branch is set up to track 'origin/master', which does not exist.
      (use "git push" to create it)
      (use "git branch --unset-upstream" to stop tracking it)

Only suggest "git push" when it would actually create the upstream,
that is when the push destination of the branch (what "@{push}"
resolves to) is the upstream itself. This is not the case, for
example, with push.default set to "nothing", or when pushing to a
different remote (branch.<name>.pushRemote or remote.pushDefault).
It is also not the case with push.default set to "matching": it only
pushes branches that already exist on the remote, so it would not
create the missing upstream. In all these cases only suggest
"git branch --unset-upstream".

"git checkout" prints the same message, so it changes too. The
"[gone]" shown by "git status -sb", "git branch -vv" and
"%(upstream:track)" is not changed, as scripts may depend on it.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is an RFC mainly about the wording. The case of a freshly cloned
empty repository has been confusing users for a while, e.g.
https://stackoverflow.com/questions/24870145

I could not find a previous discussion of this case on the list.
Opinions on whether "status:" or "remote:" is the better area prefix
are also welcome, as "git checkout" shows the same message.

This is a resubmission of this patch, which I haven't seen in 
'seen' or 'next' https://lore.kernel.org/git/20261009134004.188952-1-gitter.spiros@gmail.com/
Thanks 

 remote.c                 |  34 +++++++++--
 t/t6040-tracking-info.sh | 120 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index 71170f36a9..4ed4d1ee2f 100644
--- a/remote.c
+++ b/remote.c
@@ -2442,6 +2442,31 @@ static void format_branch_comparison(struct strbuf *sb,
 	}
 }
 
+/*
+ * Would a plain "git push" create the remote-tracking ref "upstream"?
+ * Not with "matching", which only updates branches that already exist
+ * on the remote.
+ */
+static bool push_creates(const char *push_ref, const char *upstream)
+{
+	return push_ref && !strcmp(push_ref, upstream) &&
+	       repo_config_values(the_repository)->push_default !=
+	       PUSH_DEFAULT_MATCHING;
+}
+
+static void format_missing_upstream(struct strbuf *sb, const char *name,
+				    bool suggest_push)
+{
+	strbuf_addf(sb, _("Your branch is set up to track '%s', "
+			  "which does not exist.\n"), name);
+	if (!advice_enabled(ADVICE_STATUS_HINTS))
+		return;
+	if (suggest_push)
+		strbuf_addstr(sb, _("  (use \"git push\" to create it)\n"));
+	strbuf_addstr(sb, _("  (use \"git branch --unset-upstream\" "
+			    "to stop tracking it)\n"));
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2503,12 +2528,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 		if (cmp < 0) {
 			if (is_upstream) {
-				strbuf_addf(sb,
-					_("Your branch is based on '%s', but the upstream is gone.\n"),
-					short_ref);
-				if (advice_enabled(ADVICE_STATUS_HINTS))
-					strbuf_addstr(sb,
-						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+				format_missing_upstream(sb, short_ref,
+							push_creates(push_ref,
+								     full_ref));
 				reported = 1;
 			}
 			free(full_ref);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..39cb755ccc 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -96,7 +96,7 @@ test_expect_success 'checkout (upstream is gone)' '
 		cd test &&
 		git checkout b5
 	) >actual &&
-	test_grep "is based on .*, but the upstream is gone." actual
+	test_grep "set up to track .*, which does not exist." actual
 '
 
 test_expect_success 'checkout (up-to-date with upstream)' '
@@ -123,7 +123,123 @@ test_expect_success 'status (upstream is gone)' '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	test_grep "is based on .*, but the upstream is gone." actual
+	test_grep "set up to track .*, which does not exist." actual
+'
+
+test_expect_success 'setup clone of an empty repository' '
+	git init --bare empty.git &&
+	git clone empty.git empty-clone &&
+	git -C empty-clone commit --allow-empty -m initial
+'
+
+test_expect_success 'status (upstream not yet pushed after empty clone)' '
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+	git -C empty-clone status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout (upstream not yet pushed after empty clone)' '
+	test_when_finished "git -C empty-clone branch -D tmp" &&
+	cat >expect <<-EOF &&
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+	EOF
+	git -C empty-clone checkout -b tmp &&
+	git -C empty-clone checkout main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'status -s -b (upstream not yet pushed after empty clone)' '
+	echo "## main...origin/main [gone]" >expect &&
+	git -C empty-clone status -s -b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup expected output without "git push" advice' '
+	cat >expect-no-push <<-EOF
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+'
+
+test_expect_success 'status (missing upstream, push.default=nothing)' '
+	git -C empty-clone -c push.default=nothing status >actual &&
+	test_cmp expect-no-push actual
+'
+
+# "matching" only updates branches that already exist on the remote
+test_expect_success 'status (missing upstream, push.default=matching)' '
+	git -C empty-clone -c push.default=matching status >actual &&
+	test_cmp expect-no-push actual
+'
+
+test_expect_success 'status (missing upstream, pushRemote is another remote)' '
+	git init --bare fork.git &&
+	git -C empty-clone remote add fork ../fork.git &&
+	git -C empty-clone -c branch.main.pushRemote=fork status >actual &&
+	test_cmp expect-no-push actual
+'
+
+test_expect_success 'status (missing upstream, advice.statusHints=false)' '
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is set up to track ${SQ}origin/main${SQ}, which does not exist.
+
+	nothing to commit, working tree clean
+	EOF
+	git -C empty-clone -c advice.statusHints=false status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream deleted on the remote and pruned' '
+	git init --bare pruned.git &&
+	git clone pruned.git pruned-clone &&
+	(
+		cd pruned-clone &&
+		git commit --allow-empty -m initial &&
+		git push origin main &&
+		git checkout -b topic &&
+		git push -u origin topic
+	) &&
+	git -C pruned.git branch -D topic &&
+	git -C pruned-clone fetch --prune
+'
+
+test_expect_success 'status (upstream deleted on the remote and pruned)' '
+	cat >expect <<-EOF &&
+	On branch topic
+	Your branch is set up to track ${SQ}origin/topic${SQ}, which does not exist.
+	  (use "git push" to create it)
+	  (use "git branch --unset-upstream" to stop tracking it)
+
+	nothing to commit, working tree clean
+	EOF
+	git -C pruned-clone status >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'short formats still show "gone" for a deleted upstream' '
+	echo "## topic...origin/topic [gone]" >expect &&
+	git -C pruned-clone status -s -b >actual &&
+	test_cmp expect actual &&
+	git -C pruned-clone branch -vv >actual &&
+	test_grep "^\* topic .* \[origin/topic: gone\] initial$" actual &&
+	echo "topic [gone]" >expect &&
+	git -C pruned-clone for-each-ref \
+		--format="%(refname:short) %(upstream:track)" \
+		refs/heads/topic >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'status (up-to-date with upstream)' '
-- 
2.53.0

