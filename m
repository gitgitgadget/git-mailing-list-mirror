Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7825DB1C
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771567490; cv=none; b=H6dFpj2slQ+G2bsTwIBqSZV18ngVCrg6pWIwj90CeS+uKJNeLydg5NG9wK4/gDXKHB7LZRbTtt4uFmcTgE5Rr5ZaUeuK60xPClRLJ7RCou3Kw04xDhUgb81hBkodPVc/mO17g/iZcSWrN6Aydd1YASP98kevnBwAI3OhnnQyIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771567490; c=relaxed/simple;
	bh=VZidiWU52RQJKyISNeb3xzgTD7fttsjLU6KkO9l0wSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsBOwHZIlrYpmEMkmRHTlnIqfO/GzG/87KTHBr/loiX6H82qEOLu2yw16N6orCiTyqwxIaIh/ceI6vNeeiPJD5TxDiCnz7FZlPTp1Yme0scnxNeBW/nReebioF39RAtOUiTqXo171fUtLfzBezWd9PZ71Pu513xjFJsmcDLkaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2jYPy/a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2jYPy/a"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so15777365e9.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 22:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771567487; x=1772172287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DijCjrxGIF6hbA3rfwFDWFP91qvmyifabToGF2wJodA=;
        b=B2jYPy/aspg6yDqY2f2FtXlEXtsISxBhwLXNLsC0liv2uB+D2YGQnCoQvy8l/zr8+v
         RG0TnJ+34Lk99WeCLkZV43a63TxWshBUNbyVibH1q/59a6y8TEWddq0xCpfcEaUBQCQi
         OSPJAIOTGMacI2YhjWS5Yr3F4ieaHPlv2JhXuiJ4PeJMf9kWGEbExkkrrp0n6/gKJljK
         6hV+XZFMTDPULpmCo1oqL+2gUZiJOrYdEZ3UnsZ0U4tbvovk94g3tgrtx/otNx5nElUV
         1zPjs9XCS2kLVFJqvJQMju6NEY2Fs4BrgwcfNAEFrXqBV5KBCmiyIU5Kkpc0/ggYA2fE
         cy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771567487; x=1772172287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DijCjrxGIF6hbA3rfwFDWFP91qvmyifabToGF2wJodA=;
        b=SkZ7CFc6fHBu1dx0l2DHReGTZnP1rGxpDvT5yPFqF3nk2r5Yex+MeRkWXNxlTJVj0j
         aZj4sg918D+0Cfr0NNmTQzIVHMZfm5LN7Mc9s19aZM3GqKJqCf8islfDF0ufWm8t2Hpk
         Z9cp+9xAWOUbsD7cZLf/y37Sw0oLz67LsjUE7vEipcgPVxcf7fc6SHT6qb2moik3Ftwy
         A/ciugo1oiM3pXv5R+tDNLYwxIjNlJmZAvlApeZmjLNOd5hN55712BvQCY/4o9Akyqwl
         hYGf8kz1DIatES7oBIYahWBZej4jz/J/mkYiDgvierGi2TqcqAsfFF2OPBunUf3dBWn5
         rTlw==
X-Gm-Message-State: AOJu0Yy+ww4c8G+fH0GPfvAImhUiAA2PB8O2UWhnILEk9zjUKxB7i1DO
	ysPORvb3icOyrtzpuAzHmM9TX2PyBQyQSrGQgJxjSwanK42MNDeHnjE5hAN2Ag==
X-Gm-Gg: AZuq6aJpnr6M9YMCRXegInZHoEbEbeJK6ge2qnmgJsSD2/ytULCj0yZt/XtGNTKI+Ez
	s0aNy+vdHjdKx6GQiddeo04Oila7HIFAc6WOgsGAP9w3OADd5KKmfGZnElHJ/K0l7yxJQYdpB+m
	RgAcv93hB4oj/t/tdlM52q3mRUEC9B4ApMQuajZqCN+Pr8Y7jeev81+EAWH3fbb2YglAmlDqeIG
	2eZlHQBY1t+BxHBoNNqxnOUSCmNXw4NGSxBpwTnLXhvvWrj9MdaUabzwqRRHSlCsQAqrGf+VaZP
	vr/SRoUowqPVgChNwtu5RvJTXsmx13NTgyLC2sEpo5l0gzvOIR6Esscom+Xgu6iHQfdJ9ErmLgS
	L98YqMiYOy0aio5ZRwag4NeDTTW7bbYCVLibpp+CLOzu7hlbvKvpFIU54GDE4PMMtzMJcuzorg1
	iMRAYXj2QsxnOimLiuS9ixF7lQi2m3c28c4Q==
X-Received: by 2002:a05:600c:1f0e:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-4839e636f4cmr74900385e9.3.1771567486911;
        Thu, 19 Feb 2026 22:04:46 -0800 (PST)
Received: from fedora.marun.edu.tr ([193.255.169.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm43477255e9.5.2026.02.19.22.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 22:04:46 -0800 (PST)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [GSOC PATCH v2 0/2] mailmap: reduce global state
Date: Fri, 20 Feb 2026 09:04:40 +0300
Message-ID: <20260220060442.29469-1-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219125954.3539324-1-bkkaracay@gmail.com>
References: <20260219125954.3539324-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch series aims to reduce the global variable dependency of the
mailmap subsystem:

  - Patch 1 eliminates the implicit 'the_repository' dependency in the
    'read_mailmap' and 'read_mailmap_blob' functions by adding a
    'struct repository' parameter.

  - Patch 2 removes the 'git_mailmap_file' and 'git_mailmap_blob' global
    variables, shifting to on-demand configuration reading via the config
    set helpers and using local variables.
    
Changes in v2:
  - Forward declare 'struct repository' in mailmap.h
  - Fix whitespace problems

Thanks to Junio for the kind words and for catching the 'make hdr-check' issue.

Burak Kaan Karaçay (2):
  mailmap: stop using the_repository
  mailmap: drop global config variables

 builtin/blame.c         |  2 +-
 builtin/cat-file.c      |  2 +-
 builtin/check-mailmap.c |  4 ++--
 builtin/commit.c        |  2 +-
 builtin/log.c           |  2 +-
 builtin/shortlog.c      |  2 +-
 environment.c           | 19 -------------------
 mailmap.c               | 30 +++++++++++++++++++-----------
 mailmap.h               |  9 ++++-----
 pretty.c                |  2 +-
 ref-filter.c            |  2 +-
 11 files changed, 32 insertions(+), 44 deletions(-)

-- 
2.52.0

