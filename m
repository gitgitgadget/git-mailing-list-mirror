Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E392EE610
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766380; cv=none; b=J0yEDKJ2sVkYxkf+xeYlTmJ8pe8zzoXwJPcDaz9yMYceLc5ewl/y6ftczGmwuTcWewC2eF55iIW9cEBo5jtiz0mlZdmXsfw+nNkvBTyH+3xLN0g1oYHJSv3sdXTRHVbp5w/NcWY5gX3dexrF0BXj8I0PiVoZ1RIJcJ9UE5G/Jhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766380; c=relaxed/simple;
	bh=sy9p5K2F+64LJdJTFooSw3SIVZUvyv9y+Cq0GhgQxhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akjydPw7UHTdgHfag/IxRR7PCCOv4uU0vf221n0eGV+H6+NeY2XIFoDUw43B8bFpNrXV2WiEk2Y7H7IdXXO4sCQkPGRj0PZHktoThMIl42mNzssAu1Ecjba50g4xMIr6I3GcRuNhI/c0bp5q00owMPKUFuLxZ8MhyAmG00gWris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIz/Kgu+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIz/Kgu+"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4746fd4793so613758a12.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755766378; x=1756371178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO4lYYDyDYihGiwWPpdEPAyFxDEZQuaWfJuxpdUVhVQ=;
        b=QIz/Kgu+gT2iLu3eZ0TwmSXYdWRTDOYWDpIaFwbvdlHsZp7nYWVciVRG0w+vQ3Uly5
         RqCPvy/e5XQVasn9MDjKWhg4QMa4ph0CBgn09AxyCpWnAEUp3rrbsbiuBn67cPIg+uFF
         frJ6h6gDqYVEsdk2UlUoSWeM+IR0fn009gdKTZS6O8RkxI8D9J7QjwUaEMrBvEibCP4G
         E0OA4DaxCf3XWANef8R0DJdyxyLQzSDNJU8JYOXybOFOxs2zl3J30sTtmxLt2LM0VOVH
         5+v8MI9i80XDkPoysAReW//Nz/TF881rn24Li1DVEBrcWY7wUKBAUiQUTm6Vb4op5chm
         vnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766378; x=1756371178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO4lYYDyDYihGiwWPpdEPAyFxDEZQuaWfJuxpdUVhVQ=;
        b=ky8C6TjYK2u8431duAXO7OvsHeincLezMXNhioMw/fXknqor+am4QaEa5+bnXUMzta
         OtIPWH4NbR7Z3+WaiXfNpaAfLV2k5zK6uxQK7nrK/5mrmcuJ5k20aL71U5XVGfSkiJ4E
         7eR+HVQBdbn4l6ucOIWcgWTTxItAgCKdSp4fCo9pUp32DSWvDXIYgQP4wCSqM9l2VdeX
         qG+4NCoZ5uaCA1XmO3x5JWlCZtXWVoIfUfWTbG2etmBJMcGq2o7mn3pVbSwRw7PcwnND
         STL6T7HLZCujn/7i58Y2W0Ata04fR4BEa6wgmtCNimgapfS7qLwT/XmUS6pyTVfQvvMB
         Pj2w==
X-Gm-Message-State: AOJu0YxTBwuRw03aKwrc6BjNgy6HQYhxM803e31lfOK+SYWhJqVQzkoV
	98Vsn+D1oGecTeixYS5sL6RrLBFL9+tS2jw6WKOKJ604dEf7IpdoT2PQ7P5XSQ==
X-Gm-Gg: ASbGncs+XwqL4cMhK8y9IyGYPSz+r3c71m8TMp4cKrNzIxVbcNywMxO7m0cuFakzv9G
	u2aqFX4Nhmm85dn8BJbS8caEIm9URh7FFSeCASSqpK0jZTZiuKaC3vS5i7FXICpZELGgauhjc9H
	mRnjB8+UTWQFQZe1VYC7QMqzQzQpLd6XFy8aLZ0Ns6dTyVSItyWWH42p0OUSHgRmrtzXsCqTGFh
	t4J/6ZdQ1qq/vsnrmyphnQG0R4gJsD/rH9kvGNM+WlEUmEEcvGcGCeOfGrdBTqzLiMaFsUPK51G
	UuqYPbuiTkhsKKJ29HgGAhhb/s6Io4KpuFt24nNMIY7jy5i4cFt6rf+GLUdi6Fi/GDSvbe2MGoQ
	zJhRYezeHv6LX1pV7qgr6CpavyNl6oA==
X-Google-Smtp-Source: AGHT+IFukN1tnAcHn9vVdh25TuijgVfn76iCuazPc57O8SLcAMbCKlRPaYcv/YFL7QQiI2KE36N5Tg==
X-Received: by 2002:a17:903:246:b0:235:eefe:68f4 with SMTP id d9443c01a7336-245fedb418emr22547445ad.29.1755766377500;
        Thu, 21 Aug 2025 01:52:57 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7d7fsm48949525ad.80.2025.08.21.01.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:52:57 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 2/2] t: add test for git refs exists subcommand
Date: Thu, 21 Aug 2025 14:22:46 +0530
Message-Id: <20250821085246.929307-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821085246.929307-1-meetsoni3017@gmail.com>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new `git refs exists` subcommand must have identical behavior to its
predecessor, `git show-ref --exists`. To avoid duplicating the entire
test suite, refactor the existing tests into a shareable helper script.

Extract the tests for the `--exists` flag from `t1403-show-ref.sh` into
a new `show-ref-exists-tests.sh` helper. The command under test is
parameterized using the `$git_show_ref_exists` variable.

Source new helper to both `t1403-show-ref.sh` and the new test file,
`t1462-refs-exists.sh`, ensuring both commands are verified against the
same comprehensive test suite.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build              |  3 +-
 t/show-ref-exists-tests.sh | 66 ++++++++++++++++++++++++++++++++++++++
 t/t1403-show-ref.sh        | 66 +-------------------------------------
 t/t1462-refs-exists.sh     | 22 +++++++++++++
 4 files changed, 91 insertions(+), 66 deletions(-)
 create mode 100644 t/show-ref-exists-tests.sh
 create mode 100755 t/t1462-refs-exists.sh

diff --git a/t/meson.build b/t/meson.build
index baeeba2ce6..eed812a9b9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -211,6 +211,7 @@ integration_tests = [
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
+  't1462-refs-exists.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
@@ -1219,4 +1220,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/show-ref-exists-tests.sh b/t/show-ref-exists-tests.sh
new file mode 100644
index 0000000000..23b941d386
--- /dev/null
+++ b/t/show-ref-exists-tests.sh
@@ -0,0 +1,66 @@
+git_show_ref_exists=${git_show_ref_exists:-git show-ref --exists}
+
+test_expect_success '--exists with existing reference' '
+	${git_show_ref_exists} refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+'
+
+test_expect_success '--exists with missing reference' '
+	test_expect_code 2 ${git_show_ref_exists} refs/heads/does-not-exist
+'
+
+test_expect_success '--exists does not use DWIM' '
+	test_expect_code 2 ${git_show_ref_exists} $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME 2>err &&
+	grep "reference does not exist" err
+'
+
+test_expect_success '--exists with HEAD' '
+	${git_show_ref_exists} HEAD
+'
+
+test_expect_success '--exists with bad reference name' '
+	test_when_finished "git update-ref -d refs/heads/bad...name" &&
+	new_oid=$(git rev-parse HEAD) &&
+	test-tool ref-store main update-ref msg refs/heads/bad...name $new_oid $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	${git_show_ref_exists} refs/heads/bad...name
+'
+
+test_expect_success '--exists with arbitrary symref' '
+	test_when_finished "git symbolic-ref -d refs/symref" &&
+	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+	${git_show_ref_exists} refs/symref
+'
+
+test_expect_success '--exists with dangling symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	${git_show_ref_exists} refs/heads/dangling
+'
+
+test_expect_success '--exists with nonexistent object ID' '
+	test-tool ref-store main update-ref msg refs/heads/missing-oid $(test_oid 001) $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	${git_show_ref_exists} refs/heads/missing-oid
+'
+
+test_expect_success '--exists with non-commit object' '
+	tree_oid=$(git rev-parse HEAD^{tree}) &&
+	test-tool ref-store main update-ref msg refs/heads/tree ${tree_oid} $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	${git_show_ref_exists} refs/heads/tree
+'
+
+test_expect_success '--exists with directory fails with generic error' '
+	cat >expect <<-EOF &&
+	error: reference does not exist
+	EOF
+	test_expect_code 2 ${git_show_ref_exists} refs/heads 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success '--exists with non-existent special ref' '
+	test_expect_code 2 ${git_show_ref_exists} FETCH_HEAD
+'
+
+test_expect_success '--exists with existing special ref' '
+	test_when_finished "rm .git/FETCH_HEAD" &&
+	git rev-parse HEAD >.git/FETCH_HEAD &&
+	${git_show_ref_exists} FETCH_HEAD
+'
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9da3650e91..dbae82384b 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -228,69 +228,5 @@ test_expect_success 'show-ref sub-modes are mutually exclusive' '
 	grep "cannot be used together" err
 '
 
-test_expect_success '--exists with existing reference' '
-	git show-ref --exists refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-'
-
-test_expect_success '--exists with missing reference' '
-	test_expect_code 2 git show-ref --exists refs/heads/does-not-exist
-'
-
-test_expect_success '--exists does not use DWIM' '
-	test_expect_code 2 git show-ref --exists $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME 2>err &&
-	grep "reference does not exist" err
-'
-
-test_expect_success '--exists with HEAD' '
-	git show-ref --exists HEAD
-'
-
-test_expect_success '--exists with bad reference name' '
-	test_when_finished "git update-ref -d refs/heads/bad...name" &&
-	new_oid=$(git rev-parse HEAD) &&
-	test-tool ref-store main update-ref msg refs/heads/bad...name $new_oid $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
-	git show-ref --exists refs/heads/bad...name
-'
-
-test_expect_success '--exists with arbitrary symref' '
-	test_when_finished "git symbolic-ref -d refs/symref" &&
-	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
-	git show-ref --exists refs/symref
-'
-
-test_expect_success '--exists with dangling symref' '
-	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
-	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
-	git show-ref --exists refs/heads/dangling
-'
-
-test_expect_success '--exists with nonexistent object ID' '
-	test-tool ref-store main update-ref msg refs/heads/missing-oid $(test_oid 001) $ZERO_OID REF_SKIP_OID_VERIFICATION &&
-	git show-ref --exists refs/heads/missing-oid
-'
-
-test_expect_success '--exists with non-commit object' '
-	tree_oid=$(git rev-parse HEAD^{tree}) &&
-	test-tool ref-store main update-ref msg refs/heads/tree ${tree_oid} $ZERO_OID REF_SKIP_OID_VERIFICATION &&
-	git show-ref --exists refs/heads/tree
-'
-
-test_expect_success '--exists with directory fails with generic error' '
-	cat >expect <<-EOF &&
-	error: reference does not exist
-	EOF
-	test_expect_code 2 git show-ref --exists refs/heads 2>err &&
-	test_cmp expect err
-'
-
-test_expect_success '--exists with non-existent special ref' '
-	test_expect_code 2 git show-ref --exists FETCH_HEAD
-'
-
-test_expect_success '--exists with existing special ref' '
-	test_when_finished "rm .git/FETCH_HEAD" &&
-	git rev-parse HEAD >.git/FETCH_HEAD &&
-	git show-ref --exists FETCH_HEAD
-'
-
+. "$TEST_DIRECTORY"/show-ref-exists-tests.sh
 test_done
diff --git a/t/t1462-refs-exists.sh b/t/t1462-refs-exists.sh
new file mode 100755
index 0000000000..c00d76cc9e
--- /dev/null
+++ b/t/t1462-refs-exists.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='refs exists'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+git_show_ref_exists='git refs exists'
+
+test_expect_success setup '
+	test_commit --annotate A &&
+	git checkout -b side &&
+	test_commit --annotate B &&
+	git checkout main &&
+	test_commit C &&
+	git branch B A^0
+'
+
+. "$TEST_DIRECTORY"/show-ref-exists-tests.sh
+
+test_done
-- 
2.34.1

