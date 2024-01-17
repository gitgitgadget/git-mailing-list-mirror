Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0794224E4
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508139; cv=none; b=BzwUKnefyQqM6EE4exxemcuXIPuqom4bRp+LZ+/lgbxV6Gr8/N8I5M3b4ie0ApiX5F+yiZR2mii7MhKMAo9XvFYZ1+ewKdtHtD6tZujgdQV76dphYzKKvhxYqjB9BeqsAa7AFb2//UVjotHSLWi4z1ksXTg7rIUMqLnsgjCiMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508139; c=relaxed/simple;
	bh=/15dKvKus3Y/HzSE2QevkAnLzuNiUdnOtMpQetxFEqU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=gsNRwL1/mMa1FOttCUCpYtUG4rTkx6zjm/r5DFchcTJ5b4OVfnyHsFJ8JxqUNTVLSbUOkbl54TGrVrGEuQcyWKIUMTQSn3O5g9isazRp/c8i9UFTAiWGy0gRt1KnA+HGf8PR9H2kxx1LELrWG5jQinyW7JLBOaC1AhyG8+8uY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GySgSznQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GySgSznQ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so9820961b3a.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 08:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705508137; x=1706112937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYWkCcs3G+NscD9/yJoRAxN7h6q+7wxmS3x+caxSEiY=;
        b=GySgSznQkDVAREb51cDlpi0TYDLtJR2XdFy//jyZwUwkkKV/bDQ8xgIB57cB48OgOr
         rnlv9xztlGnV7NVZH0KOUA4rA9UVQpv28j5ir+trMBJtbkhYLULuh2aZUsrPmKMch9SD
         EIV1xaq6tRN/1IFX65f5lXX/6NkzyMtDFiF8EiDw/y5hIfMzvDouHMfEkz9wVJYLXQ/u
         ykvcBX/i+EDIEeZXJHTAni11c9xQxm0gdXLFykPSr1IijFcXpBZphpG4KUxReqSWJAu9
         R6Uzt/frsr1QMJP3DbGKIkrPpuFmMurggAxlGRLvsUdh4wJDHzzhtZYWkeiMppa1k69t
         ncVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508137; x=1706112937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYWkCcs3G+NscD9/yJoRAxN7h6q+7wxmS3x+caxSEiY=;
        b=jc6TX573FYMa/6/oxIqAq9f7XaKvlrr4GPbsWw+49tx1dB4pvFLfkNWn+Hoq2OCE67
         rPFe/pxh4CyOCb0nr/2pPLctBAS7npKLb7zf33x0Qwav4PfHOxrTubyxwQUcEgHNAYoc
         6/M3fx0ZWw+a3HnvOttEsUlDh71IbLUf9ussMvqkue7kdE3tN9Tb+IExB+TUooPBpWxV
         8/vWOvGUKLxIjehtPA5caL/xctFU9SsgFHZ4IhnSCjQUvaR17D+6VdZFoH+g0X3fAJC9
         s9J3Q60rPwMpHrxwBz1qNdrZYEjb3s75YglImXl+Uurg1Kca0Pnf+BdkFdX5tTH1b/Y5
         SS3A==
X-Gm-Message-State: AOJu0Yxq0vvAm/s8A9vtdFjq2SZqqkfsGcJMuPEY/sWs8VovR6nCI8Ur
	xEmMOHMZPbnGwTbIxW+v3zNkaIdc1wZ6TeKH
X-Google-Smtp-Source: AGHT+IFT9utQBgtKDV60rrZ8XvKuGSz9v+PI5ck+uQ6ifMVGR765lG3a0XUVNmcjEFGN49OgrBZctQ==
X-Received: by 2002:a05:6a21:a583:b0:199:afd6:2338 with SMTP id gd3-20020a056a21a58300b00199afd62338mr9895581pzc.43.1705508136681;
        Wed, 17 Jan 2024 08:15:36 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id sh2-20020a17090b524200b0028dfdfc9a8esm12634126pjb.37.2024.01.17.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:15:36 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v6 1/2] t7501: add tests for --include and --only
Date: Wed, 17 Jan 2024 21:43:54 +0530
Message-ID: <20240117161421.17333-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117161421.17333-1-shyamthakkar001@gmail.com>
References: <20240113042254.38602-1-shyamthakkar001@gmail.com>
 <20240117161421.17333-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for --only (-o) and --include (-i). This include testing
with or without staged changes for both -i and -o. Also to test
for committing untracked files with -i, -o and without -i/-o.

Some tests already exist in t7501 for testing --only, however,
it is only tested in combination with --amend and --allow-empty
and on to-be-born branch. The addition of these tests check, when
the pathspec is provided without using -only, that only the files
matching the pathspec get committed. This behavior is same when
we provide --only and it is checked by the tests.
(as --only is the default mode of operation when pathspec is
provided.)

As for --include, there is no prior test for checking if --include
also commits staged changes, thus add test for that. Along with
the tests also document a potential bug, in which, when provided
with -i and a pathspec that does not match any tracked path,
commit does not fail if there are staged changes. And when there
are no staged changes commit fails. However, no error is returned
to stderr in either of the cases. This is described in the TODO
comment before the relevent testcase.

And also add a test for checking incompatibilty when using -o and
-i together.

Thus, these tests belong in t7501 with other similar existing tests,
as described in the case of --only.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 75 ++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 3d8500a52e..c169f10458 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, -i and -o, test reflog,
+# FIXME: Test the various index usages, test reflog,
 # signoff
 
 test_description='git commit'
@@ -92,6 +92,34 @@ test_expect_success '--long fails with nothing to commit' '
 	test_must_fail git commit -m initial --long
 '
 
+test_expect_success 'fail to commit untracked file (even with --include/--only)' '
+	echo content >baz &&
+	error="error: pathspec .baz. did not match any file(s) known to git" &&
+
+	test_must_fail git commit -m "baz" baz 2>err &&
+	test_grep -e "$error" err &&
+
+	test_must_fail git commit --only -m "baz" baz 2>err &&
+	test_grep -e "$error" err &&
+
+	# TODO: as for --include, the below command will fail because
+	# nothing is staged. If something was staged, it would not fail
+	# even though the provided pathspec does not match any tracked
+	# path. (However, the untracked paths that match the pathspec are
+	# not committed and only the staged changes get committed.)
+	# In either cases, no error is returned to stderr like in (--only
+	# and without --only/--include) cases. In a similar manner,
+	# "git add -u baz" also does not error out.
+	#
+	# Therefore, the below test is just to document the current behavior
+	# and is not an endorsement to the current behavior, and we may
+	# want to fix this. And when that happens, this test should be
+	# updated accordingly.
+
+	test_must_fail git commit --include -m "baz" baz 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'setup: non-initial commit' '
 	echo bongo bongo bongo >file &&
 	git commit -m next -a
@@ -117,6 +145,51 @@ test_expect_success '--long with stuff to commit returns ok' '
 	git commit -m next -a --long
 '
 
+for opt in "" "-o" "--only"
+do
+	test_expect_success 'exclude additional staged changes when given pathspec' '
+		echo content >>file &&
+		echo content >>baz &&
+		git add baz &&
+		git commit $opt -m "file" file &&
+
+		git diff --name-only >actual &&
+		test_must_be_empty actual &&
+
+		test_write_lines baz >expect &&
+		git diff --name-only --cached >actual &&
+		test_cmp expect actual &&
+
+		test_write_lines file >expect &&
+		git diff --name-only HEAD^ HEAD >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success '-i/--include includes staged changes' '
+	echo content >>file &&
+	echo content >>baz &&
+	git add file &&
+
+	# baz is in the index, therefore, it will be committed
+	git commit --include -m "file and baz" baz  &&
+
+	git diff --name-only HEAD >remaining &&
+	test_must_be_empty remaining &&
+
+	test_write_lines baz file >expect &&
+	git diff --name-only HEAD^ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--include and --only do not mix' '
+	test_when_finished "git reset --hard" &&
+	echo content >>file &&
+	echo content >>baz &&
+	test_must_fail git commit --include --only -m "file baz" file baz 2>actual &&
+	test_grep -e "fatal: options .-i/--include. and .-o/--only. cannot be used together" actual
+'
+
 test_expect_success 'commit message from non-existing file' '
 	echo more bongo: bongo bongo bongo bongo >file &&
 	test_must_fail git commit -F gah -a
-- 
2.43.0

