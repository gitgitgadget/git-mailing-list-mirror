Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41252D2D5;
	Thu, 10 Sep 2026 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060867; cv=none; b=CACz2rY2FcFcTSC4sy2o35Rr1MiCyrqo7ookxhUJRr1xQZx/3QkkRPND8JG5/XqFuy0gEIOsg1Nfw55EX/HY/ianMmb7SDMisEOaSziulMkHZ6448w0fBdxIpeQFZ7cZgvjWGa15xWKjngu2Lm4ss2uOcVjDHIok10Pl46xonpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060867; c=relaxed/simple;
	bh=whmxmGDIjOfibch3r8srpCCy9T0jAVp3jbKO31QW6IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPZvWy5IY5tyNlSPz1xZjk5k3s99UZCx8qAt98Zew+XjCp6CBOH3xsdxPahVE4SyCebBiQRzMm1lXWpKMkevOMLDzmyEknEUnKVuVcD0jhSZtW5HuIUNJnt7IeafAz73+8SZx0P8aUJAFF9wx+iqcQm4Eg1PW8Ds7M0YkIs9BlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RZk35EI6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0VozwXS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RZk35EI6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0VozwXS"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B07AFEC0188;
	Thu, 10 Sep 2026 13:20:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 10 Sep 2026 13:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1789060823; x=1789147223; bh=vW
	+07KPaPrxcA5TRyMa9fr2zvVPYL2K2cjcwmuGCS3g=; b=RZk35EI6119ug3ueeN
	+vTBS4+SaEh727Nt5CjIXb2+afDNsVr3KUi1skL3dCeQZKge3kxuUynSRi+3BziA
	Ez7qFkF8xK58xqeWtxvMj3F8qzPgrJ+ITzc+ffCaWGKTtN7bn1uwf1eNQATNOS0H
	Ljd/iLLHSdRz8WbDwhrTNRsb5jRK3AbLCOWnoDsMLCeTE30t6cZyRBpT9VgFS07I
	3sXJsxwVOv5AXArkASQNVjIU0hekfU/FYvHxg5kPVl7w2t9gmTE42xcRDBS5GqCb
	jnvLQWLkX8jB2JIVxWGqotpSW+RKbPFMNcSesxvTV2urdBVTr1Fy7vK/BlosOnk4
	m6cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1789060823; x=1789147223; bh=vW+07KPaPrxcA5TRyMa9fr2zvVPY
	L2K2cjcwmuGCS3g=; b=p0VozwXSCSthDM5KcPiCvGBYTh48U91NB3iR7hEF5ijc
	dV5tG+H5beLsrRwzbhrZbOmOqlcfeavHfeY4KZDGDzvADzU+LkEbqEGawZicysab
	cMkp+l1QQsDk/Gj8QVRNz2yQgxTZibKAppRQgKwzuUS49K8lJNVJasAGHGLwJLgD
	K4jeX2O7cgjBMCFZsUATqHyRHo9ppoc7rQRXOXYsHQSnWEU2HFgR0GjpRWPBPwJj
	NTfbQip51zEeBYW6hPxeCabmt9VbRHE8kldl+JJ6QEitb27d8O34Sc1vhGmNCR9M
	qhi3UeUhL+btauP9i/7f2UbExVv/ex4PDn5xizl7dg==
X-ME-Sender: <xms:1-aiakwKChN6Hl8PinyVF8R-nq8juTOTYcd3zhs_QokgYWwUx34Pug>
    <xme:1-aiahkahGq9NK6UYU9n0DsXD0-N7lNCY3YdSqDI8cqAtr-R4l7kNVPzUszTnvnKV
    XeSWT88pMPvIuuKjVpIym1bgQjZdrHKc6U91FE6_8cy6V1bCK9Gj4k>
X-ME-Received: <xmr:1-aiatlhMy0VQ7WjTSPaoZ2z8502DT5FgVQAxou_AjEB_s5XGBcC7-snOx0GCpwvbFDX8HtvaxMhBoG7sCuMmx-wgfLVAnN6nTjb>
X-ME-Proxy-Cause: dmFkZTGM6nECd1U/FsQ5UFopom8wYlPtvlNjFkSa/1zcjZVFWfxkafDJCX8VhcUzZT4IHw
    2mY26p5EGdXpRdXVQD1jsvlyBKuh8TbaevCKQdwhoA3sFPAOqTFVPtYZKOJ+dy7E3/UANp
    CmEKaLdEO4sWViKC0dGPRMXNkPIOxdTiaJM1/R+yqD7Rns7FzoHk56v42rc1ihZQ5Puq+D
    PXwA9JxDErpxu3zabWlh4GDnPbgaLfFiT+tECORsMBGUfJdC4NR/UDrjH+wGRaptkmRTBZ
    LODdW6HI8t4G2sa8i/ZnHjakw6mgzmPYEeXCd5EWB+ua/174unvn5g04sNJic0LM8zJxq9
    aGiU/8jhvkzhLhSZMnB15DAi6Aj9gxOM4zOERPa1tlsF/qrmTbvLU1XVS1htbgveZTIn8m
    zYSeTZ9vAWEiWcgxeSQVnCnsUuU4KnWFRa3pIM9XjrAB3wQJwxgjRg65mZiVHKmSlhVO0b
    idCftDvvPrLmf8yTUH0UJwocb0TmRaadp8kXJB0REyM7znt1j3sqB9DUw1pgweyzd+bvfi
    etcvQOeEk0S1wpGAJ7TG6VcHeb+sACVx1Ai13L0u2pSx1x4xC6OE2aFBDkFBdsjHlqzEJ+
    8Cc7nJykUuXOqdAr3g5meqs79ztrGbDrIyVjWWzPULYw/ecIiwNJuHzZJ9lA
X-ME-Proxy: <xmx:1-aiajy-BVrpDPWyMYtigugghyq7u2NEy9qKZ9UnD9DY3MTrNo1Kbw>
    <xmx:1-aiaipetPIuOaBKvN76A3qfwc9PMJXItv39po_u1ZHdh8JjC22izA>
    <xmx:1-aiai7Y65yiPV819SAxBrswl6GA99vT7JkfDgD8qLdi2FF98SoFMg>
    <xmx:1-aiapc7UM7hikaehkEtjIyPe8ZDDb-OD_T7AvHvmMfk6Txv3iDBmw>
    <xmx:1-aianJWCM0FbfQRNn1aoJp8qpq-w3brXfmVPPmE1QnrfOEbimYf6xuz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 13:20:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.56.0-rc0
Date: Thu, 10 Sep 2026 10:20:21 -0700
Message-ID: <xmqqecf1f2ga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

An early preview release Git v2.56.0-rc0 is now available for
testing at the usual places.  It is comprised of 635 non-merge
commits since v2.55.0, contributed by 82 people, 32 of which are
new faces [*].

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.56.0-rc0' tag and the 'master' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

New contributors whose contributions weren't in v2.55.0 are as follows.
Welcome to the Git development community!

  Adrian Friedli, Alan Stokes, Antonio De Stefani, basuradeluis,
  Brendan Jackman, Chen Linxuan, Colin Hinton, Dominique Martinet,
  Éric NICOLAS, Friel, Gatla Vishweshwar Reddy, Hardik Kumar,
  Henrique Ferreiro, Ihar Hrachyshka, Jamie Magee, Justin Lee,
  Kenneth Lorber, Lucas Zamboni Orioli, Lutz Lengemann, Marcelo
  Machado Lage, Mike Gilbert, Nicolas Le Cam, Nikolaus Schuetz,
  oxsignal, Shlok Kulshreshtha, Swapnil Saste | INDIA, Ted Nyman,
  Travor Liu, Vincent Mailhol, Vinicius Lira de Freitas, xuqing
  yang, and Yoichi NAKAYAMA.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Shopov, Ayush Chandekar, brian m. carlson, Calvin Wan,
  Chandra Pratap, Christian Couder, David Lin, D. Ben Knoble,
  Derrick Stolee, Elijah Newren, Eric Ju, Harald Nordgren,
  Jean-Noël Avila, Jeff King, Jerry Zhang, Johannes Schindelin,
  Johannes Sixt, Jonathan Tan, Jörg Thalheim, Junio C Hamano,
  Justin Tobler, Karthik Nayak, K Jayatheerth, Kristofer Karlsson,
  Kristoffer Haugsbakk, Lucas Seiki Oshiro, Mantas Mikulėnas,
  Matt Hunter, Michael Montalbo, Miklos Vajna, Olamide Caleb Bello,
  Pablo Sabater, Patrick Steinhardt, Peter Colberg, Philip Oakley,
  Phillip Wood, Randall Becker, René Scharfe, Sahitya Chandra,
  Shardul Natu, Siddharth Asthana, Siddharth Shrimali, Stefan
  Haller, SZEDER Gábor, Tamir Duberstein, Taylor Blau, Tian
  Yuchen, Toon Claes, Uwe Kleine-König, and Weijie Yuan.

[*] We are counting not just the authorship contribution but issue
    reporting, mentoring, helping and reviewing that are recorded in
    the commit trailers.

----------------------------------------------------------------

Git v2.56 Release Notes (draft)
===============================

UI, Workflows & Features
------------------------

 * Advice shown by "git status" when the local branch is behind or has
   diverged from its push branch has been updated to suggest "git pull
   <remote> <branch>".

 * The handling of promisor-remote protocol capability has been updated
   to allow the other side to add to the list of promisor remotes via the
   'promisor.acceptFromServerURL' configuration variable.

 * The 'ort' merge backend has been hardened against corrupt trees by
   ensuring it aborts under appropriate error conditions.

 * The `fetch.followRemoteHEAD` configuration variable has been added to
   provide a default for the per-remote `remote.<name>.followRemoteHEAD`
   setting.

 * "git log --follow" has been updated to better handle non-linear
   history, in which the path being tracked gets renamed differently in
   multiple history lines.

 * The "git repo info" command has been taught new keys to output both
   absolute and relative paths for "gitdir" and "commondir", supported by
   a new path-formatting helper extracted from "git rev-parse".

 * When 'git push origin/main' or 'git branch origin main' is run, the
   command is now recognized as a potential typo, and advice has been
   added to offer a typo fix.

 * The 'git refs' toolbox has been extended with new 'create', 'delete',
   'update', and 'rename' subcommands to create, delete, update, and
   rename references, respectively.

 * The experimental 'git history' command has been taught a new 'drop'
   subcommand to remove a commit, with its descendants replayed onto its
   parent.

 * The alignment of commit object name abbreviations in 'git blame'
   output has been optimized to reserve a column for marks (caret,
   question mark, or asterisk) only when such marks are actually shown.

 * Option parsing with 'git rev-parse --parseopt' and in most 'git'
   subcommands has been updated to exit with 0 (instead of 129) when the
   help option ('-h' or '--help') is requested directly by the user,
   aligning with standard Unix convention.

 * The '[includeIf "condition"]' conditional inclusion facility for
   configuration files has been taught to use the location of the
   worktree in its condition.

 * The usage string and SYNOPSIS for 'git fast-export' have been
   standardized to make them consistent with each other and with other
   commands.

 * 'git log --graph' has been modified to visually distinguish parentless
   'root' commits (and commits that become roots due to history
   simplification) by indenting them, preventing them from appearing
   falsely related to unrelated commits rendered immediately above them.

 * Userdiff patterns for Swift have been added, with support for
   Swift-specific constructs such as attributes, modifiers, failable
   initializers, and generics.

 * Configuration file locking has been updated to retry for a short
   period, avoiding failures when multiple processes attempt to update
   the configuration simultaneously.

 * The 'remote-object-info' command has been added to 'git cat-file
   --batch-command', allowing clients to request object metadata
   (currently size) from a remote server via protocol v2 without
   downloading the entire object.  Format placeholders are dynamically
   filtered on the client based on server-advertised capabilities,
   returning empty strings for inapplicable or unsupported fields.

 * 'git branch -d' has been taught to report when a branch cannot be
   deleted because it is being used in an active bisect run.

 * 'git mv' has been updated to check for a missing destination
   leading directory during the checking phase, allowing 'git mv -n'
   to report the failure.  The error message when the rename(2)
   syscall fails has also been improved to name both the source and
   the destination.

 * 'git add' has been taught a new '--resolved' option to stage
   conflict-resolved paths, while leaving unrelated local changes
   unstaged.  It scans the unmerged paths for leftover conflict
   markers and aborts if any are found.

 * The known limitations of the ref format migration in 'git refs' have
   been moved to be displayed as a warning admonition directly under the
   description of the 'migrate' subcommand, improving visibility.  A
   reference to 'git-maintenance' has also been corrected to use the
   'linkgit' macro.

 * The 'git bisect' command has been taught a
   '--reset-when-found[=<where>]' option that tells the command to
   automatically run 'git bisect reset' to jump back to the original
   state or to the found culprit.

 * The 'git branch' command has been taught the '--delete-merged' option
   to remove local branches that are already merged into their tracked
   remote-tracking branches.

 * The 'remote-object-info' command for 'git cat-file --batch-command'
   has been extended to support the '%(objecttype)' placeholder.

 * The usage string of 'git fast-import' has been updated to use the
   parse_options() API for displaying help, and its SYNOPSIS in the
   documentation has been standardized to match.

 * The error message given by 'git send-email' when a message file is
   missing a 'Subject:' header has been clarified, and the error string
   is now terminated with a newline so that Perl avoids appending its
   internal source location data.

 * The '--shallow-file' option of 'git' command requires a value, but the
   code did not check the presence of a value and instead segfaulted
   without one, which has been corrected.

 * 'git repack' has been taught '--drop-filtered' to delete local
   promisor blobs exceeding a limit (currently 'blob:limit=') in partial
   clones, reclaiming space.  Guards prevent running during other
   operations or if referenced by the index.

 * The documentation for 'git format-rev' has been updated to use the
   [synopsis] block definition on code blocks to properly highlight
   placeholders, and a quoting inconsistency in the running text has
   been fixed.

 * The DWIM logic in 'git worktree add' sometimes tried to infer a
   remote-tracking branch when an explicit '-b' or '-B' option was
   given to create a new branch, causing the explicit branch name to
   be ignored, which has been corrected.

 * The command line completion (in contrib/) has been taught to handle
   the experimental 'git history' command.

 * 'git checkout' and 'git worktree add' makes guesses based on a name
   of a remote-tracking branch, but does not give an error when such a
   remote-tracking branch cannot be uniquely identified, which has
   been corrected.

 * The 'git replay' command has been taught the '--linearize' option to
   drop merge commits and linearize the replayed history, mimicking 'git
   rebase --no-rebase-merges'.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

 * The refactoring of 'setup.c' has been continued to drop remaining
   global state (`git_work_tree_cfg`, `is_bare_repository_cfg`), updating
   `is_bare_repository()` to no longer implicitly rely on
   `the_repository`.

 * Project-specific configuration for b4 has been introduced, and the
   documentation has been updated to recommend using it as a
   streamlined method for submitting patches.

 * The default format path of git cat-file --batch has been optimized
   to use strbuf_add_oid_hex() and strbuf_add_uint() instead of
   strbuf_addf(), yielding a noticeable speedup.

 * Commands that list branches and tags (like git branch and git tag)
   have been optimized to pass the namespace prefix when initializing
   their ref iterator, avoiding a loose-ref scaling regression in
   repositories with many unrelated loose references.

 * The packed object source has been refactored into a proper struct
   odb_source.

 * The global configuration variables protect_hfs and protect_ntfs have
   been migrated into struct repo_config_values to tie them to
   per-repository configuration state.

 * The trailer sections in SubmittingPatches have been updated to
   encourage use of standard trailers.

 * The documentation in SubmittingPatches has been updated to clarify how
   patch contributors should respond to design and viability critiques,
   and how the resolution of such critiques should be recorded in the
   final commit messages.

 * The pack-objects command has been updated to support reachability
   bitmaps and delta-islands concurrently with the `--path-walk` option,
   allowing faster packaging by falling back to path-walk when bitmaps
   cannot fully satisfy the request.

 * Documentation on community contribution guidelines has been updated to
   encourage replying to review comments before rerolling, and to advise
   a default limit of at most one reroll per day to give reviewers across
   different time zones enough time to participate.

 * The lazy priority queue optimization pattern (deferring actual removal
   in 'prio_queue_get()' to allow get+put fusion) has been folded
   directly into 'prio_queue' itself, speeding up commit traversal
   workflows and simplifying callers.

 * The 'reprepare()' callback for object database sources has been
   generalized into a 'prepare()' callback with an optional flush cache
   flag, and a new 'odb_prepare()' wrapper has been introduced to allow
   pre-opening object database sources.

 * The 'whence' field in 'struct object_info' has been removed.  The
   backend-specific object information retrieval has been refactored into
   an opt-in 'struct object_info_source' structure.

 * A racy build failure under Meson has been corrected by ensuring that
   the generated header file 'hook-list.h' is built before compiling
   files in 'builtin_sources' that depend on it.

 * The repository discovery and repository configuration phases, which
   were previously intertwined in 'setup.c', have been split.  Repository
   discovery has been updated to populate a 'struct repo_discovery'
   without modifying the repository state, which is then taken by
   repository configuration to initialize the repository, paving the way
   for clean unification of repository configuration.

 * The 'SubmittingPatches' document has been updated to explicitly
   describe the expectation for contributors to retract or abandon their
   patch series when they are no longer pursuing it.

 * The contributor guide has been updated to advise new contributors to
   trim irrelevant quoted text when replying to review comments, matching
   the existing advice given to reviewers.

 * The build system has been updated to support building universal macOS
   binaries when 'Rust' is enabled, by compiling separate static archives
   for each target triple listed in 'RUST_TARGETS' and combining them
   using the macOS 'lipo' tool.  The 'git-credential-osxkeychain' helper
   has been updated to link against '$(RUST_LIB)' when 'Rust' is enabled.

 * The test suite has been updated to use the 'test_grep' helper instead
   of bare 'grep' for test assertions, allowing file contents to be
   printed on failure for easier debugging.  A new 'greplint' linter has
   been introduced to detect and prevent new bare 'grep' assertions from
   being added to the test suite.

 * The pipelines in 't1410-reflog.sh' have been replaced with the
   'test_stdout_line_count' helper to avoid suppressing the exit code of
   'git' commands, ensuring failures are not hidden from the test suite.

 * The cache-scanning loop in 'next_cache_entry()' has been optimized
   to avoid rescanning already-unpacked index entries, preventing a
   quadratic performance slow-down when diffing the working tree
   against a commit with a pathspec matching early index entries.

 * The global configuration variable 'ignore_case' (representing the
   'core.ignorecase' configuration) has been migrated into 'struct
   repo_config_values' to tie it to a specific repository instance.

 * The performance of ref updates and reads using the 'reftable' backend
   in the presence of many deletion tombstone records has been optimized
   by removing the tombstone suppression flag from the merged iterator
   and instead skipping tombstones at higher-level call sites where
   iteration bounds are known.

 * Various code paths have been hardened against potential NULL-pointer
   dereferences and invalid file descriptor accesses flagged by
   Coverity.

 * The in-tree 'b4' cover letter template has been updated to include the
   'change-id' trailer, ensuring that sent tags generated by 'b4' contain
   the required tracking information for subsequent runs.

 * 'git receive-pack' has been refactored to use ODB transaction
   interfaces instead of directly managing 'tmp_objdir' for staging
   incoming objects, bringing it closer to being ODB backend agnostic.

 * The test script 't/t9811-git-p4-label-import.sh' has been
   modernized to use 'test_path_is_file' and 'test_path_is_missing'
   instead of raw 'test -f' and '! test -f' calls.

 * A redundant strbuf_reset() call in the 'HAVE_GETDELIM' path of
   strbuf_getwholeline() has been removed, as getdelim() overwrites the
   buffer and the length is updated afterward.

 * The object database enumeration interface odb_for_each_object() has
   been taught to accept object filters, allowing the underlying backends
   to optimize the traversal by using reachability bitmaps when
   available.  'git cat-file --batch-all-objects' has been updated to use
   this generic interface, simplifying its code and avoiding direct
   access to ODB backend internals.

 * The test script 't/t1100-commit-tree-options.sh' has been modernized
   by converting test cases to the modern style (using single quotes and
   tab indentation) and moving the creation of the expected file inside
   the setup test so it runs under the protection of the test harness.

 * The test script 't/t7614-merge-signoff.sh' has been updated to avoid
   suppressing the exit code of 'git' commands in a pipe.

 * The 'git rev-list --no-walk' command has been corrected to restore
   pathspec filtering, which was lost when the streaming walk was
   refactored.

 * The ref subsystem and the worktree API have been refactored to pass a
   repository pointer down the call chain, allowing them to drop
   references to the global 'the_repository' variable.  As part of this,
   the handling of the 'core.packedRefsTimeout' configuration has been
   moved into the per-repository ref store structure.

 * 'git branch --contains' and 'git for-each-ref --contains' have been
   optimized to use the memoized commit traversal previously used only by
   'git tag --contains', significantly speeding up connectivity checks
   across many candidate refs with shared history.

 * The passing of push destination specifications in the 'remote-curl'
   helper has been simplified by removing the explicit 'count' parameter
   and relying on the NULL-termination of the array.

 * The dependency on the global 'the_repository' variable in the
   'refspec.c' API has been removed by passing the hash algorithm
   explicitly to refspec-parsing functions and storing it in 'struct
   refspec'.

 * The enumeration of untracked and ignored files in 'git status' has
   been optimized by avoiding quadratic complexity when inserting into
   string lists, reducing the construction cost from O(n^2) to O(n log
   n).

 * The copy_file() and copy_file_with_time() functions have been
   refactored to take a repository parameter, allowing the removal of the
   implicit dependency on the global 'the_repository' variable in
   'copy.c'.

 * The tempfile and lockfile APIs have been refactored to stop depending
   on the 'the_repository' global variable, and their callers have been
   updated to use the repository-aware variants.

 * The 'trust_executable_bit' (coming from the 'core.filemode'
   configuration) has been migrated into 'struct repo_config_values' to
   tie it to a specific repository instance.

 * The 'excludes_file' and various other global configuration variables
   (including 'editor_program', 'pager_program', 'askpass_program', and
   'push_default') have been migrated into the per-repository structure.

 * The 'git stash push' command has been optimized to avoid unnecessary
   sparse index expansion when pathspecs are wholly inside the
   sparse-checkout cone.  Also, a potential out-of-bounds read in the
   sparse-index expansion check helper pathspec_needs_expanded_index()
   has been fixed by consistently using the parsed, prefixed path.

 * The logic to write loose objects has been refactored and moved from
   'object-file.c' to the loose backend source file 'odb/source-loose.c',
   making the loose backend more self-contained.  This is achieved by
   first refactoring force_object_loose() to use generic ODB write
   interfaces instead of loose-backend internals.

 * Object database housekeeping in 'git gc' and 'git maintenance' has
   been refactored to be pluggable.  The files-backend-specific logic,
   including incremental and geometric repacking as well as object
   pruning, has been moved out of the command implementation and into the
   files object database source, enabling future alternative object
   database backends to implement their own housekeeping services.

 * The image version used by the static-analysis CI job has been bumped
   to ubuntu-latest (Ubuntu 24.04), which brings in a newer Coccinelle
   version that resolves a severe performance regression.  A false
   positive warning from the 'CHECK_ASSERTION_SIDE_EFFECTS' build with
   GCC 15 in the Bloom filter code has also been silenced to facilitate
   the image upgrade.

 * The alias tests in 't/t0014-alias.sh' have been updated to dynamically
   query the list of deprecated commands using 'git
   --list-cmds=deprecated' to avoid test failures when running with
   'WITH_BREAKING_CHANGES' in a build directory that contains stale
   executables of formerly deprecated commands.

 * The code path that deals with relative paths in the diff-lib has
   been cleaned up.

 * The get_commit_action() function has been refactored to be a pure
   predicate by moving the side-effecting line-level log range folding to
   simplify_commit().  This ensures that evaluating a commit's action
   before the walk reaches it does not prematurely mutate its tracked
   line ranges, making it safer for potential lookahead evaluations.

 * Synopsis and options in the documentation for 'git format-patch',
   'git imap-send', 'git send-email', and 'git request-pull' have been
   updated to the modern style.

 * A new test helper commit_body() has been introduced to print the
   message body of a commit, and various tests have been updated to use
   it instead of spelling out the command pipeline manually and losing
   the exit status of the 'git cat-file' command on the upstream of the
   pipe.

 * Tests for 'git merge-base --is-ancestor' have been added to cover
   exit codes (0 for success, 1 for non-ancestor, 128 for errors) and
   to ensure it cannot be combined with '--all'.

 * The 'TRACE2_ANCESTRY' prerequisite in the 't0213' test script has been
   refined to avoid failures under user-mode emulation by verifying that
   the ancestry collector reports the expected process names rather than
   the emulator binary name.

 * Concurrent downloads of packfiles via packfile URIs and dumb HTTP are
   safer by avoiding concurrent appends to the staging file.  Opening in
   read-write mode with separate file offsets prevents corruption and
   preserves resumability.  'fetch-pack' now tolerates pre-existing
   '.keep' files.

 * The 'ssh-agent' tests in 't7528' have been fixed to work when the
   user's login shell is csh-like, by explicitly passing '-s' to
   'ssh-agent' to force Bourne shell syntax.

 * A compatibility wrapper for writev(3p) has been reintroduced,
   including fixes for CMake build and 'MAX_IO_SIZE' limits on NonStop.
   Calls to write(3p) in send_sideband() and cat_blob() have been
   refactored to use writev(3p) wrappers to reduce syscall overhead.

 * The creation of the on-disk data structures for the object database
   has been made pluggable, allowing future backends to customize their
   setup.  As part of this, the initialization of the object database
   has been deferred, and the loading of the loose-object map has been
   detangled from repository initialization.

 * The 'struct odb_read_stream' and 'struct odb_write_stream'
   structures have been consolidated into a single unified 'struct
   odb_stream' structure, simplifying object database streaming APIs
   and enabling streaming of arbitrary object types.

 * The sequencer has been updated to release the object database before
   spawning 'git commit'.  This prevents open file handles from
   blocking auto-maintenance tasks, such as repacking, on systems like
   Windows where open files cannot be easily unlinked.

 * The merge-base computation has been optimized by stopping the walk
   early when one side's exclusive commits in the queue are exhausted,
   yielding significant speedups for queries with one-sided histories.

 * A handful of code paths have been corrected to check return values
   from functions like curl_easy_duphandle(), deflateInit(), lseek(),
   dup(), and strbuf_getline_lf(), resolving several Coverity warnings
   about unchecked returns.

 * The setting of a now-unused member '.pretty_given' in the sequencer
   machinery has been removed.

 * The performance of adding numerous new packfiles has been improved
   by introducing a fast path for known-new packfiles to skip an
   unnecessary traversal in packfile_list_append(), avoiding a
   quadratic complexity regression on load.

 * The unused name parameter in 'struct chdir_notify_entry' has been
   removed from chdir_notify_register(), chdir_notify_unregister(), and
   related callback signatures across several subsystems, simplifying the
   API now that trace output no longer uses it.

 * A heap-use-after-free bug in the object name parsing code when
   reporting failures with a relative path to a sparse directory has
   been corrected.

 * The object database (odb) API has been refactored to distinguish
   between missing objects and corrupt ones by returning more
   descriptive error statuses.  Both the packed and loose backends now
   faithfully propagate error details using a generic strbuf error
   mechanism, removing backend-specific leakage from central lookup
   paths.

 * The object database layer has been simplified by eagerly loading
   alternate object directories upon initialization, instead of
   deferring it to the first object lookup.  This eliminates the need
   for scattered lazy-loading calls throughout the codebase and paves
   the way for integrating alternates with the pluggable backends.

 * The threshold for geometric repacking to trigger based on loose
   object count has been adjusted to match that of 'git gc --auto',
   preventing over-aggressive repacking during concurrent writes.

 * The 'git receive-pack' command has been updated to use a new ODB
   transaction interface for writing incoming packfiles, making it more
   backend-agnostic.

 * The mechanism to generate a packfile corresponding to the result of
   a fetch/push has been made pluggable through a set of object
   database callback functions, removing hardcoded references to
   'pack-objects' and enabling alternative ODBs to serve packfiles
   themselves.

 * The pack-objects command has been updated to record the total bytes
   written to pack files in trace2 output, allowing performance
   analysis of different compression settings by comparing the
   resulting pack sizes.

 * The global variable 'fetch_if_missing' has been moved to a member in
   'struct repository', continuing the libification process and
   allowing per-repository control (such as for submodules).

 * The reftable code has been optimized to avoid an unnecessary
   stat/reload of the stack when an addition already holds the
   list_file lock, reducing the number of newfstatat syscalls from
   linear to constant when writing refs.

 * The application of the edited patch in 'git add -e' has been
   refactored to use the internal apply API directly, avoiding the need
   to spawn a 'git apply' subprocess.

 * The memory ownership of argv elements passed to the revision
   machinery has been made more robust by keeping logically "freed"
   elements alive until the rev_info struct is released, preventing
   use-after-free bugs when options store references to them.

 * The object lookup machinery has been taught to gracefully recover
   when a multi-pack-index points to an owning pack that was removed
   during a concurrent geometric repack, and 'git replay' has been
   fixed to not segfault when reading such missing objects.


Fixes since v2.55
-----------------

 * A regression in the error diagnosis code for invalid .git files has
   been fixed, avoiding a potential NULL-pointer crash when reporting
   that a .git file does not point to a valid repository.
   (merge 54a441bcea jk/setup-gitfile-diag-fix later to maint).

 * Support for hashing loose or packed objects larger than 4GB on Windows
   and other LLP64 platforms has been improved by converting object header
   buffers and data-handling functions from 'unsigned long' to 'size_t'.
   (merge d99e13d0be po/hash-object-size-t later to maint).

 * The display of the rebase todo list in "git status" has been
   improved to correctly abbreviate object IDs for more commands and
   avoid misinterpreting refs as object IDs.
   (merge 6f34e5f9e3 pw/status-rebase-todo later to maint).

 * Reference backend configuration has been updated to load lazily to
   avoid recursive calls during repository initialization when 'onbranch'
   configuration conditions are evaluated. This has also fixed a memory
   leak and allowed the unused `chdir_notify_reparent()` machinery to be
   dropped.
   (merge d6522d01df ps/refs-onbranch-fixes later to maint).

 * The connectivity check has been refactored to search for promisor
   objects in a generic way using the object database interface,
   rather than iterating packfiles directly. This allows connectivity
   checks to work properly in repositories that do not use packfiles.
   (merge 66ee9cb930 ps/connected-generic-promisor-checks later to maint).

 * A test checking interactions between git rebase --quit and
   autostash in t3420-rebase-autostash.sh has been corrected to use
   test_path_is_missing instead of ! grep on a file that shouldn't
   exist in the conflicted state.
   (merge eaad121fef sg/t3420-do-not-grep-in-missing-file later to maint).

 * The GPG and SSH signature parsing code has been corrected to strip
   carriage return characters only when they immediately precede line
   feeds, instead of unconditionally stripping all carriage returns.
   (merge 5dea8b690b ad/gpg-strip-cr-before-lf later to maint).

 * A memory leak in the 'reftable_writer_new()' initialization function
   has been fixed by delaying the allocation of 'struct reftable_writer'
   until after input options are validated.
   (merge c6fb3b9c3e jk/reftable-leakfix later to maint).

 * A memory leak in the '--base' handling of 'git format-patch' has been
   plugged, and the leak reporting of the test suite when running under a
   TAP harness has been improved.
   (merge 973a0373ff jk/format-patch-leakfix later to maint).

 * A write file stream resource leak has been fixed as part of a code
   cleanup.
   (merge ebb4d2ffa3 jc/history-message-prep-fix later to maint).

 * Various memory leaks in the Bloom-filter code paths that are exposed
   when running tests with the 'GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1'
   environment variable have been plugged.
   (merge 459088ec2e jk/bloom-leak-fixes later to maint).

 * The wincred credential helper has been updated to avoid memory
   corruption when erasing credentials and to prevent silent
   credential loss when storing OAuth tokens, by correcting buffer
   allocations and arguments passed to safe-CRT APIs.
   (merge f635ab9ab4 js/wincred-fixes later to maint).

 * Various code paths that initialize a cryptographic hash context but
   bail out or finish without calling 'git_hash_final()' have been taught
   to call 'git_hash_discard()' to release allocated resources, fixing
   memory leaks when Git is built with non-default backends like
   'OpenSSL' or 'libgcrypt'.
   (merge 600588d2aa jk/hash-algo-leak-fixes later to maint).

 * Various resource leaks, invalid file descriptor closures, and process
   handle ownership issues flagged by Coverity have been fixed.
   (merge 9184231173 js/coverity-fixes later to maint).

 * Dockerized CI jobs running in private GitHub repositories have been
   adjusted to use explicit process and file limits, preventing resource
   exhaustion errors on private runners.
   (merge bad766fbac js/ci-dockerized-pid-limit later to maint).

 * Various test scripts have been updated to clean up large temporary
   files and repositories, reducing peak disk usage during testing.
   Also, expensive tests have been disabled on platforms that lack
   sufficient resources (like 32-bit platforms and Windows CI runners),
   and the long test suite has been enabled in GitLab CI.
   (merge 84248444ad ps/t-fixes-for-git-test-long later to maint).

 * The UTF-8 precomposition wrapper on macOS has been updated to use a
   flexible array member to represent the name of a directory entry,
   preventing fortified libc checks from failing when the name is
   reallocated to be larger than 'NAME_MAX' bytes.
   (merge 1eb281159f ih/precompose-flex-array later to maint).

 * The 'git_hash_*()' wrappers have been updated to be used consistently
   across the codebase instead of direct calls to members of 'struct
   git_hash_algo', and 'git_hash_discard()' has been made idempotent to
   simplify cleanups.
   (merge 9e396aa553 jk/git-hash-cleanups later to maint).

 * The sideband demultiplexer has been updated to recognize ANSI SGR
   escape sequences that use colon-separated subfields (e.g., for
   256-color or true-color codes).
   (merge 3792b2aea4 mm/sideband-ansi-sgr-colon-fix later to maint).

 * The 'reftable' code has been hardened against corrupted tables by
   fixing out-of-bounds writes, out-of-bounds reads, and abort calls
   during parsing.
   (merge ca93c27328 ps/reftable-hardening later to maint).

 * A description in the release notes for Git 2.55.0 has been
   retroactively updated to clarify that Rust support is enabled by
   default, but still optional, and will become mandatory in Git 3.0.
   (merge 18b2009d14 jc/relnotes-2.55-rust-fix later to maint).

 * The early-exit optimization in 'paint_down_to_common()' has been
   gated on the queue being generation-ordered, fixing a bug where
   'git merge-base' (without '--all') could return incorrect results
   on repositories with v1 commit graphs and clock skew.
   (merge ae68032a8d kk/commit-reach-find-all-fix later to maint).

 * The client-side parser of the server-advertised bundle-URI list has
   been updated to drain the remaining response in order to avoid
   protocol desynchronization when the server sends a misconfigured list.
   Also, the server-side has been taught to omit empty configuration
   values instead of sending invalid key-value lines.
   (merge 50de1169e4 tc/bundle-uri-empty-fix later to maint).

 * The 'topo_levels' slab was propagated only to the topmost layer of a
   split commit-graph chain, causing topological levels for commits in
   base layers to be recomputed during incremental writes.  This has been
   corrected.

 * The stream-based object signature verification path has been
   corrected to avoid double-closing the stream on read errors.
   (merge cfd52a74a0 ps/odb-stream-double-close-fix later to maint).

 * The '-i' shorthand for the '--init' option, which was accepted by the
   'git submodule update' command until it was broken in a modernization
   of the option-parsing code, has been restored.
   (merge ff1da37f58 dm/submodule-update-i-shorthand later to maint).

 * An accidental use of the '%zu' format specifier in 'git
   submodule--helper' has been corrected to use 'PRIuMAX' and cast the
   value to 'uintmax_t' to avoid portability issues.
   (merge 3279c13c00 jc/submodule-helper-avoid-zu later to maint).

 * The rebase post-rewrite notes-copying logic has been corrected.  When
   a commit is dropped during rebase (e.g., because its changes are
   already upstream), it is no longer recorded as rewritten, preventing
   its notes from being copied to an unrelated commit.
   (merge 42554b78fd pw/rebase-drop-notes-with-commit later to maint).

 * A few memory problems in the Rust interface to C hash functions have
   been corrected.  The 'Clone' implementation of 'CryptoHasher' now
   properly initializes the context before cloning, and its 'Drop'
   implementation now discards the context to prevent leaks.

 * The object ID shortening and linking in the 'commitdiff' view of
   'gitweb' has been corrected to work even when the index line carries
   a trailing file mode.
   (merge fda513d6fe tl/gitweb-shorten-hashes-with-modes later to maint).

 * When the push remote is specified as a URL, the fetch refspec of a
   uniquely matching configured remote is now used to find and update
   the remote-tracking branch (e.g., '@{push}').

 * Traversals with '--exclude-first-parent-only' have been corrected
   to properly stop after the first parent even when it has already
   been marked as 'SEEN'.
   (merge 47382f7398 jc/exclude-first-parent-seen later to maint).

 * A segfault when 'git clone --revision' talks to a server that does not
   support protocol v2 (falling back to protocol v0) has been corrected.
   (merge 1034ad383f af/clone-revision-v0-segfault-fix later to maint).

 * rewrites_release() in 'remote.c' has been updated to free 'struct
   rewrite' instances, their '.instead_of' arrays, and their contents.
   (merge dcef3bf041 jc/remote-insteadof-leakfix later to maint).

 * The remote-matching logic for submodules has been corrected to resolve
   'url.*.insteadOf' aliases before comparing the inventoried URL from
   '.gitmodules' with the URLs of configured remotes.

 * 'git diff --relative' running with '--cached' has been corrected to
   avoid a segfault when encountering unmerged paths outside the
   prefix.
   (merge 447126ed7d jk/diff-relative-cached-unmerged later to maint).

 * Two bugs in how 'git rebase' handles skipped 'fixup' and 'squash'
   commands have been fixed.  One bug caused an incorrect commit count to
   be shown in the template message when multiple commands were skipped,
   and another prevented the editor from opening when the final command
   in a chain containing 'fixup -c' was skipped.

 * Git for Windows has been updated to avoid auto-detecting the symlink
   type if the target path starts with a slash, preventing NTLM
   credential leaks when checking out repositories with crafted
   symbolic links pointing to network shares.

 * 'git cat-file --batch-command' that asked for 'contents' without
   'type' segfaults, which has been corrected.
   (merge 2abc7f0304 jk/cat-file-batch-wo-type-fix later to maint).

 * A memory leak in 'git merge' when run without arguments (which
   triggers the default-to-upstream path) has been fixed.  A test has
   been added to cover this case.
   (merge 68cce04a02 tc/merge-default-to-upstream-leakfix later to maint).

 * A boundary case check in reachability bitmap traversal has been
   corrected to properly handle the object at position zero, which was
   previously skipped, leading to redundant bitmap loading.
   (merge b56b48301e dl/pack-bitmap-position-zero later to maint).

 * A crash in the 'sparse-index' collapse code when encountering an
   invalidated cache-tree node (due to an intent-to-add path) has been
   fixed by avoiding collapsing such subtrees.
   (merge eede1e69fe ds/sparse-index-ita-crash later to maint).

 * Documentation for 'git replay' has been updated to refer to its
   configuration variables.
   (merge 48c0549f5c kh/doc-replay-config later to maint).

 * Documentation for 'git interpret-trailers' has been updated to explain
   the format of trailer keys (alphanumeric characters and hyphens),
   replace outdated terminology, define key terms upfront, and document
   how comment lines in the input are treated.
   (merge 4515c86fd9 kh/doc-trailers later to maint).

 * The 'pack-objects' and delta-encoding code paths have been updated to
   use 'size_t' instead of 'unsigned long' for object sizes and offset
   limits, avoiding potential truncation issues on 64-bit Windows.
   (merge d50ac11724 js/pack-objects-delta-size-t later to maint).

 * A client requesting the promisor-remote capability without a value
   caused a null pointer dereference, which has been corrected by
   rejecting a request without an argument.
   (merge dd6b35ff71 en/serve-promisor-remote-fix later to maint).

 * Various tests in 't7900-maintenance.sh' have been updated to use a
   throwaway repository, and auto-detaching of maintenance tasks is now
   disabled for these tests to fix flaky races with concurrent background
   maintenance jobs.
   (merge 2775d8bcd1 ps/t7900-deflake-maintenance later to maint).

 * The help text for the '-l' option of 'git diff' has been updated.
   (merge 764243bdf4 en/diff-l-opt-help later to maint).

 * 'git -C <dir> diff fi<TAB>' did not complete 'file', which has
   been corrected.
   (merge 354d1bf3a0 jc/complete-diff-tracked-paths later to maint).

 * 'git -C <dir> checkout fi<TAB>' did not complete 'file', which has
   been corrected.
   (merge 05e2ab1f31 jc/complete-checkout later to maint).

 * The trailer parsing machinery has been updated to avoid mistaking
   lines that begin with a URL (e.g., 'https://...') as trailer lines.
   This prevents intended textual URLs from being mangled or mistakenly
   treated as metadata keys.

 * The instructions for deprecated commands emitted by
   you_still_use_that() have been reworded to clarify that the removal
   decision is final and to provide more assertive guidance on finding
   a replacement.
   (merge 8ace32221c jc/you-still-use-that later to maint).

 * The zsh completion script (in 'contrib/') has been updated to
   correctly locate the Git command after global options like '-C' by
   properly skipping them, similar to how the bash completion does.

 * The git worktree repair command failed to rewrite the .git file of
   a working tree from a relative path to an absolute path when the
   command was run in the working tree itself.  The
   read_gitfile_gently() function was modified to also return whether
   the path originally recorded in the file was absolute, and this new
   capability is used to correctly detect such mismatches.

 * GitHub Actions CI workflow runs triggered by pull requests have
   been configured to cancel older runs when a new push is made to the
   same pull request.
   (merge a251b1bd21 hn/ci-cancel-stale-pr-runs later to maint).

 * The string extraction logic for the branch name and worktree name
   from the given path in 'git worktree add' has been corrected and
   simplified to avoid out-of-bounds reads and improper handling of
   trailing slashes.
   (merge 2e8a9d94b0 rs/worktree-add-basename-fixes later to maint).

 * Other code cleanup, docfix, build fix, etc.
   (merge 026636128f ss/submittingpatches-typofix later to maint).
   (merge d2af22cc21 jc/rerere-doc-typofix later to maint).
   (merge c486c1df72 hk/typofix later to maint).

----------------------------------------------------------------

Changes since v2.55.0 are as follows:

Adrian Friedli (1):
      builtin/clone: fix segfault when using --revision with protocol v0

Alexander Shopov (3):
      gitk i18n: Update Bulgarian translation (329t)
      git-gui i18n: Update Bulgarian translation (562t)
      git-gui: allow larger width for the commit message field

Antonio De Stefani (1):
      gpg-interface: fix strip_cr_before_lf to only remove CR before LF

Calvin Wan (3):
      fetch-pack: move fetch initialization
      serve: advertise object-info feature
      transport: add client support for object-info

Chen Linxuan (3):
      config: refactor include_by_gitdir() into include_by_path()
      config: add "worktree" and "worktree/i" includeIf conditions
      b4: include change-id in cover template

Christian Couder (23):
      t5710: simplify 'mkdir X' followed by 'git -C X init'
      urlmatch: change 'allow_globs' arg to bool
      urlmatch: add url_normalize_pattern() helper
      promisor-remote: add 'local_name' to 'struct promisor_info'
      promisor-remote: introduce promisor.acceptFromServerUrl
      promisor-remote: trust known remotes matching acceptFromServerUrl
      promisor-remote: auto-configure unknown remotes
      doc: promisor: improve acceptFromServer entry
      fast-export: standardize usage string and SYNOPSIS
      mailmap: change primary address for Christian Couder
      parse-options: introduce OPT_HIDDEN_GROUP
      api-parse-options.adoc: document per-option flags
      api-parse-options.adoc: document hidden and OPT_*_F option macros
      fast-import: localize 'i' into the 'for' loops using it
      fast-import: use int for some bool flags
      fast-import: factor out option_*() functions
      fast-import: introduce 'struct fast_import_state'
      fast-import: move command state globals into 'struct fast_import_state'
      fast-import: use struct option for usage string
      fast-import: use callbacks to parse some options
      fast-import: use parse_options() for command line options
      fast-import: remove useless from_stream argument
      git: avoid segfault on "git --shallow-file" without a value

Colin Hinton (1):
      chdir-notify.h: Removed unused param 'name'

D. Ben Knoble (1):
      mailmap: change primary address for D. Ben Knoble

David Lin (1):
      pack-bitmap: handle objects at bitmap position zero

Derrick Stolee (1):
      sparse-index: avoid crash on intent-to-add entry outside the cone

Dominique Martinet (1):
      submodule--helper: accept '-i' shorthand for update --init

Elijah Newren (14):
      merge-ort: propagate callback errors from traverse_trees_wrapper()
      merge-ort: drop unnecessary show_all_errors from collect_merge_info()
      merge-ort: free diff pairs queue in clear_or_reinit_internal_opts()
      merge-ort: abort merge when trees have duplicate entries
      cache-tree: fix verify_cache() to catch non-adjacent D/F conflicts
      t6600: add test cases for side-exhaustion edge cases
      serve: reject valueless promisor-remote capability
      sequencer: remove unnecessary variable setting
      mailmap: map Elijah Newren's current and previous work addresses
      diff: avoid misleading statement about -l option
      replay: fail gracefully when a merge input is unreadable
      mktree: plug per-tree leak in --batch mode
      mktree: do not use OBJECT_INFO_QUICK when checking objects
      packfile: recover when a multi-pack-index names a removed pack

Eric Ju (3):
      cat-file: declare loop counter inside for()
      t1006: extract helper functions into new 'lib-cat-file.sh'
      cat-file: add remote-object-info to batch-command

Friel (1):
      pack-objects: trace pack bytes written

Gatla Vishweshwar Reddy (2):
      t1410-reflog.sh: avoid suppressing git's exit code in pipelines
      builtin/add.c: replace run_command() with direct apply_all_patches() call

Harald Nordgren (18):
      remote: qualify "git pull" advice for non-upstream compareBranches
      git-gui: drop msgfmt --statistics output
      gitk: make "make -s" silent
      branch: suggest <remote>/<branch> on upstream slip
      push: suggest <remote> <branch> for a slash slip
      remote: pass repository to push tracking helper
      remote: find tracking branches for URL push destinations
      bisect: let bisect_reset() optionally check out quietly
      bisect: add --reset-when-found to leave when done
      branch: add --forked filter for --list mode
      branch: convert delete_branches() to a flags argument
      branch: let delete_branches skip unmerged branches on bulk refusal
      branch: prepare delete_branches for a bulk caller
      branch: add --delete-merged <pattern>
      branch: add branch.<name>.deleteMerged opt-out
      branch: add --dry-run for --delete-merged
      send-email: clarify missing subject error
      ci: cancel stale pull request workflow runs

Hardik Kumar (1):
      versioncmp: fix typo in versioncmp.c, t/t0022-crlf-rename.sh

Henrique Ferreiro (1):
      unpack-trees: avoid quadratic index scan in next_cache_entry()

Ihar Hrachyshka (1):
      precompose_utf8: use a flex array for d_name

Jamie Magee (1):
      t0213: skip ancestry tests under user-mode emulation

Jean-Noël Avila (4):
      doc: convert git-imap-send synopsis and options to new style
      doc: convert git-format-patch synopsis and options to new style
      doc: convert git-send-email synopsis and options to new style
      doc: convert git-request-pull synopsis and options to new style

Jeff King (36):
      read_gitfile(): simplify NOT_A_REPO error message
      reftable: fix unlikely leak on API error
      t: move LSan errors from stdout to stderr
      format-patch: fix leak of rev_info in prepare_bases()
      bloom: make bloom-filter slab initialization idempotent
      revision: avoid leaking bloom keyvecs with multiple traversals
      line-log: drop extra copy of range with bloom filters
      csum-file: drop discard_hashfile()
      hash: add discard primitive
      csum-file: always finalize or discard hash
      csum-file: provide a function to release checkpoints
      patch-id: discard hash when done
      check_stream_oid(): discard hash on read error
      http: discard hash in dumb-http http_object_request
      hash: fix memory leak copying sha256 gcrypt handles
      hash: add platform-specific discard functions
      hash: use git_hash_init() consistently
      hash: convert remaining direct function calls
      hash: document function pointers and wrappers
      hash: make git_hash_discard() idempotent
      csum-file: use idempotent git_hash_discard()
      http: use idempotent git_hash_discard()
      hash: check ctx->active flag in all wrapper functions
      pack-objects: drop unused return value from add_object_entry()
      diff: ignore unmerged paths outside prefix with --relative --cached
      bloom: silence CHECK_ASSERTION_SIDE_EFFECTS false positive
      ci: bump ubuntu image version for static-analysis job
      diff-lib: add idx/tree sanity check to oneway_diff
      diff-lib: drop stale comment about advancing o->pos
      diff-lib: skip paths outside prefix in oneway_diff()
      cat-file: handle content request for --batch-command without type
      t0014: factor out choice of deprecated commands
      t0014: generate deprecated command names dynamically
      transport: drop remote object-info fields from transport struct
      revision: hang on to "freed" argv elements
      revision: simplify mark_argv_for_free() callers

Johannes Schindelin (55):
      ci(dockerized): raise the PID limit for private repositories
      load_one_loose_object_map(): fix resource leak
      loose: avoid closing invalid fd on error path
      download_https_uri_to_file(): do not leak fd upon failure
      run-command: avoid `close(-1)` in `start_command()` error paths
      line-log: avoid redundant copy that leaks in process_ranges
      dir: free allocations on parse-error paths in `read_one_dir()`
      submodule: fix cwd leak in `get_superproject_working_tree()`
      worktree: fix resource leaks when branch creation fails
      imap-send: avoid leaking the IMAP upload buffer
      reftable/table: release filter on error path
      fsmonitor: plug token-data leak on early daemon-startup failures
      mingw: make `exit_process()` own the process handle on all paths
      diffcore-break: guard against NULLed queue entries in merge loop
      diff: handle NULL return from repo_get_commit_tree()
      remote: guard `remote_tracking()` against NULL remote
      reftable/stack: guard against NULL list_file in stack_destroy
      mailsplit: move NULL check before first use of file handle
      bisect: handle NULL commit in `bisect_successful()`
      replay: die when --onto does not peel to a commit
      revision: avoid dereferencing NULL in `add_parents_only()`
      pack-bitmap: handle missing bitmap for base MIDX
      bisect: ensure non-NULL `head` before using it
      shallow: fix NULL dereference
      shallow: give write_one_shallow() its own hex buffer
      wincred: avoid memory corruption when erasing a credential
      wincred: prevent silent credential loss when storing OAuth tokens
      mingw: skip symlink type auto-detection for network share targets
      http: die on curl_easy_duphandle failure in get_active_slot
      config: propagate launch_editor() failure in show_editor()
      reftable: handle block-writer initialization errors
      reftable/block: check deflateInit() return value
      reftable tests: check reftable_table_init_ref_iterator() return
      last-modified: handle repo_parse_commit() failures
      compat/pread: check initial lseek for errors
      transport-helper: check dup() return in get_exporter
      transport-helper: warn when export-marks file cannot be finalized
      bisect: check strbuf_getline_lf return when reading terms
      bisect: check get_terms return at all call sites
      bisect: handle dup() failure when redirecting stdout
      sequencer: release the ODB before spawning git commit
      diff-delta: widen `struct delta_index`' size fields to `size_t`
      delta: widen `create_delta_index()` parameter to `size_t`
      pack-objects: widen delta-cache accounting to `size_t`
      pack-objects: widen `free_unpacked()` return to `size_t`
      pack-objects: widen `mem_usage` and `try_delta()`'s out-param to `size_t`
      delta: widen `create_delta()` and `diff_delta()` to `size_t`
      packfile, git-zlib: widen `use_pack()` and zstream avail fields to `size_t`
      archive-zip: widen `zlib_deflate_raw()`'s maxsize local to `size_t`
      diff: widen `deflate_it()`'s bound local from int to `size_t`
      http-push: widen `start_put()`'s size local from `ssize_t` to `size_t`
      t/helper/test-pack-deltas: widen `do_compress()`'s maxsize local to `size_t`
      git-zlib: widen `git_deflate_bound()` to `size_t`
      packfile: widen `unpack_object_header_buffer()` to `size_t`
      packfile: fix perf regression with many packs

Johannes Sixt (1):
      git-gui: reduce complexity of the quiet msgfmt rule

Junio C Hamano (43):
      SubmittingPatches: address design critiques
      history: streamline message preparation and plug file stream leak
      Start Git 2.56 cycle
      Rust: fix description in Release Notes to 2.55
      SubmittingPatches: document how to retract a topic
      The 2nd batch for Git 2.56
      submodule--helper: avoid use of %zu for now
      The 3rd batch for Git 2.56
      The 4th batch for Git 2.56
      The 5th batch
      The 6th batch
      The 7th batch
      revision: honor --exclude-first-parent-only with SEEN first parent
      remote: plug memory leaks
      The 8th batch
      The 9th batch
      read-cache: reindent
      merge-ll: consolidate conflict marker scanning logic
      read-cache: add remove_file_from_index_with_flags()
      add: introduce '--resolved' option
      The 10th batch
      The 11th batch
      The 12th batch
      The 13th batch
      completion: no-op refactoring of diff completion
      completion: complete tracked paths for 'git diff'
      completion: 'git diff' completes untracked paths as a last resort
      completion: no-op refactoring of checkout completion
      completion: complete tracked paths for "git checkout"
      completion: 'git checkout' completes untracked paths as a last resort
      The 14th batch
      The 15th batch
      The 16th batch
      The 17th batch
      The 18th batch
      rerere: technical documentation typofix
      The 19th batch
      you_still_use_that(): reword the instructions
      The 20th batch
      The 21st batch
      The 22nd batch
      The 23rd batch
      Git 2.56-rc0

Justin Tobler (21):
      bundle-uri: stop sending invalid bundle configuration
      object-file: rename files transaction prepare function
      object-file: rename files transaction fsync function
      object-file: embed transaction flush logic in commit function
      object-file: drop check for inflight transactions
      object-file: propagate files transaction errors
      odb/transaction: propagate begin errors
      odb/transaction: propagate commit errors
      odb/transaction: add transaction env interface
      odb/transaction: introduce ODB transaction flags
      builtin/receive-pack: drop redundant tmpdir env
      builtin/receive-pack: stage incoming objects via ODB transactions
      builtin/receive-pack: properly clean up keep files
      odb/transaction: add transaction finalize interface
      builtin/receive-pack: pass shallow file explicitly
      builtin/receive-pack: read unpack limit config lazily
      builtin/receive-pack: lift global state out of unpack()
      builtin/receive-pack: report unpack errors via strbuf
      builtin/receive-pack: explicitly pass packfile fd
      odb: return temporary ODB source when set
      odb/transaction: add transaction interface to write packfiles

Jörg Thalheim (1):
      config: retry acquiring config.lock, configurable via core.configLockTimeout

K Jayatheerth (3):
      path: extract format_path() and use in rev-parse
      repo: add path.commondir with absolute and relative suffix formatting
      repo: add path.gitdir with absolute and relative suffix formatting

Karthik Nayak (4):
      reftable/stack: remove `REFTABLE_STACK_NEW_ADDITION_RELOAD`
      reftable/stack: rename reftable_stack_new_addition()
      reftable/stack: move list lock to `struct reftable_stack`
      reftable/stack: avoid reloading the stack when already locked

Kenneth Lorber (1):
      t7528: fix failure under csh

Kristofer Karlsson (18):
      prio-queue: rename .nr to .nr_ and add accessor helpers
      prio-queue: fold lazy_queue into prio_queue for automatic get+put fusion
      t6600: add test for merge-base early exit with clock skew
      commit-reach: guard !FIND_ALL early exit with generation ordering check
      commit-graph: add trace2 instrumentation for generation DFS
      commit-graph: propagate topo_levels slab to all chain layers
      t/perf: add perf test for ref tombstone scenarios
      reftable: fix quadratic behavior in the presence of tombstones
      revision: fix --no-walk path filtering regression
      Documentation/technical: add paint-down-to-common doc
      test-lib-functions: improve diagnostic output for trace2 data assertions
      t6099: add side-exhaustion regression test
      commit-reach: add trace2 instrumentation to paint_down_to_common()
      t6600: add clock-skew topologies and step counts for edge cases
      commit-reach: introduce struct paint_state with per-side counters
      commit-reach: terminate merge-base walk when one paint side is exhausted
      commit-reach: move min_generation check into paint_queue_get()
      commit-reach: remove commit-date ordering fallback

Kristoffer Haugsbakk (25):
      SubmittingPatches: encourage trailer use for substantial help
      SubmittingPatches: discourage common Linux trailers
      SubmittingPatches: document Based-on-patch-by trailer
      SubmittingPatches: be consistent with trailer markup
      SubmittingPatches: note that trailer order matters
      doc: link to config for git-replay(1)
      doc: replay: improve config description
      doc: replay: use a nested description list
      doc: replay: move “default” to the right-hand side
      doc: refs: put ref migration warning under the command
      doc: refs: linkgit to git-maintenance(1)
      doc: interpret-trailers: stop fixating on RFC 822
      doc: interpret-trailers: replace “lines” with “metadata”
      doc: interpret-trailers: use “metadata” in Name as well
      doc: interpret-trailers: not just for commit messages
      doc: interpret-trailers: explain the format after the intro
      doc: interpret-trailers: explain key format
      doc: interpret-trailers: add key format example
      doc: interpret-trailers: join new-trailers again
      doc: interpret-trailers: commit to “trailer block” term
      doc: interpret-trailers: rewrite new-trailers paragraphs
      doc: interpret-trailers: document comment line treatment
      doc: format-rev: quote subject placeholder before and after
      doc: format-rev: use [synopsis] on code block
      trailers: stop recognizing URLs as trailers

Lucas Zamboni Orioli (2):
      mv: name both source and destination when rename fails
      mv: reject a destination whose leading path is missing or a symlink

Lutz Lengemann (1):
      completion: zsh: support completion after "git -C <path>"

Mantas Mikulėnas (1):
      sideband: allow ANSI SGR with colon-separated subfields

Marcelo Machado Lage (2):
      t9811: break long && chains into multiple lines
      t9811: replace 'test -f' and '! test -f' with 'test_path_*'

Matt Hunter (8):
      fetch: fixup set_head advice for warn-if-not-branch
      doc: explain fetchRemoteHEADWarn advice
      t5510: cleanup remote in followRemoteHEAD dangling ref test
      fetch: rename function report_set_head
      fetch: return 0 on known git_fetch_config
      fetch: refactor do_fetch handling of followRemoteHEAD
      fetch: add configuration variable fetch.followRemoteHEAD
      fetch: fixup a misaligned comment

Michael Montalbo (7):
      t/README: document test_grep helper
      t: fix grep assertions missing file arguments
      t: extract chainlint's parser into shared module
      t: fix Lexer line count for $() inside double-quoted strings
      t: convert grep assertions to test_grep
      t: add greplint to detect bare grep assertions
      revision: make get_commit_action() a pure predicate

Mike Gilbert (1):
      meson: restore hook-list.h to builtin_sources

Miklos Vajna (1):
      log: improve --follow following renames for non-linear history

Nikolaus Schuetz (3):
      merge-base: add tests for --is-ancestor
      t1401: check symbolic-ref failure and --quiet silence on a non-symbolic ref
      t1402: test forbidden characters in refnames

Pablo Sabater (23):
      lib-log-graph: move check_graph function
      revision: add next_commit_to_show()
      graph: add a 2 commit buffer for lookahead
      graph: indent visual root in graph
      graph: wrap cascading commits after 4 columns
      graph: move config reading into graph_read_config()
      graph: add --[no-]graph-indent and log.graphIndent
      transport-helper: fix memory leak of helper on disconnect
      fetch-pack: drop the static advertise_sid variable
      fetch-pack: use unsigned int for hash_algo variable
      fetch-pack: move write_fetch_command_and_capabilities() to connect.c
      connect: make write_fetch_command_and_capabilities() more generic
      protocol-caps: check object existence regardless of the attributes requested
      cat-file: make remote-object-info allow-list adapt to the server
      t5701: use test_file_size() to get the size of a file
      fetch-object-info: detect malformed server responses
      fetch-object-info: pass arguments directly instead of a struct
      fetch-object-info: use dedicated struct for the results
      fetch-object-info: die() on the remaining error path
      protocol-caps: add type support to object-info
      fetch-object-info: parse type from server response
      serve: advertise type capability
      cat-file: unify default format

Patrick Steinhardt (178):
      builtin/init: stop modifying global `git_work_tree_cfg` variable
      builtin/init: simplify logic to configure worktree
      setup: remove global `git_work_tree_cfg` variable
      builtin/init: stop modifying `is_bare_repository_cfg`
      environment: split up concerns of `is_bare_repository_cfg`
      environment: stop using `the_repository` in `is_bare_repository()`
      treewide: drop USE_THE_REPOSITORY_VARIABLE
      MyFirstContribution: recommend shallow threading of cover letters
      MyFirstContribution: recommend the use of b4
      b4: introduce configuration for the Git project
      packfile: rename `struct packfile_store` to `odb_source_packed`
      packfile: split out packfile list logic
      packfile: move packed source into "odb/" subsystem
      odb/source-packed: store pointer to "files" instead of generic source
      odb/source-packed: start converting to a proper `struct odb_source`
      odb/source-packed: wire up `close()` callback
      odb/source-packed: wire up `reprepare()` callback
      packfile: use higher-level interface to implement `has_object_pack()`
      odb/source-packed: wire up `read_object_info()` callback
      odb/source-packed: wire up `read_object_stream()` callback
      odb/source-packed: wire up `for_each_object()` callback
      odb/source-packed: wire up `count_objects()` callback
      odb/source-packed: wire up `find_abbrev_len()` callback
      odb/source-packed: wire up `freshen_object()` callback
      odb/source-packed: stub out remaining functions
      midx: refactor interfaces to work on "packed" source
      odb/source-packed: drop pointer to "files" parent source
      odb/source: generalize `reprepare()` callback
      odb: introduce `odb_prepare()`
      odb/source-packed: extract logic to skip certain packs
      odb/source-packed: support flags when iterating an object prefix
      connected: split out promisor-based connectivity check
      connected: search promisor objects generically
      setup: inline `check_and_apply_repository_format()`
      setup: stop applying repository format twice
      setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
      refs: unregister reference stores from "chdir_notify"
      chdir-notify: drop unused `chdir_notify_reparent()`
      repository: free main reference database
      refs: move parsing of "core.logAllRefUpdates" back into ref stores
      refs/files: lazy-load configuration to fix chicken-and-egg
      reftable: split up write options
      refs/reftable: lazy-load configuration to fix chicken-and-egg
      refs: protect against chicken-and-egg recursion
      read-cache: split out function to drop unmerged entries to stage 0
      reset: drop `USE_THE_REPOSITORY_VARIABLE`
      reset: rename `reset_head()`
      reset: modernize flags passed to `reset_working_tree()`
      reset: introduce dry-run mode
      packfile: thread odb_source_packed through packed_object_info()
      odb: make backend-specific fields optional
      odb: add `source` field to struct object_info_source
      treewide: convert users of `whence` to the new source field
      odb: drop `whence` field from object info
      odb: document object info fields
      reset: introduce ability to skip updating HEAD
      reset: allow the caller to specify the current HEAD object
      reset: stop assuming that the caller passes in a clean index
      replay: expose `replay_result_queue_update()`
      builtin/history: split handling of ref updates into two phases
      builtin/history: implement "drop" subcommand
      meson: support building fuzzers with libFuzzer
      oss-fuzz: add fuzzer for parsing reftables
      reftable/basics: fix OOB read on binary search of empty range
      reftable/record: don't abort when decoding invalid ref value type
      t/unit-tests: introduce test helper to write reftable blocks
      reftable/block: fix OOB write with bogus inflated log size
      reftable/block: fix OOB read with bogus block size
      reftable/block: fix OOB read with bogus restart count
      reftable/block: fix use of uninitialized memory when binsearch fails
      reftable/block: fix OOB read with bogus restart offset
      reftable/table: fix NULL pointer access when seeking to bogus offsets
      reftable/table: fix OOB read on truncated table
      README: add GitLab CI badge to make it more discoverable
      t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
      t4141: fix inefficient use of dd(1)
      t5608: reduce maximum disk usage
      t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
      t7900: clean up large EXPENSIVE repository
      t: use `test_bool_env` to parse GIT_TEST_LONG
      gitlab-ci: disable RAM disk on macOS jobs
      gitlab-ci: enable "GIT_TEST_LONG"
      builtin/refs: drop `the_repository`
      builtin/refs: add "delete" subcommand
      builtin/refs: add "update" subcommand
      builtin/refs: add "create" subcommand
      builtin/refs: add "rename" subcommand
      setup: rename `check_repository_format_gently()`
      setup: mark bogus worktree in `apply_repository_format()`
      setup: unify setup of shallow file
      setup: split up concerns of `setup_git_env_internal()`
      setup: introduce explicit repository discovery
      setup: embed repository format in discovery
      setup: move prefix into repository
      setup: drop static `cwd` variable
      setup: propagate prefix via repository discovery
      setup: make repository discovery self-contained
      setup: drop redundant configuration of `startup_info->have_repository`
      setup: pass worktree to `init_db()`
      setup: mark `set_git_work_tree()` as file-local
      object-file: fix closing object stream twice
      t7900: simplify how we check for maintenance tasks
      odb: run "pre-auto-gc" hook for all maintenance tasks
      builtin/gc: move worktree and rerere tasks before object optimizations
      builtin/gc: extract object database optimizations into separate function
      builtin/gc: make repack arguments self-contained
      builtin/gc: inline config values specific to the "files" backend
      builtin/gc: introduce object database optimization options
      builtin/gc: move geometric repacking into `odb_optimize()`
      builtin/gc: introduce `odb_optimize_required()`
      builtin/gc: refactor ODB optimizations to operate on "files" source
      builtin/gc: fix signedness issues in ODB-related functionality
      odb: make optimizations pluggable
      odb/source-packed: improve lookup when enumerating objects
      pack-bitmap: mark object filter as `const`
      pack-bitmap: allow aborting iteration of bitmapped objects
      pack-bitmap: iterate object sources when opening bitmaps
      pack-bitmap: drop `_1` suffix from functions that open bitmaps
      pack-bitmap: introduce function to open bitmap for a single source
      odb: introduce object filters to `odb_for_each_object()`
      builtin/cat-file: filter objects via object database
      refs/packed: de-globalize handling of "core.packedRefsTimeout"
      refs/files: drop `USE_THE_REPOSITORY_VARIABLE`
      worktree: refactor code to use available repositories
      worktree: pass repository to file-local functions
      worktree: pass repository to public functions
      refs: remove remaining uses of `the_repository`
      refspec: group related structures and functions
      refspec: let callers pass in hash algorithm when parsing items
      refspec: stop depending on `the_repository`
      copy: drop dependency on `the_repository`
      odb: compute compat object ID in `odb_write_object_ext()`
      t/u-odb-inmemory: implement wrapper for writing objects
      odb: compute object hash in `odb_write_object_ext()`
      odb: lift object existence check out of the "loose" backend
      odb: support setting mtime when writing objects
      object-file: fix memory leak in `force_object_loose()`
      object-file: force objects loose via generic interface
      object-file: move `force_object_loose()`
      object-file: move logic to write loose objects
      odb/streaming: track write stream size in the structure
      odb/streaming: drop `is_finished` field
      odb/streaming: support streaming arbitrary object types
      odb/streaming: rename `struct odb_read_stream`
      odb/streaming: consolidate read and write streams
      odb/streaming: rename `struct read_object_fd_data`
      odb/streaming: rename `struct input_zstream_data`
      odb/streaming: unify function names to create new streams
      loose: load loose object map for the correct source
      setup: detangle loading of loose object maps
      setup: handle ODB-related environment variables in `odb_new()`
      setup: defer object database creation
      odb/source: introduce function to map source type to name
      odb: make creation of on-disk structures pluggable
      compat/posix: introduce writev(3p) wrapper
      wrapper: introduce writev(3p) wrappers
      wrapper: properly handle MAX_IO_SIZE in writev(3p)
      sideband: use writev(3p) to send pktlines
      fast-import: use writev(3p) to send cat-blob responses
      t7900: adapt some tests to use a throwaway repository
      t7900: fix flaky "maintenance.strategy" test
      setup: create ref and object databases after config is written
      odb: decouple source path comparisons from `the_repository`
      odb: eagerly initialize alternates
      odb: drop `loaded_alternates` field
      odb: drop `alternates_db` field
      odb/source-packed: flag known-bad objects as corrupt and not missing
      odb/source: introduce error status when reading objects
      odb/source: let callers discern missing and corrupt objects
      odb/source: allow `read_object_info()` to bubble up error messages
      odb: handle `OBJECT_INFO_DIE_IF_CORRUPT` generically
      odb: introduce interface to generate packfiles
      upload-pack: generate packfiles via the object database
      send-pack: generate packfiles via the object database
      builtin/bundle: refactor option handling for progress meter
      bundle: get (mostly) rid of `the_repository`
      bundle: generate packfiles via the object database
      odb/files: be less aggressive with geometric repacking

Philip Oakley (6):
      hash-object: demonstrate a >4GB/LLP64 problem
      object-file.c: use size_t for header lengths
      hash algorithms: use size_t for section lengths
      hash-object --stdin: verify that it works with >4GB/LLP64
      hash-object: add another >4GB/LLP64 test case
      hash-object: add a >4GB/LLP64 test case using filtered input

Phillip Wood (13):
      sequencer: factor out parsing of todo commands
      status: improve rebase todo list parsing
      t3400: restore coverage for note copying with apply backend
      sequencer: be more careful with external merge
      sequencer: never reschedule on failed commit
      sequencer: remove unnecessary "or" in pick_one_commit()
      sequencer: simplify handling of fixup with conflicts
      sequencer: remove unnecessary condition in pick_one_commit()
      sequencer: simplify pick_one_commit()
      sequencer: use an enum to represent result of picking a commit
      sequencer: do not record dropped commits as rewritten
      rebase -i: fix counting of fixups after rebase --skip
      rebase: remember fixup -c after skipping fixup/squash

René Scharfe (14):
      cat-file: speed up default format
      blame: reserve mark column only if necessary
      strbuf: avoid redundant reset in strbuf_getwholeline()
      tempfile: add repo_create_tempfile{,_mode}()
      refs/packed: use repo_create_tempfile()
      lockfile: add repo_hold_lock_file_for_update{,_timeout}{,_mode}()
      tempfile: stop using the_repository
      use repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos
      remote-curl: simplify passing of push specs
      branch: report active bisect run when rejecting delete
      worktree add: don't read out of bounds in worktree_basename()
      worktree add: reject separator-only path
      worktree add: trim slashes when deriving branch name from path
      worktree add: let worktree_basename() return string copy

SZEDER Gábor (1):
      t3420-rebase-autostash: don't try to grep non-existing files

Sahitya Chandra (1):
      wt-status: avoid repeated insertion for untracked paths

Shardul Natu (3):
      Makefile: add $(RUST_LIB) prerequisite to osxkeychain
      Makefile: support universal macOS builds via RUST_TARGETS
      contrib: wire up osxkeychain in contrib/Makefile on macOS

Shlok Kulshreshtha (7):
      t1100: modernize test style
      t1100: move creation of expected output into setup test
      t7614: avoid hiding git's exit code in a pipe
      userdiff: add support for Swift
      test-lib-functions: add commit_body helper
      t: use commit_body to extract commit message bodies
      object-name: avoid use-after-free in get_oid_with_context_1()

Siddharth Shrimali (6):
      builtin/repack: add --drop-filtered and --dry-run options
      list-objects-filter: add list_objects_filter__filter_oidset()
      repack-promisor: allow excluding objects from the rebuilt promisor pack
      builtin/repack: enumerate promisor blobs for --drop-filtered
      builtin/repack: actually drop filtered promisor blobs
      builtin/repack: add guards for --drop-filtered

Swapnil Saste | INDIA (1):
      doc: fix typo in submitting patches

Tamir Duberstein (4):
      ref-filter: restore prefix-scoped iteration
      commit-reach: reject cycles in contains walk
      ref-filter: memoize --contains with generations
      commit-reach: die on contains walk errors

Taylor Blau (5):
      t/perf: drop p5311's lookup-table permutation
      pack-objects: support reachability bitmaps with `--path-walk`
      pack-objects: extract `record_tree_depth()` helper
      pack-objects: support `--delta-islands` with `--path-walk`
      mailmap: map Taylor Blau's work address

Ted Nyman (8):
      pathspec: use match for sparse-index expansion checks
      stash: avoid sparse-index expansion for in-cone paths
      http-fetch: correct --index-pack-arg documentation
      http: avoid closing index-pack input twice
      http: accept HTTP 416 for complete partial packs
      http: avoid concurrent appends to partial packs
      http: permit unlinking partial packs on Windows
      fetch-pack: accept "pack" output for packfile URIs

Tian Yuchen (19):
      environment: move 'protect_hfs' and 'protect_ntfs' into 'repo_config_values'
      environment: move ignore_case into repo_config_values
      config: use repo_ignore_case() to access core.ignorecase
      environment: use 'repo->initialized' for repo_protect_hfs() and repo_protect_ntfs()
      repository: introduce repo_config_values_clear()
      environment: move excludes_file into repo_config_values
      environment: move editor_program into repo_config_values
      environment: move pager_program into repo_config_values
      environment: move askpass_program into repo_config_values
      environment: migrate apply_default_whitespace and apply_default_ignorewhitespace
      environment: move push_default into repo_config_values
      environment: move autorebase into repo_config_values
      environment: move object_creation_mode into repo_config_values
      repository: adjust the comment of config_values_private_
      read-cache: remove redundant extern declarations
      read-cache: pass 'repo' to 'ce_mode_from_stat()'
      environment: move trust_executable_bit into repo_config_values
      environment: move has_symlinks into repo_config_values
      repository: move fetch_if_missing into struct repository

Toon Claes (5):
      bundle-uri: drain remaining response on invalid bundle-uri lines
      merge: fix leak with merge.defaultToUpstream
      replay: add helper to put entry into replayed_commits
      replay: resolve the replay base outside pick_regular_commit()
      replay: offer an option to linearize the commit topology

Travor Liu (1):
      gitweb: shorten index hashes with trailing file modes

Vincent Mailhol (4):
      completion: add 'git history' subcommands
      completion: complete 'git history --empty' values
      completion: complete 'git history --update-refs' values
      completion: complete 'git history split' pathspecs

Weijie Yuan (3):
      MyFirstContribution: mention trimming quoted text in replies
      doc: encourage review replies before rerolling
      doc: advise batching patch rerolls

Yoichi NAKAYAMA (6):
      worktree add: shouldn't dwim if -b or -B is given
      checkout: extract function to display advice for ambiguous remotes
      checkout: improve message for ambiguous remote branch name
      worktree add: improve message for ambiguous remote branch name
      worktree add: treat multiple matches with --guess-remote as an error
      worktree repair: detect relative path in .git file correctly

basuradeluis (1):
      gitk: spanish translations

brian m. carlson (6):
      t1517: skip svn tests if svn is not installed
      parse-options: add a separate case for help output on error
      rev-parse: have --parseopt callers exit 0 on --help
      parse-options: exit 0 on -h
      hash: initialize context before cloning
      rust: discard hash context when finished

Éric NICOLAS (1):
      submodule: resolve insteadOf aliases when matching remote

