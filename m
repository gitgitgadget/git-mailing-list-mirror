Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23F22F74D
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100298; cv=none; b=L63NwUR4Y26TNo/5KBGSkT5MVvYy08VnKMxhgmvDa+EB/RYFh4qmMChJiOQofn30Hizqi0x6+f+HhcZ4mRNZkpicO7GCuBN/tPtzjmHu/ccIgoKpCIAYY8TXQ75AEZQep1HbI67D1O4X3INv7SVqgICv2jYZ+Ir6ouEbb9B8C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100298; c=relaxed/simple;
	bh=bX68HOw4MfR07i7PIw4qULV9kXWh9Emzs284k7mOBgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQNfDadeVvfd5brYVBCyhGEHyH+PPpRJzmkdwAaCuKQMV8U8XvmGL59cJ0K7a78pm2gRRU819EqVz5w3NyysiTFhgib7IcKsIzD0XP8LadUbgOqaGddrG59z8EebpOy03z69W2St5+gsMXoVPjcV89ftYQcSPymP70EkzBtnNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhlYH+1t; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhlYH+1t"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e336b1ac4so5821650d50.1
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100295; x=1762705095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTXUpCqqAAWX2y26qVlMIK5ou/bhG09xiZ2Nrux4ydQ=;
        b=WhlYH+1tjdK1nLUQsz33GMahNl1DrPENDldJtHgaslQhdvHETYh4cbOUq70UPXAsG7
         dFZVuuYnjObKgYD+CA/mjKdSNmXimyALU6/WWP4MFonzJtGUR2RiUj+CcNBqMK+xGVl+
         NDZpJrbyiHrhW2Ei7ChOXquMeiU/R6ZzifzA9N2EVLIUpoa0VdQuAS+OJ6ewUSSbDEb3
         X9ETP8eK0A4yNohXd0NpN7y7Qvxw94j+iW3j4MW9dr9lAzHCHsbAi59t7iu5SBbcrMyG
         g30VwyKS9OBVkGG9qvs4d9V2cspJgnou8X2WB2JCnb1tevU/LqSO8eH9UWQm3AMDe+1G
         h6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100295; x=1762705095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTXUpCqqAAWX2y26qVlMIK5ou/bhG09xiZ2Nrux4ydQ=;
        b=S13osbZKBBi9XEhx7tGIfv6HMbFLo4E2sLYG3d38sCNlzeoo5Za5pEM+wADW+dY+xv
         GZsv0tyKTdTRHwp6TDsS9KLbSxwtB0Hwg1uRhyohvr51IOiWPuIFuTJPIMRhpboX2Y0p
         O6krnw2F5A3Gi7Orju9cqzT/DM3qoyV/et+iem4X5w7mAPIJvHxReEF/sItj7HJvSPdC
         tOxThF+aoB260Tk9eoyjKZ/b/4v4IDu0Z6Gyy6k3aYo2q5LGKbSOFflEA+BK8IYdKwLX
         hOtZ9ByirZe4bFMSlA5BKprH6WdSpdOHUZEXPhm8WOV2Ab0t/pncEXn+njtQysxI8Wld
         IFEQ==
X-Gm-Message-State: AOJu0YxwYAE8asC+cOkLzEGGTs812TFxKM9aVIqpWuc7k/41f1k+QaME
	eGzTNu8dmX9IVf660n3tCCg6G2wQZ4qt/0mzwuly7HD7BbbQGesFLN54zh9qsbx9
X-Gm-Gg: ASbGncvcszGAW1XcRrEVEwrsgsph42F2iFVkeJlM7kpLUw01sssR2Khfi9NTvAEOcWB
	g3+CNAy87BC++XSmKmvZcJiivcgTTTPV+R3ELmcPKCNTMuDoyiqh5IpHnKwnzDZ0sHHs8wshsbf
	A1Wg+2NCeH+kvS23m5eGsvuiC+WK/Bvs+j2nE5gsnOKLcUPA1eEB2TpRqzA+ES/h4BHsPY4B788
	+ieqg2BZygzaELGuCvk6nJWLS7t+AB8j+4vuKxZcDsQteD0BqBy99mjbgmOs+gCaNsQ7Qg1T0EP
	SBCuBhmcicTx0j3hNvooTii4RQ8WVAmF2s4myjpkQLRb21LXSEl8S2q77FX1ZiM8tuVYEXZRnu+
	Arp+yJrSj2NAAiz7ZBwTasXi9oDU/uLBNCw286xWw+yeNrdWBzKW0przRgVglsxVxeK/sddejzL
	7xRUT1mvjaylwhAEEHVvXQ2HyjD5HYxWFpdAQReA==
X-Google-Smtp-Source: AGHT+IFbjHfSM+YIQygPFxfS5QGEuqTr2CDOxYowChvaiKs7BkPUw7NfoVGJRGLuY4HHjDQaLzLAcQ==
X-Received: by 2002:a53:accc:0:10b0:63b:a941:90c1 with SMTP id 956f58d0204a3-63f828dc3damr10871453d50.12.1762100295409;
        Sun, 02 Nov 2025 08:18:15 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:c038:e715:f394:297e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c6185c5sm22626967b3.32.2025.11.02.08.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 08:18:14 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] doc: clarify command equivalence comment
Date: Sun,  2 Nov 2025 11:17:45 -0500
Message-ID: <30908830025a3004fa34080793b610b5fe1eef9e.1762100242.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1762100242.git.ben.knoble+github@gmail.com>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation of command parsing for :(optional) includes a terse
comment; expand it to be clearer to readers.

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/gitcli.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index ef2a0a399d..6815d6bfb7 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -223,7 +223,7 @@ Options that take a filename allow a prefix `:(optional)`. For example:
 
 ----------------------------
 git commit -F :(optional)COMMIT_EDITMSG
-# if COMMIT_EDITMSG does not exist, equivalent to
+# if COMMIT_EDITMSG does not exist, the above is equivalent to
 git commit
 ----------------------------
 
-- 
2.48.1

