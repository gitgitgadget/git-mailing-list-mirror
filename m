Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188C15A8
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975348; cv=none; b=pofXEDNLaVkLvEdDcTZKBaOhCT3t5Qz5Ez6SA+QF1/2bBnNe3/JTnT1mfC0yXtQVOhGVX3DbP3qXQIFzIRZtJVqrbVYxXEDohyuFQsSszS6pto6yGL+z1Ifo/gaG0lLJqhSle1OZcYNlXod6ATCoR2e0/peSdiWN3IAbH0htZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975348; c=relaxed/simple;
	bh=r/Duk4rVlXdfTfgAdtz9UF6vSVzV6ZfHG41P4aloCG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8GxmhkesTo6Pe5T6eqcCTZByGWLDhptRf2j2yc365CeGAMHx3xjyFW/2HsuGDY1XstMVT8TuKVoXXB1hprenTkTFf1/i6i1KxnA1rdKvB2rjY4A6yzK13C8JWOfKG0p9I23HSXXPXR1XEH4T1TsQL9U6IiBkGt0+/jVTVAQ1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJTrPaUK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJTrPaUK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so7634935e9.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753975344; x=1754580144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0pQXsQlbfxghJuQ4jUtr9epY0YiyK9zAg+EMCFqCgn4=;
        b=mJTrPaUKOeiRA6aWtgxxIapQtMyg2HLuj6DdAMj76zrJ4kGV8gXkDeY4uSY8fmXKbj
         6lqZX1PHjLk9gjfbZo1iZu66a9aj7L8T36Bj3nGz0Hbd9XfXq2bO91WFAo2VwDEIPOHa
         Lmtp4MglHKjy1HRWfpXvS9H7byAkvvz5uLowe1PIs5CjR4E698a3MkkawLxYLVbjrAsr
         5QaK6xPHO8ewBKOQfjva2ke21HbrjG/FtNEYNXI9ru+q+xsYjb/q98HlMLYzWOUALjB+
         vVUTQXHSueXluv6++Q4N0+cpHpdmyrbthWs3Tqp6yqBN9DSOB7P4cY9938uA+eaodCPm
         3Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975344; x=1754580144;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pQXsQlbfxghJuQ4jUtr9epY0YiyK9zAg+EMCFqCgn4=;
        b=D+Oo5BZdcoWveXdxcfTHfiW/0kUIAdRYpcRpdIEwovoV+AoctCk2OrAkJr6oNb3S2C
         67Oc6xkJi4/LGD8VC1xDNJO/+YElP72a/QRr1rQ25WTolmbsSaG7ySKZ1AkOhCrEbvQ+
         PUYMX5AmTCm1mCfebV2cYxZBSYh8orvDMoKnWmWk3nSg70rwbDYZLvAG0Ia3N/NvMJOn
         f2a/iSYHo6csjX8sQUtpDOydzOcBg9qKxswWtj/gmQ4vu59/0LP+utX3+kPzzswuTbEJ
         Hkc6iXKAkL4eaWu3X1eVZT1S8qlb4MMWV8YPJT3usawZiqLhBl0uXvRGHh1+6vyz4Hth
         yk2A==
X-Gm-Message-State: AOJu0Ywr4bdaqns0f+tsxgkclSjq2hSjb7f0+CwZt4RI7lDcHwS2MNE7
	CGMycWoI1qIm2k2UXiyaVvQM3kbi1vuI7Pvy6ilrzZG2Wt6pEagXxcSotsnM1Q==
X-Gm-Gg: ASbGncsy23J0I0jinftPsMDIGoaJPg612PfrXtTsWO76QXQ8+bvTPTcYUdeEBVkTB7L
	4W0nm4vyssJ6jL4PxJhRAihR1wkYWDCRlzycFPUNyP0RDXmLzx71Jv++tlLas5KD2/+RUlwLUvZ
	C4Y2mHRAf5Aa96+DG6QjG3P4HxGr54ZU6GxM7CarDgZO4NMpltUVsdrjwSxPDVx2PdoP2+Vp2kF
	zeeN2vHapnd8C0BJpFy8j3DOP6ZdtXjlDzkYMVjaV1Onj3KD8kIMOpMJnZ5qH6UJo0Yy+8FNxtx
	TOtdoBQyiXb4R5krYKzApbPPz5UHzV7lCvkOIiH6jkPocb3S+pA8apj0ZifFN0zL5GS7xjFQ/Io
	1XCbYE7PrcnUEacqjwm14a2Y+uDSBOLs/5QjqX1jq5thc
X-Google-Smtp-Source: AGHT+IHIJkqYJI9yNebTQHyUAJH6BNbQ6EnEXW8hioZHQBwuYkF+rnmlsL2uInaVd8ssEGviz/02Kw==
X-Received: by 2002:a05:600c:3495:b0:456:18b3:df2a with SMTP id 5b1f17b1804b1-458a2013110mr26752125e9.7.1753975344107;
        Thu, 31 Jul 2025 08:22:24 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533e6sm2842426f8f.35.2025.07.31.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:22:23 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 0/3] breaking-changes: deprecate support for core.commentChar=auto
Date: Thu, 31 Jul 2025 16:21:52 +0100
Message-ID: <cover.1753975294.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Ayush, Junio and Oswald for their comments on V1.
This series implements the plan to deprecate and remove support for
core.commentChar=auto outlined in [1]. This feature has been the
source of a couple of bug reports recently [2,3] and it is hard to
see how the design can be fixed as it is incompatible with preparing
a commit message template containing comments. When git sees the
deprecated config setting it will print advice based on the user's
config setting to help the user either remove the setting or set a
custom comment string. In the example below core.commentString is set
multiple times in $XDG_CONFIG_HOME/git/config and core.commentChar
is set in ~/.gitconfig and $XDG_CONFIG_HOME/git/config.

warning: Support for 'core.commentChar=auto' is deprecated and will be removed in Git 3.0
hint:
hint: To use the default comment string (#) please run
hint:
hint:     git config unset --file ~/.config/git/config --all core.commentString
hint:     git config unset --file ~/.config/git/config core.commentChar
hint:     git config unset --global core.commentChar
hint:
hint: To set a custom comment string please run
hint:
hint:     git config set --global core.commentChar <comment string>
hint:
hint: where '<comment string>' is the string you wish to use.

[1] https://lore.kernel.org/git/6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com
[2] https://lore.kernel.org/git/20250315140913.577404-1-oswald.buddenhagen@gmx.de
[3] https://lore.kernel.org/git/20250626132233.414789-1-ayu.chandekar@gmail.com

Changes since V1:
 - Rebased onto a merge of 'ps/config-wo-the-repository' and 'master'
 - Reworded commit messages
 - What was patch 2 has been split into two separate patches and
   reworked to die when core.commentChar=auto and WITH_BREAKING_CHANGES
   is enabled.

Base-Commit: 1ae5bd276bdf101e37c1a8f2904a2eae05fbb744
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fremove-auto-comment-char%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/1ae5bd276...0e7c08b15
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/remove-auto-comment-char/v2


Phillip Wood (3):
  breaking-changes: deprecate support for core.commentString=auto
  config: warn on core.commentString=auto
  commit: print advice when core.commentString=auto

 Documentation/BreakingChanges.adoc |   5 +
 Documentation/config/core.adoc     |  20 +-
 builtin/commit.c                   |   7 +
 builtin/merge.c                    |   3 +
 builtin/rebase.c                   |   3 +
 builtin/revert.c                   |   7 +
 config.c                           | 297 ++++++++++++++++++++++++++++-
 environment.c                      |  11 +-
 environment.h                      |   3 +
 repository.c                       |   1 +
 repository.h                       |   3 +
 t/t3404-rebase-interactive.sh      |  19 +-
 t/t3418-rebase-continue.sh         |   2 +-
 t/t7502-commit-porcelain.sh        |  52 ++++-
 14 files changed, 421 insertions(+), 12 deletions(-)

Range-diff against v1:
1:  3747a1f77f0 < -:  ----------- breaking-changes: deprecate support for core.commentString=auto
2:  83d0d3ece86 < -:  ----------- commit: print advice when core.commentString=auto
-:  ----------- > 1:  a6355451d4b breaking-changes: deprecate support for core.commentString=auto
-:  ----------- > 2:  8b575980426 config: warn on core.commentString=auto
-:  ----------- > 3:  0e7c08b15e5 commit: print advice when core.commentString=auto
-- 
2.49.0.897.gfad3eb7d210

