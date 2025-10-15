Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171C302750;
	Wed, 15 Oct 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554252; cv=none; b=tp/oZMcch78W50cjZDB4dT9K64w09XIV/EAqKjzlNPRrGHHxWk9Pm1elc9YkrkU8HIwX+qSv8W8nNRho1ME/DbTnQF3IYGSjsSTAjVOHfs19HzP0QRk0nmAUW/FsOx5uZl7ZJxXXb6qI2cXo7NExreCjVL4HJ1jDx3DGzDv50dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554252; c=relaxed/simple;
	bh=68YsTsGp1it4PoQXysa5N0fLMIclyhq2x/rAu9dC2U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCU7QI//Ovj1WSe1KTxJYdi9dxWV5dMBp8Olizlhe4xWATTfghUapvInx4NSjUhQN8l03gwXpINilJeX+DIuExkiLCpRuOC3+8FfnLXrC+SWdZZJaUD2NOgBZPY/wIMIJQb7GKeeSpVSsKxOO1dTZzaGyBxi/D8CFKXkmpevBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fw8fDHuu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9Gyf4y+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fw8fDHuu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9Gyf4y+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 33FFAEC0230;
	Wed, 15 Oct 2025 14:50:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 14:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1760554248; x=1760640648; bh=Fr
	iZuyY0yThvGqLdjcv88IPbga4kqQw7nhJ2H+Aace4=; b=fw8fDHuuoSbeC/Qa/j
	VlLOmLmmeehXXZR0TWahYEFJJrM6WrLjbf6LBNIkj1pi2ax4ZOtcpGV7MyB4YtwG
	DQBiNdtEsdOoCWLUq3sOaj/l3SFDPeM8CFFKbAJW98KYUWFzhCHzwM5xjIOpbDgF
	YokDyPsEgyuyYsF+J+77G37VAh7bsRZlW4k3enIz7Y4OCLvT0iNGio1Sp2nLKXjo
	cQ/Z7kMv6vFZfCizGjVD8spBtB+wR3KoBDs/6bkS50mTe2vUqqpVHNONGe+AGnwN
	wyYWrRsn85XCvX6ogVwq/fDPWbdev1MRqXEQumoh2hbOdmPNQzRVErrYXQvbb5Kw
	sauw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760554248; x=1760640648; bh=FriZuyY0yThvGqLdjcv88IPbga4k
	qQw7nhJ2H+Aace4=; b=H9Gyf4y+9REj64UYEGHlH38CTCHzXY/HEbEd5e+Z5Jv3
	QeRk44AQxnVR3wGZsKYsWulneSqjf4DkblKfipcRAGmmp92m9k5lAaOLdn5goMZr
	1PTFGaooP+z6cPOnLA8ORXiE5I82lRm/ONGZKcMXPOxOcZsIQDOA/qLuWlRlGHb7
	YjixVHh8o022kZuEaG0uU9vt1T1A8mGvl+3b6tB6sSXq8Ofymo/HKbVL8KvkdrIJ
	NJ+N+Lfgzxtrk97FOMfRVmvG7hsPdQKoVXMFO1Gw8ERSg4kmi7KtG2YjpPXzJt2C
	rofRFTBxM4gIVCPCZURtwvBv4Swxw4sghuH6ByBtGQ==
X-ME-Sender: <xms:B-3vaOE4wgAXWT1TT3aEwmbiZoctXmnbWorTj5GZLne3DCJuAIeAUg>
    <xme:B-3vaA2I2eTb3NMNl5w_qajeN5BRbXCQ6TM2jJT3WGrRfxhjeOvEZeYK1i_SxwNhs
    QIVMgS3i5qknvd2W7cQYJa5xQu7DVSrWgubFxl9Yiune_cF5In6rQ>
X-ME-Received: <xmr:B-3vaINY7MfLq_h8IYS7uyzBn-7OiRljP0MJGbX3ODbMMN14Rf9A0qXrxhMrI3ZtqW4D2J8pj7-3q-Dc3_EimOcioAKkUnnNQUoX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegudejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:B-3vaH67563sFMTTYsBMBofOFyFoKUFjeY8SaGr0c4Nnn9SK1o0KEA>
    <xmx:B-3vaK1Qf7DZADrbn5AC3M_qkRF359ILR1xiC9WD2gYd03R2cKuDOg>
    <xmx:B-3vaAwJnuVgmweyZ3oBovELvaDANFXR_NKctG5P0VMdNSau7FDZow>
    <xmx:B-3vaMv8PchKcfb6fy_MSWaAWxpTvzSF6_IsZhVgfwY0PhWxXZ64yg>
    <xmx:CO3vaF7MMxaQF8XTlBJipa1ZjM55BOtnxqBop8j7NjOtDFwY2TGtStGi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 14:50:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.51.1
Date: Wed, 15 Oct 2025 11:50:46 -0700
Message-ID: <xmqqa51suhh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The latest maintenance release Git v2.51.1 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.51.1'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git 2.51.1 Release Notes
========================

There shouldn't be anything exciting to see here.  This is primarily
to flush the "do you still use it?" improvements that has landed on
the master front, together with a handful of low-hanging, low-impact
fixes that should be safe.


Fixes since Git 2.51.0
----------------------

 * The "do you still use it?" message given by a command that is
   deeply deprecated and allow us to suggest alternatives has been
   updated.

 * The compatObjectFormat extension is used to hide an incomplete
   feature that is not yet usable for any purpose other than
   developing the feature further.  Document it as such to discourage
   its use by mere mortals.

 * Manual page for "gitk" is updated with the current maintainer's
   name.

 * Update the instructions for using GGG in the MyFirstContribution
   document to say that a GitHub PR could be made against `git/git`
   instead of `gitgitgadget/git`.

 * Clang-format update to let our control macros be formatted the way we
   had them traditionally, e.g., "for_each_string_list_item()" without
   space before the parentheses.

 * A few places where a size_t value was cast to curl_off_t without
   checking has been updated to use the existing helper function.

 * The start_delayed_progress() function in the progress eye-candy API
   did not clear its internal state, making an initial delay value
   larger than 1 second ineffective, which has been corrected.

 * Makefile tried to run multiple "cargo build" which would not work
   very well; serialize their execution to work around this problem.

 * Adjust to the way newer versions of cURL selectively enable tracing
   options, so that our tests can continue to work.

 * During interactive rebase, using 'drop' on a merge commit led to
   an error, which has been corrected.

 * "git refs migrate" to migrate the reflog entries from a refs
   backend to another had a handful of bugs squashed.

 * "git push" had a code path that led to BUG() but it should have
   been a die(), as it is a response to a usual but invalid end-user
   action to attempt pushing an object that does not exist.

 * Various bugs about rename handling in "ort" merge strategy have
   been fixed.

 * "git diff --no-index" run inside a subdirectory under control of a
   Git repository operated at the top of the working tree and stripped
   the prefix from the output, and oddballs like "-" (stdin) did not
   work correctly because of it.  Correct the set-up by undoing what
   the set-up sequence did to cwd and prefix.

 * Various options to "git diff" that make comparison ignore certain
   aspects of the differences (like "space changes are ignored",
   "differences in lines that match these regular expressions are
   ignored") did not work well with "--name-only" and friends.

 * Under a race against another process that is repacking the
   repository, especially a partially cloned one, "git fetch" may
   mistakenly think some objects we do have are missing, which has
   been corrected.

 * "git repack --path-walk" lost objects in some corner cases, which
   has been corrected.
   cf. <CABPp-BHFxxGrqKc0m==TjQNjDGdO=H5Rf6EFsf2nfE1=TuraOQ@mail.gmail.com>

 * Fixes multiple crashes around midx write-out codepaths.

 * A broken or malicious "git fetch" can say that it has the same
   object for many many times, and the upload-pack serving it can
   exhaust memory storing them redundantly, which has been corrected.

 * A corner case bug in "git log -L..." has been corrected.

 * Some among "git add -p" and friends ignored color.diff and/or
   color.ui configuration variables, which is an old regression, which
   has been corrected.

 * "git rebase -i" failed to clean-up the commit log message when the
   command commits the final one in a chain of "fixup" commands, which
   has been corrected.

 * Deal more gracefully with directory / file conflicts when the files
   backend is used for ref storage, by failing only the ones that are
   involved in the conflict while allowing others.

Also contains various documentation updates, code cleanups and minor fixups.

----------------------------------------------------------------

Changes since v2.51.0 are as follows:

Aditya Garg (1):
      docs: update sendmail docs to use more secure SMTP server for Gmail

Daniele Sassoli (2):
      count-objects: document count-objects pack
      doc: clarify which remotes can be used with GitGitGadget

David Aguilar (1):
      Makefile: build libgit-rs and libgit-sys serially

Denton Liu (3):
      t5516: remove surrounding empty lines in test bodies
      remote.c: remove BUG in show_push_unqualified_ref_name_error()
      remote.c: convert if-else ladder to switch

Derrick Stolee (8):
      path-walk: fix setup of pending objects
      path-walk: create initializer for path lists
      midx-write: only load initialized packs
      midx-write: put failing response value back
      midx-write: use cleanup when incremental midx fails
      midx-write: use uint32_t for preferred_pack_idx
      midx-write: reenable signed comparison errors
      midx-write: simplify error cases

Elijah Newren (8):
      merge-ort: update comments to modern testfile location
      merge-ort: drop unnecessary temporary in check_for_directory_rename()
      t6423: document two bugs with rename-to-self testcases
      t6423: fix missed staging of file in testcases 12i,12j,12k
      merge-ort: clarify the interning of strings in opt->priv->path
      merge-ort: fix incorrect file handling
      merge-ort: fix directory rename on top of source of other rename/delete
      Documentation/git-merge-tree.adoc: clarify the --merge-base option

Jean-Noël Avila (2):
      doc: fix asciidoc format compatibility in pretty-formats.adoc
      doc: change the markup of paragraphs following a nested list item

Jeff King (7):
      fetch-pack: re-scan when double-checking graph objects
      curl: add support for curl_global_trace() components
      stash: pass --no-color to diff plumbing child processes
      add-interactive: respect color.diff for diff coloring
      add-interactive: manually fall back color config to color.ui
      contrib/diff-highlight: mention interactive.diffFilter
      doc: fix indentation of refStorage item in git-config(1)

Johannes Schindelin (3):
      http: offer to cast `size_t` to `curl_off_t` safely
      imap-send: be more careful when casting to `curl_off_t`
      http-push: avoid new compile error

Johannes Sixt (4):
      rebase -i: permit 'drop' of a merge commit
      doc/gitk: update reference to the external project
      doc/format-patch: adjust Thunderbird MUA hint to new add-on
      progress: pay attention to (customized) delay time

Junio C Hamano (4):
      diff: --no-index should ignore the worktree
      config: document includeIf conditions consistently
      Prepare for 2.51.1
      Git 2.51.1

Justin Tobler (1):
      clang-format: exclude control macros from SpaceBeforeParens

Karthik Nayak (4):
      refs/files: catch conflicts on case-insensitive file-systems
      refs/files: use correct error type when lock exists
      refs/files: handle F/D conflicts in case-insensitive FS
      refs/files: handle D/F conflicts during locking

Knut Harald Ryager (1):
      docs: remove stray bracket from git-clone synopsis

Kristoffer Haugsbakk (17):
      doc: git-log: fix description list
      doc: interpret-trailers: close all pairs of single quotes
      doc: config: replace backtick with apostrophe for possessive
      doc: add missing backtick for inline-verbatim
      doc: remove extra backtick for inline-verbatim
      doc: fast-import: replace literal block with paragraph
      Makefile: don’t add whatchanged after it has been removed
      git: add `deprecated` category to --list-cmds
      git: move seen-alias bookkeeping into handle_alias(...)
      git: allow alias-shadowing deprecated builtins
      t0014: test shadowing of aliases for a sample of builtins
      you-still-use-that??: help the user help themselves
      whatchanged: hint about git-log(1) and aliasing
      whatchanged: remove not-even-shorter clause
      BreakingChanges: remove claim about whatchanged reports
      doc: patch-id: fix accidental literal blocks
      RelNotes: minor fixups before 2.51.1

Kyle E. Mitchell (1):
      doc: fix formatting of function-wrap shell alias

Lidong Yan (1):
      diff: ensure consistent diff behavior with ignore options

M Hickford (1):
      docs/gitcredentials: describe URL prefix matching

Mikhail Malinouski (1):
      docs: fix typo in worktree.adoc 'extension'

Patrick Steinhardt (13):
      Documentation/git-reflog: convert to use synopsis type
      builtin/reflog: improve grouping of subcommands
      refs: export `ref_transaction_update_reflog()`
      builtin/reflog: implement subcommand to write new entries
      ident: fix type of string length parameter
      refs: fix identity for migrated reflogs
      refs/files: detect race when generating reflog entry for HEAD
      refs: stop unsetting REF_HAVE_OLD for log-only updates
      refs: fix invalid old object IDs when migrating reflogs
      t5530: modernize tests
      upload-pack: don't ACK non-commits repeatedly in protocol v2
      odb: drop deprecated wrapper functions
      ci: fix broken jobs on Ubuntu 25.10 caused by switch to sudo-rs(1)

Phillip Wood (2):
      rebase -i: respect commit.cleanup when picking fixups
      sequencer: remove VERBATIM_MSG flag

Ramsay Jones (1):
      t6137-*.sh: fix test failure on cygwin

René Scharfe (1):
      object-name: declare pointer type of extend_abbrev_len()'s 2nd parameter

SZEDER Gábor (2):
      line-log: fix assertion error
      line-log: show all line ranges touched by the same diff range

brian m. carlson (1):
      docs: note that extensions.compatobjectformat is incomplete

