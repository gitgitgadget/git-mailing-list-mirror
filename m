Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098697;
	b=gvridfQB5OgAtHHcM4QIUXxfiVG3t7e2vYsAxes18ajKB4Y62gu8QwkzgbnDyGB6efET
	 jKhjvUYAEN9U9EG6fUhOky3jZTfgAXPXG6brYxVBE7zE7DCT1zPWqgDIqpjvDUqpcSh27
	 8CzP8z0sMYArFICuhPRTRvh4N9d8vzCIGDa1j0/ZoQWtEqIZXxvZbsyJJ5TS2ebTu9bKI
	 J2d7J+AbyGgpV5RSWhfbds7cHIqukjcK4A+IIi8itq5DtG9LHB3L1vxfIrPDPlfcaj5zl
	 akg4q1bGIepBamErCnD0ORZQkCLd0h42zH7xytaAYLBfWiPrOob/P6lmWkZHzdMjw5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7YhaoJ+9kZY4Mk+Kr1wcyZ9hckEfQpqwVWkRpuvkUdQ=;
	b=DPQo9Fm+Kd3cfAl/W1AsetAIXNygA5HUo+7001uPxNr5nDRQGWL5f8/9yne3kV2dwRnh
	 BD2P3qvwivbdfbk72FlRsC4UmBnG8t4SZtxk5U/Sy7PSlximk5GX2Vpua1T/6A0Xk72QR
	 x0bz/Aiy7FPlT2kW6jC6p/2MX/crjexHPkP1ivaAW5FgIoDGuXj3TGotHbM10uByI7NDp
	 b/ULApmar/8vaUC4Yks5FzJvF++INDBu25KL0BumMdXA1MCr2N7j6g9XkVJRI1AlhvjBi
	 Q/ali/TVbeCYHXJOyPJZtLdwddJ+SH5F6Hbk1E0U2GYwDpe1nhCwvly4Znm3OcvK5ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H9pqsuaR;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3E606A322
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA3E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H9pqsuaR
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1866539f8f.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098695; x=1793703495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7YhaoJ+9kZY4Mk+Kr1wcyZ9hckEfQpqwVWkRpuvkUdQ=;
        b=H9pqsuaRWUPk7UxUaCdUEw88GKcqNI/g1OtJbA0pZZ/OqC8BCVlTXyThlO13cIsT++
         M3FvHtK8W/k7Ebwpt4NnsosbJhxt/WQBZRXroZlaxOB5/dRLysebT25ebaf7ln71v7Nq
         5FUdt7o197GXiTidK79CHfTO71Xhb2YCzyqEpuWW9vvUIaclOoF2qK6rIyUoLL908fiB
         78qlBk8yTHjmqNCX7pCh9XPrCwV9OswUWrq1QEHj8RpTry3J2Wr6cwV8Cyj+eqyPj3ly
         ULUzDQIVWfUMH2KbzwAEyyYgaMJnd3BViCgbzA/oOlJAxUrwUanAFY3fWPeW3K0VS9LO
         W6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098695; x=1793703495;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YhaoJ+9kZY4Mk+Kr1wcyZ9hckEfQpqwVWkRpuvkUdQ=;
        b=kYKuoD9DkjzNg8k1aU99njrZ8b5xshFsqsmaLWUmCwUDbxLmu0MMXR75EwL9XsVL5C
         nZXZInEJtW08sZoay0QuyOOckEMk3Z6+TEIGRMHCer6zMskDSGq4p7Pwbsfa5T7eVWFh
         ka5+QA9tVsLjqM1dPgNEvZdmYTg49BYKpp9IuAuFN82aqa4R56YdwJjbs+1WpQN7fCLZ
         5MJhpdHqei0i/o1SnThGScnugGl7yKEhoxL6Bem+NbJtgZNvqGn7b8rVql8iabAu33mc
         9LWvXgWY1uR3GofR+FbG77QwSk8wrTt3e700Yw6mZZQE5tKp8r92rNTae9/GTS9165rD
         sBNA==
X-Gm-Message-State: AFq9FYI9g9QeADgyi36KB3zxrLLzq/i6cbTMYL4cRZKbyTrFwGNbO5YQ
	ULqAn8RtyfJexVKNakFwHxvhqzPXVhrkhxIlo+90h0QRyo+qLdloR5X8F6KO+w==
X-Gm-Gg: AYBFou2IU02d7Z2yrsayIR9Ghik/3wLC4fOjI956d4Ok6t1IxgPigQDbWFVFpdlXnwV
	GiRQ/3Ud21GICm/PHtpFdN3US7V2wuKzKH1ubVaRqdYY34+7AEXE/5ORxtLE96pBtocRH08OnS2
	drHC6UiZ0DyQzzMBk1Y8veEGL2aG/uccLsqAIh2pKU0qbT32Jm1IlkADb3jM0KRURKnPlOBKmVa
	fmUiuSzs4W0fvn2V0KNMLCD/pqpq5sfpZ4iDCjMnUhVrx7I4ps2yCWLvcJi+toPe2kaP32Xh7FV
	0uZGQNOmEkFQ6umIw/nj+eyQDAkJo1NIOwETqxUAzi64gJeYcWGbYgFognV8cz2zT1rnfWSWglr
	m6NFRj65SyaC5sSh+M+9wp6jTpBEOk1Yt26z0vmmuDF5Q9BEhsQMXl159eCOKsK5hkl7D+fAjwU
	k1CJtWEEMnp/OqvEk2hO32HYU/B4hCcAWOPxNEDOo6rmyCf7G1ZL7I3//KZad8JHWfknu9mcivw
	Q3+yJAM/vuEdlR/v5/BwHzgOJsdJLlGu3OSd3Gc6K6juxxx2WrrnLNdpfg=
X-Received: by 2002:a05:600c:474a:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4a35acb586cmr185348065e9.23.1793098695213;
        Tue, 27 Oct 2026 03:58:15 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm321638925e9.4.2026.10.27.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:58:14 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Long 76 <long76.git@mail.ru>,
	Matt Hunter <m@lfurio.us>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] test_ref_missing(): improve error message
Date: Tue, 27 Oct 2026 10:57:55 +0000
Message-ID: <e246ee6f3b11c231580752b6c94a57f31f449955.1793098652.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.336.g97505d19352
In-Reply-To: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
References: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the ref being checked exists, then test_ref_missing() does not print
the name of the ref in the error message. So, if there is more than
one call to test_ref_missing() in a test, it is hard to understand
which one failed by looking at the test output. Fix that by printing
the name of the ref that erroneously exists.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/test-lib-functions.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 09a41d51adc..b56b4f0a6c8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -292,18 +292,20 @@ test_ref_exists () {
 # a reference. This is preferable to `! test_ref_exists` as this function is
 # able to distinguish actually-missing references from other, generic errors.
 test_ref_missing () {
+	local refname
+	eval refname="\$$#"
 	test_ref_exists "$@"
 	case "$?" in
 	2)
 		# This is the good case.
 		return 0
 		;;
 	0)
-		echo >&4 "test_ref_missing: reference exists"
+		echo >&4 "test_ref_missing: '$refname' exists"
 		return 1
 		;;
 	*)
-		echo >&4 "test_ref_missing: generic error"
+		echo >&4 "test_ref_missing: generic error while checking '$refname'"
 		return 1
 		;;
 	esac
-- 
2.56.0.336.g97505d19352

