Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311411;
	b=hrskCL2peXzb0vLN1cEYuIYeEAeIZ7qHODPOKkVLm5Xg+ZxqyvGL2fjd50xfWFQA8WXK
	 W1Puf+kBKBVkXL60/R3A6EEdCXj6NHvsPivci8QCC+q+H47bRFyFMTuRb9o8D52h7Yxb8
	 hDR7SwJFFbOextq8sk94/ZzQzzKMkbFQnt27Z8rkyeRaTH1Y4XYp6h3WyywE6zjkGW2IU
	 oxcQUzcX60FF66AJy1tKlQ2OTwPv8/8s5rZwS9wszbV13GHmszGoFpg+Vt7Wch7XaNwX7
	 oOgQIheEWyf/uMDJiMJMGH9J0gMVRAS5daZPOtBPElkfvLnO+o0vOUU9jE77s55iP9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=btFugKsi5lpZ4A8iXSm0xnI2cqo5wooSJ5xEUu5v270=;
	b=SE33RA61VBYunT+EiznrHp2eTE0fmuOH73x9prm+g7BkL7n+VZRSxFrHhXSj/1610fY1
	 rBUlAhq+foVsj16hXrxlpWJfA6VZ6A2qMaKi414H21Wx+mUqDEHpBcoALcw6/dQ7SdgVH
	 JgcaF5Ym1tqDQ2CMtXMUsdMAvwmpvhwtk7T7S6P5Fl8OX1ev3LAMMYrySW3s8O9lR1AZp
	 s5ISTkamk67do/N0tvnETI64sc9nc5pPT3uTBsek7n1R2JnyQm9viv5kJMfB4SxSIn+vM
	 2a0QlvNMaClG5FyG5qObkG6pJCrfuYm8XpVdz/sTRltRojam5KgXS3kEaAXDs2CRhEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUA56EGK;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B1606A9AD
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 627B1606A9AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vUA56EGK
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so16236815e9.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311410; x=1794916210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btFugKsi5lpZ4A8iXSm0xnI2cqo5wooSJ5xEUu5v270=;
        b=vUA56EGK7r3cHM+ZBBC+CQc2BxmNAT7IPs2uYAmC27ftszKW1pTTA7jIpWrAimPJPO
         QdHQmyh7z34c5xd91NEgJ63iwx9E8LMngf1rmhrbIPdVSfCsv7Cx6ko2zVy6vc719kmM
         6vjsrPjMTFgJY1Y1bAU6saFKJT+erLuS9zZndQRGrrBMXFeIbnK/noNEFegSINbMzLmj
         EBGiH1H5+Wh4/wq28Q5xuZrbKt0o1tUjH3B8ByXQL0YsxshDH+KMwX3mP+X/ohPHwAxD
         m+98U6xKD8crFqyEhO5fx4XShr0gP/C2LdWSV/sLxDjdRsNxgZdZcjJ3qjmL7z0ERR/i
         +zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311410; x=1794916210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btFugKsi5lpZ4A8iXSm0xnI2cqo5wooSJ5xEUu5v270=;
        b=CfVynpqJJLvnbai9ru/iEx/RvE13W1kIoyEwjETasBPyKw7A6UYdHr7qlL+6enDmHw
         35qkOMtLBPgmdEf9DKiTfArx5i/nDNIve5/kZnA7JSqOlz4MkPyP6keG7YFqK8I1lNDs
         a8Dx1K3Dqbx+f9WaVVrXaUNjYUmiMUBcn1QgWjvs5eSui98uTvR3jy2ViyVZAodzQcRv
         1tmHYp4+V+1FBhbt9/hr7t3rkPoy6xGhuhUxUrG1BAs79l1/2FoqcVQrl2cj1f9hzngg
         fG6P8sUxYezEHQkERqdaXgpJ9Tmag3Fz1G1rg/nR/TYMqzacRLAllofK7SbysOohQ84y
         PVjA==
X-Gm-Message-State: APuU4Z/Y0Z+1p+6YoNhUWTh7zX4SaE3xcb+sOix3OxCAZjxbudJSIVUZ
	w8nWUWEwmzhYlcjOI86p4UUxBi7gbsItPHYNCjfWB56CJgdlG7tQQ30I9zQnlA==
X-Gm-Gg: AYBFou3jSFTwXSAzTL6HggTpwEeagdFI+i3Aa+cxKHh3vt5vnqQyOjCLjk/Av2TcitD
	FX+l69ridi1lM5t7uMeiJPswtu/bFxYpVgC41EVFi7OPkYHz/3P9NB7zkTdYnHQVH/m7RdPWE9h
	rEoy/vzDoUkZr0m/Y/LDE55nc6HkzQ8mUk4z7kSoKWF2n6gLdueCgASm1UMa3mLfvmRuOi5eWle
	ONBW81wa8WlXUSOAncAulmhx5XzT3WPMVWkpYn95JMgqbDbi4sls+GqVyGr/Z1xWEjkjT5x1Pkq
	JGBV1ImGtoKT75RV4yZ/olC0upeADDSAesRi3l7S+Q55GA8Hi4ptlUAZZewu+CQ33FpDi3iIBK1
	p/IAW7FEMet4W9vwv3oEZeoDHHD1GqU6tyqMiBHYfPzZnk3vOP7G4hRaaTkSHivJndar7oeIRCl
	nBrznkNdakqPokmbaPUt4GT3sYznUAsKI454BcvhJtkrP8Qa0X2hk23GIgR790Gv8XaA6DYV358
	vc2+w01/pgcYPYZFtBtqe6/heppts8MyFTO4R0QIXpNJ5J2D3shOb4tdQgC47ROyzQugV1tMn8K
	SSwezzN1PQyWiyWVbdA+0m99Noh86YeW2UmeD6SzOLi7kef/Os3qyPE7fjNn/h91Nkg=
X-Received: by 2002:a05:600c:64c8:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4ba02343ac3mr37686875e9.16.1794311409512;
        Tue, 10 Nov 2026 03:50:09 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:52 +0100
Subject: [PATCH 07/20] t9300: make the series P tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-7-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7387; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=N4QOqMki0vlWavobJFf6TrpokR7q8nXlEYEwU0RZqTg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBObHhm72IfLTx48swQKKyARNLDTTd0UO0
 Ip9XI51gzFPJokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTmAAoJED7VnySO
 Rox/FukL/j0SNs953XyAVnkeLrO81wEQa9javA1xQeQzFoat3T1fUqSeYLDGvvZhUgxXzI0KnIn
 F5O14fJse1D2uPooC4fzCGRieEdGh0WIe0F9AEWIgVXMEmEV4uwAZvKahotdK/cI2MGIuwu8iMa
 d3TqsPRK3VXCrEuOJl9GCtgjFi4bmn2iZqE3c+6xWq+TYdC3L977NHjgkkxaIMWedrHY3WmJPif
 sJSySZBzm+ElIDh9vJtES0caTi+I3+rhDrFacSV3RnYA0W7RS3V/4omxAGXCeZMy2+ulw1f2Eb3
 ipfIfPM9stQry7tIPL+wZy7bl/oUfDx4xJ4cPUfB+L7zqvTmCCLm2DB6FaO5MJ46j3Kw5QEAGIO
 OLWuJ91k5DRq4UvOJ8Ndp4sW0OI8ytG9ajcPtq6gOyVv+PhzKe8icVpXfyb/jLaxa9McH+kfqhf
 r4iEHnz+WjWx/N88zZwufV+2KrepOcNnOuoGnZt+JgHmE6iiXMMYKRORkoITSU027xMa2kaV7j7
 0M=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series P' to make
them independent of state from previous tests.

Move the setup to a 'setup_gitlinks_repo()' function, so each test can
invoke it.

The 'fail on inline gitlink' and 'fail on blob mark in gitlink' tests
create their commit on top of 'subuse2', which is only written by the
'verbatim SHA gitlinks' test. Use 'subuse1' from the setup instead, as
these tests only check that the invalid gitlink is rejected.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 290 +++++++++++++++++++++++++++----------------------
 1 file changed, 161 insertions(+), 129 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 9b1827bae2..480ae2c47f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1866,157 +1866,189 @@ test_expect_success 'O: progress outputs as requested by input' '
 ### series P (gitlinks)
 ###
 
-test_expect_success 'P: superproject & submodule mix' '
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data 10
-	test file
-
-	reset refs/heads/sub
-	commit refs/heads/sub
-	mark :2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 12
-	sub_initial
-	M 100644 :1 file
-
-	blob
-	mark :3
-	data <<DATAEND
-	[submodule "sub"]
-		path = sub
-		url = "$(pwd)/sub"
-	DATAEND
-
-	commit refs/heads/subuse1
-	mark :4
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 8
-	initial
-	from refs/heads/main
-	M 100644 :3 .gitmodules
-	M 160000 :2 sub
-
-	blob
-	mark :5
-	data 20
-	test file
-	more data
-
-	commit refs/heads/sub
-	mark :6
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 11
-	sub_second
-	from :2
-	M 100644 :5 file
-
-	commit refs/heads/subuse1
-	mark :7
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 7
-	second
-	from :4
-	M 160000 :6 sub
-
-	INPUT_END
-
-	git fast-import <input &&
-	git checkout subuse1 &&
-	rm -rf sub &&
-	mkdir sub &&
+setup_gitlinks_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo base &&
 	(
-		cd sub &&
-		git init &&
-		git fetch --update-head-ok .. refs/heads/sub:refs/heads/main &&
-		git checkout main
-	) &&
-	git submodule init &&
-	git submodule update
+		cd repo &&
+
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data 10
+		test file
+
+		reset refs/heads/sub
+		commit refs/heads/sub
+		mark :2
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 12
+		sub_initial
+		M 100644 :1 file
+
+		blob
+		mark :3
+		data <<DATAEND
+		[submodule "sub"]
+			path = sub
+			url = "$(pwd)/sub"
+		DATAEND
+
+		commit refs/heads/subuse1
+		mark :4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 8
+		initial
+		from refs/heads/main
+		M 100644 :3 .gitmodules
+		M 160000 :2 sub
+
+		blob
+		mark :5
+		data 20
+		test file
+		more data
+
+		commit refs/heads/sub
+		mark :6
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 11
+		sub_second
+		from :2
+		M 100644 :5 file
+
+		commit refs/heads/subuse1
+		mark :7
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 7
+		second
+		from :4
+		M 160000 :6 sub
+
+		INPUT_END
+
+		git fast-import <input
+	)
+}
+
+test_expect_success 'P: superproject & submodule mix' '
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
+
+		git checkout subuse1 &&
+		rm -rf sub &&
+		mkdir sub &&
+		(
+			cd sub &&
+			git init &&
+			git fetch --update-head-ok .. refs/heads/sub:refs/heads/main &&
+			git checkout main
+		) &&
+		git submodule init &&
+		git submodule update
+	)
 '
 
 test_expect_success 'P: verbatim SHA gitlinks' '
-	SUBLAST=$(git rev-parse --verify sub) &&
-	SUBPREV=$(git rev-parse --verify sub^) &&
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
 
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<DATAEND
-	[submodule "sub"]
-		path = sub
-		url = "$(pwd)/sub"
-	DATAEND
+		SUBLAST=$(git rev-parse --verify sub) &&
+		SUBPREV=$(git rev-parse --verify sub^) &&
 
-	commit refs/heads/subuse2
-	mark :2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 8
-	initial
-	from refs/heads/main
-	M 100644 :1 .gitmodules
-	M 160000 $SUBPREV sub
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<DATAEND
+		[submodule "sub"]
+			path = sub
+			url = "$(pwd)/sub"
+		DATAEND
 
-	commit refs/heads/subuse2
-	mark :3
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data 7
-	second
-	from :2
-	M 160000 $SUBLAST sub
+		commit refs/heads/subuse2
+		mark :2
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 8
+		initial
+		from refs/heads/main
+		M 100644 :1 .gitmodules
+		M 160000 $SUBPREV sub
 
-	INPUT_END
+		commit refs/heads/subuse2
+		mark :3
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data 7
+		second
+		from :2
+		M 160000 $SUBLAST sub
 
-	git branch -D sub &&
-	git gc --prune=now &&
-	git fast-import <input &&
-	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+		INPUT_END
+
+		git branch -D sub &&
+		git gc --prune=now &&
+		git fast-import <input &&
+		test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
+	)
 '
 
 test_expect_success 'P: fail on inline gitlink' '
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/subuse3
-	mark :1
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	corrupt
-	COMMIT
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
 
-	from refs/heads/subuse2
-	M 160000 inline sub
-	data <<DATA
-	$SUBPREV
-	DATA
+		SUBPREV=$(git rev-parse --verify sub^) &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/subuse3
+		mark :1
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
 
-	INPUT_END
+		from refs/heads/subuse1
+		M 160000 inline sub
+		data <<DATA
+		$SUBPREV
+		DATA
 
-	test_must_fail git fast-import <input
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<DATA
-	$SUBPREV
-	DATA
+	setup_gitlinks_repo &&
+	(
+		cd repo &&
 
-	commit refs/heads/subuse3
-	mark :2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	corrupt
-	COMMIT
+		SUBPREV=$(git rev-parse --verify sub^) &&
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<DATA
+		$SUBPREV
+		DATA
 
-	from refs/heads/subuse2
-	M 160000 :1 sub
+		commit refs/heads/subuse3
+		mark :2
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
 
-	INPUT_END
+		from refs/heads/subuse1
+		M 160000 :1 sub
 
-	test_must_fail git fast-import <input
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 ###

-- 
2.56.GIT

