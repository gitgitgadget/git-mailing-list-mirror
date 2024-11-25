Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15489136327;
	Mon, 25 Nov 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516685; cv=none; b=Va0T1Bb3abRW0lZTKU6zDw+9E8mML3LZfECVkMebWQodUE3J/SaH0wfzKIA2kRF6P4qai8TYNE1grQ0kJmbFJabu1Rw/mbGrjtkf9F705g2WAPtHO3j7LMLNWyE5rOMor986ZGWZD+Xs+q5tP9WMO+4xTn0tGBpyHhMDzo9P+0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516685; c=relaxed/simple;
	bh=Ke6wPtwidax2MeV8lVEyuVXLI5dAgvoaCE/7nh/5afg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dZP0QM5533/F46V3gs02L7qpNxdXWCPQpebeB68sJl5A+O4ZhE6MdaPgKTHkfSXegZkgTSMtJ9f0EPFFFyLZh4B03SiQtxxf9OlZPIeY2OSmIAiZFuxpKVB7mqeSdwi9ULP28aIRijEaYzVVHwGSgK+uJvLvkzAgF7j6P5oxvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTBmyTUl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTBmyTUl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 124E911401A3;
	Mon, 25 Nov 2024 01:38:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 01:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516682; x=
	1732603082; bh=Xos6N/mWA8Uk2KGNDKa4lm7fZfWHCc3QBYAgtcYaLNE=; b=d
	TBmyTUl/2BKZNoAWr5txlbLV/yC/gINPtC5AHAA7xje9xNSH2k4xW4B9BefpqZbM
	7Hy+9MxPYt9qtr45cLEFASSC0zEds/b0jSILXt3TcAIQc6hdYcBGuvcSbXpDET8d
	RhQDAaMYLeISCm+39iDyCF1gcPB3dTmFXH4Naswwwzj5rXa/X7senGegVvvFnxuT
	dIAzeAMRv9xadOKvbWakWj3/fG+WuwSs5bnMobMLYgP4/o10otYmYO4sOv+Kkdx+
	mJL+LkKbXnZ51++XRYTFxKi0x8L2fcvwWpmupjEUCFPdwsBqH5okuAapDoYCzd7S
	m8GHJDSVy6yjHx4V0bD2Q==
X-ME-Sender: <xms:SRtEZya7Z1CLoZEB7MD0Cs5QiGNeh7S4coTItV_mRuWwKHqdpl-Fzw>
    <xme:SRtEZ1bvTDGxqxgYJFVrZgUIn_hUxvY1gZmGkZNG4cCmRoYmfmCB1BRUFkQ7z9N8v
    _izk7gcKRxSmVRvHQ>
X-ME-Received: <xmr:SRtEZ8-DcUu1dcxxrhCRrth-7cKPTEwdHOO1zhGBDZJhOJct2YWfzF5temSS33OTPSg3Pb5EC6LXn7KP-sePxMQ5d_KA1X9nqcURf9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkfgfgggtsehttdertddtredtnecuhfhr
    ohhmpefluhhnihhoucevucfjrghmrghnohcuoehjuhhnihhosehpohgsohigrdgtohhmqe
    enucggtffrrghtthgvrhhnpeeuueeivdfhvdefudehteehueegjeeiudfggefhfeefffef
    hfefhefhjeekfeeufeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvg
    hsohhurhgtvgdrtghomhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosg
    hogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    qdhprggtkhgrghgvrhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhope
    hlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:SRtEZ0qFeGWdGLHER2tKLLudI2mGYns4SKKv7u48fEv88VTT279KYA>
    <xmx:SRtEZ9oAjcTcBhUB0F7Xd6L2Hzm4LYIHpq3VBptYTt3XYZ7ZYWY6XA>
    <xmx:SRtEZyTVq7SyWmA8mCR9T66wAUaxPlu_P48wKSFKuDK8KU1ViFZCcQ>
    <xmx:SRtEZ9qpdXZym7DzTjgbFst-rJpsCisd6TJpedGfajU5nBf67AOsBg>
    <xmx:ShtEZ2AUJar9uy3q9HpbNpEDbyIsu3nGCTQMLNIkkmUg38tyagDFwUjA>
Feedback-ID: i1ffb436d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:38:01 -0500 (EST)
From: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.47.1
Date: Mon, 25 Nov 2024 15:37:59 +0900
Message-ID: <xmqq5xob6coo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The latest maintenance release Git v2.47.1 is now available at the
usual places.  This flushes some fixes accumulated on the 'master'
front since Git 2.47.0 but the primary purpose is to synchronising
"gitk" subtree with that of Johannes Sixt, who volunteered to be the
new upstream maintainer of it.  Huge thanks to Paul Mackerras who
started the useful tool and have maintained it so far, and to
Johannes Sixt to volunteering to move it forward.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.47.1'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git 2.47.1 Release Notes
========================

This is to flush accumulated fixes since 2.47.0 on the 'master'
front down to the maintenance track.


Fixes since Git 2.47
--------------------

 * Use after free and double freeing at the end in "git log -L... -p"
   had been identified and fixed.

 * On macOS, fsmonitor can fall into a race condition that results in
   a client waiting forever to be notified for an event that have
   already happened.  This problem has been corrected.

 * "git maintenance start" crashed due to an uninitialized variable
   reference, which has been corrected.

 * Fail gracefully instead of crashing when attempting to write the
   contents of a corrupt in-core index as a tree object.

 * A "git fetch" from the superproject going down to a submodule used
   a wrong remote when the default remote names are set differently
   between them.

 * The "gitk" project tree has been synchronized again with its new
   maintainer, Johannes Sixt.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.47.0 are as follows:

Andrew Kreimer (6):
      compat: fix typos
      contrib: fix typos
      t/unit-tests: fix typos
      t/perf: fix typos
      t/helper: fix a typo
      t: fix typos

Daniel Black (1):
      submodule: correct remote name with fetch

Derrick Stolee (1):
      line-log: protect inner strbuf from free

Jeff King (7):
      line-log: use diff_line_prefix() instead of custom helper
      diff: drop line_prefix_length field
      diff: return const char from output_prefix callback
      diff: return line_prefix directly when possible
      diff: store graph prefix buf in git_graph struct
      simple-ipc: split async server initialization and running
      fsmonitor: initialize fs event listener before accepting clients

Johannes Schindelin (1):
      docs: fix the `maintain-git` links in `technical/platform-support`

Josh Heinrichs (1):
      git-config.1: remove value from positional args in unset usage

Josh Soref (2):
      doc: update links to current pages
      doc: switch links to https

Junio C Hamano (3):
      doc: clarify <src> in refspec syntax
      Prepare for 2.47.1
      Git 2.47.1

Karthik Nayak (1):
      loose: don't rely on repository global state

Kristoffer Haugsbakk (2):
      doc: merge-tree: improve example script
      checkout: refer to other-worktree branch, not ref

Patrick Steinhardt (4):
      cache-tree: refactor verification to return error codes
      cache-tree: detect mismatching number of index entries
      unpack-trees: detect mismatching number of cache-tree/index entries
      builtin/gc: fix crash when running `git maintenance start`

Shubham Kanodia (1):
      doc: add a note about staggering of maintenance

Taylor Blau (2):
      Documentation: mention the amlog in howto/maintain-git.txt
      Makefile(s): avoid recipe prefix in conditional statements

Toon Claes (1):
      bundle-uri: plug leak in unbundle_from_file()

Xing Xin (1):
      Documentation/gitprotocol-v2.txt: fix a slight inconsistency in format

