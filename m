Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7432E134
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353541; cv=none; b=AjEBHxSkq90n5qFlcRbNcE+WcIdiMN9ucTHUz6K/84YZYx45wFzCuJ+aMC+U4aN9Zpc6mjG3/XvdQx8Lj2V0hpdca+97c1YObDxfF5WLTO7Sqo5RNcp075Wt2RJxZA2PVL63LIiP+IEw2ECgDsE+2kfFsyk4yoxAw7kU36RCCHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353541; c=relaxed/simple;
	bh=Gq9PMHT709U6dptH8iKYx2p/ccQ/nnd2vlTiCGGmUis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOxVruX8oSSuOh+g087477Ldf/oRIWzksqb2P/sKUpoOUvuIFLAmGhx0t4YlQF3jQSD47haORpHOzs0Wz6a6B2Y/PxQWKKHETU9b7PSBFNpeZ3u+oHusJzHl4BBg30wYyVh2hjPeFPUN3UYMo1ck8whUGoG6Sf2pmj8X9dySDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh0FyuJk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh0FyuJk"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429bccca1e8so3442032f8f.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 06:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353538; x=1762958338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xIrjBnHSEG+7D9sYqb1jJWNIh3C+x2e1T/NZvjSFD6A=;
        b=fh0FyuJkcTs4fM0DpU7zNM8vOdXP0CbelEEyyEN4HqhcUS0PuX6XnUoDGx/hk/VAUI
         ZhwkHaoSo+NtVuwMmi5n6sSA7GJ/pRqGs6HelJ2dNVBfSkBxQuClRgAC2L3+o0Ny7NRp
         8PLiIqDEw2HePBcsJm6BQ1pxEr9fZpCe9Lbaeq6Fu2bo/KxDlXc1cdY4FjSyadsZhwNA
         lOTWomMk8sPpP+aYoaaUd6I/9UHapWCg7s/7nzT9vfvezWhMBOKAmtWIO6C0VvlXHcHN
         xbqvRIu7c/QPETIMEHGYds/BQmmRay/ZcDGZnI2XBiSOIsheL0EjKEaFUGJ8EiE7UT2N
         NufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353538; x=1762958338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIrjBnHSEG+7D9sYqb1jJWNIh3C+x2e1T/NZvjSFD6A=;
        b=ih0PQrrEIpo5yNTGnb4bVj/JsBmNTetmJDc324QlO1U3cnb0Z7tjmEwyVP26XxYhb9
         cHhUpp4X2Vvsvajs/BbuOu4LzdblioE8QOPGdRn3iKu2NWmwx77l1DtRwhtOYZY5c80T
         7DcFUCMQk0UgLqdtXwk4jTokwu5Gh5l+kBTEsjR5x+BzMYVuV4V/ImHaacvOcxzG9+mX
         I+VCt89wioT47vXedLXFDVAtmDGcn8Zj4rDsrGc5fmLAKDv24plMfj2AKs1xVSduAPYj
         iY025kjvyFR8ik1P6LCRmbA0QfS+YzoiFpg2jVODxbiniVi1T+ST8Ctqlg8ZR5Ym9SGG
         7CsA==
X-Gm-Message-State: AOJu0YwosmpOkeJrKiP1fT7W8zV3OQYPJDsrKYSpWEdAVyRHfeG0dT3K
	SSFSRWElUGLyuNoUp9likwF7tHpXKFEF+t36WzzSkdGm+39ge4xCMTaVLVSXZ/vJ
X-Gm-Gg: ASbGncvbUx4zFFiWJmeINfGkeMNFBRxLmCemg0XLYlONrGFEf6WvbhpqyhmasrBqYBA
	sc5zSfhyORyq3poIA706e8yGWDkysxRfaYEt/fLRzglGvuLbDnY/ITifYi24SeR2SRsnwMb63G8
	6/FepH/mcvqUhcZTFiwH+h7WqEP9iyrPssk/B5tFIQynmQkZO3GNxz2j5AhRTnBbh+z0V/dPFG2
	xUkko+q1X+Z24CBRnXajI3WWayrNVvdTD/NZ//F6PNUhMR5hJFLVMkJyYjXboVD6NOWjMUJ8DOK
	SQPnkCF8mjuxYZTxEiNoHwATO0i2epMmbazOKJju9SfsX/t5z85e4XnsWfcY6ZVFmz32qs8cHsT
	InG2nP8UdMDXwQqy1OVpTHySXhJ7TpcsQ9h/DiYqus9ot0FnU+0sVEb87AOtEyHErRRzgYLftQF
	Veiob9x68ggC3arg==
X-Google-Smtp-Source: AGHT+IH0uODyxVsQVgIF8b1AfFuzxNxanaP53F+vn1NoHAQXl6N3AQXZ/PrngyrS3JqH+afX4ntK3A==
X-Received: by 2002:a05:6000:3107:b0:3eb:9447:b97a with SMTP id ffacd0b85a97d-429e330d7f9mr3231598f8f.54.1762353537603;
        Wed, 05 Nov 2025 06:38:57 -0800 (PST)
Received: from QueenJ-PC ([105.113.69.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1a850fsm11200048f8f.20.2025.11.05.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:38:57 -0800 (PST)
From: Queen Ediri Jessa <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usman.akinyemi@gmail.com,
	Queen Ediri Jessa <qjessa662@gmail.com>
Subject: [PATCH v4] doc: clarify server behavior for invalid 'want' lines in HTTP protocol
Date: Wed,  5 Nov 2025 15:38:49 +0100
Message-ID: <20251105143849.1192-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation to clearly describe how the server responds when a
client sends an invalid or malformed `want` line during the HTTP protocol
exchange. The server includes the offending object name in its error message.

Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
---
Changes since v3:
- Removed extra explanatory lines per reviewer feedback.

 Documentation/gitprotocol-http.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
index d024010414..e2ef7f0459 100644
--- a/Documentation/gitprotocol-http.adoc
+++ b/Documentation/gitprotocol-http.adoc
@@ -443,7 +443,8 @@ If no "want" objects are received, send an error:
 TODO: Define error if no "want" lines are requested.
 
 If any "want" object is not reachable, send an error:
-TODO: Define error if an invalid "want" is requested.
+When a Git server receives an invalid or malformed `want` line, it
+responds with an error message that includes the offending object name.
 
 Create an empty list, `s_common`.
 
-- 
2.51.0.573.gb660e2dcb9

