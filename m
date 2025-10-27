Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D061E5B72;
	Mon, 27 Oct 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580613; cv=none; b=GlyjYXxG1Inrsz6DQXBZKCcigypojJS5F8Qo7/zOOcPQgb6t57SwokY4aeoRSoUhMoEcSOgv00FM3pE9TEJkiUJqGgV2dhspcjABn4E+eRRZtpmrgf+QCZiXcRYGBgbFMkqpp9aQk6Ig2msI4XdhzQSgF59RTODQQ1O1T9ZRUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580613; c=relaxed/simple;
	bh=S61BcdhjBlE8pNb7rtr3ZXpVmmZWi1rq36Z7ilkFXxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mfEKZfpxrD5oPkILjoMOADAagA6nZ/HeXZUtWihv4Yo6/4cjUcz7EWMcSnRLKfBsw3ZOTJYeAF31cN+M178nPR29vvS6bIjkW9W5i9y2SaZ/DPxrW0wzRwcXoBMrvtispQeSx3ia6czrNs723ZGidTePUMs6Ew5Uo0Omt55ZoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q846CXW6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rsZnjkcW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q846CXW6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rsZnjkcW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 27364EC014C;
	Mon, 27 Oct 2025 11:56:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Oct 2025 11:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1761580610; x=1761667010; bh=tb
	eSHzXOk4TJB/30tlejhrTtGiyHoE1uNSmxqwrDiV4=; b=Q846CXW6XBYBoJW4vR
	VvQIYuuWOdguH6g4GxNpx9/GQUd6wGpSW0NTYbtpnVnuvU6//JL9PDKkYDIGxUD9
	YheB/wbG8KmK13nd/ea7Mf5eoPrskuJS+igMeCb4uZ4HLAycTGc9MSdViXQxjZYr
	DHEY5uVP89hGTLQ57UbjQmgnW6vMJSd71pMASGlr+erWKzuyE4ThXH6az0ce+SoA
	SprfllNQ9b8ibvW0nf1pZiT9ZYJ3Tjpv5gKAk92wKyGtFZepoLiJaBAZr0xfjV8j
	1EnoorSKHKEpTBiZqQr+0isqpdv4i91adZsrjxnI5N2R/tlq7p4GozCBMIYbn6Rh
	hQ7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1761580610; x=1761667010; bh=tbeSHzXOk4TJB/30tlejhrTtGiyH
	oE1uNSmxqwrDiV4=; b=rsZnjkcWbWsZtb5rt/tCcY2H0Fn9qjqCprnWUvMkjFNX
	R+G3VlECWVXEeQBGRZ9EQWANNvUYd3zUixJDL4fAUdfAAMbO1+L4yUvo+vMZT9bY
	psAYn7RPJ4E1aq4ma76UG/RprIKrSrRzw9qAEVjwp1v1c73FS7Z0VL2Sf7YqHTG+
	U9K+Liab9+Z1NUKtB+wTlP9YKOLUFcTwyZVN/7lJBXF6YJ37824UKIgh8aQgZFGr
	U0TVqM0MA97BPCyxItrYSKNFetN/Of34KCkhcDb5tMwtG+QVNFjXp2/30f5RP0i4
	B75mpIIGa96Ddjj4wzw3BMeen5QR/96GY9CQJr3A+w==
X-ME-Sender: <xms:QZb_aASbP_KoH_gsLN9cfaZoDvxesUU4NOSxnNG0BUnvHbKObdXv6g>
    <xme:QZb_aPTCqy_ypJb6sKZi4XiI_Xv1TJJ7r5kyI76O_KwvMOrU94b39kjCqp4n_5EvM
    FstIqxYbZbDTu13ymutLbNZOzjIY0iSd17CuvP9EVGJbRkerK0D7uI>
X-ME-Received: <xmr:QZb_aN72TiPN3hWxM2JbqjB0hPWuK0eMHXMu1AoeTrweS98r4ctFZf0PXJKStLArS_TqAwGdTQcWp6oENNF9jNBdVrqB4z4d7-w8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufgffkfggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeduvdeludeiteeikeejveeifeeltdffgfegteelhfdvgeehfeejieeljeffgeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvghsohhurhgtvgdrtg
    homhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgv
    rhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehlfihnsehlfihnrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QZb_aD3qDhcOv9A-A9CvSO0GNixWe5a3RGjMtD_5fzKsoVu3mh0pHg>
    <xmx:QZb_aADSQWTbg_ExIUi923jYAJ-yP49V5rSKx0NkpFLO5zvJeCYPaA>
    <xmx:QZb_aGOrI2Lzzcal1YEAn3xoEtAX3Og06yverqA6-0lF5SaXmstzfQ>
    <xmx:QZb_aNZFMvftvXj3WDCCTFx510kW6zfeKCJSIpLr7ev7w23OW2MQLw>
    <xmx:Qpb_aHoH7BR5uzK-BQPqBIU8gXRXGgOB90P6naCdy_4_RYBpUNhwh0tN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 11:56:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.51.2
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 27 Oct 2025 08:56:48 -0700
Message-ID: <xmqqo6psjq2n.fsf@gitster.g>
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

