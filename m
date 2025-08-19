Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB553115BD
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600968; cv=none; b=o2tv+QQfW6ClRaxlvL+aFvDGV+L8lF3Jd+srpEWq/jqlcdfl79+7ZYr8AeG/W6OgODygXtc6k08p0OaOEqAenIcRyA1WY1W3WOvvnPT0aMOHXX+SJDa4YQLXoR5BnVhj2sW4t7WKYW0dH23mUX3WIteyCrHPOBGj5LwhPKXPEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600968; c=relaxed/simple;
	bh=hlUGaZD+ebFjz4MZI2XPGHQq0YvNE+ZbHCxxWjO0jA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dQpjt7WVDUvQ+rD4ARizjXJvV4nGaG6D2VEZg61O+wh5/uEtITU/6xTRYbj4WvGpi4QxJjKLqABxZzHddI5R2qwgweQsVoDZ7By9YJ1zrVVwBnxEiJTa1kgj4kMZzoUKBGc5oreZYy7NRD/FigCx13YYoVXpeQ30yduUM6QZkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B+CAjLvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j86K9rDG; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B+CAjLvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j86K9rDG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 05A731D0020A
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 19 Aug 2025 06:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1755600963; x=1755687363; bh=euQf5qqIma
	4zRnPfHrHR0pj528hrdOp+1eB8/5BRt2E=; b=B+CAjLvvZ9MJ0tm5TqvvsobTAw
	MkiStQnFfrEbZ3YCkHP76ugEwHj9PgV1OLbIhOXr/XGP32jmz53OuffJ/LBUqnVr
	Ti6CfNaLzg0mI9WqExTp+ica8tIhofFcQC8M5Q17KxNCRcYBFYd6EL5POPM4ETd8
	81hvkzsBztkxKNDztor6+QyRFJNhn2I4erprf0QAaGwC7hW+VVTNG01FazbEMP58
	gv/nGoaGJ8ZCNqV25MXEF95jqgzYF16lfYSawv7JLc0jwEjVUfRRe1uRpV6Ugv+k
	9W6+9MaVz9WcYTR8kv5XFAB+oKQfrr1diV84luDp2iE9br0Mz2IYHqJ3iqvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755600963; x=1755687363; bh=euQf5qqIma4zRnPfHrHR0pj528hr
	dOp+1eB8/5BRt2E=; b=j86K9rDGvSp41HR5iNUgxQSYpwUK3iJ55vPuKtuaZhrP
	wzdVfmt7CmZpDnHowd0QflWbgDPIlu1n68vHIFjx42J9WNnabUSZ4DT/e9jYx1IT
	jtGWWLlQnqO0X771gfIj4nglCad/gMzIZSF9/og6BR0jnkMIYRFI5l++HmB3++Hn
	+FQsNHO/9Q+tZUoGFBmt6XPfvTGdMMARKvg0P5jXa2tfDx8KXOKqCrUtpfq9pAr5
	I7ZgwdWwraiHzYCcpnvuAhB2bAFzjuU1A91vbBW7YCPPINDlBzm2ZtG2OKXIc/gV
	bpMUfwp6LpvZyxttAP8spTDe1AvWYnZSnkOG4uRXAg==
X-ME-Sender: <xms:Q1ikaGmuPGXUDclF_dc-zwiB0s4_flRtdwJ4dUfPTdbj8UrJb1E9nQ>
    <xme:Q1ikaP0Dd_LQjoFxSYYGcxDF7MN5lxB2sN001HBmibpmvtssf1Otr6DnUovWJJK-e
    NF-pDbnUYgMTrxarg>
X-ME-Received: <xmr:Q1ikaOCB86UlmWR07U28Nmo0-TvzQcz32RVwJBqrY6P6wsnkGHwObtqy_MB9z7BI-v2ze1HGoLZcqEXhDMp4o1JYnwXKhH0bxFZJ0JFCC0O5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:Q1ikaMyBAgsXX1kug1eFHEin5W0VeAT0Fc_95kx2hTNkOMoxZCSywg>
    <xmx:Q1ikaMl4aUIbXJQWHml-cJj6D9uGOQ1GVYP89zUhwk8ZkkkB4MfPtQ>
    <xmx:Q1ikaBENuL9W8MqRekLeQauxigYA4nl_7Nx7XFhAJ-C6TghFdZhuow>
    <xmx:Q1ikaMV1Wp-etk3qeoqJLualHTIieDK21vnzV3Q-Jv4OHP7Bg-Y8BQ>
    <xmx:Q1ikaLuxQfNCY-TjcyksT8A6IJPYKVZNoqhULJUaPpyqAT2E-zL_Dru3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e4c9dce4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Date: Tue, 19 Aug 2025 12:55:56 +0200
Message-Id: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1YpGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NL3SQT3YLsYt2MzOKS/KJK3aTSzJySzDxdC2NjS4s0y0QD0zQDJaD
 mgqLUtMwKsMHRSkFuzkqxtbUAAbRCEG0AAAA=
X-Change-ID: 20250819-b4-pks-history-builtin-83398f9a05f0
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

over recent months I've been playing around with Jujutsu quite
frequently. While I still prefer using Git, there's been a couple
features in it that I really like and that I'd like to have in Git, as
well.

A copule of these features relate to history editing. Most importantly,
I really dig the following commands:

  - jj-abandon(1) to drop a specific commit from your history.

  - jj-absorb(1) to take some changes and automatically apply them to
    commits in your history that last modified the respective hunks.

  - jj-split(1) to split a commit into two.

  - jj-new(1) to insert a new commit after or before a specific other
    commit.

Not all of these commands can be ported directly into Git. jj-new(1) for
example doesn't really make a ton of sense for us, I'd claim. But some
of these commands _do_ make sense.

I thus had a look at implementing some of these commands in Git itself,
where the result is this patch series. Specifically, the following
commands are introduced by this patch series:

  - `git history drop` to drop a specific commit. This is basically the
    same as jj-abandon(1).

  - `git history reorder` to reorder a specific commit before or after
    another commit. This is inspired by jj-new(1).

  - `git history split` takes a commit and splits it into two. This is
    basically the same as jj-split(1).

If this is something we want to have I think it'd be just a starting
point. There's other commands that I think are quite common and that
might make sense to introduce eventually:

  - An equivalent to jj-absorb(1) would be awesome to have.

  - `git history reword` to change only the commit message of a specific
    commit.

  - `git history squash` to squash together multiple commits into one.

In the end, I'd like us to learn from what people like about Jujutsu and
apply those learnings to Git. We won't be able to apply all learnings
from Jujutsu, as the workflow is quite different there due to the lack
of the index. But other things we certainly can apply to Git directly.

Note: This patch series currently builds on the cherry-pick infra.
As such, when one hits a merge conflict one needs to `git cherry-pick
--continue`, which is quite suboptimal. I didn't want to overpolish this
series before getting some feedback, but it is something I'll fix in
subsequent versions. Furthermore, the command for now bails out in the
case where there's any merge commits in the history that is being
rewritten. This is another restriction that can be lifted in the future.

Thanks!

Patrick

---
Patrick Steinhardt (11):
      sequencer: optionally skip printing commit summary
      sequencer: add option to rewind HEAD after picking commits
      cache-tree: allow writing in-memory index as tree
      builtin: add new "history" command
      builtin/history: implement "drop" subcommand
      builtin/history: implement "reorder" subcommand
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      builtin/history: implement "split" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc | 159 ++++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   1 +
 add-interactive.c              | 151 +++------
 add-interactive.h              |  43 +--
 add-patch.c                    | 271 ++++++++++++++--
 add-patch.h                    |  61 ++++
 builtin.h                      |   1 +
 builtin/add.c                  |  22 +-
 builtin/checkout.c             |   7 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 691 +++++++++++++++++++++++++++++++++++++++++
 builtin/reset.c                |  16 +-
 builtin/stash.c                |  46 +--
 cache-tree.c                   |   5 +-
 cache-tree.h                   |   3 +-
 commit.h                       |   2 +-
 git.c                          |   1 +
 meson.build                    |   1 +
 sequencer.c                    |  36 ++-
 sequencer.h                    |   4 +
 t/meson.build                  |   5 +-
 t/t3450-history-drop.sh        | 127 ++++++++
 t/t3451-history-reorder.sh     | 218 +++++++++++++
 t/t3452-history-split.sh       | 304 ++++++++++++++++++
 26 files changed, 1947 insertions(+), 246 deletions(-)


---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

