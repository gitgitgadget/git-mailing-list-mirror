Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EE204080
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299164; cv=none; b=LY5n9F4w7awQBl4Dwqf1Lubr4JdII1N1Xg8GHpcTMA24mZceCcaYNccOse+0GLEELU38wp+RuY4RVy0sjMznEDTHDvmKBrkjn6nLuzKsXQ4taJQ6IayFYuuIf73K6rtd+Vyu/qnkX7RicLd+vblZ5fQJ9pdrl3zWfjbPrxP8GcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299164; c=relaxed/simple;
	bh=7YGOE1V0m9sL8QWrYrg/iFXRmB5kj3lqEV/02JVPmT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rn2fstZ3G5plKk3wEnD2A7kq0Uft6184Rw8FHynrCxJlgnEhleDo9nlVl2SwApYQXaSfwlB0i323qdYtJh0XX9UOSofbrJfzvExhGRfiXAxzj5D7+VkgBckBQPSMuUHl3he5TwiGTzhnTjCNBK+MXNVZB+lq3rje2EtYsTjMnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMQFt2Zu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMQFt2Zu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225fbdfc17dso43551095ad.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299158; x=1742903958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvhScSu3t5VemBaRanmXmyrxZhq1r7vCFO+Z8EBQ0vs=;
        b=GMQFt2Zutyk8FAXO6YrRP454BOwjA6BO3zPmPhW39/U2WqCZSg8eyjvKGEeUoc+0yu
         xHubcW4sDiZuhxkkden/IU1H7YgEO+bUHH/u8HRFf0ZWZBuA6HXrFBMxN9QFwbMkrUBS
         dbAOXF6O4Om57rzN8LCoCNZxCZxw3Pmx7cximQ1FADIE3XnCQ4AelHbUHoRdTogF/Nr1
         s9FEYj8fCRhYyNSyLl4iEVqLgU3fRFmPPDm9buRmYu7/7yqCVdkHkXlO+1XyXWnU4w+j
         1J8UdzsuDQ7a81ifzwiWhejjg0VkAK+AqvJPHMVBl40HMnboKGxWTJ+ZBIQK/p7EsfL6
         xxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299158; x=1742903958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvhScSu3t5VemBaRanmXmyrxZhq1r7vCFO+Z8EBQ0vs=;
        b=XTDTqTwiYpBRRfDQTR2y2LzgQoOKUzeClTEy71uNVfJ/DYYNvUIRUgLdCQ4I9IhJzY
         UjM8KIxFkb7IWyVuBvtOaZBUuVGUWkFV6AXYH9SHuKa/bmIkVCGsMkghuttDo31SpRrA
         2ufJbPqk+U7F7gO4SFY6UnAuxs85pXQ6Q0iJNWriInwm1oTqDU/pHRATK5wzkR29hV5k
         dOHflJdyftx9zcRTY5soKA5A0k3/eGQalnNtWXzz+0aT/6ewVffaJKxjA+8/qA2Ln1Fa
         f8ZjoPupu8RYLn0ZghMxkogOmqADXCsTZ0MitKq0bPx7qJwE8XdXSov9zcKMRzny4/ff
         qYuQ==
X-Gm-Message-State: AOJu0Yy1XIsHEUbnW1v62hsH0ILa0Po++qwTZZRpR4ea6kPqSKnJXWIH
	7dwadkohXtOVXEVDew5fXum2wqlT2emVKehT/koQsOjkB6pMfKZd314udd46
X-Gm-Gg: ASbGncvEBH2tcxzJ12fRHuJ+CogegJmMY4qNov/iEhcfwupmkqocRCKH4KNWUo8vHOx
	KuPfx92E/7BoLSsGgwv0+g5eoXXw20UY60UolRL6qiwLg988KId86a2rfPpNptVw3+hVNxrdEIN
	pF2olGxvPfY8mWcwOxnIdTHVU+N/M6aHtK3m6EKquR1LsH0PcYzPl0yS5RVBN4OhrXCt+uN9ado
	OLFRCR5lW+Bc5ZK5wC9jc8iUULS9R/yK1E+4wzHvhyNvymt8HDFc7GwnuGLP6L6w03Ln9fVIBqx
	zZ3CIiNpLR3oAwWM7aoDhzpI26uEJUC2RUWshwzemtXTEd4SU03C800cIT0hkhPJAG2y+nFpzcn
	0wm7B
X-Google-Smtp-Source: AGHT+IEJZbe2rSjPsmORX9rk64mV2wlqY1898woVHrXAvlS5MZla7OnI0jeZ5/77t4KTnKbYHqgpGw==
X-Received: by 2002:a17:902:ce90:b0:225:abd2:5e4b with SMTP id d9443c01a7336-225e0a54cc6mr195753135ad.16.1742299157578;
        Tue, 18 Mar 2025 04:59:17 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:17 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 0/9] remove unnecessary if statement
Date: Tue, 18 Mar 2025 17:28:52 +0530
Message-ID: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an earlier patch[1] which has been merged to the master,
We checked `repo` is not NULL before making call to `repo_config()`.
Later, in another patch series[2] which has been merged to next,
`repo_config()` was taught to allow `repo` to be NULL.

So there is not need for checking if the `repo` is NULL before calling
repo_config() in the earlier patch.

Note, I have already sent the first 8 patches in [2] but, the 9th
patch depends on the first patch of that series. 

[1] https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi202@gmail.com/
[2] https://public-inbox.org/git/20250307233543.1721552-1-usmanakinyemi202@gmail.com/

Usman Akinyemi (9):
  config: teach repo_config to allow `repo` to be NULL
  builtin/verify-tag: stop using `the_repository`
  builtin/verify-commit: stop using `the_repository`
  builtin/send-pack: stop using `the_repository`
  builtin/pack-refs: stop using `the_repository`
  builtin/ls-files: stop using `the_repository`
  builtin/for-each-ref: stop using `the_repository`
  builtin/checkout-index: stop using `the_repository`
  builtin/update-server-info: remove unnecessary if statement

 builtin/checkout-index.c        | 43 ++++++++++++++++-----------------
 builtin/for-each-ref.c          |  5 ++--
 builtin/ls-files.c              | 32 ++++++++++++------------
 builtin/pack-refs.c             |  8 +++---
 builtin/send-pack.c             |  7 +++---
 builtin/update-server-info.c    |  4 +--
 builtin/verify-commit.c         | 13 +++++-----
 builtin/verify-tag.c            |  7 +++---
 config.c                        |  4 +++
 config.h                        |  9 +++++++
 t/t0610-reftable-basics.sh      |  7 ++++++
 t/t2006-checkout-index-basic.sh |  7 ++++++
 t/t3004-ls-files-basic.sh       |  7 ++++++
 t/t5400-send-pack.sh            |  7 ++++++
 t/t6300-for-each-ref.sh         |  7 ++++++
 t/t7030-verify-tag.sh           |  7 ++++++
 t/t7510-signed-commit.sh        |  7 ++++++
 17 files changed, 118 insertions(+), 63 deletions(-)

-- 
2.48.1

