Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26033B3C0E
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812017; cv=pass; b=GZJwZC2gxDGMi3r4FtLWKlzlQiHqt3WhyJRD/JdFgaFe7wKRJqv5lsk3gqTENuBtIOsvO5SKi2028eVfuyF/bQT7LMRQcYUD0sGLCIvVD0NCjSrUSbhd8c2ANiHyBPCw6Np75W0pchJqBhe8WUjW1+QBOk3h3X7X0M1G+xxuVfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812017; c=relaxed/simple;
	bh=sdazTCjX5PKu/RUX9hr6/+G0Ral3JyWP+GGFE7i6Pqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDP5/6H9qNeVPIKf9RXAYTPI5On1QdqEWx/k0kaYtlqKL+0JkH2fic0cvZyC7yCCYQdMKRW5NgPnQld5vcB7gX63cR8lHO7+LqEXQmx4pf48S2qwRFNqy2T5fp0auJB2d9HRYFewfYwuZ4ySJUSb3absSaW4jIWFYupgvR9NmIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=K6DhrzqP; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="K6DhrzqP"
ARC-Seal: i=1; a=rsa-sha256; t=1775811994; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c5gSNP0HwT8OzRRQ1NKVnUzrKKInpQGEpiloAwJe/kgnUK5ZYE8WTCOmIHgxSSO11hw1BjMembfQyslsHnRKCwCvLVxVJntafZ/Y20kRZaxQ3YRSfgfcz/NmoxwByMYvcRU+nY9Byi3KF21J7H5E+6z3nnCCiS0gfUHH6U6G8g4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775811994; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vAb62JUYrNnOjOW71hvxsJ7sR3GtIIYSIMvtBRN5IE0=; 
	b=XDDqx3fL01EFz++ZzPmHDIGyzOqk+hK7a6r/M47bXsWluq2qxJAtWJxiy5eDtXNnJQMERjzmouVT7RM316MSZ6Alvi3Z0Y5T+3ZaJU/73go8BNQJFVvyn92FbTmKYKagGh0h7rB5JyIM4peGGE7dfNS8PpZ7WTm7XLMsZQbbynA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775811994;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vAb62JUYrNnOjOW71hvxsJ7sR3GtIIYSIMvtBRN5IE0=;
	b=K6DhrzqPBpoP2mJwFPPgxGEBXWYdrycX+xt+QNQ9MQClHVzgxp8V+SmZ2gpGBVgw
	rEcrFe0PVikSd+DZjbCvDzKReSsXTQ1n7+qbOdcjQh0GqmP8L0bpBWBuGyVG5qeWA+s
	8BG3lH9nIXQxDKf7mcdTKzJlAQbUYo/3kgG7RuBw=
Received: by mx.zohomail.com with SMTPS id 1775811992652837.6680489237962;
	Fri, 10 Apr 2026 02:06:32 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 00/13] Run hooks in parallel
Date: Fri, 10 Apr 2026 12:05:55 +0300
Message-ID: <20260410090608.75283-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This series enables running hook commands in parallel and is based
on the latest master branch. It requires commit 2226ffaacd
(run_processes_parallel(): fix order of sigpipe handling, 2026-04-08)
from master.

v7 is a minor refresh which includes a new parallel test contributed
by Jeff King to test the bugfix above which landed recently on master.

Branch is pushed to GitHub:
https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v7

Successful CI run:
https://github.com/10ne1/git/actions/runs/24234022244

Changes in v7:
* Apply Jeff's patch as the 13'th commit in this series, slightly
  rewording it and moving the test at Jeff's suggestion (Adrian)

Range-diff v6 -> v7:
 1:  b79b6d4d92 =  1:  c361429e4d repository: fix repo_init() memleak due to missing _clear()
 2:  04d70c5fe6 =  2:  96d11e8a82 config: add a repo_config_get_uint() helper
 3:  9d52e73211 =  3:  d7972c7557 hook: parse the hook.jobs config
 4:  fa52e229e6 =  4:  6fb33026da hook: allow parallel hook execution
 5:  255e87fe42 =  5:  d5d56c2753 hook: allow pre-push parallel execution
 6:  eb60a9effe =  6:  48584cf296 hook: mark non-parallelizable hooks
 7:  44eaa1b5eb =  7:  2606af97ad hook: add -j/--jobs option to git hook run
 8:  dcd7f91d96 =  8:  950f4dca9f hook: add per-event jobs config
 9:  7b1513b648 =  9:  4a9e0ec914 hook: warn when hook.<friendly-name>.jobs is set
10:  1a808c35c3 = 10:  aa1583ba65 hook: move is_known_hook() to hook.c for wider use
11:  a5d37a0ea1 = 11:  3f70f2c2bf hook: add hook.<event>.enabled switch
12:  136cd50cea = 12:  56e66c409d hook: allow hook.jobs=-1 to use all available CPU cores
 -:  ---------- > 13:  044996431a t1800: test SIGPIPE with parallel hooks

Adrian Ratiu (9):
  repository: fix repo_init() memleak due to missing _clear()
  config: add a repo_config_get_uint() helper
  hook: parse the hook.jobs config
  hook: allow pre-push parallel execution
  hook: add per-event jobs config
  hook: warn when hook.<friendly-name>.jobs is set
  hook: move is_known_hook() to hook.c for wider use
  hook: add hook.<event>.enabled switch
  hook: allow hook.jobs=-1 to use all available CPU cores

Emily Shaffer (3):
  hook: allow parallel hook execution
  hook: mark non-parallelizable hooks
  hook: add -j/--jobs option to git hook run

Jeff King (1):
  t1800: test SIGPIPE with parallel hooks

 Documentation/config/hook.adoc |  76 +++++
 Documentation/git-hook.adoc    |  23 +-
 Makefile                       |   2 +-
 builtin/am.c                   |   8 +-
 builtin/checkout.c             |  19 +-
 builtin/clone.c                |   6 +-
 builtin/hook.c                 |  46 ++-
 builtin/receive-pack.c         |   3 +-
 builtin/worktree.c             |   2 +-
 commit.c                       |   2 +-
 config.c                       |  28 ++
 config.h                       |  13 +
 hook.c                         | 286 +++++++++++++++-
 hook.h                         |  38 ++-
 meson.build                    |  24 +-
 parse.c                        |   9 +
 parse.h                        |   1 +
 repository.c                   |   3 +
 repository.h                   |  10 +
 t/t1800-hook.sh                | 584 ++++++++++++++++++++++++++++++++-
 transport.c                    |   6 +-
 21 files changed, 1119 insertions(+), 70 deletions(-)

-- 
2.52.0

