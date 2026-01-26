Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12A221FDE
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424567; cv=none; b=PmQhEq4AHfeATKWK9SHaSO2NI/w06w5tRMAjQUJUKW4/rrGvn6zbiBN7xkx6En6Z7bhzhycfKyCiMEKSdhP/Omez9GSwbN44TGhUMmfEQ5lOW8ZN3+EEHHzfBXIRpHUCLAgN4GkBFiPx7yY0aYheF4qUOiUaTawoZI6C0PoYWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424567; c=relaxed/simple;
	bh=WZmg9nhOZz8DGFcR1QRnezVAKVn1MZB/UABNARecz7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVjlhjtOFr6wocyd0WlSEjUBs+7wMcfbRv2ZCQkl9ttWiRX4dIpf/EvltPL+/pStex7CtiVIXzW3Rjj/b0/KKSPCmCVbKh1tQQ9Rkp9p+0sjkImxfn32Xd6OlHNrUEf1yiQxHfyFQpXHlqn07+gkGkmOb1/fqrD0qjAZArZNjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IinNfXnJ; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IinNfXnJ"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso34156355e9.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 02:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424564; x=1770029364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UviGy3hzpgHwYeLYVf3j6QdDBqce3y5kLtlad5mKzc=;
        b=IinNfXnJI3WCwGrWz2TpWu70TEieiLn+2+H5Y4feUGX9Qr0jxe6Lx7KshRRBOZMPCC
         B+CwSuyb7DvmOGS00x8JKBBJCBFysxIfSMP1Dn0r7+0xZ0Djj7+YYZlTGCTjF6Fr0smN
         aj4cov+Bxg5+IbEZ1UJ3+EYH8C5neBcaIcIwrvvyM02uIdh6hnwq/4JOmdA2asUcpLDz
         8ObPM1vVafeejS2MZCdsy8i4QiA+DM+8LZum/k09tuJBYus79pZzCRA4vGIXOTALWeqk
         wESGBaVJohZLSHv3n4YpM0I1GEYGPl3fxpOTrtsuuq2NM63Ehc4+yyU+Hvz3yLKeejjG
         nZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424564; x=1770029364;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UviGy3hzpgHwYeLYVf3j6QdDBqce3y5kLtlad5mKzc=;
        b=SCVaFunioLI5kHyF3llY3OJKKSyYawsw2PPxpoU3lubB07U8+t3/zL41PgTKbB/D8H
         Z073d8HJXxIUZUsW6q5v8Li2yt4iHOIlt0RsSlH7JvVc7i/Ebk0t7nE9/35B9a/+BxD/
         pYGe6NSv4HdoO5i1nPbwgQ2fSigLxftdgw/seYlNyRzJtO+M9uGfH/A/qyDa8SpLsH8R
         EVERh3/u1qmAPZoUBzFZnjGAsKH5Ox3EKtud/bpaLH36f6L1aB9RsXNfLWYo2FeHH3lD
         pFvI2HiWxKDinQKPbzle4M5DgR4o7fhwwmIONAWMKJxkGJreYRK7umIET4NXkreh55+c
         TavA==
X-Gm-Message-State: AOJu0YwgblUqAqqLaIhTXVHV0b4BejWfRjHJ5CuktjaineOMceLd/RqU
	i4nBhFexndSE7zniRRh3lIMs9SGvbXoHMPUrP4QIYcSUzNohuq8rROOLoWFkGOoz
X-Gm-Gg: AZuq6aL5rARM2CyEJugeXE++SS/IQuYmkz4M4NpIsLeU3H+eBl5AwL1vjiYAg9Gvp41
	U+Xs51vRhKsgdUK7D/qy0yHbL+3ugnJssBqQi3YDer2r2qq+699ec8DvdrzQQRQqWeMjmZscFFu
	1kAyBjp9Yq1TGGk0zUoFA1Xfl6PlOPtn+Q2C5idKy4WP2/8d5ac6Ldt8GNS1XbZmfXd7RaRnp0t
	bB0rrPDKYudtt/pc2LtkJwB5xUZbwnvaMpZNfvGSHiJGvyc79HwH4AXBui4hYINUhMx9tunozC/
	MgsAFXfBApu8t6S3KVnKQ8OgSU82gDhzLwdF8pHfjoUHeP7YADzIM6VrTmns8G/h+shMc/z7XPM
	+inj/OlKFiu8I1YGbwYvrS2XmIg4bWoqfTF2kbrOe/g3hYg4b9/kLYIooycjov8PL2Jra4JO8Ex
	caewpkKfRFLv7KVsptw7WK8K7e9A==
X-Received: by 2002:a05:600c:5309:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-4805cd407fdmr64494605e9.3.1769424563633;
        Mon, 26 Jan 2026 02:49:23 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm30063907f8f.20.2026.01.26.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:49:23 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 0/2] xdiff: Remove unneeded members from xrecord_t and xdlclass_t
Date: Mon, 26 Jan 2026 10:48:50 +0000
Message-ID: <cover.1769424529.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series has a couple of cleanups on top of 'en/xdiff-cleanup-2'
that reduce the sizes of the xrecord_t and xdlclass_t. Unfortunately
they conflict with 'en/xdiff-cleanup-3' in seen, in particular with
db8a50ca6b9 (xdiff: don't waste time guessing the number of lines,
2026-01-02). I'm not particularly convinced that moving the call to
xdl_classify_record() out of xdl_prepare_ctx() in that commit is
a good idea, but if we decide that we do want to stop classifying
lines in xdl_prepare_ctx() we can start passing the hashes out in a
separate array rather than wasting space in xrecord_t.

Base-Commit: 1faf5b085a171f9ba9a6d7a446e0de16acccb1dc
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fxdiff-cleanup-xrecord_t-and-xdlclass_t%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/1faf5b085...0d251dfba
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/xdiff-cleanup-xrecord_t-and-xdlclass_t/v1


Phillip Wood (2):
  xdiff: remove "line_hash" field from xrecord_t
  xdiff: remove unused data from xdlclass_t

 xdiff/xprepare.c | 20 ++++++++++++--------
 xdiff/xtypes.h   |  1 -
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.52.0.362.g884e03848a9

