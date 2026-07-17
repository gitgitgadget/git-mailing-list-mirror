Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8914372066
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304418; cv=none; b=TWFmszAfrymThNs6QCgM4Ww3HIOS17lAB8ATL8s34/MHSDZh6GZFjJPdbuguv8AFGGcq4IogmZbtpaFetyu+xE3kXIcysA1BnobtjloF9Qiesx/tWNt9GRqFnU6TnVESday2m0Me3N7w73PyP09h52eHlQYp2mW7h4NBQx6ybuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304418; c=relaxed/simple;
	bh=vrFNvXZHfxgoFeCI80lk6ZiFpTVNn6TAm2Lt0E/4ZLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFO8XkjmYAoWHJjaH8hf4Tv7FSBJ67NGh7iY2i/aHfSMRHE4FzMjkAiGlmx/1/LDYt9XLc8WWYzHz71v4h/CNr/XyrlInbTP6JqllPnW13uc9jwLi0hPGmKoqII1EGJEanG6t7/OKoalYPNWBedabuBSY/09tjblcxu8Eb2JO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJRXtBpy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJRXtBpy"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47d6c634f45so4551417f8f.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784304415; x=1784909215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v+SDSUMRpBKlEO6qdDcnH28O+lWSvMR4LfI/Ni+ga88=;
        b=eJRXtBpysr8UurR9gAs3EGu8KreDC0kyh9rmvijsXf0Zm6QlNct5v0WOyNk4deIqqd
         v9VXq+nL7SSvFzXboJSXg6c58Z4Uz4oPGTJDCMDrvUQgh1LEXy+LosUAOiyWsxplWHB5
         +ADmrfTgWVoTYU/S9pHtUv5shTcs3GJneegUVMCPlpGARbYMJGtbJBWGa7AzmuMBTgV2
         gV/6hsU9RCpguuia9Q2+zvKgAE5EGrXmT5K1bAmNCvPNS8lm8y0B5LiG5ydh27G3ddTc
         8xwPapmepYnHcnwFCR8uDS+Y65B4YuFgkIswURUis0QyIJkuhVD7k8eOH8ksmTShfLSd
         nvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784304415; x=1784909215;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+SDSUMRpBKlEO6qdDcnH28O+lWSvMR4LfI/Ni+ga88=;
        b=NG4ZNtU2M/27u5Ykpup+3G6PPTZO5BgMgu4HARkt5IJgJw6oUXZodekMoft6mchIAH
         Gd78yVRwGOV5vjg2+SSZ/zIaeQX0EtIheTv8FRs1Jb6lPnyZGHyB0vXkto0wCXU3mlan
         frF0oZdr5RvJc4PJBykdzsXQMSLR4CfhvedWUtNmJ/Fp1w3DohJnhr0XMvtu/Owir6VV
         16zE4EDcXFSw8wd/z7ErTuPE7rBIQPGUN7qbbLrp8TVo63ISrrp1/Jr8a7th3RCnSC3E
         iw68F6AZjyZXKP2Bkiet9csr/OQ/N2Lz/mQ7fX5FUn9LZKqT8VOE4oi+bRmwcMl7nEvL
         wq/A==
X-Gm-Message-State: AOJu0YwxOIWFdU2zO2W13AMI+8Jx86aDpRu/G5nB4Zjez21lhnhe5fPe
	DGgBUI8HYiWeE5DWAEJ+sO7FdWxddOghK7oYGoqHLRdyLxJcL+O5fZOJ8FJuvA==
X-Gm-Gg: AfdE7cn8LbMI712tRWgbUqIbSV90E3LlkphNUJVF1SRbWiJjhKOr1YhO5JXVSfW1nS3
	O4S85JqQ/Nue+VJjP7I7HAdFkoCT1KM61axSvwINdIl36Kfme2j9lMQsNKwoutMrFPwkje7oLoH
	MPK+XvIgiIprqcL0FostI2luyDrzZIVSQfFxPbtM8PKDuXs9i0Se937bm16vGZSplTRzELkkSnb
	it1wzeEOBZWizeGxoXz61Wxabo2hn7k5EsMrl1gF0gwmyEh44xvjGh9ziGIQr0TG0q6IhH099bJ
	r8Dgetaaw5vDDRQXaker/SO03aZxIgKzopj7lx0RM5jCPzUyhRG0ssGGLsdOll+GizM3oWZw4iA
	HAh4Fuais2ixULG5svxTakRt9YA/cHshLhqxYjWmonUh24NShktQoU2wv3+Y4p+9KOj8HxdHELf
	XDZrzCsQ==
X-Received: by 2002:a05:6000:40cd:b0:475:f0c2:5b00 with SMTP id ffacd0b85a97d-47f6233b3f4mr4782179f8f.54.1784304414852;
        Fri, 17 Jul 2026 09:06:54 -0700 (PDT)
Received: from berwick ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm5177588f8f.10.2026.07.17.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:06:54 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/2] rebase -i: fix counting of fixups after rebase --skip
Date: Fri, 17 Jul 2026 17:06:36 +0100
Message-ID: <c37a518486a8fa9832a6dbbe6048cda70af87d73.1784304378.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the sequencer processes a chain of "fixup" and "squash" commands
it keeps a list of the commands that have been executed. If there are
conflicts, then the list is saved when the rebase stops for the user to
resolve them. When the rebase resumes, the list is loaded and is used
to initialize the count of how many "fixup" and "squash" commands have
been processed; if a command has been skipped with "git rebase --skip",
then the last command needs to be popped off the end of the list.

To count the number of commands, commit_staged_changes() uses the
number of newlines in the file plus one. This is due to the slightly
unusual way the list is constructed - instead of appending a newline
when a command is added, a newline is inserted before the command
if the current count is greater than zero. Therefore, when we pop a
skipped command off the list, we should also remove the newline that
precedes it. Otherwise, when a new command is added, a blank line
will be left before it, which will contribute to the fixup count the
next time the file is read. Unfortunately, the preceding newline is
not removed, leading to an incorrect count. Fix this by removing the
newline that appears before the skipped command.

In addition to fixing the code that removes a skipped command from the
list, the code that reads the list is fixed to skip blank lines. We
have had reports of users starting a rebase with one version of
git and continuing it with another. Often this happens because the
version of git bundled with an IDE or TUI differs from the one used
at the command line. By fixing both the reading and writing ends of
the problem we ensure the count is correct when an older version of
git reads the fixup file written by a newer version and vice versa.

Triggering the incorrect count requires the user to skip two "fixup" or
"squash" commands before the final command in the chain. An existing
test is extended to prevent future regressions. The consequence of
miscounting is not serious: we just print the wrong count in the
header of the commit message template.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                | 11 ++++++++++-
 t/t3418-rebase-continue.sh | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1355a99a092..af3d2c72616 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3281,7 +3281,13 @@ static int read_populate_opts(struct replay_opts *opts)
 			const char *p = ctx->current_fixups.buf;
 			ctx->current_fixup_count = 1;
 			while ((p = strchr(p, '\n'))) {
-				ctx->current_fixup_count++;
+				/*
+				 * Older versions of git accidentally
+				 * inserted blank lines when a fixup
+				 * was skipped.
+				 */
+				if (p[1] != '\n')
+					ctx->current_fixup_count++;
 				p++;
 			}
 		}
@@ -5353,6 +5359,9 @@ static int commit_staged_changes(struct repository *r,
 			if (!len)
 				BUG("Incorrect current_fixups:\n%s", p);
 			while (len && p[len - 1] != '\n')
+				len--;
+			/* Remove trailing newline */
+			if (len)
 				len--;
 			strbuf_setlen(&ctx->current_fixups, len);
 			if (write_message(p, len, rebase_path_current_fixups(),
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index f9b8999db50..3c248e97364 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -134,6 +134,7 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 	EOF
 
 	: skip and continue &&
+	test_config commit.status false &&
 	echo "cp \"\$1\" .git/copy.txt" | write_script copy-editor.sh &&
 	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 
@@ -145,7 +146,8 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 
 	: now, let us ensure that "squash" is handled correctly &&
 	git reset --hard wants-fixup-3 &&
-	test_must_fail env FAKE_LINES="1 squash 2 squash 1 squash 3 squash 1" \
+	test_must_fail env \
+		FAKE_LINES="1 squash 2 squash 1 squash 3 squash 1 squash 4 squash 1" \
 		git rebase -i HEAD~4 &&
 
 	: the second squash failed, but there are two more in the chain &&
@@ -171,19 +173,45 @@ test_expect_success '--skip after failed fixup cleans commit message' '
 	fixup 2
 	EOF
 
+	(test_set_editor "$PWD/copy-editor.sh" &&
+	 test_must_fail git rebase --skip) &&
+	: not the final squash, no need to edit the commit message &&
+	test_path_is_missing .git/copy.txt &&
+
+	: The first, third and fifth squashes succeeded, therefore: &&
+	cat >expect <<-\EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	wants-fixup
+
+	# This is the commit message #2:
+
+	fixup 1
+
+	# This is the commit message #3:
+
+	fixup 2
+
+	# This is the commit message #4:
+
+	fixup 3
+	EOF
+	test_commit_message HEAD expect &&
+
 	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
 	test_commit_message HEAD <<-\EOF &&
 	wants-fixup
 
 	fixup 1
 
 	fixup 2
+
+	fixup 3
 	EOF
 
 	: Final squash failed, but there was still a squash &&
-	head -n1 .git/copy.txt >first-line &&
-	test_grep "# This is a combination of 3 commits" first-line &&
-	test_grep "# This is the commit message #3:" .git/copy.txt
+	test_cmp expect .git/copy.txt
 '
 
 test_expect_success 'setup rerere database' '
-- 
2.54.0.200.gfd8d68259e3

