Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311731;
	b=xh4/deWbQlez5b/D76FZ/TQxshYWHNl+jIuHaWIfeTZq5reAB/m64gBXqkEaXno9n4md
	 DiEYtxZMYaDVSiPb4xXrR8lcnRHQoFqmPcpGFu2CBly8MQcAQ2BOUMcnHCQUMCbQeaJSi
	 AFnq8SzT84vqYMIoSclL3VfTjTOPSLHf1jpt7qmSalFBRlg3YetzlWJByDkFb3i3PlOPh
	 owND6TRYIXgxhBpFsK94obghfWeCMSnB/XHBTdl8NnEnCEIMe6pEDOVcwAsyT4mHKUBzj
	 F2Mo59anYiBM9DVEV/ODGQ7WNI2Gg73XxQqHTeIH4XL3+Pq1MEWQtLtzZofLNM4/TCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=EWOcfY9tLMDUzPK76cIprm0dPJVXp1eQx5+RhGaOvBo=;
	b=Ywp3svh/pQZDcKtqxrDq5YqWkvmFoWQTgbLRjLm3F5ubpQ64dh1GBcyUxnd/iEfRwQHp
	 ig/WLhfHuTlStEdD1iQHEr9Chwjs889Mzo/UWYVXji2ELZI83T6j6q6BShf/TNm8fA23o
	 OT4mCeQVI72QWA+yGTCUJFOD0blcoUSQFVp2D8DgUP07uyU9JIBKODaO1ETtNjam5HhYs
	 g1mnFWB5JUEo3SeKYr0wys/uibYPpuuog74vVj2jYe9p54NePmi6z1Ywnu7mrRpeBm3/t
	 D+DHt4woLTYGB/Giq94smMA0cwixN1Z6MgI0f/86066AJbMeQNw2Np1pEtjXejt37/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgzIwDv9;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CE606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D29CE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgzIwDv9
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso2184583e87.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311729; x=1794916529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWOcfY9tLMDUzPK76cIprm0dPJVXp1eQx5+RhGaOvBo=;
        b=hgzIwDv9h+TYA0E1UPIfeDA2Zsc0aqIP55XrtHlVf1g3h5w39BkAEOdjl4E9feitAH
         vG51jWd4sSt2GvcDtvTQgCNoyoAs+rNga0MOfOPE/Zg/GqVAcFi6/+tfxJriLKJ9f205
         GlkCjf+r1ELaE6lTZSenXlLeg4PaXXdtxUsq0aWCGjW7jOyeBGZW7AMJcK/+KojyYVcE
         i2ZxSHODgmIzqJFDbEaO6dXFvSMmh1uVSb5H6/obdtw5VYB6olMAMERe225kG3zmt+JK
         lsy4t27WB7NtUH0Mkel0K6Nzq7Xmo2DDVy++HMTwvB0soW8QQUjq2D7nu470yeaWHlvN
         HhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311729; x=1794916529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWOcfY9tLMDUzPK76cIprm0dPJVXp1eQx5+RhGaOvBo=;
        b=1cuR66u+JKQSIrYH/odNoP7GKl6W7a798mW5H1GYvNjRrp80bOxjtkDm/GLaCkR6pE
         4bN3rMfwLp4obwUa534okvRl3908LYv2wpvC5FQScjzQJiV26YepLpjvNOxHaLXxwxkV
         Q1cQ28YwDUVpOaAZ5yLh2EC2g+ncTDtHm+hpW8DfSO2bf+Q93aYe89CJaYrbLVJjPd0o
         NxiEDDHWsh1KvlTM2GhoIEjwUeQ7TZeBtq2L35fuM4kPWSay04LVkb+XgXAvFUeF5cAQ
         Xwk74OvGwczXS45EqpOPlCBBQEpYVH9WkjECJjlLK7QIQ1MnDTuxehtbsXeqZQiirObm
         tnbA==
X-Gm-Message-State: APuU4Z88v04DjECF9U2T/dlVHEsXCVYYuRng1+pAq58xMEUw3HD4uygZ
	gNvrMVzg/tJ/w3Hge93or1a5JR1gaQGUYk4ASxhlla+CzP+kJxO5/GiTq3p3mw==
X-Gm-Gg: AYBFou1j+/84N2pOLGOkG2gYXMzZl4GQmKggXIG0Q6yDnk0yX2T58RlFCMOTMhhKmNx
	EwCoXKLb6BiM+zUh9XhnlaDIlaAjozUSj8o2GQ5xfOJ/weZzLSbr0ABtp1uwnvDtZcGYvVKxEa9
	QkxPV/lnOKUo+04z/5owsSJuPsuY/H9IfOt8TgH2je3igYD2nC6W3txRlZ4v3JHf+rYZNArYH/n
	aqBUj391y5IQXnf7v4orWKZXHD2tO0nDBy39vm7bREwwgoZCxcMHGEiINXQCHrYvOYxy0ixaB34
	lSejyHB+gAb1b5o4IWxFOx3v68jj0DC3W0u+QDKzb5F9Vc6XfOnJSN4bdpcxgiYaO9jLwQnGrWk
	2j+ry7xDGMvfZRV+bqHDN0Gt9DaUe34QLxKDxYjdfhnCPF1+24TVAfhoshUSVnbtRzrChiJ32wG
	QqqbDpvkp/Lp61bHdo6HIQFIRb5N89o6Rdjzu248XqrA2YhaG/cOIYrQY3MraPNP0GT0ZHVKSeg
	QHsfj9kNIa+eLA1Lx0U0fKRUAAxTbMJQJr2aIDFSaDvTKrlGK3GQQYOz2jbvvlgoFPKiDHwoOlh
	xP9VRyQMQNXngM3/kwTePY/MQnAxj8mkoOABW39sLeBZ6rOdL6iKsiEhSiiZZAMV2dU=
X-Received: by 2002:a05:600c:3b86:b0:4a2:167a:c939 with SMTP id 5b1f17b1804b1-4ba0234e2fdmr46323265e9.21.1794311410993;
        Tue, 10 Nov 2026 03:50:10 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:10 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:54 +0100
Subject: [PATCH 09/20] t9300: make the big blob tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-9-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2QqW6cr4BUMnON3kDRRxHb64H6i5xO6pNTzeo1quR04=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOcnXiByWvOH0kWoveSSz5y3vFojJvTIH
 lMTzNCyc25LYIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTnAAoJED7VnySO
 Rox/cvYMAIgPUCHFkJtp4ET9zYcQI8StqXH7E7JKq4XFZN9nsB61kWW36nwnz+qvrVbahHGCoEC
 2vlMYJ7c5ZbT0naFV3rmnQegS+2huZO0U6PyCy/ZrydqoCUXt0P3rnmjUtd4mVyERgTWeEDZVKP
 UN7VYcWhjkkP3NSNkZpt/6jq3bvptQdB7O5Om+ZpPPuCkD2Okuep4kLHJWAqqJ+8c9nUjaRBnVP
 MWYT/16LSkjboCTvJTdRE2j6Fg+3V030BGqXtRXhK1QeH2EO4rZ1dxvN2LmFggnUXiMp2qixw7o
 VK/qEg4SV2yFJUrXxpCNOt4TLcaNEaFa72cnNAb4gLn1nmxU+Y+pPieZ4bJ2mHsyvp13ialfF9P
 RaLJqcSoiwiS2qw6Gjy/wfts9/EP7ybr8gLqy8t1AaMziM0nn4EaFwLmFo/kWTiz99KPYHjh4so
 EqWSDJOkUOhJDyqbN0yN1ydHhfvFBdSbqSAK62tokVkaDLzm6NyJ3gKfvqRi1wjurRYFMwA05d9
 Oo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the big blob tests in 'series R'
to make them independent of state from previous tests.

'R: blob bigger than threshold' imports the blobs, and the tests after
it inspect the result. Fold them into a single test, which does the
import and checks the pack, the blob contents and that the blob is
stored only once.

Set 'fastimport.unpackLimit' to 0 for the import so that a pack is
written, and verify it with an inline loop in place of 'verify_packs()',
which won't be available once the test is moved to another file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 79 ++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 75c2de46ed..9f4aea09dd 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3148,51 +3148,48 @@ test_expect_success 'R: corrupt lines do not mess marks file' '
 ## R: very large blobs
 ##
 test_expect_success 'R: blob bigger than threshold' '
-	blobsize=$((2*1024*1024 + 53)) &&
-	test-tool genrandom bar $blobsize >expect &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/big-file
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	R - big file
-	COMMIT
-
-	M 644 inline big1
-	data $blobsize
-	INPUT_END
-	cat expect >>input &&
-	cat >>input <<-INPUT_END &&
-	M 644 inline big2
-	data $blobsize
-	INPUT_END
-	cat expect >>input &&
-	echo >>input &&
-
-	test_create_repo R &&
-	git --git-dir=R/.git config fastimport.unpackLimit 0 &&
-	git --git-dir=R/.git fast-import --big-file-threshold=1 <input
-'
-
-test_expect_success 'R: verify created pack' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		cd R &&
-		verify_packs -v > ../verify
+		cd repo &&
+
+		blobsize=$((2*1024*1024 + 53)) &&
+		test-tool genrandom bar $blobsize >expect &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/big-file
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		R - big file
+		COMMIT
+
+		M 644 inline big1
+		data $blobsize
+		INPUT_END
+		cat expect >>input &&
+		cat >>input <<-INPUT_END &&
+		M 644 inline big2
+		data $blobsize
+		INPUT_END
+		cat expect >>input &&
+		echo >>input &&
+
+		git -c fastimport.unpackLimit=0 fast-import --big-file-threshold=1 <input &&
+
+		for p in .git/objects/pack/*.pack
+		do
+			git verify-pack -v "$p" || return 1
+		done >verify &&
+
+		git cat-file blob big-file:big1 >actual &&
+		test_cmp_bin expect actual &&
+		a=$(git rev-parse big-file:big1) &&
+		b=$(git rev-parse big-file:big2) &&
+		test $a = $b &&
+		n=$(grep $a verify | wc -l) &&
+		test 1 = $n
 	)
 '
 
-test_expect_success 'R: verify written objects' '
-	git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-	test_cmp_bin expect actual &&
-	a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
-	b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
-	test $a = $b
-'
-
-test_expect_success 'R: blob appears only once' '
-	n=$(grep $a verify | wc -l) &&
-	test 1 = $n
-'
-
 ###
 ### series S (mark and path parsing)
 ###

-- 
2.56.GIT

