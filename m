Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311413;
	b=f18kBGSNApT/VUTDBmrdNkkp2AozLPCxcRx74Beu0WRij6UzfMBJr2nJ5+EtcpGt7w4/
	 x9EetGRVzXU0OG0+aNgA3cqAH2+sKAAZt3Ons38q5p/ELvHTaUNGx9igSexH/IBmVymcv
	 4rbAtUdutsQipIgzUdtbHj8j3Npr/dYJdExeG4YF7gmtHu2JE1w9JbAOzWcVp5gvN8iQ9
	 +XCROaLvXHjahra35DxyXlNlwatxwGmWvDPiZZzjXFbQXYfwc/iEPX9c0ds00tkK09o5A
	 1rTIGongCtcouqaulUszmiFQo9IJ18QTCHNDcnM456G+0ki11Ni6G8l689jGmuBuNVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=rJ3bRVWsgYqsowGCfhzTbN12uI60sJINBdBfg1rfmWc=;
	b=oGU8mxwmzgis2HdJhqmk9Uzh3Hm5KAHOTi2b8Zlqp5jYluApvvBdppsgc9YPGMltw4Nc
	 tEx78Bqy3fpzMeVyKGk/8ueoSvsL9L22Lp35G0hvP814mJ2MjMd+an8yTyPSXRtQi52RA
	 jmGdWHioanAF9IWCGkpsefprWkCuXPQTR4t/az6uf9fT7Cevk8Z1M2xzbdWTOFF8zS5Xz
	 QjezwH5ecEO/xbXnNvvcVJHdIVjM0PoHXlyiTa+gtMu2wKkey2zul71Mwrs6j+TAHedKT
	 h5AG1Bxrsw8WUAUCTRNZGAyC2lCRg5YV3N9bYJ7sYGCVzyo24b2qKCliyRrtRzSk+MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="CY3/NBd1";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E38606B583
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84E38606B583
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CY3/NBd1
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so16237135e9.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311412; x=1794916212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJ3bRVWsgYqsowGCfhzTbN12uI60sJINBdBfg1rfmWc=;
        b=CY3/NBd1JC4NcwQth39wLwpjo2BqJtdhtpwid2CTd9RusDeOQn7U8U22bkIpzxa2ZR
         GjpnfSiKnNPE3zaXBBGTD7XKnAZD0IqCD4lDnyU6KN1wyRrG8w76d43ydw4SEFcSNM0F
         fRYdJIBLfi0x8taFDSwgoyCOr0On5Rjs0vTGSK41f3K+yh5pGrp3xOHGmztn+WqdNcav
         k5+sMMkVk/+g1ymuSl+iL+sfgJcUlw7vhgW3M2TqtkTETiwdSP7+NiAgD2kIMY4Kz07Q
         D8EA9sbauIzW8urtoJssdN5AgKAMXukJan1acLdMOq+EKL8CscYFCcMi09IDoh4TJu7D
         HVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311412; x=1794916212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJ3bRVWsgYqsowGCfhzTbN12uI60sJINBdBfg1rfmWc=;
        b=LtcyaCty6B+ceh1QMFykzei2bQsdWTqx+GxKW0BapupxVjQDiYY0Ty4nTfWxkmZ+MR
         PXYz3GlvTfbbPwCiL5VsiHExGbrflwD7oIP6xYUdfxJdCkoq8otqnOU9isrhb63FGZaW
         I7cc2z8e3y6vj2Zik2gZd3IpA8EIuANxkN5Cc2QqjGJmDaTMYGUMKURVdvyypCPXzLoF
         LSu1Kq4TOhZN4Yc/Pk7er/mdpUSPvFI1FNBY+icYI6aGf1triaYB1L476g5ZSWCJP4Zj
         9J+NCJUb7gNMC8ouJekunK/Du0GuTLzYolpM8NuBu1GP0PV0YL8HPoNCfBQEpKX+rHUE
         +IXw==
X-Gm-Message-State: APuU4Z91qFtGEXYCroPfmG+i4qGEE/ab4nQvj3amLP5iIhMc+7IU1/GW
	GzPhT+aMtHfjaC8RFu8+TB/V7EA7fFrMenpwPBEAIjoRPRkPkv25iDS8Vurmwg==
X-Gm-Gg: AYBFou0SWZkMCcCbv1a4kpHXiMTaEUYLQn0VGgAUF5TIAfBxHR7qnNpKzC7awQF0GEH
	tc0RFFr3f1pUBlfUYmxKM4vnYerrPxEINneXfDqO7lypQQV4SByWiBYJkf/B2DkxeWu7UAUDfU4
	BrN1D+e9/mystxhwBpZ0GbNa2jxMG1ZHDgDdWJ7GMgfyosbb+/WHBjOhercOImyPLh5PnQdD14L
	knzlUtzNrtTElEH71I9Hc0LipjqsdQEQ0fhO9MDSXKlujpFRr/ph0OFbhnZWc7g5c8I+UzkK9OI
	ebswx7wG7oegQRWHRVZI5dAvMBsNrGBr4vPu09QUY7/+Mnbi7efT4kkfCu7vzZ7ZBd7JSW7clTo
	0/FGcLJEica59GX0ZvLUAIs9yNRD1d+NWdMFybYbf9lVX5qEh9ng8O3epMB+7D4l5UgF8MBAe1W
	+SuK3Ig+SfIkqJaaERMzw6hMqMtiHzoc8/5zvuILMaksAzsOSOXV+dSnHLTFiDYedxrxDz6/YhF
	TfxX+geuOUpWUtpI8EhX1KQ90tAESggHSGQJbfJKiqLQzV5H3OITETQlDB5fANgiYBi09lx8Oov
	u18XfoJyAcJImnZNQweQYAWoTjXwou1IFvtu0j7gGcgEBDUfFS3wMoMGvqPDqEfCwT0=
X-Received: by 2002:a05:600c:3495:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4ba0233d85dmr41977235e9.8.1794311411755;
        Tue, 10 Nov 2026 03:50:11 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:55 +0100
Subject: [PATCH 10/20] t9300: make the ref update tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-10-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7862; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=4CTnc9EdRrIMMn54HScwk9KXMkRYJB9g0gTwtVYkXxo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOf8dNL+rFYIeT//S8R7rvXWSzi8/gnKG
 2qoHuwYhyHFPIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTnAAoJED7VnySO
 Rox/IAoL/1ZB13UJYGo4naMZ2KHVaLmTy2nhuTLa8SVnR58ax/iEPOzyVi7U/Sj1odU8/3Rp2ex
 FNeEQfDbLwCEdprAYvKjV61u65VhM89zCWqotkZM0F0P+v4c/8rTIenRwUph+fMlDZhAWp9jdVw
 wSkRJLlcHTWS2FbJiYH9MdHDld3nSoKvNdc8NtylnOw8NUgtPuhxaS6FxWndDog843xxrTD0VN+
 wDNqvCIVJ0PZNhzQ8GvV3Vs8o8lfNeSXvzISMasEjE5RVmFv2vB6kHEneJo1MjQ/erYhcIv9q8e
 RCKyMYH9J0rStSDOUckta+dOJcqlx2jkVikNHr7DPzlY/e/M+sNpr0uUB4DQJgqZlg4HwTHAPfh
 Uy9Lln0ewbrA7KVXeRMdnPnY7YxTc0xyJQoepkKJtMJPL7Y60AIAdo8oyQMNck9Pmp2/8HskIrX
 kPIQ9YD91clswrjtIfoZtqEaOvKOSqAplkTp0PLBVe7u0CpSXpCc+7M/4gjAyST8HOO5XflBDj8
 LU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the reference update tests in
series 'F', 'G', 'J' and 'K' to make them independent of state from
previous tests. Add a 'setup_two_commit_repo()' function which creates
a repository with two commits on 'main', so each test can invoke it.
The tests used to build on the 'branch' branch of earlier tests.

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
index 9f4aea09dd..9576df78a1 100755
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
@@ -1017,42 +1030,50 @@ test_expect_success 'I: verify edge list' '
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
@@ -1060,29 +1081,32 @@ test_expect_success 'J: tag must fail on empty branch' '
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

