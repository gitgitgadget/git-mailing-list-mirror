Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9237F735
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423062; cv=none; b=JkIq6+T6hyXAzNIHu8buPLRoQuNxR//a92v3VFmGx710l1qNihxaxC4AXOH86xUk3a9dGjXVuUYb3D3O3tHstKRKKxk2b2R3GW/63Mj7efMcRiJeHuMKJ4zxFTcYgZdUJ+nNJCdJBm2kh96Yq/i6LJDPGU7BBr+Nj/UePEGHpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423062; c=relaxed/simple;
	bh=EXg08j7sb9nDeZvSawhqkLBQ6NoJ7ClExWk968Jtbfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ncE6rxmmx0jlRYY4VJm2QGNbufczF9wNewt/v09vfWBVXtLf+KjlPGfqVaRt3kPmDdcwU2LDxhzOo5dvA5YarcBIWNDB7WjHaJpaqi9VgbEE8ucn/pO3VinRRPMxNiebcQghmBRpxDe6r9UXJZHSMDUK9bB/d6KT20QHVOFMNRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jxjw4ner; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U6l8Jz6T; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jxjw4ner";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U6l8Jz6T"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85ECB140008A;
	Fri, 17 Apr 2026 06:50:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Apr 2026 06:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423059;
	 x=1776509459; bh=RASbEe8KUORb23LyBaZxzt+GiBwzw0DlRr7diYQDPOc=; b=
	jxjw4nerc0Yg7XAErEciR6YFm8zlArM/ULvOYcRxqWhUkpPTXNYF6WPN7Gy+q5Xn
	t4R2HNbXqhUMsOKCjwy1WCH9rVM5OJA/uImNQNMxxFKwu393VTK1hLLc0q010S9R
	qjYM2WNim/Nb5aT2KHUOr+DVa6+A9+adwMvDurVTmhA1bNcKrLDeDHHyXpDNpspE
	wb3Xa+Uaz4sdOJfDJsR2UOgBJoMVWqvuHJ3UTPPi/ygCn0rPaLriyo6bC30R06iI
	Lii7I8sKXnFHbWsJHyhhA3mK5GXI+TMNAczEGuZyUhHkWqoWXEjT6gGJwJNNySeM
	RDyPEfPwkngWWZMkm0+fzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423059; x=
	1776509459; bh=RASbEe8KUORb23LyBaZxzt+GiBwzw0DlRr7diYQDPOc=; b=U
	6l8Jz6THB72xeKZ5xuiflL1Tg1w80IlgwFGvs4hm3kST7q/0B2QbHeKHP0PmZ5lk
	0zVeuHAstjJ8ltsrHpNGKNbFoVaibhu6l4gcfG/QRlYH9ibMaIh+baNRLAqcAGQm
	jYZa4+2ZCjQVFhnk+ZSx7fmwLNFghm4riS41ICEe1W6/rGB9YUaWPKUPDbrkwY7z
	dNIgEm6ZzabP3Ci4FpkcKKcv3wxELcSJGOySG0oaQ9D5rUtq4Ty3GOk50ODCuHz/
	H7t3U1leiAVEmFn7BlQwgHAay/CIrmH9rS8yBYAuNOeCOn6v0bk7ZOaP0IK7P6GR
	RAd72dBze4nWrH085aMNA==
X-ME-Sender: <xms:kxDiaeAnuq1muxVPHVVRRPEZt6p-hJVpSZXXa8UbMQ6204e496Sbfg>
    <xme:kxDiafj6xJ23b25Jp0Lg-is6AJbV9w-B4SXxBoK4i-fuOpSi1BDvxlAWsk86sLzBc
    bRJHjJlLVf--rk8M629dTOgOG5G9-5BLRRi86xQM-tD-xUddqevSw>
X-ME-Received: <xmr:kxDiaWm54wAgAYMrsY0DF0J2X_3wTPD4VvaLbuW-LFNyMLyuQjTAOdx1WqIlmWzS3j0NHCPA6EiS_ndUQotNcA_V-3Vw_1o5Si_8qTBw6xyu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvleetjeeggfdvfeeutdejfeejhfehteeuje
    dvkeffiefgleffgfeijeeiteekleenucffohhmrghinhepmhhsghhiugdrlhhinhhkpdhg
    ihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kxDiabpVds1MYiC9sbODzybgyNzXj5TSFcIMHtUL49_QAYEX6oJ2ng>
    <xmx:kxDiafHRIM3dACJBmlKcZ0Ljw15BoxNBYVfSeDUqPtf-bhBJw5yswA>
    <xmx:kxDiaXw3WqpOi9uCCoswS-xbp45YrF3PoHPOL6yb659sfy9fvkssIQ>
    <xmx:kxDiaUobfsxkVmVXQpQFXBrQPN3Of2pFYUzsxqM3TC6i2wRYM6X-iA>
    <xmx:kxDiaQgq-1ToBmyd8PM1stR1gXWM3cC5fgi8dGMlvxYrOFjI6MF_H0x1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:50:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 677dd3a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:50:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/12] t: detect errors outside of test cases
Date: Fri, 17 Apr 2026 12:50:46 +0200
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIcQ4mkC/3XNzQ6CMBAE4FcxPbumP1sQT76H8dDCKtWohK2oI
 by7RaPRA8dJZr7pBVMbiMVq1ouWusDhck4B5zNR1u68JwhVykJLnUlUEjxCc2SIxJHhFmINTBE
 IjCPMC6/RWyXSumlpF+4vebN9Z776A5Vx5MZGHThe2sfrulNj7/NiJl86BRKsX5o8M07SEtept
 ggnMV50+hex04hOCBIWEl2R7ZT9Q8wvkk0jJiG5KyTZqixdVX2RYRieGYJOZFcBAAA=
X-Change-ID: 20260410-b4-pks-tests-with-set-e-3ae479b24b51
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

I've created an MR with GitLab [2] and a PR with GitHub [3] to verify
that these changes work on both platforms.

Changes in v4:
  - Simplify how we read a multi-line variable value.
  - Link to v3: https://patch.msgid.link/20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im

Changes in v3:
  - Adapt `linux-TEST-vars` job to use Bash instead of Dash. Ubuntu
    packet mirrors seem to be having problems, so I wasn't able to get
    past installing dependencies in any jobs. All to say that I couldn't
    verify that this works as expected :/
  - Link to v2: https://patch.msgid.link/20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im

Changes in v2:
  - Use `ret=0; $command || ret=$?` pattern.
  - Restore `echo 0` in SIGPIPE tests.
  - Fix "lib-git-svn.sh" to gracefully handle the case where SVN Perl
    modules aren't installed.
  - Use `|| :` consistently instead of `|| true`.
  - Fix up a couple of tests that fail on FreeBSD 15. The test suite is
    now passing on this system, too.
  - Only enable `set -e` on Bash 5 and newer.
  - Link to v1: https://patch.msgid.link/20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im

Thanks!

Patrick

[1]: <20260325062114.2067946-1-gitster@pobox.com>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/541
[3]: https://github.com/git/git/pull/2270

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

 ci/run-build-and-tests.sh          |  5 +++++
 t/lib-git-daemon.sh                |  8 +++++---
 t/lib-git-svn.sh                   |  7 +++----
 t/lib-httpd.sh                     |  3 +--
 t/t0005-signals.sh                 |  4 ++--
 t/t0008-ignores.sh                 |  4 ++--
 t/t1301-shared-repo.sh             |  2 +-
 t/t3600-rm.sh                      |  2 +-
 t/t3901-i18n-patch.sh              |  3 ++-
 t/t4032-diff-inter-hunk-context.sh | 14 ++++++++------
 t/t5000-tar-tree.sh                |  4 ++--
 t/t6002-rev-list-bisect.sh         | 17 ++++++++++-------
 t/t7422-submodule-output.sh        |  2 +-
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 t/t7508-status.sh                  |  4 ++--
 t/t9138-git-svn-authors-prog.sh    |  4 ++--
 t/t9200-git-cvsexportcommit.sh     |  3 +--
 t/t9400-git-cvsserver-server.sh    |  5 +++--
 t/t9401-git-cvsserver-crlf.sh      |  4 ++--
 t/t9402-git-cvsserver-refs.sh      |  4 ++--
 t/t9902-completion.sh              |  6 ++----
 t/test-lib-functions.sh            | 12 ++++++------
 t/test-lib.sh                      | 19 +++++++++++++++----
 23 files changed, 91 insertions(+), 69 deletions(-)

Range-diff versus v3:

 1:  276cd1c541 =  1:  7e57f3ba57 t: prepare `test_match_signal ()` calls for `set -e`
 2:  3cbcf0298c =  2:  3b8f710de8 t: prepare `test_must_fail ()` for `set -e`
 3:  e97211a468 =  3:  9cf3f458b3 t: prepare `stop_git_daemon ()` for `set -e`
 4:  c974d59252 =  4:  8763cedd60 t: prepare `git config --unset` calls for `set -e`
 5:  e41064dd1b =  5:  8dc43cca62 t: prepare conditional test execution for `set -e`
 6:  890c11aa7a =  6:  ca0c250d39 t: prepare execution of potentially failing commands for `set -e`
 7:  a7b2bb9cd5 =  7:  4631ebe1d9 t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
 8:  17656428f9 =  8:  64df2f3975 t0008: silence error in subshell when using `grep -v`
 9:  7a6e730ba3 =  9:  f79e55dd96 t1301: don't fail in case setfacl(1) doesn't exist or fails
10:  b762f10ac9 = 10:  fcf5ed7ced t6002: fix use of `expr` with `set -e`
11:  bb588ffe22 <  -:  ---------- t9902: fix use of `read` with `set -e`
 -:  ---------- > 11:  39a5e2ffcb t9902: fix use of `read` with `set -e`
12:  9ffcb73e64 = 12:  7dfee331e9 t: detect errors outside of test cases

---
base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
change-id: 20260410-b4-pks-tests-with-set-e-3ae479b24b51

