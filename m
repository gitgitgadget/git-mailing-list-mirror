Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C411C298
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260331; cv=none; b=YH0OQJRoAUcFol94opYbBLRpdb8Q8SZDSEJw952JhafLCgxNtBnxw8SgIabRZHallHxO7oXC9eD9YSD0l1lR/b7tf+BEJOwf3XyK659w0mGlMDO4J+anS9nwU58FqUbS+poam+m6lmhOHtEv+owDxDaCJIaGEfPx+2WgaloxAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260331; c=relaxed/simple;
	bh=b3fk27teWiststUmEija90xdmCTRbA56x6SCLHNvUdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onR9WHWhrpRZD5RyOme5PeWh8C8TzdUG0t50qXx64lLFIwNzHi4N7VHDViDJM1kBmaJFTD61yv4xRCdULJrk7tVDSPj5KwflscvNMD+XJlPf7ppbSYN07e12rr8b3fp1w+hB69TLf4ZIRMGcBY0xma7Y+7npkFEKx+DHMZIbATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnptykJw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnptykJw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d780a392fdso438755ad.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 14:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707260329; x=1707865129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOuoOVAI5aayObgUcf6aL99zUPnQl4bECVX3RdqxgbQ=;
        b=ZnptykJwIT5YLWehki34x7yiOEjKOrf9+KA1/89eb3xhhxuFnvmqDUJ8yTJ7BjscYq
         gAGWjXjl64J+sG/BWbBJhz9GXmUXf2p0hMHcmyLM2pbbpKBTPI3R5mjL64PYw3s4IcUc
         b8db812CsUqi7hubzE9v0JZYEeAAl/+kjEUZAiGfb1ZK2P7Tfe0c6ebRbjGUuLqjSZw9
         PXByZEkmVr91QUaijCmFAULGFFuhhZObW0YQXxQ9sRr77Kw17lq8eImS1yuoBt8bMz0p
         BZGwPCkeIkYC5fjUcJor+7n9eKJc33qbO6yVTmCz2FmSEe6scVB6hZwLbnjJHXRC/a4d
         RHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707260329; x=1707865129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOuoOVAI5aayObgUcf6aL99zUPnQl4bECVX3RdqxgbQ=;
        b=QBubW35EdhEXMLCeh4q5/zekeOMXt4NkYKbxLA9xtwjtExu9IACGMBennMhogYhlTs
         jE8qqHNBe7sy9Lg9RUdLoFeDAz0KV5XbW0KtyuZqeRTjml+RZnmI+BmKB2+fREBbN5Eq
         a1lKoDhfL34lnBF6kpbqE/TL/ReF0TfJmoc7jOhs55zACxSAaIhLr1G5ixTvkOUJFlhK
         cpkVzF47xdU+A0w4GK6SxtAeoJXiC2RnspFdI1AcdoUTHFsfvB8qjuz9EUFlP6etVTbo
         DuM9mLeW86AuGNHzIj42MFL6DM2ffFe6QQXydtj61acw8DuTWYMGnbuZo3i7wN1mKzJR
         qfvA==
X-Gm-Message-State: AOJu0YwWGYXiYs4l9F9tCy7RQWDf9YGYZUVJX72GccSWTOMxZgvVwQJX
	+0PPoczeAvnHx6TOlqE3J25z5Aul88aKNxznjLU0cO8H7Ls492tazTg7z55J
X-Google-Smtp-Source: AGHT+IF4C21ccUujVW5QULPXIVuV7m1oSRnlzs/+Cj62b4QvHVbu6tAbXiP/VQAx8qrTMhREzc7xrw==
X-Received: by 2002:a17:90a:ff95:b0:290:f5db:c4ad with SMTP id hf21-20020a17090aff9500b00290f5dbc4admr940567pjb.46.1707260328985;
        Tue, 06 Feb 2024 14:58:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX07OHuiSCmHjgejzNKVwszW6xdop7t9di1AWtSJY+AGqE2IYX5elnDZKNln9g+gLAUfOs6Nhe1K1DNGo1WH6cXvfXsNC+2H+A0QtoEANV6p32m01C5qe2Q2XP2OjPyvIby6iB8uVDMZh9iQYciNSs=
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090aca1400b00290f9e8b4f9sm46741pjt.46.2024.02.06.14.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 14:58:48 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v4 2/3] add-patch: classify '@' as a synonym for 'HEAD'
Date: Wed,  7 Feb 2024 04:20:38 +0530
Message-ID: <20240206225122.1095766-6-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203112619.979239-2-shyamthakkar001@gmail.com>
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, (checkout, reset, restore) commands correctly take '@' as a
synonym for 'HEAD'. However, in patch mode (-p/--patch), for both '@'
and 'HEAD', different prompts/messages are given by the commands
mentioned above (because of applying reverse mode(-R) in case of '@').
This is due to the literal and only string comparison with the word
'HEAD' in run_add_p(). Synonymity between '@' and 'HEAD' is obviously
desired, especially since '@' already resolves to 'HEAD'.

Therefore, replace '@' to 'HEAD' at the beginning of
add-patch.c:run_add_p(). There is also logic in builtin/checkout.c to
convert all command line input rev to the raw object name for underlying
machinery (e.g., diff-index) that does not recognize the <a>...<b>
notation, but we'd need to leave 'HEAD' intact. Now we need to teach
that '@' is a synonym to 'HEAD' to that code and leave '@' intact, too.

There is one unintended side-effect/behavior change of this, even if
there exists a branch named '@', when providing '@' as a rev-source to
(checkout, reset, restore) commands in patch mode, it will consider it
as HEAD. This is due to the behavior of diff-index. However, naming a
branch '@' is an obvious foot-gun and there are many existing commands
which already take '@' for 'HEAD' regardless of whether 'refs/heads/@'
exists or not (e.g., 'git log @', 'git push origin @' etc.). Therefore,
this should be fine.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 add-patch.c               |  4 ++++
 builtin/checkout.c        | 11 +++++-----
 t/t2016-checkout-patch.sh | 46 ++++++++++++++++++++++-----------------
 t/t2071-restore-patch.sh  | 18 +++++++++------
 t/t7105-reset-patch.sh    | 10 +++++++++
 5 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 68f525b35c..6f4ca8f4e4 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1726,6 +1726,10 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 
 	init_add_i_state(&s.s, r);
 
+	/* helpful in deciding the patch mode ahead */
+	if(revision && !strcmp(revision, "@"))
+		revision = "HEAD";
+
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
 	else if (mode == ADD_P_RESET) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a6e30931b5..79e208ee6d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -539,12 +539,13 @@ static int checkout_paths(const struct checkout_opts *opts,
 		 * recognized by diff-index), we will always replace the name
 		 * with the hex of the commit (whether it's in `...` form or
 		 * not) for the run_add_interactive() machinery to work
-		 * properly. However, there is special logic for the HEAD case
-		 * so we mustn't replace that.  Also, when we were given a
-		 * tree-object, new_branch_info->commit would be NULL, but we
-		 * do not have to do any replacement, either.
+		 * properly. However, there is special logic for the 'HEAD' and
+		 * '@' case so we mustn't replace that.  Also, when we were
+		 * given a tree-object, new_branch_info->commit would be NULL,
+		 * but we do not have to do any replacement, either.
 		 */
-		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
+		if (rev && new_branch_info->commit && strcmp(rev, "HEAD") &&
+		    strcmp(rev, "@"))
 			rev = oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid);
 
 		if (opts->checkout_index && opts->checkout_worktree)
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 747eb5563e..c4f9bf09aa 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -38,26 +38,32 @@ test_expect_success 'git checkout -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success 'git checkout -p HEAD with NO staged changes: abort' '
-	set_and_save_state dir/foo work head &&
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_saved_state dir/foo
-'
-
-test_expect_success 'git checkout -p HEAD with NO staged changes: apply' '
-	test_write_lines n y y | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
-
-test_expect_success 'git checkout -p HEAD with change already staged' '
-	set_state dir/foo index index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git checkout -p HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head head
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success "git checkout -p $opt with NO staged changes: abort" '
+		set_and_save_state dir/foo work head &&
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_saved_state dir/foo &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with NO staged changes: apply" '
+		test_write_lines n y y | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+
+	test_expect_success "git checkout -p $opt with change already staged" '
+		set_state dir/foo index index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git checkout -p $opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head head &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success 'git checkout -p HEAD^...' '
 	# the third n is to get out in case it mistakenly does not apply
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index b5c5c0ff7e..dbbefc188d 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -44,13 +44,17 @@ test_expect_success PERL 'git restore -p with staged changes' '
 	verify_state dir/foo index index
 '
 
-test_expect_success PERL 'git restore -p --source=HEAD' '
-	set_state dir/foo work index &&
-	# the third n is to get out in case it mistakenly does not apply
-	test_write_lines n y n | git restore -p --source=HEAD &&
-	verify_saved_state bar &&
-	verify_state dir/foo head index
-'
+for opt in "HEAD" "@"
+do
+	test_expect_success "git restore -p --source=$opt" '
+		set_state dir/foo work index &&
+		# the third n is to get out in case it mistakenly does not apply
+		test_write_lines n y n | git restore -p --source=$opt >output &&
+		verify_saved_state bar &&
+		verify_state dir/foo head index &&
+		test_grep "Discard" output
+	'
+done
 
 test_expect_success PERL 'git restore -p --source=HEAD^' '
 	set_state dir/foo work index &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 05079c7246..7147148138 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -33,6 +33,16 @@ test_expect_success PERL 'git reset -p' '
 	test_grep "Unstage" output
 '
 
+for opt in "HEAD" "@"
+do
+	test_expect_success "git reset -p $opt" '
+		test_write_lines n y | git reset -p $opt >output &&
+		verify_state dir/foo work head &&
+		verify_saved_state bar &&
+		test_grep "Unstage" output
+	'
+done
+
 test_expect_success PERL 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
-- 
2.43.0

