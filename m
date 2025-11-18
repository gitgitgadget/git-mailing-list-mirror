Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89E2EC096
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450812; cv=none; b=Rm5PPVTpekeZnFOE5O59re3kR3MWSXuOvTlEiobfxoQOtsdgJdOg9HDT1R665DZJw0p91u2MytFEKUIP3i2SlfK50bDCE7mh5NYEUbedgIJTTx5ys3TQgwejWJublq/zNhyiYOK7+BD6lcAxnHxPBSBtu1LE6Az9BS731OVhw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450812; c=relaxed/simple;
	bh=mDa79R1g4z5BSOMlYadN2FTHvBXzTmoGsEmUOaMnflM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDi93/UXM28eO1L/VgqnqC4joxf52e9xKz/0KFR5pV55BGjJ6H3ItL6WCDh7sfab6tb+UioCGZ2O9jPGy2WAPuq3V1IzRXpCxfSlXAAEKyPeBCWkMvCiyoitLUO8V81kfesqyTeTptxO1JHQlZPCFTTmLkyUJjHEd+HJptZsqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgAGSjd7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgAGSjd7"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7866bca6765so48215277b3.1
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 23:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763450810; x=1764055610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8lahWdAYJG/19FPT122Nfiha0jz9wtCjokD6Fu9mMk=;
        b=bgAGSjd7CfJPV5h41JNdXX+anpkmmNZXZ1Ek19cMg+vm6Zb8Y9+ZOQGI4FYhEP+/Yb
         ZOubmNnN79GZtcrZxpsOcg4KfJ3fFIiFLoLfiUjFW+2oIoef1rG2uRbGSUcBLgjEKbZh
         6lz03fCIyZAv7KN69pkRnCJ+2LvS7MU0wLMP0mSwJayiX9t6EmddzJUBeMWNFLqUwf67
         S2B08Te76uweCaVQkX+ZFjym5/SOp0cOMjVnDWTPHR8rYQSLqITOpUocSdtWuN3sqfLo
         9sPh68nnTqTSrxysiRLWnuJJT98aiAzPZg7EVx9/3HqN2qXLVWcVjYfi3jNVGELpBzXT
         rM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763450810; x=1764055610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8lahWdAYJG/19FPT122Nfiha0jz9wtCjokD6Fu9mMk=;
        b=jgIq4M/cZKbe6YAfRyB9tlAL/pD6lx1aedSTOTQorPWt+U3ZXAD4MMO/8EZtGRfV+K
         Vz3KuaoKkWurbDkhGkqCIfWflnG41De2LCRN6gN65pYJmlslDT0QVwGRBB1CGfMXD+DE
         Zrxibl/jrar24E8PBdfXMkXDmI3kSzjciWVOT1deM2iUnuM/EjpFfVMQL4glIfc2x891
         oTZ/MPRZ9iSGYIAcRa7Jf6K+yYynPQ9RUD0sQ2rdNRc5Lniz0g/FI2dCplYqGuRuRmMr
         7HGVmDoh77Yi+QcbWQD88b8ImNtk+J2mYObRseW55sqt7qAS9/cbL6R5PoYBb8s6LyaE
         DJmA==
X-Gm-Message-State: AOJu0YywmjFdQITCEHedhORHBHi+QR2DOA0Ee4UQHBp/O9j1o2xdJd3a
	o6zha1dKr0GrdaevRouJml/d/j1Oe6KNor5dwauW8HslQYWNRT8Rpg/QFuEqgWVP
X-Gm-Gg: ASbGncvment+Df9TCyoElTq/ghiPoIAmUzYF05WN6KNdMTu5lGT8T1ng5NMUfZfJ5yE
	x8nMrc7bsu8R8Ku2UCAwvttzkfGKsq/XPVkYuYCFRB9voedkBsNlFD7WTWxyUrNbW8lrJHshEVL
	6/ao4ywqLwg1EPRHNkQxSZGG5YHSowUon5dWqfPiZs7EcPguydeGK9vLW3Fa61FyybwzT5g4fDO
	XUpe4WyH7SKKuk98J7/RDjVrXvMJi2x5k/0p74Us5u1oF8M8uX1AaSJmaXW+qMveKAoLc/REYhp
	iy+e66qivjQ8yvNbJcJT+65t/45HSlXgQGX9uBYYxQZD2aqYNpI8/k6frJgqbTy3Pr299px7Ema
	1PpohqL4obpcJvgfSx90Wsr9pvbfX+AgBI6l6vM2kO5Wl/9Lcfyqn4sYGFuP9w5GCh347mylGiY
	+m5HakWLAu923IfoDMHu1g0EyQWrAhnI2PXO4KFRX3TxEpC/DXadPzkFb9QL3icg==
X-Google-Smtp-Source: AGHT+IECaneXHKEtYYzYJZW3YQqbrf1dSuFk8+qNOdwyhpeW6645SnHgb5qcDsLyvo4jOSOvX29Ggg==
X-Received: by 2002:a05:690c:3384:b0:787:f5c5:c639 with SMTP id 00721157ae682-78929dfdfedmr135414467b3.3.1763450810217;
        Mon, 17 Nov 2025 23:26:50 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882214e1d8sm50052087b3.49.2025.11.17.23.26.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:26:49 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
Subject: [PATCH] ci: bump actions/setup-go from 5 to 6
Date: Tue, 18 Nov 2025 02:26:45 -0500
Message-ID: <ebc68ec5b2abbc4702b94f833b9b3bf1adb79f1a.1763450087.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cb24b29c-1fa4-8f01-88ed-c6f02a1bd990@gmx.de>
References: <cb24b29c-1fa4-8f01-88ed-c6f02a1bd990@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Bumps actions/setup-go from 5 to 6. This upgrade includes dependency
updates that incorporate a fix for a critical vulnerability.
[Originally opened at https://github.com/git-for-windows/git/pull/5811]

- [Release notes](https://github.com/actions/setup-go/releases)
- [Commits](https://github.com/actions/setup-go/compare/v5...v6)

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 .github/workflows/l10n.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index e2c3dbdcb5..95e55134bd 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -63,7 +63,7 @@ jobs:
             origin \
             ${{ github.ref }} \
             $args
-      - uses: actions/setup-go@v5
+      - uses: actions/setup-go@v6
         with:
           go-version: '>=1.16'
           cache: false
-- 
2.52.0

