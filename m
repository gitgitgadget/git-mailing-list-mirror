Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB1762D0
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 04:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360508; cv=none; b=SIqe7uCaC7riYlODZVrTI+GkktLsvYGyIu7rHjKpC6yjldY4+mymnFxgE3W8FDEPVX+LrJ/gXsTIr+NPsylUTi4VKkskWqM40StTkizosnOD5+jqUhKELkRyOW6lanuS7b10Cvm45wryGaYq02s3TUKC6kgKPKvpCq2AgAeDRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360508; c=relaxed/simple;
	bh=OMuVPkI6/UipUCzTIUXUSgSyeRybziPREEUJDh05IVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s0TxeJCrJlxZCeLnsf8mtUPHGCWMwvpGQ2QWXhiK7LFVtsFZA2XnaZ2wEJMZGw49BHIsmXvaDipflF6CysP4JnC7wU4N8yfC52EBBfjpkn/hYCgBKaMMf/kuX520KLKtuEcJvJTaDUJgAWci+oTkKwwgjr/o0by88XE0Tze6rKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0sOv7nH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0sOv7nH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e28b2df104so7326a91.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 21:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728360506; x=1728965306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezOGhyZSZnacQwxx9fBceiARhNr5ZIXKCldRwmApAV8=;
        b=h0sOv7nHp9SBE6Ys1c1TIxdlaOq7lHQNYuIZevvN0dipMhQPKuobeFL6dCFC9pawU1
         cnP4DnbLwTOtCWwVoGPrT0C/07+4lg9DN8LEk02+D6oPc03vCAkwQQ1n4RwjX3tdURek
         wUibpnHbQM6lGJZU8jnX4TjFnhJY6UM+qm0bVu8fMDc5UOJ4bKBfUG7zY4De3F3dxhGB
         Jl50jtrr5Axeaqu+oVOxdtYNUODPF8ltKAa4pOiol1/XkDW25bxQvWV9Bks1jUV5BC/N
         LwV/AcXI7ms8o4SeOeitibgiy2xZ9CvfSVRI9WvBN8sgcnDLZjYud4s8wzeBwdZY+Ntn
         5vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360506; x=1728965306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezOGhyZSZnacQwxx9fBceiARhNr5ZIXKCldRwmApAV8=;
        b=KzxNG+7D47QQW8UyHNSdcMhCfL6AD0AfU65a5eEm5U031uTeToA51jcPlB7rgu+DnD
         C7uHMwssb4HS90H8OAMO1xL+hHx5RqtwHNwbZchKWIuWfmYiC0U2FAj/H0reCCKgfG1B
         yBXAgJiBvDNzWW848rJ+Hm0kpJP9m/si3BpzBO90DOBwkMGbhfhjVf8fJKA3KtJyxEZA
         FWOr7o5/oKOKB4Mk4+g7q2+bANSroyefby3d/m6mvxC7tdqp2cw4l+IoSkz7yQ4wU/ol
         41zDBP3RIsuIlwVvUMCawir4LSKWswKncJm5iqqu3go8TJ+Z5yowTxISOqvOM7m3lQwO
         T7vg==
X-Gm-Message-State: AOJu0YyMw2m3KOo1/pD5FpEwQ5ONsGw8VchGilhbJKuZ6doLiBhFCJ8B
	asiDm5ZqV9RyzOW/2FDZ4ce8x4iQu9HcgbNtSrEEjN06vkrd/P8pf+LMHw==
X-Google-Smtp-Source: AGHT+IG2OnHQNFkzSOtiQKWWnlf+MovoDbt5WLViX2F0LLlMkh+zLO+4PXnF8KzTIBN2JYZN5Nk7/w==
X-Received: by 2002:a17:903:188:b0:207:14d2:ddeb with SMTP id d9443c01a7336-20bff1c5568mr92853465ad.13.1728360506004;
        Mon, 07 Oct 2024 21:08:26 -0700 (PDT)
Received: from localhost.localdomain ([2604:3d09:e083:d900:fddc:a13c:16ae:b340])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1395a533sm47056035ad.204.2024.10.07.21.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 21:08:25 -0700 (PDT)
From: Josh Heinrichs <joshiheinrichs@gmail.com>
To: git@vger.kernel.org
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>
Subject: [PATCH 0/1] Remove value from positional args in config unset usage
Date: Mon,  7 Oct 2024 22:07:48 -0600
Message-Id: <20241008040749.69801-1-joshiheinrichs@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I tripped over this while attempting to use `git config unset --fixed-value`.
The value is supposed to be provided via `--value`, but the usage makes it
seem like it can be provided as a positional argument.

While I was looking at the translations I noticed that po/bg.po was missing
`<name>` as a positional argument. From my reading of the docs it sounds like
translation changes are made independently, so I have not changed them in this
series.

Josh Heinrichs (1):
  git-config.1: remove value from positional args in unset usage

 Documentation/git-config.txt | 2 +-
 builtin/config.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

