Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FF436375
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918188; cv=none; b=pe7KqGUGKrRigyin3ipCQyzXGZf1JTJBM49M5eSTgldIeIE79RvGAstvnHasscG47htZNxuP/W3Noe/st5eaP0TBMOT7qvV8hDhdjx2f/ojPQZAk4yLHQq0M78zDMbBNu+CP3aEQQIClKDw3Dpxd4eLC+Q4e2nVtxJZhES3NsZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918188; c=relaxed/simple;
	bh=+zJuIaroptE65Xez+UM8Tk82QjW1TMr5uXTvl154EXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIgJ1qDjqx+lYbeyUC21U8lfupICWptt6g4gu42JHplXR8YPkn0AYtxmRPHsL+8N7ABtXREpvZJwSQXqAprz+J2QMdWpP9M/NafyMzcwf7fxGc45hqadwlOc5ufbumDeAuJQU3MIzN5A0fAden6NzvLSR3CS24YOzWFQhNa692M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m79NXFJ4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m79NXFJ4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c21417781so2832580a91.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768918186; x=1769522986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ak4I/wZiFBdKyHCZCja6eGH6FsP6Qju5r+C/5Jr3xEw=;
        b=m79NXFJ4k1rBnbHoXTL/8Whq+ICLnsc5vrULNXFST6DtR6RJ/An9292ENM+wzv746S
         4Pfy2oDlGjkvsX6NUVQl0UUNrxM8jm5fFQG9seu1ZjBfCL2Kl/EpIzVYcOuAa0MRiabO
         He6DuTNH8370gTgANuxFj/3uEXpJBxcseRqhVLYR9Rgx18RT5j8FXEuHXS+2JOJ4FPQu
         C9Psulme2kXoV5qR0q0Dm4HvcaJyPtNy06esTque5pzN2SdavP8m1wr5RSXcuOV/OTIA
         V5e5n7oLkwEkZrlH9zO1K8ap5bIwZq0ZtvSrfYYObvEvPa5PnTmNiBL0U0P8upPehuTX
         ekHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768918186; x=1769522986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ak4I/wZiFBdKyHCZCja6eGH6FsP6Qju5r+C/5Jr3xEw=;
        b=XxFHd92DlLg3TD10XLcDvslMmLnp3KP4ITmkbP021GTge1KUNcsL2xwawu8F/9qjvW
         KwzfkSBTqiUgSifnLQHuACDG5wCuoNH1ty4CuaUjN/wDIz4aISRKDdLuwcWICgCTqmOT
         JU63mO0FqkUHc8gMh5RKdYQOh9hl+eIr9ACcx0bSyY3dv6wLs0PIFEKorHULU+HClB58
         0FTf6jE+XsISa5EzgaReXObj1RZJnm7TVeyFyfn+o6y1Q3JtZmM9R9U4kudVBgyAd1Jq
         x5zG6Ba/FAiPrgl7zgdTC7blua0081EJfRmaLd3j0Dez7G1EE91wL0VZVLcgzWQ3OcQy
         jSzw==
X-Gm-Message-State: AOJu0YxydZTKzX54CfaykvGECxCvI1sr4TfeZsk7fsIrIK1GzuVTHa69
	Y6OokZH/gvYVb1HyaNEAFYvMYROcelSa9ys7UMBDJ7oLLQ8ONLX0sePuVal3eg==
X-Gm-Gg: AZuq6aKihI6cDUNZv7F2IjRyRGPkVedJwbALst41BiLRLwE1uSOaCWSHohFZZYVBrtx
	b1Bvz0nIQ0IrNjbyJPg9HQWzD/D6WQcMrO6IrsqqnOmWbnFlurGTuxQ/dpQSBym3BzGZtPKw9tf
	RMqrhY/b1A3xF7f5UrdtdWrD8OpDRDpLWnEcJMBEs++Qcpdf1x+58Ewta8PmsRJasxYRkcowKsE
	05zj/lsE1Vg3GzVCMmtqt5ZheScfgYQrTMCWgxsKUtRp21kMexe580Es2lnHg7hErfHa7Qpi22Y
	buGNOJen1i5hpcYnjLoiatJpusUgvM0zsexFfzHlrTkKHdQlbnjlovr7syKJln9lWMUdl2czXdq
	92b3lTSkYyvR2dU9bD5+8tvdhvQJdJ5sH5H3I3yjX+dp+i9W2ZqtfJSZPJyHwqLFCBwiO+ZHPcR
	9NOSmFlFpoDSsPcStkcR0wRFbTOnkQF1ivRzJ8i8K6A+WG37103bht54jv
X-Received: by 2002:a17:90b:586c:b0:339:eff5:ef26 with SMTP id 98e67ed59e1d1-35272fbef55mr11583557a91.30.1768918186299;
        Tue, 20 Jan 2026 06:09:46 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:2062:a538:8b6f:d4b5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352d5a3ea3dsm1362250a91.3.2026.01.20.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:09:45 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [RFC][PATCH 0/3] show-index: modernize and implement auto-detection of hash algorithm
Date: Tue, 20 Jan 2026 19:35:38 +0530
Message-ID: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves the current git show-index implementation,
by adding automatic hash detection, removing global state variables,
and wrapping error messages for better clarity.

Currently, when git show-index is run outside of a repository, it falls back
to SHA-1 unless --object-format is explicitly provided, the first patch
implements automatic hash detection, but it only works when there are no
64-bit offsets present in the index file.
I am unsure if there is an appropriate way to detect such cases.

Additionally, please let me know if there are any tests that should be
made or modified for these changes, or if any documentation updates are
expected as well.

Do let me know your thoughts on this.

Shreyansh Paliwal (3):
  show-index: implement automatic hash detection
  show-index: use gettext wrapping in error messages
  show-index: remove global state variables

 builtin/show-index.c | 74 ++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

-- 
2.52.0

