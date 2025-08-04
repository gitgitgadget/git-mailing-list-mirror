Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7292E55B
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299385; cv=none; b=OuEvqcND8vsy2m8TocUW5cz8jntRFvnKUHwrOE6XShW+DIIT888o2wd94Z6gvbRoCz2Kdos4LoGj+XNyNdJ+IaQlgU58HKarfHHL7yVgs5VCsjilqadvTbFI/GaVoA3KdroFE6FyKlcrcRdmRlRE64ftoQVEimGyv+UaKjq3nBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299385; c=relaxed/simple;
	bh=c0FbflyQpFPGmNDUSnUtOKD7+y/C0lj7fu4wMjw/0aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6cLE99eX1uj4aYmkyqI5PrFhwzPf9OltZN93OQIF/n8BPagkZR71YV3yNfBwrSTlc2PTD5W8/96Q9N5ZTY1DXo4BZlRZo7UQaQh6El60eK4D5mFQfHuuKDRikK+wbWqO6HXYfmuEdf9V8p91J6fVKYqWhI6g36mc2VyzJnIYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbr/FfOO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbr/FfOO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2403ca0313aso32378505ad.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299383; x=1754904183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JLVDTWU8B1pqTRBopmvo/GUqlVlISWASxk3Pmjpj8s=;
        b=kbr/FfOOU3SGGxdBDgotnQP666rn8+CnwT8940sDo7ccuHLFyLUaRmecNsDNhlJe66
         //AfOpSxRTMRX5vA098qO9euTiTYVnLi+pwRJWALY88pxV+8m/dGX7puJRAvsYehg4A9
         +qPzmYYkKexuzFvNu/tPzyRSgX5sW9z71Mm57zeln5QWAGrTMXMmn0trJTgRSAS314z2
         QdBqReFXqbJf0aehqJqfdvNuyL/uw1WnskylBYvxxbr2Up1mQUWxlbS3eHvXnQy8mR2M
         nuySMWVUx2bzoTw10QEqTMa7pl+uit2zgaMXQtqt5Ek4Q7iDVOfNstbjZrT1l3OL1Hn7
         tq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299383; x=1754904183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JLVDTWU8B1pqTRBopmvo/GUqlVlISWASxk3Pmjpj8s=;
        b=lsG07W7UNq8WNugyCBnaAAUf+L4MbqOGtiWvXunjS64tlJSakyDRQsQriRbAEB2pqB
         FNylP9tDR4XhbUaXOKJUAhc3k1H5iG5fumgS56XM/IoG4Qba8fVVczguax9bGHDSViKn
         gVbUZtJ6C+BO+0m5u78y0ulNgcCOxoDn8P7hFAsn42oz7pa5wTaVmgtKfV5StdECZawU
         a1TVMNcvNHJssLbWUqu1UsKJsP5klmqAAAau7wpzXQT5LxHoRn0bUEhLEppdfVc3yFoR
         eYG2EUYxAv4SZVcc33TwvkP9rDpN0uADeJ84GAyWnmQ0nH019LSjK8x3OnSjkjv8UjVH
         oU/w==
X-Gm-Message-State: AOJu0YzGgZMYtd1u8WHgBpcXTiIGjwHVFLzG+j7TKe2nUYM8ZtHAYgWA
	wVo+WWW2RvoXwlK6w30YayBqzuAxfAFKuDS8KC10prUb7irgUrgL5Wcero24UMTl
X-Gm-Gg: ASbGncuML3aTuv1llUqcAHOMDea3zOjeWLwxEPijuQT518NkurnjQpVIYDLWQIjfTJc
	uYZTCdABXpxt1oKrs52mF2A1wQOCZgZs9l6Murfwvy/BXs+KJjm4llBf9GO9aVSl5K7nQanuI0L
	l4JAuRBTh9cUbCJWBugO1OUa+ogGu382Jl61naGp67JQNPsbIy152hAMbymwx2OHkrsKl67k5Wg
	Hc2YUXqG8rGhE4XzAK+4nPRTU42wDfO3ajAgt4+tbnG0ABxZf9e5nhl+skJIYkFPzXMMrDiGFu9
	/L81v1CTcQZyh88TJ9sot64xwlexkGL0soEjMwJhdSdCVdxux2Ly7gEYO7yoUm1v47R4+0Aan4g
	tzTx/BvH6b7ZyegPRx0sp96iS+4WKWA==
X-Google-Smtp-Source: AGHT+IFuTMIjoDuevdmRno8n/7gKKBiLNPvDG4ph9JdewEN7feJ/keyDoZhEgMeVsQOInXykpDgMng==
X-Received: by 2002:a17:902:e54a:b0:240:2145:e53b with SMTP id d9443c01a7336-24246f564b7mr114358935ad.9.1754299382659;
        Mon, 04 Aug 2025 02:23:02 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c62sm106205565ad.4.2025.08.04.02.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:23:01 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH v5 0/6] Add refs list subcommand
Date: Mon,  4 Aug 2025 14:52:49 +0530
Message-Id: <20250804092255.1092973-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731090040.1625303-1-meetsoni3017@gmail.com>
References: <20250731090040.1625303-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Everyone,

This is the fifth version of the patch series that introduces the git
refs list subcommand.

changes in v5:
  - moved changes that fixed the test into a separate commit.

---
(v1 cover-letter text)

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

Meet Soni (6):
  doc: factor out common option
  builtin/for-each-ref: align usage string with the man page
  builtin/for-each-ref: factor out core logic into a helper
  builtin/refs: add list subcommand
  t6300: refactor tests to be shareable
  t: add test for git refs list subcommand

 Documentation/for-each-ref-options.adoc |   79 +
 Documentation/git-for-each-ref.adoc     |   80 +-
 Documentation/git-refs.adoc             |   16 +
 builtin/for-each-ref.c                  |   35 +-
 builtin/refs.c                          |   14 +
 for-each-ref.h                          |   26 +
 t/for-each-ref-tests.sh                 | 2141 +++++++++++++++++++++++
 t/meson.build                           |    1 +
 t/t0450/adoc-help-mismatches            |    1 -
 t/t1461-refs-list.sh                    |    8 +
 t/t6300-for-each-ref.sh                 | 2140 +---------------------
 11 files changed, 2307 insertions(+), 2234 deletions(-)
 create mode 100644 Documentation/for-each-ref-options.adoc
 create mode 100644 for-each-ref.h
 create mode 100644 t/for-each-ref-tests.sh
 create mode 100755 t/t1461-refs-list.sh

Range-diff against v4:
1:  d2fa47a2b9 = 1:  d2fa47a2b9 doc: factor out common option
-:  ---------- > 2:  48a006dca9 builtin/for-each-ref: align usage string with the man page
2:  5084db4d14 ! 3:  b7788d477a builtin/for-each-ref: factor out core logic into a helper
    @@ Commit message
     
      ## builtin/for-each-ref.c ##
     @@
    - #include "ref-filter.h"
    + #include "builtin.h"
    + #include "commit.h"
    + #include "config.h"
    ++#include "for-each-ref.h"
    + #include "gettext.h"
    + #include "object.h"
    + #include "parse-options.h"
    +@@
      #include "strbuf.h"
      #include "strvec.h"
    -+#include "for-each-ref.h"
      
    +-#define COMMON_USAGE_FOR_EACH_REF \
    +-	"[--count=<count>] [--shell|--perl|--python|--tcl]\n" \
    +-	"                         [(--sort=<key>)...] [--format=<format>]\n" \
    +-	"                         [--include-root-refs] [ --stdin | <pattern>... ]\n" \
    +-	"                         [--points-at=<object>]\n" \
    +-	"                         [--merged[=<object>]] [--no-merged[=<object>]]\n" \
    +-	"                         [--contains[=<object>]] [--no-contains[=<object>]]\n" \
    +-	"                         [--exclude=<pattern> ...]"
    +-
     -static char const * const for_each_ref_usage[] = {
    --	N_("git for-each-ref [<options>] [<pattern>]"),
    --	N_("git for-each-ref [--points-at <object>]"),
    --	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
    --	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
    +-	"git for-each-ref " COMMON_USAGE_FOR_EACH_REF,
     -	NULL
     -};
     -
    @@ for-each-ref.h (new)
     +#ifndef FOR_EACH_REF_H
     +#define FOR_EACH_REF_H
     +
    ++struct repository;
    ++
     +/*
     + * Shared usage string for options common to git-for-each-ref(1)
     + * and git-refs-list(1). The command-specific part (e.g., "git refs list ")
    @@ for-each-ref.h (new)
     +		      struct repository *repo, const char *const *usage);
     +
     +#endif /* FOR_EACH_REF_H */
    -
    - ## t/t0450/adoc-help-mismatches ##
    -@@ t/t0450/adoc-help-mismatches: fast-export
    - fast-import
    - fetch-pack
    - fmt-merge-msg
    --for-each-ref
    - format-patch
    - fsck-objects
    - fsmonitor--daemon
3:  1a15cd454b = 4:  97088dab96 builtin/refs: add list subcommand
4:  29c41d682b = 5:  abe9df9c4f t6300: refactor tests to be shareable
5:  0fd1f714c9 = 6:  a037a47dcd t: add test for git refs list subcommand
-- 
2.34.1

