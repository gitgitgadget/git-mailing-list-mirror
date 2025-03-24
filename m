Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED9B667
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742777517; cv=none; b=UmuTByGGDOj8bLIz/PTovXh1LK0eo3PYxjdZd0eErz71q+TRHjvo3JI1hQxft08XKuT/N2rLYpHoBq+Xcy3lasHUC+s4sGlSwZiI0ebFdjSbnUtTcDFgGwD5LqTNetIoJVY+s06Deq+TzarUVa8faDHiIXZkwIl+UzteAkX/QRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742777517; c=relaxed/simple;
	bh=CeF1RUYKzZIDjAVd7v/sxhEGCf8D0oVLV6z4jyBxOZk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Z3GmdlPD9Pbyzr9NJUOW57JHHd/jfVlRpmCXDQaeMfFNsl2EmLe9p3ghiPeD0yrunUmQJZho/rXVoTaMQqMoNCBxVgotYR9UCPFiFxlkI87vsBDLzBucuvjl1V9pOdr08o1K8qOtHY/cau+HYoYpuU1gnZGkYUAywKE6ED+x0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8vV4KBV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8vV4KBV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso42130235e9.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 17:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742777514; x=1743382314; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UN+2vo2lMq1ofLiN3ucrTQLKEXVuSBJvu7wlwC5nRvs=;
        b=E8vV4KBVOyC/cjY65kcUkM98XezZaYVxf9WR0kl9F899uadCMDV4f1T0CnvX21MDmm
         l8HvGoA+hwTtezxPz1beqD/x31JHz6pIjL3c151+4OiKJHkipLPQDGjZbpfRPEGd2+Ld
         VQzptEKRa+cPNr60KRJt85az7pwgLTc1ysWrLB0A0+OUpJbcpVvdUv8BXykKN222PQDw
         B9G7yZpMI6RaDtTDL5aXD3mC195EvwDasvqtziWn7uWI276nQYDuVufwhSjUuDspd/Ze
         XDaj5JjhYZ8MQGcFI5sof8xlA6uVs1d9XLxpFsm+JLBSI7USALI4O18SeuGaBw9sZzte
         vbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742777514; x=1743382314;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UN+2vo2lMq1ofLiN3ucrTQLKEXVuSBJvu7wlwC5nRvs=;
        b=t4D9riSK3E53V3qmhMm5N4XT/kUulMlkbqc+kUywjnM40FJtUzB1yTvhxWmgfSAKE3
         7HlUOXigw2/SyeIuceG5IiRbd51E8YJ+z3oXUDnaHdlxjDRxXTzzOsJ9Wuav4Y2fWqFY
         wyQ+BzrRWraIdOG5y7DEQS/fP69PV7FtXqo1ybYzOlRFB3ryl5ZCrUmz5P3ti7ortQX7
         QiLpz+SHMyDtSEGvlPx809APNHhc4LKlGq5hOo5Qr/kKTHIRHdVL9rMRhiCbEz/fiQmv
         TZlY7IC+rJ7M8oQqYDlyow+85FxDb58Az4YP0uIWoiwyKLPKUib8Y/xyf7Yg730efVd9
         Q4Vw==
X-Gm-Message-State: AOJu0YxlsZISdlKLIEnHWxIaW/xVGHOZWsd5V0yCaTVx2E6yT4PI7iAm
	XdAPmj3g8t7VBsX0NWicmP7E82OInHrb7AWFz20M9qc3zn713/x0oBjN+Q==
X-Gm-Gg: ASbGncv9rbWNAod5lVLLN0efZMDpN3w6LZtHrrEIbHLsoiIyk6RRIfEETeoVysVfaj0
	h1NJKMtM3MPAJlSNEtH80CNRph1wF7luCP4VwvUPxT8AI1QHnz3GYXbwNG/Rsa7hBbbHqh77F0B
	HnlskYNAXS+17uN1GZqkDyfQ7jW1xt8E5eY4l6u6Jkm8bTbcMWYam5cXGJD0y2QB0GXY9xF2B7+
	siTv/v6TQkt9pngeeBVjFtIo7qcKQRMHdDWpDYeJFa3I6MmzDn51+tWYAlMfJxhsx0a09SeaB7h
	KY3FHaQ8zpq99czhTJlTwEvvXI+RJ5TW2RP8ues00fO3qQ==
X-Google-Smtp-Source: AGHT+IEXMyJxcj81XfRYyCtcG4i4V8WR3y+cM71eyMWOcMFsCMlWYAXgmtoWX0uj9g9vymzJWV8Xlg==
X-Received: by 2002:a05:600c:4e41:b0:43d:1824:aadc with SMTP id 5b1f17b1804b1-43d50a3632emr106644825e9.29.1742777513456;
        Sun, 23 Mar 2025 17:51:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed786sm152563115e9.38.2025.03.23.17.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 17:51:52 -0700 (PDT)
Message-Id: <pull.1885.git.1742777512.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 00:51:49 +0000
Subject: [PATCH 0/2] Allow configuration for loose-objects maintenance task
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

The loose-objects task for the git maintenance run command has a hard-coded
limit. The limit exists by default for the purposes of background
maintenance, but can be misleading if users truly want to clean up all loose
objects in one command (and don't want to use git repack). This adds a new
maintenance.loose-objects.batchSize config option to help users adjust this
value up or down.

When testing, I noticed that progress indicators were not always provided
when isatty(2) is false. This is because the --[no-]quiet option was not
appropriately passing to child processes. A small change fixes this before
the config is added, so we can test the results using stderr output.

Thanks,

 * Stolee

Derrick Stolee (2):
  maintenance: force progress/no-quiet to children
  maintenance: add loose-objects.batchSize config

 Documentation/config/maintenance.adoc |  5 +++++
 Documentation/git-maintenance.adoc    | 18 ++++++++++-------
 builtin/gc.c                          | 20 +++++++++++++++++++
 t/t7900-maintenance.sh                | 28 +++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 7 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1885%2Fderrickstolee%2Floose-objects-batch-size-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1885/derrickstolee/loose-objects-batch-size-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1885
-- 
gitgitgadget
