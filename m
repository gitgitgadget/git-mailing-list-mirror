Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C912147E6
	for <git@vger.kernel.org>; Wed, 27 May 2026 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855855; cv=none; b=K2AUWa6fwNhzWS6DtsgpFjPZWFMqvjGT8SH2GxU7J5yIkaJyP3W0OKw/MTj2JH9i5kBC6f3zdPCOrKFLYW6F2qWXl5iXvuecO7bjpuAYI74T70Urpyh40c3UMuiLFkEWqNzLl4yasrx9XdG2g+uRnXTeeP4hvYtXkNLIMWmCSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855855; c=relaxed/simple;
	bh=wvPCytO/iDn4eeex49RPBpVuFdI/MUOykAV86Z53YQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sa4t6bwR/Z+ki4yQh9XQFCPiILv5DycINkYIDy6F7X6NVcYnR6IizjDH5odtiYFlvSnJV+5wrp2RL9XjVu+6Ni7iEeBzfv2XkdtILpHVmgPZ8SM5f8LodMLXTVsHVnxXGRgVj2PJWI1OCM42ixlV22R2xudbnstDQaZCERZ+bks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlPWwTyg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlPWwTyg"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8413ba03989so678202b3a.1
        for <git@vger.kernel.org>; Tue, 26 May 2026 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779855854; x=1780460654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47tVY0NB13PUY9lsnmIO3KxS1P7xGyMFRWJe5L8ZG10=;
        b=GlPWwTygWUdau94cYtzZh4OMEx0roaGINhuCHLiXaN0rf+09WI4zStLrhJI7rsEsI6
         2MudQXYi4DWrYH38m3j871v9nkwpxfkTjTP30Ft276St+UrMjybfXWiycGZRGF8FjOqu
         F+x77YCyAB6y1KCy7HDsq6LllQGT7vtbr0wezaYjRoT9yXiMU7WRtM6yxWTyjAr/cBY1
         xO5T/btlPZk8Ty1NRDJuunjrEa6MSPh4i8YbFIxnH0jTfs8OzeqbyMxr8phWkvysQiL+
         UwlfuTLpgBbMWZiN1ClXonEs169DwO/M5ckm7UPoTK7RbQhEacvHpjddm04odYFk/GOI
         ehRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779855854; x=1780460654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47tVY0NB13PUY9lsnmIO3KxS1P7xGyMFRWJe5L8ZG10=;
        b=WvHuSv3ac0WsN3ZYCqWsyLercAf2dKIxVyHqduGQ3rj1AI0XxF3BzjgnU6US+aY7MV
         NNpKSsD09PB3K3a3k84fExQ77A21OWq1KCIDJtx9ZFf3HteQe+8n1NjFQiPf+d1dzZgz
         nAmKrJgcQhpfKik2y5+S3+FNLRgPB/w2VFLp5SivL3XL8qE6DQE+PqD5hmFsMTV/9hRi
         j/kyvKZKaTAc+zXUIzegFicJTEicX2iK/Tar69ENJJR3SG3qw1sLbecXsD9H45QCgLmM
         0YP53yIJOQ7P+Vg2p7+I5BsB+NQGb58XDLkZCpEA+NewnmesHBIpugAhvKYJ5RjSL/nl
         uEsg==
X-Gm-Message-State: AOJu0YwOog/a6LACHiXiAdGgSO9mh8tJ8uIXdYR6CBCSS39x6NAtvYn9
	Z19/+0zpEeUJ8fP5BiNLIuofBkPEZGKP1VLA235VBlRs8kojv5DYN/jeqh6cLw==
X-Gm-Gg: Acq92OE/UxiQUyxwX5AHWtpkO3DzSkaQxqurAYmA8vJys0CD+ujTiAOf3za2vmpJe47
	rjzsug6uhgwl9zeqhuZyeTur8oagNGJod/sLz029lJ6Cmd4fR82L79Wr6a+PAQtHFB2DXc7JLlx
	rSAST7daUZ+LMoqFBWvA0qWZ8jTW4J+ONYIDJHGZ1KEnAOle+OQpKVcC54YMOklSdTKB65xnsOa
	tescuOnCmaOmcbA84PSsGv5Nh7NRYlFG3JtiVvwKazkuDAN/zPNFmHGxGUS8S4rrA2rccR/vYKf
	ScsaceSx/1NO97WA16Ln3Ysa4eXAKr/sdf6bzMbRkp2Va6xuVBcWvCHOZ/JMVMSW1+rqvXKHyWO
	ei9xxz24x44M2b7fX6THtKfd0SFzBN06v1Mir2bgi88M7bRIb3LQW+BP244xQjEgT5z9wCyMagx
	Sy9A15zsF51PBeHS63nJDtINs/zpJMWG9dPeALZSZ5r6qr0N9S1P2jEUzA7rocYp5+2fqex2wwc
	d+Gubljr1zTEq+hG0XIbCL+yZtE
X-Received: by 2002:a17:903:3850:b0:2ba:7374:76e7 with SMTP id d9443c01a7336-2beb03312ffmr120528365ad.0.1779855853749;
        Tue, 26 May 2026 21:24:13 -0700 (PDT)
Received: from localhost.localdomain (122x211x77x66.ap122.ftth.ucom.ne.jp. [122.211.77.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm135625495ad.65.2026.05.26.21.24.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 21:24:13 -0700 (PDT)
From: Keita Oda <ainsophyao@gmail.com>
To: git@vger.kernel.org
Cc: Keita ODA <ainsophyao@gmail.com>
Subject: [RFC PATCH 0/3] diff: pair edited lines inside moved blocks
Date: Wed, 27 May 2026 13:23:59 +0900
Message-Id: <20260527042402.13607-1-ainsophyao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keita ODA <ainsophyao@gmail.com>

This is an RFC for a review aid, not a proposed final UI or option name.

The motivation is the gap between --word-diff and --color-moved.
--word-diff is very useful when the line-level diff already found useful
old/new line pairs.  --color-moved is useful when moved lines are exact
matches.  But when a block is moved and one line inside the block is edited,
the small edit can be buried in a large delete/add region.

That case matters for review.  A one-line move is usually easy to inspect by
eye.  A ten-line moved block with a one-character change inside it is harder
to audit.  A small synthetic permission-table example in patch 3 uses this
shape:

  -#define PERM_RESOURCE_EXPORT       0x0008
  +#define PERM_RESOURCE_EXPORT       0x0001

That particular toy example is not meant to show something that
--color-moved cannot see.  It is meant to make the review question small:
can Git expose "this moved line was also edited" in a lightweight way?
The real-world cases below are less about proving that existing modes are
blind, and more about making the row-to-row correspondence explicit enough
that the small edits are easy to check.

This series adds an opt-in prototype, --word-diff-align, that post-processes
the emitted diff symbols and tries to pair similar deleted and inserted lines.
It does not change the underlying diff algorithm, patch semantics, apply, or
merge behavior.
The prototype is deliberately language-agnostic.  It does not parse source
code or build an AST; it only tokenizes diff lines into small text tokens and
scores local token overlap.  This keeps the experiment applicable to code,
tests, generated tables, documentation, and other text files.

The prototype is intentionally split into three pieces:

  * patch 1 adds the candidate retrieval and line-pair scoring, and exposes
    selected pairs with an RFC/debug comment;
  * patch 2 adds a small RFC-only renderer that inserts word-diff-like
    markers on the selected pairs, so that the recovered pairs are easier to
    inspect;
  * patch 3 adds a focused test case.

The current prototype is still larger than I would like, but the split keeps
the experimental pieces visible.  The full series is about 1000 inserted
lines; roughly 800 lines are option plumbing, tokenization, candidate
retrieval, scoring, pair selection, and debug comments, while about 200 lines
are temporary rendering code for review.

The scoring model is:

  S = W + aL

where W is a 5-line-window token overlap score and L is a center-line token
LCS score.  A small 64-bit window fingerprint is used only as a candidate
retrieval index; candidate pairs are scored again before they are selected.
Tokens repeated in the surrounding small window carry less weight for the
center-line score, which is a local-IDF-like approximation.  This keeps tokens
such as "import" or "#define" from overwhelming the line-specific identifier.

Some real-world examples that motivated the prototype:

  * CPython opcode/metadata renumbering, where many table rows stay logically
    paired but their numeric values shift;
  * CPython test parameterization rewrites such as tuple rows becoming
    dict(input=..., expected=...) rows;
  * Git's own expected-output tables, where a column width change adds spaces
    across many rows and a row insertion shifts the surrounding context;
  * Git's own remote.c refactoring, where extracted helper code has small
    identifier changes.

As a rough trigger-rate sanity check, I ran the prototype over 5734 changed
file pairs sampled from recent Git, CPython, and Rust history.  The stricter
"crossing and edited" signal, which ignores the many adjacent row pairs and
looks for pairs that cross another recovered pair, appeared in 739 file pairs
(about 13%).  This is not a gold-label quality number, but it suggests that
the mode is not only triggering on the synthetic test.
A small manual review found both clear wins and loose matches.

I found the problem easiest to inspect with four-way comparisons:

  * git diff --histogram
  * git diff --histogram --word-diff=plain
  * git diff --histogram --color-moved=blocks
  * git diff --histogram --word-diff-align

I put a small set of rendered four-way examples here:

  https://oda.github.io/git-diff-rfc-examples/rfc-word-diff-align/

These links are supplemental; the patch series is intended to be readable
without them.

Known limitations:

  * the UI/debug output is not final;
  * generated or boilerplate-heavy hunks, especially Rust generated test
    updates, can still produce loose matches;
  * one-line long-distance pairs are often less useful than block-level pairs;
  * the prototype intentionally gives local and remote pairs similar treatment
    for now, to make the recovered pairings visible for discussion;
  * thresholds and tie-breaking are still experimental.

The question for this RFC is whether this kind of language-agnostic line-pair
annotation is worth pursuing in core, and if so whether it should be shaped as
word-diff plumbing, a color-moved extension, or a separate opt-in mode.

Keita ODA (3):
  diff: add word-diff-align line pairing
  diff: render word-diff-align pairs for RFC review
  t4034: cover moved-and-edited word diff alignment

 diff.c                | 996 +++++++++++++++++++++++++++++++++++++++++-
 diff.h                |   1 +
 t/t4034-diff-words.sh |  46 ++
 3 files changed, 1035 insertions(+), 8 deletions(-)

-- 
2.39.3 (Apple Git-146)
