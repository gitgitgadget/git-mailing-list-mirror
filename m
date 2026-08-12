Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC93ACA7E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521815; cv=none; b=IChJWq0m8ERxeaD4uiZ8XEr3LGTdQ77xgQALm+fuSKBVsCee0mcgpb6YSnZqIPiPde+qa6ZoQ8NXRRwcFV7nrv2WzeA8b/k4TUtKRCoZ28dGhO6VNLoKahm2YjYnrDNA9lv04yX73LabT36f9Z0YYqf+gJ9HCNypCW+NpgcojhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521815; c=relaxed/simple;
	bh=8jXEuCIKxe2NgJLX098Vk1mNSqUSzASZLerpvxnM5tM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dNledG2vRsNEbIec6xvw+oeby5LmsPR20rZwD56FUNhy2JT0omeeLLCHAcSxFFnCBqfBPDHkB9hBq5pqaIFo3ZUOwLnwkZqjDLC9oUC9AFfDxiYC2lSAkgYLR0/eXC01hYniCQMzgkDerL3pt0TXKFT2lVRsP7S0f2ZzpQ4nI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaL3FkAt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaL3FkAt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1017209a91.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521812; x=1787126612; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xu8vxC0Dl9qppXclM4RcERBLpZ/EAFP0raJNLF1tKHg=;
        b=jaL3FkAt5IfQAFluWzojmttH2kNh6hD4n/3tnsDCQnip56eqjGSFRlAX58ETF7ej6a
         n5Uxc+vNO8lpbMlhAbzU9Qi0u4VX6HFNosWsIkltRgFASfDqpoFA01Pn93bwLiV9MhiG
         xWefsWTVIUtCWK+fiauO57zP69TZj9wBnsf7O9wbVRXpywpqg7EH/pNqNn36L7+otTJk
         QPRYq0vUhCS6tmCKBcQsZjtrt5IQ9R9i72wyvqQ+I/oGmN4U5D8c4R/wSOkyO+qnXxrz
         +6JvAgVMuZ/yVkWxWL45V+WBT4YBm2dB0d8oWa/VE3I+iyHJ1LbngQt/B7RM7Pu53vRM
         17hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521812; x=1787126612;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xu8vxC0Dl9qppXclM4RcERBLpZ/EAFP0raJNLF1tKHg=;
        b=rT/ZrWzVDn0GzPb18Ki1NgnHN1IhUt/qEXTLwZznRcEjbv2+qNbH5A2zTRurqOIV4l
         bqQ203doCDK+gxBthDFN71vR1igri4RsezTLTn4Hg+q/Uo+g1ENHAChcIwOo4xXppzpW
         gW3uE10ygB9gstxxONT+z7gC5NikdwW9/O/e3UcAOoEzXNC+7DAecXqXBUBd5syPbq46
         tvo0b1LEwtBbiiYHzLPJ18kULzvJhcONfkDyB5fLcu2YaalQUXovkiC2Tt+Es9Qcy1zg
         wcxHU89SEOUqjaT/ZaAOj9pVKn7rbtTFZtf+m7CE6JE4/bz+PNc5Xi30z9F22H75oABG
         BZiQ==
X-Gm-Message-State: AOJu0YyTbYsHLRtDuNRcsMbam0edbxZeFWAU08pigX+H+rFgz+rwKC54
	Kf3oTY9J3foP8VGe/dDS5Oy85/FpFfALI2YjxyU634RQfpz9H80Kiu7T/s6sNANZ
X-Gm-Gg: AR+sD13N+kMz0tD6v43Xry/bwKhVd3fPlrmbUj7HLxVbKgfaB9SynBbRIXrfkxBUlYd
	QFXBF5uMnXvqrwbiNUjpCLYCDIPoZxDTlhJLz+2LtDuDKHH11SJixYCKi+B63nn60b22sQ+rytN
	ZemchuzxAlrcLRbrmMebxQfrcY1SgeyuHpsmLeZmlZMQgR8vduw1mW2ncgRb6HKTNkMxb2JCvG4
	sSX6c4+zkicvvlJc5rH81FoGJ6UnzcHByNBIaHjljN10sFABeo12U2ZBVh6PtNq7tMbV6R76FwW
	H+/ezdYd7EhocGXEngEE/y7GuD+4d/FUeNsroHivGpjSX+FkmT4pIDUAruPv+9j+Zd1cJDyPpYn
	OiU4DDgK53xf3o7ug7LSNeEVJ9MsbBoJZtFV67JX4SW0vGt3WYm+L+uhLnLtuhE/EtlJQyh7pxu
	XIR46GrN1ibJnOOpu142ETAIt7qBffnR/YkmcpsQ52JqRJNmStmLwHaLpCQ1bU0w==
X-Received: by 2002:a17:90b:4cc2:b0:38e:488f:7068 with SMTP id 98e67ed59e1d1-393011b295bmr3943015a91.2.1786521811842;
        Wed, 12 Aug 2026 01:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8896c20sm2657981a91.1.2026.08.12.01.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:29 -0700 (PDT)
Message-Id: <c689148aef4302df2a370b78f30c185cd21a42c9.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:11 +0000
Subject: [PATCH v3 03/12] reftable: handle block-writer initialization errors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

2d5dbb37b284 (reftable/block: handle allocation failures, 2024-10-02)
taught `writer_reinit_block_writer()` to report initialization failures
and updated its callers, but `reftable_writer_new()` continued to ignore
the return value.

Consequently, the constructor could report success after block-writer
initialization had failed. Propagate the error and release the
constructor's allocations instead of returning an unusable writer.

Pointed out by GPT-5.6 Sol and Claude Opus 4.8.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/writer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index d969a6a021..073b9bbd89 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -150,6 +150,7 @@ int reftable_writer_new(struct reftable_writer **out,
 {
 	struct reftable_write_options opts = {0};
 	struct reftable_writer *wp;
+	int err;
 
 	if (_opts)
 		opts = *_opts;
@@ -177,7 +178,12 @@ int reftable_writer_new(struct reftable_writer **out,
 	wp->opts = opts;
 	wp->hash_id = hash_id;
 	wp->flush = flush_func;
-	writer_reinit_block_writer(wp, REFTABLE_BLOCK_TYPE_REF);
+	err = writer_reinit_block_writer(wp, REFTABLE_BLOCK_TYPE_REF);
+	if (err < 0) {
+		reftable_free(wp->block);
+		reftable_free(wp);
+		return err;
+	}
 
 	*out = wp;
 
-- 
gitgitgadget

