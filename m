Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EF1B4129
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480860; cv=none; b=O6jsxmdIySAhOBh/YlL4GHfXwWX28AChVgd6iwWdtcR2WtsF2zv8lbBz2dyxLe6BbDGoiBGU5oAtqO+pd8I371EIU74/cL2XsjPelk4Rk+guB8tmN1Z8wXYw17u4h4C6QsQoksRU7Ga9xsgifUYLZo7x2Zh2dm8fVAHisp7NQvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480860; c=relaxed/simple;
	bh=MqwK/HLOSiX0zjREUZy01Sh3SIcEzCsL9F4AtGNp10k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=j46grT9ZKbFLZSSNHBizi/6BYFV+owXEqibolVR73PVhI+S2F/Q2mSah7qaqv0uQwByWntahu4RD2VSMMD6pEc03hZW5SJ2FGjrjIzm9OVErZ1i/T2HU8S+73/WXwWx9jAIeTd/ca3sV26MQw6+cWu2wY5+xWKSv2JXP5nOYUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eXgLM9+J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0eUYjL/T; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eXgLM9+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0eUYjL/T"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DC602540197;
	Fri,  6 Dec 2024 05:27:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 05:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480856;
	 x=1733567256; bh=RFQRNQUBqfjL5xb5hnmp4zMdiLdIHHs067G3S37/mRA=; b=
	eXgLM9+Jo5JRqhx/bUF9ptwxiNgOLh/61mgYR7unrHp4z5y0O3Ak4kQQE3b84s9/
	GtYj1OWBr3pwe5kSHMpbgEAW0YU/XgRUHfM3J7oIkLqG07Xjhgr1zmH4GHdffCsx
	rFp/Oc0VE04xlTkq02dHDBMGrwq5UDJ2Cv3ka4WhjUIYC4jh2ie7ZodlHLdUSzUj
	nFi4KYtpyW2JNekjKVI8HP5S7nFIJh+QFW4bzC43xkfYfsS8vSlu7Z+uQZ/d7KXg
	zYw3zLUi/U2/CdNhFNNl/1T39AGNqWkYiqCqqAR1khwe2k+BPMWr0LvQD+zHRy94
	cLz2eCkNnFmvCxYgTerNIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480856; x=
	1733567256; bh=RFQRNQUBqfjL5xb5hnmp4zMdiLdIHHs067G3S37/mRA=; b=0
	eUYjL/T6TuX503yzQ8/L45Y0wnOcYbyrpEQJ1PUwVn92ceN9T2HPl/n+lZpp05Tz
	Vav2gHvg1xvTiUm/YCEGn/czHuGDy5xEQ6PdzOd+myc0Ct20jKJ6Yf4OMJvUMB8E
	81WlhlEIYQSWzgzfIWkvwwOQQpiFMgJ1Qy6FNvF+un6GWoxzAXR5SRdD6Nyvukft
	NIHHL2wI9p41phCMzAqT1v8uNKlyBR3yznxrGHQmUt/urhrzIQbTBDBASM6sR/m1
	qpq8kYvHZhOBwcbdcvtfsQJdhMAHn34Di+ZM+yVVd8Q8OoMsIWdjpH/wdapAdxqe
	Lnwb36vaU/Xz55b9Zt7Nw==
X-ME-Sender: <xms:mNFSZ2XQK20WTlzKHhsw609OmRSBW4Hpwm3FzuBjNGO-5-IGPMT8Ww>
    <xme:mNFSZymV9NP5g-okvxv40GUNnyJ77ZCJSgN9jQvYHUxsNNQ2yeddJnbjAB06HFrqA
    jJvuq-huQhmxbLC_Q>
X-ME-Received: <xmr:mNFSZ6awUgT_s-t4uB64jzhZfWU7bUMuckW5i6Im_hFo7ODC7BErkxvS_R6ya6UwztJ6_kmjXBoN_4RCdYQLJT9G24PWHNblY5vMB_u3EwxTcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgeetheejve
    duleefkeelvdelgeehudetgedtuddvhfekgeevvdekvdettddvudenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgpdhmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvght
X-ME-Proxy: <xmx:mNFSZ9XG1TOBT5QR27qcm-P5vHfRLdd-Efv5NplOnV1FWFvF6yKTJA>
    <xmx:mNFSZwnLSGEevL2Dd7ECoZjKQMQcXib1aELBC6m0vLyc5JSwyWH1YQ>
    <xmx:mNFSZyclm018m2cpfzn-4eZRYt6TXLc7fVokARv0H2uV2FsQ6jCCiw>
    <xmx:mNFSZyFtAfNsiZ1NO3qpsQyVKl20_xa4ctRIHjqSE1ugC2aT20-QXA>
    <xmx:mNFSZxAfrc89dgWJX-sCtNg5a1JTai3KHQTSwM-H1VJqe1p277Nbimua>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07e641a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/16] Start compiling with `-Wsign-compare`
Date: Fri, 06 Dec 2024 11:27:15 +0100
Message-Id: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAITRUmcC/23NywrCMBAF0F+RrI1k0mgaV/6HuEjTaTtIHyQSl
 NJ/Ny34wm4G7jDnzsgCesLAjpuReYwUqO9SUNsNc43tauRUpsykkApA5ny4Bh6o7rjr28F65MZ
 VWoEsHIJliQ0eK7ovledLyg2FW+8fy4cI8/ZVZv7LInDBK6fEoTC5Kpw5pZMdtWxuivKj01jRM
 mnUlbClkVarX5196/2KzmYtARBFbjTot56m6Qmd+ATeKQEAAA==
X-Change-ID: 20241128-pks-sign-compare-9cf7412bce1a
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

when compiling with DEVELOPER=YesPlease, we explicitly disable the
"-Wsign-compare" warning. This is mostly because our code base is full
of cases where we don't bother at all whether something should be signed
or unsigned, and enabling the warning would thus cause tons of warnings
to pop up.

Unfortunately, disabling this warning also masks real issues. There have
been multiple CVEs in the Git project that would have been flagged by
this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
the vicinity of these CVEs). Furthermore, the final audit report by
X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
that it might be a good idea to become more strict in this context.

Now simply enabling the warning globally does not fly due to the stated
reason above that we simply have too many sites where we use the wrong
integer types. Instead, this patch series introduces a new macro that
allows us to explicitly mark files that generate such warnings. Like
this, we can adapt the codebase over time and hopefully make this class
of vulnerabilities harder to land.

Changes in v2:

  - Explode the 6th patch into multiple patches with more careful
    analysis and refactorings

  - Drop the conversion of "gettext.c". To do it properly we'd have to
    fix the return type of `utf8_strwidth()`, which we have already
    marked as a todo.

  - Link to v1: https://lore.kernel.org/r/20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im

Changes in v3:

  - Include Junio's fix for 32 bit platforms.

  - Improve a commit message.

  - Link to v2: https://lore.kernel.org/r/20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im

Changes in v4:

  - Rebased on top of e66fd72e97 (The fourteenth batch, 2024-12-06) to
    fix a couple of new errors in "git.c"'

  - Remove needless cast in "csum-file.c".

  - Refactor "pkt-line.c" to be safer regarding integer conversions.

  - Link to v3: https://lore.kernel.org/r/20241205-pks-sign-compare-v3-0-e211ee089717@pks.im

There are a couple of trivial conflicts with kn/midx-wo-the-repository,
but I don't think it makes sense to make that a dependency of this
series. Let me know in case you disagree and I'll change the base of
this series.

Thanks!

Patrick

---
Junio C Hamano (1):
      csum-file: fix -Wsign-compare warning on 32-bit platform

Patrick Steinhardt (15):
      git-compat-util: introduce macros to disable "-Wsign-compare" warnings
      compat/regex: explicitly ignore "-Wsign-compare" warnings
      compat/win32: fix -Wsign-compare warning in "wWinMain()"
      global: mark code units that generate warnings with `-Wsign-compare`
      config.mak.dev: drop `-Wno-sign-compare`
      diff.h: fix index used to loop through unsigned integer
      pkt-line: fix -Wsign-compare warning on 32 bit platform
      global: trivial conversions to fix `-Wsign-compare` warnings
      daemon: fix loops that have mismatching integer types
      daemon: fix type of `max_connections`
      gpg-interface: address -Wsign-comparison warnings
      builtin/blame: fix type of `length` variable when emitting object ID
      builtin/patch-id: fix type of `get_one_patchid()`
      scalar: address -Wsign-compare warnings
      t/helper: don't depend on implicit wraparound

 add-interactive.c                    |  1 +
 add-patch.c                          |  1 +
 advice.c                             |  7 ++-----
 apply.c                              |  1 +
 archive.c                            |  1 +
 attr.c                               |  1 +
 base85.c                             |  3 +--
 bisect.c                             |  1 +
 blame.c                              |  1 +
 bloom.c                              |  2 ++
 builtin/add.c                        |  9 +++++----
 builtin/am.c                         |  1 +
 builtin/bisect.c                     |  2 ++
 builtin/blame.c                      | 11 +++++++++--
 builtin/branch.c                     |  2 ++
 builtin/cat-file.c                   |  3 +++
 builtin/checkout--worker.c           |  2 ++
 builtin/checkout-index.c             |  3 +++
 builtin/checkout.c                   |  2 ++
 builtin/clean.c                      |  3 +++
 builtin/clone.c                      |  3 +++
 builtin/commit.c                     |  3 +++
 builtin/describe.c                   |  2 ++
 builtin/diff-files.c                 |  3 +++
 builtin/diff-index.c                 |  2 ++
 builtin/diff-tree.c                  |  1 +
 builtin/diff.c                       |  3 +++
 builtin/difftool.c                   |  5 ++++-
 builtin/fast-export.c                |  3 +++
 builtin/fast-import.c                |  2 ++
 builtin/fetch-pack.c                 |  2 ++
 builtin/fetch.c                      |  3 +++
 builtin/for-each-repo.c              |  5 +++--
 builtin/fsmonitor--daemon.c          |  2 ++
 builtin/gc.c                         |  3 +++
 builtin/grep.c                       |  3 +++
 builtin/help.c                       |  6 +++---
 builtin/index-pack.c                 |  2 ++
 builtin/log.c                        |  3 +++
 builtin/ls-files.c                   |  3 +++
 builtin/mailsplit.c                  |  6 ++++--
 builtin/merge-file.c                 |  2 ++
 builtin/merge-index.c                |  2 ++
 builtin/merge-ours.c                 |  2 ++
 builtin/merge-tree.c                 |  6 +++---
 builtin/merge.c                      |  3 +++
 builtin/mv.c                         |  2 ++
 builtin/name-rev.c                   |  2 ++
 builtin/pack-objects.c               |  2 ++
 builtin/pack-redundant.c             |  4 ++--
 builtin/pack-refs.c                  |  1 +
 builtin/patch-id.c                   | 16 +++++++++-------
 builtin/prune.c                      |  2 ++
 builtin/pull.c                       |  4 ++--
 builtin/push.c                       |  6 ++++--
 builtin/range-diff.c                 |  1 +
 builtin/rebase.c                     |  3 +++
 builtin/receive-pack.c               |  2 ++
 builtin/reflog.c                     |  1 +
 builtin/remote.c                     |  2 ++
 builtin/repack.c                     |  2 ++
 builtin/replay.c                     |  4 +++-
 builtin/rerere.c                     |  9 +++++----
 builtin/reset.c                      |  2 ++
 builtin/rev-list.c                   |  2 ++
 builtin/rev-parse.c                  |  3 +++
 builtin/revert.c                     |  1 +
 builtin/rm.c                         |  3 +++
 builtin/shortlog.c                   |  1 +
 builtin/show-branch.c                |  2 ++
 builtin/show-index.c                 |  2 ++
 builtin/sparse-checkout.c            |  2 ++
 builtin/stash.c                      |  7 +++----
 builtin/submodule--helper.c          |  8 ++++----
 builtin/tag.c                        |  3 +++
 builtin/unpack-objects.c             |  2 ++
 builtin/update-index.c               |  3 +++
 builtin/update-ref.c                 |  2 ++
 builtin/var.c                        |  5 +++--
 builtin/worktree.c                   |  2 ++
 bulk-checkin.c                       |  1 +
 bundle-uri.c                         |  1 +
 bundle.c                             |  1 +
 cache-tree.c                         |  1 +
 chunk-format.c                       |  1 +
 color.c                              |  2 ++
 column.c                             |  2 ++
 combine-diff.c                       |  1 +
 commit-graph.c                       |  1 +
 commit-reach.c                       |  1 +
 commit.c                             |  3 +--
 compat/fsmonitor/fsm-listen-darwin.c |  3 +--
 compat/mingw.c                       |  1 +
 compat/poll/poll.c                   |  2 ++
 compat/regex/regex.c                 |  2 ++
 compat/terminal.c                    |  3 +--
 compat/win32/headless.c              | 17 +++++++++--------
 compat/win32mmap.c                   |  2 ++
 compat/winansi.c                     |  2 ++
 config.c                             |  1 +
 config.mak.dev                       |  1 -
 connect.c                            |  1 +
 convert.c                            |  1 +
 credential.c                         |  1 +
 csum-file.c                          |  2 +-
 daemon.c                             | 31 +++++++++++++------------------
 date.c                               |  2 ++
 decorate.c                           |  3 +++
 delta-islands.c                      |  1 +
 diagnose.c                           |  7 +++----
 diff-delta.c                         |  2 ++
 diff-lib.c                           |  1 +
 diff-no-index.c                      |  2 ++
 diff.c                               |  1 +
 diff.h                               |  3 +--
 diffcore-order.c                     |  1 +
 diffcore-pickaxe.c                   |  3 +++
 diffcore-rename.c                    |  3 +--
 diffcore-rotate.c                    |  1 +
 dir.c                                |  1 +
 entry.c                              |  4 ++--
 ewah/ewah_bitmap.c                   |  5 ++---
 ewah/ewah_io.c                       |  3 +++
 ewah/ewah_rlw.c                      |  3 +++
 fetch-pack.c                         |  1 +
 fmt-merge-msg.c                      |  1 +
 fsmonitor.c                          |  1 +
 gettext.c                            |  2 ++
 git-compat-util.h                    | 10 ++++++++++
 git.c                                | 32 +++++++++++++-------------------
 gpg-interface.c                      | 14 ++++++--------
 graph.c                              |  1 +
 grep.c                               |  2 ++
 help.c                               |  1 +
 help.h                               |  8 +++-----
 hex.c                                |  6 ++----
 http-backend.c                       |  1 +
 http-push.c                          |  3 +--
 http-walker.c                        |  1 +
 http.c                               |  1 +
 imap-send.c                          |  1 +
 json-writer.c                        |  2 ++
 kwset.c                              |  2 ++
 line-log.c                           |  2 ++
 list-objects-filter-options.c        |  4 +---
 list-objects.c                       |  7 ++-----
 log-tree.c                           |  1 +
 ls-refs.c                            |  4 +---
 mailinfo.c                           |  1 +
 mailmap.c                            |  1 +
 match-trees.c                        |  1 +
 mem-pool.c                           |  2 ++
 merge-ll.c                           |  1 +
 merge-ort.c                          |  1 +
 merge-recursive.c                    |  1 +
 merge.c                              |  4 ++--
 midx-write.c                         |  1 +
 midx.c                               |  1 +
 name-hash.c                          |  1 +
 notes-merge.c                        |  1 +
 notes.c                              |  1 +
 object-file-convert.c                |  1 +
 object-file.c                        |  1 +
 object-name.c                        |  1 +
 object.c                             |  1 +
 pack-bitmap-write.c                  |  1 +
 pack-bitmap.c                        |  1 +
 pack-check.c                         |  1 +
 packfile.c                           |  1 +
 parallel-checkout.c                  |  1 +
 path.c                               |  4 ++--
 pathspec.c                           |  1 +
 pkt-line.c                           | 23 ++++++++++++-----------
 preload-index.c                      |  1 +
 pretty.c                             |  1 +
 progress.c                           |  1 +
 pseudo-merge.c                       |  1 +
 quote.c                              |  2 ++
 range-diff.c                         |  1 +
 read-cache.c                         |  1 +
 ref-filter.c                         |  1 +
 reflog.c                             |  1 +
 refs.c                               |  1 +
 refs/debug.c                         |  3 +--
 refs/files-backend.c                 |  1 +
 refs/iterator.c                      |  2 ++
 refs/packed-backend.c                |  1 +
 refspec.c                            |  1 +
 reftable/system.h                    |  2 ++
 remote-curl.c                        |  1 +
 remote.c                             |  1 +
 rerere.c                             |  1 +
 resolve-undo.c                       |  1 +
 revision.c                           |  1 +
 run-command.c                        |  1 +
 scalar.c                             |  6 +++---
 send-pack.c                          |  5 ++---
 sequencer.c                          |  1 +
 serve.c                              |  7 ++-----
 server-info.c                        |  1 +
 setup.c                              |  1 +
 shallow.c                            |  1 +
 sideband.c                           |  1 +
 sparse-index.c                       |  1 +
 split-index.c                        |  1 +
 strbuf.c                             |  2 ++
 string-list.c                        |  2 ++
 strvec.c                             |  3 +--
 submodule-config.c                   |  1 +
 submodule.c                          |  1 +
 symlinks.c                           |  2 ++
 t/helper/test-bloom.c                |  9 ++-------
 t/helper/test-cache-tree.c           |  1 +
 t/helper/test-config.c               |  1 +
 t/helper/test-csprng.c               |  3 +--
 t/helper/test-drop-caches.c          |  2 ++
 t/helper/test-dump-fsmonitor.c       |  3 +--
 t/helper/test-dump-split-index.c     |  3 +--
 t/helper/test-dump-untracked-cache.c |  6 +++---
 t/helper/test-genrandom.c            |  2 +-
 t/helper/test-genzeros.c             |  2 ++
 t/helper/test-hash-speed.c           |  5 ++---
 t/helper/test-mergesort.c            |  2 ++
 t/helper/test-parse-options.c        |  5 ++---
 t/helper/test-path-utils.c           |  1 +
 t/helper/test-reach.c                |  3 +--
 t/helper/test-ref-store.c            |  3 +--
 t/helper/test-run-command.c          |  2 ++
 t/helper/test-string-list.c          |  2 ++
 t/helper/test-tool.c                 |  3 +--
 t/helper/test-trace2.c               |  1 +
 t/unit-tests/lib-reftable.c          |  2 ++
 t/unit-tests/t-example-decorate.c    |  4 ++--
 t/unit-tests/t-prio-queue.c          |  2 +-
 t/unit-tests/t-reftable-readwrite.c  |  2 ++
 t/unit-tests/t-reftable-stack.c      |  2 ++
 t/unit-tests/t-trailer.c             |  2 ++
 t/unit-tests/test-lib.c              |  2 ++
 tag.c                                |  1 +
 tmp-objdir.c                         |  3 +--
 trace.c                              |  1 +
 trace2.c                             |  2 ++
 trace2/tr2_sysenv.c                  |  2 ++
 trace2/tr2_tgt_event.c               |  2 ++
 trace2/tr2_tgt_perf.c                |  2 ++
 trailer.c                            |  3 +--
 transport-helper.c                   | 13 ++++++-------
 transport.c                          | 13 ++++---------
 tree-diff.c                          |  1 +
 unix-socket.c                        |  2 ++
 unpack-trees.c                       |  1 +
 upload-pack.c                        |  1 +
 urlmatch.c                           |  2 ++
 usage.c                              |  3 ++-
 userdiff.c                           |  1 +
 utf8.c                               |  2 ++
 version.c                            |  3 +--
 versioncmp.c                         |  3 +--
 worktree.c                           |  1 +
 wrapper.c                            |  3 +++
 ws.c                                 |  3 +++
 wt-status.c                          |  1 +
 xdiff-interface.c                    |  1 +
 xdiff/xdiffi.c                       |  1 +
 xdiff/xinclude.h                     |  2 ++
 265 files changed, 519 insertions(+), 235 deletions(-)

Range-diff versus v3:

 1:  db200b32a4 =  1:  4b1b789a11 git-compat-util: introduce macros to disable "-Wsign-compare" warnings
 2:  d2f39d9cdd =  2:  9374c60f7a compat/regex: explicitly ignore "-Wsign-compare" warnings
 3:  195adf8638 =  3:  5e171b5c88 compat/win32: fix -Wsign-compare warning in "wWinMain()"
 4:  5d1169e388 !  4:  05f2d3b693 global: mark code units that generate warnings with `-Wsign-compare`
    @@ refs/files-backend.c
     +#define DISABLE_SIGN_COMPARE_WARNINGS
      
      #include "../git-compat-util.h"
    - #include "../config.h"
    + #include "../abspath.h"
     
      ## refs/iterator.c ##
     @@
 5:  54f765cd2a =  5:  dd1182224a config.mak.dev: drop `-Wno-sign-compare`
 6:  d40c804a80 =  6:  14623c961b diff.h: fix index used to loop through unsigned integer
 7:  bc629478af !  7:  8647bcb017 sign-compare: 32-bit support
    @@ Metadata
     Author: Junio C Hamano <gitster@pobox.com>
     
      ## Commit message ##
    -    sign-compare: 32-bit support
    +    csum-file: fix -Wsign-compare warning on 32-bit platform
     
         On 32-bit platforms, ssize_t may be "int" while size_t may be
         "unsigned int".  At times we compare the number of bytes we read
    @@ csum-file.c: static void verify_buffer_or_die(struct hashfile *f,
      	if (ret < 0)
      		die_errno("%s: sha1 file read error", f->name);
     -	if (ret != count)
    -+	if ((size_t)ret != (size_t)count)
    ++	if ((size_t)ret != count)
      		die("%s: sha1 file truncated", f->name);
      	if (memcmp(buf, f->check_buffer, count))
      		die("sha1 file '%s' validation error", f->name);
    -
    - ## pkt-line.c ##
    -@@ pkt-line.c: static int get_packet_data(int fd, char **src_buf, size_t *src_size,
    - 	}
    - 
    - 	/* And complain if we didn't get enough bytes to satisfy the read. */
    --	if (ret != size) {
    -+	if ((size_t)ret != (size_t)size) {
    - 		if (options & PACKET_READ_GENTLE_ON_EOF)
    - 			return -1;
    - 
 -:  ---------- >  8:  ea870e7d7b pkt-line: fix -Wsign-compare warning on 32 bit platform
 8:  3dfb3dac4c !  9:  482020af4b global: trivial conversions to fix `-Wsign-compare` warnings
    @@ git.c: void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
      		if (skip_prefix(commands[i].cmd, prefix, &name))
      			add_cmdname(cmds, name, strlen(name));
      }
    -@@ git.c: static int run_argv(int *argcp, const char ***argv)
    +@@ git.c: static int run_argv(struct strvec *args)
    + 			handle_builtin(args);
    + 		else if (get_builtin(args->v[0])) {
    + 			struct child_process cmd = CHILD_PROCESS_INIT;
    +-			int i;
    ++			int err;
    + 
    + 			/*
    + 			 * The current process is committed to launching a
    +@@ git.c: static int run_argv(struct strvec *args)
    + 			commit_pager_choice();
    + 
    + 			strvec_push(&cmd.args, "git");
    +-			for (i = 0; i < args->nr; i++)
    ++			for (size_t i = 0; i < args->nr; i++)
    + 				strvec_push(&cmd.args, args->v[i]);
    + 
    + 			trace_argv_printf(cmd.args.v, "trace: exec:");
    +@@ git.c: static int run_argv(struct strvec *args)
    + 			cmd.clean_on_exit = 1;
    + 			cmd.wait_after_clean = 1;
    + 			cmd.trace2_child_class = "git_alias";
    +-			i = run_command(&cmd);
    +-			if (i >= 0 || errno != ENOENT)
    +-				exit(i);
    ++			err = run_command(&cmd);
    ++			if (err >= 0 || errno != ENOENT)
    ++				exit(err);
    + 			die("could not execute builtin %s", args->v[0]);
    + 		}
      
    - 		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
    +@@ git.c: static int run_argv(struct strvec *args)
    + 
    + 		seen = unsorted_string_list_lookup(&cmd_list, args->v[0]);
      		if (seen) {
     -			int i;
      			struct strbuf sb = STRBUF_INIT;
    @@ git.c: static int run_argv(int *argcp, const char ***argv)
      				struct string_list_item *item = &cmd_list.items[i];
      
      				strbuf_addf(&sb, "\n  %s", item->string);
    +@@ git.c: int cmd_main(int argc, const char **argv)
    + 	 */
    + 	setup_path();
    + 
    +-	for (size_t i = 0; i < argc; i++)
    ++	for (int i = 0; i < argc; i++)
    + 		strvec_push(&args, argv[i]);
    + 
    + 	while (1) {
     
      ## help.h ##
     @@ help.h: static inline void list_config_item(struct string_list *list,
 9:  e958cdf2a7 = 10:  9b3939369e daemon: fix loops that have mismatching integer types
10:  817d83e78c = 11:  20b4332a90 daemon: fix type of `max_connections`
11:  c926562a6d = 12:  3708125de5 gpg-interface: address -Wsign-comparison warnings
12:  806d118aae = 13:  74710deea7 builtin/blame: fix type of `length` variable when emitting object ID
13:  c47920d71a = 14:  7527b49737 builtin/patch-id: fix type of `get_one_patchid()`
14:  e346768f65 = 15:  2b3c65b3f4 scalar: address -Wsign-compare warnings
15:  f39ffd3073 = 16:  aac99381ff t/helper: don't depend on implicit wraparound

---
base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
change-id: 20241128-pks-sign-compare-9cf7412bce1a

