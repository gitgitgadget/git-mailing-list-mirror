Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504864;
	b=sgwTfueunXz8CiWMkjBtulAyIfPAciStEEJJ3c/gRLSpoEUUbdUjAfjE/DotiFWvVo5v
	 L8KooFX97fjmCLu6hLeKZN5SRQR2GIsYCMshpnf7MWzCAaZSt4GiiY8vZLX1eBsogpPID
	 CjE8iOsWIY2t/DN1M/25zDn7kx4Ye4HvAs7s/hpu3QPf2tFihyCz42or7FGhIkvjb/0Kv
	 R/66FI+HOv87z9BZtAa3siRjHAFgNaIkr4d+441m86QCZDVwTqW0iv7ZY8haMynWOLovJ
	 wRtAilqGgRX2ceWmH4HouqBeVYpw41NzDlseujWbsLREDa6T5zuNaMvrUFr9LaYlrIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SNp199k6THpYZNFCYjXnanj5PCJQvo3lmwZjI0V1f1U=;
	b=5kS7KFsO/M8yLu4qy/rq6ghj+l7NUV50sOQ7vLbwNUtdkr4BDU0kQXSyMJi/THpDMRvd
	 +D+w0YibwlOM8Br+38ZWp4Iuzlaqm3i/5qetooZoOj/nj9hR1Qy8NdZ9+8HhEdcfyaIDZ
	 0K+jPerz7dEUYpG6hRBpr5zuRK+XyaihmLmAwIzMUok4rsgzX55kPklQLjSxlmxDjcF6o
	 fqB4lF9akzPODc7wIGBuKUIcJGUV5Zi4JpTj2Mw6PN+Sg/YwYvxqOICe3z1iFfXfY7tyg
	 6ObvqLCwQKF2SSK/eJjZ3yL8ZlchPTMFtRl2z8tqH/DhyFJ/TJ3mqZPskamDmckHE3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yfSOQ8r/";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C4606A232
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16C4606A232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yfSOQ8r/
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-491971ac844so1710f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504862; x=1795109662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNp199k6THpYZNFCYjXnanj5PCJQvo3lmwZjI0V1f1U=;
        b=yfSOQ8r/f6gN4hVb5QH/TmdfFPTT+CRmxvKwOjkTT/2JxV9au5YW3n5w7UEWuqn2/R
         6oP0JT+xmc96XFOcpWR5oLmZqye+otDFbDCbpWDkCV8X47C0UdBYLHoxJJx/MsvhGKkX
         vIwgC7n5fQi23Kb/hdbEb0hKL2sK8jhCQtmiN1QyNROuw2EOfBL/XC7qNQjgnGvWCQSh
         kFgb63HqbE+7BNqrgx1k5DOosdimQlxeMEy1db0wTbuezMf14FewjC15n+8uFopCEdzP
         8EfvmXGRGmHOYYqgWzMaGs99qT9sV5dlMEcD7Sqq4c8h5idHCctCViTLY942Y6h/e3oy
         oCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504862; x=1795109662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SNp199k6THpYZNFCYjXnanj5PCJQvo3lmwZjI0V1f1U=;
        b=T8yM7xxBjsinPMYMw5YNCRX9/qwbk5Dj4N2CyY5UsbdmBA2kEoVHeiIdPO+Fm1/yVM
         FbnB0J/feH5EgdFuvyOFRveYCyrOL1zN8QWwmnkg0v/yIeqWB6ndVfr4jA1nqD226JHB
         rhL8Vqeer4wKc81QGCcIlmFXAe/e0VMf3QS3hWyWGgmqaNY8S7oMvPZlK1UYfDcBeJ/w
         Vo5tlcfBL3J+Dz21iTyZO7/NOPVUXiE9t3Hx+LWVrlW0XhxwhDAYTRvrVnJ9m1jmQqdu
         L5WZKtlrzhEfS+H8w4HKy/d1Gc6xm5KwkzDVkTnsfX7tvYpVWy4T5QfDZKVZdHBkLmsa
         fAQA==
X-Gm-Message-State: APuU4Z9oBjnWCxV1r8s9N0KNP42w3wNwqWj+QF5jjyEIqCjxmuBxzBop
	Ec8xGeXo3i58QWAiSj98JHfzjsvymRS+JMON4lQGJ9OTWEiTU9HJFNgAPReysg==
X-Gm-Gg: AYBFou0ffrWLwRT3Dd6HE5+p3Xj1PVPM2yWz2kWFwTr3COHtTeXJxmnK39/mAI0dNdB
	4cdwzd/EhbJTYq7HTm3vqDORIXZnY2aNiCxcK0Dh9JYV/Ie3FG5Y3qWH6ZzuvbLyopwoWv4gW3h
	MUMpSdBH5qNCjtp3p6J+2K6q2pU40M0jq5hniPWVKLuI1Onvd0E6Y5q4ZXI6Jdrq6riILzLtA+I
	aeQu7ymuRdwGCvXMYB5XOi29Jxufi7g5aPFWUmpscnYAyS+WUdr7uH8AMLSClq4mx7iWC7E/+1X
	zsy+gTiX363oPpOZtwTCOhIGbVE/iCG0vv8+Lb2oNet5WAwVCpws1wtUbw9uy+6MCyrKl2ZXyyg
	zfXhAToReYAHxrVlcZ9TGfBablHpfVCVtKLzf27x3qBUhNN1joPPu4YnlZPehwKhpShTNkUaCU7
	m80FeIGPqXK5levtC+piT9yKfJGpdSMg159oArriwXaJ2fJiysW3pgkSjoiVd/7Lj3i099uqPgK
	2cdK5uVn/E0GUHGGWkjCdbBJ1LZ4FY1/jW81EaP9Bue6sqhgWdbzc2t9tKcpUZ/sypi44d8kqTI
	YF3hf63F7NT1iDaBQeWp0XKj6Zs7blZ5l/o3f06zlIssDnjZ6mMZf38S73qrSufV8LfC
X-Received: by 2002:a05:6000:4553:b0:499:27eb:ab19 with SMTP id ffacd0b85a97d-49c727d2112mr87856f8f.35.1794504862377;
        Thu, 12 Nov 2026 09:34:22 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:21 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:10 +0100
Subject: [PATCH v2 10/20] t9300: make the ref update tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-10-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7807; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=U2ahtaeM9dUw0LqwYBLr3U/M7nRiXw9TEZoXq9yeQMg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JEEAzoCg+rvSnXq5QyYqc425EolNAran
 /qDmYB7dppak4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiRAAoJED7VnySO
 Rox/5/oMAJo7Ml4hFcPsljv48riXVEiy91B4mkScdlS/GnwH7nKmRSHUjXmxMD9kDlh5VYuhToc
 JJMVxtU/5LWd9X6ZaOWbkcWTp+CS2MguQ3nPAERzcIRVvBoPLK9Ve8fGP8HcvImG1MLEYdBQ05l
 IvTmeiX5q8elRf33X1Atolm5line5wWb++xdXBnH/d0juAlJZgPVyB4l/14IjzgDVxtjTpet/+t
 Hk77r5fPJOimrx/E6xVNa7Adsz4EDfaYFYvsdmIdiITmtIOF1adG9yLGCY2XzG/DsKranQdsFns
 9z6pvoKpspT7kwRDg3hHS6dJ5LG3tEhYfKSTDNo5Y+eW4LC20YI+YmdK3lAkqGzW3Xh4eMWP6rO
 +1HKIKuAXkls74t//GhuMUvmCTM847+xCoMVbO0Rxh9srh4AO3cgaSf8VYHDUtZBvKYOdwE+4CU
 MP4Fl3kjyCp2wVZWJ6kFuSLChGZS5nKQhSTA2U2KRUJ3VymHSOI3K4ubCGugLVBzqK2SdKDAEc6
 BE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the reference update tests in
series 'F', 'G', 'J' and 'K' to make them independent of state from
previous tests. Add a 'setup_two_commit_repo()' function which creates
a repository with two commits on 'main', so each test can invoke it.

Fold the tests which only check the result of an import into the tests
performing it, as they can't run on their own. As
'fastimport.unpackLimit' is no longer set by an earlier test, set it for
the 'F' and 'G' imports so that a pack is written, and verify it with an
inline loop in place of 'verify_packs()'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 214 +++++++++++++++++++++++++++----------------------
 1 file changed, 119 insertions(+), 95 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2231e1bdab..446cf0c51a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -865,43 +865,53 @@ test_expect_success 'E: verify commit' '
 ### series F
 ###
 
+setup_two_commit_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo one &&
+	test_commit -C repo two
+}
+
 test_expect_success 'F: non-fast-forward update skips' '
-	old_branch=$(git rev-parse --verify branch^0) &&
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/branch
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	losing things already?
-	COMMIT
+	setup_two_commit_repo &&
+	(
+		cd repo &&
+		old_branch=$(git rev-parse --verify main^0) &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/main
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		losing things already?
+		COMMIT
 
-	from refs/heads/branch~1
+		from refs/heads/main~1
 
-	reset refs/heads/other
-	from refs/heads/branch
+		reset refs/heads/other
+		from refs/heads/main
 
-	INPUT_END
+		INPUT_END
 
-	test_must_fail git fast-import <input &&
-	# branch must remain unaffected
-	test $old_branch = $(git rev-parse --verify branch^0)
-'
+		test_must_fail git -c fastimport.unpackLimit=0 fast-import <input &&
+		# branch must remain unaffected
+		test $old_branch = $(git rev-parse --verify main^0) &&
 
-test_expect_success 'F: verify pack' '
-	verify_packs
-'
+		for p in .git/objects/pack/*.pack
+		do
+			git verify-pack "$p" || return 1
+		done &&
 
-test_expect_success 'F: verify other commit' '
-	cat >expect <<-EOF &&
-	tree $(git rev-parse branch~1^{tree})
-	parent $(git rev-parse branch~1)
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		cat >expect <<-EOF &&
+		tree $(git rev-parse main~1^{tree})
+		parent $(git rev-parse main~1)
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	losing things already?
-	EOF
-	git cat-file commit other >actual &&
-	test_cmp expect actual
+		losing things already?
+		EOF
+		git cat-file commit other >actual &&
+		test_cmp expect actual
+	)
 '
 
 ###
@@ -909,28 +919,31 @@ test_expect_success 'F: verify other commit' '
 ###
 
 test_expect_success 'G: non-fast-forward update forced' '
-	old_branch=$(git rev-parse --verify branch^0) &&
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/branch
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	losing things already?
-	COMMIT
+	setup_two_commit_repo &&
+	(
+		cd repo &&
+		old_branch=$(git rev-parse --verify main^0) &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/main
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		losing things already?
+		COMMIT
 
-	from refs/heads/branch~1
+		from refs/heads/main~1
 
-	INPUT_END
-	git fast-import --force <input
-'
+		INPUT_END
+		git -c fastimport.unpackLimit=0 fast-import --force <input &&
+		# branch changed, but logged
+		test $old_branch != $(git rev-parse --verify main^0) &&
+		test $old_branch = $(git rev-parse --verify main@{1}) &&
 
-test_expect_success 'G: verify pack' '
-	verify_packs
-'
-
-test_expect_success 'G: branch changed, but logged' '
-	test $old_branch != $(git rev-parse --verify branch^0) &&
-	test $old_branch = $(git rev-parse --verify branch@{1})
+		for p in .git/objects/pack/*.pack
+		do
+			git verify-pack "$p" || return 1
+		done
+	)
 '
 
 ###
@@ -1042,42 +1055,50 @@ test_expect_success 'I: export-pack-edges via stdin' '
 ###
 
 test_expect_success 'J: reset existing branch creates empty commit' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/J
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	create J
-	COMMIT
+	setup_two_commit_repo &&
+	(
+		cd repo &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/J
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		create J
+		COMMIT
 
-	from refs/heads/branch
+		from refs/heads/main
 
-	reset refs/heads/J
+		reset refs/heads/J
 
-	commit refs/heads/J
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	initialize J
-	COMMIT
+		commit refs/heads/J
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		initialize J
+		COMMIT
 
-	INPUT_END
-	git fast-import <input
-'
-test_expect_success 'J: branch has 1 commit, empty tree' '
-	test 1 = $(git rev-list J | wc -l) &&
-	test 0 = $(git ls-tree J | wc -l)
+		INPUT_END
+		git fast-import <input &&
+		# branch has 1 commit, empty tree
+		test 1 = $(git rev-list J | wc -l) &&
+		test 0 = $(git ls-tree J | wc -l)
+	)
 '
 
 test_expect_success 'J: tag must fail on empty branch' '
-	cat >input <<-INPUT_END &&
-	reset refs/heads/J2
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >input <<-INPUT_END &&
+		reset refs/heads/J2
 
-	tag wrong_tag
-	from refs/heads/J2
-	data <<EOF
-	Tag branch that was reset.
-	EOF
-	INPUT_END
-	test_must_fail git fast-import <input
+		tag wrong_tag
+		from refs/heads/J2
+		data <<EOF
+		Tag branch that was reset.
+		EOF
+		INPUT_END
+		test_must_fail git fast-import <input
+	)
 '
 
 ###
@@ -1085,29 +1106,32 @@ test_expect_success 'J: tag must fail on empty branch' '
 ###
 
 test_expect_success 'K: reinit branch with from' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/K
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	create K
-	COMMIT
+	setup_two_commit_repo &&
+	(
+		cd repo &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/K
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		create K
+		COMMIT
 
-	from refs/heads/branch
+		from refs/heads/main
 
-	commit refs/heads/K
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	redo K
-	COMMIT
+		commit refs/heads/K
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		redo K
+		COMMIT
 
-	from refs/heads/branch^1
+		from refs/heads/main^1
 
-	INPUT_END
-	git fast-import <input
-'
-test_expect_success 'K: verify K^1 = branch^1' '
-	test $(git rev-parse --verify branch^1) \
-		= $(git rev-parse --verify K^1)
+		INPUT_END
+		git fast-import <input &&
+		# K^1 = main^1
+		test $(git rev-parse --verify main^1) \
+			= $(git rev-parse --verify K^1)
+	)
 '
 
 ###

-- 
2.56.GIT

