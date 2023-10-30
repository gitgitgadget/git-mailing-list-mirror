Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3378EA3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3UfkPUv"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB0683
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 20:08:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso29458155e9.3
        for <git@vger.kernel.org>; Sun, 29 Oct 2023 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698635294; x=1699240094; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqs2I45H+XBtf9yS5dVD9F+ySbonGCYvJjULMWEImMM=;
        b=R3UfkPUvFRIOOltuY1KhRaNJ3EZFVkLNbJRmVdzVp6OkKmps8uKAwBbf+dkN+ySRY7
         Cd8aJ4Ao2ym94FKl/yeppEMfyzbbGAL6UsrnsnbQwFHeUcUXBHsUTNOXTrE6GZmE25MU
         CEhd9iBHvOzPXFDj1nUpLFZ5K1tqkuiPjMfwnCELsfoZkuW1znpgi79hHhcTnBvjhiC9
         Amw/ZJr5aFDL+ZNb6j45sMGHfyhNSG3nwJPA9ws82m5O+/4ECZ/sOlHPmjA0mODNbZ3V
         /3KjyM/Ski4/lChIr0ArLQiymWQkWLqsg/Pzk7uEfJLAtj0Sl4fPRyY15vbyXLbpH5Uk
         YVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698635294; x=1699240094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yqs2I45H+XBtf9yS5dVD9F+ySbonGCYvJjULMWEImMM=;
        b=oZ6CHjt+M/F8BFDrea2QNHTyu8YIHmy0Y5OhHcgvGLUG72ThaBj29sj/xQoxtMEQH/
         7d1ruRkZ6/R5jAwQTXvPkOIT/OqlMSzoOiMZfVhjxMkV8sXLVJ/OwCww3YEs2nGtMW98
         CMLHKyRjbmR+MWxQuC/z/AphoDB1uaa1j5vT+LoMBu3YS961s/itakvgtOHHtryXQj1x
         1i4CDmpVRnQCrTriq69wtp4LS0cGvr8arMQ29UXyM15Df1ED/wk34jNI1b+kVj47AfvT
         yWO6Pn4nctfVmW8ZTTUlJwlVx3+N0hbcSGDW6oLUnYyF2swMAIsXG0sPvgGQA8n327tI
         Z64Q==
X-Gm-Message-State: AOJu0YyrsOrmf98MLzgY9Bxv42lrr+9PHn77sjAt5+rcQQRziaJiJSQv
	VX7CdZu4eL4XjGGuSaHi407CLTwkw70=
X-Google-Smtp-Source: AGHT+IE6YQspnCEQXxPo8RxCOZffURtEmFApenmRDzkdpAGXWfruNinwYGIk+cVmdTEqOcLqR6lVOQ==
X-Received: by 2002:a05:600c:3149:b0:409:101e:235a with SMTP id h9-20020a05600c314900b00409101e235amr6871334wmo.28.1698635293953;
        Sun, 29 Oct 2023 20:08:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c458500b00406443c8b4fsm11517844wmo.19.2023.10.29.20.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 20:08:13 -0700 (PDT)
Message-ID: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
From: "Tony Tung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Oct 2023 03:08:12 +0000
Subject: [PATCH] sequencer: remove use of comment character
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
Cc: Tony Tung <tonytung@merly.org>,
    Tony Tung <tonytung@merly.org>

From: Tony Tung <tonytung@merly.org>

Instead of using the hardcoded `# `, use the
user-defined comment_line_char.  Adds a test
to prevent regressions.

Signed-off-by: Tony Tung <tonytung@merly.org>
---
    sequencer: remove use of hardcoded comment char
    
    Instead of using the hardcoded # , use the user-defined
    comment_line_char. Adds a test to prevent regressions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1603%2Fttung%2Fttung%2Fcommentchar-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1603/ttung/ttung/commentchar-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1603

 sequencer.c                   |  5 +++--
 t/t3404-rebase-interactive.sh | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d584cac8ed9..8c6666d5e43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6082,8 +6082,9 @@ static int add_decorations_to_list(const struct commit *commit,
 		/* If the branch is checked out, then leave a comment instead. */
 		if ((path = branch_checked_out(decoration->name))) {
 			item->command = TODO_COMMENT;
-			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
-				    decoration->name, path);
+			strbuf_commented_addf(ctx->buf, comment_line_char,
+					      "Ref %s checked out at '%s'\n",
+					      decoration->name, path);
 		} else {
 			struct string_list_item *sti;
 			item->command = TODO_UPDATE_REF;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8ea2bf13026..076dca87871 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1839,6 +1839,45 @@ test_expect_success '--update-refs adds label and update-ref commands' '
 	)
 '
 
+test_expect_success '--update-refs works with core.commentChar' '
+	git checkout -b update-refs-with-commentchar no-conflict-branch &&
+	test_config core.commentChar : &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git commit --allow-empty --fixup=third &&
+	git branch -f is-not-reordered &&
+	git commit --allow-empty --fixup=HEAD~4 &&
+	git branch -f shared-tip &&
+	git checkout update-refs &&
+	(
+		write_script fake-editor.sh <<-\EOF &&
+		grep "^[^:]" "$1"
+		exit 1
+		EOF
+		test_set_editor "$(pwd)/fake-editor.sh" &&
+
+		cat >expect <<-EOF &&
+		pick $(git log -1 --format=%h J) J
+		fixup $(git log -1 --format=%h update-refs) fixup! J : empty
+		update-ref refs/heads/second
+		update-ref refs/heads/first
+		pick $(git log -1 --format=%h K) K
+		pick $(git log -1 --format=%h L) L
+		fixup $(git log -1 --format=%h is-not-reordered) fixup! L : empty
+		update-ref refs/heads/third
+		pick $(git log -1 --format=%h M) M
+		update-ref refs/heads/no-conflict-branch
+		update-ref refs/heads/is-not-reordered
+		update-ref refs/heads/update-refs-with-commentchar
+		EOF
+
+		test_must_fail git rebase -i --autosquash --update-refs primary shared-tip >todo &&
+		test_cmp expect todo
+	)
+'
+
 test_expect_success '--update-refs adds commands with --rebase-merges' '
 	git checkout -b update-refs-with-merge no-conflict-branch &&
 	git branch -f base HEAD~4 &&

base-commit: 2e8e77cbac8ac17f94eee2087187fa1718e38b14
-- 
gitgitgadget
