Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEF182B7
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902083; cv=none; b=ekiraTvYXsABFU01CMD6ZqIOg+mp8oJXJSesbFqLekenB4B1O2ARJHlIYJDNjPpmHen34aKnA3uCfNvnLsd9WqqcKT0UvJxhV8DzsG3ic+c/N1ZSY/ZuvSyF5dgqQWnNWuG5iLu4kTfyNylIyp5HTZddZ7a4aNz82PEJgpw2zME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902083; c=relaxed/simple;
	bh=Fk3org8ob2+DsYjNJRM3mnODFJhxMU0EupnikhqaVoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfTsJxV2LOay2c+nqAgsAi3+o3+RCG41LlgIMceSZUJHw3YuCMbKuWzHPZDllcJb9CotMoBckfu9NEfEhZBFKWk+OFEkvvOABKnS/sRuBw3NYSzSTwq2xH5aUjGYAZG4BTVmLpfuvZ3lzYqyQHMNIqv/Ib2EhP92m1v+qSSh2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHvwlo2o; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHvwlo2o"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7387d4a334so2624327276.2
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902080; x=1747506880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyZUWpxOA0w/m3HAu94X0Qzo/P06I8mP7ft9DmnPbic=;
        b=fHvwlo2os33Yo0GOXwnKcB6KNMeiTmHuPFrJUjGAejO7gx17gjKrG9JOV+bQaLaDkv
         44gYt6v22L8XlPTZsMyxdcwriojMwli78l0MBFK92qPpQWzV30Ky3uDdT1TG+IcvJiW4
         NHQ5YMnxcDPEETrybfBXtK34bRRZi8pC1oK6W4nyCbG2OaFtH99QobdBENbQpeelon8H
         2cE+CTD+mR7SPOmJe/AkCHGspkjRxwjwOhhMgpn8Tp2P+lDOsFJSz88GJXsYwYhdY8q2
         t+t7PyYunlXX0QOaIs11dIqnUhLnu2bw0xsh9j6sujvIcu6GVEBua1RL4NbDv0U6a7Ie
         4SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902080; x=1747506880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oyZUWpxOA0w/m3HAu94X0Qzo/P06I8mP7ft9DmnPbic=;
        b=ce0gRum5CkibFTIRXivVR6RUaIwobxHrCMNxm+Ig5JhrWh2fzCPj/0JMkvr7638CHA
         PkYWlXcTYI/0u5uYAMQC2g8ggZ/+fAX1iAB1ORTfaMwhXaNq9lIbPChbzdPPt0Wy2AuT
         FAS+H1Wn9FtLBglZruVmfYMRNCAhEfx1jEsCZlKuLBudRCJJgPbWlrMmGhoXNwojoMD5
         MD/B71fKuAfJQd39gHIS8uzDBue+EzEvAbX0cf6W3+tsp5A1/+MUM+D8Q/Cr+uo+WRlC
         B74xPNHQ7Z3Dj88pv4MZ3jtX+M2wNkYmL+pfn4/UsY6M15QSLcR/cq5op3RHllOAhTuf
         xEfg==
X-Gm-Message-State: AOJu0Yx12k02pq/ozCi+sKLNmLMvJODWUV84XWVmLuYEqGJPlKtXIT8l
	BaEwul2uYh8OKBwZ11QLP/DEDVrvocw2ix63VU97L70MS2kAw2D2XAQZyyoW
X-Gm-Gg: ASbGncvio3fV2gnBQyTKC964rnphGFqQNs1Ex0BeSqWFCzgJWZzZPK9hpEnIpsvCCVl
	a1W+7bOxaE1Ono8/yWgsPpdFOS7isgUnriS1hgeo6rAaZM70LnrpDRmQkgLl2rbwI3sr104La9r
	83XPIw13DZnj18+VDd+TA/gWTfGIUTfnHOVSSErkncz8kn/GEYv41FrlxYjRHHoiIni0enBTQql
	T64605LVrIyMdJNiob8SDThFQAQBft0xD+G5eckPF8dgO+WOwNxqIMbjiqRObf6Hmf1oq+AWD3i
	/lxox6AFpPcesrpzHCznaGJZ8LziszUEPyNzCowd0dJiehih2g2Pe77iNnKi3zT8xh7LxizhmPm
	z33KSc6n+vkRqWiRO47/en2V9
X-Google-Smtp-Source: AGHT+IEG4yub/3mkYgKzpjP8UORQ6zkTePq13KLV7Ajcgn9+2v6yKDBVnFlZCFyA8gAmO9ghv/QTbg==
X-Received: by 2002:a25:a306:0:b0:e75:bd52:f14f with SMTP id 3f1490d57ef6-e78fdd2dd60mr7904893276.34.1746902079961;
        Sat, 10 May 2025 11:34:39 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:39 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Cai <johncai86@gmail.com>
Subject: [PATCH 6/9] t3903: adjust stash test to account for --[no-]index with breaking changes
Date: Sat, 10 May 2025 14:33:41 -0400
Message-ID: <20250510183358.36806-7-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few tests check the results of the index after applying a stash; with
breaking changes from previous commits that automatically restore the
stashed index, the expected values are wrong.

A few of the relevant tests check the restoration of <pathspec>s; with
the aforementioned breaking changes, things get more interesting. In
particular, if we "git stash push -- foo" but have "bar" in the index,
then when applying the stash we get a conflict: "bar" was not removed
from the index by the stash, but it was included in the recorded index
in the stash. In those cases, apply the stash with "--no-index" (which
would be the required user behavior).

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    It looks like the pathspec filtering is not applied to the stashed
    index; should it be?

 t/t3903-stash.sh | 158 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 147 insertions(+), 11 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b8936a653b..36e1d3ec08 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -99,7 +99,7 @@ setup_stash()
 	test_cmp expect file
 '
 
-test_expect_success 'apply stashed changes' '
+test_expect_success !WITH_BREAKING_CHANGES 'apply stashed changes' '
 	git reset --hard &&
 	echo 5 >other-file &&
 	git add other-file &&
@@ -111,6 +111,18 @@ setup_stash()
 	test 1 = $(git show HEAD:file)
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'apply stashed changes' '
+	git reset --hard &&
+	echo 5 >other-file &&
+	git add other-file &&
+	test_tick &&
+	git commit -m other-file &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
 test_expect_success 'apply stashed changes (including index)' '
 	git reset --hard HEAD^ &&
 	echo 6 >other-file &&
@@ -136,7 +148,7 @@ setup_stash()
 	test_must_fail git stash drop --foo
 '
 
-test_expect_success 'drop top stash' '
+test_expect_success !WITH_BREAKING_CHANGES 'drop top stash' '
 	git reset --hard &&
 	git stash list >expected &&
 	echo 7 >file &&
@@ -150,7 +162,21 @@ setup_stash()
 	test 1 = $(git show HEAD:file)
 '
 
-test_expect_success 'drop middle stash' '
+test_expect_success WITH_BREAKING_CHANGES 'drop top stash' '
+	git reset --hard &&
+	git stash list >expected &&
+	echo 7 >file &&
+	git stash &&
+	git stash drop &&
+	git stash list >actual &&
+	test_cmp expected actual &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_expect_success !WITH_BREAKING_CHANGES 'drop middle stash' '
 	git reset --hard &&
 	echo 8 >file &&
 	git stash &&
@@ -170,7 +196,27 @@ setup_stash()
 	test 1 = $(git show HEAD:file)
 '
 
-test_expect_success 'drop middle stash by index' '
+test_expect_success WITH_BREAKING_CHANGES 'drop middle stash' '
+	git reset --hard &&
+	echo 8 >file &&
+	git stash &&
+	echo 9 >file &&
+	git stash &&
+	git stash drop stash@{1} &&
+	test 2 = $(git stash list | wc -l) &&
+	git stash apply &&
+	test 9 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	git reset --hard &&
+	git stash drop &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_expect_success !WITH_BREAKING_CHANGES 'drop middle stash by index' '
 	git reset --hard &&
 	echo 8 >file &&
 	git stash &&
@@ -227,7 +273,7 @@ setup_stash()
 	test_cmp expect actual
 '
 
-test_expect_success 'stash pop' '
+test_expect_success !WITH_BREAKING_CHANGES 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
 	test 3 = $(cat file) &&
@@ -236,6 +282,15 @@ setup_stash()
 	test 0 = $(git stash list | wc -l)
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'stash pop' '
+	git reset --hard &&
+	git stash pop &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file) &&
+	test 0 = $(git stash list | wc -l)
+'
+
 cat >expect <<EOF
 diff --git a/file2 b/file2
 new file mode 100644
@@ -320,7 +375,7 @@ setup_stash()
 	test_must_be_empty output.out
 '
 
-test_expect_success 'pop -q works and is quiet' '
+test_expect_success !WITH_BREAKING_CHANGES 'pop -q works and is quiet' '
 	git stash pop -q >output.out 2>&1 &&
 	echo bar >expect &&
 	git show :file >actual &&
@@ -328,6 +383,14 @@ setup_stash()
 	test_must_be_empty output.out
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'pop -q works and is quiet' '
+	git stash pop -q >output.out 2>&1 &&
+	echo test >expect &&
+	git show :file >actual &&
+	test_cmp expect actual &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'pop -q --index works and is quiet' '
 	echo foo >file &&
 	git add file &&
@@ -1166,7 +1229,7 @@ setup_stash()
 	test_cmp expect actual
 '
 
-test_expect_success 'stash -- <pathspec> stashes and restores the file' '
+test_expect_success !WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes and restores the file' '
 	>foo &&
 	>bar &&
 	git add foo bar &&
@@ -1178,7 +1241,19 @@ setup_stash()
 	test_path_is_file bar
 '
 
-test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
+test_expect_success WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes and restores the file' '
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	git stash push -- foo &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop --no-index &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
+test_expect_success !WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes in subdirectory' '
 	mkdir sub &&
 	>foo &&
 	>bar &&
@@ -1194,7 +1269,23 @@ setup_stash()
 	test_path_is_file bar
 '
 
-test_expect_success 'stash with multiple pathspec arguments' '
+test_expect_success WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes in subdirectory' '
+	mkdir sub &&
+	>foo &&
+	>bar &&
+	git add foo bar &&
+	(
+		cd sub &&
+		git stash push -- ../foo
+	) &&
+	test_path_is_file bar &&
+	test_path_is_missing foo &&
+	git stash pop --no-index &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
+test_expect_success !WITH_BREAKING_CHANGES 'stash with multiple pathspec arguments' '
 	>foo &&
 	>bar &&
 	>extra &&
@@ -1209,7 +1300,22 @@ setup_stash()
 	test_path_is_file extra
 '
 
-test_expect_success 'stash with file including $IFS character' '
+test_expect_success WITH_BREAKING_CHANGES 'stash with multiple pathspec arguments' '
+	>foo &&
+	>bar &&
+	>extra &&
+	git add foo bar extra &&
+	git stash push -- foo bar &&
+	test_path_is_missing bar &&
+	test_path_is_missing foo &&
+	test_path_is_file extra &&
+	git stash pop --no-index &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	test_path_is_file extra
+'
+
+test_expect_success !WITH_BREAKING_CHANGES 'stash with file including $IFS character' '
 	>"foo bar" &&
 	>foo &&
 	>bar &&
@@ -1224,6 +1330,21 @@ setup_stash()
 	test_path_is_file bar
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'stash with file including $IFS character' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash push -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop --no-index &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash with pathspec matching multiple paths' '
 	echo original >file &&
 	echo original >other-file &&
@@ -1297,7 +1418,7 @@ setup_stash()
 	test_path_is_file untracked
 '
 
-test_expect_success 'stash without verb with pathspec' '
+test_expect_success !WITH_BREAKING_CHANGES 'stash without verb with pathspec' '
 	>"foo bar" &&
 	>foo &&
 	>bar &&
@@ -1312,6 +1433,21 @@ setup_stash()
 	test_path_is_file bar
 '
 
+test_expect_success WITH_BREAKING_CHANGES 'stash without verb with pathspec' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop --no-index &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
 	git reset &&
 	>foo &&
-- 
2.48.1

