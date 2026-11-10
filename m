Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311423;
	b=nG1T3ApfVMNsMfHZC7TxctNN4JAJ/0V6gFbltE4w2PY0pJgJoXzO4+friVG/wdPAHTei
	 59TE6u1fzqBOwPVf7P8fukhNxgmAc6P0aIQHagmNg2wN1pixuMRSalcc89+GBpJrE0/v0
	 Qr4Y8FZRsiLtPlJ1wHZKb9NfrIrlKt32eoNC4auUYk88LRqrPBg0JgmvoDaLQilqRSrdL
	 155Cpv47UzXVhK1/eEuStWhAbxHtFqaiRBaRuiGF48TtNTR9Hm8MKX3phEK7CNpdzkZ6A
	 7hIn8xW8bo7pfBwr/Y7/671KzcpPT6v6zkQXmqWtLuNpe5WFQIGucfPrEdRstdOkG4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=AgumxIJn+nLclieeiQ4K38RHcTmkZJ6CpU6OdDCZtwE=;
	b=sd+5CVI+oxnjWk9MzVbNeNZGTYHf35hGgwXaxuEpC6+r7NPNzwl4HHGhIM5D9imuOLzv
	 wkpUnXm62da4kifZmyR6L1gy8H2nDbCOj24mAs3RC01fsxrwFGUiC/krtWR3JsTlVZJqq
	 rbx3BGt7SjjWegEUmNYXb7wfWm52CYjwtIUAyort9Ces6ugY7Ap7FhEkn4BT8e9wxyPvm
	 lZkeYY6CGDdSChG8FRX8p1VP6t6GHtBIqIOoE9qhWAkBlusdhpeE8l/PvkD/BevrePZhg
	 IsTUzKx1hz4WyBqfrJB3eoWKxAp+VOiz4MrKWaP/Jc1k3vb46RQQb6VY/IklrSfIofQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOPF+E8J;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15C606D4D0
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F15C606D4D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOPF+E8J
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso12999665e9.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311420; x=1794916220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AgumxIJn+nLclieeiQ4K38RHcTmkZJ6CpU6OdDCZtwE=;
        b=ZOPF+E8JaJq9vNAR2oOTbV5dLpMvz055DXAa9FBAwVELnhCLzfjl+TY7lEt25DEBPz
         ib56Z57iYE1g9IXcVami3VoRiKGk8012YZOLallXI33nlr+sbECQf+GMRSQXxE/TS66t
         UflMX9kzQS/ruj7q7WnGuDne1j+1V6yX24eAKsHApFs5MfMTuNFLaLgohc8Pw75wJhOH
         M7U2Qx/Y5aiF9jOhqpkY/0qVMSExmUCJO9nThkTwYui7mhyAgGYb7UCwvenvaqywqkFu
         H7CIjvtUMQMC6V7FiJ58nc1Fo5YPZOyz6ym6dk0BvFnJ9oU6vHqvNIW6pAGct/9y8Rt+
         3R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311420; x=1794916220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgumxIJn+nLclieeiQ4K38RHcTmkZJ6CpU6OdDCZtwE=;
        b=PwF0MibmUfUd7z85TXqSdlRclyD4FKl2NFymdFFnY3Ff89UyPOJ6PDDDmcrulxrSB4
         98rKb1ev/7eE48x4CeKtHJn6yMvpuI50A8FC0coasm52sNhZrXevVwVvmOYr2yWmFWI2
         dkn268P70+ye1pu2CQ3AoRfDMpuA+b7WSYkzrLhLRaZ2DUq+dz3y2Alwvu9XbCcHJ6HF
         B80ci+DDeJ48iAlMB0hUbuU9M4mKPv3UGIb3yvJ3pxEzfgPQzbyV6R8MWuCVF6X++YDF
         MTQpzu2f8QKzraU7XC1cSvOmceYWdrmNwKw4D+ZaO8y4DdS/8YacgFgEbIG6DI7nocKA
         GqbQ==
X-Gm-Message-State: APuU4Z8gW67NC7c1Vd+PJAK7eSKm7zHfwdMQkoMaBEWbDIqKFihoy36F
	bJEf+SFtlvLM1n85Cd2q95Xbu1N9huOJDJz2BY5YMMgTMkXnCIgyWbyA/YXp7w==
X-Gm-Gg: AYBFou2/RbxvnXPEYhcPkzxFER+hzreFRjAc0l28bH0keyqEnGEfTR9PDpm4tEwX2ss
	sPwcuJ8+oO9xvE02pEA5NmA6KXqlKNRXxzQ1X/sfOawJSka3AQbgUFnDHDxgYeECo5fpfuqsWyh
	MC6prJ1hPhFoo4gqfL+DgJvhpFdcky1jhIsqzwEU2oQmY6WJfW3QYWnwpZ1HT8AkFx2ISGpHpfh
	8JTQ07iFtLXS/LUWinmtoZbCHf/xxI48U+/cjuj5b/pqxgjFCpcWHU/vK576NZgH8oDBTlR6ZNR
	BVpPYuSdFlFPRc62E7tJj6dS30XuZq7nJxLtSbbs+6xgpM/A6Hn7vf+ZSJTLA+5MjYmFEvSQbve
	I9vZ/UyHl3Ha5lZFFEmBNkSOyXfu3rTPFNIRWvauDWOU+v2crxJYIY/FNjtDtueitedO92ZC/PN
	IjVOvy3A4bi+To5l8hp5kUMjAsfaSWwgvtSGzC+bJE0ofhknTKVqOMpVRO7Sao+Dl83ce/bpDvb
	+LVxeszHp1pXkCgsjN5Dhg6xpI5hJ7DYcgi2biO+jYsQpVcuruh2NSYOivODYO5UW1jjuleOXlZ
	xnQyxEDWnv0KPEBy/p4hktT9oqX7/0bBg5hNBnGidelUO2HSGzoDWzcd3FsJrOhd3PM=
X-Received: by 2002:a05:600c:a013:b0:4a3:18ca:806 with SMTP id 5b1f17b1804b1-4ba0234a0b2mr38075965e9.20.1794311419393;
        Tue, 10 Nov 2026 03:50:19 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:18 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:50:05 +0100
Subject: [PATCH 20/20] t93xx: drop the series letter from the moved test
 names
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-20-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=38762;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=q2qKIm7Z26LYCxdtF2rEVI/v3OD/das9JkWF+ug/nYQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOr0EMUvT/vrQ0qeZGBNyzbYYPNzdBUGH
 vAk3VbjBZ2/mYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTqAAoJED7VnySO
 Rox/R8MMAJLkHH1iFijJ4aUS1H6XpBQL5tDIiw4iD9lh9N/qEPgezYlbED4X3Lhm+6476q2DUFk
 AUa4iutjFC4ofOPhw1TaXhwWX1Da3g/98Q5merul4enD2KuXU7yQNmDvMU7ar+OxoRY+622+veg
 Yi+KfL190IBmrHZZ/++os9qKI56/k8lwcsaWb3gmA2h9wVHPPXohtCu/Q5G5+wlznHF+MXdSQOp
 mhUX0chYfYvAp9lF23+v2KBgg3+CD3P+Q0io9Lz5feY84KcROQlJdHHyGC16bcXVU9fy0E2Abxc
 MyTdo+zQ3xCsfp+OZME8DGfGzDHp43TpE4T22IGCZxjNJXDhirTZQ4Yl67NWT2TFWRmKx/GExNc
 0X7Q9+m6mF15wEtm+QcfmawixkRmikkFSnc7UJNusDGyNfYMzwb8yUYhPkS0MeeXT3VpLHBSYZf
 I8w3uB8y+tOMYfUhjG9C4eRqHKRJ5JP4qaIvzWYSEkANE5dyPAg8Tdh3StFCkYam6iGGcNtOXe6
 rg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the previous commits, tests were moved from t9300 to other test
files as is. Each of these tests have their descriptions prefixed with
their series names. Since they don't hold any value outside of t9300,
drop them.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9301-fast-import-notes.sh      | 42 ++++++++---------
 t/t9304-fast-import-marks.sh      | 28 ++++++------
 t/t9307-fast-import-validation.sh | 96 +++++++++++++++++++--------------------
 t/t9308-fast-import-stream.sh     | 52 ++++++++++-----------
 t/t9309-fast-import-checkpoint.sh | 10 ++--
 t/t9310-fast-import-submodule.sh  | 12 ++---
 t/t9311-fast-import-refs.sh       | 14 +++---
 7 files changed, 127 insertions(+), 127 deletions(-)

diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 5d43a523d0..89078b6527 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -860,7 +860,7 @@ echo \"\$@\"" &&
 	commit3=$(git -C repo rev-parse notes-test)
 }
 
-test_expect_success 'Q: verify pack' '
+test_expect_success 'verify pack' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -871,7 +871,7 @@ test_expect_success 'Q: verify pack' '
 	)
 '
 
-test_expect_success 'Q: verify first commit' '
+test_expect_success 'verify first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -886,7 +886,7 @@ test_expect_success 'Q: verify first commit' '
 	)
 '
 
-test_expect_success 'Q: verify second commit' '
+test_expect_success 'verify second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -902,7 +902,7 @@ test_expect_success 'Q: verify second commit' '
 	)
 '
 
-test_expect_success 'Q: verify third commit' '
+test_expect_success 'verify third commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -918,7 +918,7 @@ test_expect_success 'Q: verify third commit' '
 	)
 '
 
-test_expect_success 'Q: verify first notes commit' '
+test_expect_success 'verify first notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -933,7 +933,7 @@ test_expect_success 'Q: verify first notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify first notes tree' '
+test_expect_success 'verify first notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -947,7 +947,7 @@ test_expect_success 'Q: verify first notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify first note for first commit' '
+test_expect_success 'verify first note for first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -957,7 +957,7 @@ test_expect_success 'Q: verify first note for first commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for second commit' '
+test_expect_success 'verify first note for second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -967,7 +967,7 @@ test_expect_success 'Q: verify first note for second commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for third commit' '
+test_expect_success 'verify first note for third commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -977,7 +977,7 @@ test_expect_success 'Q: verify first note for third commit' '
 	)
 '
 
-test_expect_success 'Q: verify second notes commit' '
+test_expect_success 'verify second notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -993,7 +993,7 @@ test_expect_success 'Q: verify second notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify second notes tree' '
+test_expect_success 'verify second notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1007,7 +1007,7 @@ test_expect_success 'Q: verify second notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify second note for first commit' '
+test_expect_success 'verify second note for first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1017,7 +1017,7 @@ test_expect_success 'Q: verify second note for first commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for second commit' '
+test_expect_success 'verify first note for second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1027,7 +1027,7 @@ test_expect_success 'Q: verify first note for second commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for third commit' '
+test_expect_success 'verify first note for third commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1037,7 +1037,7 @@ test_expect_success 'Q: verify first note for third commit' '
 	)
 '
 
-test_expect_success 'Q: verify third notes commit' '
+test_expect_success 'verify third notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1052,7 +1052,7 @@ test_expect_success 'Q: verify third notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify third notes tree' '
+test_expect_success 'verify third notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1064,7 +1064,7 @@ test_expect_success 'Q: verify third notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify third note for first commit' '
+test_expect_success 'verify third note for first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1074,7 +1074,7 @@ test_expect_success 'Q: verify third note for first commit' '
 	)
 '
 
-test_expect_success 'Q: verify fourth notes commit' '
+test_expect_success 'verify fourth notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1090,7 +1090,7 @@ test_expect_success 'Q: verify fourth notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify fourth notes tree' '
+test_expect_success 'verify fourth notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1102,7 +1102,7 @@ test_expect_success 'Q: verify fourth notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify second note for second commit' '
+test_expect_success 'verify second note for second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1112,7 +1112,7 @@ test_expect_success 'Q: verify second note for second commit' '
 	)
 '
 
-test_expect_success 'Q: deny note on empty branch' '
+test_expect_success 'deny note on empty branch' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index 437f9016fa..57050dcfe4 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -79,7 +79,7 @@ test_expect_success 'relative marks are not affected by subdir' '
 	test_path_is_file deep-relative/.git/info/fast-import/exported-marks
 '
 
-test_expect_success 'R: export-marks feature results in a marks file being created' '
+test_expect_success 'export-marks feature results in a marks file being created' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -99,7 +99,7 @@ test_expect_success 'R: export-marks feature results in a marks file being creat
 	)
 '
 
-test_expect_success 'R: export-marks options can be overridden by commandline options' '
+test_expect_success 'export-marks options can be overridden by commandline options' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -120,7 +120,7 @@ test_expect_success 'R: export-marks options can be overridden by commandline op
 	)
 '
 
-test_expect_success 'R: catch typo in marks file name' '
+test_expect_success 'catch typo in marks file name' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -132,7 +132,7 @@ test_expect_success 'R: catch typo in marks file name' '
 	)
 '
 
-test_expect_success 'R: import and output marks can be the same file' '
+test_expect_success 'import and output marks can be the same file' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -162,7 +162,7 @@ test_expect_success 'R: import and output marks can be the same file' '
 	)
 '
 
-test_expect_success 'R: --import-marks=foo --output-marks=foo to create foo fails' '
+test_expect_success '--import-marks=foo --output-marks=foo to create foo fails' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -179,7 +179,7 @@ test_expect_success 'R: --import-marks=foo --output-marks=foo to create foo fail
 	)
 '
 
-test_expect_success 'R: --import-marks-if-exists' '
+test_expect_success '--import-marks-if-exists' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -199,7 +199,7 @@ test_expect_success 'R: --import-marks-if-exists' '
 	)
 '
 
-test_expect_success 'R: feature import-marks-if-exists' '
+test_expect_success 'feature import-marks-if-exists' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -253,7 +253,7 @@ test_expect_success 'R: feature import-marks-if-exists' '
 	)
 '
 
-test_expect_success 'R: corrupt lines do not mess marks file' '
+test_expect_success 'corrupt lines do not mess marks file' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -315,7 +315,7 @@ create_marks_file () {
 	EOF
 }
 
-test_expect_success 'R: import to output marks works without any content' '
+test_expect_success 'import to output marks works without any content' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -332,7 +332,7 @@ test_expect_success 'R: import to output marks works without any content' '
 	)
 '
 
-test_expect_success 'R: import marks prefers commandline marks file over the stream' '
+test_expect_success 'import marks prefers commandline marks file over the stream' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -349,7 +349,7 @@ test_expect_success 'R: import marks prefers commandline marks file over the str
 	)
 '
 
-test_expect_success 'R: multiple --import-marks= should be honoured' '
+test_expect_success 'multiple --import-marks= should be honoured' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -369,7 +369,7 @@ test_expect_success 'R: multiple --import-marks= should be honoured' '
 	)
 '
 
-test_expect_success 'R: feature relative-marks should be honoured' '
+test_expect_success 'feature relative-marks should be honoured' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -389,7 +389,7 @@ test_expect_success 'R: feature relative-marks should be honoured' '
 	)
 '
 
-test_expect_success 'R: feature no-relative-marks should be honoured' '
+test_expect_success 'feature no-relative-marks should be honoured' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -410,7 +410,7 @@ test_expect_success 'R: feature no-relative-marks should be honoured' '
 	)
 '
 
-test_expect_success 'A: export marks with large values' '
+test_expect_success 'export marks with large values' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
diff --git a/t/t9307-fast-import-validation.sh b/t/t9307-fast-import-validation.sh
index e52ae3326f..ec551e2487 100755
--- a/t/t9307-fast-import-validation.sh
+++ b/t/t9307-fast-import-validation.sh
@@ -6,7 +6,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_expect_success 'B: fail on invalid blob sha1' '
+test_expect_success 'fail on invalid blob sha1' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -31,7 +31,7 @@ test_expect_success 'B: fail on invalid blob sha1' '
 	)
 '
 
-test_expect_success 'B: accept branch name "TEMP_TAG"' '
+test_expect_success 'accept branch name "TEMP_TAG"' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -55,7 +55,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 	)
 '
 
-test_expect_success 'B: accept empty committer' '
+test_expect_success 'accept empty committer' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -75,7 +75,7 @@ test_expect_success 'B: accept empty committer' '
 	)
 '
 
-test_expect_success 'B: reject invalid timezone' '
+test_expect_success 'reject invalid timezone' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -93,7 +93,7 @@ test_expect_success 'B: reject invalid timezone' '
 	)
 '
 
-test_expect_success 'B: accept invalid timezone with raw-permissive' '
+test_expect_success 'accept invalid timezone with raw-permissive' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -113,7 +113,7 @@ test_expect_success 'B: accept invalid timezone with raw-permissive' '
 	)
 '
 
-test_expect_success 'B: accept and fixup committer with no name' '
+test_expect_success 'accept and fixup committer with no name' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -133,7 +133,7 @@ test_expect_success 'B: accept and fixup committer with no name' '
 	)
 '
 
-test_expect_success 'B: fail on invalid committer (1)' '
+test_expect_success 'fail on invalid committer (1)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -151,7 +151,7 @@ test_expect_success 'B: fail on invalid committer (1)' '
 	)
 '
 
-test_expect_success 'B: fail on invalid committer (2)' '
+test_expect_success 'fail on invalid committer (2)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -169,7 +169,7 @@ test_expect_success 'B: fail on invalid committer (2)' '
 	)
 '
 
-test_expect_success 'B: fail on invalid committer (3)' '
+test_expect_success 'fail on invalid committer (3)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -187,7 +187,7 @@ test_expect_success 'B: fail on invalid committer (3)' '
 	)
 '
 
-test_expect_success 'B: fail on invalid committer (4)' '
+test_expect_success 'fail on invalid committer (4)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -205,7 +205,7 @@ test_expect_success 'B: fail on invalid committer (4)' '
 	)
 '
 
-test_expect_success 'B: fail on invalid committer (5)' '
+test_expect_success 'fail on invalid committer (5)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -223,7 +223,7 @@ test_expect_success 'B: fail on invalid committer (5)' '
 	)
 '
 
-test_expect_success 'B: fail on invalid file path of ..' '
+test_expect_success 'fail on invalid file path of ..' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -248,7 +248,7 @@ test_expect_success 'B: fail on invalid file path of ..' '
 	)
 '
 
-test_expect_success 'B: fail on invalid file path of .' '
+test_expect_success 'fail on invalid file path of .' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -280,7 +280,7 @@ test_expect_success 'B: fail on invalid file path of .' '
 	)
 '
 
-test_expect_success WINDOWS 'B: fail on invalid file path of C:' '
+test_expect_success WINDOWS 'fail on invalid file path of C:' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -305,7 +305,7 @@ test_expect_success WINDOWS 'B: fail on invalid file path of C:' '
 	)
 '
 
-test_expect_success 'B: fail on invalid file path of .git' '
+test_expect_success 'fail on invalid file path of .git' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -330,7 +330,7 @@ test_expect_success 'B: fail on invalid file path of .git' '
 	)
 '
 
-test_expect_success 'B: fail on invalid file path of .gitmodules' '
+test_expect_success 'fail on invalid file path of .gitmodules' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -355,7 +355,7 @@ test_expect_success 'B: fail on invalid file path of .gitmodules' '
 	)
 '
 
-test_expect_success 'R: abort on unsupported feature' '
+test_expect_success 'abort on unsupported feature' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -369,7 +369,7 @@ test_expect_success 'R: abort on unsupported feature' '
 	)
 '
 
-test_expect_success 'R: supported feature is accepted' '
+test_expect_success 'supported feature is accepted' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -383,7 +383,7 @@ test_expect_success 'R: supported feature is accepted' '
 	)
 '
 
-test_expect_success 'R: abort on receiving feature after data command' '
+test_expect_success 'abort on receiving feature after data command' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -400,7 +400,7 @@ test_expect_success 'R: abort on receiving feature after data command' '
 	)
 '
 
-test_expect_success 'R: import-marks features forbidden by default' '
+test_expect_success 'import-marks features forbidden by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -414,7 +414,7 @@ test_expect_success 'R: import-marks features forbidden by default' '
 	)
 '
 
-test_expect_success 'R: only one import-marks feature allowed per stream' '
+test_expect_success 'only one import-marks feature allowed per stream' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -431,7 +431,7 @@ test_expect_success 'R: only one import-marks feature allowed per stream' '
 	)
 '
 
-test_expect_success 'R: export-marks feature forbidden by default' '
+test_expect_success 'export-marks feature forbidden by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -442,7 +442,7 @@ test_expect_success 'R: export-marks feature forbidden by default' '
 	)
 '
 
-test_expect_success 'R: feature ls supported' '
+test_expect_success 'feature ls supported' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -453,7 +453,7 @@ test_expect_success 'R: feature ls supported' '
 	)
 '
 
-test_expect_success 'R: feature cat-blob supported' '
+test_expect_success 'feature cat-blob supported' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -464,7 +464,7 @@ test_expect_success 'R: feature cat-blob supported' '
 	)
 '
 
-test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
+test_expect_success 'cat-blob-fd must be a nonnegative integer' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -474,7 +474,7 @@ test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
 	)
 '
 
-test_expect_success 'R: die on unknown option' '
+test_expect_success 'die on unknown option' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -488,7 +488,7 @@ test_expect_success 'R: die on unknown option' '
 	)
 '
 
-test_expect_success 'R: unknown commandline options are rejected' '\
+test_expect_success 'unknown commandline options are rejected' '\
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -498,7 +498,7 @@ test_expect_success 'R: unknown commandline options are rejected' '\
 	)
 '
 
-test_expect_success 'R: feature-only names are rejected on the command line' '
+test_expect_success 'feature-only names are rejected on the command line' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -511,7 +511,7 @@ test_expect_success 'R: feature-only names are rejected on the command line' '
 	)
 '
 
-test_expect_success 'R: die on invalid option argument' '
+test_expect_success 'die on invalid option argument' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -525,7 +525,7 @@ test_expect_success 'R: die on invalid option argument' '
 	)
 '
 
-test_expect_success 'R: ignore non-git options' '
+test_expect_success 'ignore non-git options' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -615,7 +615,7 @@ setup_marks_repo () {
 #
 # filemodify, three datarefs
 #
-test_expect_success 'S: filemodify with garbage after mark must fail' '
+test_expect_success 'filemodify with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -633,7 +633,7 @@ test_expect_success 'S: filemodify with garbage after mark must fail' '
 '
 
 # inline is misspelled; fast-import thinks it is some unknown dataref
-test_expect_success 'S: filemodify with garbage after inline must fail' '
+test_expect_success 'filemodify with garbage after inline must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -653,7 +653,7 @@ test_expect_success 'S: filemodify with garbage after inline must fail' '
 	)
 '
 
-test_expect_success 'S: filemodify with garbage after sha1 must fail' '
+test_expect_success 'filemodify with garbage after sha1 must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -674,7 +674,7 @@ test_expect_success 'S: filemodify with garbage after sha1 must fail' '
 #
 # notemodify, three ways to say dataref
 #
-test_expect_success 'S: notemodify with garbage after mark dataref must fail' '
+test_expect_success 'notemodify with garbage after mark dataref must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -691,7 +691,7 @@ test_expect_success 'S: notemodify with garbage after mark dataref must fail' '
 	)
 '
 
-test_expect_success 'S: notemodify with garbage after inline dataref must fail' '
+test_expect_success 'notemodify with garbage after inline dataref must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -711,7 +711,7 @@ test_expect_success 'S: notemodify with garbage after inline dataref must fail'
 	)
 '
 
-test_expect_success 'S: notemodify with garbage after sha1 dataref must fail' '
+test_expect_success 'notemodify with garbage after sha1 dataref must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -732,7 +732,7 @@ test_expect_success 'S: notemodify with garbage after sha1 dataref must fail' '
 #
 # notemodify, mark in commit-ish
 #
-test_expect_success 'S: notemodify with garbage after mark commit-ish must fail' '
+test_expect_success 'notemodify with garbage after mark commit-ish must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -752,7 +752,7 @@ test_expect_success 'S: notemodify with garbage after mark commit-ish must fail'
 #
 # from
 #
-test_expect_success 'S: from with garbage after mark must fail' '
+test_expect_success 'from with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -777,7 +777,7 @@ test_expect_success 'S: from with garbage after mark must fail' '
 #
 # merge
 #
-test_expect_success 'S: merge with garbage after mark must fail' '
+test_expect_success 'merge with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -811,7 +811,7 @@ test_expect_success 'S: merge with garbage after mark must fail' '
 #
 # tag, from markref
 #
-test_expect_success 'S: tag with garbage after mark must fail' '
+test_expect_success 'tag with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -831,7 +831,7 @@ test_expect_success 'S: tag with garbage after mark must fail' '
 #
 # cat-blob markref
 #
-test_expect_success 'S: cat-blob with garbage after mark must fail' '
+test_expect_success 'cat-blob with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -846,7 +846,7 @@ test_expect_success 'S: cat-blob with garbage after mark must fail' '
 #
 # ls markref
 #
-test_expect_success 'S: ls with garbage after mark must fail' '
+test_expect_success 'ls with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -858,7 +858,7 @@ test_expect_success 'S: ls with garbage after mark must fail' '
 	)
 '
 
-test_expect_success 'S: ls with garbage after sha1 must fail' '
+test_expect_success 'ls with garbage after sha1 must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -893,7 +893,7 @@ test_expect_success 'S: ls with garbage after sha1 must fail' '
 #
 test_path_eol_success () {
 	local test="$1" path="$2" unquoted_path="$3"
-	test_expect_success "S: paths at EOL with $test must work" '
+	test_expect_success "paths at EOL with $test must work" '
 		test_when_finished "git branch -D S-path-eol" &&
 
 		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF >out 2>err &&
@@ -1002,7 +1002,7 @@ test_path_eol_success 'octal escapes'   '"\150\151\056\143"' 'hi.c'
 #
 test_path_space_success () {
 	local test="$1" path="$2" unquoted_path="$3"
-	test_expect_success "S: paths before space with $test must work" '
+	test_expect_success "paths before space with $test must work" '
 		test_when_finished "git branch -D S-path-space" &&
 
 		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF 2>err &&
@@ -1067,7 +1067,7 @@ test_path_space_success 'octal escapes'      '"\150\151\056\143"' 'hi.c'
 #
 test_path_fail () {
 	local change="$1" what="$2" prefix="$3" path="$4" suffix="$5" err_grep="$6"
-	test_expect_success "S: $change with $what must fail" '
+	test_expect_success "$change with $what must fail" '
 		test_must_fail git fast-import <<-EOF 2>err &&
 		blob
 		mark :1
@@ -1130,7 +1130,7 @@ test_path_eol_fail   'ls (in commit)' 'ls :2 '       path
 # When 'ls' has no <dataref>, the <path> must be quoted.
 test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path
 
-test_expect_success 'E: rfc2822 date, --date-format=raw' '
+test_expect_success 'rfc2822 date, --date-format=raw' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -1153,7 +1153,7 @@ test_expect_success 'E: rfc2822 date, --date-format=raw' '
 	)
 '
 
-test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
+test_expect_success 'rfc2822 date, --date-format=rfc2822' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
diff --git a/t/t9308-fast-import-stream.sh b/t/t9308-fast-import-stream.sh
index f8743cbfa4..cb361c0369 100755
--- a/t/t9308-fast-import-stream.sh
+++ b/t/t9308-fast-import-stream.sh
@@ -26,7 +26,7 @@ test_expect_success 'truncated stream complains' '
 	)
 '
 
-test_expect_success !MINGW 'R: print old blob' '
+test_expect_success !MINGW 'print old blob' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -44,7 +44,7 @@ test_expect_success !MINGW 'R: print old blob' '
 	)
 '
 
-test_expect_success !MINGW 'R: in-stream cat-blob-fd not respected' '
+test_expect_success !MINGW 'in-stream cat-blob-fd not respected' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -71,7 +71,7 @@ test_expect_success !MINGW 'R: in-stream cat-blob-fd not respected' '
 	)
 '
 
-test_expect_success !MINGW 'R: print mark for new blob' '
+test_expect_success !MINGW 'print mark for new blob' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -90,7 +90,7 @@ test_expect_success !MINGW 'R: print mark for new blob' '
 	)
 '
 
-test_expect_success !MINGW 'R: print new blob' '
+test_expect_success !MINGW 'print new blob' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -114,7 +114,7 @@ test_expect_success !MINGW 'R: print new blob' '
 	)
 '
 
-test_expect_success !MINGW 'R: print new blob by sha1' '
+test_expect_success !MINGW 'print new blob by sha1' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -149,7 +149,7 @@ setup_big_file () {
 	)
 }
 
-test_expect_success 'R: print two blobs to stdout' '
+test_expect_success 'print two blobs to stdout' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -192,7 +192,7 @@ test_expect_success 'R: print two blobs to stdout' '
 	)
 '
 
-test_expect_success PIPE 'R: copy using cat-file' '
+test_expect_success PIPE 'copy using cat-file' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -244,7 +244,7 @@ test_expect_success PIPE 'R: copy using cat-file' '
 	)
 '
 
-test_expect_success PIPE 'R: print blob mid-commit' '
+test_expect_success PIPE 'print blob mid-commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -281,7 +281,7 @@ test_expect_success PIPE 'R: print blob mid-commit' '
 	)
 '
 
-test_expect_success PIPE 'R: print staged blob within commit' '
+test_expect_success PIPE 'print staged blob within commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -322,7 +322,7 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 	)
 '
 
-test_expect_success 'R: quiet option results in no stats being output' '
+test_expect_success 'quiet option results in no stats being output' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -341,7 +341,7 @@ test_expect_success 'R: quiet option results in no stats being output' '
 	)
 '
 
-test_expect_success 'R: feature done means terminating "done" is mandatory' '
+test_expect_success 'feature done means terminating "done" is mandatory' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -352,7 +352,7 @@ test_expect_success 'R: feature done means terminating "done" is mandatory' '
 	)
 '
 
-test_expect_success 'R: terminating "done" with trailing gibberish is ok' '
+test_expect_success 'terminating "done" with trailing gibberish is ok' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -370,7 +370,7 @@ test_expect_success 'R: terminating "done" with trailing gibberish is ok' '
 	)
 '
 
-test_expect_success 'R: terminating "done" within commit' '
+test_expect_success 'terminating "done" within commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -433,7 +433,7 @@ import_reference_commit () {
 	INPUT_END
 }
 
-test_expect_success 'O: comments are all skipped' '
+test_expect_success 'comments are all skipped' '
 	setup_import_repo &&
 	(
 		cd repo &&
@@ -485,7 +485,7 @@ test_expect_success 'O: comments are all skipped' '
 	)
 '
 
-test_expect_success 'O: blank lines not necessary after data commands' '
+test_expect_success 'blank lines not necessary after data commands' '
 	setup_import_repo &&
 	(
 		cd repo &&
@@ -523,7 +523,7 @@ test_expect_success 'O: blank lines not necessary after data commands' '
 	)
 '
 
-test_expect_success 'O: blank lines not necessary after other commands' '
+test_expect_success 'blank lines not necessary after other commands' '
 	setup_import_repo &&
 	(
 		cd repo &&
@@ -577,7 +577,7 @@ test_expect_success 'O: blank lines not necessary after other commands' '
 	)
 '
 
-test_expect_success 'O: progress outputs as requested by input' '
+test_expect_success 'progress outputs as requested by input' '
 	setup_import_repo &&
 	(
 		cd repo &&
@@ -616,7 +616,7 @@ test_expect_success 'O: progress outputs as requested by input' '
 ##
 ## R: very large blobs
 ##
-test_expect_success 'R: blob bigger than threshold' '
+test_expect_success 'blob bigger than threshold' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -671,7 +671,7 @@ w_input () {
 	W_INPUT_END
 }
 
-test_expect_success !MINGW 'W: get-mark & empty orphan commit with no newlines' '
+test_expect_success !MINGW 'get-mark & empty orphan commit with no newlines' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -681,7 +681,7 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with no newlines'
 	)
 '
 
-test_expect_success !MINGW 'W: get-mark & empty orphan commit with one newline' '
+test_expect_success !MINGW 'get-mark & empty orphan commit with one newline' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -691,7 +691,7 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with one newline'
 	)
 '
 
-test_expect_success !MINGW 'W: get-mark & empty orphan commit with ugly second newline' '
+test_expect_success !MINGW 'get-mark & empty orphan commit with ugly second newline' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -707,7 +707,7 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with ugly second n
 	)
 '
 
-test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous third newline' '
+test_expect_success !MINGW 'get-mark & empty orphan commit with erroneous third newline' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -718,7 +718,7 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous thi
 	)
 '
 
-test_expect_success ICONV 'X: handling encoding' '
+test_expect_success ICONV 'handling encoding' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -740,7 +740,7 @@ test_expect_success ICONV 'X: handling encoding' '
 	)
 '
 
-test_expect_success 'X: replace ref that becomes useless is removed' '
+test_expect_success 'replace ref that becomes useless is removed' '
 	test_when_finished "rm -rf testrepo" &&
 	git init -qb main testrepo &&
 	(
@@ -771,7 +771,7 @@ test_expect_success 'X: replace ref that becomes useless is removed' '
 
 for root in '""' ''
 do
-	test_expect_success "T: ls root ($root) tree" '
+	test_expect_success "ls root ($root) tree" '
 		test_when_finished "rm -rf repo" &&
 		git init repo &&
 		(
@@ -790,7 +790,7 @@ do
 	'
 done
 
-test_expect_success 'I: export-pack-edges' '
+test_expect_success 'export-pack-edges' '
 	test_when_finished "rm -rf repo" &&
 	git init -b main repo &&
 	(
diff --git a/t/t9309-fast-import-checkpoint.sh b/t/t9309-fast-import-checkpoint.sh
index 64674dcf83..5c1e80c240 100755
--- a/t/t9309-fast-import-checkpoint.sh
+++ b/t/t9309-fast-import-checkpoint.sh
@@ -91,7 +91,7 @@ setup_checkpoint_repo () {
 	INPUT_END
 }
 
-test_expect_success PIPE 'V: checkpoint helper does not get stuck with extra output' '
+test_expect_success PIPE 'checkpoint helper does not get stuck with extra output' '
 	setup_checkpoint_repo &&
 	cat >repo/input <<-INPUT_END &&
 	progress foo
@@ -103,7 +103,7 @@ test_expect_success PIPE 'V: checkpoint helper does not get stuck with extra out
 	background_import_still_running
 '
 
-test_expect_success PIPE 'V: checkpoint updates refs after reset' '
+test_expect_success PIPE 'checkpoint updates refs after reset' '
 	setup_checkpoint_repo &&
 	cat >repo/input <<-\INPUT_END &&
 	reset refs/heads/V
@@ -116,7 +116,7 @@ test_expect_success PIPE 'V: checkpoint updates refs after reset' '
 	background_import_still_running
 '
 
-test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
+test_expect_success PIPE 'checkpoint updates refs and marks after commit' '
 	setup_checkpoint_repo &&
 	cat >repo/input <<-INPUT_END &&
 	commit refs/heads/V
@@ -140,7 +140,7 @@ test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
 
 # Re-create the exact same commit, but on a different branch: no new object is
 # created in the database, but the refs and marks still need to be updated.
-test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no new objects)' '
+test_expect_success PIPE 'checkpoint updates refs and marks after commit (no new objects)' '
 	setup_checkpoint_repo &&
 	git -C repo -c fastimport.unpackLimit=0 fast-import <<-INPUT_END &&
 	commit refs/heads/V
@@ -170,7 +170,7 @@ test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no
 	background_import_still_running
 '
 
-test_expect_success PIPE 'V: checkpoint updates tags after tag' '
+test_expect_success PIPE 'checkpoint updates tags after tag' '
 	setup_checkpoint_repo &&
 	cat >repo/input <<-INPUT_END &&
 	tag Vtag
diff --git a/t/t9310-fast-import-submodule.sh b/t/t9310-fast-import-submodule.sh
index 6e7dbda9f9..1d33ec7055 100755
--- a/t/t9310-fast-import-submodule.sh
+++ b/t/t9310-fast-import-submodule.sh
@@ -72,7 +72,7 @@ setup_gitlinks_repo () {
 	)
 }
 
-test_expect_success 'P: superproject & submodule mix' '
+test_expect_success 'superproject & submodule mix' '
 	setup_gitlinks_repo &&
 	(
 		cd repo &&
@@ -91,7 +91,7 @@ test_expect_success 'P: superproject & submodule mix' '
 	)
 '
 
-test_expect_success 'P: verbatim SHA gitlinks' '
+test_expect_success 'verbatim SHA gitlinks' '
 	setup_gitlinks_repo &&
 	(
 		cd repo &&
@@ -134,7 +134,7 @@ test_expect_success 'P: verbatim SHA gitlinks' '
 	)
 '
 
-test_expect_success 'P: fail on inline gitlink' '
+test_expect_success 'fail on inline gitlink' '
 	setup_gitlinks_repo &&
 	(
 		cd repo &&
@@ -161,7 +161,7 @@ test_expect_success 'P: fail on inline gitlink' '
 	)
 '
 
-test_expect_success 'P: fail on blob mark in gitlink' '
+test_expect_success 'fail on blob mark in gitlink' '
 	setup_gitlinks_repo &&
 	(
 		cd repo &&
@@ -277,7 +277,7 @@ cat >Y-marks <<\Y_INPUT_END
 :4 ff729f5e62f72c0c3978207d9a80e5f3a65f14d7
 Y_INPUT_END
 
-test_expect_success 'Y: rewrite submodules' '
+test_expect_success 'rewrite submodules' '
 	test_when_finished "rm -rf main1" &&
 	test_oid_cache <<-EOF &&
 	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
@@ -294,7 +294,7 @@ test_expect_success 'Y: rewrite submodules' '
 	)
 '
 
-test_expect_success 'Y: reference pending tag or commit' '
+test_expect_success 'reference pending tag or commit' '
 	test_oid_cache <<-EOF &&
 	pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
 	pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
diff --git a/t/t9311-fast-import-refs.sh b/t/t9311-fast-import-refs.sh
index 2bb8ac1d46..3283fe77c0 100755
--- a/t/t9311-fast-import-refs.sh
+++ b/t/t9311-fast-import-refs.sh
@@ -13,7 +13,7 @@ setup_two_commit_repo () {
 	test_commit -C repo two
 }
 
-test_expect_success 'F: non-fast-forward update skips' '
+test_expect_success 'non-fast-forward update skips' '
 	setup_two_commit_repo &&
 	(
 		cd repo &&
@@ -55,7 +55,7 @@ test_expect_success 'F: non-fast-forward update skips' '
 	)
 '
 
-test_expect_success 'G: non-fast-forward update forced' '
+test_expect_success 'non-fast-forward update forced' '
 	setup_two_commit_repo &&
 	(
 		cd repo &&
@@ -83,7 +83,7 @@ test_expect_success 'G: non-fast-forward update forced' '
 	)
 '
 
-test_expect_success 'J: reset existing branch creates empty commit' '
+test_expect_success 'reset existing branch creates empty commit' '
 	setup_two_commit_repo &&
 	(
 		cd repo &&
@@ -112,7 +112,7 @@ test_expect_success 'J: reset existing branch creates empty commit' '
 	)
 '
 
-test_expect_success 'J: tag must fail on empty branch' '
+test_expect_success 'tag must fail on empty branch' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -130,7 +130,7 @@ test_expect_success 'J: tag must fail on empty branch' '
 	)
 '
 
-test_expect_success 'K: reinit branch with from' '
+test_expect_success 'reinit branch with from' '
 	setup_two_commit_repo &&
 	(
 		cd repo &&
@@ -159,7 +159,7 @@ test_expect_success 'K: reinit branch with from' '
 	)
 '
 
-test_expect_success 'T: delete branch' '
+test_expect_success 'delete branch' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -175,7 +175,7 @@ test_expect_success 'T: delete branch' '
 	)
 '
 
-test_expect_success 'T: empty reset doesnt delete branch' '
+test_expect_success 'empty reset doesnt delete branch' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(

-- 
2.56.GIT

