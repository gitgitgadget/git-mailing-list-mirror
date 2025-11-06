Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2D2C0F96;
	Thu,  6 Nov 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449393; cv=none; b=MHr20xspCJ4iZ6DkBW4xoKXs4GhLNgEsHyPcUn0k0TaohNhpf5BVuCT6Js9eDiMVgjE1brOX5XzdymKl8xDutFIjfkEN4kepibjSqxPKR37arQ1EPtqfMI2r1HxkPtSCM+gFXl8dz8twB+epE1ztfjw5el3JXE+N/TZK5V7bduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449393; c=relaxed/simple;
	bh=uxG5XkrF3HiIvMXRV20ewdROO14xRNDGtzCal+SIBhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T9EWCbH3eMyA4sXsoaM/M1n9jHNWGY5/zWZxNnHA/lkeGhWFDcukTxc1X/jPXjnAdNExjRjN6sJ+EjWsM6xNfJlzTDbnGeIrJgt3hgqmeq2cPKflK6dnf0yOIiG6blbKZCcdDSuzFgL5wsQq2gTYnmZ9HSIUTL2edyI27P4BFd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WSPBAffc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7MJkcrF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WSPBAffc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7MJkcrF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6CC07EC02A4;
	Thu,  6 Nov 2025 12:16:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 06 Nov 2025 12:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1762449388; x=1762535788; bh=Pb
	SRi5YF8ulnyzfTjF/uI1gL0gNio+7aFFGCbD2IxTY=; b=WSPBAffcnDaamr20cC
	Dyfq53bn04FvmIDlKncGynxdUoFE1YTEhutFrplLC5O+0pASkyFB2D/bH9kldiYM
	8i5I3xoaDKKnZlJQZe2BXQPjpiTF0VlObwXBGsL7y6OYdk5wqcWrXe4oJDpeDAnU
	7UEEla+zcJwZrgFyec31T3e0ktD+GjTWPOpCJgpihb9aS8kE5tVevk/KpAiPUXvI
	x5ztlSZWlvulwPUEM5BY+XXjrEcOiMKxAwvjiqtliRghfRIGMRa5TGyWcxR3vQju
	3C56wRrRZdf08bXD3jqhObIKBdjgDhDKK3lyW8nmUvkMDaKidxmczf72HHtEUUDZ
	ieDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762449388; x=1762535788; bh=PbSRi5YF8ulnyzfTjF/uI1gL0gNi
	o+7aFFGCbD2IxTY=; b=O7MJkcrFJAsOD54NH0aGaR2simbd6ow3NASkpIGU06xH
	qP5axsJSa+ffJ88J+yrrhzKiU2UwPskeIDizqlpcbPnw2eaE20KxBP0264kZwGL1
	b+NJIRzwByWiYl5bUlvDuXW0gOHOo5cyrM+ujrUpXU0gUSjgEr9+6au7NSybL6oZ
	eQa0jjNrLcb5rtFv3y+H7Cm7WN+VCYJ8kYes2yMnx+Nshh53D+E8Mnjvam52ej2y
	r7Pt3TlEtoxZXLLlPFIcGVO419tolfdL6zbtZTHy2a3kbAvY8+dyBrzJC6S73HZl
	Rj7f5ALdLJLTi4D3EpcgA8kwLqZDPm9HHCLInsMVPg==
X-ME-Sender: <xms:7NcMaTm9yfh_zwR2xrG8ZF41hGpHcAWNcS-wfbzuHKARsckPrZW8fg>
    <xme:7NcMaYXxE5IrVGFGNBHivA8B2LKuph4n4muLkzRMo8EKFfT9yqqzf5vwSLkwIX6mX
    Nj1OOfBUOpIyennwRUwLNmgbTU-z9sfhkRubzGXgdpgZxNtyfYA>
X-ME-Received: <xmr:7NcMaZsQLU9Lef3_Jpwg7wa8-mKCBoKbJ4DhpxdUlOzfX7g7aXg29-bKxGtWGefZvuONsu5xHeefYS8P27MdpmciXDFKA1x2JF8P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeihedtgeefjeehffdtkeevfeeutefgkeelfefhudejtdehkeeiudefkeehgedt
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvghsohhurhgtvgdrtg
    homhdpohhrrdgtiidpghhithhhuhgsrdgtohhmpdhushgvrhdrnhgrmhgvnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtqdhprggtkhgrghgvrhhssehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtth
    hopehlfihnsehlfihnrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:7NcMabat--_4ZOTN3tsGLcaCvkwtLrdNnUxeevB6QvMJVyMxy9XV8g>
    <xmx:7NcMaYXCO5oVKZxJuHpdi6M1DwfxCJa3FJm4QpzF3LWR0tE2hK1lZQ>
    <xmx:7NcMaQSSQvyOtSrkhcp1BsQ4cCCt5FEgrfUxB-6lfHJ_vEohLIS1TA>
    <xmx:7NcMaWMe-5PWRa7JHFlvgiqE7SvQZmc-2laFQEcZMFO7B0QEb3r_AA>
    <xmx:7NcMaVYNFrPPW4c-TEcb3fbN0-FXdk7lBMtuYhOhDbxbRK8X7VCo2P-g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 12:16:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.52.0-rc1
Date: Thu, 06 Nov 2025 09:16:26 -0800
Message-ID: <xmqqqzubhyj9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A release candidate Git v2.52.0-rc1 is now available for testing at
the usual places.  It is comprised of 606 non-merge commits since
v2.51.0, contributed by 80 people, 33 of which are new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.52.0-rc1' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.51.0 are as follows.
Welcome to the Git development community!

  Alexander Monakov, Cheng, Colin Stagner, Daniele Sassoli,
  Emily Yang, Evgeni Chasnovski, Evgeny Cherpak, Ezekiel Newren,
  Gregoire Geis, Igor Stepushchik, Isaac Oscar Gariano, Jake
  Zimmerman, Joe Drew, Julia Evans, KIYOTA Fumiya, Knut Harald
  Ryager, Kyle E. Mitchell, Langbart, Lauri Tirkkonen, Mikhail
  Malinouski, NeilBrown, Olamide Caleb Bello, Paulo Casaretto,
  Queen Ediri Jessa, Rick Sanders, Ruoyu Zhong, Simon Cheng,
  Solly, Thomas Uhle, Windl, Ulrich, Xinyu Ruan, Xi Ruoyao,
  and ノウラ | Flare.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, Aditya Garg, Ayush Chandekar, brian m. carlson,
  Christian Couder, Collin Funk, David Aguilar, D. Ben Knoble,
  Denton Liu, Derrick Stolee, Elijah Newren, Eric Sunshine,
  Eric W. Biederman, Ghanshyam Thakkar, Greg Hurrell, Han Jiang,
  Heiko Voigt, Jacob Keller, Jean-Noël Avila, Jeff King, Johannes
  Schindelin, Johannes Sixt, Jonathan Tan, Junio C Hamano, Justin
  Tobler, Karthik Nayak, Kristoffer Haugsbakk, Lidong Yan, Lucas
  Seiki Oshiro, Mark Levedahl, Meet Soni, M Hickford, Michael
  Lohmann, Michael Rappazzo, Patrick Steinhardt, Phillip Wood,
  Ramsay Jones, Randall S. Becker, René Scharfe, shejialuo,
  SZEDER Gábor, Taylor Blau, Todd Zullinger, Toon Claes, Torsten
  Bögershausen, Usman Akinyemi, and Дилян Палаузов.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.52 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * The "list" subcommand of "git refs" acts as a front-end for
   "git for-each-ref".

 * "git cmd --help-all" now works outside repositories.

 * "git diff-tree" learned "--max-depth" option.

 * A new subcommand "git repo" gives users a way to grab various
   repository characteristics.

 * A new command "git last-modified" has been added to show the closest
   ancestor commit that touched each path.

 * "git refs exists" that works like "git show-ref --exists" has been
   added.

 * "repo info" learns a short-hand option "-z" that is the same as
   "--format=nul", and learns to report the objects format used in the
   repository.

 * "core.commentChar=auto" that attempts to dynamically pick a
   suitable comment character is non-workable, as it is too much
   trouble to support for little benefit, and is marked as deprecated.

 * "git send-email" learned to drive "git imap-send" to store already
   sent e-mails in an IMAP folder.

 * The "promisor-remote" capability mechanism has been updated to
   allow the "partialCloneFilter" settings and the "token" value to be
   communicated from the server side.

 * Declare that "git init" that is not otherwise configured uses
   'main' as the initial branch, not 'master', starting Git 3.0.

 * Keep giving hint about the default initial branch name for users
   who may be surprised after Git 3.0 switch-over.

 * The stash.index configuration variable can be set to make "git stash
   pop/apply" pretend that it was invoked with "--index".

 * "git fast-import" learned that "--signed-commits=<how>" option that
   corresponds to that of "git fast-export".

 * Marking a hunk 'selected' in "git add -p" and then splitting made
   all the split pieces 'selected'; this has been changed to make them
   all 'undecided', which gives better end-user experience.

 * Configuration variables that take a pathname as a value
   (e.g. blame.ignorerevsfile) can be marked as optional by prefixing
   ":(optoinal)" before its value.

 * Show 'P'ipe command in "git add -p".

 * "git sparse-checkout" subcommand learned a new "clean" action to
   prune otherwise unused working-tree files that are outside the
   areas of interest.

 * "git fast-import" is taught to handle signed tags, just like it
   recently learned to handle signed commits, in different ways.

 * A new configuration variable commitGraph.changedPaths allows to
   turn "--changed-paths" on by default for "git commit-graph".

 * "Symlink symref" has been added to the list of things that will
   disappear at Git 3.0 boundary.

 * "git maintenance" command learns the "geometric" strategy where it
   avoids doing maintenance tasks that rebuilds everything from
   scratch.

 * "git repo structure", a new command.

 * The help text and manual page of "git bisect" command have been
   made consistent with each other.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * string_list_split*() family of functions have been extended to
   simplify common use cases.

 * Arrays of strbuf is often a wrong data structure to use, and
   strbuf_split*() family of functions that create them often have
   better alternatives.  Update several code paths and replace
   strbuf_split*().

 * Revision traversal limited with pathspec, like "git log dir/*",
   used to ignore changed-paths Bloom filter when the pathspec
   contained wildcards; now they take advantage of the filter when
   they can.

 * Doc lint updates to encourage the newer and easier-to-use
   `synopsis` format, with fixes to a handful of existing uses.

 * Remove dependency on the_repository and other globals from the
   commit-graph code, and other changes unrelated to de-globaling.

 * Discord has been added to the first contribution documentation as
   another way to ask for help.

 * Inspired by Ezekiel's recent effort to showcase Rust interface, the
   hash function implementation used to hash lines have been updated
   to the one used for ELF symbol lookup by Glibc.

 * Instead of scanning for the remaining items to see if there are
   still commits to be explored in the queue, use khash to remember
   which items are still on the queue (an unacceptable alternative is
   to reserve one object flag bits).

 * The bulk-checkin code used to depend on a file-scope static
   singleton variable, which has been updated to pass an instance
   throughout the callchain.

 * The work to build on the bulk-checkin infrastructure to create many
   objects at once in a transaction and to abstract it into the
   generic object layer continues.

 * CodingGuidelines now spells out how bitfields are to be written.

 * Adjust to the way newer versions of cURL selectively enable tracing
   options, so that our tests can continue to work.

 * The clear_alloc_state() API function was not fully clearing the
   structure for reuse, but since nobody reuses it, replace it with a
   variant that frees the structure as well, making the callers simpler.

 * "git range-diff" learned a way to limit the memory consumed by
   O(N*N) cost matrix.

 * Some places in the code confused a variable that is *not* a boolean
   to enable color but is an enum that records what the user requested
   to do about color.  A couple of bugs of this sort have been fixed,
   while the code has been cleaned up to prevent similar bugs in the
   future.

 * The build procedure based on meson learned a target to only build
   documentation, similar to "make doc".
   (merge ff4ec8ded0 ps/meson-build-docs later to maint).

 * Dip our toes a bit to (optionally) use Rust implemented helper
   called from our C code.

 * Documentation for "git log --pretty" options has been updated
   to make it easier to translate.

 * Instead of three library archives (one for git, one for reftable,
   and one for xdiff), roll everything into a single libgit.a archive.
   This would help later effort to FFI into Rust.

 * The beginning of SHA1-SHA256 interoperability work.

 * Build procedure for a few credential helpers (in contrib/) have
   been updated.

 * CI improvements to handle the recent Rust integration better.

 * The code in "git repack" machinery has been cleaned up to prepare
   for incremental update of midx files.

 * Two slightly different ways to get at "all the packfiles" in API
   has been cleaned up.

 * The code to walk revision graph to compute merge base has been
   optimized.

 * AI guidelines has been added to our documentation set.

 * Contributed credential helpers (obviously in contrib/) now have "cd
   $there && make install" target.

 * The "MyFirstContribution" tutorial tells the reader how to send out
   their patches; the section gained a hint to verify the message
   reached the mailing list.

 * The "debug" ref-backend was missing a method implementation, which
   has been corrected.


Fixes since v2.51
-----------------

Unless otherwise noted, all the changes in 2.51.X maintenance track,
including security updates, are included in this release.

 * During interactive rebase, using 'drop' on a merge commit lead to
   an error, which was incorrect.

 * "git refs migrate" to migrate the reflog entries from a refs
   backend to another had a handful of bugs squashed.

 * "git remote rename origin upstream" failed to move origin/HEAD to
   upstream/HEAD when origin/HEAD is unborn and performed other
   renames extremely inefficiently, which has been corrected.
   (merge 16c4fa26b9 ps/remote-rename-fix later to maint).

 * "git describe" has been optimized by using better data structure.
   (merge 08bb69d70f rs/describe-with-prio-queue later to maint).

 * "git push" had a code path that led to BUG() but it should have
   been a die(), as it is a response to a usual but invalid end-user
   action to attempt pushing an object that does not exist.

 * Various bugs about rename handling in "ort" merge strategy have
   been fixed.

 * "git jump" (in contrib/) fails to parse the diff header correctly
   when a file has a space in its name, which has been corrected.
   (merge 621ce9c1c6 gh/git-jump-pathname-with-sp later to maint).

 * "git diff --no-index" run inside a subdirectory under control of a
   Git repository operated at the top of the working tree and stripped
   the prefix from the output, and oddballs like "-" (stdin) did not
   work correctly because of it.  Correct the set-up by undoing what
   the set-up sequence did to cwd and prefix.

 * Various options to "git diff" that makes comparison ignore certain
   aspects of the differences (like "space changes are ignored",
   "differences in lines that match these regular expressions are
   ignored") did not work well with "--name-only" and friends.
   (merge b55e6d36eb ly/diff-name-only-with-diff-from-content later to maint).

 * The above caused regressions, which has been corrected.

 * Documentation for "git rebase" has been updated.
   (merge 3f7f2b0359 je/doc-rebase later to maint).

 * The start_delayed_progress() function in the progress eye-candy API
   did not clear its internal state, making an initial delay value
   larger than 1 second ineffective, which has been corrected.

 * The compatObjectFormat extension is used to hide an incomplete
   feature that is not yet usable for any purpose other than
   developing the feature further.  Document it as such to discourage
   its use by mere mortals.

 * "git log -L..." compared trees of multiple parents with the tree of the
   merge result in an unnecessarily inefficient way.
   (merge 0a15bb634c sg/line-log-merge-optim later to maint).

 * Under a race against another process that is repacking the
   repository, especially a partially cloned one, "git fetch" may
   mistakenly think some objects we do have are missing, which has
   been corrected.

 * "git fetch" can clobber a symref that is dangling when the
   remote-tracking HEAD is set to auto update, which has been
   corrected.

 * "git describe <blob>" misbehaves and/or crashes in some corner
   cases, which has been taught to exit with failure gracefully.
   (merge 7c10e48e81 jk/describe-blob later to maint).

 * Manual page for "gitk" is updated with the current maintainer's
   name.

 * Update the instructions for using GGG in the MyFirstContribution
   document to say that a GitHub PR could be made against `git/git`
   instead of `gitgitgadget/git`.

 * Makefile tried to run multiple "cargo build" which would not work
   very well; serialize their execution to work around this problem.

 * "git repack --path-walk" lost objects in some corner cases, which
   has been corrected.

 * "git ls-files <pathspec>..." should not necessarily have to expand
   the index fully if a sparsified directory is excluded by the
   pathspec; the code is taught to expand the index on demand to avoid
   this.
   (merge 681f26bccc ds/ls-files-lazy-unsparse later to maint).

 * Windows "real-time monitoring" interferes with the execution of
   tests and affects negatively in both correctness and performance,
   which has been disabled in Gitlab CI.

 * A broken or malicious "git fetch" can say that it has the same
   object for many many times, and the upload-pack serving it can
   exhaust memory storing them redundantly, which has been corrected.

 * A corner case bug in "git log -L..." has been corrected.

 * "git rev-parse --short" and friends failed to disambiguate two
   objects with object names that share common prefix longer than 32
   characters, which has been fixed.
   (merge 8655908b9e jc/longer-disambiguation-fix later to maint).

 * Some among "git add -p" and friends ignored color.diff and/or
   color.ui configuration variables, which is an old regression, which
   has been corrected.

 * "git subtree" (in contrib/) did not work correctly when splitting
   squashed subtrees, which has been improved.

 * Import a newer version of the clar unit testing framework.
   (merge 93dbb6b3c5 ps/clar-updates later to maint).

 * "git send-email --compose --reply-to=<address>" used to add
   duplicated Reply-To: header, which made mailservers unhappy.  This
   has been corrected.
   (merge f448f65719 nb/send-email-no-dup-reply-to later to maint).

 * "git rebase -i" failed to clean-up the commit log message when the
   command commits the final one in a chain of "fixup" commands, which
   has been corrected.

 * There are double frees and leaks around setup_revisions() API used
   in "git stash show", which has been fixed, and setup_revisions()
   API gained a wrapper to make it more ergonomic when using it with
   strvec-manged argc/argv pairs.
   (merge a04bc71725 jk/setup-revisions-freefix later to maint).

 * Deal more gracefully with directory / file conflicts when the files
   backend is used for ref storage, by failing only the ones that are
   involved in the conflict while allowing others.

 * "git last-modified" operating in non-recursive mode used to trigger
   a BUG(), which has been corrected.

 * The use of "git config get" command to learn how ANSI color
   sequence is for a particular type, e.g., "git config get
   --type=color --default=reset no.such.thing", isn't very ergonomic.
   (merge e4dabf4fd6 ps/config-get-color-fixes later to maint).

 * The "do you still use it?" message given by a command that is
   deeply deprecated and allow us to suggest alternatives has been
   updated.

 * Clang-format update to let our control macros be formatted the way we
   had them traditionally, e.g., "for_each_string_list_item()" without
   space before the parentheses.

 * A few places where a size_t value was cast to curl_off_t without
   checking has been updated to use the existing helper function.

 * "git reflog write" did not honor the configured user.name/email
   which has been corrected.

 * Handling of an empty subdirectory of .git/refs/ in the ref-files
   backend has been corrected.

 * Our CI script requires "sudo" that can be told to preserve
   environment, but Ubuntu replaced with "sudo" with an implementation
   that lacks the feature.  Work this around by reinstalling the
   original version.

 * The reftable backend learned to sanity check its on-disk data more
   carefully.
   (merge 466a3a1afd kn/reftable-consistency-checks later to maint).

 * A lot of code clean-up of xdiff.
   Split out of a larger topic.
   (merge 8b9c5d2e3a en/xdiff-cleanup later to maint).

 * "git format-patch --range-diff=... --notes=..." did not drive the
   underlying range-diff with correct --notes parameter, ending up
   comparing with different set of notes from its main patch output
   you would get from "git format-patch --notes=..." for a singleton
   patch.

 * The code in "git add -p" and friends to iterate over hunks was
   riddled with bugs, which has been corrected.

 * A few more things that patch authors can do to help maintainer to
   keep track of their topics better.
   (merge 1a41698841 tb/doc-submitting-patches later to maint).

 * An earlier addition to "git diff --no-index A B" to limit the
   output with pathspec after the two directories misbehaved when
   these directories were given with a trailing slash, which has been
   corrected.

 * The "--short" option of "git status" that meant output for humans
   and "-z" option to show NUL delimited output format did not mix
   well, and colored some but not all things.  The command has been
   updated to color all elements consistently in such a case.

 * Unicode width table update.

 * GPG signing test set-up has been broken for a year, which has been
   corrected.
   (merge 516bf45749 jc/t1016-setup-fix later to maint).

 * Recent OpenSSH creates the Unix domain socket to communicate with
   ssh-agent under $HOME instead of /tmp, which causes our test to
   fail doe to overly long pathname in our test environment, which has
   been worked around by using "ssh-agent -T".

 * strbuf_split*() to split a string into multiple strbufs is often a
   wrong API to use.  A few uses of it have been removed by
   simplifying the code.
   (merge 2ab72a16d9 ob/gpg-interface-cleanup later to maint).

 * "git shortlog" knows "--committer" and "--author" options, which
   the command line completion (in contrib/) did not handle well,
   which has been corrected.
   (merge c568fa8e1c kf/log-shortlog-completion-fix later to maint).

 * "git bisect" command did not react correctly to "git bisect help"
   and "git bisect unknown", which has been corrected.
   (merge 2bb3a012f3 rz/bisect-help-unknown later to maint).

 * The 'q'(uit) command in "git add -p" has been improved to quit
   without doing any meaningless work before leaving, and giving EOF
   (typically control-D) to the prompt is made to behave the same way.

 * The wildmatch code had a corner case bug that mistakenly makes
   "foo**/bar" match with "foobar", which has been corrected.
   (merge 1940a02dc1 jk/match-pathname-fix later to maint).

 * Tests did not set up GNUPGHOME correctly, which is fixed but some
   flaky tests are exposed in t1016, which needs to be addressed
   before this topic can move forward.
   (merge 6cd8369ef3 tz/test-prepare-gnupghome later to maint).

 * The patterns used in the .gitignore files use backslash in the way
   documented for fnmatch(3); document as such to reduce confusion.
   (merge 8a6d158a1d jk/doc-backslash-in-exclude later to maint).

 * The version of macos image used in GitHub CI has been updated to
   macos-14, as the macos-13 that we have been using got deprecated.
   (merge 73b9cdb7c4 jc/ci-use-macos-14 later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 529a60a885 ua/t1517-short-help-tests later to maint).
   (merge 22d421fed9 ac/deglobal-fmt-merge-log-config later to maint).
   (merge a60203a015 dk/t7005-editor-updates later to maint).
   (merge 16684b6fae ps/reftable-libgit2-cleanup later to maint).
   (merge e5c27bd3d8 je/doc-add later to maint).
   (merge 13296ac909 ps/object-store-midx-dedup-info later to maint).
   (merge f9a6705d9a tc/t0450-harden later to maint).
   (merge a66fc22bf9 rs/get-oid-with-flags-cleanup later to maint).
   (merge 15b8abde07 js/mingw-includes-cleanup later to maint).
   (merge 2cebca0582 tb/cat-file-objectmode-update later to maint).
   (merge 8f487db07a kh/doc-patch-id-1 later to maint).
   (merge f711f37b05 eb/t1016-hash-transition-fix later to maint).
   (merge 85333aa1af jk/test-delete-gpgsig-leakfix later to maint).

----------------------------------------------------------------

Changes since v2.51.0 are as follows:

Adam Dinwoodie (2):
      t/t1517: mark tests that fail with GIT_TEST_INSTALLED
      git-gui: sync Makefiles with git.git

Aditya Garg (3):
      send-email: add ability to send a copy of sent emails to an IMAP folder
      send-email: enable copying emails to an IMAP folder without actually sending them
      docs: update sendmail docs to use more secure SMTP server for Gmail

Alexander Monakov (1):
      xdiff: optimize xdl_hash_record_verbatim

Ayush Chandekar (2):
      environment: remove the global variable 'merge_log_config'
      builtin/fmt-merge-msg: stop depending on 'the_repository'

Christian Couder (15):
      promisor-remote: refactor to get rid of 'struct strvec'
      promisor-remote: allow a server to advertise more fields
      promisor-remote: use string constants for 'name' and 'url' too
      promisor-remote: refactor how we parse advertised fields
      promisor-remote: use string_list_split() in filter_promisor_remote()
      promisor-remote: allow a client to check fields
      promisor-remote: use string_list_split() in mark_remotes_as_accepted()
      gpg-interface: refactor 'enum sign_mode' parsing
      fast-import: add '--signed-commits=<mode>' option
      SubmittingPatches: add section about AI
      doc: git-tag: stop focusing on GPG signed tags
      lib-gpg: allow tests with GPGSM or GPGSSH prereq first
      t9350: properly count annotated tags
      fast-export: handle all kinds of tag signatures
      fast-import: add '--signed-tags=<mode>' option

Colin Stagner (1):
      contrib/subtree: fix split with squashed subtrees

D. Ben Knoble (10):
      parse-options: refactor flags for usage_with_options_internal
      builtin: also setup gently for --help-all
      t7005: use modern test style
      t7005: stop abusing --exec-path
      t7005: sanitize test environment for subsequent tests
      t3903: reduce dependencies on previous tests
      t3905: remove unneeded blank line
      stash: refactor private config globals
      stash: honor stash.index in apply, pop modes
      doc: explain the impact of stash.index on --autostash options

Daniele Sassoli (3):
      count-objects: document count-objects pack
      doc: add discord to ways of getting help
      doc: clarify which remotes can be used with GitGitGadget

David Aguilar (1):
      Makefile: build libgit-rs and libgit-sys serially

Denton Liu (3):
      t5516: remove surrounding empty lines in test bodies
      remote.c: remove BUG in show_push_unqualified_ref_name_error()
      remote.c: convert if-else ladder to switch

Derrick Stolee (17):
      path-walk: fix setup of pending objects
      path-walk: create initializer for path lists
      ls-files: conditionally leave index sparse
      midx-write: only load initialized packs
      midx-write: put failing response value back
      midx-write: use cleanup when incremental midx fails
      midx-write: use uint32_t for preferred_pack_idx
      midx-write: reenable signed comparison errors
      midx-write: simplify error cases
      sparse-checkout: remove use of the_repository
      sparse-checkout: add basics of 'clean' command
      sparse-checkout: match some 'clean' behavior
      dir: add generic "walk all files" helper
      sparse-checkout: add --verbose option to 'clean'
      sparse-index: point users to new 'clean' action
      t: expand tests around sparse merges and clean
      sparse-index: improve advice message instructions

Elijah Newren (8):
      merge-ort: update comments to modern testfile location
      merge-ort: drop unnecessary temporary in check_for_directory_rename()
      t6423: document two bugs with rename-to-self testcases
      t6423: fix missed staging of file in testcases 12i,12j,12k
      merge-ort: clarify the interning of strings in opt->priv->path
      merge-ort: fix incorrect file handling
      merge-ort: fix directory rename on top of source of other rename/delete
      Documentation/git-merge-tree.adoc: clarify the --merge-base option

Emily Yang (1):
      commit-graph: add new config for changed-paths & recommend it in scalar

Eric Sunshine (1):
      gitk: fix MacOS 10.14 "Mojave" crash on launch

Eric W. Biederman (1):
      t1016-compatObjectFormat: really freeze time for reproduciblity

Ezekiel Newren (14):
      xdiff: delete static forward declarations in xprepare
      xdiff: delete local variables and initialize/free xdfile_t directly
      xdiff: delete unnecessary fields from xrecord_t and xdfile_t
      xdiff: delete superfluous function xdl_get_rec() in xemit
      xdiff: delete local variables that alias fields in xrecord_t
      xdiff: delete struct diffdata_t
      xdiff: delete redundant array xdfile_t.ha
      xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
      xdiff: delete chastore from xdfile_t
      xdiff: rename rchg -> changed in xdfile_t
      make: delete XDIFF_LIB, add xdiff to LIB_OBJS
      make: delete REFTABLE_LIB, add reftable to LIB_OBJS
      xdiff: add macros DISCARD(0), KEEP(1), INVESTIGATE(2) in xprepare.c
      xdiff: change type of xdfile_t.changed from char to bool

Greg Hurrell (2):
      git-jump: make `diff` work with filenames containing spaces
      mailmap: consolidate multiple addresses into one

Heiko Voigt (1):
      git-gui: provide question helper for retry fallback on Windows

Jacob Keller (1):
      diff --no-index: fix logic for paths ending in '/'

Jean-Noël Avila (12):
      doc: test linkgit macros for well-formedness
      doc: check well-formedness of delimited sections
      doc: check for absence of multiple terms in each entry of desc list
      doc: check for absence of the form --[no-]parameter
      doc:git-for-each-ref: fix styling and typos
      doc lint: check that synopsis manpages have synopsis inlines
      doc: fix asciidoc format compatibility in pretty-formats.adoc
      doc: change the markup of paragraphs following a nested list item
      doc: convert git-stash.adoc to synopis style
      doc: convert git tag to synopsis style
      doc: convert git worktree to synopsis style
      doc: do not break sentences into "lego" pieces

Jeff King (47):
      combine-diff: zero memory used for callback filepairs
      diff: teach tree-diff a max-depth parameter
      describe: pass oid struct by const pointer
      describe: error if blob not found
      describe: catch unborn branch in describe_blob()
      t5510: make confusing config cleanup more explicit
      t5510: stop changing top-level working directory
      t5510: prefer "git -C" to subshell for followRemoteHEAD tests
      refs: do not clobber dangling symrefs
      describe: handle blob traversal with no commits
      describe: pass commit to describe_commit()
      fetch-pack: re-scan when double-checking graph objects
      curl: add support for curl_global_trace() components
      stash: pass --no-color to diff plumbing child processes
      add-interactive: respect color.diff for diff coloring
      add-interactive: manually fall back color config to color.ui
      contrib/diff-highlight: mention interactive.diffFilter
      color: use GIT_COLOR_* instead of numeric constants
      color: return enum from git_config_colorbool()
      grep: don't treat grep_opt.color as a strict bool
      diff: simplify color_moved check when flushing
      diff: don't use diff_options.use_color as a strict bool
      diff: pass o->use_color directly to fill_metainfo()
      diff: stop passing ecbdata->use_color as boolean
      pretty: use format_commit_context.auto_color as colorbool
      color: use git_colorbool enum type to store colorbools
      color: return bool from want_color()
      add-interactive: retain colorbool values longer
      config: store want_color() result in a separate bool
      stash: tell setup_revisions() to free our allocated strings
      revision: manage memory ownership of argv in setup_revisions()
      revision: add wrapper to setup_revisions() from a strvec
      treewide: use setup_revisions_from_strvec() when we have a strvec
      treewide: pass strvecs around for setup_revisions_from_strvec()
      revision: retain argv NULL invariant in setup_revisions()
      doc: fix indentation of refStorage item in git-config(1)
      diff: restore redirection to /dev/null for diff_from_contents
      status: make coloring of "-z --short" consistent
      diff: send external diff output to diff_options.file
      diff: drop save/restore of color_moved in dry-run mode
      diff: replace diff_options.dry_run flag with NULL file
      diff: drop dry-run redirection to /dev/null
      diff: simplify run_external_diff() quiet logic
      match_pathname(): reorder prefix-match check
      match_pathname(): give fnmatch one char of prefix context
      doc: document backslash in gitignore patterns
      test-tool: fix leak in delete-gpgsig command

Johannes Schindelin (13):
      git gui: set GIT_ASKPASS=git-gui--askpass if not set yet
      git-gui--askyesno: allow overriding the window title
      git-gui--askyesno (mingw): use Git for Windows' icon, if available
      http: offer to cast `size_t` to `curl_off_t` safely
      imap-send: be more careful when casting to `curl_off_t`
      http-push: avoid new compile error
      mingw: avoid relative `#include`s
      mingw: order `#include`s alphabetically
      refs: forbid clang to complain about unreachable code
      build(deps): bump actions/download-artifact from 4 to 5
      build(deps): bump actions/checkout from 4 to 5
      build(deps): bump actions/setup-python from 5 to 6
      build(deps): bump actions/github-script from 7 to 8

Johannes Sixt (6):
      rebase -i: permit 'drop' of a merge commit
      doc/gitk: update reference to the external project
      doc/format-patch: adjust Thunderbird MUA hint to new add-on
      progress: pay attention to (customized) delay time
      git-gui: fix error handling of Revert Changes command
      t7500: fix tests with absolute path following ":(optional)" on Windows

Jonathan Tan (1):
      mailmap: change primary address for Jonathan Tan

Julia Evans (26):
      doc: git-add: clarify intro & add an example
      doc: git-add: simplify discussion of ignored files
      doc: git-rebase: start with an example
      doc: git rebase: dedup merge conflict discussion
      doc: git rebase: clarify arguments syntax
      doc: git-rebase: move --onto explanation down
      doc: git-rebase: update discussion of internals
      doc: rephrase the purpose of the staging area
      doc: git-checkout: clarify intro sentence
      doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
      doc: git-checkout: clarify `git checkout <branch>`
      doc: git-checkout: clarify `-b` and `-B`
      doc: git-checkout: deduplicate --detach explanation
      doc: git-checkout: split up restoring files section
      doc: git-checkout: clarify restoring files section
      doc: git-push: create PUSH RULES section
      doc: git-push: rewrite refspec specification
      doc: git-push: clarify intro
      doc: add an UPSTREAM BRANCHES section to pull/push/fetch
      doc: git-push: clarify "where to push"
      doc: git-push: clarify "what to push"
      doc: git-push: add explanation of `git push origin main`
      doc: git-pull: move <repository> and <refspec> params
      doc: git-pull: clarify options for integrating remote branch
      doc: git-pull: delete the example
      doc: git-pull: clarify how to exit a conflicted merge

Junio C Hamano (62):
      string-list: report programming error with BUG
      string-list: align string_list_split() with its _in_place() counterpart
      string-list: unify string_list_split* functions
      string-list: optionally trim string pieces split by string_list_split*()
      diff: simplify parsing of diff.colormovedws
      string-list: optionally omit empty string pieces in string_list_split*()
      string-list: split-then-remove-empty can be done while splitting
      wt-status: avoid strbuf_split*()
      clean: do not pass strbuf by value
      clean: do not use strbuf_split*() [part 1]
      clean: do not pass the whole structure when it is not necessary
      clean: do not use strbuf_split*() [part 2]
      merge-tree: do not use strbuf_split*()
      notes: do not use strbuf_split*()
      config: do not use strbuf_split()
      environment: do not use strbuf_split*()
      sub-process: do not use strbuf_split*()
      trace2: trim_trailing_newline followed by trim is a no-op
      trace2: do not use strbuf_split*()
      diff: --no-index should ignore the worktree
      abbrev: allow extending beyond 32 chars to disambiguate
      config: document includeIf conditions consistently
      Start 2.52 cycle, the first batch
      The second batch
      The third batch
      The fourth batch
      The fifth batch
      The sixth batch
      The seventh batch
      The eighth batch
      The ninth batch
      The tenth batch
      initial branch: give hints after switching the default name
      The twelfth batch
      t7500: make each piece more independent
      The thirteenth batcn
      The fourteenth batch
      t7500: fix GIT_EDITOR shell snippet
      config: values of pathname type can be prefixed with :(optional)
      parseopt: values of pathname type can be prefixed with :(optional)
      The fifteenth batch
      The sixteenth batch
      The seventeenth batch
      t1016: make sure to use specified GPG
      The eighteenth batch
      The nineteenth batch
      Prepare for 2.51.1
      Git 2.51.1
      The twentieth batch
      The twenty-first batch
      The twenty-second batch
      diff: make sure the other caller of diff_flush_patch_quietly() is silent
      The twenty-third batch
      The twenty-fourth batch
      Git 2.51.2
      The 25th batch
      The 26th batch
      The 27th batch
      Git 2.52-rc0
      A bit more before rc1
      GitHub CI: macos-13 images are no more
      Git 2.52-rc1

Justin Tobler (18):
      bulk-checkin: introduce object database transaction structure
      bulk-checkin: remove global transaction state
      bulk-checkin: require transaction for index_blob_bulk_checkin()
      bulk-checkin: use repository variable from transaction
      bulk-checkin: remove ODB transaction nesting
      builtin/update-index: end ODB transaction when --verbose is specified
      bulk-checkin: drop flush_odb_transaction()
      object-file: relocate ODB transaction code
      object-file: update naming from bulk-checkin
      odb: add transaction interface
      clang-format: exclude control macros from SpaceBeforeParens
      builtin/repo: rename repo_info() to cmd_repo_info()
      ref-filter: allow NULL filter pattern
      ref-filter: export ref_kind_from_refname()
      builtin/repo: introduce structure subcommand
      builtin/repo: add object counts in structure output
      builtin/repo: add keyvalue and nul format for structure stats
      builtin/repo: add progress meter for structure stats

KIYOTA Fumiya (1):
      completion: complete some 'git log' options

Karthik Nayak (13):
      Documentation: note styling for bit fields
      refs/files: catch conflicts on case-insensitive file-systems
      refs/files: use correct error type when lock exists
      refs/files: handle F/D conflicts in case-insensitive FS
      refs/files: handle D/F conflicts during locking
      refs/ref-cache: fix SEGFAULT when seeking in empty directories
      refs: remove unused headers
      refs: move consistency check msg to generic layer
      reftable: check for trailing newline in 'tables.list'
      Documentation/fsck-msgids: remove duplicate msg id
      fsck: order 'fsck_msg_type' alphabetically
      reftable: add code to facilitate consistency checks
      refs/reftable: add fsck check for checking the table name

Knut Harald Ryager (1):
      docs: remove stray bracket from git-clone synopsis

Kristoffer Haugsbakk (24):
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
      range-diff: rename other_arg to log_arg
      revision: add rdiff_log_arg to rev_info
      format-patch: handle range-diff on notes correctly for single patches
      doc: patch-id: fix accidental literal blocks
      doc: fix accidental literal blocks
      doc: patch-id: convert to the modern synopsis style
      RelNotes: minor fixups before 2.51.1
      RelNotes: sync with Git 2.51.1 fixups
      doc: git-checkout: fix placeholder markup

Kyle E. Mitchell (1):
      doc: fix formatting of function-wrap shell alias

Lidong Yan (3):
      diff: ensure consistent diff behavior with ignore options
      bloom: enable bloom filter with wildcard pathspec in revision traversal
      diff: stop output garbled message in dry run mode

Lucas Seiki Oshiro (7):
      repo: declare the repo command
      repo: add the field references.format
      repo: add the field layout.bare
      repo: add the field layout.shallow
      repo: add the --format flag
      repo: add the flag -z as an alias for --format=nul
      repo: add the field objects.format

M Hickford (1):
      docs/gitcredentials: describe URL prefix matching

Mark Levedahl (15):
      git-gui: simplify PATH de-duplication
      git-gui: simplify using nice(1)
      gitk: use themed spinboxes
      gitk: make sha1but a ttk::button
      gitk: use config variables to define and load a theme
      gitk: do not invoke tk_setPalette
      gitk: use text labels for commit ID buttons
      gitk: use text labels for next/prev search buttons
      gitk: eliminate Interface color option from gui
      gitk: eliminate unused ui color variables
      gitk: add proc run_themeloader
      gitk: add theme selection to color configuration page
      gitk: make configuration dialog resizing useful
      gitk: separate code blocks for configuration dialog
      gitk: set minimum size on configuration dialog

Meet Soni (19):
      doc: factor out common option
      builtin/for-each-ref: align usage string with the man page
      builtin/for-each-ref: factor out core logic into a helper
      builtin/refs: add list subcommand
      t6300: refactor tests to be shareable
      t: add test for git refs list subcommand
      builtin/refs: add 'exists' subcommand
      t1403: split 'show-ref --exists' tests into a separate file
      t1422: refactor tests to be shareable
      t: add test for git refs exists subcommand
      refs: add a generic 'optimize' API
      files-backend: implement 'optimize' action
      reftable-backend: implement 'optimize' action
      builtin/pack-refs: convert to use the generic refs_optimize() API
      builtin/pack-refs: factor out core logic into a shared library
      doc: pack-refs: factor out common options
      builtin/refs: add optimize subcommand
      t0601: refactor tests to be shareable
      t: add test for git refs optimize subcommand

Michael Lohmann (1):
      builtin/reflog: respect user config in "write" subcommand

Michael Rappazzo (2):
      gitk: add README with usage, build, and contribution details
      gitk: fix error when remote tracking branch is deleted

Mikhail Malinouski (1):
      docs: fix typo in worktree.adoc 'extension'

NeilBrown (1):
      send-email: don't duplicate Reply-to: in intro message

Olamide Caleb Bello (2):
      gpg-interface: do not use misdesigned strbuf_split*()
      gpg-interface: do not use misdesigned strbuf_split*()

Patrick Steinhardt (113):
      Documentation/git-reflog: convert to use synopsis type
      builtin/reflog: improve grouping of subcommands
      refs: export `ref_transaction_update_reflog()`
      builtin/reflog: implement subcommand to write new entries
      ident: fix type of string length parameter
      refs: fix identity for migrated reflogs
      refs/files: detect race when generating reflog entry for HEAD
      refs: stop unsetting REF_HAVE_OLD for log-only updates
      refs: fix invalid old object IDs when migrating reflogs
      refs: pass refname when invoking reflog entry callback
      refs: simplify logic when migrating reflog entries
      builtin/remote: fix sign comparison warnings
      builtin/remote: determine whether refs need renaming early on
      builtin/remote: rework how remote refs get renamed
      builtin/remote: only iterate through refs that are to be renamed
      odb: store locality in object database sources
      odb: allow `odb_find_source()` to fail
      odb: consistently use "dir" to refer to alternate's directory
      odb: return newly created in-memory sources
      odb: simplify calling `link_alt_odb_entry()`
      midx: drop redundant `struct repository` parameter
      midx: load multi-pack indices via their source
      midx: write multi-pack indices via their source
      midx: stop duplicating info redundant with its owning source
      midx: compute paths via their source
      reftable/writer: fix type used for number of records
      reftable/writer: drop Git-specific `QSORT()` macro
      reftable/stack: reorder code to avoid forward declarations
      reftable/stack: fix compiler warning due to missing braces
      reftable/stack: allow passing flags to `reftable_stack_add()`
      reftable/stack: handle outdated stacks when compacting
      reftable: don't second-guess errors from flock interface
      refs/reftable: always reload stacks when creating lock
      commit-graph: stop using `the_hash_algo` via macros
      commit-graph: store the hash algorithm instead of its length
      commit-graph: refactor `parse_commit_graph()` to take a repository
      commit-graph: stop using `the_hash_algo`
      commit-graph: stop using `the_repository`
      commit-graph: stop passing in redundant repository
      gitlab-ci: disable realtime monitoring to unbreak Windows jobs
      blame: drop explicit check for commit graph
      revision: drop explicit check for commit graph
      commit-graph: return the prepared commit graph from `prepare_commit_graph()`
      commit-graph: return commit graph from `repo_find_commit_pos_in_graph()`
      commit-graph: pass graphs that are to be merged as parameter
      t5530: modernize tests
      upload-pack: don't ACK non-commits repeatedly in protocol v2
      t/unit-tests: update clar to fcbed04
      odb: drop deprecated wrapper functions
      meson: introduce a "docs" alias to compile documentation only
      meson: print docs backend as part of the summary
      ci: don't compile whole project when testing docs with Meson
      t1300: write test expectations in the test's body
      t1300: small style fixups
      builtin/config: do not die in `get_color()`
      builtin/config: special-case retrieving colors without a key
      builtin/config: do not spawn pager when printing color codes
      t/unit-tests: update to 10e96bc
      packfile: introduce a new `struct packfile_store`
      odb: move list of packfiles into `struct packfile_store`
      odb: move initialization bit into `struct packfile_store`
      odb: move packfile map into `struct packfile_store`
      odb: move MRU list of packfiles into `struct packfile_store`
      odb: move kept cache into `struct packfile_store`
      packfile: reorder functions to avoid function declaration
      packfile: refactor `prepare_packed_git()` to work on packfile store
      packfile: split up responsibilities of `reprepare_packed_git()`
      packfile: refactor `install_packed_git()` to work on packfile store
      packfile: introduce function to load and add packfiles
      packfile: move `get_multi_pack_index()` into "midx.c"
      packfile: refactor `get_packed_git()` to work on packfile store
      packfile: refactor `get_all_packs()` to work on packfile store
      packfile: refactor `get_packed_git_mru()` to work on packfile store
      meson: add infrastructure to build internal Rust library
      Makefile: reorder sources after includes
      Makefile: introduce infrastructure to build internal Rust library
      help: report on whether or not Rust is enabled
      varint: use explicit width for integers
      varint: reimplement as test balloon for Rust
      BreakingChanges: announce Rust becoming mandatory
      ci: convert "pedantic" job into full build with breaking changes
      ci: enable Rust for breaking-changes jobs
      gitlab-ci: dedup instructions to disable realtime monitoring
      gitlab-ci: ignore failures to disable realtime monitoring
      gitlab-ci: drop workaround for Python certificate store on Windows
      gitlab-ci: upload Meson test logs as JUnit reports
      t8020: fix test failure due to indeterministic tag sorting
      ci: fix broken jobs on Ubuntu 25.10 caused by switch to sudo-rs(1)
      ci: deduplicate calls to `apt-get update`
      ci: check formatting of our Rust code
      rust/varint: add safety comments
      ci: check for common Rust mistakes via Clippy
      ci: verify minimum supported Rust version
      rust: support for Windows
      refs/files: deprecate writing symrefs as symbolic links
      object-name: convert to use `packfile_store_get_all_packs()`
      builtin/gc: convert to use `packfile_store_get_all_packs()`
      builtin/grep: simplify how we preload packs
      packfile: drop `packfile_store_get_packs()`
      packfile: introduce macro to iterate through packs
      packfile: rename `packfile_store_get_all_packs()`
      t7528: work around ETOOMANY in OpenSSH 10.1 and newer
      builtin/gc: remove global `repack` variable
      builtin/gc: make `too_many_loose_objects()` reusable without GC config
      builtin/maintenance: introduce "geometric-repack" task
      builtin/maintenance: make the geometric factor configurable
      builtin/maintenance: don't silently ignore invalid strategy
      builtin/maintenance: improve readability of strategies
      builtin/maintenance: run maintenance tasks depending on type
      builtin/maintenance: extend "maintenance.strategy" to manual maintenance
      builtin/maintenance: make "gc" strategy accessible
      builtin/maintenance: introduce "geometric" strategy
      t7900: fix a flaky test due to git-repack always regenerating MIDX

Paulo Casaretto (1):
      range-diff: add configurable memory limit for cost matrix

Phillip Wood (12):
      xdiff: refactor xdl_hash_record()
      breaking-changes: deprecate support for core.commentString=auto
      config: warn on core.commentString=auto
      commit: print advice when core.commentString=auto
      breaking-changes: switch default branch to main
      t4013: switch default branch name to main
      t9902: switch default branch name to main
      t0613: stop setting default initial branch
      rebase -i: respect commit.cleanup when picking fixups
      sequencer: remove VERBATIM_MSG flag
      add -p: mark split hunks as undecided
      add-patch: update hunk splitability after editing

Queen Ediri Jessa (1):
      MyFirstContribution: add note on confirming patches

Ramsay Jones (6):
      t6137-*.sh: fix test failure on cygwin
      doc: add some missing technical documents
      doc: remembering-renames.adoc: fix asciidoc warnings
      doc: sparse-checkout.adoc: fix asciidoc warnings
      doc: commit-graph.adoc: fix up some formatting
      doc: add large-object-promisors.adoc to the docs build

René Scharfe (15):
      describe: use prio_queue
      describe: use prio_queue_replace()
      describe: use oidset in finish_depth_computation()
      object-name: declare pointer type of extend_abbrev_len()'s 2nd parameter
      use repo_get_oid_with_flags()
      add-patch: improve help for options j, J, k, and K
      add-patch: document that option J rolls over
      add-patch: let options y, n, j, and e roll over to next undecided
      add-patch: let options k and K roll over like j and J
      add-patch: let options a and d roll over like y and n
      add-patch: reset "permitted" at loop start
      add-patch: fully document option P
      commit-reach: avoid commit_list_insert_by_date()
      add-patch: quit without skipping undecided hunks
      add-patch: quit on EOF

Ruoyu Zhong (4):
      gitk: use <Button-3> for ctx menus on macOS with Tcl 8.7+
      gitk: fix trackpad scrolling for Tcl/Tk 8.7+
      bisect: fix handling of `help` and invalid subcommands
      bisect: update usage and docs to match each other

SZEDER Gábor (6):
      line-log: fix assertion error
      line-log: show all line ranges touched by the same diff range
      line-log: avoid unnecessary tree diffs when processing merge commits
      line-log: get rid of the parents array in process_ranges_merge_commit()
      line-log: initialize diff queue in process_ranges_ordinary_commit()
      line-log: simplify condition checking for merge commits

Solly (1):
      t2401: update path checks using test_path helpers

Taylor Blau (52):
      SubmittingPatches: extend release-notes experiment to topic names
      SubmittingPatches: guidance for multi-series efforts
      builtin/cat-file.c: simplify calling `report_object_status()`
      builtin/repack.c: avoid "the_repository" in `cmd_repack()`
      builtin/repack.c: avoid "the_repository" in existing packs API
      builtin/repack.c: avoid "the_repository" when taking a ref snapshot
      builtin/repack.c: avoid "the_repository" when removing packs
      builtin/repack.c: avoid "the_repository" when repacking promisor objects
      builtin/repack.c: avoid "the_hash_algo" when deleting packs
      builtin/repack.c: avoid "the_hash_algo" in `write_oid()`
      builtin/repack: avoid "the_hash_algo" in `repack_promisor_objects()`
      builtin/repack.c: avoid "the_hash_algo" in `finish_pack_objects_cmd()`
      builtin/repack.c: avoid using `hash_to_hex()` in pack geometry
      repack: introduce new compilation unit
      builtin/repack.c: pass both pack_objects args to repack_config
      repack: move 'delta_base_offset' to 'struct pack_objects_args'
      repack: remove 'prepare_pack_objects' from the builtin
      builtin/repack.c: rename many 'struct existing_packs' functions
      repack: remove 'remove_redundant_pack' from the builtin
      builtin/repack.c: pass "packdir" when removing packs
      builtin/repack.c: avoid unnecessary numeric casts in existing_packs
      repack: remove 'existing_packs' API from the builtin
      builtin/repack.c: rename "struct generated_pack_data"
      builtin/repack.c: factor out "generated_pack_install"
      builtin/repack.c: pass "packtmp" to `generated_pack_populate()`
      builtin/repack.c: provide pack locations to `generated_pack_install()`
      repack: remove 'generated_pack' API from the builtin
      builtin/repack.c: pass "packtmp" to `repack_promisor_objects()`
      builtin/repack.c: remove "repack_promisor_objects()" from the builtin
      builtin/repack.c: rename various pack_geometry functions
      builtin/repack.c: pass 'pack_kept_objects' to `pack_geometry_init()`
      builtin/repack.c: pass 'packdir' to `pack_geometry_remove_redundant()`
      repack: remove pack_geometry API from the builtin
      builtin/repack.c: remove ref snapshotting from builtin
      builtin/repack.c: extract opts struct for 'write_midx_included_packs()'
      builtin/repack.c: use a string_list for 'midx_pack_names'
      repack: keep track of MIDX pack names using existing_packs
      builtin/repack.c: reorder `remove_redundant_bitmaps()`
      builtin/repack.c: inline `remove_redundant_bitmaps()`
      builtin/repack.c: pass `repack_write_midx_opts` to `midx_included_packs`
      builtin/repack.c: inline packs within `write_midx_included_packs()`
      repack: 'write_midx_included_packs' API from the builtin
      builtin/repack.c: introduce `struct write_pack_opts`
      builtin/repack.c: use `write_pack_opts` within `write_cruft_pack()`
      repack: move `find_pack_prefix()` out of the builtin
      repack: extract `write_pack_opts_is_local()`
      builtin/repack.c: pass `write_pack_opts` to `finish_pack_objects_cmd()`
      repack: move `finish_pack_objects_cmd()` out of the builtin
      repack: move `pack_kept_objects` to `struct pack_objects_args`
      repack: move `write_filtered_pack()` out of the builtin
      repack: move `write_cruft_pack()` out of the builtin
      builtin/repack.c: clean up unused `#include`s

Thomas Uhle (2):
      contrib/credential: harmonize Makefiles
      contrib/credential: add install target

Todd Zullinger (2):
      t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
      t/lib-gpg: call prepare_gnupghome() in GPG2 prereq

Toon Claes (7):
      within_depth: fix return for empty path
      t0450: fix test for out-of-tree builds
      last-modified: new subcommand to show when files were last modified
      t/perf: add last-modified perf script
      last-modified: use Bloom filters when available
      t0450: add allowlist for builtins with missing .adoc
      last-modified: fix bug when some paths remain unhandled

Torsten Bögershausen (1):
      unicode: update the width tables to Unicode 17

Usman Akinyemi (3):
      t/t1517: automate `git subcmd -h` tests outside a repository
      t5200: move `update-server-info -h` test from t1517
      t5304: move `prune -h` test from t1517

Xinyu Ruan (1):
      refs: add missing remove_on_disk implementation for debug backend

brian m. carlson (10):
      docs: note that extensions.compatobjectformat is incomplete
      docs: update pack index v3 format
      docs: update offset order for pack index v3
      docs: reflect actual double signature for tags
      docs: improve ambiguous areas of pack format documentation
      docs: add documentation for loose objects
      rev-parse: allow printing compatibility hash
      fsck: consider gpgsig headers expected in tags
      t: allow specifying compatibility hash
      t1010: use BROKEN_OBJECTS prerequisite

shejialuo (4):
      string-list: use bool instead of int for "exact_match"
      string-list: replace negative index encoding with "exact_match" parameter
      string-list: change "string_list_find_insert_index" return type to "size_t"
      refs: enable sign compare warnings check

ノウラ | Flare (1):
      alloc: fix dangling pointer in alloc_state cleanup

