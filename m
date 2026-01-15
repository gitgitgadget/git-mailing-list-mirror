Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3B3B8D5F;
	Thu, 15 Jan 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498550; cv=none; b=fzUDxsuewpyT1upeF8Fqtd3wzUwIJaGM5dSr1FgTqDtXnXo5ZkgpveUfiTgINLsimmSk+Mr6CMv4GyiPl1VfX6POynlcVGJsl6FryJ0he15qPeG++zIwLYxzDgC+yHajtV9qR3bmXEp8hy0tD0bYVmKzS1hdaoxHsHJ8k6FMJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498550; c=relaxed/simple;
	bh=e68FrU8RvQI1BDBQx3Pj92a4IGyfrKgg3jPm0Yi21qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1sKoGIrMpbcoF6nfTcmP4Bx/nKqo2Mjlq7pAyD2F4n4kjB/6MaBBTsMa+I0nRmWl3j2VQKFSOc6WMrE2Bz17LfEtgjX3uHHbpO/36jgtxwTJWR5VsAHLC5WdEOEjinZQVukuxrlyXmBdhjW77MN05KcLA8Tl6Xej6H1LTmKkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L3NrzEhO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0o1rONaK; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L3NrzEhO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0o1rONaK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A38487A0052;
	Thu, 15 Jan 2026 12:35:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 15 Jan 2026 12:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1768498547; x=1768584947; bh=Qq
	mJSIpMWxYzoGK9ctnt+kJTIb8a/uGUY92Vk4CYlYo=; b=L3NrzEhOaUzYqRmUZo
	A0tUG4ub/zn6NUy0JlWHvg0VbQv71qjb+T50MwhmG7zClw71kaBLHccSDcL2JKs1
	+jq7Hf+WEKdGqTdS8vl4pUuSYVKV3E2xsvQmUlIPH7k32+lbZ6NAsze5mvRhU1cM
	7B0lLIYd4q2eCpj6myCzLacry6x6aUcrWy+HX6qjuD7aLiS8f75W2IHV7vHVzikc
	StqC9U6jYThJSD254Ncx1mQCg4JzDFCKJNMXRux8gK+P3Sn6fAqA486RfExWnDr2
	qV30yXBEytQ3/A++q/ihm2hXXgBKwgSzdrvhoPOcL0dFdlerCO3GFsNyiNDfD7j7
	kKcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1768498547; x=1768584947; bh=QqmJSIpMWxYzoGK9ctnt+kJTIb8a
	/uGUY92Vk4CYlYo=; b=0o1rONaKa7TqOgA9rWW7zkmkWTz4cD9QOQ6skxlLX9lE
	Es87wpES6oO+o6tQzbGr6nXrhxe8PmKKog+W2sEq+fviEXdP/jSP5FXotvniHZ1Q
	cNCfPD335f5nvAy/mvFEFFiB44rgb2ju4YCzIOmjIW3qfL+pgHxDrIwcFhAf8WxZ
	Jv7rZrG9q8N4Q13i+vNyhuJ0Q18tZYW+M6wKu7oCyjZmDucK4Ten2KngylmZmh0/
	Fa1ZnFX/SPaJdp2AsAgTo7T554CY250Jc3P57fCBR8K0KwWomdFJQ95PifVg470s
	Y7iW3phb0S9yaL7qu7GXB6Xg3rseuTJCzIcwZF8kLA==
X-ME-Sender: <xms:cyVpaTeGFi8BUjNo1eQJsJZtYOlTYJOH-hFOlqDJoMi42XJtYiQb2g>
    <xme:cyVpaau5gTvMtV4jgCNxDQpbZFYYXQ0LDpcyROaOPz-Kkg3FnDCs_X47F0gGw_acE
    2VDugVmU0NKDqXLWHLZoe5LPRdRtOdLQvyK069ahH5z2KGVa3RC2w>
X-ME-Received: <xmr:cyVpaclsxYsDxG8S7jVQ4wOTyQkLREZqnM2avEkFVJ5EJD_BsUV-hFD4WKAT03PJlysFXTbmoJP3exD6LuqjXVglO1RG5ueFud14gck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiieejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cyVpaUxBFH7j4nANGogSmm6GIdPwyS-mzorbeQQji-ql8ojtlMFMhw>
    <xmx:cyVpaWNdk1GHQJwBy2OBfsg2pCkJSCBUnusUdNAhHucApvm9bAvKkQ>
    <xmx:cyVpaYr2WgqXIGbTXlLUUzmZGxWXFvnP88-mhsm324sQ8HJAs-xYMA>
    <xmx:cyVpaXFPNl5SJjEPbvcxe3IXPU4-3lPo7y61rcKFbwxMj7Ni4cHT-w>
    <xmx:cyVpadxnXYTa5VGBBl8ENzGfgdEAXI50-YzT1aMura116PT_xz-F6uAA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 12:35:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.53.0-rc0
Date: Thu, 15 Jan 2026 09:35:45 -0800
Message-ID: <xmqqv7h2bwy6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

An early preview release Git v2.53.0-rc0 is now available for
testing at the usual places.  It is comprised of 329 non-merge
commits since v2.52.0, contributed by 52 people, 15 of which are
new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.53.0-rc0' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.52.0 are as follows.
Welcome to the Git development community!

  Adrian Ratiu, Ben Stav, correctmost, David Bohman, David Macek,
  Deveshi Dwivedi, Greg Funni, Jean-Noël Avila via GitGitGadget,
  Paul Tarjan, Paul Wintz, Petter Sælen, Pushkar Singh, Sam
  Bostock, Yee Cheng Chin, and Zhelyo Zhelev.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Aaron Plattner, Anders Kaseorg, Antonin Delpeuch, brian
  m. carlson, Carlo Marcelo Arenas Belón, Christian Couder,
  D. Ben Knoble, Derrick Stolee, Elijah Newren, Emily Shaffer,
  Eric Sunshine, Ezekiel Newren, Han Jiang, Jean-Noël Avila,
  Jeff King, Jiang Xin, Johannes Schindelin, Johannes Sixt,
  Julia Evans, Junio C Hamano, Justin Tobler, Karthik Nayak, K
  Jayatheerth, Koji Nakamaru, Kristoffer Haugsbakk, Lucas Seiki
  Oshiro, Mark Levedahl, Matthew Hughes, Michael Rappazzo, Patrick
  Steinhardt, Phillip Wood, Queen Ediri Jessa, René Scharfe,
  Siddharth Asthana, Taylor Blau, Tobias Boesch, and Toon Claes.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.53 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * "git maintenance" command learned "is-needed" subcommand to tell if
   it is necessary to perform various maintenance tasks.

 * "git replay" (experimental) learned to perform ref updates itself
   in a transaction by default, instead of emitting where each refs
   should point at and leaving the actual update to another command.

 * "git blame" learns "--diff-algorithm=<algo>" option.

 * "git repo info" learned "--all" option.

 * Both "git apply" and "git diff" learn a new whitespace error class,
   "incomplete-line".

 * Add a new manual that describes the data model.

 * "git fast-import" learns "--strip-if-invalid" option to drop
   invalid cryptographic signature from objects.

 * The use of "revision" (a connected set of commits) has been
   clarified in the "git replay" documentation.

 * A help message from "git branch" now mentions "git help" instead of
   "man" when suggesting to read some documentation.

 * "git repo struct" learned to take "-z" as a synonym to "--format=nul".

 * More object database related information are shown in "git repo
   structure" output.

 * Improve the error message when a bad argument is given to the
   `--onto` option of "git replay".  Test coverage of "git replay" has
   been improved.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * The list of packfiles used in a running Git process is moved from
   the packed_git structure into the packfile store.

 * Some ref backend storage can hold not just the object name of an
   annotated tag, but the object name of the object the tag points at.
   The code to handle this information has been streamlined.

 * As "git diff --quiet" only cares about the existence of any
   changes, disable rename/copy detection to skip more expensive
   processing whose result will be discarded anyway.

 * A part of code paths that deals with loose objects has been cleaned
   up.

 * "make strip" has been taught to strip "scalar" as well as "git".

 * Dockerised jobs at the GitHub Actions CI have been taught to show
   more details of failed tests.

 * Code refactoring around object database sources.

 * Halve the memory consumed by artificial filepairs created during
   "git diff --find-copioes-harder", also making the operation run
   faster.

 * The "git_istream" abstraction has been revamped to make it easier
   to interface with pluggable object database design.

 * Rewrite the only use of "mktemp()" that is subject to TOCTOU race
   and Stop using the insecure "mktemp()" function.
   (merge 10bba537c4 rs/ban-mktemp later to maint).

 * In-code comment update to clarify that single-letter options are
   outside of the scope of command line completion script.
   (merge dc8a00fafe jc/completion-no-single-letter-options later to maint).

 * MEMZERO_ARRAY() helper is introduced to avoid clearing only the
   first N bytes of an N-element array whose elements are larger than
   a byte.

 * "git diff-files -R --find-copies-harder" has been taught to use
   the potential copy sources from the index correctly.

 * Require C99 style flexible array member support from all platforms.

 * The code path that enumerates promisor objects have been optimized
   to skip pointlessly parsing blob objects.

 * Prepare test suite for Git for Windows that supports symbolic
   links.

 * Use hook API to replace ad-hoc invocation of hook scripts with the
   run_command() API.

 * Import newer version of "clar", unit testing framework.
   (merge 84071a6dea ps/clar-integers later to maint).


Fixes since v2.52
-----------------

 * Ever since we added whitespace rules for this project, we misspelt
   an entry, which has been corrected.
   (merge 358e94dc70 jc/gitattributes-whitespace-no-indent-fix later to maint).

 * The code to expand attribute macros has been rewritten to avoid
   recursion to avoid running out of stack space in an uncontrolled
   way.
   (merge 42ed046866 jk/attr-macroexpand-wo-recursion later to maint).

 * Adding a repository that uses a different hash function is a no-no,
   but "git submodule add" did nt prevent it, which has been corrected.
   (merge 6fe288bfbc bc/submodule-force-same-hash later to maint).

 * An earlier check added to osx keychain credential helper to avoid
   storing the credential itself supplied was overeager and rejected
   credential material supplied by other helper backends that it would
   have wanted to store, which has been corrected.
   (merge 4580bcd235 kn/osxkeychain-idempotent-store-fix later to maint).

 * The "git repo structure" subcommand tried to align its output but
   mixed up byte count and display column width, which has been
   corrected.
   (merge 7a03a10a3a jx/repo-struct-utf8width-fix later to maint).

 * Yet another corner case fix around renames in the "ort" merge
   strategy.
   (merge a562d90a35 en/ort-rename-another-fix later to maint).

 * Test leakfix.
   (merge 14b561e768 jk/test-mktemp-leakfix later to maint).

 * Update a version of action used at the GitHub Actrions CI.
   (merge cd99203f86 js/ci-github-setup-go-update later to maint).

 * The "return errno = EFOO, -1" construct, which is heavily used in
   compat/mingw.c and triggers warnings under "-Wcomma", has been
   rewritten to avoid the warnings.
   (merge af3919816f js/mingw-assign-comma-fix later to maint).

 * Makefile based build have recently been updated to build a
   libgit.a that also has reftable and xdiff objects; CMake based
   build procedure has been updated to match.
   (merge b0d5c88cca js/cmake-libgit-fix later to maint).

 * Under-allocation fix.
   (merge d22a488482 js/wincred-get-credential-alloc-fix later to maint).

 * "git worktree list" attempts to show paths to worktrees while
   aligning them, but miscounted display columns for the paths when
   non-ASCII characters were involved, which has been corrected.
   (merge 08dfa59835 pw/worktree-list-display-width-fix later to maint).

 * "Windows+meson" job at the GitHub Actions CI was hard to debug, as
   it did not show and save failed test artifacts, which has been
   corrected.
   (merge 17bd1108ea jk/ci-windows-meson-test-fix later to maint).

 * Emulation code clean-up.
   (merge 2367c6bcd6 gf/win32-pthread-cond-wait-err later to maint).

 * Various issues detected by Asan have been corrected.
   (merge a031b6181a jk/asan-bonanza later to maint).

 * "git config get --path" segfaulted on an ":(optional)path" that
   does not exist, which has been corrected.
   (merge 0bd16856ff jc/optional-path later to maint).

 * The "--committer-date-is-author-date" option of "git am/rebase" is
   a misguided one.  The documentation is updated to discourage its
   use.
   (merge fbf3d0669f kh/doc-committer-date-is-author-date later to maint).

 * The option help text given by "git config unset -h" described
   the "--all" option to "replace", not "unset", multiple variables,
   which has been corrected.
   (merge 18bf67b753 rs/config-unset-opthelp-fix later to maint).

 * The error message given by "git config set", when the variable
   being updated has more than one values defined, used old style "git
   config" syntax with an incorrect option in its hint, both of which
   have been corrected.
   (merge df963f0df4 rs/config-set-multi-error-message-fix later to maint).

 * "git replay" forgot to omit the "gpgsig-sha256" extended header
   from the resulting commit the same way it omits "gpgsig", which has
   been corrected.
   (merge 9f3a115087 pw/replay-exclude-gpgsig-fix later to maint).

 * A few tests have been updated to work under the shell compatible
   mode of zsh.
   (merge a92f243a94 bc/zsh-testsuite later to maint).

 * The way patience diff finds LCS has been optimized.
   (merge c7e3b8085b yc/xdiff-patience-optim later to maint).

 * Recent optimization to "last-modified" command introduced use of
   uninitialized block of memory, which has been corrected.
   (merge fe4e60759b tc/last-modified-active-paths-optimization later to maint).

 * "git last-modified" used to mishandle "--" to mark the beginning of
   pathspec, which has been corrected.
   (merge 05491b90ce js/last-modified-with-sparse-checkouts later to maint).

 * Emulation code clean-up.
   (merge 42aa7603aa gf/win32-pthread-cond-init later to maint).

 * "git submodule add" to add a submodule under <name> segfaulted,
   when a submodule.<name>.something is already in .gitmodules file
   without defining where its submodule.<name>.path is, which has been
   corrected.
   (merge dd8e8c786e jc/submodule-add later to maint).

 * "git fetch" that involves fetching tags, when a tag being fetched
   needs to overwrite existing one, failed to fetch other tags, which
   has been corrected.
   (merge b7b17ec8a6 kn/fix-fetch-backfill-tag-with-batched-ref-updates later to maint).

 * Document "rev-list --filter-provided-objects" better.
   (merge 6d8dc99478 jt/doc-rev-list-filter-provided-objects later to maint).

 * Even when there is no changes in the packfile and no need to
   recompute bitmaps, "git repack" recomputed and updated the MIDX
   file, which has been corrected.
   (merge 6ce9d558ce ps/repack-avoid-noop-midx-rewrite later to maint).

 * Update HTTP tests to adjust for changes in curl 8.18.0
   (merge 17f4b01da7 jk/test-curl-updates later to maint).

 * Workaround the "iconv" shipped as part of macOS, which is broken
   handling stateful ISO/IEC 2022 encoded strings.
   (merge cee341e9dd rs/macos-iconv-workaround later to maint).

 * Running "git diff" with "--name-only" and other options that allows
   us not to look at the blob contents, while objects that are lazily
   fetched from a promisor remote, caused use-after-free, which has
   been corrected.

 * The ort merge machinery hit an assertion failure in a history with
   criss-cross merges renamed a directory and a non-directory, which
   has been corrected.
   (merge 979ee83e8a en/ort-recursive-d-f-conflict-fix later to maint).

 * Diagnose invalid bundle-URI that lack the URI entry, instead of
   crashing.
   (merge 7796c14a1a sb/bundle-uri-without-uri later to maint).

 * Mailmap update for Karsten
   (merge e97678c4ef js/mailmap-karsten-blees later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 46207a54cc qj/doc-http-bad-want-response later to maint).
   (merge df90eccd93 kh/doc-commit-extra-references later to maint).
   (merge f18aa68861 rs/xmkstemp-simplify later to maint).
   (merge fddba8f737 ja/doc-synopsis-style later to maint).
   (merge 22ce0cb639 en/xdiff-cleanup-2 later to maint).
   (merge 8ef7355a8f je/doc-pull later to maint).
   (merge 48176f953f jc/capability-leak later to maint).
   (merge 8cbbdc92f7 kh/doc-pre-commit-fix later to maint).
   (merge d4bc39a4d9 mh/doc-config-gui-gcwarning later to maint).
   (merge 41d425008a kh/doc-send-email-paragraph-fix later to maint).
   (merge d4b732899e jc/macports-darwinports later to maint).
   (merge bab391761d kj/pull-options-decl-cleanup later to maint).
   (merge 007b8994d4 rs/t4014-git-version-string-fix later to maint).
   (merge 4ce170c522 ds/doc-scalar-config later to maint).
   (merge a0c813951a jc/doc-commit-signoff-config later to maint).
   (merge 8ee262985a ja/doc-misc-fixes later to maint).
   (merge 1722c2244b mh/doc-core-attributesfile later to maint).
   (merge c469ca26c5 dk/ci-rust-fix later to maint).
   (merge 12f0be0857 gf/clear-path-cache-cleanup later to maint).
   (merge 949df6ed6b js/test-func-comment-fix later to maint).
   (merge 93f894c001 bc/checkout-error-message-fix later to maint).
   (merge abf05d856f rs/show-branch-prio-queue later to maint).
   (merge 06188ea5f3 rs/parse-config-expiry-simplify later to maint).
   (merge 861dbb1586 dd/t5403-modernise later to maint).
   (merge acffc5e9e5 ja/doc-synopsis-style-more later to maint).

----------------------------------------------------------------

Changes since v2.52.0 are as follows:

Aaron Plattner (2):
      object: apply skip_hash and discard_tree optimizations to unknown blobs too
      packfile: skip hash checks in add_promisor_object()

Adrian Ratiu (3):
      run-command: add first helper for pp child states
      reference-transaction: use hook API instead of run-command
      hook: allow overriding the ungroup option

Antonin Delpeuch (2):
      xdiff: add 'minimal' to XDF_DIFF_ALGORITHM_MASK
      blame: make diff algorithm configurable

Christian Couder (3):
      fast-import: refactor finalize_commit_buffer()
      commit: refactor verify_commit_buffer()
      fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>

D. Ben Knoble (1):
      rust: build correctly without GNU sed

David Macek (1):
      wincred: avoid memory corruption

Derrick Stolee (6):
      scalar: annotate config file with "set by scalar"
      scalar: use index.skipHash=true for performance
      scalar: remove stale config values
      scalar: alphabetize and simplify config
      scalar: document config settings
      diff: avoid segfault with freed entries

Deveshi Dwivedi (1):
      t5403: use test_path_is_file instead of test -f

Elijah Newren (5):
      t6429: update comment to mention correct tool
      merge-ort: remove debugging crud
      merge-ort: fix failing merges in special corner case
      Documentation/git-replay.adoc: fix errors around revision range
      merge-ort: fix corner case recursive submodule/directory conflict handling

Emily Shaffer (8):
      run-command: add stdin callback for parallelization
      hook: provide stdin via callback
      hook: convert 'post-rewrite' hook in sequencer.c to hook API
      transport: convert pre-push to hook API
      run-command: allow capturing of collated output
      hooks: allow callers to capture output
      receive-pack: convert update hooks to new API
      receive-pack: convert receive hooks to hook API

Ezekiel Newren (10):
      doc: define unambiguous type mappings across C and Rust
      xdiff: use ptrdiff_t for dstart/dend
      xdiff: make xrecord_t.ptr a uint8_t instead of char
      xdiff: use size_t for xrecord_t.size
      xdiff: use unambiguous types in xdl_hash_record()
      xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
      xdiff: make xdfile_t.nrec a size_t instead of long
      xdiff: make xdfile_t.nreff a size_t instead of long
      xdiff: change rindex from long to size_t in xdfile_t
      xdiff: rename rindex -> reference_index

Greg Funni (4):
      win32: return error if SleepConditionVariableCS fails
      win32: pthread_cond_init should return a value
      repository: remove duplicate free of cache->squash_msg
      refs: dereference the value of the required pointer

Jean-Noël Avila (10):
      doc: convert git fetch to synopsis style
      doc: convert git pull to synopsis style
      doc: convert git push to synopsis style
      doc: fix asciidoc markup issues in several files
      doc: correct minor wording issues
      doc: fix t0450-txt-doc-vs-help to select only first synopsis block
      doc: convert git-status to synopsis style
      doc: convert git-status tables to AsciiDoc format
      doc: convert git stage to use synopsis block
      doc: convert git-remote to synopsis style

Jean-Noël Avila via GitGitGadget (1):
      doc: pull-fetch-param typofix

Jeff King (16):
      attr: avoid recursion when expanding attribute macros
      read-cache: drop submodule check from add_to_cache()
      compat/mmap: mark unused argument in git_munmap()
      pack-bitmap: handle name-hash lookups in incremental bitmaps
      Makefile: turn on NO_MMAP when building with ASan
      cache-tree: avoid strtol() on non-string buffer
      fsck: assert newline presence in fsck_ident()
      fsck: avoid strcspn() in fsck_ident()
      fsck: remove redundant date timestamp check
      fsck: avoid parse_timestamp() on buffer that isn't NUL-terminated
      t: enable ASan's strict_string_checks option
      unit-test: ignore --no-chain-lint
      ci(windows-meson-test): handle options and output like other test jobs
      test-mktemp: plug memory and descriptor leaks
      t5551: handle trailing slashes in expected cookies output
      t5563: add missing end-of-line in HTTP header

Jiang Xin (2):
      t/unit-tests: add UTF-8 width tests for CJK chars
      builtin/repo: fix table alignment for UTF-8 characters

Johannes Schindelin (18):
      make strip: include `scalar`
      cmake: stop trying to build the reftable and xdiff libraries
      mingw: avoid the comma operator
      ci: bump actions/setup-go from 5 to 6
      ci(dockerized): do show the result of failing tests again
      last-modified: support sparse checkouts
      t9700: accommodate for Windows paths
      apply: symbolic links lack a "trustable executable bit"
      mingw: special-case `open(symlink, O_CREAT | O_EXCL)`
      t0001: handle `diff --no-index` gracefully
      t0301: another fix for Windows compatibility
      t0600: fix incomplete prerequisite for a test case
      t1006: accommodate for symlink support in MSYS2
      t1305: skip symlink tests that do not apply to Windows
      t6423: introduce Windows-specific handling for symlinking to /dev/null
      t7800: work around the MSYS path conversion on Windows
      test_detect_ref_format: fix comment
      .mailmap: replace Karsten Blees' default address

Johannes Sixt (4):
      Revert "gitk: Only restore window size from ~/.gitk, not position"
      gitk: persist position and size of the Tags and Heads window
      gitk: fix a 'continue' statement outside a loop to 'return'
      gitk: show unescaped file names on 'rename' and 'copy' lines

Julia Evans (3):
      doc: add an explanation of Git's data model
      doc: remove stray text in Git data model
      doc: git-pull: fix 'git --rebase abort' typo

Junio C Hamano (45):
      t7004: do not chdir around in the main process
      .gitattributes: remove misspelled no-op whitespace attribute
      whitespace: correct bit assignment comments
      diff: emit_line_ws_markup() if/else style fix
      diff: correct suppress_blank_empty hack
      diff: keep track of the type of the last line seen
      diff: refactor output of incomplete line
      diff: call emit_callback ecbdata everywhere
      diff: update the way rewrite diff handles incomplete lines
      apply: revamp the parsing of incomplete lines
      whitespace: allocate a few more bits and define WS_INCOMPLETE_LINE
      apply: check and fix incomplete lines
      diff: highlight and error out on incomplete lines
      attr: enable incomplete-line whitespace error for this project
      Start 2.53 cycle
      config: mark otherwise unused function as file-scope static
      The second batch
      The third batch
      config: really pretend missing :(optional) value is not there
      config: really treat missing optional path as not configured
      submodule add: sanity check existing .gitmodules
      The fourth batch
      The fifth batch
      The sixth batch
      completion: clarify support for short options and arguments
      connect: plug protocol capability leak
      The seventh batch
      Makefile: help macOS novices by mentioning MacPorts
      FLEX_ARRAY: require platforms to support the C99 syntax
      coccicheck: emit the contents of cocci patch
      cocci: use MEMZERO_ARRAY() a bit more
      The eighth batch
      The ninth batch
      The 10th batch
      commit: document that $command.signoff will not be added
      odb: do not use "blank" substitute for NULL
      signoff-option: linkify the reference to gitfaq
      The 11th batch
      The 12th batch
      The 13th batch
      The 14th batch
      The 15th batch
      The 16th batch
      The 17th batch
      Git 2.53-rc0

Justin Tobler (8):
      docs: clarify git-rev-list(1) --filter behavior
      builtin/repo: group per-type object values into struct
      strbuf: split out logic to humanise byte values
      builtin/repo: humanise count values in structure output
      builtin/repo: add inflated object info to keyvalue structure output
      builtin/repo: add inflated object info to structure table
      builtin/repo: add disk size info to keyvalue stucture output
      builtin/repo: add object disk size info to structure table

K Jayatheerth (1):
      pull: move options[] array into function scope

Karthik Nayak (11):
      refs: move to using the '.optimize' functions
      refs: rename 'pack_refs_opts' to 'refs_optimize_opts'
      t/pack-refs-tests: move the 'test_done' to callees
      reftable/stack: return stack segments directly
      reftable/stack: add function to check if optimization is required
      refs: add a `optimize_required` field to `struct ref_storage_be`
      maintenance: add checking logic in `pack_refs_condition()`
      maintenance: add 'is-needed' subcommand
      fetch: extract out reference committing logic
      fetch: fix non-conflicting tags not being committed
      fetch: fix failed batched updates skipping operations

Koji Nakamaru (1):
      osxkeychain: avoid incorrectly skipping store operation

Kristoffer Haugsbakk (14):
      doc: commit: link to git-status(1) on all format options
      doc: warn against --committer-date-is-author-date
      branch: advice using git-help(1) instead of man(1)
      doc: join default pre-commit paragraphs
      doc: send-email: fix broken list continuation
      doc: replay: mention no output on conflicts
      replay: improve --contained and add to doc
      doc: replay: link section using markup
      replay: remove dead code and rearrange
      replay: find *onto only after testing for ref name
      replay: die descriptively when invalid commit-ish is given
      replay: improve code comment and die message
      replay: die if we cannot parse object
      t3650: add more regression tests for failure conditions

Lucas Seiki Oshiro (5):
      repo: factor out field printing to dedicated function
      repo: add --all to git-repo-info
      repo: remove blank line from Documentation/git-repo.adoc
      repo: use [--format=... | -z] instead of [-z] in git-repo-info synopsis
      repo: add -z as an alias for --format=nul to git-repo-structure

Matthew Hughes (2):
      config: document 'gui.GCWarning'
      docs: note the type of core.attributesfile

Patrick Steinhardt (85):
      packfile: use a `strmap` to store packs by name
      packfile: move the MRU list into the packfile store
      http: refactor subsystem to use `packfile_list`s
      packfile: fix approximation of object counts
      builtin/pack-objects: simplify logic to find kept or nonlocal objects
      packfile: move list of packs into the packfile store
      packfile: always add packfiles to MRU when adding a pack
      packfile: track packs via the MRU list exclusively
      odb: fix subtle logic to check whether an alternate is usable
      odb: introduce `odb_source_new()`
      odb: adjust naming to free object sources
      object-file: move `fetch_if_missing`
      object-file: introduce `struct odb_source_loose`
      object-file: move loose object cache into loose source
      object-file: hide internals when we need to reprepare loose sources
      object-file: move loose object map into loose source
      object-file: read objects via the loose object source
      object-file: rename `has_loose_object()`
      object-file: refactor freshening of objects
      object-file: rename `write_object_file()`
      object-file: refactor writing objects via a stream
      refs: introduce wrapper struct for `each_ref_fn`
      refs: introduce `.ref` field for the base iterator
      refs: fully reset `struct ref_iterator::ref` on iteration
      refs: refactor reference status flags
      refs: expose peeled object ID via the iterator
      upload-pack: convert to use `reference_get_peeled_oid()`
      ref-filter: propagate peeled object ID
      builtin/show-ref: convert to use `reference_get_peeled_oid()`
      refs: drop `current_ref_iter` hack
      refs: drop infrastructure to peel via iterators
      object: add flag to `peel_object()` to verify object type
      refs: don't store peeled object IDs for invalid tags
      ref-filter: detect broken tags when dereferencing them
      ref-filter: parse objects on demand
      ref-filter: fix stale parsed objects
      object: fix performance regression when peeling tags
      path: move `enter_repo()` into "setup.c"
      setup: convert `set_git_dir()` to have file scope
      odb: adopt logic to close object databases
      odb: refactor `odb_clear()` to `odb_free()`
      streaming: rename `git_istream` into `odb_read_stream`
      streaming: drop the `open()` callback function
      streaming: propagate final object type via the stream
      streaming: explicitly pass packfile info when streaming a packed object
      streaming: allocate stream inside the backend-specific logic
      streaming: create structure for in-core object streams
      streaming: create structure for loose object streams
      streaming: create structure for packed object streams
      streaming: create structure for filtered object streams
      streaming: move zlib stream into backends
      packfile: introduce function to read object info from a store
      streaming: rely on object sources to create object stream
      streaming: get rid of `the_repository`
      streaming: make the `odb_read_stream` definition public
      streaming: move logic to read loose objects streams into backend
      streaming: move logic to read packed objects streams into backend
      streaming: refactor interface to be object-database-centric
      streaming: move into object database subsystem
      streaming: drop redundant type and size pointers
      odb: move logic to disable ref updates into repo
      oidset: introduce `oidset_equal()`
      builtin/index-pack: fix deferred fsck outside repos
      t/helper: stop setting up `the_repository` repeatedly
      http-push: stop setting up `the_repository` for each reference
      odb: handle initialization of sources in `odb_new()`
      chdir-notify: add function to unregister listeners
      odb: handle changing a repository's commondir
      odb: handle recreation of quarantine directories
      t/unit-tests: update clar to 39f11fe
      t/unit-tests: demonstrate use of integer comparison assertions
      gitattributes: disable blank-at-eof errors for clar test expectations
      midx: fix `BUG()` when getting preferred pack without a reverse index
      midx-write: extract function to test whether MIDX needs updating
      midx-write: skip rewriting MIDX with `--stdin-packs` unless needed
      odb: refactor parsing of alternates to be self-contained
      odb: resolve relative alternative paths when parsing
      odb: move computation of normalized objdir into `alt_odb_usable()`
      odb: stop splitting alternate in `odb_add_to_alternates_file()`
      odb: remove mutual recursion when parsing alternates
      odb: drop forward declaration of `read_info_alternates()`
      odb: read alternates via sources
      odb: write alternates via sources
      builtin/gc: fix condition for whether to write commit graphs
      odb: properly close sources before freeing them

Paul Tarjan (1):
      t7800: fix racy "difftool --dir-diff syncs worktree" test

Phillip Wood (3):
      worktree list: fix column spacing
      worktree list: quote paths
      replay: do not copy "gpgsign-sha256" header

Pushkar Singh (1):
      t1300: use test helpers instead of `test` command

Queen Ediri Jessa (1):
      doc: clarify server behavior for invalid 'want' lines in HTTP protocol

René Scharfe (35):
      diff: disable rename detection with --quiet
      wrapper: simplify xmkstemp()
      config: fix suggestion for failed set of multi-valued option
      config: fix short help of unset flags
      diff-index: don't queue unchanged filepairs with diff_change()
      wrapper: add git_mkdtemp()
      compat: use git_mkdtemp()
      compat: remove mingw_mktemp()
      banned.h: ban mktemp(3)
      compat: remove gitmkdtemp()
      replay: move onto NULL check before first use
      t4014: support Git version strings with spaces
      diff-files: fix copy detection
      revision: export commit_stack
      log: use commit_stack
      midx: use commit_stack
      name-rev: use commit_stack
      remote: use commit_stack for local_commits
      remote: use commit_stack for sent_tips
      remote: use commit_stack for src_commits
      test-reach: use commit_stack
      commit: add commit_stack_init()
      pack-bitmap-write: use commit_stack
      shallow: use commit_stack
      commit: add commit_stack_grow()
      commit-graph: use commit_stack
      commit-reach: use commit_stack
      macOS: make Homebrew use configurable
      macOS: use iconv from Homebrew if needed and present
      show-branch: use prio_queue
      config: use git_parse_int() in git_config_get_expiry_in_days()
      tag: use algo of repo parameter in parse_tag_buffer()
      tag: support arbitrary repositories in gpg_verify_tag()
      tag: support arbitrary repositories in parse_tag()
      tag: stop using the_repository

Sam Bostock (1):
      bundle-uri: validate that bundle entries have a uri

Siddharth Asthana (3):
      replay: use die_for_incompatible_opt2() for option validation
      replay: make atomic ref updates the default behavior
      replay: add replay.refAction config option

Tobias Boesch (1):
      gitk: add external diff file rename detection

Toon Claes (6):
      last-modified: fix use of uninitialized memory
      meson: ignore subprojects/.wraplock
      meson: only detect ICONV_OMITS_BOM if possible
      meson: use is_cross_build() where possible
      git-compat-util: introduce MEMZERO_ARRAY() macro
      contrib/coccinelle: pass include paths to spatch(1)

Yee Cheng Chin (1):
      xdiff: optimize patience diff's LCS search

brian m. carlson (4):
      object-file: disallow adding submodules of different hash algo
      t0614: use numerical comparison with test_line_count
      t5564: fix test hang under zsh's sh mode
      checkout: quote invalid treeish in error message

