Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F190209F56
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281056; cv=none; b=FMe5nv4b3AQBPqGDPT8BOhbVP48c3QGl5VvXJKO3nT00vKYwud8Pvm8qc+FCE/gpUgEraHtjtkSw1ZeFCunhC6dTAQDWhcDrLECFiZbMaRADJoz4CVMku6UDXOj0p4AGWJWOvXXYgjc2S6Fh986anGrAo4kC4YoPAAiGy3DAVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281056; c=relaxed/simple;
	bh=Ba0FAbQKKcIka793PGhdJikAD1mGaGMrRmWiOM67mbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irjAjqla9EGxAWiSx0aCNgj6upkzajs5fud9dSAcgM0unXt1hZd6FeQJBhJn7J9DiMwKstLfOWKE9uHVMPZNnLjTDB9e+o1kpzsu4UV1U5iLzuz7IABFmRh5GAfRTqrLo1lR6FjdH/mMxRUaDyS/+zHY+2uGWxwXuf5RGwFwCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvRL99Bt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvRL99Bt"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234b440afa7so1742005ad.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750281054; x=1750885854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noP/Cm8u58XitZEEcoYCHaHtfqIbFWxIPaHQiAsRgAk=;
        b=YvRL99BtWwFpquIx8i8qezEI9FfPtRk4gKY6bmkVbwsp78OwC14iy/cEViSu8ufbdu
         eTarLY9Gh84PKgw8vdRU77390z5UEmK5N0VWaERIbjaSQIRNRw520q1uCrihw/vZAZ1M
         eUEvyAa0yQxizVuLuDh5fu+lb8H4ZgNFVaU68fOcrB7mMNjAbVjXMn+7XeeE1bLNosED
         baC/AWKACQvckJDza+2zKFGj3pzqKVi7SKXNww88mdI11CgSS8owIcCIhNSKcs5JTOBG
         mzH93DQvmKwGVNNCG+CaSPtQTKWtMMwoeLR1fSrhh+XCGZ+k2tgrVVOazrPtzWB2xd6L
         gwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281054; x=1750885854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noP/Cm8u58XitZEEcoYCHaHtfqIbFWxIPaHQiAsRgAk=;
        b=f6DlFnHX/XWK59GJw6cHKG3fYsIwskR0h+bI3yvzuElfGRpzHZ4ndvV/ZrOlrVNqLF
         HCSgYRMJ8qKQGiCSgdUu4EfP31VIxQnswMRHlqgbqh4l62coNHebmLV8qkKuYd0qnCzw
         0JjgdxyiP7bNvgAU2jhuQpZaIruu/ZaTle+InBXCy1cVuJsZg2bCj5bc44knMieMk9iV
         GWROC1Z2uO3nrcrEKW4Vm/JLU1z3njifegYWmjKSx/0ygvaCc5fA9ToSbJIlS7WYGGaI
         0WIPXby6OSog3+hipZ1fF87uQB3y5gBt+AdyI/DyJfkbF7dvhkPzpompNwIGRo/len/Q
         6EMg==
X-Gm-Message-State: AOJu0YyO+sCc7g1q66bGF9ZF2ICVP84Erf1UkiPx3F/ONxdHmxvThNQV
	CEMEJUsx8Zu5A81zummFabavYWUIs1dnlAAs6Y7xdT7TN0m4wPg/y6SkYuKl/Q==
X-Gm-Gg: ASbGnctPgA3i/AI7od/x2orMPpT81eD7m5f4pWMlAbld3SdPs/jjZqZmrs/9W+KDB1K
	JrSu8Yf4TNZ3xQoUc+HOBe1HwiKBX3vnpK3PV6GxiYPvUxUdSw57DA9pmhQejBXCPhfj2Wi/VFu
	rtHdJSBFLRwoiuwr4quuajWZC3f7p2KQJIYFDwJ+UxAG7raLqmu1cT8rxQgIORakI+6yUofvy9b
	2XLlSennks0RFr6L84i3ytc2OW80hSZX1fGjbdO0AQFNAEA+fp8iqC0Dy7Yc7Vqg3v5dQqFqa/3
	1gf3JewTDQtbKa/CpMXtuPTxVNFPsUxOU9R2jvsrP+HopcPU1fp+D/k/ir8=
X-Google-Smtp-Source: AGHT+IF3xlVp4vMH/kKKtxmvpr3GGBpQEM5jnYjA3UYVuHYxGz94VnD6tkM380p/4WaDZW1CzceNnA==
X-Received: by 2002:a17:902:d4ca:b0:232:11e7:47c4 with SMTP id d9443c01a7336-2366b3501d6mr290573945ad.15.1750281053906;
        Wed, 18 Jun 2025 14:10:53 -0700 (PDT)
Received: from dev-phord.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680448sm9696731a12.45.2025.06.18.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 14:10:53 -0700 (PDT)
From: Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To: git@vger.kernel.org
Cc: Phil Hord <phil.hord@gmail.com>
Subject: [RFC PATCH 0/2] fetch --prune performance problem
Date: Wed, 18 Jun 2025 14:08:38 -0700
Message-ID: <20250618211024.2332525-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.50.0.1.gf2ab606906.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Hord <phil.hord@gmail.com>

`git fetch --prune` runs in O(N^2) time normally. This happens because the code
iterates over each ref to be pruned to display its status. In a repo with
174,000 refs, where I was pruning 15,000 refs, the current code made 2.6 billion
calls to strcmp and consumed 470 seconds of CPU. After this change, the same
operation completes in under 1 second.

The loop looks like this:

    for p in prune_refs { for ref in all_refs { if p == ref { ... }}}

That loop runs only to check for and report newly dangling refs. A workaround to
avoid this slowness is to run with `-q` to bypass this check.

There is similar check/report functionality in `git remote prune`, but it uses a
more efficient method to check for dangling refs. prune_refs is first sorted, so
it can be searched in O(logN), so this loop is O(N*logN).

    for ref in all_refs { if ref in prune_refs { ... }}

My patch fixes this for fetch, but it affects the command's output order.
Currently the results look like this:

     - [deleted]     (none) -> origin/bar
       (origin/bar has become dangling)
     - [deleted]     (none) -> origin/baz
     - [deleted]     (none) -> origin/foo
       (origin/foo has become dangling)
     - [deleted]     (none) -> origin/frotz

After my change, the order will change so the danglers are reported at the end.

     - [deleted]     (none) -> origin/bar
     - [deleted]     (none) -> origin/baz
     - [deleted]     (none) -> origin/foo
     - [deleted]     (none) -> origin/frotz
       (origin/bar has become dangling)
       (origin/foo has become dangling)

The latter format is close to how `git remote prune` works, but the formatting
is a bit different. I can coerce my change into something that preserves the
original order, but it will be quite a bit messier.

Q: Does anyone care enough about the command output ordering that they think
   it's worth the extra code complexity?

Phil Hord (2):
  fetch-prune: optimize dangling-ref reporting
  refs: remove old refs_warn_dangling_symref

 builtin/fetch.c | 16 ++++++++--------
 refs.c          | 17 +----------------
 2 files changed, 9 insertions(+), 24 deletions(-)

-- 
2.50.0.1.gf2ab606906.dirty

