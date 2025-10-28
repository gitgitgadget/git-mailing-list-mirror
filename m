Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3D27144A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639185; cv=none; b=G4n00r13JP4GQr5AKr192LbKN59+Nx4z3E0tAb3qU8sXUAXYszVuEj46s8YXDsvBHvbQkLp80hG24/QppIKkBRcjH8G7G1F2BL8Ulez4g/VXzDmn8UJ8R/B+cT0H1RhbZkodddMJ3F1Pl8NSbs+sMl5rqdHe4dqir4Jc3sBsN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639185; c=relaxed/simple;
	bh=5EheeBr2QF9OP4C+dZ7R+BCbZNGYDYWEGT/F5VZXgU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juJZyVT6beX6VWN6qYXx/Wl5Wl6KGgNvkkxGLVVKbBqqES92gOyBlhX4wIV8Diz93EdCCmijp17Nuz97FxSzLw+ZzuPatZ9sGgRaEsarKnrwyPs98z8cTKsKKc/j77w78lAjaPp9w8GnsRMwxo1VATxAIlsdUhUo7/hwI+POTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7b3defv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7b3defv"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso19496605e9.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761639181; x=1762243981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ka8yl3gxGVX1dgGw4uLeb14o5Vf+qatBtYsMno5FjrE=;
        b=Q7b3defvE7IuVWCo/lKkRGFryaXkr0num1D34SbNW2OP7OrNwBiYQZqtRFmbOG/K6D
         W6CaSn5RU4o44zRfvqFirbBzv/SO3A0r1vjK7fp7HKQWc+A0kF43RguUo8xoSmewmZ4u
         fIlckotT/dIeTICeGXdblOdSmwq9MyoqfZRzZnXvmDUqEL0kx436FHQ/6vc542E/5Oqz
         sWdR9cwHQd8navj5B2dGRXLiSI3lwzKhYaQaY1ksl2Fo1mg7ctu2TO+O8TXXWZBSwXAI
         e5+0BtN8hH9i2XnYcW9FviNqIyAf98oAdCt1Hh03dZOf4FHIfIYmjPPbqNSgpe7B/ABq
         osfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761639181; x=1762243981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ka8yl3gxGVX1dgGw4uLeb14o5Vf+qatBtYsMno5FjrE=;
        b=n5pFyQdeGMM9KYZvLSg68Dwc+3LeZrJd00WDpBPE7UNZvaiZ5IieY/C3CCh8gOEhVf
         ELj6DhTtfsLuq6WRG/8RhUEYEvdD0gjm0ULTx1prvoQ9G0VeRKl3pggkEC2ZZKSclhdG
         UWz6cc6IhiWIAo19F4vNRl7uyqJGMh8o9TFyiBKf4pfe9LN9nVitLrwoIj4i367ppHrP
         3RWQdqlTyByU6ynOh3O+qTwOdjyX3bIofvDAB2ET4+ZmXBbWg9HyYj3LhM5iVWeTYO/6
         XjzPkJyB9JJi7ESW5yob0oQvF7mI/akK8T3Z2bRGCEtYJRXPdO6EVYyHTaNVQAbysaIA
         oh2g==
X-Gm-Message-State: AOJu0Yyus8YSeuGLkKAR7m6SwDp5fip6BfJ1j5OVlQiWUxs6V0Fle8ts
	FazvZWS1vECEmkYjF71cwztBAj3k7j4Owc9npPveX/+QwCnwmHgZTgt2QVJmPA==
X-Gm-Gg: ASbGncuieoT6fz5/kZgcZMnoMqQ0C3MWzqBPxatcTl8SIKo1K+7zkRP/VUoB+Xl2Zgj
	KqmGt/fpvG/WNSiSehPyGyrfMq0VVYXHF5tRwWI48ee/mH4eSqVo6jDmT87x33O/7t6gU8F+529
	ggSqacu6dfAMx10erPlDdHgATgPqkvRmP+ORAm/45oHSJEbstCYYsycfqjzuDBuxNMK2ZLmPNyF
	6OkoYbhNv7IUtyKJvzpl1XmHyO7IGo100pud8IBKVPkyH4TbNnvMwuoxqv2L2c1D/wXfMboO8Su
	XjrYkQKxwaL0Ev67u2iizL8QJEuJ/s1h9tO70cwtCj9NGrosT0+AhWlaXEPitn/CPOx3c0fB7RH
	bNVfUyHBj8HiQqVneHSCbk85HCcYIguntwCXlr7e6RzTzi8m0IxqnfMwMpI+HcwEChGY3ofbTEa
	1+ce6M6cd6b8nx+LKQbSe0UXyXEZk=
X-Google-Smtp-Source: AGHT+IFhVhjsf5hWdchSbnRhplXkKqi2swkQkRBBfBTwDD6a68RKLPzQ8UYSJ0DBEma1giTsaL5z0A==
X-Received: by 2002:a05:600c:620f:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-47717e413f5mr17186935e9.21.1761639181138;
        Tue, 28 Oct 2025 01:13:01 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm12830335e9.14.2025.10.28.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:13:00 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/5] fast-export/import: cleanups and translation
Date: Tue, 28 Oct 2025 09:12:27 +0100
Message-ID: <20251028081232.3068147-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.540.g4ad31e1014
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a previous v2 patch series[1] that I sent last May, there were two
preparatory cleanup patches[2][3] that have been dropped in the v3 and
next versions. I think these two cleanup patches are worth resending
in their own series though.

While at cleaning things up, I realized that, when working in this
area of the code, I have often been annoyed by the fact that few error
and warning messages were marked for translation. So I decided to also
address this here.

So patches 1/5 and 2/5 are small code cleanups that are resent, while
patches 3/5, 4/5 and 5/5 are about marking strings for translation.

[1] https://lore.kernel.org/git/20250526103314.1542316-1-christian.couder@gmail.com/
[2] https://lore.kernel.org/git/20250526103314.1542316-2-christian.couder@gmail.com/
[3] https://lore.kernel.org/git/20250526103314.1542316-3-christian.couder@gmail.com/

CI build:
---------

All the tests pass, except for the "win + Meson build" which seems to
fail at a Rust related step:

https://github.com/chriscool/git/actions/runs/18856740498

Christian Couder (5):
  gpg-interface: simplify ssh fingerprint parsing
  gpg-interface: use left shift to define GPG_VERIFY_*
  fast-export: mark strings for translation
  fast-import: mark strings for translation
  gpg-interface: mark a string for translation

 builtin/fast-export.c |  77 ++++++------
 builtin/fast-import.c | 270 +++++++++++++++++++++---------------------
 gpg-interface.c       |   4 +-
 gpg-interface.h       |   6 +-
 4 files changed, 179 insertions(+), 178 deletions(-)

-- 
2.51.2.540.g4ad31e1014

