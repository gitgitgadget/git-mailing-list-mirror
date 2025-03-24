Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461E261570
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829781; cv=none; b=SbPa2YaoGvGioJlVFgvG22d/ozrdx9GvuAgRXT/kk4NKZq62ocDonRPqd+kj+P/vS1FMO9LOFebPAYPnyMjs2a8nL7nkItV4/Ujyqmz9bg3wdwU+8RYBQLIfGYAbY+iyBcbmd8DvNQa0nuLKr+Qjiq35uRMMjN3aEhqTzUHrY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829781; c=relaxed/simple;
	bh=nlUI0ABCQsibVHOq/5euLOYgQNpTrN2MpbxFeSrmW/s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UAFDFARxLGV23+3/0jDTePmahzGi2REMCUax785P69TlhbIg/LzQ9XLdRnRmaCtF/UyGyVTA/4FYdCcO7Ac58PdOBad4A3uYfavv29ph6LjuMFaoJa4HjGQLBfswQ3P1QMOCwCMSdgjAm6w9gi2az11W17+/ruasTsSj7Lmm/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2nPCOCB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2nPCOCB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a823036so46344405e9.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829778; x=1743434578; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upOV+Ni5f0v+0t/cclecq8DthtiSYqTCyAODw4CnCgM=;
        b=H2nPCOCBJed19D1+Myw0QvLS2+byXk4vYkt7N3dKCzKauMGtTqn+vxgs97Vu/jmbh9
         IU5GVPjClcvHWZpCGKA0bCRs8I7NjV9NyUgrm8qlLhlYYBXM95JGFeXPAe1rOinLehEx
         cMv2PmvJlwGaxB7rZBSoQLQzgIQgE3Rn/esYcxNk+TBQ93QnhRwyiKu5E7yBnM+dZdln
         FHxdBAv85OZbR7OfdpY5/g84zSRpIhEh8IX19gIwx4o/3TU1wTqMq6kFZsAD1zh+jpSz
         DlVffKmRXjmA99+YVrCoEPfKcfDj00aoq5rPJpj+ig2NGxhLknq8Pvy3H/wX5UQYXB9n
         V1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829778; x=1743434578;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upOV+Ni5f0v+0t/cclecq8DthtiSYqTCyAODw4CnCgM=;
        b=muGPsVLYPNmyymG8OCVVCI0nW+75eIy2Zn2eV4IY+wNQ36KLHFQUfQzsdj/WmrsUHX
         vIyYooy/ANIKAWUZOYZCmKFN/1ti1ynv4hyRlK9S9O0gQk3TdwwQv255Inb6SBhd/3dx
         waKS/P0Xr1DT6Plb6CcaMEvk25MXiKUDri7kivMVs1twV6rwfrsflNelTY/yoQsR1Kjj
         D/g9DmggNW4jJ3C6Ot87sIO9YrO958A8ukpEuS14VQIWA6ENPIMPv6zBuyBFeMNTqdVG
         uLWsI2vV/+8zPP4Fgve7EdJ+CjXMqMGSdP3RliSix2we4ETR3hu/U4NIJRGhBeqJ13My
         5pMQ==
X-Gm-Message-State: AOJu0YwBNYTS90KmjmNsLfltnytAwP7ml9bL2Qtw89N32ryLTAeQyu1X
	GnVK717geQeWcViOQrgBXONMcO9G/rPGKM3I6Xd2r+QxanPZ/7HVz3ua/g==
X-Gm-Gg: ASbGncvjWfPQG6mAqAM/rri/s4atndvWTRq0raWGBMKsszaM+NRuqpILp43cIhZEDrr
	4AaCfDiCK1IZjLzWmGSdXapSMCB5G/NM0E3ACFLEi2c6+xOGqZyd+9uYBofasAA/FLjGBNyWMjA
	Yl/JyZI/edbx+n1UbkdZQzDA+fVPWNJqFRUZrKzgT4qWKhMxnbHZPn4ncEnVrem1mB9qBC+HsL5
	HnOgpaxZ7lU3Q39YYCH5gvPHIV4UXhB6o6mX8ewW1Makqes/f4CJc1RjfuTYL88OhfqsqPwH04B
	U4ecPHtBiIBwNIjNexW31tlHkjL2dYSwOYRKm2ovYxx7uw==
X-Google-Smtp-Source: AGHT+IFw3KbwCbJRF7VzhhSmImRZrQQB2zYZKRa9E1u1P/o+8BcZ6ObrrKxzqsPdXy4Gt2Fsc/rxow==
X-Received: by 2002:a05:600c:4512:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43d509ed936mr130181335e9.12.1742829777697;
        Mon, 24 Mar 2025 08:22:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d53678dfcsm112349195e9.18.2025.03.24.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:57 -0700 (PDT)
Message-Id: <ddf804e606a5560639e4018709da33cd80c74012.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:42 +0000
Subject: [PATCH v2 06/13] t5538: add tests to confirm deltas in shallow pushes
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

