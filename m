Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504878;
	b=ljm/qZFQiyEYsV2E0woqIPJu3SOidnPzYhrRecdus+92P/USB2abnfpDDe6DWSv8vfYi
	 We7XCYOyO+Kd7XhLJs2mpkeu70ZBM16fmKg4SK8zmJNCwNq/8WjJetV+dDLu1HMg+vJR5
	 cz8PTsZ4LAcavviA2iUGatHZFMihobqqTwwFZ4sk6k/XPfgLVRHrybcrnX0+w0SATgwNJ
	 dosUIrVEX3voqYywV+vO+ySOXNuT4nB1G1lGlTEwM696Wke8sZdIcaPQ9Odzl74RyWQO0
	 A9KExHfDnW5Fh1j+2MPkw8a6QDQ+86JGzxASvrLbv9GTJ3kYpkx+1h2fy0ryb/xXT0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Vmd6x5+OMU0xJ+2ZqvGWbWgGAkDPRquL3LWr8sniZYg=;
	b=BmCxoCQ8E2VCnRoX8pQeN0PZpMnSYhEqPjOJ/G/3WNR2/Jz1VMkfWKGQ2eenBadyK8FN
	 y5Q122UyCX7XvXZaD90iTG/H8AbOGoBbDsDniQSUWrjfJg8hRlryCX4zhPwUBjxtZMY4Y
	 6izsJRY92OpNDyq0TA6TadxWyacfLaH6YT2RxYwB/mSvY1N80ltzSyzBzjv8aAMt3KviY
	 Qi9ccH0kM+xqFaLcp2G0ffHksFL+gP81uj7GvN9qM/mcGveXGxwzMJVeikjxwzt/tf6at
	 MILPc+n6rCYQzrBrk7FLTUxeg0YTNQqlfZ8iXGyXTPqolj4lTL020X0aRQCUMMio2yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VK0H+0b7;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D73606DF26
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D73606DF26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VK0H+0b7
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48fd2e38825so1332f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504876; x=1795109676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vmd6x5+OMU0xJ+2ZqvGWbWgGAkDPRquL3LWr8sniZYg=;
        b=VK0H+0b7IE0tb9JC6W4z8fjcu2Z9f6MFHwC5SA9J9QNmnwLK9Cs1vBfjwYlFzVoaq/
         TC7LhCGm08LrogWLgWJ8z9swCIlkpZArCa+hwXpe6ea9l6UXf6BftWetY4lyTJBOqSA2
         vGL3A/VI+rebfWWJFh+aC3SmoJyb8xyHfJlSZ5BljIeAbhJODVd9Xp62xIYcmigCBalR
         CK6EccQOBVu7THHgnAuiB6/dNOtiaZJjOwKL/TMVWbe/H5O1XGrW1DWqpWep2AdTLv18
         FlB9RPrdSWdMJv7LfJaI3wSGpMQEYV8WR3L0NrqGAeuL734PqMXYG74aetEvWcoidjRM
         8a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504876; x=1795109676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vmd6x5+OMU0xJ+2ZqvGWbWgGAkDPRquL3LWr8sniZYg=;
        b=hn5r0G0ipRagGAoN2F3NDT3SDmAoIDOVL0EcRu0vk3Vg3BIKJ9AyofK62EHyKpbBZ9
         b6fXA19emNWknGX5CPkB9MK1Rn1tM4lpBmWfVEjo8IOqAB6Dzx9I2CmPg1LAwrMBZEym
         KT2TqWl7cHW1oRDo4V2w1MYExzQCm9Si5z2wiP4mSst+CTOYv3it+uSf9jO3xjdkFsWK
         UgfK7Yf7DKnq97oGH4Oy14JRHthdAv6hIqPIFG3RXcdqgucSzUT1KJozfybw7KLDy0jK
         MGhHnYk9xSRHBz45q/zSCRU4tdVYT7kpksZUpLz2rRs8yI02Qrf6vFc06qMQeYcxlcSn
         +INg==
X-Gm-Message-State: APuU4Z9v4TZEpNZOkMOXcn2sX971unnS7D0JrtpzlikvNLMp8h8EXCfH
	OCCOUG8TlckOcnjW93W2ek4X/4iBMV8NjtQeV39uhWQyiNm5Y+JFuK3oKx3bjQ==
X-Gm-Gg: AYBFou0Usep4T/Xmbu1cuHO7anDe+DH9qj0asoIm7jEmSlFAiu6PMmXHTvfGxQS1njX
	JyvF4wxt+c2Rctt+44bca2vPzPFme6/BsVnUwTtqthBfmG0a2+akJG2SQwzcLHMlRk/KmbcqK3a
	DsZ49FQiEh8GgB+2PNHPlbL6v0G/saYP+KJrLM5qBO7I/8N/+x+p3ZgOvaP1yFxuEsCHm8598Mn
	sTOX1uLx//s4MO7IfWPUYx/ixoWVzYeTIgoSZblRyCn40se5mzg33dOR8m8hCmaq1Esbf2VjHgg
	FbqP5n5Mvz7jioZubUJ/iXIPsIPJ9cHGp49Fh7bXxsKwVU5iskPnq6Tbl0E6leFBatRVhfImY9n
	kfMo8tOfMe130kLwlESGPwN/olnKUfpczU+L2MITWw9H8tf5Utx3Vj/zldWFptNe7ENphXlGbc6
	VfkV7uq17wa2r6ON8Xinl9UbLlovNByCWSiOA0nnHtUt9qKb2zuz0laVDzhbfrGNdq/OcrW+Y/x
	LvCpXmwSJmtOrhGozVaxSunBB7Syh6y3ZjgUhUFpzoro+Sjg+yX2MBHqwGoaaYjUUiSbv/QwcRo
	WGKYSQDRykd5f8jb8KNFPEhvL4dtiXWorbTmIFRDfJAh/F/NZ5oCdhPPUFoO+2zEkEfE6g==
X-Received: by 2002:a05:6000:2610:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-49c70de357amr179230f8f.17.1794504875478;
        Thu, 12 Nov 2026 09:34:35 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:34 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:20 +0100
Subject: [PATCH v2 20/20] t93xx: drop the series letter from the moved test
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-20-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=42390;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XDN3JAt9LyQ0CDosXs4yOjCrAGii8xsWI51MCxarOFw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JM3zdmKpi8H9pvDfYAl3yuZmZ1eXk5T5
 5Wa6MZgcIgH3okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiTAAoJED7VnySO
 Rox/nTgL/imVIlAAVQyvPhVKwVrDZsZTZCA8Wl6y2+v2eKiPK+txHzjdPvT7G2jp8MH3lrJIBKy
 bvAARKSX//3+opDMbGMPaSaTGkMtjcbbQzsdXsW9qDIVr657PNX9Cl6wHtWzfSibXlOOxYEk2BK
 De8LrJWwEamBMEA7WXs2qTHcvGFUdsC/Vfsbhw0LLyU4b9TN5q9uyvc1SLwYEGVWxqoO0VUGdD6
 DmoFll0lR4qL5J8wLHV/61abmDKtuvfFTdqR++Hr3VTzzIB+FRYTfqsVdZvKdw6nyhbUKcEIogA
 RlBtrSXq2CVKqDLIMkX4zhiIyrtcEwJPTrDa5LnMAlHowLDk26iEZHeEfppn9bUEbGVpoxozlb2
 IKU8Y65R4zQbhIw5PGTmOSvyDbQLmtwbaMlHwAo+ZpbWiG/hA/t6LOLFbkE+55fLnqrh5fu7jRx
 1q5auZR0+vYpPDlwucyaIP8JAf/JyZqIQRoIC1LeDWjh68vF8rqGRXHbFB0D94Psr3Mo+2IA267
 ko=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the previous commits, tests were moved from t9300 to other test
files as is. Each of these tests have their descriptions prefixed with
their series names. Since they don't hold any value outside of t9300,
drop them.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9301-fast-import-notes.sh      |  40 +++++++-------
 t/t9304-fast-import-marks.sh      |  28 +++++-----
 t/t9307-fast-import-validation.sh | 106 +++++++++++++++++++-------------------
 t/t9308-fast-import-stream.sh     |  60 ++++++++++-----------
 t/t9309-fast-import-checkpoint.sh |  10 ++--
 t/t9310-fast-import-submodule.sh  |  18 +++----
 t/t9311-fast-import-refs.sh       |  14 ++---
 7 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index a4b4b0b6cd..f268b4f0c0 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -860,7 +860,7 @@ echo \"\$@\"" &&
 	commit3=$(git -C repo rev-parse notes-test)
 }
 
-test_expect_success 'Q: verify first commit' '
+test_expect_success 'verify first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -875,7 +875,7 @@ test_expect_success 'Q: verify first commit' '
 	)
 '
 
-test_expect_success 'Q: verify second commit' '
+test_expect_success 'verify second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -891,7 +891,7 @@ test_expect_success 'Q: verify second commit' '
 	)
 '
 
-test_expect_success 'Q: verify third commit' '
+test_expect_success 'verify third commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -907,7 +907,7 @@ test_expect_success 'Q: verify third commit' '
 	)
 '
 
-test_expect_success 'Q: verify first notes commit' '
+test_expect_success 'verify first notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -922,7 +922,7 @@ test_expect_success 'Q: verify first notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify first notes tree' '
+test_expect_success 'verify first notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -936,7 +936,7 @@ test_expect_success 'Q: verify first notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify first note for first commit' '
+test_expect_success 'verify first note for first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -946,7 +946,7 @@ test_expect_success 'Q: verify first note for first commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for second commit' '
+test_expect_success 'verify first note for second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -956,7 +956,7 @@ test_expect_success 'Q: verify first note for second commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for third commit' '
+test_expect_success 'verify first note for third commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -966,7 +966,7 @@ test_expect_success 'Q: verify first note for third commit' '
 	)
 '
 
-test_expect_success 'Q: verify second notes commit' '
+test_expect_success 'verify second notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -982,7 +982,7 @@ test_expect_success 'Q: verify second notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify second notes tree' '
+test_expect_success 'verify second notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -996,7 +996,7 @@ test_expect_success 'Q: verify second notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify second note for first commit' '
+test_expect_success 'verify second note for first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1006,7 +1006,7 @@ test_expect_success 'Q: verify second note for first commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for second commit' '
+test_expect_success 'verify first note for second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1016,7 +1016,7 @@ test_expect_success 'Q: verify first note for second commit' '
 	)
 '
 
-test_expect_success 'Q: verify first note for third commit' '
+test_expect_success 'verify first note for third commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1026,7 +1026,7 @@ test_expect_success 'Q: verify first note for third commit' '
 	)
 '
 
-test_expect_success 'Q: verify third notes commit' '
+test_expect_success 'verify third notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1041,7 +1041,7 @@ test_expect_success 'Q: verify third notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify third notes tree' '
+test_expect_success 'verify third notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1053,7 +1053,7 @@ test_expect_success 'Q: verify third notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify third note for first commit' '
+test_expect_success 'verify third note for first commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1063,7 +1063,7 @@ test_expect_success 'Q: verify third note for first commit' '
 	)
 '
 
-test_expect_success 'Q: verify fourth notes commit' '
+test_expect_success 'verify fourth notes commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1079,7 +1079,7 @@ test_expect_success 'Q: verify fourth notes commit' '
 	)
 '
 
-test_expect_success 'Q: verify fourth notes tree' '
+test_expect_success 'verify fourth notes tree' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1091,7 +1091,7 @@ test_expect_success 'Q: verify fourth notes tree' '
 	)
 '
 
-test_expect_success 'Q: verify second note for second commit' '
+test_expect_success 'verify second note for second commit' '
 	setup_notes_repo &&
 	(
 		cd repo &&
@@ -1101,7 +1101,7 @@ test_expect_success 'Q: verify second note for second commit' '
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
index e5cb8c6d00..e9485fed21 100755
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
@@ -618,7 +618,7 @@ setup_marks_repo () {
 #
 # filemodify, three datarefs
 #
-test_expect_success 'S: filemodify with garbage after mark must fail' '
+test_expect_success 'filemodify with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -636,7 +636,7 @@ test_expect_success 'S: filemodify with garbage after mark must fail' '
 '
 
 # inline is misspelled; fast-import thinks it is some unknown dataref
-test_expect_success 'S: filemodify with garbage after inline must fail' '
+test_expect_success 'filemodify with garbage after inline must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -656,7 +656,7 @@ test_expect_success 'S: filemodify with garbage after inline must fail' '
 	)
 '
 
-test_expect_success 'S: filemodify with garbage after sha1 must fail' '
+test_expect_success 'filemodify with garbage after sha1 must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -677,7 +677,7 @@ test_expect_success 'S: filemodify with garbage after sha1 must fail' '
 #
 # notemodify, three ways to say dataref
 #
-test_expect_success 'S: notemodify with garbage after mark dataref must fail' '
+test_expect_success 'notemodify with garbage after mark dataref must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -694,7 +694,7 @@ test_expect_success 'S: notemodify with garbage after mark dataref must fail' '
 	)
 '
 
-test_expect_success 'S: notemodify with garbage after inline dataref must fail' '
+test_expect_success 'notemodify with garbage after inline dataref must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -714,7 +714,7 @@ test_expect_success 'S: notemodify with garbage after inline dataref must fail'
 	)
 '
 
-test_expect_success 'S: notemodify with garbage after sha1 dataref must fail' '
+test_expect_success 'notemodify with garbage after sha1 dataref must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -735,7 +735,7 @@ test_expect_success 'S: notemodify with garbage after sha1 dataref must fail' '
 #
 # notemodify, mark in commit-ish
 #
-test_expect_success 'S: notemodify with garbage after mark commit-ish must fail' '
+test_expect_success 'notemodify with garbage after mark commit-ish must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -755,7 +755,7 @@ test_expect_success 'S: notemodify with garbage after mark commit-ish must fail'
 #
 # from
 #
-test_expect_success 'S: from with garbage after mark must fail' '
+test_expect_success 'from with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -780,7 +780,7 @@ test_expect_success 'S: from with garbage after mark must fail' '
 #
 # merge
 #
-test_expect_success 'S: merge with garbage after mark must fail' '
+test_expect_success 'merge with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -814,7 +814,7 @@ test_expect_success 'S: merge with garbage after mark must fail' '
 #
 # tag, from markref
 #
-test_expect_success 'S: tag with garbage after mark must fail' '
+test_expect_success 'tag with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -834,7 +834,7 @@ test_expect_success 'S: tag with garbage after mark must fail' '
 #
 # cat-blob markref
 #
-test_expect_success 'S: cat-blob with garbage after mark must fail' '
+test_expect_success 'cat-blob with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -849,7 +849,7 @@ test_expect_success 'S: cat-blob with garbage after mark must fail' '
 #
 # ls markref
 #
-test_expect_success 'S: ls with garbage after mark must fail' '
+test_expect_success 'ls with garbage after mark must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -861,7 +861,7 @@ test_expect_success 'S: ls with garbage after mark must fail' '
 	)
 '
 
-test_expect_success 'S: ls with garbage after sha1 must fail' '
+test_expect_success 'ls with garbage after sha1 must fail' '
 	setup_marks_repo &&
 	(
 		cd repo &&
@@ -896,7 +896,7 @@ test_expect_success 'S: ls with garbage after sha1 must fail' '
 #
 test_path_eol_success () {
 	local test="$1" path="$2" unquoted_path="$3"
-	test_expect_success "S: paths at EOL with $test must work" '
+	test_expect_success "paths at EOL with $test must work" '
 		test_when_finished "git branch -D S-path-eol" &&
 
 		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF >out 2>err &&
@@ -1005,7 +1005,7 @@ test_path_eol_success 'octal escapes'   '"\150\151\056\143"' 'hi.c'
 #
 test_path_space_success () {
 	local test="$1" path="$2" unquoted_path="$3"
-	test_expect_success "S: paths before space with $test must work" '
+	test_expect_success "paths before space with $test must work" '
 		test_when_finished "git branch -D S-path-space" &&
 
 		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF 2>err &&
@@ -1070,7 +1070,7 @@ test_path_space_success 'octal escapes'      '"\150\151\056\143"' 'hi.c'
 #
 test_path_fail () {
 	local change="$1" what="$2" prefix="$3" path="$4" suffix="$5" err_grep="$6"
-	test_expect_success "S: $change with $what must fail" '
+	test_expect_success "$change with $what must fail" '
 		test_must_fail git fast-import <<-EOF 2>err &&
 		blob
 		mark :1
@@ -1133,7 +1133,7 @@ test_path_eol_fail   'ls (in commit)' 'ls :2 '       path
 # When 'ls' has no <dataref>, the <path> must be quoted.
 test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path
 
-test_expect_success 'E: rfc2822 date, --date-format=raw' '
+test_expect_success 'rfc2822 date, --date-format=raw' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -1156,7 +1156,7 @@ test_expect_success 'E: rfc2822 date, --date-format=raw' '
 	)
 '
 
-test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
+test_expect_success 'rfc2822 date, --date-format=rfc2822' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -1193,7 +1193,7 @@ test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
 	)
 '
 
-test_expect_success 'R: --allow-unsafe-features found after a value' '
+test_expect_success '--allow-unsafe-features found after a value' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -1207,7 +1207,7 @@ test_expect_success 'R: --allow-unsafe-features found after a value' '
 	)
 '
 
-test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
+test_expect_success '--allow-unsafe-features can be abbreviated' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -1219,7 +1219,7 @@ test_expect_success 'R: --allow-unsafe-features can be abbreviated' '
 	)
 '
 
-test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
+test_expect_success 'disallowed abbreviation of --allow-unsafe-features' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -1232,7 +1232,7 @@ test_expect_success 'R: disallowed abbreviation of --allow-unsafe-features' '
 	)
 '
 
-test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation' '
+test_expect_success '--allow-unsafe-features as the value of an abbreviation' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -1246,7 +1246,7 @@ test_expect_success 'R: --allow-unsafe-features as the value of an abbreviation'
 	)
 '
 
-test_expect_success 'R: --allow-unsafe-features after a non-option' '
+test_expect_success '--allow-unsafe-features after a non-option' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
diff --git a/t/t9308-fast-import-stream.sh b/t/t9308-fast-import-stream.sh
index f0755c9673..8d3cd3c9e6 100755
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
@@ -819,7 +819,7 @@ test_expect_success 'I: export-pack-edges' '
 	)
 '
 
-test_expect_success 'I: export-pack-edges option forbidden by default' '
+test_expect_success 'export-pack-edges option forbidden by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -830,7 +830,7 @@ test_expect_success 'I: export-pack-edges option forbidden by default' '
 	)
 '
 
-test_expect_success 'I: export-pack-edges via stdin' '
+test_expect_success 'export-pack-edges via stdin' '
 	test_when_finished "rm -rf repo" &&
 	git init -b main repo &&
 	(
@@ -859,7 +859,7 @@ test_expect_success 'I: export-pack-edges via stdin' '
 	)
 '
 
-test_expect_success 'R: --git-completion-helper does not read from stdin' '
+test_expect_success '--git-completion-helper does not read from stdin' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -873,7 +873,7 @@ test_expect_success 'R: --git-completion-helper does not read from stdin' '
 	)
 '
 
-test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
+test_expect_success '--git-completion-helper-all does not read from stdin' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
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
index 74c20d39c5..23bbf2db85 100755
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
@@ -295,7 +295,7 @@ test_expect_success 'Y: rewrite submodules' '
 	)
 '
 
-test_expect_success 'Y: reference pending tag or commit' '
+test_expect_success 'reference pending tag or commit' '
 	test_oid_cache <<-EOF &&
 	pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
 	pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
@@ -339,7 +339,7 @@ test_expect_success 'Y: reference pending tag or commit' '
 	)
 '
 
-test_expect_success 'Y: rewrite-submodules-to feature forbidden by default' '
+test_expect_success 'rewrite-submodules-to feature forbidden by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -350,7 +350,7 @@ test_expect_success 'Y: rewrite-submodules-to feature forbidden by default' '
 	)
 '
 
-test_expect_success 'Y: rewrite-submodules-from feature forbidden by default' '
+test_expect_success 'rewrite-submodules-from feature forbidden by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -361,7 +361,7 @@ test_expect_success 'Y: rewrite-submodules-from feature forbidden by default' '
 	)
 '
 
-test_expect_success 'Y: rewrite submodules via stdin' '
+test_expect_success 'rewrite submodules via stdin' '
 	test_when_finished "rm -rf main1" &&
 	test_oid_cache <<-EOF &&
 	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
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

