Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC03DEFE5
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140418; cv=none; b=ZsvMYs6QvVIGGs7WtPntfgluYVAsMVzoZPdGPlYICE+GpfVAWXxL1CtytFhYp3Re6g37ssBn2lDU5sVL4SjbHrocxVvZ9Ls1e9X0RFPD/WC9V5BnFwvdv5d80/8Ic3iwrZ6Sf5/ZPyd1Xw2BOo/piucr1LbrHqWrf6xQQCU1RJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140418; c=relaxed/simple;
	bh=8uw7kObl5KOcBicJq5x2U9BULp4QBQ4NOeK4/WfnuXg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rQUqwf02fH4OxXa/GPA1C+tJdP8F9m6CazzB6Kh/+duXvO3NfRCbY4lm+wxusQhfks60rA9P3DHMY5EFtHzLhs+yz1jHrWZa6j4OzpfVcHIAVq69J7YePO5Wwc8656jX5A7WZegJqShdFUeViW+jqZTDbYZegobeXQzx3SKEnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2a3a7Ur; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2a3a7Ur"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ab3e26cceso8744497b3.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140416; x=1775745216; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNiyN+0I1E+n88lbn0W36AflR2LQgGLc/FSYbdHEJVE=;
        b=A2a3a7UrRoXTl8Yi7rwb6VJKPIFSyjQ1+LwsXi5ByhDywf8XimuKyAx1xEfcOv5Loq
         Uc0vQ/ky4j0AjPggxLGO5u/teSecacLrBn7yPdoeE2RHwdrdggqZ+K1zwS4eY5by2Whk
         a2GJIrd0rDsW1nkedDfOALKnP6+cxUDfzXn8uSrbNU/CukDPISJvFGtPs11/ZxdOo6ug
         TMhVmSrcK1im3C1qu7TEQwqm6v4+mkfYXs5BiBs2ZtYBU8wUSngZ155Ft7dHNE4Sn0+Q
         G+VKrFCVyWfbmuyQhUpijxaDvm8FzrNug/nO/r6Wy/fTXC2Cu66DhAm+Gpri2s5AkeOq
         CAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140416; x=1775745216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TNiyN+0I1E+n88lbn0W36AflR2LQgGLc/FSYbdHEJVE=;
        b=nHPRkO1rP3t+vkZNcg2xXE3SzDeb44s77k52Mf1uOAt987vG0fHpuvF72o/kl86OMO
         8RzZEP8wuBj78Cf7sV/LbW8IAlDoVI+WptGhldbUzWjl/Dy9KwOwKAID9plXJMRYGkfI
         BNnRLqpfks4IxV09w5DyaCU1HxBosBnIudJgE9hoeWCxW0e2wF9mvszW4u70ISNPuECM
         crUam7LmaYZy7FaWKku5lqinl23H6QRswjalJ1+IQgjzW45YpMfJaD1RxM6EXd6RA7U9
         laqTAa+ai24HxMGYR32JB2fn9Iq/LhH/d8qZ43A/IEVG3lsARD7DUXcQ6vYZ8vC5EpUl
         WY1g==
X-Gm-Message-State: AOJu0Ywr7A5y8AbiIDtuuVhoI9A9XGwHbwc7CYIYwJe5X6G4ZrN8v3bh
	4DD8yvT7HOAa7EL9XrypkjdW4MH3mDUrmqTnrszVYB9zVFeb7TBf8FvJ61ms9w==
X-Gm-Gg: AeBDiesGDl4spoX2B6bil6EdpbH8E+rA4IN+njujfqgFSdoCGOa8x42w7vQZfE9LU2J
	bjdCxsmcJOIj9/h3XhG4w3Yt81jTvXq1OTM7kscNGF5uR4eEUppFOI2DwXdNJxpdgUZ+RnVqN5o
	fcybDv/D+ROOF9gyg+OMUPwaByaXjllcPq88hcIPncZ/QHC/0RKYweoXU4SjcyRX1pz79siXoFP
	NJARdLMwLVgxvXWB+7tV/FLkfxe/jGvBo5JVd+vAAHZ21aa3ah7XqWklHGKmpvjuKFUFljNc2fs
	Yrfql38DZYQ1ngm7P9Mtv1e/zpB8IwSE0AW4BknKc77/ghL7Ui4pWODh/WDMUTusCqkluyoG5kx
	zpci0MmtmluegubkqxDQsQb3qun3GETwZQWDJ4i5xxtHvUvZF8k9O7Zrsm8s9pBJL7LU7v+29ld
	gVZEoCOwDJ8HDBc96pxLvUuFBRDEo=
X-Received: by 2002:a05:690c:e72c:b0:79a:d393:f8b1 with SMTP id 00721157ae682-7a211a418d2mr68724647b3.26.1775140415856;
        Thu, 02 Apr 2026 07:33:35 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e830f12sm11389007b3.11.2026.04.02.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:35 -0700 (PDT)
Message-Id: <2905e000c526e6fe7140bec7a7ead152b495db65.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:14 +0000
Subject: [PATCH 08/17] t2406: use `--git-dir=.` for bare repository worktree
 repair
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), the test case t2406.10(repair .git file from bare.git)
cannot rely on the implicit discovery of thee bare repository. Simply
add a `--git-dir=.` to the invocation. The `-C bare.git` argument is
still needed so that the `repair` command realizes works on the intended
directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2406-worktree-repair.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index f5f19b3169..cac448b575 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -84,7 +84,7 @@ test_expect_success 'repair .git file from bare.git' '
 	git -C bare.git worktree add --detach ../corrupt &&
 	git -C corrupt rev-parse --absolute-git-dir >expect &&
 	rm -f corrupt/.git &&
-	git -C bare.git worktree repair &&
+	git -C bare.git --git-dir=. worktree repair &&
 	git -C corrupt rev-parse --absolute-git-dir >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

