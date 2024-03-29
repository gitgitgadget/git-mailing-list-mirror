Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABC3C24
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746162; cv=none; b=p6gpX+onFEYXJ4dIrAWIzBhSd/TQvF3BndDKrdQb7r3tNihbdeiPNbVrtQSxQtdVlP1w6hdU/K3k3CCosAdGCO0ibu8ElPhDIpqHqhPKAKSby4FVsz+qHzPVXgWbgXOESMuA8mMpl1AX0bybh1iaD1i1hu/sSI5X0MkM8nKxcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746162; c=relaxed/simple;
	bh=wqaocCiaulZX06o+S3M4rXpeIwrAdBSbD5YhTsJU1aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEHoTKBWi5cZC2BeAQHaoQ0KCenKejMZ7MA7vCGZ+EkpxhCkjQOKpfHzOeX4poEiV1btboE5p81XskMBN5qKcix5W3IFDeEXvrhShw1ivfNMd4SFqSJRcCov4APfotqI6lDTYMuNc1hEUFyeuzePWIMRcP2vtvvoS+PhyC+uYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8+IMgJU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8+IMgJU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dfff641d10so18276125ad.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711746160; x=1712350960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DC2phNz5ipYJyFV2ZDlviny7PqnszCNUjPLSjAJULg=;
        b=h8+IMgJUXMFDNLDpiNfrnQI+viF3kWLT4sKctmELNySnbypBrhsSbXJieNmsIRSF1G
         43RySyd7XbniZXBWxJH3dfYOP5opbbALbRIZrXxsKA7xhZqPBX0j97QiImm9fCNXtigT
         y/dloNnp8Kko2LQTEXdVZT5w1+YEfA5d5njOqyI65JN0Gcc9g7lmdtOCNNpXMrNmNr8s
         VyMvPGk1b1rfPGEBpnMuOTzz9pe/ohB5BrPjsH9RRgdhSIVtI1GNhmLC8QLGeKE10Rpi
         YMVYFYwUTaibrJm3xL/JAESyNQRV2+soOkdL9jJK9AUsv9AP/epJrfqjAJ/lMhfbgnLs
         igIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711746160; x=1712350960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DC2phNz5ipYJyFV2ZDlviny7PqnszCNUjPLSjAJULg=;
        b=AJku/FxlsxeF0yBONkWniWZliAwby3MU4kC2mPVHI9FUT4dua2X1EDfvDY0eufK7zy
         sEnsydIlnW6RX1xkztdvNsSfbqpAUYarxd1/WKV+GOwYNVGmHrHoyKTxb9u9ZBgLRWbR
         Mw2gtscs1uOx/YcCYQPNcdlfnSS7fN/gHIlar02AAObooHYGJMwm6rwtPc6KnhoRt5R+
         5jWYqpZi3hXShKnmEmepIIAhe1sgtc55/StCxkCtSOwIrcjDrfyLYWJmSrltZC0qTBLw
         jq7laUrdgoAWQHFPb7fa51Cy2peY3Kr9zlg7wtzUUSALmFzGx2rn7bQFdiSnNKL7aOwz
         vw1Q==
X-Gm-Message-State: AOJu0YzlcMuu09APBoFIqhHptztjzVtUqcXrwNoxJCHZEa3CjUlENc4w
	nR53GzV7ye22o2V9pJv4A142YoaBegfxQtV82J+BaM0v3putkhzIm6p81LHsQ58=
X-Google-Smtp-Source: AGHT+IHrAZKxVdzxTmF0RY+Dy8bPHuDLHvjP0xoxybRqbkfgStCQQa5w+mKrCUn/zc/gXX75uEhDIQ==
X-Received: by 2002:a17:902:c947:b0:1e0:c0c3:4b33 with SMTP id i7-20020a170902c94700b001e0c0c34b33mr3941075pla.13.1711746160385;
        Fri, 29 Mar 2024 14:02:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001e020a47fe9sm3875327plr.261.2024.03.29.14.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 14:02:39 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 0/3] commit, add: error out when passing untracked path
Date: Sat, 30 Mar 2024 02:26:18 +0530
Message-ID: <20240329205649.1483032-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318155219.494206-2-shyamthakkar001@gmail.com>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 'commit -i' and 'add -u', which expect known paths, not erroring
out when passing untracked paths.

The first patch introduces a new parameter to add_files_to_cache() and
run_diff_files() to optionally collect pathspec matching info for use
in reporting error. And the second and third patch use this parameter
to collect pathspec matching info and report error when passing
untracked paths to 'git commit -i' and 'git add -u' respectively.

Ghanshyam Thakkar (3):
  optionally collect pathspec matching info
  builtin/commit: error out when passing untracked path with -i
  builtin/add: error out when passing untracked path with -u

 add-interactive.c                     |  2 +-
 builtin/add.c                         | 13 ++++++++++---
 builtin/checkout.c                    |  3 ++-
 builtin/commit.c                      |  9 ++++++++-
 builtin/diff-files.c                  |  2 +-
 builtin/diff.c                        |  2 +-
 builtin/merge.c                       |  2 +-
 builtin/stash.c                       |  2 +-
 builtin/submodule--helper.c           |  4 ++--
 diff-lib.c                            |  5 +++--
 diff.h                                |  3 ++-
 read-cache-ll.h                       |  4 ++--
 read-cache.c                          |  6 +++---
 t/t2200-add-update.sh                 |  6 ++++++
 t/t7501-commit-basic-functionality.sh | 16 +---------------
 wt-status.c                           |  6 +++---
 16 files changed, 47 insertions(+), 38 deletions(-)

-- 
2.44.0

