Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311409;
	b=unz5Z1GJuC38PaoH6su8QLtXXQp+dw9XAukALW0Y7cTZm9zSl8G3F5bOcSE61jvmxBT4
	 qMzO94K1jadSrskDpnmnKammq9gCzYSLCOm2vq89iZtA8PZb+2Ioq7awNlNu8TyirbShZ
	 ccRBih8rbdH8iPZbO9nn5XENTiLn6n/Lhu8/ajX1kLC0SeOigGmNZIZiTEESlxKWsBhC3
	 t9TxOrIPBR9ARF4oyGTPwOFKFuIp3X8GustP+lugBxrsp6HirVGKGHXt7wK47GtRnnu+n
	 o6JvIZjCGSR4udQEAzTbyoio2+Ulm05UG+l+XzyVeRCMUj7lRijakr4a1hlUoz0LBzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=lGHL4PBtbupBQWz+lIJXgJx570uEMx9mjD1lhJGFVIM=;
	b=L+m8VNr+kxLnI4EU/OD0lcleLCQ5j6K1PRFcwifEoFLWtC4y/9d0vV3GeanbNTtL911p
	 eSNxxIweSKzfo+7dXDlMlbw39LDksDKW/SNC+Q0v9znQ0RBuJ6VXMN21TUC9XRxYaQ/lI
	 VVt0iPVJDwQ4o7e7XpwCELVHE+DaRwjiAdnSGapZzil8mvh+/owmItcgtL7zRzSiXLj6B
	 Ew6FJWUQkeE9FClLp84BQaWA5okr08t+4ESc/aq8LznIZBGmF3j9kEihqujERTJ7Jbasq
	 1NBBEsIEE+xTcmhbXEPGRiNUJ9dL235NZ80mScOQyupo6SznRHmIHpUJUfdvBjBakWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RXEFhcH7;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41C606A987
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C41C606A987
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RXEFhcH7
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so16955125e9.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311407; x=1794916207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGHL4PBtbupBQWz+lIJXgJx570uEMx9mjD1lhJGFVIM=;
        b=RXEFhcH7oEk0wO8WkbyccvDoYPBXPC/307Ox9LCoiixA/2JPkY1Id8lsaqWRpJL4vC
         Kbe3S2HMiBOjgtNIWb+1og0yrxee+voUkaxdT9ZbkcqmY5U3y3NjPS43MBuJuDcJ6jsV
         9u7KtA+TcDMaTK/C69sfWn81JJ2ghxFSG6E+cvpZtPmFvByLAlAC6ETrBGbyplF/ABVi
         JKkhiy3/Lhq/KedqvguSwoHFVQsz3FVSqSOBUtAjC3cnggf0a74kyvT2pm5OEDlHL2iz
         CkFohE9fGZuwHnRxXEuH2EGOMnMc9NLZe2uzDfAeGGjiSVehpu3MZXRnmbSxj0FRnwzc
         BSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311407; x=1794916207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGHL4PBtbupBQWz+lIJXgJx570uEMx9mjD1lhJGFVIM=;
        b=j6gPAipwQAVzasf0J5A5aoEI6dQ9gVyRCeqKipmHR2FUOsWIwgM7zES2QoEwnEJvxb
         //TjlKFgO0QjWdxX5GCTWE3g4L64h8dLSJ5vz3O8DgKep/CXiX10nxWq4ASsH6s4WJXj
         SZzLk/QoacbgStH/UWDlAXa0gn6ZJJjtscxWpSyjzDsPgLKwcYV2E8fif1j6Tzu2H186
         dlLp8WJl9pxTUZ1eSBeCty9cMeNc5381Ah5+uyXA7ZEp7vcyZf4pejd1ccKp/bYRuk/f
         ZoWV65YiZsfGRWdTncIVwlgb+ZRZ5RV2l6/poQB3UOqaSGHhzC48O73LtQrXOsl/vjer
         ShMw==
X-Gm-Message-State: APuU4Z+Ca3ks+AMQYHyzJtVf1uWXLTq+VTafS0tA7Puvb4di+W1N2GoE
	p/pmDAlSCXccDNaXXqKxJ9z58j99NAWoFLFe11OiGm0+y3tY1p1Mamk4Xyw2Ww==
X-Gm-Gg: AYBFou0+xhHNFgCn0IclfubDMwX5DZ3O3XBMHHh2wfKYB7RV5/OAqBzX5URZxIenpYs
	OscwKMCdGIQdaJNwAXewGQji5PCqibpTS/rjO7d4YXHlNtZaYvJ7dVPlXC+pbXC7ux4yEye8Cw2
	Ndct25rH8xezGjJjTHs3zS7ubpLjVzkug+/0Y3PXzrzSWGNIiWQLaix1y0jL1WHVGEHjsJVlxMh
	vm317c5LBGRaXR3nOKssxylIxmo62dS9XP+mQcr1TUZYbL8hAE/BkCtWIR1yj2TdERj2awBMiS6
	nVUsoQURrvDwRuyXKPOJMqFlB9CW1jiAESBa2NoFuqrjkLy3NRzWkIsz2+zc9308VQGMmnFMMsX
	s5h86kgDZC/55rweW34lM6HNgJlmCC8MB2oOA6voQ6lUKUTkPg5ssdJaxx2pgtekY/gBbkJWk6L
	pNkbTlPzGe7ahJYgKvp3FTlaDNPijzgh9R9zflz48sDDNe6bUO8ZQMud/dPWudAlztiDwaylMng
	ZCFV9OF/KXmuOrHUGs7TQ6jnLE1vPcnJYA1GoKqKFFo9RDl13xuGUlq4sMMyiHw1YxcsjbCua9M
	724ASv3C+rspC6EwOxr95M0GZhG5d5lGUd/+3zTz7srSlBpR8WR+MX8wmU4t9xRydH4=
X-Received: by 2002:a05:600c:8b21:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4ba023085c6mr36632335e9.4.1794311407278;
        Tue, 10 Nov 2026 03:50:07 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:06 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:49 +0100
Subject: [PATCH 04/20] t9300: make the series S tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-4-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11348;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=YmpaUkALuzbjKncoXbRh4bWzrMFdX+JMkv3pff1e4Bo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOVV6wiX1P/EcqBFXkl+ZbXvvCrzj+7gE
 ZlCP7XjaJUUyokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTlAAoJED7VnySO
 Rox/ZcUL/082bZmoRZTzZrYh1y6gvVv5tmD8IVbFCdv1dXSvhY2QWszoM2BIL2iNCGE0fIn9LrX
 F4MReARRbSEWUib09oFmlKRJDowhttF6LcjeRpR+p8c2XpAWRgtO2Pz0bk7wUo85cPTWyiVIdaG
 crxM9QX2aBGnsOYuVg5Xx59hMPZi/INQrZoermOncmkIPyK8/bvpW01vwDBS+5uw36Scz9UeAZR
 6F/3gyrJmXBSxoX3KSTHbtyYqB4aZiVtBPX7XRHarQ9HVCcoYuR/4YzIU/ZqX5k6kMia9AieTr7
 dATGMviVos+UI0JZdf4UY6/xzmSF62h8mlX7Eeh1Q9yRzZDJXtwnrdIIqiyXGKoFBkqoouhQkKu
 u9yWQjJty3xgLJVYHCntwvbJtFHrtz5Gk+RQub64Q76Dj6hqCJsKVKsqS5LxSJqhuQw37KM1WbR
 Moh1669IU6H/+Y9iFUjQITITl3dFi1hkuAIasFvgoukBfSa3scKbbf9ReFVxykentRKB4IC+tG5
 Ik=
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
index 76cc9504eb..14af91cffd 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3023,10 +3023,12 @@ test_expect_success 'R: blob appears only once' '
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
@@ -3063,142 +3065,168 @@ test_expect_success 'S: initialize for S tests' '
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
 
 
@@ -3206,61 +3234,97 @@ test_expect_success 'S: from with garbage after mark must fail' '
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

