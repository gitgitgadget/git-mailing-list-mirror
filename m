Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504866;
	b=0uckvME9knvmiC03tadajrYmcNZH46roHqSRDHoLxYu+k2FUEgkH3CW+aovDMFLfdEnm
	 G1VBF/tqKLBJKcFFGSKGdjDxE+lw8F3MK7C1mg4vicOEV9ATqVo2/3hAkM1wymr3QT3kd
	 SFKZVDxdM0dCXRflx8CJHxbb1+s9pNlIxIR1cMapV7EnLgbZR9zFf0pOxv3yQmVjv2vLQ
	 vOUvGrioIbFtVeL1tHabK7T76Db+e4OM1VjKCE77vMvFdoo/R0YvoOuk7BTUoLcjFkE+m
	 CB2UunlvzXbfgFwq1BH97vbfbgnym3aCJndo4LdKQgabaI68Z/DtcPTa08WwdplG0oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=eJdQdd8YffKgnZtBPwWLKvXtFmolZdH+5vmLxCDPo2c=;
	b=he68nFri3/prYf5uveHFC7LYm8MNH9PNs7HreTyxIjnslKWTV7lav1vSz2q1lNcihHwY
	 hLgvxCyxRwy8ghrFLz8RrAe110XKF3HQYxfYk1vJa0Y1sU4JE04bfxaQ6hrGOCsrFuCre
	 YzbQS/oqBNbWxgxy4n/Lyeqvz2NnMNxDdt5xtqd2FZaYzRRBA5bkVFohH+2vv0ncq2EjZ
	 yzUGGcALO0MO5LJU3xd8jPKGoTsXR5UOWEMjfBLsltpHT1PeQkXpK0270e8BAcTMGZjrz
	 6y/rvKXEai3DtKSAeLVn2unofE3x+tznjy0szDZADT4Fx4P27IQTZBxmTmiS5l+6QJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAlE3DXJ;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A32606A232
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A32606A232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XAlE3DXJ
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4922dbcee23so17613f8f.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504865; x=1795109665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJdQdd8YffKgnZtBPwWLKvXtFmolZdH+5vmLxCDPo2c=;
        b=XAlE3DXJLqXXiUxv1yxKBN9LlFnCl0xbwwRC74b/B53PLdHglvIKkV9Sr30BgGPwUr
         ZatZPKaW+k5YjglKzbNQPPC7SSacqDG3h/z8DTx2fKLWDSFm1DSAj4rC8gCVZDkUTJMX
         hFk7XI5BbGhswqTQCrvc9ctRXpixp68DrxIkz3a/rosYfiCdgcsabpDQm5gGFZRu4gZ2
         MFmYLeeVF6yllSWlkkyq5eWzBMKs5EkAAN3yHVGGcpjIYTd3TQfv2Y6j7U0EMiSg3kK8
         vfffHIcRPaJ7DEYdXac3IHsUgL44DDNj7vKPmNwDFguoyquGXqEc1CubHhCKsir2qI7B
         4VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504865; x=1795109665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJdQdd8YffKgnZtBPwWLKvXtFmolZdH+5vmLxCDPo2c=;
        b=uhUdp+5xahPHgyjDbTzo0ScQeM9JcoWc0ByHAycm5buT6XQaxsZyWWWpXLGzyklO4Q
         NP5OK+7254fWmk+z5OOXNGlG0iBvIw4xjWjoouW1SwmrjaD4kp1pENxjNXx8bghsDFka
         Ubw2g5mALkPKhBBXrO42mL1DHx4Zxn6hAU/EYW3ktTyr/uEE5+6a0cydD1BFCygSogaB
         vLCLNpDgeGW6zfVSKOKkvC8qqz56z4g9ZbbRLOKXc9tfhkV1Gjj76tdjeSIkkEsslfGp
         HepGiot7r+4NTgPJCziYZ8Wl4N8qgE/qnARtGbGvEq/kEoWQLEOdHJRLcPdQJ519V5p3
         7iFQ==
X-Gm-Message-State: APuU4Z+QBrRliY8JKvdIWzmMboRhraRhK0ccyRLJhuGErE0FEgw/wwwa
	jAy/5KmprKRqW6sL4DrMkKTDfsqp6+uH7Oxr7Eb4dnjTFae/izoocfoteYJRNg==
X-Gm-Gg: AYBFou0iFVAw9DWcPldowDRhuORYVoJ18AJVDzL8YntKZImBLkhTLMRw08SDAtvd9Nx
	cPy7eXnHZKhUnHKlt0Cio5n9N4w2MIULprkZUwhVgWrpXj/D1J5Qe6t+nCo9CFnw/EekWIMocn9
	K4rv8lBlplSUVdx9OjIIBttAfMzPTo8hqjTk1IrXa7a3gM8tugSoql1AKA3YOu7SRp51mjn4MUy
	NTXO+KTNij8vImWPUCxkEpvPrs5JHj5Fsqa3yuh1JPWsUGpQViIzgW+jpg0Fmqff81lH7hvc/1c
	PGehYfxlW1gOT09xlY4JUfdnez4tm7cpmkFfTdgGgk449uNdiLqysn6lmmujGz/+sssqv2ClHa5
	K2FD6uFZ2e9tqWCCfosTJykGUvzU/sjUDT2eDbVefXDtSfchV9aUmjUWVnMlEw6ePQ2ucqZr6Gk
	bLDzFjEPMgVVGxf7WmBB1bMQ9VfORgrauTOHlmyez4wwyWOmoIdJWRu3Kk2T9kDgkqNULCI7vHs
	BsAB80ka4uIr+9sAFovrAdSvdIgwgJ1V3w+mmksZ/ar64Ffk5u/cHXWboddcy8wcLTtNpM6wBuP
	2aJifFYgeZ9oIYm7XD3LeEDHGdSNQmtmqGntJ3B4io8lcqpKWmwHgVE8do0w6Ar8OCbK
X-Received: by 2002:a05:6000:40c9:b0:48e:75a1:1e38 with SMTP id ffacd0b85a97d-49c73ed1330mr61170f8f.56.1794504864685;
        Thu, 12 Nov 2026 09:34:24 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:23 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:11 +0100
Subject: [PATCH v2 11/20] t9300: make the date format tests self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-11-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3174; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jjUFwuPkb2LOJ6zFuUID5rxhB4m3rOsoFc7enBYNlfU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JJxC7Qs9g85amiCB1xj0FktFXOKtNKfT
 XiNum85uJaVsYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiSAAoJED7VnySO
 Rox//ekL/3/pFdi+nMdtjImicwsFvEuN9p4D8wzAStAnEMuuT8PHbNsbLCrCHqZKmFzMTTZkzWq
 mVFTwPZF98jHjslOD5nLyqGHfjT/RV1V9NpYmnYLHYKfI8JRe4C47o6o1k5lh0UHWZQeIfSsHTS
 6+iQbBN2qbGXyftw2LXl4rn39eut3CXxp3Sl7VWvWXTLfofBQCgg9Hu7ult7iDiDo7WJeg5TDUY
 nWDvWWq8gc7bXbkl6jXWnCR18VGhDRfyAFpApRxmHA6DnwYQVjbNpEgk1C+xTNtVI+WbnFbh0bX
 vov9R1t2jMn2HsVVKyibf5ftzdQPC1LzzqexdBbAmi64/FFgYu8t+wYq0XKCOmqtPhxFldWMUu/
 MLK7Ske4qKZp50gy/q/XMIuah9wziZAZ+9hpGzWpnPYOBujxn1XCA4awEr0vqTNne54HkDSHbXs
 5QT9RErynRlsiGNgG8XcH5kuM+uA3oTxUJCsHTYD1jqozFzceku5UmLa6r7H+3fzspzEZqogWS7
 NA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the date format tests to
make them independent of state from previous tests.

Fold the 'E: verify pack' and 'E: verify commit' tests into the test
performing the import. As 'fastimport.unpackLimit' is no longer set by
an earlier test, set it for the import so that a pack is written, and
verify the pack with an inline loop in place of 'verify_packs()'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 72 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 446cf0c51a..54394c892b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -828,37 +828,63 @@ test_expect_success 'D: verify file6' '
 ###
 
 test_expect_success 'E: rfc2822 date, --date-format=raw' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/branch
-	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
-	data <<COMMIT
-	RFC 2822 type date
-	COMMIT
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit one &&
 
-	from refs/heads/branch^0
+		cat >input <<-INPUT_END &&
+		commit refs/heads/main
+		author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
+		data <<COMMIT
+		RFC 2822 type date
+		COMMIT
 
-	INPUT_END
+		from refs/heads/main^0
 
-	test_must_fail git fast-import --date-format=raw <input
+		INPUT_END
+
+		test_must_fail git fast-import --date-format=raw <input
+	)
 '
+
 test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
-	git fast-import --date-format=rfc2822 <input
-'
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit one &&
 
-test_expect_success 'E: verify pack' '
-	verify_packs
-'
+		cat >input <<-INPUT_END &&
+		commit refs/heads/main
+		author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> Tue Feb 6 11:22:18 2007 -0500
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> Tue Feb 6 12:35:02 2007 -0500
+		data <<COMMIT
+		RFC 2822 type date
+		COMMIT
 
-test_expect_success 'E: verify commit' '
-	cat >expect <<-EOF &&
-	author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
+		from refs/heads/main^0
 
-	RFC 2822 type date
-	EOF
-	git cat-file commit branch | sed 1,2d >actual &&
-	test_cmp expect actual
+		INPUT_END
+
+		git -c fastimport.unpackLimit=0 fast-import --date-format=rfc2822 <input &&
+
+		cat >expect <<-EOF &&
+		author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
+
+		RFC 2822 type date
+		EOF
+		git cat-file commit main | sed 1,2d >actual &&
+		test_cmp expect actual &&
+
+		for p in .git/objects/pack/*.pack
+		do
+			git verify-pack "$p" || return 1
+		done
+	)
 '
 
 ###

-- 
2.56.GIT

