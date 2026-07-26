Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CE189F43
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785106098; cv=none; b=EDYQBx7jAfGQxEKHrb3rBRSxqrPXzE07GUhrIK4g5s9CyJ1LNGllLzah/L8kdaZGlFKf3LY8yy+W63LaEoY/6v65GbZ8EQ7sSWASDvnbgLgFj+omVbkfN0TfOg5GMVp9v7/N9awq6RVbleJbd+cydqPXqAHG0Sk+RB61tH/EJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785106098; c=relaxed/simple;
	bh=8+Yks5LKY+cenLzw8ntsHH4FSt38imgiisv9GHM4Q7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0u0t7jFkCOzjLh3ONYMZkg1ndZMZGJDrcBcYjwwZspNI67L8M9CFFiUeju0WGGnHBkcweEstuhg3wVHLpD0e3ZUAYxo64Pgq05QDAQ/mR7JxaL4PWZeSbEMZkmYCxH0/gR+xk1+YkFUhcBs+cxDKyd1oPrHi/zjt6/DO14ti5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9uYZYAV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9uYZYAV"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1730947a91.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785106097; x=1785710897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6vlgqHWaZVdtdMVbu/v2u4OCDtJea7LnbsEL780aSs=;
        b=T9uYZYAVCh26hc8YcqLRY4bIlcKY2dc2uyyEOohBhuT5e4zcQiTSG0cXZxYilS4ZF1
         dfcMaxdZt5DovzJmxEE+es3jDLQKDoFMqxhOeqXGKL/OWveQ8yXw2rb3jN9AJKhk0LP5
         L+ioERyv6x5pozbrOfkNc09eoy8UyUu9L9ubykzalWH5rtsWYB8vdKYRwu9q6EOkzF7I
         ALAqATfL2orQfaGTEYPzPQ5amPwagPhdajWNIZp4u8GgXZLGxedy8IH6DuJ90fooy5G7
         gR3i5PESs7NtPfA03XqWNqoUzKLN2HsA7h1iY3yN1SMg37MkFCdWUgrpNg2vmIGvY83p
         KBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785106097; x=1785710897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6vlgqHWaZVdtdMVbu/v2u4OCDtJea7LnbsEL780aSs=;
        b=AS1OyekoT+cZ4psKvmTadLn9Pt2QM5wUUQlNSbwu8wUqI+pl1PYXr3dWZC/EB/hQHu
         LvL8xyvQ2JSwymsLyFVzmo6tXFOb7GZbAqaoYj8AxUhF8w9XTGjIIPSPMaaLJr42q/5A
         UyZu7+Fw1LB1j+htRNLXd0ISOTTDMq3iRWPdfMrQ6Tp4IHRS2nukwYdf4I48NpDH3x7N
         OI5TFD2P52ofjyCZC1E+wW8EYbhSUzHV2c0NoaabX7ar5XETU3iFqu3kZzffGdeU1TzT
         +yzCEDSi1p5zQTPqcWJ5CMfFsuosmcVXqxHYt2ctt79tEgc69yQaZYFOME4YPHUWIjoZ
         N0/w==
X-Gm-Message-State: AOJu0YxD1ujN5n94THKpTzM6eF6sL/zWmZLny6KoCYLY7iwhZLi7/DyT
	sTY57w6NvSFlBHZDBZTxZ6BeuhAfjqisvs6+/TYoh/z+z83jodd+MlW2TcyayA==
X-Gm-Gg: AR+sD127rrX9tPOorOXI52MViXHtF2nw489DfIm+htuTntTelEeymLK9EPXojiWgVEp
	v7v1fnxaicIBjKey5/iVAzdKdt2dUuTTtQxcbbgqzFb6HY27BGmtmy+18wbjE8zqYlBCWxWJ4QR
	VtKtpnh5946W8BuOrWhsjQG6H3r4EO9XphwaQnlTI9KAml3cCSHjCUbZDyc/Hu3H/lqawv6Xiop
	QqZK3k2WxqOAdZla/hsOmoqsCLXn4s5H0X0ops838YXkpA1Xsjh5vz6fhRETzqILrHvw5CYRe6B
	wFiOuXpJZnUAVKpPH44EEdAoW/NIBh43evZY9/QKSTJsA/HwZf4TALRFwOz4A+FOqZyaKMG2vKC
	VvAOLEFsTWHsrK/SDL6PmrlGuKY0FLFXhYR1qwxKDC8Q66q/eID9qPTzImlDrXBlBIAl19zcPLx
	ZPIKYPEv+q/pX/QDuzJL2yNOQHt0M1y0n0cOpS
X-Received: by 2002:a17:90b:5586:b0:38e:e9b:ffa7 with SMTP id 98e67ed59e1d1-38f295bd716mr6218860a91.28.1785106096827;
        Sun, 26 Jul 2026 15:48:16 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:81fc:d9f6:d0c0:5850:ae0a:7e6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm24847928c88.0.2026.07.26.15.48.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 15:48:16 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH 0/2] t: add and use a commit_body test helper
Date: Mon, 27 Jul 2026 04:18:01 +0530
Message-ID: <20260726224803.45131-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing "t7614: avoid hiding git's exit code in a pipe"
(now in master as b6b276974e), Junio pointed out that the pattern
fixed there by hand -- "cat-file the commit object, and strip away
the object header with sed" -- recurs throughout the test suite, and
suggested factoring it into a helper (cf. <xmqq1pd4m4ea.fsf@gitster.g>):

    commit_body () {
        git cat-file commit "$1" >.commit &&
        sed -e "1,/^$/d" .commit &&
        rm -f .commit
    }

I said I would take this up as a follow-up once t7614 landed. It has,
so here it is.

Scope:

  1/2 adds the helper to t/test-lib-functions.sh, following Junio's
      sketch, with a t/README entry.

  2/2 converts the existing call sites: 60 sites across 11 files.
      The idiom appears in four equivalent spellings (piped or
      written to a file first, "sed -e" or plain "sed", "\$" or "$"
      in the address) that all produce byte-identical output and
      collapse to the same commit_body call. Two sites needed more
      than a mechanical substitution and are explained individually
      in that commit's message; a few more are left alone because
      they are not extracting a commit's message body at all (email
      headers, a hand-built object for fsck, a .patch file).

Converting the piped sites also closes the same exit-code hole t7614
fixed: the exit status of a pipeline is that of its last command, so
a crashing "git cat-file" was previously masked by "sed" succeeding
on empty input.

Verification: all 11 touched test scripts pass in full (build clean,
no new failures), and a deliberately failing "git cat-file" now fails
a converted test that previously passed, confirming the exit-code fix
is real.

Shlok Kulshreshtha (2):
  test-lib-functions: add commit_body helper
  t: use commit_body to extract commit message bodies

 t/README                                  | 11 ++++
 t/t3405-rebase-malformed.sh               |  8 +--
 t/t3408-rebase-multi-line.sh              |  4 +-
 t/t3434-rebase-i18n.sh                    |  3 +-
 t/t3900-i18n-commit.sh                    |  4 +-
 t/t4150-am.sh                             |  8 +--
 t/t7500-commit-template-squash-signoff.sh |  4 +-
 t/t7501-commit-basic-functionality.sh     | 21 +++----
 t/t7502-commit-porcelain.sh               | 77 ++++++++---------------
 t/t7600-merge.sh                          | 14 ++---
 t/t7604-merge-custom-message.sh           | 18 ++----
 t/t7614-merge-signoff.sh                  |  9 +--
 t/test-lib-functions.sh                   |  8 +++
 13 files changed, 81 insertions(+), 108 deletions(-)

-- 
2.52.0

