Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE53A2569
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073772; cv=none; b=GHklMm8ZEct60I+yt80lT+wsdk/G0cVm+PDQxeEOb49Mn13xwSG/svsfBRrS0VEZpmjLZBRNl6QDdsTkl9XsUmQJnqH1Wl5XDaNZpisyD1zbJLNfgh+3Tk5vxXu7CF67ruxywHoj8gkb6pK8iqxWoy5TPRZMuGYIP4nCHjmse60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073772; c=relaxed/simple;
	bh=Q/QSASH4969F7SbltRjeRkekpdrC5vHiIUw6Gz6hB2Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p3bnb9vGkMRetExfENkfQkjnUPNskZdBv56PvFXgAcepAmO8X6Z9vjHdT6gDwL9EnKO+mpFBNWA25L37rDJ/YfLpgZZqc3VhFuKydRIHRo+/h1BFNJf84xM7HSXKitgAHgY5U8MK+dGWEK0y51b9n+ylgEEdz/U+Zk4jAPIAAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vm6e3faB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6XiBXvB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vm6e3faB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6XiBXvB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE5F1140011B;
	Mon, 13 Apr 2026 05:49:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Apr 2026 05:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1776073769; x=1776160169; bh=a07rvLnRMQ
	Yjs51ILEKQP+gEh3ZP1koFx7Fsa8oKxMc=; b=vm6e3faB1duJ4Fj7Dymtd3kafn
	1bRT4P+fpcHtVfW3OrKXHpZ1Y8p1EIPyvS5oNtCigN7zedOG8Zz8AElH2Q548KLr
	40+IoQly49DcUbKFRcM6pzsG2HWQS7pp99/GnDvDm8g6cLYXqcVYZjF82hmLmKNd
	8JZkULbnlE72NU0nkVu9UH3TDpo/5efTGXpyPI2DVtIf0wAphU7KZ7M+Mvr+LNFH
	qmxohMSaTqmopOStp6GEBIf85AXSm7vZ30DhR71+bL4XphvLd5/8P4qrRFPuzK6B
	9QxBgJsu2lNCVgX0VB5jMmQjtZRM5W9wiyuhP9qwh3jr1HQSrmwYRbjpWBtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776073769; x=1776160169; bh=a07rvLnRMQYjs51ILEKQP+gEh3ZP
	1koFx7Fsa8oKxMc=; b=n6XiBXvBXYAjyWriAo7ob2zDuQuYHNCUcPdpshxx5/42
	r1zIlzRrfyOAQgiZfs1RyLzIMWH5Tl4jmiNmkliYoOgUR1z4s1QN9+qEt6SQCX0m
	apwfaQsEZqqtKRqs+UCk+8YIlVkZR3jM3fZsPFtTAiZv2ay7G00sz1cIPH+Bl8TK
	m2goXd8MUPlrqEEMaIRXGz/raEzH7OIQ8fgjopDRRfR+CSVDFeT+C4AWR6AELX0p
	Mskds5ABZzedz5IZsfN6l0qIMwwa8kYVRXxLwYhxhBhp9gwhfX0NS8JAhUptD9TI
	xGi8XQ5bllCvodCcQutf7iJvzL2XaoRvzBoxYMQ+sg==
X-ME-Sender: <xms:KbzcabsYAJSIEMc4ycQd0T5SsA6wl4kaZGfL6vAP3tSUQyuwonslRA>
    <xme:KbzcaScpOulm6rTZ3owhe1RXTlSvL8L9MJRc9GyvimyVUPVc_hw12iZj-DRPv84Da
    D4z9f0kwr5KQ20OYZRqeroYKRIL4qW3KSVU-XgTXkNbemznUIskEw>
X-ME-Received: <xmr:KbzcacaF-YQBUaNjd9kGvOT9ZrUiLAa4LrEqEnJmcXg5r69SmPMkKttMi8sRdTxoF0vIdy2H-YfZCJJQJD3QucVFc3Q94H3faaGDrSOJ0FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeiveegffdvleekudekvdefveelvdfgleegveeije
    dttefffeegkeegkedtgffgieenucffohhmrghinhephhhtthhpugdrshhhnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:KbzcaVUi0PrxwtkLYq0q5rpUEmscSDrb-GcFaljJ6tr-gOLloWx9sg>
    <xmx:Kbzcaeh5mQ_-vvClWM6FWXepnQ03qMGvpURcvRLYEc6KHdmVZ6f8sg>
    <xmx:KbzcaTVDV7ePZcLuE2TPy7zKL34jrTnaIplPQJbBRFnlzVO8GNZTVg>
    <xmx:KbzcaVPu-TzKQ6jNFG_VqQk7CGN1cGMJdIwZ69cGMe_qKtqvr_1Y7w>
    <xmx:KbzcaXEgb6--GT2h7iZv9LgzWpgeDiz087GwVZevOhgwb9a_MZqIYrAm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75efc5e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/12] t: detect errors outside of test cases
Date: Mon, 13 Apr 2026 11:49:21 +0200
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACK83GkC/yXMQQ6CMBBG4auQWTtJWytGr2JYUPyF0QRJZ0ATw
 t2tuvwW762kyAKlc7VSxiIqz7HA7yrqhnbswXItpuBC7aJ3nCJPD2WDmvJLbGCFMXjfIh5PKcR
 08FTqKeMm79/50vytc7qjs++Otu0Do/FpDHsAAAA=
X-Change-ID: 20260410-b4-pks-tests-with-set-e-3ae479b24b51
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

Hi,

this is a follow-up to the recent discussion we had around `set -e` to
make our tests more robust and basically supersedes Junio's [1].

I've tested the patches with both Bash and Dash, and all tests are
passing on my machine with both of them. CI seems to be happy, as
well. But I would expect that this change probably has some fallout,
even though I hope that it's generally going to be small and contained.

This series is based on 8c9303b1ff (Merge branch
'jc/no-writev-does-not-work', 2026-04-10).

Thanks!

Patrick

[1]: <20260325062114.2067946-1-gitster@pobox.com>

---
Patrick Steinhardt (12):
      t: prepare `test_match_signal ()` calls for `set -e`
      t: prepare `test_must_fail ()` for `set -e`
      t: prepare `stop_git_daemon ()` for `set -e`
      t: prepare `git config --unset` calls for `set -e`
      t: prepare conditional test execution for `set -e`
      t: prepare execution of potentially failing commands for `set -e`
      t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
      t0008: silence error in subshell when using `grep -v`
      t1301: don't fail in case setfacl(1) doesn't exist or fails
      t6002: fix use of `expr` with `set -e`
      t9902: fix use of `read` with `set -e`
      t: detect errors outside of test cases

 t/lib-git-daemon.sh                | 13 ++++++++++---
 t/lib-git-svn.sh                   |  3 +--
 t/lib-httpd.sh                     |  3 +--
 t/t0005-signals.sh                 |  4 ++--
 t/t0008-ignores.sh                 |  4 ++--
 t/t1301-shared-repo.sh             |  2 +-
 t/t3600-rm.sh                      |  2 +-
 t/t4032-diff-inter-hunk-context.sh | 14 ++++++++------
 t/t6002-rev-list-bisect.sh         | 17 ++++++++++-------
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 t/t7508-status.sh                  |  4 ++--
 t/t9138-git-svn-authors-prog.sh    |  4 ++--
 t/t9200-git-cvsexportcommit.sh     |  3 +--
 t/t9400-git-cvsserver-server.sh    |  5 +++--
 t/t9401-git-cvsserver-crlf.sh      |  4 ++--
 t/t9402-git-cvsserver-refs.sh      |  4 ++--
 t/t9902-completion.sh              |  2 +-
 t/test-lib-functions.sh            | 12 ++++++++----
 t/test-lib.sh                      |  8 ++++++--
 19 files changed, 76 insertions(+), 56 deletions(-)


---
base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
change-id: 20260410-b4-pks-tests-with-set-e-3ae479b24b51

