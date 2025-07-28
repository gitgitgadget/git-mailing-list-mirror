Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02112274670
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734058; cv=none; b=iwLtLnqoNHNMu9kJgAJ/RCfdeOCdIQHNGFiHLYKld513vst4p19JItZvgGFGlKwrnUBumJiANsClMD1IHWQpq/p1+A64FB+Qtwm2eVlgWPtvxEFaArOoh2TdR1TmOCZgxTQfwGo1sXcQVxgDcVWOou0Q5XKPjpL2FdcXU7I+wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734058; c=relaxed/simple;
	bh=D84meJKp4+3J/O7kj50Rb8/yYQZMFqrPZso3q05ChQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0YkpOdqXom1U6s5/vuUk6DFclt1pMCHr98ggKB6BdxJdiLq8paiNQCHzimlybghkx3Y8wPJTU46LydzxRVybkjkLVLbes68TBmMj9szBrW0w3bl01YbuHcYMvtvXYqHIlXGB3jHnT8TUgEDmdkwfUU4QG0qCTgZfybNtiznRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWMeCQyq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWMeCQyq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aec46b50f33so875886466b.3
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753734055; x=1754338855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zjCDUTPGR0i8JetlVMEcU2JSwVQIHfwsiAhPPigQNQ=;
        b=ZWMeCQyqRtGEdaNAWWhiO1vFmWoqrERWl1oY0X8RSbRNqfBS06vP1mLSjL4rmhNyW2
         S2rqxcNhUQ3CB4uL/L7+9i9F2OJpynCQNacxFNmDTJ8Li+ldJxxOH5zV2VlhL2Ok770L
         Brg9zqP9QQJ0SVIMk5SE3xcPbCnRORIARaHxEVJTT7Mon0/lH9H5V+yC0zcBs5nT3pSy
         ONZgYIxF7ftMtqCRbxEf3CyhbQDFPXjhdKyifab7bnf87wLbNqxbne7/F+QChWQ1Lpnp
         9hyv6Y/w6teoN83Hgv5u9XmBAbJkXP6KrXRFZb9JNUcg08ML/wkIbA4iyolyzXpxiwhv
         GXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734055; x=1754338855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zjCDUTPGR0i8JetlVMEcU2JSwVQIHfwsiAhPPigQNQ=;
        b=oM3y7GpxLIzVPfqYhU6zG/2CeikAMcAE+b+xBiO5DIaKtx+6FrrLgzUCtluMzouzBa
         01N/r+2c1JENQyMiab3D4tqH6lA2T6TCw0c3A+thIpUhIPpoCgqBQI8q/6wFuVv7Boim
         ZDLk8Y2SCF7ILNGWFQZorxsnuY72QBsfjOzOuYmi443cTbuodh+14Yo9oqmPcEQAQn+s
         TlzORpAjOA2PUpPINrWo17UZc+KedraNECYW2zcG6w21x+AmiSxlD7h9+RaYMpFhlRXW
         OyibePXfGCAKYfTpFl9EPcw2x30qfNeBKJm6Mz18iLlkL4MLSDxcDpyKFR3earlU6pFF
         xkJQ==
X-Gm-Message-State: AOJu0YzHhbkhEXewKtmBh59G8j8jM6FiNCy/3c2/t29dED9TzJvhowKG
	E9hGO7Nl9LEkhuRcMAJ25UGTDhOC+QPYdJwbAH3cZFCNppHs9vsqjAw/plhHph2V
X-Gm-Gg: ASbGncscB7mINZzcZeY3JNG6SkXSeVkZrJTT0yv64txFTjQYFcSsVuaY93PbM5ijGI7
	52+Y1C53jsD48dQLNhcIRjiBNOGo25GemQDeS4DnYhInsHYrqF0M2PnIoR/fNnBHAHmzGj0mI1q
	4xbBerlppy84303SY1gADJTHSFYFXYs3BIEGA/jnqKdQ2FZYfpN2HWDFvxIgBb3ECHY5vP9E9bz
	B093rRVvzbRfaFfSynGao8jfFAWCERRLo4j5nqmENLUaZJ4Bm1CS6FRFH6iRdktgjFbMF6d35ed
	dqhYF30KVU6Wb+XtJz2N/fI6uAGUKByfzhcBvp+6btGW0ylPuZg2KeLhBwtuWtVY3NGrwYOBamV
	/0mvi7vFqGI5rlAmfYK76OH21383r
X-Google-Smtp-Source: AGHT+IHJBZb8CA2ViZyzDJLfHOmcInq0Pp7e2Oa5YWwypyJ4RxUJWT2D/ZLt5gIJFJkXg0NMZoFE3w==
X-Received: by 2002:a17:907:97c2:b0:ae0:5137:fc44 with SMTP id a640c23a62f3a-af61730b97cmr1460560466b.18.1753734054894;
        Mon, 28 Jul 2025 13:20:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9706:c2d9:b21a:2042])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62ab9sm475376266b.86.2025.07.28.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:20:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 28 Jul 2025 22:20:49 +0200
Subject: [PATCH v2 4/5] t6302: add test combining '--start-after' with
 '--exclude'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-kn-small-cleanups-v2-4-d3021c8bf471@gmail.com>
References: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
In-Reply-To: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=D84meJKp4+3J/O7kj50Rb8/yYQZMFqrPZso3q05ChQU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiH26IrWGFllpV7PgiYURnAKoCTjITq3AeXN
 /pdHnN9jQ95yIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoh9uiAAoJED7VnySO
 Rox/+CsL+gNn04rPR89QEx4vLCJrQU3bpVcNnhTgezvOs6gIsq4FO7W2Bb3n7FpJwZ/vPssutbP
 +rb2fEwoQDPRtAd4Cq4w+hxpYfGV5U1S1w+q1IO7FR86iH7fHT360Lgfbj2Wyv3/kAPzK6FYBfn
 GoFH6lyC7Hfr0jmj++Lv8Zin6AwGvSZwrLzqNODV59BaeUg8RTmZcMkJpvtyCTKMj0p1fWVmZOr
 8ar7Sojz5urquT36mKS+e696c15Qr0MKc1zlX8Gt+7dqReiUEFBzzxwTY1UJufraelnlrgd4IiQ
 oCB5unGBJqEhP7xG77nII9YQaAjDdKeyShcj6yWwN+8AsFGIQO8c6T/ENlQ70LG8s8xdYF6q27Z
 QTkiNRATb9+jzMhHYkvGKfulaWMT2Peg8rxOteLCIIwjJb5QujXCGTnk7PRele+Ih1YO/nByBcL
 uFWFS88Yf6kA0g/vQTThAxeawnWWZMPvx17FVedYVSGngIKgAuP87QS7tWyenSjlvWfl2bd1Qk6
 cI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The '--start-after' doesn't explicitly mention being compatible with the
'--exclude' flag, generally only incompatibility is explicitly called
out. However, it would be nice to test the compatibility between the
two to avoid future regressions. Let's do that.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6302-for-each-ref-filter.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index e097db6b02..9b80ea1e3b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -712,6 +712,25 @@ test_expect_success 'start after, overflow specific reference path' '
 	test_cmp expect actual
 '
 
+test_expect_success 'start after, with exclude pattern' '
+	cat >expect <<-\EOF &&
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/spot \
+		--exclude=refs/tags/foo >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'start after, last reference' '
 	cat >expect <<-\EOF &&
 	EOF

-- 
2.50.0

