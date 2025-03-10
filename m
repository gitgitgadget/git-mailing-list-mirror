Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE05190674
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571465; cv=none; b=ZMp1OqJp+6YpFMIbOKKxIXro1FRppvYUinNVSVb7ZSNdUClzskXL/Hol2POalWWq7R4ypoV1TpH4w8dAUyGDNsDjqy0wbCZ7C/SSk6xSMKigHqKpIWcXuTub2obxnBrJmPhiwVjjgxdn5fIWfI145DMLLhiV8dOl22TIr9waB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571465; c=relaxed/simple;
	bh=nlUI0ABCQsibVHOq/5euLOYgQNpTrN2MpbxFeSrmW/s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GV6T8RsDFcXDuQGNciMFrWkha3pc8K74423XvDLqnsRB+QKfA5t6G4XreqYaeuk4tL53xkVx2XVP2bxbYL05Eb+fFUo1sSuiv3Y+jYMAoU2fRkDouXXX/M6kua8MDgdGay9gpz5VFQRouDJYsU5HAsuffq4H9GSRJUAyv6Zr+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncbihFV6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncbihFV6"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so543086066b.0
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571461; x=1742176261; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upOV+Ni5f0v+0t/cclecq8DthtiSYqTCyAODw4CnCgM=;
        b=ncbihFV63JPYUo2vK5FwyH13NuJd4cbaFtTKIQQdz0p4liIR0DgrZE0wtSbQ7teSLW
         Mv2VgZSPxWVcBW+jOudx/C2bmeo3f/CWE7KcV26HnDGw7EMZZJVj1rUCwTB1Fb6U4dL8
         fF6v9RUSBW3XTJxstMNP/A1i+aF04ozf9dgb11oZIiiZIByFuZ3qshYafchKxvOkAUEc
         uM5JclwqrZ9rIa3A2/ernE52rGr02AY+jHfT2LGanC83Q2f+y+lTPvboJNaTy9S5l8kL
         GrvlGHuCeJzViRXgsITUDgQO1Ysf0Kk8gUmmyeTf1ZbDA2qwy/OR8JBo52FhrNeAN7HZ
         qPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571461; x=1742176261;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upOV+Ni5f0v+0t/cclecq8DthtiSYqTCyAODw4CnCgM=;
        b=IKaKt6ZXfJzr+balVEx4ZCZtEKcmSXPIoK+5GmvguJs5lDxClm+SJFqnVbAtDB7m6N
         vYYaVBfRI5GiokB7qN3octrvoeZf6c/MHyu+8c4bko94yeokjZkqQefvKSssExexOS+N
         1y5v0oGfibFegVJIMdgtXCiS1t+mKgaXRrXvG4ZGklkDoY8t5tPEiZYVG0u/WbokUek6
         cHIMFwyejeRmcXK0ttE0eaGIEJ8mrhPjYrUZre+f4hEMsLlXZNPd9U7NJkQrjnScdmkt
         gkVnh4y2bdqRnfd36l+Iq4m6o2ABxUHFG6a7JC/5JwlrkquYf8od+BL9AqrqAIng+a9P
         SlSg==
X-Gm-Message-State: AOJu0YwiPrN6hdwdP6MVrfkjdQZ2QjxR5zm08pQ/ouk2G99XLHT7uGqM
	LNYClwZDFxBgULrOpq/z2ygg8PdGrrE9loPspvgTi3OhYlL8rbkMajFYsA==
X-Gm-Gg: ASbGncs3Upu1pXc7qldFk+UbP5eDrG3Twnsf34vRuCUzJCu4Y3Lma/ZZbVBsvbMLDeI
	K019L1q4bRYRa3/mL/FdL3l4CLvqO/VPHXKDj94/BULyJmrUyaCs1Coi56DlhbCkbXYcG5f97yG
	ZknqaKW0rg1yKKwe5TnIgdsixC24TsNFaGIIXVRVdxCZbYJSHqgsmFrC75NZxNJxdJWaFtGrDE7
	vruT/KXLeHcuemMiaZ0q0SgvlmBuRaJgdV17194ROJAcqSFL4/1cT5Se63+bcgEO7gKyxQQtITU
	qrs2gLsDoatQE6kg/YH+u2c03iu5W0IBVa19xinWKntVUe+VKhZIk8Ts
X-Google-Smtp-Source: AGHT+IGFsTT/bNUBD9U+SgTeTR8mod3/a1TCyZsMOlMP+Q8jJqYqhhuNCknRSSDhGkwavL7q6hFutw==
X-Received: by 2002:a05:6402:270f:b0:5de:dfde:c8b1 with SMTP id 4fb4d7f45d1cf-5e5e229de50mr27823782a12.4.1741571461264;
        Sun, 09 Mar 2025 18:51:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a54c3c25sm52342966b.118.2025.03.09.18.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:00 -0700 (PDT)
Message-Id: <cfee2136e92832cb3fb4e90e016d5d71034ea9a6.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:48 +0000
Subject: [PATCH 06/13] t5538: add tests to confirm deltas in shallow pushes
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

It can be notoriously difficult to detect if delta bases are being
computed properly during 'git push'. Construct an example where it will
make a kilobyte worth of difference when a delta base is not found. We
can then use the progress indicators to distinguish between bytes and
KiB depending on whether the delta base is found and used.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5538-push-shallow.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index e91fcc173e8..11b85cca9e8 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -123,4 +123,38 @@ EOF
 	git cat-file blob $(echo 1|git hash-object --stdin) >/dev/null
 	)
 '
+
+test_expect_success 'push new commit from shallow clone has correct object count' '
+	git init origin &&
+	test_commit -C origin a &&
+	test_commit -C origin b &&
+
+	git clone --depth=1 "file://$(pwd)/origin" client &&
+	git -C client checkout -b topic &&
+	git -C client commit --allow-empty -m "empty" &&
+	GIT_PROGRESS_DELAY=0 git -C client push --progress origin topic 2>err &&
+	test_grep "Enumerating objects: 1, done." err
+'
+
+test_expect_success 'push new commit from shallow clone has good deltas' '
+	git init base &&
+	test_seq 1 999 >base/a &&
+	test_commit -C base initial &&
+	git -C base add a &&
+	git -C base commit -m "big a" &&
+
+	git clone --depth=1 "file://$(pwd)/base" deltas &&
+	git -C deltas checkout -b deltas &&
+	test_seq 1 1000 >deltas/a &&
+	git -C deltas commit -a -m "bigger a" &&
+	GIT_TRACE2_PERF="$(pwd)/trace.txt" \
+	GIT_PROGRESS_DELAY=0 git -C deltas push --progress origin deltas 2>err &&
+
+	test_grep "Enumerating objects: 5, done" err &&
+
+	# If the delta base is found, then this message uses "bytes".
+	# If the delta base is not found, then this message uses "KiB".
+	test_grep "Writing objects: .* bytes" err
+'
+
 test_done
-- 
gitgitgadget

