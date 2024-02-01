Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30F12CDB4
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788708; cv=none; b=ePdIkWB1sGVgkly69SY4AWj5lHA6i2GYg/I5vLBEPCpZQ8sW28Z6e615vR9G4DDh8oSi3OxJgH6jApBUidKtWW6NlYonogNO4ecT0HrlFt/liLORsWSYqWc3woDYMwAOscWhenr2Y/GnFUS91QO88rWzQmj1NDx6OBwvDQVDpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788708; c=relaxed/simple;
	bh=hFX138Vs/mp29Ak05uT2MPTYkYXBHp+PN9oUZo0aPD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2PHS+42Gm0n+HxBSOJOEvlEIdxBdgbljb+atkmWfALyn2Fon/hAfpt8YYZdFhfRl2HdknzdZfGi7q/Zu0C/T03P7zX4pTZYRu/M2X1epo7v93ghVVIIFR4CmW4FRs41OlrSXOApMC/DNg24iMH04zUmIdc7T9CJ3fWBDQWigDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7Q7ph/U; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7Q7ph/U"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso7598605e9.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706788704; x=1707393504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q21axT91++V/JXxczKI3KkbGISSdwfP1IIjNTvU/iko=;
        b=Y7Q7ph/UtrXtbBSaIdbsXtfwAVJPdHHvEiniqPQbt+Os8jnXREL37nVtb2WX+6J3mv
         WBREE1Jkidl1pKLeT+gyun/dN1A5RQvvcwpo7/7D5rNy/NtyOf1z2xmCJFNzHWVUxfks
         npWBRg+aD80LtUz2doXvhgNBpwt4gNHUvxWJEd3XXLXUwbLmga7ngDsq1TI5pkv39nYF
         /Czb7ZMQggkIsvRBjKTYaC4x0Sqd70sEsn9ZPrB62hSJxcNZZPXJV/BoXjZcPENXrnTM
         T/KAv760uwqCOReeCQQnBxzIlPdHOJk/r9VafAbwMnybFkv9Cku54ycB8vJS/j+G0DSs
         2DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788704; x=1707393504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q21axT91++V/JXxczKI3KkbGISSdwfP1IIjNTvU/iko=;
        b=nFtFss3Dyg79HzH6aNwwAwJFV2Zy/YB6EHSD5ZLyH1kKtkSc0WCknqT55+MrtuRoSw
         RcPJJ7o2KPjWa9h9TK8koPeIVDidbwVmlYpvLhHAW0Ic5PXKLWPrpZCMNG9IM3Y/Za/h
         IAenTMKIEBQwTrpirsmHOCLiEs7/cCwtP4/WLbFJi8mocIwOA/31SzhbVLyEdjnp3GPw
         YxRwiOHcucGvvUkBEjUUZUZQgMaXP+vS4c1wbslBBsLPiY573iPOkqJoYdnjg1mgmYne
         bxzv8P29T4VkDApxrAzjc0OGZFV6sFKW1vxD+Nk21+dKVAJWkYkawx8GNH/Xj6ZkUzZ4
         x89Q==
X-Gm-Message-State: AOJu0Yw57TAEOw7tWUp00Mhal0J+6bb0BjBfTrY9v2/FLr4/SNW2dzVW
	C6jdcWjZxXlSf0IUyuNuMPvTHGT3BCiOXDyABTjAQA4Lcjn946zFPOetZhXJ
X-Google-Smtp-Source: AGHT+IGJNIfvSiC2IpR255U9rgcWQfKOks9RAjldBwUqs6csQzG+ppSu5GAAFLEvjzjqLlSbRvlKaw==
X-Received: by 2002:a05:600c:5013:b0:40e:4897:c772 with SMTP id n19-20020a05600c501300b0040e4897c772mr4707549wmr.34.1706788704188;
        Thu, 01 Feb 2024 03:58:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVeLuzvYiVygHAUWB1icfi7rG3yTxa8RGN0CCpWdl8DFtx8SNyukcayU/FQZII5EmaHMiHkQbHkfztfB6aCJT9Q3KJpJvzlyPQcWQON+Ki4hO6+k4x/PUgdBh0UD8MjsDQFr1vHdp6Js/rd
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e1e0:bb55:1733:6146])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c044600b0040faf410320sm4113495wmb.20.2024.02.01.03.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:58:22 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/3] rev-list: allow missing tips with --missing
Date: Thu,  1 Feb 2024 12:58:06 +0100
Message-ID: <20240201115809.1177064-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.496.g8be34ce359
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent patch series, kn/rev-list-missing-fix [1] extended the
`--missing` option in git-rev-list(1) to support commit objects.

Unfortunately, git-rev-list(1) with `--missing` set to something other
than 'error' still fails, usually with a "fatal: bad object <oid>"
error message, when a missing object is passed as an argument.

This patch series removes this limitation and when using
`--missing=print` allows all missing objects to be printed including
those that are passed as arguments.

Patches 1/3 (revision: clarify a 'return NULL' in get_reference()) and
2/3 (t6022: fix 'even though' typo in comment) are very small
preparatory cleanups.

Patch 3/3 (rev-list: add --allow-missing-tips to be used with
--missing=...) introduces the new `--allow-missing-tips` option that
allows git-rev-list(1) with `--missing` to not fail when one of the
tips it is passed is missing.

[1] https://lore.kernel.org/git/20231026101109.43110-1-karthik.188@gmail.com/

Christian Couder (3):
  revision: clarify a 'return NULL' in get_reference()
  t6022: fix 'even though' typo in comment
  rev-list: add --allow-missing-tips to be used with --missing=...

 builtin/rev-list.c          | 24 ++++++++++++++++-
 revision.c                  | 11 +++++---
 revision.h                  |  8 ++++++
 t/t6022-rev-list-missing.sh | 53 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.43.0.496.gd667eb0d7d.dirty

