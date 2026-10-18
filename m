Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE27AC4D
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299305; cv=none; b=dvN7ntxKCmasZsoeG1iCeO8lMZoqOcEKqlevqrRFXkckFSsieMp3L5qGqYqD1D8T7E+Um1OQ30hj7/SzczsC21Rs24ycsAqtIcKL0XMFISLivnJIwgMgpFo/vvQwxmKcn0tlT2eiOf3TQeqppuVltRJRXQFtKCYgGckVxotc/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299305; c=relaxed/simple;
	bh=aQ12qpFGsiwokkNKO/xbkdz4ZoPtIiRhlAomop+AAno=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Y3gY7G7+sp8Pj2ZLP1cGZe37kJXSNTsMYRzZQ/InL3/IGDQ+92dvDUXcxW9zExHxpAWGkPVa9gi1EgpaQtUnKfVTVJRiw943+1ANJU9aYQvqb8wqdxx3IuKZex3UsnBQr7MgKhxr69R8aJnhstpxoJujKmFWwUgV1tLaEUkhdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTbLCn66; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTbLCn66"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917aca1aee5so11632996d6.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792299303; x=1792904103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q0mij4lhFxH1AtRnG5yWbYIbsEELTmgdeTL2QOt3qMg=;
        b=WTbLCn66o1/lCI/0VGjdqc+BjfOItOEUCxkpK0j+LuATqa5SbRQsVFwIpsuciKrZ/2
         szLB54zhfxu07xcNfMJ7Fsqc8Rt8ka4z7yKOvG8jQ3uFFDMvepWeqPhA3l3J40I42FXj
         RzLZMybLY5tHjPxKOX7K6eWlvCH+I4YlvV8mUKDbGsInRcdgJQMPLNT23KtoLAzZ9NAC
         Ob56zt7b+8Ro25bGOAAvqhxDsPzsiK5gIUiqjudxITehVlcOr8CBMRaKSht0XMVQEioT
         iPuPA1N2AbGP0IBWnJlmPTLxJBzefpBQC2Tx71Srg2DFY2R4dh8HHdi1xngQwlhWSjqA
         i27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299303; x=1792904103;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q0mij4lhFxH1AtRnG5yWbYIbsEELTmgdeTL2QOt3qMg=;
        b=26cN8hZpVFGkRzpUecHEPuLCB440Zlh4Ng3CozLAxkDbcRbWRmOQarNczJ8SxomMz+
         0t9qQG7sBgHOYqRSJFwSLCiOdrPoRbrt1CWtWG7tieI+ejPm0DVl7J38P1QRTUI2FJD4
         JG3BccXTMkhMWjwComwQycirAVTFHMjyECTD3/ReNs9YsuyBtYoqe3clyZvW3EnNPCZG
         B5iEAvMARlW54YQHukKphx9f17yXL0civHuqaOFpzYonAj/YaKzVekWJCuQCpk5c/9ql
         q8vYjuj5MisisQD+NRV4sMKiMKiUQtmjaIi0jSGcBRmo5sjjlMxrg/kecZaAdFNB/U8x
         f7UA==
X-Gm-Message-State: AFq9FYKElAbk23eN59VHUxBNXIKjBNADVKWn+3Lbo5E/T8QXU8cUTDXn
	xJT769kiqyptdw1SOl4m3Ql4+96VOny/LHy7MRG+q6s5swBkYdfdIUUwx/R+aA==
X-Gm-Gg: AYBFou3XU+9zBuglTmbsaI1iGVLxPxLVtSv/SHA0I+w8Eiqx5OimBd3E/oWtrVFhNiR
	8gLlqPRbTorVWwr7oODkkQNOX1i2AoGEaNm/Ax/cIxMQ/1DtjCSc2v2Mw80IHymFmKJ/8hozcwQ
	4kSQMFVBDUyaLuGNYTwHedFa+7yMi8iL20uUJu2JEjaxFA8P7fYAgXMPJB7fc3vvgUqvjCP6tvT
	pVudiZVyIrsMx1ue2W9EJoDPb8x6qn7xnGim0qr68HFOsq8MWnhqhbXnHjj/8AAP0wxztRmtapU
	kuPR4dMjvBzCgnWm5JjE3o6ZBgDt4HvETsRP7YgIa7SQIJ6q5/9QlrGc2SHCcTfNKnaSWtMWWGm
	RbBkgg9Qf9zfjiWlSi1dG/35J5EndQ7fwh6d4LHPIowMsaSgZanN4iYU/h9e6cYG8aPkarSjmsN
	Sp3SOlrI0myZGmOc1DkiFH2SXL0Hdd4+095fYTQonc47I6PPm9p28TtfnQCGcFHypDLRt+3yB9b
	Q==
X-Received: by 2002:a05:6214:19e5:b0:91b:d32a:9ea9 with SMTP id 6a1803df08f44-91bdf2e2286mr74675076d6.54.1792299302554;
        Sat, 17 Oct 2026 21:55:02 -0700 (PDT)
Received: from [127.0.0.1] ([57.152.36.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb233d2sm62916206d6.32.2026.10.17.21.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:55:02 -0700 (PDT)
Message-Id: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 04:55:01 +0000
Subject: [PATCH] [Outreachy PATCH] t0001: avoid pipes in test scripts
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
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith Poojary <poojarysrujith@gmail.com>

From: Srujith Poojary <poojarysrujith@gmail.com>

Avoid piping output from git version directly into sed to ensure

that any command failure is properly caught by test scripts.

Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] t0001: avoid pipes in test scripts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2260%2Fpoojarysrujith%2Fmicroproject-init-pipe-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2260/poojarysrujith/microproject-init-pipe-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2260

 t/t0001-init.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..e835afee68 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -678,7 +678,7 @@ test_expect_success 'default ref format' '
 		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat
 	) &&
-	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
+	git version --build-options >build-options && sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
