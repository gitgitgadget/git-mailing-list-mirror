From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Tue, 09 May 2006 20:11:31 -0700
Message-ID: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 10 05:11:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdf6v-00029Y-Sm
	for gcvg-git@gmane.org; Wed, 10 May 2006 05:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWEJDLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 23:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWEJDLe
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 23:11:34 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50939 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964775AbWEJDLd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 23:11:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060510031132.VJPB9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 23:11:32 -0400
To: git@vger.kernel.org
X-maint-at: d1802851b0c112a065b43e3f83d631f867b7e1ce
X-master-at: f7a3276bab880222e3117f8b8cbef40920dfe884
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19868>

This week's "What's in" is a day early, since I do not expect to
be able to do much gitting for the rest of the week.

* The 'maint' branch has these fixes since the last announcement.

Dmitry V. Levin:
      Separate object name errors from usage errors

Eric Wong:
      apply: fix infinite loop with multiple patches with --index

Johannes Schindelin:
      repo-config: trim white-space before comment

Junio C Hamano:
      core.prefersymlinkrefs: use symlinks for .git/HEAD
      repo-config: document what value_regexp does a bit more clearly.
      Fix repo-config set-multivar error return path.
      Documentation: {caret} fixes (git-rev-list.txt)

Linus Torvalds:
      Fix "git diff --stat" with long filenames
      revert/cherry-pick: use aggressive merge.

Martin Waitz:
      clone: keep --reference even with -l -s
      repack: honor -d even when no new pack was created

Matthias Lederhofer:
      core-tutorial.txt: escape asterisk

Pavel Roskin:
      Release config lock if the regex is invalid

Sean Estabrooks:
      Fix for config file section parsing.

Yakov Lerner:
      read-cache.c: use xcalloc() not calloc()


* The 'master' branch has these since the last announcement, in
  addition to the above.  I've flushed topics that have been
  cooked in "next" long enough and hadn't given me problems.

Eric Wong:
      git-svn: documentation updates
      git-svn 1.0.0

Johannes Schindelin:
      builtin-push: --all and --tags _are_ explicit refspecs
      Fix users of prefix_path() to free() only when necessary
      Fix users of prefix_path() to free() only when necessary

Junio C Hamano:
      get_sha1(): :path and :[0-3]:path to extract from index.
      Makefile: do not link rev-list any specially.
      delta: stricter constness
      pack-object: squelch eye-candy on non-tty
      binary patch.
      binary diff: further updates.
      update-index --unresolve: work from a subdirectory.
      checkout-index: plug memory leak from prefix_path()
      update-index: plug memory leak from prefix_path()
      update-index --again
      update-index --again: take optional pathspecs
      binary diff and apply: testsuite.
      repo-config: document what value_regexp does a bit more clearly.
      get_sha1() - fix infinite loop on nonexistent stage.
      Teach git-clean optional <paths>... parameters.
      checkout: use --aggressive when running a 3-way merge (-m).

Martin Waitz:
      Transitively read alternatives
      test case for transitive info/alternates
      clone: don't clone the info/alternates file

Nicolas Pitre:
      split the diff-delta interface
      use delta index data when finding best delta matches
      replace adler32 with Rabin's polynomial in diff-delta
      tiny optimization to diff-delta
      improve diff-delta with sparse and/or repetitive data
      improve base85 generated assembly code

Peter Hagervall:
      Sparse fix for builtin-diff

Sean Estabrooks:
      Several trivial documentation touch ups.
      Fix up docs where "--" isn't displayed correctly.
      Update git-unpack-objects documentation.
      Clarify git-cherry documentation.
      Another config file parsing fix.
      t1300-repo-config: two new config parsing tests.


* The 'next' branch, in addition, has these.

  - cvsserver and cvsexportcommit updates (Martin Langhoff and Martyn Smith)

    This is a new merge but not very new code.  Martin may want
    to comment on how ready they are.

  - built-in fmt-patch (Johannes Schindelin)

    I think this is ready, even though it does not have some
    things we have in format-patch (i.e. --attach, --signoff,
    --check).  If anybody deeply cares please stop me soon or
    better yet enhance with your patches; otherwise I would like
    to push this out to "master" sometime next week to supersede
    the git-format-patch script.

  - built-in grep (me)

    I think this is also ready, even though it robs users from
    having funky "grep" on their $PATH and invoke it.  Compared
    to GNU grep, it lacks -P (pcre), -Z (NUL-terminated output),
    -q (totally quiet), -z (NUL-terminated input), but all the
    commonly used ones including -f (from file), -F (fixed), -w
    (word regexp), -l/-L (files with/without match) and -n (line
    number) are implemented.  The same "stop me or else" comment
    applies.

  - use config "remote.$name.url" and friends for fetch/pull
    (Johannes Schindelin)

    I think this itself is ready; the only reason I do not plan
    to do so this week is to wait until the new config format
    discussion settles, at which time we would need to adjust
    this to the new format.

  - cache-tree (me)

    This has been stalled; I would want to redo it without using
    out-of-index data structure, but that would need the
    following steps, and lately I have too many distractions to
    concentrate on them.

    - review existing index/working-tree/tree walkers.

    - prepare a merge-tree style path walker that walks index,
      working tree, and zero or more trees in parallel.  This
      would probably have an interator interface to return list
      of either tree or blob <mode,sha1> to the caller.  Because
      index does not currently have tree entries, a "not
      up-to-date" tree entry would be returned from the index
      part of the walker if I base this change on "master".  I
      might base this on "next" and use information from
      cache-tree. 

    - using the parallel path walker, revamp diff-cache (both
      cached and non cached) to work out kinks to the walker API
      and see how well it performs.  If I base the work on
      "next", the code should be able to skip unchanged
      subtrees.

    - revamp diff-files (walks index and working tree), although
      this will not get any benefit from having tree entries in
      the index.

    - revamp read-tree (all forms).

    - if I based the work on "next", rip out the cache-tree
      dependency and make the walker return "not up-to-date"
      tree entries for index.

    - revamp update-index, apply, and write-tree to have tree
      entries in the index.  This probably involves revamping
      read-cache interface to update the index file contents.

    - review read-tree to make sure it correctly maintains the
      tree entries in the cache.

* The 'pu' branch, in addition, has the proposed configuration
  file syntax updates from Linus with a patch from Sean.  I
  haven't had time to really look at it, and it seems to fail a
  test right now, but I left it as is.  This is merged from a
  throw-away topic branch for now, but when I resume to gitting
  sometime next week I am hoping we have something ready to be
  tested (iow, "next" material) based on the list concensus.  At
  that time we might probably do backport to cope with the
  syntax updates for 1.3.X release and perhaps 1.2.X series just
  for fun.
