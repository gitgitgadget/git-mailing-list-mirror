Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5C2505AA
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643930; cv=none; b=I9MElKRrymcRL0CDKlrU/dGhUQdZis6WMSFeP2Ztyg5oZZzlBMmPtb0ekxteD2bqxdKwUmY/T34QPtYjJjIyjC2zehFcJ3epIST7nhkyZashkMkXZ0rdhjsLagZ2caedPPIEOeNYB0f15ESBiB3VkVuzExlw3bV8RLbbVRttiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643930; c=relaxed/simple;
	bh=DcLzYa6X3qN3narNVyQTi6KNt0Jlnxk9ah2Z+V75j/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYZ/jupt+kwv3okO7VAzZJTlOwDMsDq2IOt76i4HT8ztL8SK205IpxbL88iLDUvivROavZtD3dx2qRVAe7BIC/SC5aR3gw7A8YeLrJQiLfVfamSJcW1Q7GlS1o01CxlpttnVBSTYgM+ORRy7BtH3XGj6NWiow+nCufx1iW0s6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTEFvj9H; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTEFvj9H"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d196a2334fso402600a34.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 15:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643928; x=1770248728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKi6nZBhglUnGhaAjkd1L/YyrM12uvBuAJgKd3Fty0M=;
        b=TTEFvj9H/akuGorgj459JSoya/okw+S3RWGv2YONXakv7nZ7ZKPMGxdGZrftRjRX0Y
         wFwpRABbJ7KGuZZDe9ijEKulu/FX/299PYHrHJZv8Qpo6PsYBFyzU2V5IIp/fNt4x8KV
         7xfa+VsI2eN6IQTKGYA6n5RB11SnI+XIquPwDrY1eXP9XRn06OgmiLOGIyJ3wqGPDHJu
         3l+8ZJjaF2BZczTcRa4Og6aijYYU3gmatscPOZDSdn5VpMvGGQr2P7/hTh4/4hEXwhsH
         ePU0j0ZfgNqSb7305entwqPiNiT3CpaHSpMMXOJDCXTV+Khjm1HEqu6eqgy2GH+uYR72
         pEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643928; x=1770248728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKi6nZBhglUnGhaAjkd1L/YyrM12uvBuAJgKd3Fty0M=;
        b=LeQKG1be2XFOmnpizPAmU8wy47RELyDOJ8DlCIMITip+LSwpi4OKVgu8SdMmAlZmWh
         wPJ2ubR/cckwYxrRM+9kwRHBildOwUCU6byyJmgZF9kGuGMnHycgwh+lipz7MJJSvS08
         46bCKAs2rUAzNGr6ZPW1/dWBJNgEDfNqDuGzU0G9gjDsqAiIkpk4I4ozkAzcMEO9YP5u
         9yj65gENZkG08wdlskisCy7DAqQhdEgUvEp4lBHa7x0I/Yxq2dYZd8tmC79oKfoTmKLU
         u38gp9fzyU+1QasWiEowPNadxuCv8xCp+uM1BxRXitxBbqrieqTkdT0J3wSLOlTNHrz6
         JeRQ==
X-Gm-Message-State: AOJu0Ywj2Envaz1Bw1EowCSHu7TisBx+2Hy9JdF/SZ3el7jNRpyfgIJ5
	jC7U2hzRfaWCiQWu3T8U1ovNcTVPmqPKHvWWrL1Zke1Jz4h/imtfh+YbuC+8YA==
X-Gm-Gg: AZuq6aIV9Gl3n0BYhzRSQaFfLRzenFACWl406T6aq6QRdeUvx8CD54frD8AUpOtHiMp
	UiZcydEKDHKgPTkwBqCC+2EAAptEEUswlUgO8WnotKPp1iJZpa2QuREWVlggnTcsq/d+pAO/vu4
	tyCvYZdOgS40S2k8+wk+tPIdchdRRRJnHrtDES/kaiPA5cHtgNpRAeDwmes1PDaZ4BlOEOUhFlZ
	lV+9bsrqJH21MnMEhPf2yzwZQX12+fWQB1PQH5ceNtrqEk0looa0zUonYoFmp8uBOrBmVq2r90y
	DGpyOCLRJfbWz7n+LdOCls0ixw5QT4il4Gn2xGcbU23hjjmsjuj3BoMt2Fkyy2u7hNJh27MxruF
	bWPCvlGp5Os7SDWukAoMNvBBvihh4/rqmIQNEY8D4/aaTTTBLc+8m7Vtj9r8ztdvtDgN0nkk7oO
	Q4irpV+Ng2MERLZIG0nNE=
X-Received: by 2002:a05:6830:44a8:b0:7d1:93ea:5bc0 with SMTP id 46e09a7af769-7d197084cc3mr666370a34.9.1769643927684;
        Wed, 28 Jan 2026 15:45:27 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67065esm2648676a34.6.2026.01.28.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:45:27 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/4] odb: support ODB source specific transaction handling
Date: Wed, 28 Jan 2026 17:45:15 -0600
Message-ID: <20260128234519.2721179-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.373.g68cb7f9e92
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

ODB transactions provide a mechanism for writing new objects in the
repository that are in a pending state until they are committed. With
pluggable ODBs, each source will likely need to handle transactions
differently. This patch series prepares ODB transaction handling to be
defined for each ODB source by creating a generic odb_transaction
structure that stores a callback for committing the transaction.

For now, `struct odb_transaction_loose` is the only transaction
implementation and what is always returned when creating a transaction.
Additionally, this series lifts transaction logic that is common to all
backends out of the implementation layer into
`odb_transaction_{begin,commit}()` layer.

Thanks,
-Justin

Justin Tobler (4):
  odb: store ODB source in `struct odb_transaction`
  object-file: rename transaction functions
  odb: prepare `struct odb_transaction` to support more sources
  odb: transparently handle common transaction behavior

 object-file.c | 77 +++++++++++++++++++++++++--------------------------
 object-file.h | 10 ++-----
 odb.c         | 22 +++++++++++++--
 odb.h         | 17 ++++++++++++
 4 files changed, 77 insertions(+), 49 deletions(-)


base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
-- 
2.52.0.373.g68cb7f9e92

