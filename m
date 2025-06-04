Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F42459F2
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749023965; cv=none; b=I/BKgV0EF0Nu3uugXbBmKm0j8Di39rI8xlTpEL90RuRpLM0A38uJ5EnYdvFvPcb/Eo0AtKUD25uuDFGT0s6Jlqa/lctV2OA3GsRtTmYjyCtnpPf5OfxLcgwWQgYQVNN0sx4/MXM9qgsKLneUvVo7/U+ZHEfaPpv1XKZY+D5l3fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749023965; c=relaxed/simple;
	bh=y/2pEmEJt5fthUq6cD0d1oV3u6bGmlnCLJKLZPzgy9Q=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ez8CbVJ141mTgwzRffKqdtx3dfefcC+8KugEc/RO2lntZ5rzgJ4JwDaPJl47ZjK4+Nb4z4PJcHNcbGf/BPhhbI+pC141RHKQnLBFA30LztJKNQOwodyU04s3z0QSysmIbeQpGKlJV1GH4wJDk24PFic+rumuWfTMLFrJ9NVTLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbymYIpX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbymYIpX"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso4009547f8f.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749023961; x=1749628761; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7TitnAqaIIxsP6QqYBpuH2FbiBma4z3ZahZ7ZFr7ujY=;
        b=nbymYIpXZ3tmS+yclLp7UYoFCSyUYUyxPrqjUNU0bqf0VMBSH8+yV4aoTFapo03Es1
         wLXFxmJ4JbXpIRcMUUn5El9eBcDiOCYexxwgR9J0HivFUOtZRFtt5R6gy4pRCRkBlBb4
         fR8tFHqr7h/2t7aHPGJyPaKiwCWqjc1fpb7vrJr787QmNjZH+yrHoaws2rCaM3oFpFwO
         kRs/u0B2Rn75M7ZRtJxa04356FvFYaRtVi89+GZ0wf6LTS88Xv/WSrEffWLAZiu/nL5v
         1f3cWq3IWlwZ74tJcGADjMUSaqQKNNKWFlfiAxuPSXx3jnqu9k9vWftrbIsXGlX7XK5b
         mZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749023961; x=1749628761;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TitnAqaIIxsP6QqYBpuH2FbiBma4z3ZahZ7ZFr7ujY=;
        b=m4KkCSpzWeswstYQqbNasYELmRv5mg9B5x3mCOr+p9BROSLHEb8/LuEsqnxvBFt71D
         +whRQVd482t6e3dJeec1l620q4Ivaye3ddn8nP413VWNLJfAPXcf0aau6VXU2ZV9Nce/
         ImTv0m26Vb0vr7nunzuYlShDrPaGUxfSkGKN+CXk945pHwb1e7cJCrCw0S6oqH5c+Oiy
         Gv3b3+zwP2UMTf75J3wxWWSLBxvYmlROqdI7d4B6bHberMdDDVBZfhA8wiblMnWgpFxi
         vP+7QXtJsMLX0LriJn9InJTQJ4OZkT6hn2VKdm6UTpBII+f1PvnzIU7b27X/lAoII/Oq
         /IjA==
X-Gm-Message-State: AOJu0Yx2Sqsiqc2fT8qQ4xodOUkC+vsU1gLt4NjFKjby3MSh/Z9mumFl
	Q5eB+oDAUyjyTB0H9Wa69LXvIOm9AbCIgwJ2nPFN6XGveQsI3muo5ULYNTkPMw==
X-Gm-Gg: ASbGncsGSqvjT0Nq0MV+0RK8Ii8dAsuxNBOIQCFhA4qv+5OHJc5Ot6YM7UXI/HM00IE
	jCqu5WGFJITxQFvTYplROXBSTC9d1mVx2oau7PfGnCsUHkR3Bx/Ya/cEf+tzu8iG8tyKBqrGrx5
	JDtaorDiEN7ej3elUAlkNB0Q8ul9RRfUM7fEzlpBI/ZzaGMqJ3S89WPVB2ffwuKADfDsrTYXwfI
	HOnkeMc/f4x/Uiat4WfXUN986gwxwyCE/bJ/bxvdP1ykr/Gxde+ywdZPYnluOBjGR63w2Pqv7Cp
	aO4bWccB32tVuiEHW1XGfcxco594f8JB8pV54MQ3v2D0WokKIkVt
X-Google-Smtp-Source: AGHT+IHI/I4vMP5CpvXu49SV6dB3Ep5BuuqLI/RFwyBbAwQma9J5xfW0MxzdXxytpwdy691DBr76Tw==
X-Received: by 2002:a5d:64e2:0:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a51d9305e1mr1304544f8f.21.1749023961376;
        Wed, 04 Jun 2025 00:59:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a02cdsm21008570f8f.94.2025.06.04.00.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 00:59:21 -0700 (PDT)
Message-Id: <pull.1985.git.git.1749023960409.gitgitgadget@gmail.com>
From: "Jan Mazur via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 07:59:20 +0000
Subject: [PATCH] bundle-uri: replace printf with fprintf in print_bundle_uri
 function
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
Cc: "Derrick Stolee [ ]" <stolee@gmail.com>,
    Jan Mazur <mzr@meta.com>,
    Jan Mazur <mzr@fb.com>

From: Jan Mazur <mzr@fb.com>

Signed-off-by: Jan Mazur <mzr@meta.com>
---
    bundle-uri: replace printf with fprintf in print_bundle_uri function
    
    Small fix to bundle-uri convenience debug function.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1985%2Fmzr%2Fbundle_uri__print_bundle_list_fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1985/mzr/bundle_uri__print_bundle_list_fix-v1
Pull-Request: https://github.com/git/git/pull/1985

 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 9accf157b44..c9d65aa0ce8 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -122,7 +122,7 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
 		int i;
 		for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 			if (heuristics[i].heuristic == list->heuristic) {
-				printf("\theuristic = %s\n",
+				fprintf(fp, "\theuristic = %s\n",
 				       heuristics[list->heuristic].name);
 				break;
 			}

base-commit: b07857f7dcffee4d3b428df8dce6c9b49a57c9c1
-- 
gitgitgadget
