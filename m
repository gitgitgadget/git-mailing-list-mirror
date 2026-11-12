Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504858;
	b=OzS91V8xxZo/8Q9SqyksJ9ds+KUlIDYRjvKeaTkWjAeFsUxSYT1bc+Ut+xEVs99+SDX2
	 q85KsW+i6Jpks/sLH4h3a/05wT39TkmKU9btwZCt3HURB5Q4vN0QPRiXbvi1m7pkZcS2k
	 8Wvb7dJiOF+0jdYMehCdG/1MFEKS/inHqamyyxUctIW0jkAmdtq7MNbcKaf4iqvKKoOWO
	 65SEPkQjicr6lXh0D4kHJIQJSmBEEg5v2crH7Ju6kQR0nRsl8vM07ZLgFltlW9rS9DKkS
	 5MU9or/gxkXV09/+VFICYTcng4My/i2XXTglGr/6ohbWJ1CZ82fPWhQPNYKK995o50w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SEDYuUqGYStUi5w3CX4KhU214csb5JlywsQfoVwOjIE=;
	b=ZBYXnI3x0/cBU2It8IxA+QQ8PUq3YBduqt2xhlKfCpQtKSRoxpQY6SF7do+QPTMQNrPB
	 KQ8AO5qGmHRXRQHQXhFU9VjDxQaMU/po1AnFSX3tn+MzI5FJG+oLmOQ/nfLY1LhaSpDy/
	 63FgLJDpSJkz9Iry61Kc2fVCylQOV2KFkmoAwN5BWtRaEAxJpnHZPGLiPPF1JpU2dfXMs
	 tAfhDTDdGkaotyiLA7GGChUzYg/9VBjv+9uCktomTUChme+BBgW89pBchw70gnIWkDKJ1
	 8cFxjzt1IArIdH/oP6ZAxp/LeQECTn/3SgQmBTDmzPayaRGa8R7/yu2R3dbE/zbZmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A0q2ogN/";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D0606A204
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4D0606A204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0q2ogN/
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so356355e9.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504857; x=1795109657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SEDYuUqGYStUi5w3CX4KhU214csb5JlywsQfoVwOjIE=;
        b=A0q2ogN/SNtFk5Gb+u6/qpsvZU/GoPP+cLQ58bvzImbaWBYTNLRD5FyfSFgCH0sUWv
         wsig9a+5OGndxfadT4Mm/X67kHnXnCVemeLnTCkagt/EtJvlMAegQ1E0BSxbXH503SZq
         DrD2FO+Jiyzqxf2AKhBDZs2dbIj3SRVBA6EBJ3PWV+Sw+AgPBvxkNPlQte/arbZEzF6L
         hu9wIK3w+egBmUMVBZtIIf0Au5WjyKEbNYz2YcROMfmeCGM5K9bmQFrUVN3LaN4ZR2ed
         SmOAVELwjF9Om1ci/Q2TgZyN8FEYjRksXf8FjX50E1zkKahYtZjF0gq0Ei4Kw1/YuGDM
         iCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504857; x=1795109657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SEDYuUqGYStUi5w3CX4KhU214csb5JlywsQfoVwOjIE=;
        b=Iil0giNWKyCYCuFzLaClYZc3JqCqWO8GcQcPwhD0pf8UDAqt4ijmjn9K6RmwwalFU7
         HMMy0t6gmqS+I9cvUWGNSRpKr66FCn2GpEBjY4mEfOcksrxNb+vneDVXZEIUIcLgXZw3
         1A45/CKD8hCcU2QbTmiUoKagmVpfZD/8x2H138xEpfOXUp6q9ZK5NE/RNieWPxBwT478
         KqYZD74gIUTq20VSPhGxAwprevUVoszeEUiHA7PHJbLT+gvOHNuRijQuY1vuWzoY8A+m
         KrvbkoYS2F8kbQzrFg7mTQZ9YfMtl/TouI7VmlMHt5n8Rir7Yt6quSOemNpL/Y6d9AYm
         Q+jw==
X-Gm-Message-State: APuU4Z+OpCnDrccjp90bukFPwGGJc8TkTF0IW1eADFRaIxg5tXZy+/Yz
	d7bArAxNauGE3ZH8NDW1maAqg5x5xWzL28hU1vFvONJUVGV3LwsI4jPkiJD2vA==
X-Gm-Gg: AYBFou3GjwXeDEs4X6cuh24QNldeohfJWXtyskGr15eLkMZKpgQDTqJSaIab55SrFmf
	/Oi65i5f8gH35rquc644z0Qgv2wl3DC8Dju0agx6qkH/FTeCCf/yRP4faUPHa5l0y2Y3dBfRpnM
	pLpXJFepyjM4I9XL1HdDpZ7lJRLJPaDw6+p0owGbECFBeIDgenOLs3abEPNbNnb3aJjHqipM291
	6Xz5FqwB3ANTjiGNydAvBJ1jWCEkBC7rZ7MdibY8IrtpOayaZcVOOlQvyOdH3mIG3NhnJH4KhEy
	1c9eTmKtYxy2+XQuNaeBBDZ8ybbaHwzbmvq7h5t8jQMJgET1YDneeOnfEfPbq/LuqcXQsZmPsqL
	hu7m0ela+HJh8XN67FcILFVIOSuxc8WYn079bmzyOOGq4itV+JNdSb5yWw3HKuldWkzfSM4IGc9
	aPn+RkCgJ4L/lSBc1SJteu5Of+6WT/UW4WrmpROLGtL9AeeF3rnhz7eQJOBWyCGNoVrKo13IewI
	A0iwB+flmzlU3/QIHTbsz1rLh+DveC/u39BBhINYqOi+4c+oyhlEsykL+m2XM3+F323jnjS8GPa
	xq7VO555mwqGur13l3xu2PEaSZBib0pDelm7ACpi24+r8FXc1Cnz+/TVleOHcjUu5SJBC2vyzXV
	7fHazpseBJhtREf8=
X-Received: by 2002:a05:600c:3e1a:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4ba093b967fmr125296905e9.31.1794504856498;
        Thu, 12 Nov 2026 09:34:16 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:15 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:04 +0100
Subject: [PATCH v2 04/20] t9300: make the series S tests self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-4-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11378;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=YTdRXfGa0K72QP4MKUZ2SeZ4xFX/6G3lp5+dBIzt8F8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JCMxWPKI/UheiktvUHGw7/bHpD01kNir
 hmjtRoZt8MlgIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiQAAoJED7VnySO
 Rox/UokL/3Yt4paV+T8R4KVAPi+KQN1KVMOGEe5IQsnuFfKyO75nsXldzApDpekuhez8ck/gkJ8
 Qo0q2r8Aj8U+pkVJTWKJFiUD9nJrDlZ5oRi0dt+HuoKX+rmRV/10NHp86/EXX+3FrezIg7zEKU6
 znkiPx4OZlCeFMOd0QLimglutvZ+znhCrIROm3zqUbeINJv1wWNTK1zPH2qI257dYt36LbOXXFR
 RJDe8i//+VQkqvDoKfMwiUor1OzbtECZLFjx5aEIgfonKrJYxR6EI8lohR8u8Nrjg/c2FrEmeZa
 FfOuF5tv1MlN/N9G00rhzJGXnaeJTD47k6unSkmkXlqUzb8dZhtcOxijwRZkRbnL4cdcNgPfspw
 HDJGuv07kPFHRuZY3OMEUtIzr4nXXJ+XWaM8w6nQ0btXle1xd+PLyxQCB+9cCknfr36KzQD6pbb
 AeGObWWz6MUAuKua5Et7QKc7j9vGIkktm4CoH68jauhDc5pmm1XbztjPLVYr6iHpkSPvWUIgdi9
 7U=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series S' to make
them independent of state from previous tests.

Replace the 'S: initialize for S tests' test with a
'setup_marks_repo()' function, so each test can invoke it to setup its
own repo and tear it down when the test completes.

'S: from with garbage after mark must fail' used to create the 'S2'
commit which 'S: merge with garbage after mark must fail' needs. Create
that commit in the merge test instead.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 332 +++++++++++++++++++++++++++++--------------------
 1 file changed, 198 insertions(+), 134 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index a0e322b866..f9359bbaf3 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3100,10 +3100,12 @@ test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
 #
 #   invalid dataref ..
 #
-test_expect_success 'S: initialize for S tests' '
+setup_marks_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	test_tick &&
 
-	cat >input <<-INPUT_END &&
+	cat >repo/input <<-INPUT_END &&
 	commit refs/heads/S
 	mark :301
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -3140,142 +3142,168 @@ test_expect_success 'S: initialize for S tests' '
 	BLOB
 	INPUT_END
 
-	git fast-import --export-marks=marks <input
-'
+	git -C repo fast-import --export-marks=marks <repo/input
+}
 
 #
 # filemodify, three datarefs
 #
 test_expect_success 'S: filemodify with garbage after mark must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit N
-	COMMIT
-	M 100644 :403x hello.c
-	EOF
-	test_grep "space after mark" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit N
+		COMMIT
+		M 100644 :403x hello.c
+		EOF
+		test_grep "space after mark" err
+	)
 '
 
 # inline is misspelled; fast-import thinks it is some unknown dataref
 test_expect_success 'S: filemodify with garbage after inline must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit N
-	COMMIT
-	M 100644 inlineX hello.c
-	data <<BLOB
-	inline
-	BLOB
-	EOF
-	test_grep "nvalid dataref" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit N
+		COMMIT
+		M 100644 inlineX hello.c
+		data <<BLOB
+		inline
+		BLOB
+		EOF
+		test_grep "nvalid dataref" err
+	)
 '
 
 test_expect_success 'S: filemodify with garbage after sha1 must fail' '
-	sha1=$(grep :403 marks | cut -d\  -f2) &&
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit N
-	COMMIT
-	M 100644 ${sha1}x hello.c
-	EOF
-	test_grep "space after SHA1" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		sha1=$(grep :403 marks | cut -d\  -f2) &&
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit N
+		COMMIT
+		M 100644 ${sha1}x hello.c
+		EOF
+		test_grep "space after SHA1" err
+	)
 '
 
 #
 # notemodify, three ways to say dataref
 #
 test_expect_success 'S: notemodify with garbage after mark dataref must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit S note dataref markref
-	COMMIT
-	N :202x :302
-	EOF
-	test_grep "space after mark" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit S note dataref markref
+		COMMIT
+		N :202x :302
+		EOF
+		test_grep "space after mark" err
+	)
 '
 
 test_expect_success 'S: notemodify with garbage after inline dataref must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit S note dataref inline
-	COMMIT
-	N inlineX :302
-	data <<BLOB
-	note blob
-	BLOB
-	EOF
-	test_grep "nvalid dataref" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit S note dataref inline
+		COMMIT
+		N inlineX :302
+		data <<BLOB
+		note blob
+		BLOB
+		EOF
+		test_grep "nvalid dataref" err
+	)
 '
 
 test_expect_success 'S: notemodify with garbage after sha1 dataref must fail' '
-	sha1=$(grep :202 marks | cut -d\  -f2) &&
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit S note dataref sha1
-	COMMIT
-	N ${sha1}x :302
-	EOF
-	test_grep "space after SHA1" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		sha1=$(grep :202 marks | cut -d\  -f2) &&
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit S note dataref sha1
+		COMMIT
+		N ${sha1}x :302
+		EOF
+		test_grep "space after SHA1" err
+	)
 '
 
 #
 # notemodify, mark in commit-ish
 #
 test_expect_success 'S: notemodify with garbage after mark commit-ish must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/Snotes
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit S note commit-ish
-	COMMIT
-	N :202 :302x
-	EOF
-	test_grep "after mark" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/Snotes
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit S note commit-ish
+		COMMIT
+		N :202 :302x
+		EOF
+		test_grep "after mark" err
+	)
 '
 
 #
 # from
 #
 test_expect_success 'S: from with garbage after mark must fail' '
-	test_must_fail \
-	git fast-import --import-marks=marks --export-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S2
-	mark :303
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit 3
-	COMMIT
-	from :301x
-	M 100644 :403 hello.c
-	EOF
+	setup_marks_repo &&
+	(
+		cd repo &&
 
+		test_must_fail \
+		git fast-import --import-marks=marks --export-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S2
+		mark :303
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit 3
+		COMMIT
+		from :301x
+		M 100644 :403 hello.c
+		EOF
 
-	# go create the commit, need it for merge test
-	git fast-import --import-marks=marks --export-marks=marks <<-EOF &&
-	commit refs/heads/S2
-	mark :303
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	commit 3
-	COMMIT
-	from :301
-	M 100644 :403 hello.c
-	EOF
-
-	# now evaluate the error
-	test_grep "after mark" err
+		test_grep "after mark" err
+	)
 '
 
 
@@ -3283,61 +3311,97 @@ test_expect_success 'S: from with garbage after mark must fail' '
 # merge
 #
 test_expect_success 'S: merge with garbage after mark must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	commit refs/heads/S
-	mark :304
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	merge 4
-	COMMIT
-	from :302
-	merge :303x
-	M 100644 :403 hello.c
-	EOF
-	test_grep "after mark" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		git fast-import --import-marks=marks --export-marks=marks <<-EOF &&
+		commit refs/heads/S2
+		mark :303
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		commit 3
+		COMMIT
+		from :301
+		M 100644 :403 hello.c
+		EOF
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		commit refs/heads/S
+		mark :304
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		merge 4
+		COMMIT
+		from :302
+		merge :303x
+		M 100644 :403 hello.c
+		EOF
+		test_grep "after mark" err
+	)
 '
 
 #
 # tag, from markref
 #
 test_expect_success 'S: tag with garbage after mark must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	tag refs/tags/Stag
-	from :302x
-	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<TAG
-	tag S
-	TAG
-	EOF
-	test_grep "after mark" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		tag refs/tags/Stag
+		from :302x
+		tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<TAG
+		tag S
+		TAG
+		EOF
+		test_grep "after mark" err
+	)
 '
 
 #
 # cat-blob markref
 #
 test_expect_success 'S: cat-blob with garbage after mark must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	cat-blob :403x
-	EOF
-	test_grep "after mark" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		cat-blob :403x
+		EOF
+		test_grep "after mark" err
+	)
 '
 
 #
 # ls markref
 #
 test_expect_success 'S: ls with garbage after mark must fail' '
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	ls :302x hello.c
-	EOF
-	test_grep "space after mark" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		ls :302x hello.c
+		EOF
+		test_grep "space after mark" err
+	)
 '
 
 test_expect_success 'S: ls with garbage after sha1 must fail' '
-	sha1=$(grep :302 marks | cut -d\  -f2) &&
-	test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
-	ls ${sha1}x hello.c
-	EOF
-	test_grep "space after tree-ish" err
+	setup_marks_repo &&
+	(
+		cd repo &&
+
+		sha1=$(grep :302 marks | cut -d\  -f2) &&
+		test_must_fail git fast-import --import-marks=marks <<-EOF 2>err &&
+		ls ${sha1}x hello.c
+		EOF
+		test_grep "space after tree-ish" err
+	)
 '
 
 #

-- 
2.56.GIT

