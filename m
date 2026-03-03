Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B523BF9B
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570590; cv=none; b=NkNuXEj/Vpf4Qlzr/pBJQXYiQeRN10+ms8FkT02y/Gcoat7+fSgfsfKi4PxhLjK32AMaEntWlgBhUJWUYUOg5yoOekmfbyd16fp3KutD6zznuz52SWg3/DVgCqALEh/PWyqDV8F73JVTZvjwSZ+3Fnajfn7UXFG6iKn+tsI6Fvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570590; c=relaxed/simple;
	bh=CMhDADzky7ETnsyfeBwhejrqVqU/NON+a7b1hGLVb1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGpl8mmWuzWP9moYDYyP5B+7RyvV5NTiax5Q8TWEmica3uPy94Hc5J5oXiyiXGsQw66NcOCnoHPNeRDMVSrXuRZcnF1JLr+aQFW+fK3bY8qEf8hdKMZfcQny8N7gXATpTD1fgc9he4u1qHTobXEGGQCU1SYMGEWNVoLgm8A5IPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEf8Eobi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEf8Eobi"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8274936d2c0so5963506b3a.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 12:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772570588; x=1773175388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PlRzTbxc74EYRHxirIyGgZiAhrGVoYWT9qVMpIEpi4=;
        b=eEf8EobiLBNVttdP71/Kl1eOMZEMlPOPJQnYxp/6qNGboUSgxjrP/26LG5gJgmm+rq
         A4jJHRtyyCnXfE+kTpPuaRkU6pe6fXWPkz7eO1JLSUGO/vctu6wRwJ9wXP4B42QfaPZH
         GYhYmsa5rXW6XdJL9qbPjQElHUnyi0I8DzFssKBm+VF6FsRdV4hdl3gCn3LM8W8FEMje
         1osJxI9HG6NFKbd3YqP1fUSMJdDb/tLr0isi26tsPfyYc6o1Qu5HNWFsJVYPGsm9kbSg
         zTkiCqwNWzQYZnuQCJUiZLfMw0j/SjjQKDUGOLjufWY3uo6HUojmBO0QcJ9KAZ0Tjy2g
         Vb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570588; x=1773175388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PlRzTbxc74EYRHxirIyGgZiAhrGVoYWT9qVMpIEpi4=;
        b=HEssuiUzQ+TcUtC9FdgU9rGXNfxuGOnDWJUobcu6FulFnsmMAkG/9vadZ3H5Sw15DP
         IvLY+tLPpPFqKLkISrwiBHvxqU9ErEpBWDfdRXgVMmZj6GxVlJsIn7OYT42LSKjBg5QO
         dQRffFAZbQG/msZo3r8/6a30DtIQ5RH4thloaKd/3fPqLZNfOoPDAHT9LnhHfVD3YJ3e
         cxghIzVauKoj/YjC8CfNMwUG/y97E6+MnK+QPr5WiiXiPrKKsSUx7JXKJ9cbGhD6wrup
         UAnwEfwYWKY7FDcbxKkm/b+/XMeOEyL6X+23EzHmQtXLGdfeHh6xp68VKkVrtHAmNPj8
         X6Eg==
X-Gm-Message-State: AOJu0YwKq6LoJdWbG4otl/4M/LcW2xVT/zRi+V/sOxRTPWSu/ubxBt4V
	gPZjzaA53nnTBtpIS16U0sZL2s2i1gp0Zipr7KLrLKefYX3mQ4cBZTCsQ8dBmenoIY0=
X-Gm-Gg: ATEYQzxOxIyGWCzRM6hVRWbkfBJDrSYexN3xK/54Kzf4asm0uOUCs8NyPf6VeJGFg4Y
	JxWiiP4R+JSMauXK4m3CyfNQkkE7nyxR5+n9gny8WVWSMaCZtNNQWws9UnNEu6RBJOmH937VQmz
	U8LN4Y3euU2233MCxkiV6g7Rf2JhrSLwJ6BiQbSUo7ZAEaufAqKM3CMM4o7JkraNQGhKFIpp9AN
	s86M78ZHzWyeTjX+cVc0nzz6iKFyhqpAlu4HEauBoMwZifKgv7Z+Ojbkvok6nRCf7ZFMANPYL6E
	wfPLtVynOkvSAVPr16PrF3tg9iqQ/LBqJqn1v+6tNXlpCy6/26/2eK3re9MwiM4JBAQzwrNZYeI
	BnhvBd7iPBIzuHH8wCji2PrQ4lyVRRKcwiSsfr32CdJAAHWqYZpOe3NxsU3UKT9C2ba1EXup1zA
	CGmV47wg2Pt+Ek3moDgri7ZD4Wt6ikuKp9zPa8DlFFptE5Jz6gqfC4iG/Kpe4zkLoP500atw==
X-Received: by 2002:a05:6a21:170b:b0:38d:f56f:cdbd with SMTP id adf61e73a8af0-395c3a0c964mr17838903637.1.1772570587858;
        Tue, 03 Mar 2026 12:43:07 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:562e:3a88:890e:9f53:fad:871d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c531sm15348524a12.24.2026.03.03.12.43.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 12:43:07 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v3 2/2] t3700: use test_grep helper for better diagnostics
Date: Wed,  4 Mar 2026 02:10:29 +0530
Message-ID: <20260303204029.52952-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
References: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'grep' and '! grep' invocations with 'test_grep' and
'test_grep !'. This provides better debugging output if tests fail
in the future, as 'test_grep' will automatically print the
contents of the file when a check fails.

While at it, update any remaining instances of 'grep' to 'test_grep'
that were missed in the previous versions to ensure that the entire
file is consistent with modern project style.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t3700-add.sh | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index c9ce2f758c..2947bf9a6b 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -39,7 +39,7 @@ test_expect_success 'Test with no pathspecs' '
 
 test_expect_success 'Post-check that foo is in the index' '
 	git ls-files foo >actual &&
-	grep foo actual
+	test_grep foo actual
 '
 
 test_expect_success 'Test that "git add -- -q" works' '
@@ -141,7 +141,7 @@ test_expect_success 'error out when attempting to add ignored ones but add other
 	git ls-files >files &&
 	sed -n "/\\.ig/p" <files >actual &&
 	test_must_be_empty actual &&
-	grep a.if files
+	test_grep a.if files
 '
 
 test_expect_success 'add ignored ones with -f' '
@@ -197,8 +197,8 @@ test_expect_success 'git add with filemode=0, symlinks=0, and unmerged entries'
 	echo new > symlink &&
 	git add file symlink &&
 	git ls-files --stage >actual &&
-	grep "^100755 .* 0	file$" actual &&
-	grep "^120000 .* 0	symlink$" actual
+	test_grep "^100755 .* 0	file$" actual &&
+	test_grep "^120000 .* 0	symlink$" actual
 '
 
 test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over stage 1' '
@@ -215,8 +215,8 @@ test_expect_success 'git add with filemode=0, symlinks=0 prefers stage 2 over st
 	echo new > symlink &&
 	git add file symlink &&
 	git ls-files --stage >actual &&
-	grep "^100755 .* 0	file$" actual &&
-	grep "^120000 .* 0	symlink$" actual
+	test_grep "^100755 .* 0	file$" actual &&
+	test_grep "^120000 .* 0	symlink$" actual
 '
 
 test_expect_success 'git add --refresh' '
@@ -241,8 +241,8 @@ test_expect_success 'git add --refresh with pathspec' '
 	test_must_be_empty actual &&
 
 	git diff-files --name-only >actual &&
-	! grep bar actual &&
-	grep baz actual
+	test_grep ! bar actual &&
+	test_grep baz actual
 '
 
 test_expect_success 'git add --refresh correctly reports no match error' "
@@ -258,7 +258,7 @@ test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unr
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
 	git ls-files foo1 >actual &&
-	! grep foo1 actual
+	test_grep ! foo1 actual
 '
 
 rm -f foo2
@@ -270,7 +270,7 @@ test_expect_success POSIXPERM,SANITY 'git add --ignore-errors' '
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose --ignore-errors . &&
 	git ls-files foo1 >actual &&
-	grep foo1 actual
+	test_grep foo1 actual
 '
 
 rm -f foo2
@@ -283,7 +283,7 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors)' '
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
 	git ls-files foo1 >actual &&
-	grep foo1 actual
+	test_grep foo1 actual
 '
 rm -f foo2
 
@@ -295,7 +295,7 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors = false)' '
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose . &&
 	git ls-files foo1 >actual &&
-	! grep foo1 actual
+	test_grep ! foo1 actual
 '
 rm -f foo2
 
@@ -307,7 +307,7 @@ test_expect_success POSIXPERM,SANITY '--no-ignore-errors overrides config' '
 	chmod 0 foo2 &&
 	test_must_fail git add --verbose --no-ignore-errors . &&
 	git ls-files foo1 >actual &&
-	! grep foo1 actual &&
+	test_grep ! foo1 actual &&
 	git config add.ignore-errors 0
 '
 rm -f foo2
@@ -317,9 +317,9 @@ test_expect_success BSLASHPSPEC "git add 'fo\\[ou\\]bar' ignores foobar" '
 	touch fo\[ou\]bar foobar &&
 	git add '\''fo\[ou\]bar'\'' &&
 	git ls-files fo\[ou\]bar >actual &&
-	grep -F fo\[ou\]bar actual &&
+	test_grep -F fo\[ou\]bar actual &&
 	git ls-files foobar >actual &&
-	! grep foobar actual
+	test_grep ! foobar actual
 '
 
 test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
@@ -337,7 +337,7 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
 test_expect_success '"add non-existent" should fail' '
 	test_must_fail git add non-existent &&
 	git ls-files >actual &&
-	! grep "non-existent" actual
+	test_grep ! "non-existent" actual
 '
 
 test_expect_success 'git add -A on empty repo does not error out' '
@@ -548,10 +548,10 @@ test_expect_success 'all statuses changed in folder if . is given' '
 		git add -A &&
 		git add --chmod=+x . &&
 		git ls-files --stage >actual &&
-		! grep ^100644 actual &&
+		test_grep ! ^100644 actual &&
 		git add --chmod=-x . &&
 		git ls-files --stage >actual &&
-		! grep ^100755 actual
+		test_grep ! ^100755 actual
 	)
 '
 
-- 
2.51.2

