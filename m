Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6126284665
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482073; cv=none; b=H6RKi/O4iy9QhIY8YPzu5XMhHAPS5aPOFzqtgYy9WdDiDzra4qnRqrxlC4ydXYNCGm+YPwM2JOuHb3JM8JSgM9ueelg3zELrGqaIehsXdny0ei3sJuPhIQV2XVTWgeo+EH0nMwKGmr8HcL5ArUPdn19ghlgNS8QZIIu1ZNwBqs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482073; c=relaxed/simple;
	bh=nNEU6lHkLYfBjI5XgcONh1kEgWXXgi/pqesdU5YLntw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+B9Cp60ctVwDNK1BmxHNDVLEmi19LMy1iHdJ/rUqpGRsD6oaZBWlwxMs/X2TJG6gsnz8BWoRFjP5wuBIJQA+dVSNooHmd2i+QYbugHJH12U+MpG//hVwDfXYhIiV1JPwpKZBPr0ZrY8oIjz4DI4dqeSLSS26j54+thPAR31Lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbcM08tL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbcM08tL"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47790b080e4so23593075e9.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763482070; x=1764086870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EgCjbdjCFz57ijjOQhrOQp3hvwKFjGZEHXicSG9FyMY=;
        b=RbcM08tLZlOe/kF9UOrGzrMauMml4OcVaSdQdFMeyYfCxbV6Q12XAvOGsGYsDg5kRo
         NLKPOp8mVuGf7NtbK/AVk7PWQYtufwb68XyvdyBngXDhuYyiT3MmQQ2/BVPoIs1BQ4+g
         vJZyGSHo7iCcO/GibQxIRU+sDxjdFRPSMdpOIWkJ9roacsgx14YkFiDCgqYxYTbdK6su
         RV2Zx099dFm07JcsJWGDZZOY+8li0q3ZEdNlnJTqKenke//lPgD/bdSn0oR9mhAfe6lL
         4QJLFI7rFtbUWh1uEEcmJObwt8FNRkw3qCy0r5PqCCgdt6ojwGtPuWuST/H8kKZLVHSV
         bPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482070; x=1764086870;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EgCjbdjCFz57ijjOQhrOQp3hvwKFjGZEHXicSG9FyMY=;
        b=Ex7FRDzyCfv8OwhBik2v0vP95LPK29fJcmwoD0Q+gxHfq/+mSB4qjVo25bx3sxwc1c
         IFG+pQw78Z3tCo2G6Nfzcz0wOs+pAuZd2dDsAvrmOb0vX4HPff6gmw3U6iujF8cKSwaM
         MKoevKCFcmD9SNixlt+ja7RsXT4OjsjD/jygmtjiycuk+N3FWzQj1/e4xGbUJ/4rAO+I
         6cs8YPPAjEeVbFLWlz8MU5DyY1RsJ8PM9lSmK3llJBdVVUYUqR9K/ZoOTAu0W9QGnCQN
         lr1V5ylK6mDKDPctzFZsbWrRvvKQktT/iYbFQoHVo7xLEE8tEtneG8fLcFHgX8/XmtZ7
         0thQ==
X-Gm-Message-State: AOJu0YyKC4StUbVFB7WREOOATwWFs0VAstKKCNuAANh6PEbYvBBRp1QN
	CaKCTnvpgru5tth2lFDkWBhfFNTKVJk/dLucvQuYLYEH2v7vvJz0xOQTwRgNkA==
X-Gm-Gg: ASbGncsQHzIwC79U5lLUZVCtPhHALV6y4OgGiFb9axr/mB03P0jbu4hwktbDttfT7R1
	rLXbCeRRwblcBGcGbeYSVFT8eMchnvWSP+otGopxmrorzRMqJQHBs4ec8BL5IjWLBklGp58J8S8
	RvgrchlzQm4RcNJUgtXgJrMGSdGNoPqep/vgHgqaKBHkq0RdQQ+NMAUWQynEF6KqtQXKpkNS3xe
	H0OnqOD96Ku5JcSBI2++QcESjtX0xQ+M88o3Ge/7iY8PFGJRRvvRS+wIg3yTm7JikDtdDThG0+4
	rC2IKMCXhZDbtGquMSe+9O5Aj30xBC7PNknaUZ0qZXenjA+JderLQ41OMi8euX2nQZMqG/B8w27
	kAhND49tycPEQSK7iOf1ML8Hu9TZqsEXS6KTC4XnL3yujuDLJS/Bl3/zSpv1SAEPmPQWEFBUReD
	freUbjldywuyY9/Qr8ffxqWF5N
X-Google-Smtp-Source: AGHT+IHmvDnY7JSGeBJVPMYAkqvHGQ8m3w/2w37j++4nirFiCLdiv65R34JXWsDs9p5gQynJ0q3nTg==
X-Received: by 2002:a05:600c:35c1:b0:477:54f9:6ac2 with SMTP id 5b1f17b1804b1-4778fe1170fmr196589265e9.0.1763482069791;
        Tue, 18 Nov 2025 08:07:49 -0800 (PST)
Received: from berwick ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a97412e3sm20850665e9.5.2025.11.18.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:07:49 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] worktree list: fix column alignment
Date: Tue, 18 Nov 2025 16:07:31 +0000
Message-ID: <cover.1763482051.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.345.g9c3c96ee5a7
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a worktree path contains a multibyte character we end up with
excess padding between the columns in the output of "git worktree
list". This series fixes that and quotes the path to avoid control
characters messing up the output as well.

Base-Commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fworktree-list-spacing%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/fd372d9b1...b42d0f668
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/worktree-list-spacing/v1


Phillip Wood (2):
  worktree list: fix column spacing
  worktree list: quote paths

 builtin/worktree.c       | 41 ++++++++++++++++++++++++++++------------
 t/t2402-worktree-list.sh | 37 +++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 25 deletions(-)

-- 
2.52.0.345.g9c3c96ee5a7

