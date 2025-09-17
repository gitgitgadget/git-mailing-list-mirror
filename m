Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DB12CD96
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071805; cv=none; b=E10gVbIhIg70/n2jGcB8iftuBTWTVCcfWvqMhZkNHRojXBAFGAh1HWAcW+qgcIU9lMKxxgsrfb8CtUcbRGOaeN5URFhKsrPMR8Nz+3HxRXpnbnHSo4cJxT6z5IcUf6Y0YbXvQbIWZoHm79b7FBCx8HdpDOvJUe2aRye5fn2g1WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071805; c=relaxed/simple;
	bh=OhHvYg4rhZn87+8Myzpvn6v+3PqDLoNAT/e9lKrdhTg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A7I9w850iqfGdhtDoBLtEitygnPypZy/9hDIbMnar9Kf1x5VLs0T1objOMe2kp/D7jMFKKLeohc8Boz4CAJkFsN73GziQM6Sn2sW0gXpmNyw5QTnJrHcXtH8NgCOz5/eQk3aNUIyo4nfRG1iIks3RcVI/WvPUMwQwikI0OzwH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2OErCsl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2OErCsl"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so4042047a12.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071802; x=1758676602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XQ9Lz7i+w2e60eMg6pKwqYPvnehbmTemdyD+z7thBg=;
        b=R2OErCslGeqTMPdiZVMd/hpcAKyiaCzhv4EVQGYHHtecqtb8FumYIyWJKfqmQI7P6+
         abVGxJ+/LzQsdAMV/V7zJLosGz++JMp/waweMn24uYq0lDSziSDjzsLfSWmFGajWhVpe
         srE3ghZ83cUVcb9KCjAmxENQVLj5Xw/lWfPmpizP87SGsZJkzMxKgPuq3FpcI0CLG0jN
         uhSuHiEXNVMrY071NrJjLKMP67zwgmt+H+6jHas6mmmdZjWEUeKS5sa97JhVpNDhp5aJ
         s8Zs7dNLWEA/4yy1HMKLBIqNkX8lIpF5BFCVOzxu7UcAaT8n2S26cSq9toIa9inJsvRl
         4w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071802; x=1758676602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XQ9Lz7i+w2e60eMg6pKwqYPvnehbmTemdyD+z7thBg=;
        b=KK/ChM3ggiiggoND2Z7DSEvveZD++KECEPjtBFsIEwwlq10+QFRXcu4U13pUgT6DhT
         FJwyNY7eyhkmshHtMSqM71do1TnfG4Tbp815j4JVPVc4wc696C+ABXkG1ZLg/XwLEMEj
         JFZxOVTdy3glfQppn9vHXKnQaJLVgjJYnfmVdTOpoHGDarjugPupxPMPs5PrAv82q6GK
         3zvmYbrw5kn7qtd1q2j9hWPqYmBS+FmQRVwAOMRE+s8p1wkiREEt8xo2JVv9S2vqP3dT
         iHPFZt6AUujEuAwIYFBtv9GiWhWO2Y6NPR37ys1Wa/Iq4OMllCDDjMXPMZgf7xjtUjlK
         IVdg==
X-Gm-Message-State: AOJu0YywIyrK6CC3Ul1XRZ0yp6oYml+J6Fkty9DN8nlhXhhWWY1YEQvl
	Q4eBzSdllANT1bcc/cNoDnS5Oehfm5T4gGZYE9wITx4HYgZ9vwmRgA4aVgHCBA==
X-Gm-Gg: ASbGncv4+p2omoilwbnsZ2XdHscRC+sDIChOBRQ1awdX85FWjxRvub4e998ZLCextzd
	FqKti1x5ykoXH+LZp6qZYS+xn5gqLK8lO66x7MdGU/BG6PJyocpEQGba4XuifsKK+OxC0evR+2G
	i9Y+Lqs0FGE/b9INt0gGk2u/Pl14BT+Kx7E54a7ySgWBESh/Vry0iYXW8ZkwnPK31DFI9O474zt
	KEjkjjJzAf/TgjjUpIDiF7/VxKKFOmxkV93NoGaea3zebN5YUXed2xXRL/rjLhj7aqXyzevzO6v
	hTR0B7K3OwpYSMv80U5KGoqSh1sjt4DnQKkBGAVyJzcoNVu/NyjekC9m3e6wWlsxe8TQ2ngymbu
	xlY5l2rkiC0MFcQHKIjsBvj3JpW4=
X-Google-Smtp-Source: AGHT+IHSBd5hLuFerKv+yDsZau7KFuqgSAQQpyEOZNMD34z7qfHcpz24nRCsN//ETeUFM9nXdfODJQ==
X-Received: by 2002:a17:903:2350:b0:267:c9c8:3b49 with SMTP id d9443c01a7336-26811ba54b3mr4491355ad.5.1758071802332;
        Tue, 16 Sep 2025 18:16:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm15869105ad.63.2025.09.16.18.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:41 -0700 (PDT)
Message-Id: <7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:22 +0000
Subject: [PATCH v2 02/18] make: add -fPIE flag
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e11340c1ae..d3e034f3be 100644
--- a/Makefile
+++ b/Makefile
@@ -1402,7 +1402,7 @@ endif
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
 CC_LD_DYNPATH = -Wl,-rpath,
-BASIC_CFLAGS = -I.
+BASIC_CFLAGS = -I. -fPIE
 BASIC_LDFLAGS =
 
 # library flags
-- 
gitgitgadget

