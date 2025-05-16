Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314242135AC
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407545; cv=none; b=aE9mcQNRf9wxL8OGDA3Pwi1EZ8toxlGh9mTU+RyLIYY8gqAqGCEb/0vKMdHCosecooKozJtfvfaUK/v3wAt9ywmwMVaSP0rQstn+NIwATXfE55tXZOmCHRqg4OPDRjKNfFj4UabkMuckj8a8FFyMdITlpEZYWtPrLOKhGMywsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407545; c=relaxed/simple;
	bh=DTzCkqDUzMwadEZyE0bcSfy/GnDy5t99amV7FTJ+U58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pf8wV4I5KAEzeN78jSI57ZOi4yHrxifaKVZILiZHmxXtIo5JUoGkgzY272YQ8t3X18Ev5cqWP5xiAxVNkQaaNvddhnnc9eVURo4jeoP8FYT8UBE6nwnhLYigFNnFNoYxoR8XOqtgfSORqmE0Y0KTRpXRQxi2nGhzhjgDo/RBJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATQcK60l; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATQcK60l"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442ea341570so14206815e9.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747407541; x=1748012341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xrBDhgdQE+QmtzGqKRJQKdQ3OPu6rC/08rSHvJQ+1k=;
        b=ATQcK60l5rD9Py/UuKDoxkUcX3gzQBLetu94IFWbgWQdzTT2dWBD4pbt1YgDSrbty6
         t8xrM8JWW64mmNFqwfRPbGELFrMMDhtrs5FggW6SfeeuaxaViKEplH9yfQGwWRp9dWKV
         dj0njPUItGnDicr/sJNWVJU6QdAeyuuqI5MfS+Apxa5Evg2+WjcO+svMYjyNWqORciuj
         Y7EgVSPeQAtiW3bidvTSsUV/If5k6y8c/xp2znMnEPwE3neGd1msqeE4dIcRE8vw/txY
         CIAzuAs0CCb5XOXv7qmnmQAHbM/F1hAeYcWoLlyOQnl0tiKO/yR3qPs4qogktmVV/dZk
         1n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407541; x=1748012341;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xrBDhgdQE+QmtzGqKRJQKdQ3OPu6rC/08rSHvJQ+1k=;
        b=XKlOOCTWMmq7m3fmnlq6s+XpizM7oFxiHTFIc72t13D4y6GjwJfQKF7yG6jhZn6z+F
         9dM33FG24GXvHXNH86z2r3RWWdvlCyJy3eA0hb4zxuGmxFX2CN7vnIxRzguhM2hTcmjh
         Z6eh2x/eNP8mDNUQ8yTuteoGwtJ6gQzpgTThup5Y+/nP7pP2dXCt4JSWpY0kgtzdTD5W
         DysqfirCtu9w15S8Vz3SsXESAMQjx6UfyhdxMAlj9PZGHGgcLYAmP9EdduLvNzNhIyWQ
         nvpdytHF5WWVeo+JxB208rJrXQQeqDvuw2f0uMvRTopgzKM/71iBmaMAwT8sl9ChmVnH
         0QVw==
X-Gm-Message-State: AOJu0YwEY7qHu4ate7oCugpBxAyTF+3rdu4Eg37Jg5vSppOSv8fscHAm
	AJ1zoAxw+ztyHapfU1f87Hc7+THA3adA8HT/i7wkuM3vJnTBqTwemIuiA9ujiQ==
X-Gm-Gg: ASbGncsk0j2k56ke3NpO1mu/zrhK46EhpLslmelPVoYk+66+4zSjFB9UhlHOBF66ocR
	fL34Cp75emLqgZIsfpCZ6h9fhLK7FrJiOY0uwLAmy2749WkIJUDqHre7JnmLCY6F7VbwVotz+sr
	R1qSp4FRlOONN+XG4c/z++QkZa76SHKXHrIpFzBZ+7/EITcNa33bM+wYJx0fWS9V26/qP+ELCso
	wDSISQfxZeFKJ4llAmf1rQ9cVs+2Vpk23FNn1nvoFtzjgA2m9OjG7g77Qfqoq6bb76reEBcGmWh
	94igD+6njGTtYUqz2qfxKUic57XAuuA7GI1+0ZTxJJ2ZFylWeJ4xxIIPHWtDbhsRVbY=
X-Google-Smtp-Source: AGHT+IGL0uJJuVh8baup81Bwa6r6tuc6pW/Ejr3UweB4j6NS5awBmNaHCcTs+8SWUDpTuxpHPDA0aA==
X-Received: by 2002:a05:600c:3ca0:b0:441:d438:4ea5 with SMTP id 5b1f17b1804b1-442ff0328b8mr23800565e9.20.1747407541156;
        Fri, 16 May 2025 07:59:01 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd59ab3esm36971125e9.40.2025.05.16.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:59:00 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH] stash: allow "git stash -p <pathspec>" to assume push again
Date: Fri, 16 May 2025 15:58:29 +0100
Message-ID: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Historically "git stash [<options>]" was assumed to mean "git stash save
[<options>]". Since 1ada5020b38 (stash: use stash_push for no verb form,
2017-02-28) it is assumed to mean "git stash push [<options>]". As the
push subcommand supports pathspecs 9e140909f61 (stash: allow pathspecs
in the no verb form, 2017-02-28) allowed "git stash -p <pathspec>" to
mean "git stash push -p <pathspec>". This was broken in 8c3713cede7
(stash: eliminate crude option parsing, 2020-02-17) which failed to
account for "push" being added to the start of argv in cmd_stash()
before it calls push_stash() and kept looking in argv[0] for "-p" after
moving the code to push_stash().

The support for assuming "push" when "-p" is given introduced in
9e140909f61 is very narrow, neither "git stash -m <message> -p
<pathspec>" nor "git stash --patch <pathspec>" imply "push" and die
instead. Fix the regression introduced by 8c3713cede7 and relax the
behavior introduced in 9e140909f61 by passing
PARSE_OPT_STOP_AT_NON_OPTION when push is being assumed and then setting
"force_assume" if "--patch" was present. This means "git stash
<pathspec> -p" still dies so do assume the user meant "push" if they
mistype a subcommand name but "git stash -m <message> -p <pathspec>"
will now succeed. Tests are added to prevent future regressions.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Base-Commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-assume-push-with-dash-p%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/1a8a4971c...6292feee7
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-assume-push-with-dash-p/v1

 builtin/stash.c  | 10 +++++++---
 t/t3903-stash.sh | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a6..b12fd6c40f1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1789,11 +1789,15 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	if (argc) {
-		force_assume = !strcmp(argv[0], "-p");
+		int flags = PARSE_OPT_KEEP_DASHDASH;
+
+		if (push_assumed)
+			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
+
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
-				     git_stash_push_usage,
-				     PARSE_OPT_KEEP_DASHDASH);
+				     git_stash_push_usage, flags);
+		force_assume |= patch_mode;
 	}
 
 	if (argc) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4b..295cb508a35 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1177,6 +1177,25 @@ test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	test_path_is_file bar
 '
 
+test_expect_success 'stash --patch <pathspec> stash and restores the file' '
+	cat file >expect-file &&
+	echo changed-file >file &&
+	echo changed-other-file >other-file &&
+	echo a | git stash -m "stash bar" --patch file &&
+	test_cmp expect-file file &&
+	echo changed-other-file >expect &&
+	test_cmp expect other-file &&
+	git stash pop &&
+	test_cmp expect other-file &&
+	echo changed-file >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'stash <pathspec> -p is rejected' '
+	test_must_fail git stash file -p 2>err &&
+	test_grep "subcommand wasn${SQ}t specified; ${SQ}push${SQ} can${SQ}t be assumed due to unexpected token ${SQ}file${SQ}" err
+'
+
 test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
 	mkdir sub &&
 	>foo &&
-- 
2.49.0.897.gfad3eb7d210

