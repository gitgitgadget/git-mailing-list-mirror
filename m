Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D53CA71
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIEMlF8h"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418E2B3
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:09:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f9268bf8cso437288f8f.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698728961; x=1699333761; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUjGjsv9pmAhwvM+a3fK958uEjDQnpX/uHAMv1LR3Ls=;
        b=DIEMlF8hgE2YrAD03Le66aNHR8n+dOY7kshrfjK7oFkSrYav1xU5FuQEa/D357jed0
         oElns47XBQK30QX0CX8zD1jaure2ZDOmw/z6PvGZxTuZt7od5N1x18pWbfTmDbKaBPIV
         Rm8HN43gsvHQBuW9bRlQscwOquXIUf4FrGATNJBfX0nHmsvuow1njtGwGQHvfB+mdR3N
         FN5MGltQ57JG+rOcwnWqWB03ZcVXbX5EKjfrrLSexYynaQLeG7YYUUH2NWTTMUY6CngX
         jGL2XHt/mqYflE8Gx7jW3FpTVIuC+lsEnwgXTW/Qnz+d0NAXzfMSZj08IT5vfISejbzB
         zqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728961; x=1699333761;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUjGjsv9pmAhwvM+a3fK958uEjDQnpX/uHAMv1LR3Ls=;
        b=MnlylM5HpT+IX661PwikQdkNL9/nSSUC6imIQCIL6Ci+oc/Tjd1MDpR1X4ql3esVTm
         +fsvMDsBHE2Vy9TFGgvwpiE0BgdsU5xeGhrbdD7/1wkdRRNDR4qdx6nBUVDsRK2zf6XU
         KCtR0MlSftiK8mqhleM8jVpNq1dgDNhcfTTbQGfXglmJ8cIyNzsIs48knu/DP6CqMs2P
         OScvfVHlWnZA+hkLeW6Yyydv/TaFdYwVFdPlltZcqkV4qazT71n6a+FfE1kRszH83ecf
         ntH002Z5kWdAsjWe5+EFIlUty8RkVbAD7uEVcKUAOfPoTkO/Lh7NT4rM7R2HuSj9WYhm
         gTTQ==
X-Gm-Message-State: AOJu0YyQtb0FdaxDXum6kOgWdC6rAN6wOa91Btcrxv6FEeWfzRC7+AG8
	I7sIEZD53t1wvmoL/XhE7OB8iJFKLAQ=
X-Google-Smtp-Source: AGHT+IHqWCRyqksquPqd7H6Ow2GLsySK6cI8CnWoizonI3SjN5BOSAKlHZd41VAa3/dMemnsdOImFQ==
X-Received: by 2002:a05:6000:c8:b0:32d:b081:ff31 with SMTP id q8-20020a05600000c800b0032db081ff31mr8053943wrx.66.1698728961386;
        Mon, 30 Oct 2023 22:09:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6107000000b0032da49e18fasm579486wrt.23.2023.10.30.22.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:09:17 -0700 (PDT)
Message-ID: <10598a56d64f5c2b4d8d05d7e7b09a18ef254f88.1698728953.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
	<pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
From: "Tony Tung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Oct 2023 05:09:11 +0000
Subject: [PATCH v2 1/2] sequencer: remove use of comment character
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
Cc: Elijah Newren <newren@gmail.com>,
    Tony Tung <tonytung@merly.org>,
    Tony Tung <tonytung@merly.org>,
    Tony Tung <tonytung@merly.org>

From: Tony Tung <tonytung@merly.org>

Instead of using the hardcoded `# `, use the
user-defined comment_line_char.  Adds a test
to prevent regressions.

Signed-off-by: Tony Tung <tonytung@merly.org>
---
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
-- 
gitgitgadget

