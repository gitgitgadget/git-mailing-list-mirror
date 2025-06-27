Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAE4221FA4
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010597; cv=none; b=UhoLnXr0/+ZvV+TAHWW03hvgjKVPKuWt/SbQMP8mqDZTAZlV9gbveAM5TP7W8MR975hoeWHKL7TlJHq94gbbNKBj5I7tKLQ/y0jUEW4dsxj2UTXRPBToIp6B+/mYNAGM2LkduB1Eb3y8+G46Yxa/pQnYackHcu5/uyYlPyQ5pLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010597; c=relaxed/simple;
	bh=WH2MIuL5hLKWuxjRN0vHXZE1dVQ2afY8Zb3aAOuNNvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W7DKMOn7U3fsWl0cKR6ym260mkYNj81jSOT1DVHVwwyt3TBkYVjwH5/J+vc6AnJN0Drn9dzMaR+BVQdHmsUvYDmQHygg0zTqLsd1NMFvzsfU8JMVlW/s9vMbkTOLIjeKSESaqtNx6NAlawyhWf5eYnsPJZ9gHiIITyDhYbKMo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5ON5HHA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5ON5HHA"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af51596da56so1434698a12.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751010595; x=1751615395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7ZXhKLnZRDLVHkV7sU0xNyX793fkl62gZD4HoLJi4c=;
        b=M5ON5HHAmk69Zw00UwVVsQqY6TDbkBhQgNDiaqqmDvx6jtkd3GkWG+r4y8DtPk+khp
         dVz8pffMtI20S1kUXbw8MWRX8CdO12wNqNYup//GEKR+/8qGdbT4aNuULDCWEGJ9LV57
         uhqNbkE9aQj/11G6Csi4QSqjzBkq3nK/TbQyY4I3kRPrJbD2uW7r9GBnz7Qn62luPw8k
         2tBAXC8WQ7NVgiMevi4KZO5OgPWCF8hk75naTE80rtpkE0ZcVnBTmI5xW0EORTOpKhLU
         3PiXDGPCHgH5bstNBnPhWZTQFfJsuO08rUHmkZZzBseo/dNA6gCYSPp7UWkelKnMjMcy
         qmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010595; x=1751615395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7ZXhKLnZRDLVHkV7sU0xNyX793fkl62gZD4HoLJi4c=;
        b=bWU7GRLAUeMKeaw7QLR6f1+BqKQ2ocTcyhWrzrDkJtxJ8BvSHn0Qp29IQxH7OB/af/
         XonbHr3IIYXVxIVC4/Ho+kM2Ntm4uYFS25ya6UsH1onxW32TuLacbG/x196pzYBDp1QU
         4AcfWaeJsc4jQ8pRnt3yYNr9zE4QX43AmxY2V5pa5DNTx7Ng9EqCRlwnPnNQO/dtuSwr
         sd7IWqcbgbgD1t1W0GfEKmekZW2+GawLNTiwkGhOklbU6BgMTPkRidwhbc/J8dPqkrFK
         +Aei5E/Pt0X7UPacJDmOjfD5LQFoBd9zkNR6QxQoiZLOld5/9khuXpIbGboEBj0iGjn3
         nmZQ==
X-Gm-Message-State: AOJu0Yw6+Sb6f27nvZAFQZsso/tVP1LJcd+/ID2uHhwal22nFwsdVHn4
	U5yj0Ft+l0CRqtmAKSezLMvq8pTFdW8ZjcxFjknNzie4aQTf0mrudR16nK5Z6zIg
X-Gm-Gg: ASbGncvND2XV/1DT+a5JHBa/2J0gVLGAH4cCLpyOKNtWAlPkUu9x8ldhAggwataCyTs
	0KvcY/4e/bl84OkqDP+pK0ChW6cod/45dVd6jPjChX+qxsCoTXXRDFcj8vsWoNOLHO7SQ2mul5w
	WRGrBn/c1MiqSWjKifA98lBEgifdHwwaHy7zcgIWVEwSY97rDVinWhvx935hQbwBOUt4ACSzU1e
	aPpkMr4TjDMwHE6Qx0Vg2iNAywk9/xCLFQZqHqnbaPcRh4KkFwFRjlPNP0J3NN2NNubtso+UlUO
	e9drzJRWaM0TXj9XpwkmS/dPARhqJMCVOjRakOEO+NMjIGdOlfqnVAZ0XEjRaVnDkmhD
X-Google-Smtp-Source: AGHT+IGfCrSSl7R/KXziYtaZiURe4Q2LoD2JzA/Q35vX8li1kES5cZHcaCUMCmD7DvJe2GC3O1z9/Q==
X-Received: by 2002:a17:90b:5347:b0:311:e8cc:4255 with SMTP id 98e67ed59e1d1-318c930f93amr2620570a91.31.1751010594929;
        Fri, 27 Jun 2025 00:49:54 -0700 (PDT)
Received: from meet.. ([43.250.165.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e23aesm1673437a91.31.2025.06.27.00.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:49:54 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH 0/2] Add refs list subcommand
Date: Fri, 27 Jun 2025 13:19:32 +0530
Message-Id: <20250627074934.1761897-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces `git refs list` as a modern replacement for
`git for-each-ref`, as part of an effort to consolidate ref-related
functionality under a unified `git refs` command.

Git's ref-related operations are currently handled by several distinct
commands, such as `git show-ref`, `git for-each-ref`, `git update-ref`,
`git pack-refs`, etc. This distribution has a few practical drawbacks:

- Users need to rely on multiple commands for related tasks involving
  refs.

- The commands may differ slightly in behavior and option syntax,
  leading to inconsistency.

We propose a long-term consolidation effort to bring ref-related
subcommands under the umbrella of a single command: `git refs`.

The implementation of `git refs list` is functionally identical to `git
for-each-ref`. It reuses the same internal logic (cmd_for_each_ref) to
ensure complete backward compatibility. The purpose of this patch is not
to introduce new behavior but to provide an alternate entry point under
the consolidated `git refs` namespace.

The motivation behind this change is twofold:

- Consolidation: Centralizing ref-related operations makes them easier
  to discover, use, and maintain.

- Evolution: While the initial goal is parity with existing commands,
  this consolidation allows for careful reconsideration of which
  features are essential. Over time, we can:

  - Remove legacy or obscure options that are no longer needed.
  - Add improvements that wouldn't make sense to bolt onto legacy
    commands.
  - Offering a more consistent and user-friendly surface.

To verify backward compatibility, this patch also includes a test
`t/t1461-refs-list.sh`, which runs the full `t6300-for-each-ref.sh` test
using `git refs list`. The test uses ${GIT_REFS_LIST_CMD:-for-each-ref}
to allow substitution without duplicating tests.

This patch is deliberately conservative: it introduces no behavioral
changes and leaves `for-each-ref` untouched. The goal is to lay
groundwork and demonstrate viability of ref consolidation within `git
refs`.

Going forward, I'd like to initiate a discussion on what the ideal
surface of `git refs list` should look like. Which options and features
from `for-each-ref` should be carried over? Are there any that are
obsolete or overly niche? What improvements might be worth considering
now that we have a new, consolidated interface?

Feedback on this, especially from those who rely on `for-each-ref` in
scripts or tooling would be very helpful.


Meet Soni (2):
  builtin/refs: add list subcommand
  t: add test for git refs list subcommand

 Documentation/git-refs.adoc |  95 ++++++++++
 builtin/refs.c              | 110 ++++++++++++
 t/meson.build               |   1 +
 t/t1461-refs-list.sh        |   8 +
 t/t6300-for-each-ref.sh     | 333 ++++++++++++++++++------------------
 5 files changed, 384 insertions(+), 163 deletions(-)
 create mode 100755 t/t1461-refs-list.sh


base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
-- 
2.34.1

