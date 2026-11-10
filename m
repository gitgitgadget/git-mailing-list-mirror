Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311414;
	b=hxJCGbBUYgQjT0L/puQy0bhNp4V7I00t2aCxJHRt5CtVS1rEE7ducO7gVGImpRHmS0Ir
	 4pilUxdSTmt9bbm9MeLqq/mJKdpecs1EhdYaCiM0SK3zj4cDdm9NyBfSDZ3cGFsUygUCY
	 3NSlZr0QbOOESyxRujFgbSo0TJfpV1L4vNu5i8Yudjv/nCr+eNPUI0ASp15TZXT/SAT8M
	 /FTc/DeNA3Lkrta/Tz8MPbm2ubwW0aNHpIhJGGbFqVUNn10NrQH+nD9c914C2Gn4/hxsX
	 msFlxP4t09TfAEW7WHuxyGXnfksi9XqLQDm1zSObKb75XbXLMoNJFBF77ZIIEivSjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=s4vmEFrHNwXDsbVDKgxoV2RQkclfI41uMNEMOyK1bC0=;
	b=VOKjExg18a1oPyEzu7mYccmw9a6ANayCoC67Cp8pqyXMgVO++bUh+f4uLb2eYMQubYyO
	 gGXOHQqXmsZp9VwC+p1PDNxYiAgTa/EXA+8KOyXmm6FpQs2szwrB3jIoQMEyhuFAzopdd
	 MJi/g+1EpjZefNsC5PakOphuSGdWFLFRSHZGIPoeBT1UCxr2Y7YustyuR9ZOiflox2J2p
	 S3j8oJD3F7k2FhYACIfnEPuYfbl9tYfT+UqO6/DchpvMFY42w5on1yNqYcrV+AcJTW9yv
	 Nmq1n8g+Z8+xErjmJIcxyfRBP80BIAfu2iRJ1FeUZcBhMgK5Xt4Jby0WDYQuM/QFS6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1tkOH+X;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F775606B597
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F775606B597
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L1tkOH+X
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso20508255e9.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311412; x=1794916212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4vmEFrHNwXDsbVDKgxoV2RQkclfI41uMNEMOyK1bC0=;
        b=L1tkOH+XRzk3u0QZZ4g+uIEol1YuyasFpA9I4VW+8lqFzCa6jJ8bJC0Pi1JMNEkfbB
         g/unZFajIE3OWaQEYObUNK0GQ1kWPFv5F4tj05m5YiAAkb+OJ9DwrpAKZOI/JsdELh4g
         7XRaZz0PksIgBn2lNTMc4Sc3OijLLk+2uGd1AdArcLRMYbyaDSBWjFGBQbqQuePoQrGi
         fHiJgQPG7asqa4EKpgWYn4+9ihQ+Yir/CkKp62Iy3Lao8tdinnjByGd3I8e0Gpk+2quB
         0TOg3U42B7t9P6fEg6UJe6owzNmv4GbI1Y6VsEOO9TDu1avJQYHfUpF6GX/4GluJXBHY
         42Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311412; x=1794916212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4vmEFrHNwXDsbVDKgxoV2RQkclfI41uMNEMOyK1bC0=;
        b=Bsd7teJvnwEUTiFJ+302v714xH/TYotf5DtFZDDKVzlwziHc4SqzogIBPYeymYpa31
         wHL3pdsaaeZacwma9KtJ9wSpsS/+URV5uJCnCGrjLLr9q4wogitfXycajo8eEuP0FfX6
         gBANuRlGsb/KUulIO/c0yrmrBJUyVGWuuNrF5cBWhKE2aHnr0+YP63CszD4brxzBTEZh
         2sXD5PnDrHc7Mok4ShWBBXv1Gi1K+zQhyw9EnOF6NqAKtzOvI4PNO8j2SXn133kcDafj
         XMZHaXNp2AEVGe2AcnWHYG5Id5AAqcGVAHKdgBu/69CVOlArZK6Rtj21w4oHt/K2RRvv
         lyBQ==
X-Gm-Message-State: APuU4Z+JILaO5LhjavTdTuZ7IiXJ4Rf4Guux79N9OI2xTLwRh2CD5wP2
	AoeOPBkd589qZx5jxngYB1CBfYCTthxiYulbB4s1A8mOh8rZac0tpKKpZMHsDQ==
X-Gm-Gg: AYBFou1PpEyA2nfaatC5N8MxxhTYUsJdx63uaXl6Ft9yjMj9aEdxyPmAdJGhuoQBHpc
	ibTWHDJKuLKj6UBOmMaf0puik7lgHI/CazfTJvM19rCoUFF210qHLzDdneHgsgHpKuXDQ7wNTuT
	fxllEebOfEwRA75Xmr7fscYpDpMOO8xbVXlQ5GiLSAo5Y/1xRapBTcU1O5mxy7gA5OxTB+pKiyP
	TnpJ3Szw22OpGIPiZqYFhfB+DKKqbzRvWqRDSPr8jz+Trj20NWip2fn00vCeY3oOKnMxm8N5PUl
	RokAnVnLpP6RVhn3G9Dcp7qC1XC6WN1jWTQFdRvaQtbSKq6k7J8CToSl1mIyXCBQZ55gy9T8Dt+
	evQJxnvE3XIkd9M6JHcsmrZ6FATXrHmcUyKf2Ak95/kMb6P3zQVzKSp012n39mU6siQDbBcu4If
	jc4tNp7oKjuMoyHEuGQlftRel/UpZNM7ZZshZmGepHEDH4+/fPrqusWILOkJq5dHNlspmb9e3sg
	u89HcdXbyAiWPIp4w6kZ0MwYe1hBFDGJcyBYYOSDp4bHG1SGFaqvZZceMz6ur/gYw/yNYgIVQwd
	ZEn6U/o5uH5AEy6cQkiGQ9JD/Ag4m1xf9JiD1BJFeOs7BL7Aq4oufIPi9k6kk2oUHqiD729EYlS
	L8IUgGilY050W
X-Received: by 2002:a05:600c:4f47:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4ba0234bc10mr40244025e9.20.1794311412470;
        Tue, 10 Nov 2026 03:50:12 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:12 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:56 +0100
Subject: [PATCH 11/20] t9300: make the date format tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-11-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3174; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8zD+CZibtFZZrCGowJVvntWLdsZIA2KtyesJK3Z5yuo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOcxbDMuBe7OXP9HqF9gZ4aG4bPa0gIrl
 MqWxfhvN6kNY4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTnAAoJED7VnySO
 Rox/J5cL/ihr96C97jaxxbAAodCL+N7VWhf4dH1mYUyAA+sTJYixOtofaYuSl2JjCRvG+P15oC8
 q1pMfdrYjjOOnXj7jmnrbTNXeA71QkfJavJdiCS6QoS3EEZwylbYlWgHZY0sDSUr4cNzCcaQ8Rb
 rqaIuU7fW5bR7vsq9gR21UYnvoiQWswp0sBaYA4XA8VhLbNcv+pVs6wlKhKA8tAuuvkHuHHI/dw
 hPjtr+rtA4OIyH5InwOi7mSgFa7ly8I3utsW6sGNEmhdB1OdROpda5GuzxDomk03kxtYT1EjOBO
 F/lpqBDUjAUn/jouR6uT37ZQizZdwca9GM36vlFY81m2yEeF8qYkwCKNBvOtxAg+43GlRsRdyCs
 3gFsKmqSm1a3jy+FZeZhFpzPLBgdBEGBcJpJgQhgR/JNYdXOik7hIBHFVwRWtBOFozXoiwMZDB4
 DTOe0MVBQ2BvLlw5Ztu9DdHpCab5FrgSdgQTS+hjbkOYUSIb/EzcKc3qfA0HJK6/DuVc04Ahy25
 mQ=
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
index 9576df78a1..5b0101700d 100755
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

