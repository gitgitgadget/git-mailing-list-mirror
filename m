Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EE11F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfHLTky (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:40:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53688 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfHLTkx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:40:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA392151D07;
        Mon, 12 Aug 2019 15:40:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=F0UDguthFxvEQnySEiweAi291
        Y4=; b=T6PjYgc8Yhv2YxpDWKs8IsqTu1pelMe+vpgesq2etRB087nivHLhczNF7
        iuNHKPBZ8fd9W1Q2DEz4F/Eg3d+ORvFDmAlUi0vkgUxpZgCY/SHH6VFpWdEUg/bT
        ahzJGdgcKazMrjS3Rl3fZKPaP/R/fTQCOEb6T3ipFvbWUEPMBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=bhocW4za5TLKLNszUAe
        o7v7m0vW1HUkueRxIC7ID2ig3xjWxyJds9MRtCd2m+qmejCik9/9lxQdZnXSpzK8
        2KVbmpLxuGhYFvn1XumudM7ZPq+dpOeytvr9EuLDWzq9MinhWtX+Hy/cSRuiuOLB
        gEbZPpb4xsRGUvGWdjcGizg0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D02A1151D04;
        Mon, 12 Aug 2019 15:40:42 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34EB3151D03;
        Mon, 12 Aug 2019 15:40:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.22.1
X-Gnus-Delayed: Mon, 12 Aug 2019 11:51:33 -0700
Date:   Mon, 12 Aug 2019 12:40:41 -0700
Message-ID: <xmqqh86m9npi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11E1F7A6-BD39-11E9-B782-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A maintenance release Git v2.22.1 is now available at the usual
places.  This backports many of the fixes that appeared already
on the 'master' front in preparation for the upcoming v2.23 release
of Git.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.22.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.22.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.22
-----------------

 * A relative pathname given to "git init --template=3D<path> <repo>"
   ought to be relative to the directory "git init" gets invoked in,
   but it instead was made relative to the repository, which has been
   corrected.

 * "git worktree add" used to fail when another worktree connected to
   the same repository was corrupt, which has been corrected.

 * The ownership rule for the file descriptor to fast-import remote
   backend was mixed up, leading to unrelated file descriptor getting
   closed, which has been fixed.

 * "git update-server-info" used to leave stale packfiles in its
   output, which has been corrected.

 * The server side support for "git fetch" used to show incorrect
   value for the HEAD symbolic ref when the namespace feature is in
   use, which has been corrected.

 * "git am -i --resolved" segfaulted after trying to see a commit as
   if it were a tree, which has been corrected.

 * "git bundle verify" needs to see if prerequisite objects exist in
   the receiving repository, but the command did not check if we are
   in a repository upfront, which has been corrected.

 * "git merge --squash" is designed to update the working tree and the
   index without creating the commit, and this cannot be countermanded
   by adding the "--commit" option; the command now refuses to work
   when both options are given.

 * The data collected by fsmonitor was not properly written back to
   the on-disk index file, breaking t7519 tests occasionally, which
   has been corrected.

 * Update to Unicode 12.1 width table.

 * The command line to invoke a "git cat-file" command from inside
   "git p4" was not properly quoted to protect a caret and running a
   broken command on Windows, which has been corrected.

 * "git request-pull" learned to warn when the ref we ask them to pull
   from in the local repository and in the published repository are
   different.

 * When creating a partial clone, the object filtering criteria is
   recorded for the origin of the clone, but this incorrectly used a
   hardcoded name "origin" to name that remote; it has been corrected
   to honor the "--origin <name>" option.

 * "git fetch" into a lazy clone forgot to fetch base objects that are
   necessary to complete delta in a thin packfile, which has been
   corrected.

 * The filter_data used in the list-objects-filter (which manages a
   lazily sparse clone repository) did not use the dynamic array API
   correctly---'nr' is supposed to point at one past the last element
   of the array in use.  This has been corrected.

 * The description about slashes in gitignore patterns (used to
   indicate things like "anchored to this level only" and "only
   matches directories") has been revamped.

 * The URL decoding code has been updated to avoid going past the end
   of the string while parsing %-<hex>-<hex> sequence.

 * The list of for-each like macros used by clang-format has been
   updated.

 * "git push --atomic" that goes over the transport-helper (namely,
   the smart http transport) failed to prevent refs to be pushed when
   it can locally tell that one of the ref update will fail without
   having to consult the other end, which has been corrected.

 * "git clean" silently skipped a path when it cannot lstat() it; now
   it gives a warning.

 * A codepath that reads from GPG for signed object verification read
   past the end of allocated buffer, which has been fixed.

 * "git rm" to resolve a conflicted path leaked an internal message
   "needs merge" before actually removing the path, which was
   confusing.  This has been corrected.

 * The "git clone" documentation refers to command line options in its
   description in the short form; they have been replaced with long
   forms to make them more recognisable.

 * The configuration variable rebase.rescheduleFailedExec should be
   effective only while running an interactive rebase and should not
   affect anything when running a non-interactive one, which was not
   the case.  This has been corrected.

 * "git submodule foreach" did not protect command line options passed
   to the command to be run in each submodule correctly, when the
   "--recursive" option was in use.

 * Use "Erase in Line" CSI sequence that is already used in the editor
   support to clear cruft in the progress output.

 * The codepath to compute delta islands used to spew progress output
   without giving the callers any way to squelch it, which has been
   fixed.

 * The code to parse scaled numbers out of configuration files has
   been made more robust and also easier to follow.

 * An incorrect list of options was cached after command line
   completion failed (e.g. trying to complete a command that requires
   a repository outside one), which has been corrected.

 * "git rebase --abort" used to leave refs/rewritten/ when concluding
   "git rebase -r", which has been corrected.

 * "git stash show 23" used to work, but no more after getting
   rewritten in C; this regression has been corrected.

 * "git interpret-trailers" always treated '#' as the comment
   character, regardless of core.commentChar setting, which has been
   corrected.

 * Code clean-up to avoid signed integer overlaps during binary search.

 * "git checkout -p" needs to selectively apply a patch in reverse,
   which did not work well.

 * The commit-graph file is now part of the "files that the runtime
   may keep open file descriptors on, all of which would need to be
   closed when done with the object store", and the file descriptor to
   an existing commit-graph file now is closed before "gc" finalizes a
   new instance to replace it.

 * Code restructuring during 2.20 period broke fetching tags via
   "import" based transports.

 * We have been trying out a few language features outside c89; the
   coding guidelines document did not talk about them and instead had
   a blanket ban against them.

 * The internal diff machinery can be made to read out of bounds while
   looking for --funcion-context line in a corner case, which has been
   corrected.

Also contains various documentation updates, code clean-ups and minor fix=
ups.

----------------------------------------------------------------

Changes since v2.22.0 are as follows:

Beat Bolli (1):
      unicode: update the width tables to Unicode 12.1

Carlo Marcelo Arenas Bel=C3=B3n (5):
      fsmonitor: avoid signed integer overflow / infinite loop
      wrapper: avoid undefined behaviour in macOS
      xdiff: drop system includes in xutils.c
      xdiff: remove duplicate headers from xhistogram.c
      xdiff: remove duplicate headers from xpatience.c

Chris Mayo (1):
      send-email: update documentation of required Perl modules

Denton Liu (2):
      config/alias.txt: change " and ' to `
      config/alias.txt: document alias accepting non-command first word

Derrick Stolee (15):
      commit-graph: fix the_repository reference
      sha1-file: split OBJECT_INFO_FOR_PREFETCH
      commit-graph: return with errors during write
      commit-graph: collapse parameters into flags
      commit-graph: remove Future Work section
      commit-graph: create write_commit_graph_context
      commit-graph: extract fill_oids_from_packs()
      commit-graph: extract fill_oids_from_commit_hex()
      commit-graph: extract fill_oids_from_all_packs()
      commit-graph: extract count_distinct_commits()
      commit-graph: extract copy_oids_to_commits()
      commit-graph: extract write_commit_graph_file()
      commit-graph: use raw_object_store when closing
      packfile: close commit-graph in close_all_packs
      packfile: rename close_all_packs to close_object_store

Doug Ilijev (1):
      README: fix rendering of text in angle brackets

Dr. Adam Nielsen (1):
      gitignore.txt: make slash-rules more readable

Emily Shaffer (3):
      grep: fail if call could output and name is null
      doc: hint about GIT_DEBUGGER in CodingGuidelines
      transport-helper: enforce atomic in push_refs_with_push

Eric Wong (1):
      server-info: do not list unlinked packs

Felipe Contreras (5):
      t5801 (remote-helpers): cleanup refspec stuff
      t5801 (remote-helpers): add test to fetch tags
      fetch: trivial cleanup
      fetch: make the code more understandable
      fetch: fix regression with transport helpers

Jakub Wilk (1):
      doc: don't use git.kernel.org as example gitweb URL

Jeff King (10):
      upload-pack: strip namespace from symref data
      am: simplify prompt response handling
      am: read interactive input from stdin
      am: drop tty requirement for --interactive
      am: fix --interactive HEAD tree resolution
      interpret-trailers: load default config
      verify-tag: drop signal.h include
      wt-status.h: drop stdio.h include
      delta-islands: respect progress flag
      xdiff: clamp function context indices in post-image

Johannes Schindelin (14):
      bisect--helper: verify HEAD could be parsed before continuing
      fill_stat_cache_info(): prepare for an fsmonitor fix
      mark_fsmonitor_valid(): mark the index as changed if needed
      bundle verify: error out if called without an object database
      poll (mingw): allow compiling with GCC 8 and DEVELOPER=3D1
      kwset: allow building with GCC 8
      winansi: simplify loading the GetCurrentConsoleFontEx() function
      config: avoid calling `labs()` on too-large data type
      t3404: fix a typo
      t0001: fix on case-insensitive filesystems
      rebase --am: ignore rebase.rescheduleFailedExec
      diff: munmap() file contents before running external diff
      mingw: support spawning programs containing spaces in their names
      clean: show an error message when the path is too long

Jonathan Tan (5):
      t5616: refactor packfile replacement
      index-pack: prefetch missing REF_DELTA bases
      t5616: use correct flag to check object is missing
      t5616: cover case of client having delta base
      t5551: test usage of chunked encoding explicitly

Josh Steadmon (1):
      trace2: correct trace2 field name documentation

Junio C Hamano (6):
      transport-helper: avoid var decl in for () loop control
      rm: resolving by removal is not a warning-worthy event
      CodingGuidelines: spell out post-C89 rules
      Flush fixes up to the third batch post 2.22.0
      Merge fixes made on the 'master' front
      Git 2.22.1

Martin =C3=85gren (1):
      RelNotes/2.21.1: typofix

Matthew DeVore (3):
      list-objects-filter: correct usage of ALLOC_GROW
      url: do not read past end of buffer
      url: do not allow %00 to represent NUL in URLs

Miguel Ojeda (1):
      clang-format: use git grep to generate the ForEachMacros list

Mike Hommey (2):
      dup() the input fd for fast-import used for remote helpers
      Use xmmap_gently instead of xmmap in use_pack

Mike Mueller (1):
      p4 unshelve: fix "Not a valid object name HEAD0" on Windows

Morian Sonnet (1):
      submodule foreach: fix recursion of options

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
      init: make --template path relative to $CWD
      worktree add: be tolerant of corrupt worktrees
      completion: do not cache if --git-completion-helper fails

Paolo Bonzini (2):
      request-pull: quote regex metacharacters in local ref
      request-pull: warn if the remote object is not the same as the loca=
l one

Philip Oakley (2):
      doc branch: provide examples for listing remote tracking branches
      .mailmap: update email address of Philip Oakley

Phillip Wood (5):
      rebase: fix a memory leak
      rebase: warn if state directory cannot be removed
      sequencer: return errors from sequencer_remove_state()
      rebase --abort/--quit: cleanup refs/rewritten
      add -p: fix checkout -p with pathological context

Quentin Nerden (2):
      docs: git-clone: refer to long form of options
      docs: git-clone: list short form of options first

Ren=C3=A9 Scharfe (6):
      cleanup: fix possible overflow errors in binary search, part 2
      coccinelle: use COPY_ARRAY for copying arrays
      use COPY_ARRAY for copying arrays
      config: use unsigned_mult_overflows to check for overflows
      config: don't multiply in parse_unit_factor()
      config: simplify parsing of unit factors

Robert Morgan (1):
      gpg(docs): use correct --verify syntax

SZEDER G=C3=A1bor (11):
      t3404: modernize here doc style
      t3404: make the 'rebase.missingCommitsCheck=3Dignore' test more foc=
used
      pager: add a helper function to clear the last line in the terminal
      t5551: use 'test_i18ngrep' to check translated output
      rebase: fix garbled progress display with '-x'
      progress: use term_clear_line()
      Document that 'git -C ""' works and doesn't change directory
      ci: don't update Homebrew
      ci: disable Homebrew's auto cleanup
      ci/lib.sh: update a comment about installed P4 and Git-LFS versions
      Documentation/git-fsck.txt: include fsck.* config variables

Simon Williams (1):
      git-p4: allow unshelving of branched files

Steven Roberts (1):
      gpg-interface: do not scan past the end of buffer

Thomas Gummerer (1):
      stash: fix show referencing stash index

Varun Naik (1):
      read-cache.c: do not die if mmap fails

Vishal Verma (1):
      merge: refuse --commit with --squash

Xin Li (1):
      clone: respect user supplied origin name when setting up partial cl=
one

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
      hash-object doc: stop mentioning git-cvsimport

