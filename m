Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7327176ADE
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323585; cv=none; b=qeiG6+XSX4k/mvIOWiGIREI01l5PpPBJYkANC0ZXGqP38JElFjFpDP2DFFliR1WLtA4S34yrw2QJXQVr1Jc9f9B0jooP/2WlE2V4+zummTGXbmdFD0JKxcxdUTCDx1n76kJRgjx9xI4GJ1KbSLuuUyhTZ1CG9+3i/UoSRN8R2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323585; c=relaxed/simple;
	bh=aY4q37Zitr/7tTLQdKzIj1jIAzHNC3JJAg3/yZ4jDWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8fDCLm7HSAhHFAjpq5Va8TA1I+Rb6lU/Xbtj8GI3nIxdlDrUR4PpeECUde4uoFrdMzah43x4/iaCTNJONQvlMororWkDvO5+Em/BRLnE4/JSGVb7PVN8wARJ9QJmrCSufhjxex2W+uKVRUPd79SGWPZeFvETiICIkjtPTTHzK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLJJXFRO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLJJXFRO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775895d69cso6641935e9.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 22:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762323581; x=1762928381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgyQ1YDSrTFTTAScb4l/Go3jxfPmhippv1n/j//GotU=;
        b=gLJJXFROEtub0LTxwPB8AA/X9glUz8cKbTHYCVoihyN1in++hNdf3bmaYglJbyWQ4q
         bnNnY/ERPaHLGqsq9HHDRE28BOawimM8XxA2+Qqtm6xU7Bfb6MBBAyp0+7wEwdWhLPSP
         6eryoI3r0/UNcXN4gXK6ZxbJrD3BMc2EeIz9suURQAjcV/wuc6Qx3rSjRrVeqlb2xncK
         6cauqvyJ5vB0CVVk4X8iaGdpZwmqJNmve1ZIubzP/dfJ6XDfG6lJZP26q7Io1/zEUmcO
         doxFU3A0k9/zZW1Qa5Tz5z7b83t9Pmw4GtxD7cGhKVHbqioxquQ0O3/sZUOkg8pJDQW/
         OCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762323581; x=1762928381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgyQ1YDSrTFTTAScb4l/Go3jxfPmhippv1n/j//GotU=;
        b=Gk2ckE5xeO+ykw962LDMb4WSXhQYZzudzndgsDYzMCW/XlbQVcP5ycKhjiqkwbx0yt
         bkYOtRnjWjBIQhrVQ8dpfjNbFWPZkodohnykVToB5eZkt6eqSwqjdAz+MnDe4cytjuO2
         NsmPmCB6JzHnFXxva1e3hu0tStRUMnNLtS/ts5F6RpzvZZ6zbdKuud8X0+yyMVXcmE43
         tjUH1vbIgP6Wi8NG0nUMh5J2totHujzko05/+HyimaMSjH6jOw8FFEkgdqwzwDwscnDr
         X79pMLMNhq4hdU51QLlta+IO+PXDXZZBESXWI+C5WuJxcLI8osJnPGlgBi1kaagkNFVf
         LdpQ==
X-Gm-Message-State: AOJu0YyfUyCCdoNXf9srbZw4lADIhaKzlVCjAqy5qJ1rfFCeAv/khMXK
	y0OoI5oJcpz2Zf4PspHX5F6AH1VDa+UEvCVoky0SDqPgGVVoZrSwNsy9YXifLQ==
X-Gm-Gg: ASbGncu8OXBSFO6eldqUwOrt2Id/8S9KuwBj37tayRBJ/A8KoKkAIiLDRmS9pfs5zVX
	84IdsE1i2XlMIvM+R2Uz5MJCmxN2h//+JWN5qyd7m5kWqjGoA+BdeWA/bXjJtww1un4+l2MUZP5
	f2bziPxXaXgUdySDOyLXs8b5ijYsp9ER8IVgn5tihSrRtZN7sMQ8ufAkpF5i7oMNWMPDi5MVak1
	ga3qJurtEBMDJvBwaI/c9hK3Bak/+/UGM08aRG84bN9mp+OMKUXPnb9vz9CCNo2dgZgzrCfX1Zy
	nYHQu4DF5qtRuoqFRhFBztJtxzYhz86utkFAd9DW2ijg5NNNSlAtOsHQ+2mJIPJ6TUa0C8Tsj4+
	J21fGNNRGaIFt+uvDEXjOBhMePeVs+/Z3uMpsEHFqEorRHnRZLwt07HSD9UW4zlStllYVYkDKmB
	DmQutM1yfzOtou/t6IY6te/fSEOQk=
X-Google-Smtp-Source: AGHT+IGPZdwOol3OGXStD2yEFukmjrlSXlw214WvvOK2RHdazgI8UGtlWmQfEbb2X1GXOzeD35ERlw==
X-Received: by 2002:a05:600c:620f:b0:477:557b:6926 with SMTP id 5b1f17b1804b1-4775cdc7123mr14713545e9.10.1762323581024;
        Tue, 04 Nov 2025 22:19:41 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5f8csm8225944f8f.23.2025.11.04.22.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:19:40 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
Date: Wed,  5 Nov 2025 07:19:15 +0100
Message-ID: <20251105061918.3688870-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.3.gf264cd25e5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--signed-commits=<mode>` option in `git fast-import` allows users
to decide what should be done when commits with signatures are
imported.

For tools like `git filter-repo`, it would be useful to be able to
strip signatures when they are invalid, so let's add a new
'strip-if-invalid' mode for that purpose.

Maybe this new mode should become the default mode, but this would be
breaking backward compatibility, and perhaps this could be decided
after other new modes that might be even better default modes have
been added. So we leave that for future work.

This 'strip-if-invalid' mode should also be added to
`--signed-tags=<mode>`, but we leave that for future work too.

CI tests
========

They have all passed, see:

https://github.com/chriscool/git/actions/runs/19091593841/job/54543228129

Christian Couder (3):
  fast-import: refactor finalize_commit_buffer()
  commit: refactor verify_commit_buffer()
  fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>

 Documentation/git-fast-import.adoc |  28 ++++---
 builtin/fast-export.c              |  46 ++++++++---
 builtin/fast-import.c              |  74 +++++++++++++++---
 commit.c                           |  17 ++++-
 commit.h                           |   7 ++
 gpg-interface.c                    |   2 +
 gpg-interface.h                    |   1 +
 t/t9305-fast-import-signatures.sh  | 118 ++++++++++++++++++++++++++++-
 8 files changed, 260 insertions(+), 33 deletions(-)

-- 
2.52.0.rc0.3.gf264cd25e5

