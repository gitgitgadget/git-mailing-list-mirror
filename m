Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4E1E4928
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674302; cv=none; b=C1lNog8vqDX/0OEvD71Yaya2wmEZotx5ki1u59gutDfy4vI5UaHEZ/YFusaKiQilQ8p4/FBSvlYzZ4jjYYEw0PYTZQ9J/1xLOtzshoXmok2Mk7S0ZXyQYssXSELaJVAnH45TzvmYibuU3U/7lAyrIye4Ik1z/LL/Z5Ogif/IInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674302; c=relaxed/simple;
	bh=hJ69YGhDzQNRP54mYx/3iRiKguXsD3bbSBLzEHVd6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f30N16PTeeqsca9/VSziL1FY7mR0AaxP6e/7Uz0lvmJTOR1rSGdReRCKGlWO0if8ZRjXH9HCdU5jevGVXxiNxWhHEjrvgcBMCbgo+UWDlI9TrSbZ+BG8CZJUPyImiNPn+1pam6hp8y03SZ74/JORrun83rKbvKzne2iaFfU2HQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBRGqR27; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBRGqR27"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso84622055ad.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741674300; x=1742279100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YS++E94eorTw7Gr5xH5R4Iqde2lE1ecppXxRJVZ6otk=;
        b=cBRGqR27n37LOAy+zXmn3qhqWI69ehHei26L0+s+K/h32+i6hFEfcJTPASTDd84oFK
         FvdmxWhYYnRfSmIoCkMXuSaa3By6PmXCfOveOyIM7yjD8xwXKzHmnd08iU2uVNyyacDq
         mdNNzhhwZ5CoNpUe1t+8Sv+MySMBw/2nT9tW3HkyGvdPpR/ZuQjzBqWRSAHTxE/LT/xr
         XJtAnhCIQ9PAi9R6C3BEEsiYHoXAn/H5D4tBioqcwidNtxySNcQ8R4I5xeXsPsPOZL/O
         Lw9NOf3oHNPW2LkkVSWnreXq3Lc5ABGyvhmhX/vOn3cdyRW2bPhGvSypWq2WgYcjrCLt
         04Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741674300; x=1742279100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS++E94eorTw7Gr5xH5R4Iqde2lE1ecppXxRJVZ6otk=;
        b=Jeeq5nqY1TTgVbhG4wM5vL0G6Dz5dkEVHTQFQbRdrNjqzCaCXBfVtzV7fblomsN+sQ
         VAnmtQbu0hUBzXvzxYQ1DQ/xqZV9WdFq0hCzGn1ym02HWYIrRwgM2O3NqzGkfaIodnL0
         bgFdyA8SU/trwN91gyMY4oYAzh83LNJ8jQoOht/Nn02AWqnTxh+z8I1AsWF6uoMypsC2
         m8byIL6AlOY6iv2dtd0cXHYpHpKYBl/nfcu3WgWCc0QYZZBScxGITAVfC+d3kXZ/o3Cg
         mXZciZqeRQbMDdD+YHO4J1a6x2sutli8Chht+yH1kJT1BOuZewIk9WW68xECKIrQZT7L
         Z3cw==
X-Gm-Message-State: AOJu0YwZnNERAO+axsN03JFT/s3f4/CGxcY2F8rH/JgZazJo5F9TnLSW
	qO4Ad3NXjp4RKgqUwLlCnXgQpw0AKbAjT8EbSjtpTfUAYudPx7O90dfqv8lk
X-Gm-Gg: ASbGncsqWHeRkoQasbq8BQs1K2N2EBvhtZ6lmm8qoPvuOBYnRjyFfGmmSdXwGioeTfz
	1fZ4OoCuoVuFfFV/oKnD7H1f3bk31TXG8nDtC2HCyW2zPTVph4eX+6b4nNoMtb3vtaTy4zoD8FQ
	lsOwoZ6mCmStyyTo6U9ZYHTHwQFcWRglgfr/lHEAaKDr9Y7Hng2ruEAh46PCNMv2zC5VNMA3TXd
	1amm3QV6ejpErwWiGt441xhQNM4+MIqSDs+P/ODLKQt6n81h41XqRUaBCqgRdSYPate3BJorJsz
	y4QfY9B5cPpXqhoLe9JQq62IM4vO2WKkxCQzACrL/7j/wsyOtEBs
X-Google-Smtp-Source: AGHT+IEDeS78M1lniv5AqQpqnIfvQSYuwBw1eFreKOu8dToxrZ1/fT6PXFXl5FXKelwukKOATHNwdg==
X-Received: by 2002:a17:903:3dea:b0:223:fbbe:599c with SMTP id d9443c01a7336-22593dc508emr26229685ad.19.1741674300589;
        Mon, 10 Mar 2025 23:25:00 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693f991fsm10250099a91.48.2025.03.10.23.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 23:25:00 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v2 0/1] improve smtp auth error handling logic
Date: Tue, 11 Mar 2025 14:24:12 +0800
Message-ID: <20250311062440.3566116-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.57.gdb91954e18
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enhances error handling in the smtp_auth_maybe() function by
distinguishing between temporary errors and permanent authentication
failures.

Zheng Yuting (1):
  improve smtp authentication error handling logic

 git-send-email.perl | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

--
2.49.0.rc0.57.gdb91954e18
