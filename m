Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0594274670;
	Mon, 27 Oct 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580697; cv=none; b=e5KyNsk7pTDMvOEFxbCdLWwZB/rkHnw0HX9Xrx2mpVscgHI0Jr5WQ84dTJEWpqAfSyNE0J6MVOwtaHJs7MBaeZNATO+MKHpIwACRzgtr1NX0N3O2vm10czF1slgbtYzWvkxhHo4srcn8kukE1WHoMGY2XiB/M8JPXpbl4miYq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580697; c=relaxed/simple;
	bh=S61BcdhjBlE8pNb7rtr3ZXpVmmZWi1rq36Z7ilkFXxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGaHBhMLxoozM/9YahsPj/XnwKKVhfrdwfE4Xf89u/w68UdfFfdYKh5HrWUmacbzw7D1N07TjhTiLh9C1LmXauXYVdLfiDEYemyZhy3uW4rL909ly2xaGYY3jTKzUQiv546EsJgx7wK+Rvytc++hS9GXeDm4fCVG8Ro+UZR3+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TgMpxXFY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KsAC8r09; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TgMpxXFY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KsAC8r09"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CB9DDEC0282;
	Mon, 27 Oct 2025 11:58:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 27 Oct 2025 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1761580694; x=1761667094; bh=tb
	eSHzXOk4TJB/30tlejhrTtGiyHoE1uNSmxqwrDiV4=; b=TgMpxXFY+MEN77+hSx
	P0Alr3HJYs1oLLyAXaVBPidVWeWSVC0KvJjL1ODtiZfEEaQ2eAWRds+wdDBBNArZ
	eug1+PsOxufdLCG6VZQESuvr6PcEtDZVUgG4ZU3J8DJn/7QSiYE/MpRz1wQQeV5S
	c2LREW68IeftK4TRzYde0mJSRMSl15U7k/WYJA9jdD93GTpmohlcxKQjNjpRCvKd
	PYaSUVVwE0OSLDo2aUlblNJ7l7IfTBUdxzfcgSYtdy++d/GzhaHN4qh11q5Z/1Ik
	epBidx2a9IOg2T23lcekWnHDBhWuppWbdi3qo9XEJ4q6Kw5prVgk+3GKPE9mmqxl
	9KnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1761580694; x=1761667094; bh=tbeSHzXOk4TJB/30tlejhrTtGiyH
	oE1uNSmxqwrDiV4=; b=KsAC8r09emYSoE7BNopqi7NQ22t00gWLZiSuz0h9QAb7
	oJsTsdITxby0JojZ6u7IyvMv+38nVU/1VPgNY/AjBbrx53xMQ7PJMpRVZaI+pFaU
	vmXKadKR19CAM6Fafbw256GDVhwWNINHhsaSz3jtMO0vL5mtUg8D6rC9RTJXE4Ku
	Damt06U449HwZPQC7bh+6wA6JpmKqhuy79fckpBp3AsDJ+a1fe16SXaEndCTTmKU
	v4oxuJxt+gSk4xmdV1dsfwokhewM3zKmX4O8N+xzeoUu55BSD/lVjZr/w9lUMy4o
	xUBYp3rxooPNkqaz3R4cOYazv45TbFwTufbbGZxxVg==
X-ME-Sender: <xms:lpb_aG_Bo4UFZFknNxH6et1YPQ2a6hOITiA-TQggmTjL0aANhTxXrQ>
    <xme:lpb_aINAeCDJ8DQyRX78MCeDqQJ7MqQGv2FQf860jt9-cQllBpQ0qMghm06JQEGGE
    WEJ6b3lX1QsaxIwUz3z1bTMczy8ZZzM9WlTRK6VXO8T338nrqwjlw>
X-ME-Received: <xmr:lpb_aMHmAiUcOE94C0alXSBIu3-2cM9f9CwweqQPRSA4abIk6Jdg0x7twpAxU_uDMGdbKzG-2Le6PiyE0QDUyTZYm3JM7OsdBhWy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtgeegtdevhfeivedvheegfffffeffgeeluefghfeftefghfejvdffgefffeeg
    heenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvghsohhurhgtvgdrtg
    homhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgv
    rhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehlfihnsehlfihnrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lpb_aOT_dXmrDj6n7abi8Hu6NRZhBKaoOE8tbRSFg5HC8Sm5hEageA>
    <xmx:lpb_aBsUjq_653spj0gd_ZK0loOFXKHak0tommZ-aJsWV278e6W9qw>
    <xmx:lpb_aOIS5E_r_oIW3sHRDwecH2-06NxrmtTOsFwOnlWvPFvc8RX8AA>
    <xmx:lpb_aOlwLpr3fm58Jg1dA0Uq-3geVWj4X_-7sR5EEZPpgc2piaSJKg>
    <xmx:lpb_aHHcxvD-OJAe1fx0ycVscfj-zTOb90sCwTsfb9DS5BavxhYR0ZzN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 11:58:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.51.2
Date: Mon, 27 Oct 2025 08:58:13 -0700
Message-ID: <xmqqjz0gjq0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The latest maintenance release Git v2.51.2 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.51.2'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git 2.51.2 Release Notes
========================

In addition to fixes for an unfortunate regression introduced in Git
2.51.1 that caused "git diff --quiet -w" to be not so quiet when there
are additions, deletions and conflicts, this maintenance release merges
more fixes/improvements that have landed on the master front, primarily
to make the CI part of the system a bit more robust.


Fixes since Git 2.51.1
----------------------

 * Recently we attempted to improve "git diff -w --quiet" and friends
   to handle cases where patch output would be suppressed, but it
   introduced a bug that emits unnecessary output, which has been
   corrected.

 * The code to squelch output from "git diff -w --name-status"
   etc. for paths that "git diff -w -p" would have stayed silent
   leaked output from dry-run patch generation, which has been
   corrected.

 * Windows "real-time monitoring" interferes with the execution of
   tests and affects negatively in both correctness and performance,
   which has been disabled in Gitlab CI.

 * An earlier addition to "git diff --no-index A B" to limit the
   output with pathspec after the two directories misbehaved when
   these directories were given with a trailing slash, which has been
   corrected.

 * The "--short" option of "git status" that meant output for humans
   and "-z" option to show NUL delimited output format did not mix
   well, and colored some but not all things.  The command has been
   updated to color all elements consistently in such a case.

 * Unicode width table update.

 * Recent OpenSSH creates the Unix domain socket to communicate with
   ssh-agent under $HOME instead of /tmp, which causes our test to
   fail doe to overly long pathname in our test environment, which has
   been worked around by using "ssh-agent -T".

Also contains various documentation updates, code cleanups and minor fixups.

----------------------------------------------------------------

Changes since v2.51.1 are as follows:

Jacob Keller (1):
      diff --no-index: fix logic for paths ending in '/'

Jeff King (2):
      diff: restore redirection to /dev/null for diff_from_contents
      status: make coloring of "-z --short" consistent

Johannes Schindelin (5):
      refs: forbid clang to complain about unreachable code
      build(deps): bump actions/download-artifact from 4 to 5
      build(deps): bump actions/checkout from 4 to 5
      build(deps): bump actions/setup-python from 5 to 6
      build(deps): bump actions/github-script from 7 to 8

Junio C Hamano (2):
      diff: make sure the other caller of diff_flush_patch_quietly() is silent
      Git 2.51.2

Kristoffer Haugsbakk (1):
      doc: fix accidental literal blocks

Patrick Steinhardt (2):
      gitlab-ci: disable realtime monitoring to unbreak Windows jobs
      t7528: work around ETOOMANY in OpenSSH 10.1 and newer

Solly (1):
      t2401: update path checks using test_path helpers

Torsten Bögershausen (1):
      unicode: update the width tables to Unicode 17

