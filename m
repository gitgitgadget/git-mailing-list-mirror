Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219155D889
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997134; cv=none; b=iYMbXNNOg+Ed0eTq+MfBwzGDawec4NXJaSw15MQKEpIHsRgXdkZKQ01ZaYfxsDb+pjqcP+getuxDZx9+dj/QDMtOBQ1zmW0deeVBqrhCxvu4YnMV20nrTxSUXkKwfnvA7y5WxhdzVEPqUGTZ0RmFiSTOoaxXqzUBAhRuRlPqd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997134; c=relaxed/simple;
	bh=8qCZggEWHLbiyWIUdWxMf1/Y8+cAKjC9rHShn1zbrRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tb4uGNlW26rG91aWqrdr6EOHl1mAeF9FvV2qCeyW2FR3R4aeNVGvbb2wgDO1YwRB0Xkl4PaFRezkXAFh5GsHB2LOT2/4peiARCKtydINaQiuUN9S5p6dRzvCzpY4mwrWgLprjYrUZK8IpSLuX6JIS+C06nvXEXtukWdwaf47v4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dASe+Ao3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dASe+Ao3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1af482519so16982635e9.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997131; x=1792601931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Je1vAeb2VD7AWTgV7fzx9UkoNM0//XBFLXXhFB3NG4Q=;
        b=dASe+Ao37zSPNgUiXo++l9Q8EHJrFMhw+WKkAYPcBjq+AOiwTjKIXnRJ4u7WwkerXS
         uBq89U54VHDEnTDNm09fajvgDFu+tLHq6FC8P53XFmWdFnD4S7nMegZz0D2uqdxTTbvw
         q2dd0MIHzlrw6/YAHEyKQwl7QjXbUJjOiA5+dne0JXCXAYgbxKgVsSs5WI5lw9iyFdjW
         oCysvo/93kLgXXdk6cr6DpIc9SPxInMPpf0f20AlxdjO10wj9Q/xhZygqNacGPDgrD8F
         cdPakGqDzPAWxu4fauLx/hAkLBtZzg7KFQVNRRLA72sJNz91WJuqGjERY15ALsfrDsve
         4G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997131; x=1792601931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Je1vAeb2VD7AWTgV7fzx9UkoNM0//XBFLXXhFB3NG4Q=;
        b=NWXO4DPCy2Fgk63UQ0EZw+qT4fEIZLWatFHHmtJqY4iGFJenQ282KJlM7aV0WoXmP9
         UIIOTdSZ29i0E8gQUPk1iikI9014kdRnAJwlDGVychi53KKUHeIcw6zQ0sAP4NdjyBij
         j3wcLCi306APY+6w6//8UpcQmpxah9AHKmLRDLvtPHIMjjENH2ImPYc71IQ3AUcn0R4k
         Qs/rlHAhrh4Qh7Cg5SfhNIKVnlgGp8ak8B6z8vhUfXA3mrT9LZdk2FzQJ/gKZygZX3A4
         9zS+Sngv45d8dJzaENYhlpItto1uQgIbQcsryTFX3IwzeuqfmK3LmaCQfgjjDdY43Kpr
         ebdA==
X-Gm-Message-State: AFq9FYKvkWfLI+Kr2RZ2i7paG8QNm8o75SByNiADHkDR0IAitmQs/HFd
	fqulF6P7hWWGJEsIVlIofJrydaQnmAtUSzgDNd7CWEOxmRoglPhgOokgDqqHU4rp1xE=
X-Gm-Gg: AYBFou0ep9FHg9CUA3vN4qo/QSjFCAKEM4CagRYsk2s0qTRBv2bqE/ZxvTFfx5mfJHT
	lM8HRmPz7m5nWGnlZKqEpl7BrmlZVFbzDbTHeKsuLAGhkSaoTyTviAOLLV2X3SBSLi32bB9or4H
	EB/sAiuo1x8tXpinsBaMXggcA1XvfQf7NmhHbZqBn040JSZpGft7kEkaRRx6Pc4p9wBrihskqqA
	c0SAhcLdcCqmW8e/DT7Siwr7aNTXh1C4V6MnkRzft8wGqGfqk4iFMCxbd/KZKGVFmglQJdHkttK
	6zDNBdPnV31dtfpbkFHK26ZImzwxNqoty4doTmG09c7rQkwnlm1cAbKd6BQW+XvZTQLIWlF1QEb
	Epm59UVk1YkbLk+OSezm1Uu5/Gv/Xu8RSdb7fSPFPK83ACQu1uUhMdIPB+veqpNI+LR/Z3LPDC+
	hMAyX/r8Nu3g8OJCodoFxZ7pMy8uK0fTsVbI42QlKZoKBSHM2IKzb0CxXvFEpSoO64+H0vONS3V
	j8YSoNNpxPnmM5de3fLJcJFEAx4QjsCRcJaNH+MihF7vB+6cnnWTJ6u
X-Received: by 2002:a05:600c:a218:b0:4a1:a3b5:2022 with SMTP id 5b1f17b1804b1-4a1a4f996a9mr116377335e9.14.1791997130846;
        Wed, 14 Oct 2026 09:58:50 -0700 (PDT)
Received: from u.ad.analog.com (dynamic-078-054-209-001.78.54.pool.telefonica.de. [78.54.209.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df0f8f624sm1803842f8f.5.2026.10.14.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:58:49 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH] sequencer: don't clobber HEAD ref name in worktree lookup
Date: Wed, 14 Oct 2026 17:58:24 +0100
Message-ID: <20261014165824.2214234-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_decorations_to_list() skips the branch that HEAD points to, because
the rebase updates it anyway, as per aa37f3e1d89 (sequencer: ignore HEAD
ref under --update-refs, 2022-07-19).

However, it keeps the name of that branch in the static buffer returned
by refs_resolve_ref_unsafe(). If another branch on the same commit is
checked out in a different worktree, branch_checked_out() overwrites
that buffer. If the current branch comes after the other branch in the
list of decorations, it gets a "checked out" comment in the todo list
instead of being skipped, and the branch whose name ended up in the
buffer is skipped in its place.

Decorations are processed in reverse alphabetical order, so this depends
on the branch names. The test added in 94304b9f48e (sequencer: comment
checked-out branch properly, 2024-11-25) happens to trigger the problem
and expects its result.

Fix it by using refs_resolve_refdup(), correct that test's expectation,
and add a test with checked-out branches sorting both before and after
the current branch.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 sequencer.c       | 11 ++++++-----
 t/t3400-rebase.sh | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6dae43e4db..c672b6e127 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6577,11 +6577,11 @@ static int add_decorations_to_list(const struct commit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
-	const char *head_ref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						       "HEAD",
-						       RESOLVE_REF_READING,
-						       NULL,
-						       NULL);
+	char *head_ref = refs_resolve_refdup(get_main_ref_store(the_repository),
+					     "HEAD",
+					     RESOLVE_REF_READING,
+					     NULL,
+					     NULL);
 
 	while (decoration) {
 		struct todo_item *item;
@@ -6633,6 +6633,7 @@ static int add_decorations_to_list(const struct commit *commit,
 		decoration = decoration->next;
 	}
 
+	free(head_ref);
 	return 0;
 }
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index accaaba4d4..0e7ef33eb1 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -483,7 +483,26 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on
 	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
 		 rebase -i --update-refs base &&
 	test_grep "% Ref refs/heads/wt-topic checked out at" actual &&
-	test_grep "% Ref refs/heads/topic2 checked out at" actual
+	test_grep ! "Ref refs/heads/topic2" actual
+'
+
+test_expect_success 'git rebase --update-refs ignores current branch with branches on worktrees' '
+	test_when_finished git branch -D base current a-topic z-topic &&
+	test_when_finished git checkout main &&
+	test_when_finished git worktree remove z-topic &&
+	test_when_finished git worktree remove a-topic &&
+	git checkout -b base main &&
+	git checkout -b current &&
+	test_commit msg4 &&
+	git worktree add a-topic &&
+	git worktree add z-topic &&
+	git checkout base &&
+	test_commit msg5 &&
+	git checkout current &&
+	GIT_SEQUENCE_EDITOR="cat >actual" git rebase -i --update-refs base &&
+	test_grep "# Ref refs/heads/a-topic checked out at" actual &&
+	test_grep "# Ref refs/heads/z-topic checked out at" actual &&
+	test_grep ! "refs/heads/current" actual
 '
 
 test_done
-- 
2.56.0

