Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504873;
	b=u2jje04ul37BnqPL5fcS7tIHkq2jYQVS1LfuVBnfwrohmE+cly29zxgrQ2lbms9zfdgh
	 9cEgTlX1dXvP6Bf6xQhfodJeH6iw/pzub6Eh3sgspSnrNl6K/knDplcft4YN6TizlgFwr
	 /fKqHn8aY/BmqYybJVjphGmQWS5S4/fTrDX0Rd0xx8j2jErOIWregmexybkgEn7efyFFy
	 eJQkNo0ggUrtadTxBJEfqwhTchgpcLHOqT5TaIYltFUp7dZ5rSkvls37h2OlSM6+zIvJr
	 qvr4WJ6DHAbbDDGEPnaHRFCDUsCijMmNo1UpnzYinEnFqP33b2K/eoyzvmcTg/nTEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=xh6bovEx0vwtZF1Y6RPbJLb3zh51XvLX3bsOCY4/sEU=;
	b=F/2fVhr3LyrfxKXY8Nu3/FPHhnQku6/QkmJLuv+WQybNEui18xiCzyLQRgo2+vuPZJ6D
	 YYxAPR5761NnqKFD33KQU5ruZ4v5rOBmRJDtOAZ+5Fr9Q0zySHxaeqjAXk6hUqjn8ILuG
	 lGWs7HYBuCt7uM3Gz09qv3KboUkqsse5xGMGVxlZLFF1nqwfvWJSfjis8/087A6RMOKDj
	 iaDRvg6XHkLVF59xgNyAqU738DO+3t5FphAOI6d/M2H87P+yxqoxB0XVtWwVy6ocRQI35
	 SbVHMFrJMOoCexZan2uPphZgOn9OxlQd6QDY8mrF+KWJ2c196q46qNmvSsH28X5q7DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U0K9momm;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA560A3824
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38CA560A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U0K9momm
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b001cd92bso2551f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504872; x=1795109672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xh6bovEx0vwtZF1Y6RPbJLb3zh51XvLX3bsOCY4/sEU=;
        b=U0K9momm6T0UBBSR62KZpitrNRZogDuv9SQFYdtqhv5BFfIAQMdfegqr7dGYDuhS9w
         MVagvci+SytzVPUbIWbfl1vU4jv57cAfzJucrx1mgsKYKHO6YFfVcSewm2eXhJaOS6UI
         mpqGpl/4gUeF5Vxz5wbn7cLDleWdS2JgL6zkd8angeZmDvmNsw36RqYzskrGh6q/1Mpv
         RC+9VKro2YE2FDDODA/CYv3/ZjCnoEFjZrQh0sSjJOBRhM4WfqnHY/FNXVBSKEmsmx3O
         opyviwRMqo2hXJu8oYgkpkY8ehG0GnUMT4FFKdiqMhgYJiLxqaiPzul5jV778elkcyEF
         lDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504872; x=1795109672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xh6bovEx0vwtZF1Y6RPbJLb3zh51XvLX3bsOCY4/sEU=;
        b=sNxW9NJ+qvzA9dfRMBlA5BtO08lBs9ieum7lDCfkeYZkmoNXhxL9re8BJ9eQsACE3e
         3p+0n8VC2E9HKpc4yWq9ALTCLT8BGJUgkfKe9CEyFPM8JoXmjS0nnyNLabOn5f6vPcKZ
         rRJoMx5mSLO+dX6bH0g4qJ+Qqkop1T2oafCAMBa6CeMOqo2kGWgcQJy7aF3OH2yWWE/W
         Ts7l/TMecYDkNSlq+cDghEHjFwb3lBtHY/Ah1NJd+wpF3ch80EXC4vsrTfs/h2V/07qC
         La/JzsIfhG9O8AdtcT+XOvmvFyKzV1IrOMheVl01Ew1is84mniimwUcrAE3rzxnjo4YO
         HtHg==
X-Gm-Message-State: APuU4Z8yvUBzBmbomgzhlhIzlQgbB39bxplynW/dClmptjRXoLpJ5S9u
	DG7F6RceZdhwHWEqJmW77EWDXi5pWX35/HvNRKyyD+R5ZCNNMYuKYPZCM0cdiA==
X-Gm-Gg: AYBFou0eRQB/zZeDsoyDu/5VMCGZgREJUHE5SqO714OcduPa6H0BevmFtObLU8CUWIY
	Ompas7CNl04iuYOH0Y0qyGy7ABM3pIu7g9GsYn9jCVp8t6tyBgMnPIVapM87raulGu3vrYLrpul
	jvd6C/QcmdAF2NwIBQzXTDvOuvy1PoJcVh5E3oux5D/SWGx6lMb+uiSbEFw4+jnwqVG/lZAqvDH
	V7aCNRdTtjAHQ0NRiYGkddEZfPpcVFSABtpvjmSg8KoPWi2msi3WPVgmNVhYc5u5JmszRCBreef
	FMKAv2QJAWTLzqRlEXlf9GrPOEfj9sg1TIj1N9l5OcG6/mEQcyXa4ORETg//5MfaT5iNbYkV/rO
	KptTGCPWrt20QGreVbVpuVLlYOqsOYfdr2VGeLHyvLo0x8NDyHAzhCiXg3swN+ezlThAuNpKkUx
	AnqgRc/8B5Lomkm7xkAit1mV26akZWA4jZuHZJBkz12zwWF6lmv9uNf6UUFx8mENctXZzhPacIR
	NBmOZCzrdy+kXhOqDXzNrMzvMRZ/sEiCgUREQLRwQ9RBO9IzAiCz44AqlHsnIiL1aD3Ydn1+xFL
	C+1SfsIBSMQvhb8itz/M3RjlWalJxj/Q+z6NEP/AyLe/uzz+pHPdjULvGeyxvGPSYeuq
X-Received: by 2002:a05:6000:2381:b0:48d:f3f8:f910 with SMTP id ffacd0b85a97d-49c70de3974mr172605f8f.34.1794504871679;
        Thu, 12 Nov 2026 09:34:31 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:31 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:16 +0100
Subject: [PATCH v2 16/20] t9300: make the feature and option tests
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-16-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10079;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=rH63rYPmjh3Jd/E/jNb0Gx8yDxramvhB+JMUqMFazWE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JJ03hoTDj9kj7PFHPwmZtWFsj4WHGS6M
 JdImNKroKbLeokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiSAAoJED7VnySO
 Rox/JiwL+weJVAOgR4UFHvvSrTX4/cR32SfDwEz5vlN3lA72kDveHUIofFgNJXTR0mTjuGzHU2U
 k915Zg3Lwt1nbAGFWrNLUcgzaRMv+4d/UWM8SpZy6lSfFjCyeOhbyDMW9Ln9EvGlHYhFB7prfS/
 94l4MQ3oqaxRVf6P/QjD1A8qd8p/8GbhfG7QTcREqyt+RqOa0SWXaOzMHuw6Q3Q1Q1Z4ZBlPf0e
 MlKBhM38sC0ixBtmPGx0ziJGrNXI2WwN6CoTVRGtnJXEAYDCxq3yrmWawFcNWUWEtteEjlrnZI9
 19aVGWDr/R+20P9Zf7Orbxq9u28PzlJCBeZTr1mTf9GXCRvDNpDoOUYDmqj7Ie0xYKV50a445ij
 r1pu65/9x5VjL4AEpvhHNuhzIlL9ziDIYJuFbCO27qJaIdTRCFldXDulfgpmU7u+QmFtpskhl3x
 ofYjusElYCKkFHWwtQrkKbhbnHfz1+Upt+JiEFaVnmvRD2VQkO5p8yoy8fFE7135LGd9qP0EQi5
 4s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series R' which
check the 'feature' command and the command line options to make them
independent of state from previous tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 260 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 187 insertions(+), 73 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0dc71648ca..5f84c66ac4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2636,54 +2636,90 @@ test_expect_success 'Q: deny note on empty branch' '
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
@@ -2728,39 +2764,69 @@ test_expect_success 'R: export-marks options can be overridden by commandline op
 '
 
 test_expect_success 'R: --allow-unsafe-features found after a value' '
-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
-	git fast-import --allow-unsafe-features <input &&
-	git fast-import --depth=5 --allow-unsafe-features <input &&
-	git fast-import --depth 5 --allow-unsafe-features <input &&
-	git fast-import --date-format raw --allow-unsafe-features <input
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+		git fast-import --allow-unsafe-features <input &&
+		git fast-import --depth=5 --allow-unsafe-features <input &&
+		git fast-import --depth 5 --allow-unsafe-features <input &&
+		git fast-import --date-format raw --allow-unsafe-features <input
+	)
 '
 
 test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
-	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
-	git fast-import --allow-unsafe <input
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+		GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+		git fast-import --allow-unsafe <input
+	)
 '
 
 test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
-	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
-		git fast-import --allow-unsafe <input 2>err &&
-	test_grep "forbidden in input without --allow-unsafe-features" err
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
+			git fast-import --allow-unsafe <input 2>err &&
+		test_grep "forbidden in input without --allow-unsafe-features" err
+	)
 '
 
 test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
-	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
-		git fast-import --quiet --export-pack \
-		--allow-unsafe-features <input 2>err &&
-	test_grep "forbidden in input without --allow-unsafe-features" err
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+		test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+			git fast-import --quiet --export-pack \
+			--allow-unsafe-features <input 2>err &&
+		test_grep "forbidden in input without --allow-unsafe-features" err
+	)
 '
 
 test_expect_success 'R: --allow-unsafe-features after a non-option' '
-	echo "feature import-marks-if-exists=nonexistent.marks" >input &&
-	test_must_fail git fast-import --depth 5 extra \
-		--allow-unsafe-features <input 2>err &&
-	test_grep "forbidden in input without --allow-unsafe-features" err
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "feature import-marks-if-exists=nonexistent.marks" >input &&
+		test_must_fail git fast-import --depth 5 extra \
+			--allow-unsafe-features <input 2>err &&
+		test_grep "forbidden in input without --allow-unsafe-features" err
+	)
 '
 
 test_expect_success 'R: catch typo in marks file name' '
@@ -3034,17 +3100,35 @@ test_expect_success 'R: feature no-relative-marks should be honoured' '
 
 
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
@@ -3399,38 +3483,68 @@ test_expect_success 'R: terminating "done" within commit' '
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

