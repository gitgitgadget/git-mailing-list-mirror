Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999121;
	b=WONkZ9QqTG+ZajsU0N0Wzku3PxY67F7rsGWJcOfjodxgiC465g+3OfDeY/jktNWaZWuh
	 VkuyLFKmxGAnqWxeeJq+DH/t4rHAUMRSbYE1G474vG5/mkiyyGIdawDDq47Q6oyrzi07O
	 M+q8lGiFCMyCnk07G1ywbP3nQOhRQXnAyj+sN6CBp6qjh0O7UUGtSXqcO7hiJ5f7nPIKk
	 BrjdJfT/78xWt5mUtirzfOkvBvs8MijYWHQfh0qimeeBGK36RVTN455x7T8nWYaghPYre
	 +kMSAbtqtpl2Nmy4bqaLN+Jrnyj3Wde/I9xO+nW+E+22Nb8YP0uBfATu4rbiBjBBW4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=tNWQ/GrFI/ofyDwUB7rSsOnN1dbZ7MfmZyTTWrBuPuU=;
	b=scXUwrQrGicoGfpnY3D9NjF+07ceabGgtmi2999dYnLxrGnpgO2P8NhEWSOcrr35TM2n
	 pi/45I6alL6tVQP/sf4HDQAqpXmqJ9HSLc4x3xsGl1XnJFFvJNPZSUqwAuqq43QZYYCT0
	 n8VHPGa2vK5EbxSQ9CfPy5mu31ulCHYqkvtdWS7Uuleq4HSYjC9kGauLsmobeFs/us3cO
	 79iLXkeH95RNYYwDhjx4Z6gz6Q5nVnC8F4XuSfdVY7jcv2cY8rkYQvNS64JWofvgZDxY9
	 TJpfW4SecMkWmUWDpnmRXibos1tsRUD3SRadMvOtY8NzEhp6L3RUrE8zqpKDLZlRN6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gDiODCgC;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCB606A323
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DDCB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gDiODCgC
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f1f76ea84so4527100eec.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999120; x=1793603920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNWQ/GrFI/ofyDwUB7rSsOnN1dbZ7MfmZyTTWrBuPuU=;
        b=gDiODCgCTBQJIazg4T7xUol/wJ1GeB8Iak1TVNfd7DQBBVi2JyEEGid6IzIuxtNR2Z
         JDOmqQeJUQrW3oMzM/Ytq9wtN1F/z3n1vCqCCYbuSTAtHreRw0aE6ZQJMDzTKwGpcz+p
         H8+SFuIXx9oSo6/S/V6rzOGpkXwrGJikpDPrMtgRMDwG4jRtmScyE9KmiuLpN4P43LFL
         +0sHbMvcwXHrEt871c6IStzgGLT6Y5whEOwwXrGxV4WZmoQzSmzuf6NxK93bDwfgEenb
         To4LtexG//2DeQW13A3srVQgQwI6oFCeGvMKejJePRQgltcIS0TJurw/gVVoX9PUy3+8
         LxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999120; x=1793603920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tNWQ/GrFI/ofyDwUB7rSsOnN1dbZ7MfmZyTTWrBuPuU=;
        b=Z79OB5YeXYNe5Yip4nbQtdGAEHM97XNm06kL57kiU47MZY/Me3gLnUrHm3tTFs4olp
         NC+hE1xNa/xpRxByWpsz5foeQC9Fbb5mpMkySP8sxdfXip1nYF818MSQ98oS3UKqSjtx
         Q6Kdp8m8oDta8V+lfNb+JL0MLjBSReOynIRdA1+JyScj3fjLaT9iKRG25NmUqspy3Fqv
         siMnVIFHi3K4SwHiksnbqPH+mTtrn21YVWckdPCwde00g1d48WQXJKSz9YEWijlnbOFm
         opL3OpNGhq2kW9W8VHhJH3T2HCaEBhckZEQqxO27zVe+8T+Q7Du6S3o2SjkTtleHyAnc
         xmSQ==
X-Gm-Message-State: AFq9FYJ7Co64Horoil5FGG1I0K1dy4Kc6oPVg0E+kxEpmf00ynU+Gycv
	d+7xmUPojkwIOMOyQMEbk1Z/JTcfaTU2EkY2QgXXc9us2ziHQstEMIjOxWCegw==
X-Gm-Gg: AYBFou1i/XUbWYr0ZN1/Jq0YyMEi9uNomaxImVI2C4bqXCgjN/PhY9UBEHvMb6aHoO6
	KgLg/msCjNkHabsNXAr5/hdXvEmWr5S+qu02HBQqz5ZIpiw5WqPqP8Yc4Q8egSx+lnC4wGRBRwm
	quB2zqsbd4qBaOptve9uRniIv/CvmCEofVp3KOfZfjYMvuHoAx36G/xjnp/auHpXQxiQhn5qdiE
	Wa7B5xr/grTTPa7j/mtqsUUsc9SuJtpK3M+G5S5jyGCf9VfwDBo9fTPyFz8us8s3PjOwwHzKIht
	Ak8xQyibOYbNNdsIsm+UQt/UKF3KtuQxMF42D5+s24Q5LgxUlm6g1L8Prf9hX/4tzxtigl09uCB
	eoH7UX08BzMFUevbqixZlTp6kXMvrHp+Lh65FP9bxIvJ72e4kc1W6Mjv77cpb+VsSj6XYKpiPPq
	iJ6r6hYTI4D0wqsuQUkslQdMzu7fQNBzfZTawJyaJv+QCzfTeNftiQzKHh6mGwYEL4RcZIhoqTQ
	7kxH2EAAAKMl0l00aowehHX1bRi7vmuj4FkZpmCyQsiO+UuzcXNtPzXrBrPS3Fi5KUPG4Imm/M8
	sSDXPhrBrw==
X-Received: by 2002:a05:693c:63d0:b0:369:fdae:c9fd with SMTP id 5a478bee46e88-369fdaece2emr3927784eec.13.1792999120011;
        Mon, 26 Oct 2026 00:18:40 -0700 (PDT)
Received: from [127.0.1.1] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a005c0188sm8871295eec.9.2026.10.26.00.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:18:39 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Mon, 26 Oct 2026 12:48:21 +0530
Subject: [PATCH v2 1/2] unit-tests: reshuffle NOOP arguments to maintain
 order
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
Message-Id: <20261026-ks-unit-tests-ignore-long-tests-v2-1-eaab5657c19c@gmail.com>
References: <20261026-ks-unit-tests-ignore-long-tests-v2-0-eaab5657c19c@gmail.com>
In-Reply-To: <20261026-ks-unit-tests-ignore-long-tests-v2-0-eaab5657c19c@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.13.0

Ever since 9faf3963b6 (t: introduce compatibility options to
clar-based tests, 2024-12-13), our clar tests have a few NOOP
arguments in order to accept the same arguments that our integration
tests accept. This makes it easy to pass in test arguments when both
unit and integration tests are run together such as via:

  $ meson test -v --test-args='-ix'

On a quick scan, the order of the NOOP arguments seem to be
alphabetical. That is only until you notice that 'with-dashes'
appears out of order.

Fix this by moving it into its appropriate place thus ensuring
they are in alphabetical order. This makes it easy for future
patches to not worry about where to place a NOOP argument
that is not yet in the list.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/unit-tests/unit-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index 752fb38fb3..d066c8a4c8 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -33,12 +33,12 @@ int cmd_main(int argc, const char **argv)
 		OPT_NOOP_ARG(0, "root"),
 		OPT_NOOP_ARG(0, "stress"),
 		OPT_NOOP_NOARG(0, "tee"),
-		OPT_NOOP_NOARG(0, "with-dashes"),
 		OPT_NOOP_ARG(0, "valgrind"),
 		OPT_NOOP_ARG(0, "valgrind-only"),
 		OPT_NOOP_NOARG('v', "verbose"),
 		OPT_NOOP_NOARG('V', "verbose-log"),
 		OPT_NOOP_ARG(0, "verbose-only"),
+		OPT_NOOP_NOARG(0, "with-dashes"),
 		OPT_NOOP_NOARG('x', NULL),
 		OPT_END(),
 	};

-- 
2.56.0.99.g5a7d1e8045.dirty

