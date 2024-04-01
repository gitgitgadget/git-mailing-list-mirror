Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2953FBA4
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982750; cv=none; b=EuOD5I8pNUmo684LITJuFdp5s0w0DuGj8aCL8Iazu9HVC4xPEluhLC36FvJkSt0jMnMTNASdldHLuLs5Vz5U3TlBiR9l4t79WxlC7OzfhSV0G79P330kMneHeBOF+d3L3o/6CPMURy1WiEz+aq8OnkVFhI/7kRBVgtlIxb3ttWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982750; c=relaxed/simple;
	bh=iucvYqlET8FBmq9ybSQdLzBGqL/XwYCydcF7+v7mpwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oo78rCc7DBZj7vtwBS3DU3GRF5Vwa6EpEhN2mE/oTCTsrAkPPipq7i4V8KznU+XjekAfMqEYQWQfhV9b9tK7tQywsOzmr3DKwumPOjr6cbEXPJGmt5cKGJ5055lG+fEZNSQTFJMt2b9y2L7TltYiYuZB12TqGvOCDR4HRZRkKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTguX/z3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTguX/z3"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso4681691e87.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711982747; x=1712587547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4QpWKO43L6bkkLakLe6mW0mR5cBj/hwJyqM4Pbw9VU=;
        b=OTguX/z3+h/jnuo6wTS5EFDNo85eiFxhQk1r5C984L0zkOjHREM9Xi+IChlpz7EiIm
         r8bKESJ5sEYDZzUynBG7/J+pMuPRk3FDTPHAEOvj10TGUmGOkB/uLw/d0N3fWGguacMl
         es/ZMrDFhxRJd4Ne4zHl5ERP+a7UBlexYs2Fm0PDCJzrIEI7EsOyFVMEFS3LZbKesZb9
         SsLxpR7HX0LhcJBON9kMKgBq4f3Bw1RMGt+YRQpGYDV3+mbLPHv7nHb992kEHd8c6/x1
         eB2NhiTvPFEtBCQtw8o/0YXx8rnQZIC5/LxtwE3CY/+/Db2WLhfXxEGepLHuE2TOWDyB
         sT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711982747; x=1712587547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4QpWKO43L6bkkLakLe6mW0mR5cBj/hwJyqM4Pbw9VU=;
        b=E8PIrql75whG4i25b6X/rDsiPfuXUJ+TNr4qmBVihI+351zwNdaEtRpEFdtoRrw798
         7C7e8jtIZ9+lqyvPtX0WDBBSaLfpuv85jSbDLyQD2W89WMeL82c0TAI/w0vedSmKMHRc
         npCmp6JiyTe2SM9Ydp32oURwWIuHX+rAiul3CFra6hG1twNKXnxWJUS3I9B1gfQLuFLr
         D7iGgFWbM6fEBw3flFVl2Sgv6QUb8pxDMUakei3qr6TaHsJTRFztgUTSi3QdOlF3I+1H
         /wb6BiXieDJTZ6mRvLm7hd3Rk5iY5gekgYveQOWFad+ZkJ+I7dEFWmeD4LnjzObxRuhT
         9QpA==
X-Gm-Message-State: AOJu0Yyld/aAtAKu5JbftH8bURMWhL3BYCGFcus4lR+lzevstnIKrDwi
	7wqowfirGP3mVxcClVEUpH05Gr/nnBpBjlG/Xwgnv7szSmX++/H7fCWeQ+cNksc=
X-Google-Smtp-Source: AGHT+IFBDNfKy9HmX6phWw11bPzTs5Z5hGwH6fRCxLeHrYUtVFo23NaRAZYiMR0LclVfauc76PvVSQ==
X-Received: by 2002:a05:6512:3d90:b0:515:c195:d6b8 with SMTP id k16-20020a0565123d9000b00515c195d6b8mr8348409lfv.60.1711982746502;
        Mon, 01 Apr 2024 07:45:46 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:c9f:8d5a:d89b:4ac])
        by smtp.gmail.com with ESMTPSA id n7-20020a509347000000b0056c24df7a78sm5751170eda.5.2024.04.01.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 07:45:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	chris.torek@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] improve documentation around git-update-ref
Date: Mon,  1 Apr 2024 16:45:40 +0200
Message-ID: <20240401144542.88027-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

This patch series was derived out of the discussion [1] around my other
patch series to add symref support for `git-update-ref(1)` [2].

The aim of these patches is to improve clarity around OIDs in the
documentation. This makes it easier to draw parallels between regular
ref updates and symref updates. The symref patch series will be rebased
on top of this in the upcoming version.

[1]: https://public-inbox.org/git/20240330224623.579457-1-knayak@gitlab.com/T/#m7bb4d1f44b656d7cfb73ed3220b990aa6d1ac247
[2]: https://public-inbox.org/git/20240330224623.579457-1-knayak@gitlab.com/T/#t

Karthik Nayak (2):
  update-ref: use {old,new}-oid instead of {old,new}value
  githooks: use {old,new}-oid instead of {old,new}-value

 Documentation/git-update-ref.txt | 58 ++++++++++++++++----------------
 Documentation/githooks.txt       | 16 ++++-----
 builtin/update-ref.c             | 26 +++++++-------
 3 files changed, 50 insertions(+), 50 deletions(-)

-- 
2.43.GIT

