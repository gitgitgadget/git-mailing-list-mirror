Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705813B7AE
	for <git@vger.kernel.org>; Sun, 24 May 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644417; cv=none; b=Mc+UKNB1/l3sIyvXq4ckUyN169KHuyjrwRyMxwPNLhWnoAcZ/CDiWba1qPGeEiHtfOzPUNjJx9ytWYuDi7Wm0Cq8MyXdnczxmThzlvlFXzNl5zmQyDLYKCRJOllaWDLqKrOngsMumTpSI+kNtc02Tjru56zoODEaheGRabfRxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644417; c=relaxed/simple;
	bh=I7zau6IE8rlcykWfX9X0Vwo9SViPipZzCE3QpdtxdKE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=J0k/NHzlooNVTn6mOzLHjELf1Uu1miPqKpGRTaOzdRKNbwKEU2fw1EEKxjiAwCvAYdhYcAtjKFqWCl2giUfE/3UHx3/AIWd9EENm0xxEtiqYf4f0Wv/NYmp+Ki18P4pzrITjym7m9V/mdjEVtQzyiR/672vneJfamhaurpBTvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQuoOMTi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQuoOMTi"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e63771eb0so89890841cf.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779644415; x=1780249215; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJJ4VcfDkjcglLme3Vy9l5VDIeWG7Nfyfba4rs2XBZw=;
        b=sQuoOMTiIDj4xNR+FJpP/nwsWxJYQ8/34i6g3letnc2hvDBAeSZ+bTAVai3PYuUKsO
         GlI1avTDTtre34dp7rmdUUd+0pDLOGJBuIp7B4P0zEqZItU82vYIoWseUaR1M+Ze2Ozg
         zD8Riqfo+SyWkKkRDb18VVpaeNCm6Ve/n6MbqZfth2R1SftWZDUiAxYMiIxvULIOK4BU
         7pK77F1o4yVCRSVvMqRWCmMMwvpaSb6WpD47uG6yiC5jPDqexJoEiMx926u7VgobaLDu
         gowbZmXjWTBuoHGsWT5slG4p8h/4IJK++9Y0ogI6lOG2+akwUt6NVc/eda1xHlij/PkC
         QWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779644415; x=1780249215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJJ4VcfDkjcglLme3Vy9l5VDIeWG7Nfyfba4rs2XBZw=;
        b=rj6hVZUz96coZfjpGnm1KTrQRwkJw3EmAMazPcpXzo6Ds3L2kuy0ApufNuREG+Ln1n
         3ParQYth6vv2et4M2SH/p2laETL5p/nNZzvTsWEdupsmK2Q+O8vuei59A0Zwsl3M4a5c
         LG8FBqwHTRGo5k9XXaSrIYRg8uAVcluMo71wvRhXG6vd6JzschJVrx94q1WTdOrhU+zM
         zXINxZVXZXNLggvcR/hH3htBgEiaet3KvjvYMr/6JayJiDVIaV3Ac/EI3Is0KZxsgai7
         ISg3tekp99FtFAwQMHXDl7TF3PsoMRH3dK00OfVktk2YEA9cfKr4pOFazCXjj1Na4cLd
         L6Qw==
X-Gm-Message-State: AOJu0YwXLNT2xcCIj7vBBg+GOQ4J0X3xa5bW9nYaGSm8Q5H7HZOlpIFr
	fY94rN1SPPIWfSelPm67aqWFIZX99PQgrFwMu1Rih7cJ1iDZ/M9bJ+TrknZyKw==
X-Gm-Gg: Acq92OFuItPu1kUXnF0lKizVKq22J+/vVzx0+AM7EzvSTmmAYfe5H4LHYywHzJ7d29T
	BHeRfEvzG7F2/oHcARZFZXoWRltAkDknRi93l9qlk7vlZDbnzZ+Zn6qJMSQVfIN0PageWVSAZBs
	ZfKKTYFtV1b+eYDS1TiEwnFRhuYEUhhmzB7U8kKAlYBoB7hkbjS8J8PfT6thgfmDXYgijcvsxEA
	iDqu/PHS2ovRquzPwCVXur95KFxDdHQ0o+usJDQr0VSJqkQrNa/phRU2Qis8WJVgbf35l24cc7U
	a+dURot2JlvGyx/xoqtlrPbFE4NG7BM+R+ArPB/Bt5e4Z9Q9fsDnXhMsPEKpbSfP9FPWFbHn1Pb
	rF54nr7uscD89tD1e3CighCyZ/sjFqR7wpknr6Z1R0RMbWutBMkXj2pKykegmJNTJ/PzEHQviqK
	fxRCp+EOw1NN9kPH5KftBFNb/F
X-Received: by 2002:a05:622a:8414:10b0:516:c8ec:5f67 with SMTP id d75a77b69052e-516d43ea9b3mr117575951cf.56.1779644415551;
        Sun, 24 May 2026 10:40:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cb8da8sm73861021cf.20.2026.05.24.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 10:40:14 -0700 (PDT)
Message-Id: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 17:40:10 +0000
Subject: [PATCH 0/2] restore: better integrate with sparse index
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>

There's still a long tail of situations where Git expands a sparse index
in-memory in order to operate on blob path entries instead of intelligently
handling trees. I was recently alerted to one such case with git restore
--staged -- ..

The basic idea here is that the pathspec . signals that all paths matter,
but what we want to do across those pathspecs will ignore the expanded blob
paths with the SKIP_WORKTREE bit, so we should avoid expanding the tree when
we can.

This series has two patches: first a test to demonstrate the baseline
behavior of git restore across different sparsity cases as well as
demonstrate that the index is currently expanded. The second patch includes
the fix and maintains the same end-to-end behavior with the only change
being the performance improvement from not expanding the sparse index.

Thanks, -Stolee

Derrick Stolee (2):
  t1092: test 'git restore' with sparse index
  restore: avoid sparse index expansion

 builtin/checkout.c                       | 57 +++++++++++++++++++++---
 t/t1092-sparse-checkout-compatibility.sh | 50 +++++++++++++++++++++
 2 files changed, 101 insertions(+), 6 deletions(-)


base-commit: aec3f587505a472db67e9462d0702e7d463a449d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2121%2Fderrickstolee%2Frestore-sparse-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2121/derrickstolee/restore-sparse-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2121
-- 
gitgitgadget
