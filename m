Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31EA2F6192
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321109; cv=none; b=nD1zEwWDXG6aoIIqr4VhUv868bVrwG3Y+xLrChSY8R5jWt1T2xJuzSmP3Hzi6KtcvG6kVtnFtJ3SYzmeLAGPOEx+6lWwF8/flE3X05SCrGbPMdAr6nxXHRmI6jdASFw3W/qnHqQGM0hh/qjMXvQ9KlZPyWwNlg7UjkWlck1UYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321109; c=relaxed/simple;
	bh=y+7qbSHXpElIQziW/kF7tG5qp8L6GAmZF8x1FSuOHpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZPcqAN7f56zFIlQ8MfsM0uhHm2hABXsj3k/IFeGa/w5OAeuiExYQfTA2r6Au4ldtI81uOJklgttSxcAfWZJDC23E0wbXj5pmlNd8QDkQZVOxtHaX0Qqe1BMjgfCW49GLZeEbh0hPwGPGo+eWKOq53LpplxsZ+DcDoIg6+n2t7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSRCDPH6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSRCDPH6"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4557f0e5ed2so211909b6e.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765321106; x=1765925906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaA21nDBUs+kzUSVjOrF5a0/8AL3fo+/3ai1sj0+uro=;
        b=OSRCDPH6xyl5eqbQ3Brp4/MzhRFug0ljYJf22AyBLFNCZNIYK8kGkIZq27YWOHdRo3
         ExjKX71M2rcn1Z0hZb4xATi2H3ajCLSeHANF0ZkH8CztRNm0awZ6x1Ynv9FNdhN4ojad
         XlumIuWzSl0w74T1dZgXU5NifYvz/mUzNQndhFWuHkrN6nSEpAT7cc3B2ftKBxaJ8ZGo
         q77zHzSGqDBcp8uvNHlKKvJwxqbKajKpCEA3P07sxJhw4ETUu2DGBvkZ35DySmC5wzXw
         b+pEBbSPPv2TIqLrUJY95tTps3ebLHkQUG0U1qrQ9W68BCVwvTlCtisLH838Luu6msZI
         MI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321106; x=1765925906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaA21nDBUs+kzUSVjOrF5a0/8AL3fo+/3ai1sj0+uro=;
        b=gPg8EnP7IaiwL0ffZMvSsdj4SicO/GEQB9ey2DjDo0lhcKs5SZHPCINCUYgqQUjxJ2
         P9L7e1vaTkxsqy/JSuGWw7BfHeNrpb0+YdoXD1v2imugyVrWOvbYKT31V4jjV8CmJt7r
         3+sHkiifs+8KA4DvJf1OY/FilrxwYQnR8Xc7qq6KL0Fvh5IVhT3/hXzqpCayERgP+eku
         BhTgjU5uikv84BJcY+jWIEfMRkUS2PTXJQxsbsX0kguDxBb37JcPg6mEUQaoC3iYOzs4
         Ez9BvdCPXxBrEAgR6dnGnXY+gK4lapqEvSZx02XQMSjSRk+AR9UdPIAIi7UIeiA1UPfX
         5SFQ==
X-Gm-Message-State: AOJu0YwyEYexQZCKSyuO+h2hqnoMLlesogyyFY4K+/yr0MaJzTLViiGW
	YILnDnRczgIT84qY8ZRFMXWZkn6UacHDfrHjr2cNO4RcW7zCllscKyF+fGtTNg==
X-Gm-Gg: ASbGncsxxpgQZEwbV8TGnL3ANh/ajaugBY/aOuAf2iMjsAjvZ9YG3DLSBq/HavNFmTo
	8QGXv6ZKeX9ueavC+LsnQU+KZtQv6PasFElW7WNlmxgsbcSYKgsTBPPMnP0c7EiPv5FE2DCfMeL
	lBOvQDT5DUFNAlg1EI7SvImUzwmcX4TtV6aoLeCBB7pkUie8RbXfcuh4Kvre35P6Q16/5VcZ51k
	pXPBwbF24y9wpz85dNBSWkfIRbSNPQsibZR5t49l9R/jqNnw5UdvB+p81MJzr73CwY5CyD8DkgC
	STixkSmMamuR7knUDLDHKEqTJRe+KU3MrP6Kko6GPnoAbvxyfGWm5uLBMZl8tj0rGCv6fWc/1SJ
	loyUvdOlqYloBNdPnd6++DVXqZqTaZ/6zoAEyyq65QyuaAiaPclCFFLYPUwO1i0QF+n3qpbyZHe
	8fGdST8/bB4MsBC5lzRtU=
X-Google-Smtp-Source: AGHT+IGVzwZExHZ01tglL0vY1KRuWMigXOiQT6g4LxXtLX4i+ogIXRVVHJR4g6q1G05FANUQAt03wg==
X-Received: by 2002:a05:6808:1a28:b0:450:b246:f1ab with SMTP id 5614622812f47-45587456348mr248007b6e.11.1765321106523;
        Tue, 09 Dec 2025 14:58:26 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02desm8161354b6e.5.2025.12.09.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 14:58:25 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/6] builtin/repo: add object size info to structure output
Date: Tue,  9 Dec 2025 16:58:14 -0600
Message-ID: <20251209225820.2861276-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This patch series extends the recently introduced "structure" subcommand
for git-repo(1) to collect object size information. More specifically,
it shows total inflated and disk sizes of objects by object type. The
aim to provide additional insight that may be useful to users regarding
the structure of a repository.

In addition to this change, this series also updates the table output
format to downscale larger output values along with the appropriate unit
prefix. This is done to make table output more human friendly. The
keyvalue and nul output formats are left the same since they are
intended more for machine parsing.

Thanks,
-Justin

Justin Tobler (6):
  builtin/repo: group per-type object values into struct
  builtin/repo: humanise count values in structure output
  builtin/repo: add inflated object info to keyvalue structure output
  builtin/repo: add inflated object info to structure table
  builtin/repo: add disk size info to keyvalue stucture output
  builtin/repo: add object disk size info to structure table

 Documentation/git-repo.adoc |   2 +
 builtin/repo.c              | 222 +++++++++++++++++++++++++++++++-----
 t/t1901-repo-structure.sh   | 142 ++++++++++++++++-------
 3 files changed, 295 insertions(+), 71 deletions(-)


base-commit: e85ae279b0d58edc2f4c3fd5ac391b51e1223985
-- 
2.52.0.209.ge85ae279b0

