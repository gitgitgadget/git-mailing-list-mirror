Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311418;
	b=viv/4eC3Ouy4isTFARnmQDDd5JsRkuXqNTqoMZwegFT0wrUhAk1F2JgUf6uLoKofOy9u
	 tkatCxC5X5Th01JTlzF7ZdhJDd6aGTMtiElTCYPKQKalop5xKBLXfbMmLhi6FVfVwBi4I
	 Om8U/Kb75Vo4jlsRW/yzUXNKl++/hwPjPiruAgXuQfSguYF/pWyGIcPIT2Csic3Sd0f/E
	 x1OTnH/ZaL8+czFKyyTQiaLdzuYUNLk38gZHYPhfiP50MLRTAatsByUmqoDp6y8W8woQ+
	 LTbuQh5d4Sj9CXwoYBXlFd6C1cBYvKYMVHH/2jBYH/UQbXPvcyJfKlSxB0UcetcZqnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=M9eaDav3d0GBMwX5V9jWnU9Ar9LJZRQH9ui2icmDCuE=;
	b=0vkxP4OBB4xjz6kpLoMcnvbJEKTlXdvtXAqYno47zOuVk9+KEdsHvYhsdtGt/8MQBh5A
	 g9p/6/JSLp9oTjhV0P4H0gsPnGK87J3CrW0v0bhz0gcOOMEIo6TNQg49xAjXhMKqMMhsC
	 LoQF27hXY1m4dBRP5efh7fZKCrHIToLSxjhcRMxecADWfSZKhFJlG1kRiTKrRBEaQHGEB
	 P6sD0T5Z4EkjvNub9JBPlv1SJflEU+k8gUfQdvd3ePuFCx0701LTWpQ+cCN83baE62CyF
	 A1/7diigv0Z1RpQMmORT+qKRb89TN3Uxy9hQwaQuLgfw3B5RIVwxtREJLV7Vcl9YrVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XNLCX8EB;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4A606C611
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4E4A606C611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XNLCX8EB
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so12432885e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311416; x=1794916216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9eaDav3d0GBMwX5V9jWnU9Ar9LJZRQH9ui2icmDCuE=;
        b=XNLCX8EBo+7C5cEd6VSxBB8sZg75cLU8JlSgshC2cX6oNCyl7wovGUNHRhCgt008f5
         7hiOdFUIzTm/1EinYRZHFyzdQxN2r+MhUe/2VHxeRr1sOsYrTuRMW+npe9iFr2U0GVTY
         eEQQAbnr9MwGxfgfPTkGbhFvkoL9L4qoGh12a/uLYl8/wBlJTvh5GEWdwpv6AdFlxbbO
         AaNIp+208uvlCGDFTCIha2fcFVzTCfqa1Q4KX6a5Q7jXlaIdM816WSfhH0YHqSRmF5sN
         8C5ouOsjh+Jk3+/WI8SCEjR3ExNvvm6+B57enGht4fU3yqikOTYY/Yw8lphi3s2QQdaA
         dFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311416; x=1794916216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9eaDav3d0GBMwX5V9jWnU9Ar9LJZRQH9ui2icmDCuE=;
        b=JzWFyjtr8tAq8GA+QoxTxzqk2GPj+yi0geHQkgNGmitJV0az/TejnWYl3x+3PzRFmb
         z8chm8PuBI8kt+2K19HsOagb+qh4vlInw9wQz/B/GM5fAJlVHnsZkylUYphHizV+nyR0
         kjmAnaUihOMcuNttujiGkHOz4urSokDZoOXG9tiVwcW2aFxqmBFeJCTvRJmv7Q1Nq7hw
         LC/fd/DIsQAz28C95YYCZ3bkEk8nt1vXB8CaSOhzghYo8YzQ6Y94HwQvyA44nAyTwK95
         ytHxaZRtWEWZpqMKghBLNi9guDMyEK0+jHB9IxnP/98xLyMnkNKKxJbFs8hbcITeqaNo
         cplQ==
X-Gm-Message-State: APuU4Z/KUTjWofe6tqW1qbVdqOvx683kv6rrvfXhSqKCTlaay2pLY2Lf
	IuK+7hOMbQ2AjkbbmuCcm/qqS3n5ZnJ1y9eIjx19b9ZYRnfJ/4IZHk4d9stbJg==
X-Gm-Gg: AYBFou0DhKwztKwEVhdLwYnO349yLLeGacoYTgvMAyr+c2vXFLuRFcDVuJosWAdXsgx
	W0hU7fPxLUxNNw8zxdtZqTbkl/4J6bsuQQGFhCg6b20s0ihnN3C+nPWnD/v7VBuWmuvoUtk96p2
	9bs7DW4p359HHJ/IVGMPkaR5U0iDLD1WaMfRqifkF3Nu/ffD9nbp2KJ4Mtn6c+ol8W86msRhkzc
	mefxuVJVhd68gyYzjuMNoCHATcDUUSGV13iG2QsVIUFWpyiHI5+fB5kiJAcTF1BX9JGWdM3aNoB
	AHF29twqUALCaRwwj8Axqgr5lIzYPDos7Bnas4y5qSlh1w2czuqilmwzcdn94kANFRlR1UknqpK
	SS3rQ9H4eadAZabfqF3J9+FM0fEtWUEnKAZejms5qweH+6LIh69lrEaFTKd4J6TLTL3AlW6OnzU
	PEUaZtGaLKTcAPs5GMRMunlZl8OdlV6SJVoUZmVAC3+eCHO3j9st2slpk5moS6zPiOybFkXU423
	Tl2dpGph9K8Qkx/bEGiSeEX4QEsYOZ5NDyE2iUE+OCyVbp8MmCvWJHxDdn65i3PLSbDG0NflPZO
	B/iN8B4G9tLFmyv2Gyw37eowvDmem6/5/lFFJ/IJYYFr5XdXJX70ziVek/tczXPlf4w=
X-Received: by 2002:a05:600c:3e1a:b0:4a1:de8a:603a with SMTP id 5b1f17b1804b1-4ba0233a429mr39782955e9.6.1794311415969;
        Tue, 10 Nov 2026 03:50:15 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:15 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:50:01 +0100
Subject: [PATCH 16/20] t9300: make the feature and option tests
 self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-16-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6510; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=njUZRcKnnAGslQicNBASDZ8U/YD/XjWssnRG4YvXv7g=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOnwbZKDkB1RTkkiE5gk3n+dugOpJxiXQ
 nbjRrivgRKk94kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTpAAoJED7VnySO
 Rox/IMUL/j6b/vzUYaR/xoW37y4TRLw9I7Jc4ED0I9CtGxLcEi6b//ksparjrHOB35dvCdk47UJ
 3g6m5y6b4p7sFreVQmcz8bhrwL2+o2Ouia2W28EDwcaPFkgufQ5c7ypdnNtfrq+GwrYDQAjRiKz
 bL7R+4/xYhumu6Yh00iDWfxG8Ud4THtVlRnOkE3L11q3Gi8P1q655mLT+WrZNDj+44jkh8cfzkU
 oAv3T/S2cMaYIHnNoERog6GJdWueSD3dMz1l/+wB9ZO4E5WX9bBtpGXLAJGc9bMF9sgILVPzH42
 tMVX2DkyS8MP31Xf5ElffeGzCmI7Qz7tkifkqcPVfgFvOgklSPp3beLU/oo957TjN548gHCrOVi
 WAkLpm0nU67KhGZD0Q9K9LBSHYet9IMo38HyQWZa+QKa0YIzEW5SpaD+sOiDcnwtCWx0f7RiCHU
 SmAPAZpabO4UNA6+4w6uP152DXxUAvssq498UtY1kd2pavosGSA5xcPMvvrI77aCLFjiCF8dgT9
 W4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series R' which
check the 'feature' command and the command line options to make them
independent of state from previous tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 188 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 136 insertions(+), 52 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3f0e7b8b1f..cf00e4faf9 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2607,54 +2607,90 @@ test_expect_success 'Q: deny note on empty branch' '
 ###
 
 test_expect_success 'R: abort on unsupported feature' '
-	cat >input <<-EOF &&
-	feature no-such-feature-exists
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_must_fail git fast-import <input
+		cat >input <<-EOF &&
+		feature no-such-feature-exists
+		EOF
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'R: supported feature is accepted' '
-	cat >input <<-EOF &&
-	feature date-format=now
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	git fast-import <input
+		cat >input <<-EOF &&
+		feature date-format=now
+		EOF
+
+		git fast-import <input
+	)
 '
 
 test_expect_success 'R: abort on receiving feature after data command' '
-	cat >input <<-EOF &&
-	blob
-	data 3
-	hi
-	feature date-format=now
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_must_fail git fast-import <input
+		cat >input <<-EOF &&
+		blob
+		data 3
+		hi
+		feature date-format=now
+		EOF
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'R: import-marks features forbidden by default' '
-	>git.marks &&
-	echo "feature import-marks=git.marks" >input &&
-	test_must_fail git fast-import <input &&
-	echo "feature import-marks-if-exists=git.marks" >input &&
-	test_must_fail git fast-import <input
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		>git.marks &&
+		echo "feature import-marks=git.marks" >input &&
+		test_must_fail git fast-import <input &&
+		echo "feature import-marks-if-exists=git.marks" >input &&
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'R: only one import-marks feature allowed per stream' '
-	>git.marks &&
-	>git2.marks &&
-	cat >input <<-EOF &&
-	feature import-marks=git.marks
-	feature import-marks=git2.marks
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_must_fail git fast-import --allow-unsafe-features <input
+		>git.marks &&
+		>git2.marks &&
+		cat >input <<-EOF &&
+		feature import-marks=git.marks
+		feature import-marks=git2.marks
+		EOF
+
+		test_must_fail git fast-import --allow-unsafe-features <input
+	)
 '
 
 test_expect_success 'R: export-marks feature forbidden by default' '
-	echo "feature export-marks=git.marks" >input &&
-	test_must_fail git fast-import <input
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature export-marks=git.marks" >input &&
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'R: export-marks feature results in a marks file being created' '
@@ -2969,17 +3005,35 @@ test_expect_success 'R: feature no-relative-marks should be honoured' '
 
 
 test_expect_success 'R: feature ls supported' '
-	echo "feature ls" |
-	git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature ls" |
+		git fast-import
+	)
 '
 
 test_expect_success 'R: feature cat-blob supported' '
-	echo "feature cat-blob" |
-	git fast-import
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature cat-blob" |
+		git fast-import
+	)
 '
 
 test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
-	test_must_fail git fast-import --cat-blob-fd=-1 </dev/null
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --cat-blob-fd=-1 </dev/null
+	)
 '
 
 test_expect_success !MINGW 'R: print old blob' '
@@ -3334,38 +3388,68 @@ test_expect_success 'R: terminating "done" within commit' '
 '
 
 test_expect_success 'R: die on unknown option' '
-	cat >input <<-EOF &&
-	option git non-existing-option
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_must_fail git fast-import <input
+		cat >input <<-EOF &&
+		option git non-existing-option
+		EOF
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'R: unknown commandline options are rejected' '\
-	test_must_fail git fast-import --non-existing-option < /dev/null
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --non-existing-option < /dev/null
+	)
 '
 
 test_expect_success 'R: feature-only names are rejected on the command line' '
-	for opt in --alias --get-mark --ls --notes
-	do
-		test_must_fail git fast-import "$opt" </dev/null || return 1
-	done
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		for opt in --alias --get-mark --ls --notes
+		do
+			test_must_fail git fast-import "$opt" </dev/null || return 1
+		done
+	)
 '
 
 test_expect_success 'R: die on invalid option argument' '
-	echo "option git active-branches=-5" |
-	test_must_fail git fast-import &&
-	echo "option git depth=" |
-	test_must_fail git fast-import &&
-	test_must_fail git fast-import --depth="5 elephants" </dev/null
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "option git active-branches=-5" |
+		test_must_fail git fast-import &&
+		echo "option git depth=" |
+		test_must_fail git fast-import &&
+		test_must_fail git fast-import --depth="5 elephants" </dev/null
+	)
 '
 
 test_expect_success 'R: ignore non-git options' '
-	cat >input <<-EOF &&
-	option non-existing-vcs non-existing-option
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	git fast-import <input
+		cat >input <<-EOF &&
+		option non-existing-vcs non-existing-option
+		EOF
+
+		git fast-import <input
+	)
 '
 
 test_expect_success 'R: corrupt lines do not mess marks file' '

-- 
2.56.GIT

