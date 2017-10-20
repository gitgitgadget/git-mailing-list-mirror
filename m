Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9831FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 06:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdJTGt4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 02:49:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53665 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751017AbdJTGtw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 02:49:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 309F1A43CC;
        Fri, 20 Oct 2017 02:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=pZExCWHED1qFux+X4T0gDs0lB
        C0=; b=D69JblEfU188qCy75R4AUueQo+dX3W0qhprpFcl5HReL6UYMvS8zXyQIS
        i1G7DWlcbatQ4YZpmvOY20FM2qlzU0ijhme0Hq7fjANzSbN6rVTryGLxPNqCQ6+X
        0IY7FNsuPfffAkDHfejkV/s5F82mQO+Z4y5TgXPbFHgnf/vke4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Z3Nx7wJOH9+ZaSv+y7a
        pvRWcFt//O7QYwi6JyOCIOjrf9mmTKKLTUCQm1ynnQNjPMU2fMItBi0yMhzoMWfW
        IS6S0GI+8m3qTgEOGjIF1VZXkhyMoVpAk3GpIxKoL6N3WXmj7UDTqEFNpcczfaPm
        zs+hk9Q6TTwIdUwlgmOdaEII=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28534A43CB;
        Fri, 20 Oct 2017 02:49:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5084DA43CA;
        Fri, 20 Oct 2017 02:49:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.15.0-rc2
Date:   Fri, 20 Oct 2017 15:49:43 +0900
Message-ID: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DAFBAAA0-B562-11E7-ACE1-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A release candidate Git v2.15.0-rc2 is now available for testing
at the usual places.  It is comprised of 737 non-merge commits
since v2.14.0, contributed by 75 people, 22 of which are new faces.

We had to back-track a bit wrt to the "git add -p" regression; for
now, we simply revert the changes that caused issues to users
without redefining 'color.ui=3Dalways' to mean 'color.ui=3Dauto', which
may or may not happen in future releases.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.15.0-rc2' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.14.0 are as follows.
Welcome to the Git development community!

  Ann T Ropea, Daniel Watkins, Derrick Stolee, Dimitrios
  Christidis, Eric Rannaud, Evan Zacks, Hielke Christian Braun,
  Ian Campbell, Ilya Kantor, Jameson Miller, Job Snijders, Joel
  Teichroeb, joernchen, =C5=81ukasz Gryglicki, Manav Rathi, Martin
  =C3=85gren, Michael Forney, Patryk Obara, Randall S. Becker, Ross
  Kabus, Taylor Blau, and Urs Thuermann.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Andreas Heiduk,
  Anthony Sottile, Ben Boeckel, Brandon Casey, Brandon Williams,
  brian m. carlson, Christian Couder, David Glasser, Eric Blake,
  Han-Wen Nienhuys, Heiko Voigt, Jean-Noel Avila, Jeff Hostetler,
  Jeff King, Johannes Schindelin, Johannes Sixt, Jonathan Nieder,
  Jonathan Tan, Junio C Hamano, Kaartic Sivaraam, Kevin Daudt,
  Kevin Willford, Lars Schneider, Martin Koegler, Matthieu Moy,
  Max Kirillov, Michael Haggerty, Michael J Gruber, Nguy=E1=BB=85n Th=C3=A1=
i
  Ng=E1=BB=8Dc Duy, Nicolas Morey-Chaisemartin, =C3=98ystein Walle, Paolo
  Bonzini, Pat Thoyts, Philip Oakley, Phillip Wood, Ralf Thielow,
  Raman Gupta, Ramsay Jones, Ren=C3=A9 Scharfe, Sahil Dua, Santiago
  Torres, Stefan Beller, Stephan Beyer, Takashi Iwai, Thomas
  Braun, Thomas Gummerer, Todd Zullinger, Tom G. Christensen,
  Torsten B=C3=B6gershausen, William Duclot, and W. Trevor King.

----------------------------------------------------------------

Git 2.15 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Backward compatibility notes and other notable changes.

 * Use of an empty string as a pathspec element that is used for
   'everything matches' is still warned and Git asks users to use a
   more explicit '.' for that instead.  The hope is that existing
   users will not mind this change, and eventually the warning can be
   turned into a hard error, upgrading the deprecation into removal of
   this (mis)feature.  That is now scheduled to happen in Git v2.16,
   the next major release after this one.

 * Git now avoids blindly falling back to ".git" when the setup
   sequence said we are _not_ in Git repository.  A corner case that
   happens to work right now may be broken by a call to BUG().
   We've tried hard to locate such cases and fixed them, but there
   might still be cases that need to be addressed--bug reports are
   greatly appreciated.

 * "branch --set-upstream" that has been deprecated in Git 1.8 has
   finally been retired.


Updates since v2.14
-------------------

UI, Workflows & Features

 * An example that is now obsolete has been removed from a sample hook,
   and an old example in it that added a sign-off manually has been
   improved to use the interpret-trailers command.

 * The advice message given when "git rebase" stops for conflicting
   changes has been improved.

 * The "rerere-train" script (in contrib/) learned the "--overwrite"
   option to allow overwriting existing recorded resolutions.

 * "git contacts" (in contrib/) now lists the address on the
   "Reported-by:" trailer to its output, in addition to those on
   S-o-b: and other trailers, to make it easier to notify (and thank)
   the original bug reporter.

 * "git rebase", especially when it is run by mistake and ends up
   trying to replay many changes, spent long time in silence.  The
   command has been taught to show progress report when it spends
   long time preparing these many changes to replay (which would give
   the user a chance to abort with ^C).

 * "git merge" learned a "--signoff" option to add the Signed-off-by:
   trailer with the committer's name.

 * "git diff" learned to optionally paint new lines that are the same
   as deleted lines elsewhere differently from genuinely new lines.

 * "git interpret-trailers" learned to take the trailer specifications
   from the command line that overrides the configured values.

 * "git interpret-trailers" has been taught a "--parse" and a few
   other options to make it easier for scripts to grab existing
   trailer lines from a commit log message.

 * The "--format=3D%(trailers)" option "git log" and its friends take
   learned to take the 'unfold' and 'only' modifiers to normalize its
   output, e.g. "git log --format=3D%(trailers:only,unfold)".

 * "gitweb" shows a link to visit the 'raw' contents of blbos in the
   history overview page.

 * "[gc] rerereResolved =3D 5.days" used to be invalid, as the variable
   is defined to take an integer counting the number of days.  It now
   is allowed.

 * The code to acquire a lock on a reference (e.g. while accepting a
   push from a client) used to immediately fail when the reference is
   already locked---now it waits for a very short while and retries,
   which can make it succeed if the lock holder was holding it during
   a read-only operation.

 * "branch --set-upstream" that has been deprecated in Git 1.8 has
   finally been retired.

 * The codepath to call external process filter for smudge/clean
   operation learned to show the progress meter.

 * "git rev-parse" learned "--is-shallow-repository", that is to be
   used in a way similar to existing "--is-bare-repository" and
   friends.

 * "git describe --match <pattern>" has been taught to play well with
   the "--all" option.

 * "git branch" learned "-c/-C" to create a new branch by copying an
   existing one.

 * Some commands (most notably "git status") makes an opportunistic
   update when performing a read-only operation to help optimize later
   operations in the same repository.  The new "--no-optional-locks"
   option can be passed to Git to disable them.

 * "git for-each-ref --format=3D..." learned a new format element,
   %(trailers), to show only the commit log trailer part of the log
   message.


Performance, Internal Implementation, Development Support etc.

 * Conversion from uchar[20] to struct object_id continues.

 * Start using selected c99 constructs in small, stable and
   essentialpart of the system to catch people who care about
   older compilers that do not grok them.

 * The filter-process interface learned to allow a process with long
   latency give a "delayed" response.

 * Many uses of comparision callback function the hashmap API uses
   cast the callback function type when registering it to
   hashmap_init(), which defeats the compile time type checking when
   the callback interface changes (e.g. gaining more parameters).
   The callback implementations have been updated to take "void *"
   pointers and cast them to the type they expect instead.

 * Because recent Git for Windows do come with a real msgfmt, the
   build procedure for git-gui has been updated to use it instead of a
   hand-rolled substitute.

 * "git grep --recurse-submodules" has been reworked to give a more
   consistent output across submodule boundary (and do its thing
   without having to fork a separate process).

 * A helper function to read a single whole line into strbuf
   mistakenly triggered OOM error at EOF under certain conditions,
   which has been fixed.

 * The "ref-store" code reorganization continues.

 * "git commit" used to discard the index and re-read from the filesystem
   just in case the pre-commit hook has updated it in the middle; this
   has been optimized out when we know we do not run the pre-commit hook.
   (merge 680ee550d7 kw/commit-keep-index-when-pre-commit-is-not-run late=
r to maint).

 * Updates to the HTTP layer we made recently unconditionally used
   features of libCurl without checking the existence of them, causing
   compilation errors, which has been fixed.  Also migrate the code to
   check feature macros, not version numbers, to cope better with
   libCurl that vendor ships with backported features.

 * The API to start showing progress meter after a short delay has
   been simplified.
   (merge 8aade107dd jc/simplify-progress later to maint).

 * Code clean-up to avoid mixing values read from the .gitmodules file
   and values read from the .git/config file.

 * We used to spend more than necessary cycles allocating and freeing
   piece of memory while writing each index entry out.  This has been
   optimized.

 * Platforms that ship with a separate sha1 with collision detection
   library can link to it instead of using the copy we ship as part of
   our source tree.

 * Code around "notes" have been cleaned up.
   (merge 3964281524 mh/notes-cleanup later to maint).

 * The long-standing rule that an in-core lockfile instance, once it
   is used, must not be freed, has been lifted and the lockfile and
   tempfile APIs have been updated to reduce the chance of programming
   errors.

 * Our hashmap implementation in hashmap.[ch] is not thread-safe when
   adding a new item needs to expand the hashtable by rehashing; add
   an API to disable the automatic rehashing to work it around.

 * Many of our programs consider that it is OK to release dynamic
   storage that is used throughout the life of the program by simply
   exiting, but this makes it harder to leak detection tools to avoid
   reporting false positives.  Plug many existing leaks and introduce
   a mechanism for developers to mark that the region of memory
   pointed by a pointer is not lost/leaking to help these tools.

 * As "git commit" to conclude a conflicted "git merge" honors the
   commit-msg hook, "git merge" that records a merge commit that
   cleanly auto-merges should, but it didn't.

 * The codepath for "git merge-recursive" has been cleaned up.

 * Many leaks of strbuf have been fixed.

 * "git imap-send" has our own implementation of the protocol and also
   can use more recent libCurl with the imap protocol support.  Update
   the latter so that it can use the credential subsystem, and then
   make it the default option to use, so that we can eventually
   deprecate and remove the former.

 * "make style" runs git-clang-format to help developers by pointing
   out coding style issues.

 * A test to demonstrate "git mv" failing to adjust nested submodules
   has been added.
   (merge c514167df2 hv/mv-nested-submodules-test later to maint).

 * On Cygwin, "ulimit -s" does not report failure but it does not work
   at all, which causes an unexpected success of some tests that
   expect failures under a limited stack situation.  This has been
   fixed.

 * Many codepaths have been updated to squelch -Wimplicit-fallthrough
   warnings from Gcc 7 (which is a good code hygiene).

 * Add a helper for DLL loading in anticipation for its need in a
   future topic RSN.

 * "git status --ignored", when noticing that a directory without any
   tracked path is ignored, still enumerated all the ignored paths in
   the directory, which is unnecessary.  The codepath has been
   optimized to avoid this overhead.

 * The final batch to "git rebase -i" updates to move more code from
   the shell script to C has been merged.

 * Operations that do not touch (majority of) packed refs have been
   optimized by making accesses to packed-refs file lazy; we no longer
   pre-parse everything, and an access to a single ref in the
   packed-refs does not touch majority of irrelevant refs, either.

 * Add comment to clarify that the style file is meant to be used with
   clang-5 and the rules are still work in progress.

 * Many variables that points at a region of memory that will live
   throughout the life of the program have been marked with UNLEAK
   marker to help the leak checkers concentrate on real leaks..

 * Plans for weaning us off of SHA-1 has been documented.

 * A new "oidmap" API has been introduced and oidset API has been
   rewritten to use it.


Also contains various documentation updates and code clean-ups.


Fixes since v2.14
-----------------

 * "%C(color name)" in the pretty print format always produced ANSI
   color escape codes, which was an early design mistake.  They now
   honor the configuration (e.g. "color.ui =3D never") and also tty-ness
   of the output medium.

 * The http.{sslkey,sslCert} configuration variables are to be
   interpreted as a pathname that honors "~[username]/" prefix, but
   weren't, which has been fixed.

 * Numerous bugs in walking of reflogs via "log -g" and friends have
   been fixed.

 * "git commit" when seeing an totally empty message said "you did not
   edit the message", which is clearly wrong.  The message has been
   corrected.

 * When a directory is not readable, "gitweb" fails to build the
   project list.  Work this around by skipping such a directory.

 * Some versions of GnuPG fails to kill gpg-agent it auto-spawned
   and such a left-over agent can interfere with a test.  Work it
   around by attempting to kill one before starting a new test.

 * A recently added test for the "credential-cache" helper revealed
   that EOF detection done around the time the connection to the cache
   daemon is torn down were flaky.  This was fixed by reacting to
   ECONNRESET and behaving as if we got an EOF.

 * "git log --tag=3Dno-such-tag" showed log starting from HEAD, which
   has been fixed---it now shows nothing.

 * The "tag.pager" configuration variable was useless for those who
   actually create tag objects, as it interfered with the use of an
   editor.  A new mechanism has been introduced for commands to enable
   pager depending on what operation is being carried out to fix this,
   and then "git tag -l" is made to run pager by default.

 * "git push --recurse-submodules $there HEAD:$target" was not
   propagated down to the submodules, but now it is.

 * Commands like "git rebase" accepted the --rerere-autoupdate option
   from the command line, but did not always use it.  This has been
   fixed.

 * "git clone --recurse-submodules --quiet" did not pass the quiet
   option down to submodules.

 * Test portability fix for OBSD.

 * Portability fix for OBSD.

 * "git am -s" has been taught that some input may end with a trailer
   block that is not Signed-off-by: and it should refrain from adding
   an extra blank line before adding a new sign-off in such a case.

 * "git svn" used with "--localtime" option did not compute the tz
   offset for the timestamp in question and instead always used the
   current time, which has been corrected.

 * Memory leak in an error codepath has been plugged.

 * "git stash -u" used the contents of the committed version of the
   ".gitignore" file to decide which paths are ignored, even when the
   file has local changes.  The command has been taught to instead use
   the locally modified contents.

 * bash 4.4 or newer gave a warning on NUL byte in command
   substitution done in "git stash"; this has been squelched.

 * "git grep -L" and "git grep --quiet -L" reported different exit
   codes; this has been corrected.

 * When handshake with a subprocess filter notices that the process
   asked for an unknown capability, Git did not report what program
   the offending subprocess was running.  This has been corrected.

 * "git apply" that is used as a better "patch -p1" failed to apply a
   taken from a file with CRLF line endings to a file with CRLF line
   endings.  The root cause was because it misused convert_to_git()
   that tried to do "safe-crlf" processing by looking at the index
   entry at the same path, which is a nonsense---in that mode, "apply"
   is not working on the data in (or derived from) the index at all.
   This has been fixed.

 * Killing "git merge --edit" before the editor returns control left
   the repository in a state with MERGE_MSG but without MERGE_HEAD,
   which incorrectly tells the subsequent "git commit" that there was
   a squash merge in progress.  This has been fixed.

 * "git archive" did not work well with pathspecs and the
   export-ignore attribute.

 * In addition to "cc: <a@dd.re.ss> # cruft", "cc: a@dd.re.ss # cruft"
   was taught to "git send-email" as a valid way to tell it that it
   needs to also send a carbon copy to <a@dd.re.ss> in the trailer
   section.

 * "git branch -M a b" while on a branch that is completely unrelated
   to either branch a or branch b misbehaved when multiple worktree
   was in use.  This has been fixed.
   (merge 31824d180d nd/worktree-kill-parse-ref later to maint).

 * "git gc" and friends when multiple worktrees are used off of a
   single repository did not consider the index and per-worktree refs
   of other worktrees as the root for reachability traversal, making
   objects that are in use only in other worktrees to be subject to
   garbage collection.

 * A regression to "gitk --bisect" by a recent update has been fixed.

 * "git -c submodule.recurse=3Dyes pull" did not work as if the
   "--recurse-submodules" option was given from the command line.
   This has been corrected.

 * Unlike "git commit-tree < file", "git commit-tree -F file" did not
   pass the contents of the file verbatim and instead completed an
   incomplete line at the end, if exists.  The latter has been updated
   to match the behaviour of the former.

 * Many codepaths did not diagnose write failures correctly when disks
   go full, due to their misuse of write_in_full() helper function,
   which have been corrected.
   (merge f48ecd38cb jk/write-in-full-fix later to maint).

 * "git help co" now says "co is aliased to ...", not "git co is".
   (merge b3a8076e0d ks/help-alias-label later to maint).

 * "git archive", especially when used with pathspec, stored an empty
   directory in its output, even though Git itself never does so.
   This has been fixed.

 * API error-proofing which happens to also squelch warnings from GCC.

 * The explanation of the cut-line in the commit log editor has been
   slightly tweaked.
   (merge 8c4b1a3593 ks/commit-do-not-touch-cut-line later to maint).

 * "git gc" tries to avoid running two instances at the same time by
   reading and writing pid/host from and to a lock file; it used to
   use an incorrect fscanf() format when reading, which has been
   corrected.

 * The scripts to drive TravisCI has been reorganized and then an
   optimization to avoid spending cycles on a branch whose tip is
   tagged has been implemented.
   (merge 8376eb4a8f ls/travis-scriptify later to maint).

 * The test linter has been taught that we do not like "echo -e".

 * Code cmp.std.c nitpick.

 * A regression fix for 2.11 that made the code to read the list of
   alternate object stores overrun the end of the string.
   (merge f0f7bebef7 jk/info-alternates-fix later to maint).

 * "git describe --match" learned to take multiple patterns in v2.13
   series, but the feature ignored the patterns after the first one
   and did not work at all.  This has been fixed.

 * "git filter-branch" cannot reproduce a history with a tag without
   the tagger field, which only ancient versions of Git allowed to be
   created.  This has been corrected.
   (merge b2c1ca6b4b ic/fix-filter-branch-to-handle-tag-without-tagger la=
ter to maint).

 * "git cat-file --textconv" started segfaulting recently, which
   has been corrected.

 * The built-in pattern to detect the "function header" for HTML did
   not match <H1>..<H6> elements without any attributes, which has
   been fixed.

 * "git mailinfo" was loose in decoding quoted printable and produced
   garbage when the two letters after the equal sign are not
   hexadecimal.  This has been fixed.

 * The machinery to create xdelta used in pack files received the
   sizes of the data in size_t, but lost the higher bits of them by
   storing them in "unsigned int" during the computation, which is
   fixed.

 * The delta format used in the packfile cannot reference data at
   offset larger than what can be expressed in 4-byte, but the
   generator for the data failed to make sure the offset does not
   overflow.  This has been corrected.

 * The documentation for '-X<option>' for merges was misleadingly
   written to suggest that "-s theirs" exists, which is not the case.

 * "git fast-export" with -M/-C option issued "copy" instruction on a
   path that is simultaneously modified, which was incorrect.
   (merge b3e8ca89cf jt/fast-export-copy-modify-fix later to maint).

 * Many codepaths have been updated to squelch -Wsign-compare
   warnings.
   (merge 071bcaab64 rj/no-sign-compare later to maint).

 * Memory leaks in various codepaths have been plugged.
   (merge 4d01a7fa65 ma/leakplugs later to maint).

 * Recent versions of "git rev-parse --parseopt" did not parse the
   option specification that does not have the optional flags (*=3D?!)
   correctly, which has been corrected.
   (merge a6304fa4c2 bc/rev-parse-parseopt-fix later to maint).

 * The checkpoint command "git fast-import" did not flush updates to
   refs and marks unless at least one object was created since the
   last checkpoint, which has been corrected, as these things can
   happen without any new object getting created.
   (merge 30e215a65c er/fast-import-dump-refs-on-checkpoint later to main=
t).

 * Spell the name of our system as "Git" in the output from
   request-pull script.

 * Fixes for a handful memory access issues identified by valgrind.

 * Backports a moral equivalent of 2015 fix to the poll() emulation
   from the upstream gnulib to fix occasional breakages on HPE NonStop.

 * Users with "color.ui =3D always" in their configuration were broken
   by a recent change that made plumbing commands to pay attention to
   them as the patch created internally by "git add -p" were colored
   (heh) and made unusable.  This has been fixed by reverting the
   offending change.

 * In the "--format=3D..." option of the "git for-each-ref" command (and
   its friends, i.e. the listing mode of "git branch/tag"), "%(atom:)"
   (e.g. "%(refname:)", "%(body:)" used to error out.  Instead, treat
   them as if the colon and an empty string that follows it were not
   there.

 * An ancient bug that made Git misbehave with creation/renaming of
   refs has been fixed.

 * "git fetch <there> <src>:<dst>" allows an object name on the <src>
   side when the other side accepts such a request since Git v2.5, but
   the documentation was left stale.
   (merge 83558a412a jc/fetch-refspec-doc-update later to maint).

 * Update the documentation for "git filter-branch" so that the filter
   options are listed in the same order as they are applied, as
   described in an earlier part of the doc.
   (merge 07c4984508 dg/filter-branch-filter-order-doc later to maint).

 * Other minor doc, test and build updates and code cleanups.
   (merge f094b89a4d ma/parse-maybe-bool later to maint).
   (merge 6cdf8a7929 ma/ts-cleanups later to maint).
   (merge 7560f547e6 ma/up-to-date later to maint).
   (merge 0db3dc75f3 rs/apply-epoch later to maint).
   (merge 276d0e35c0 ma/split-symref-update-fix later to maint).
   (merge f777623514 ks/branch-tweak-error-message-for-extra-args later t=
o maint).
   (merge 33f3c683ec ks/verify-filename-non-option-error-message-tweak la=
ter to maint).
   (merge 7cbbf9d6a2 ls/filter-process-delayed later to maint).
   (merge 488aa65c8f wk/merge-options-gpg-sign-doc later to maint).
   (merge e61cb19a27 jc/branch-force-doc-readability-fix later to maint).

----------------------------------------------------------------

Changes since v2.14.0 are as follows:

Adam Dinwoodie (1):
      doc: correct command formatting

Andreas Heiduk (2):
      doc: add missing values "none" and "default" for diff.wsErrorHighli=
ght
      doc: clarify "config --bool" behaviour with empty string

Ann T Ropea (1):
      request-pull: capitalise "Git" to make it a proper noun

Anthony Sottile (1):
      git-grep: correct exit code with --quiet and -L

Ben Boeckel (1):
      Documentation: mention that `eol` can change the dirty status of pa=
ths

Brandon Casey (7):
      t1502: demonstrate rev-parse --parseopt option mis-parsing
      rev-parse parseopt: do not search help text for flag chars
      rev-parse parseopt: interpret any whitespace as start of help text
      git-rebase: don't ignore unexpected command line arguments
      t0040,t1502: Demonstrate parse_options bugs
      parse-options: write blank line to correct output stream
      parse-options: only insert newline in help text if needed

Brandon Williams (29):
      repo_read_index: don't discard the index
      repository: have the_repository use the_index
      submodule--helper: teach push-check to handle HEAD
      cache.h: add GITMODULES_FILE macro
      config: add config_from_gitmodules
      submodule: remove submodule.fetchjobs from submodule-config parsing
      submodule: remove fetch.recursesubmodules from submodule-config par=
sing
      submodule: check for unstaged .gitmodules outside of config parsing
      submodule: check for unmerged .gitmodules outside of config parsing
      submodule: merge repo_read_gitmodules and gitmodules_config
      grep: recurse in-process using 'struct repository'
      t7411: check configuration parsing errors
      submodule: don't use submodule_from_name
      add, reset: ensure submodules can be added or reset
      submodule--helper: don't overlay config in remote_submodule_branch
      submodule--helper: don't overlay config in update-clone
      fetch: don't overlay config with submodule-config
      submodule: don't rely on overlayed config when setting diffopts
      unpack-trees: don't respect submodule.update
      submodule: remove submodule_config callback routine
      diff: stop allowing diff to have submodules configured in .git/conf=
ig
      submodule-config: remove support for overlaying repository config
      submodule-config: move submodule-config functions to submodule-conf=
ig.c
      submodule-config: lazy-load a repository's .gitmodules file
      unpack-trees: improve loading of .gitmodules
      submodule: remove gitmodules_config
      clone: teach recursive clones to respect -q
      clang-format: outline the git project's coding style
      Makefile: add style build rule

Christian Couder (3):
      refs: use skip_prefix() in ref_is_hidden()
      sub-process: print the cmd when a capability is unsupported
      sha1-lookup: remove sha1_entry_pos() from header file

Daniel Watkins (1):
      diff-highlight: add clean target to Makefile

David Glasser (1):
      doc: list filter-branch subdirectory-filter first

Derrick Stolee (1):
      cleanup: fix possible overflow errors in binary search

Dimitrios Christidis (1):
      fmt-merge-msg: fix coding style

Eric Blake (1):
      git-contacts: also recognise "Reported-by:"

Eric Rannaud (1):
      fast-import: checkpoint: dump branches/tags/marks even if object_co=
unt=3D=3D0

Evan Zacks (1):
      doc: fix minor typos (extra/duplicated words)

Han-Wen Nienhuys (5):
      submodule.h: typofix
      submodule.c: describe submodule_to_gitdir() in a new comment
      real_path: clarify return value ownership
      read_gitfile_gently: clarify return value ownership.
      string-list.h: move documentation from Documentation/api/ into head=
er

Heiko Voigt (2):
      t5526: fix some broken && chains
      add test for bug in git-mv for recursive submodules

Hielke Christian Braun (1):
      gitweb: skip unreadable subdirectories

Ian Campbell (4):
      filter-branch: reset $GIT_* before cleaning up
      filter-branch: preserve and restore $GIT_AUTHOR_* and $GIT_COMMITTE=
R_*
      filter-branch: stash away ref map in a branch
      filter-branch: use hash-object instead of mktag

Ilya Kantor (1):
      userdiff: fix HTML hunk header regexp

Jameson Miller (1):
      Improve performance of git status --ignored

Jean-Noel Avila (1):
      i18n: add a missing space in message

Jeff Hostetler (1):
      hashmap: add API to disable item counting when threaded

Jeff King (134):
      t1414: document some reflog-walk oddities
      revision: disallow reflog walking with revs->limited
      log: clarify comment about reflog cycles
      log: do not free parents when walking reflog
      get_revision_1(): replace do-while with an early return
      rev-list: check reflog_info before showing usage
      reflog-walk: stop using fake parents
      reflog-walk: apply --since/--until to reflog dates
      check return value of verify_ref_format()
      docs/for-each-ref: update pointer to color syntax
      t: use test_decode_color rather than literal ANSI codes
      ref-filter: simplify automatic color reset
      ref-filter: abstract ref format into its own struct
      ref-filter: move need_color_reset_at_eol into ref_format
      ref-filter: provide a function for parsing sort options
      ref-filter: make parse_ref_filter_atom a private function
      ref-filter: factor out the parsing of sorting atoms
      ref-filter: pass ref_format struct to atom parsers
      color: check color.ui in git_default_config()
      for-each-ref: load config earlier
      rev-list: pass diffopt->use_colors through to pretty-print
      pretty: respect color settings for %C placeholders
      ref-filter: consult want_color() before emitting colors
      strbuf: use designated initializers in STRBUF_INIT
      t/lib-proto-disable: restore protocol.allow after config tests
      t5813: add test for hostname starting with dash
      connect: factor out "looks like command line option" check
      connect: reject dashed arguments for proxy commands
      connect: reject paths that look like command line options
      t6018: flesh out empty input/output rev-list tests
      revision: add rev_input_given flag
      rev-list: don't show usage when we see empty ref patterns
      revision: do not fallback to default when rev_input_given is set
      hashcmp: use memcmp instead of open-coded loop
      sha1_file: drop experimental GIT_USE_LOOKUP search
      trailer: put process_trailers() options into a struct
      interpret-trailers: add an option to show only the trailers
      interpret-trailers: add an option to show only existing trailers
      interpret-trailers: add an option to unfold values
      interpret-trailers: add --parse convenience option
      pretty: move trailer formatting to trailer.c
      t4205: refactor %(trailers) tests
      pretty: support normalization options for %(trailers)
      doc: fix typo in sendemail.identity
      config: use a static lock_file struct
      write_index_as_tree: cleanup tempfile on error
      setup_temporary_shallow: avoid using inactive tempfile
      setup_temporary_shallow: move tempfile struct into function
      verify_signed_buffer: prefer close_tempfile() to close()
      always check return value of close_tempfile
      tempfile: do not delete tempfile on failed close
      lockfile: do not rollback lock on failed close
      tempfile: prefer is_tempfile_active to bare access
      tempfile: handle NULL tempfile pointers gracefully
      tempfile: replace die("BUG") with BUG()
      tempfile: factor out activation
      tempfile: factor out deactivation
      tempfile: robustify cleanup handler
      tempfile: release deactivated strbufs instead of resetting
      tempfile: use list.h for linked list
      tempfile: remove deactivated list entries
      tempfile: auto-allocate tempfiles on heap
      lockfile: update lifetime requirements in documentation
      ref_lock: stop leaking lock_files
      stop leaking lock structs in some simple cases
      test-lib: --valgrind should not override --verbose-log
      test-lib: set LSAN_OPTIONS to abort by default
      add: free leaked pathspec after add_files_to_cache()
      update-index: fix cache entry leak in add_one_file()
      config: plug user_config leak
      reset: make tree counting less confusing
      reset: free allocated tree buffers
      repository: free fields before overwriting them
      set_git_dir: handle feeding gitdir to itself
      rev-parse: don't trim bisect refnames
      system_path: move RUNTIME_PREFIX to a sub-function
      git_extract_argv0_path: do nothing without RUNTIME_PREFIX
      add UNLEAK annotation for reducing leak false positives
      shortlog: skip format/parse roundtrip for internal traversal
      shell: drop git-cvsserver support by default
      archimport: use safe_pipe_capture for user input
      cvsimport: shell-quote variable used in backticks
      config: avoid "write_in_full(fd, buf, len) < len" pattern
      get-tar-commit-id: check write_in_full() return against 0
      avoid "write_in_full(fd, buf, len) !=3D len" pattern
      convert less-trivial versions of "write_in_full() !=3D len"
      pkt-line: check write_in_full() errors against "< 0"
      notes-merge: use ssize_t for write_in_full() return value
      config: flip return value of store_write_*()
      read_pack_header: handle signed/unsigned comparison in read result
      prefix_ref_iterator: break when we leave the prefix
      read_info_alternates: read contents into strbuf
      read_info_alternates: warn on non-trivial errors
      revision: replace "struct cmdline_pathspec" with argv_array
      cat-file: handle NULL object_context.path
      test-line-buffer: simplify command parsing
      curl_trace(): eliminate switch fallthrough
      consistently use "fallthrough" comments in switches
      doc: put literal block delimiter around table
      files-backend: prefer "0" for write_in_full() error check
      notes-merge: drop dead zero-write code
      prefer "!=3D" when checking read_in_full() result
      avoid looking at errno for short read_in_full() returns
      distinguish error versus short read from read_in_full()
      worktree: use xsize_t to access file size
      worktree: check the result of read_in_full()
      validate_headref: NUL-terminate HEAD buffer
      validate_headref: use skip_prefix for symref parsing
      validate_headref: use get_oid_hex for detached HEADs
      git: add --no-optional-locks option
      test-terminal: set TERM=3Dvt100
      t4015: prefer --color to -c color.diff=3Dalways
      t3701: use test-terminal to collect color output
      t7508: use test_terminal for color output
      t7502: use diff.noprefix for --verbose test
      t6006: drop "always" color config tests
      t3203: drop "always" color test
      t3205: use --color instead of color.branch=3Dalways
      provide --color option for all ref-filter users
      color: make "always" the same as "auto" in config
      t4015: use --color with --color-moved
      t7301: use test_terminal to check color
      path.c: fix uninitialized memory access
      sha1_loose_object_info: handle errors from unpack_sha1_rest
      t3308: create a real ref directory/file conflict
      refs_resolve_ref_unsafe: handle d/f conflicts for writes
      write_entry: fix leak when retrying delayed filter
      write_entry: avoid reading blobs in CE_RETRY case
      write_entry: untangle symlink and regular-file cases
      diff: fix infinite loop with --color-moved --ignore-space-change
      Revert "color: make "always" the same as "auto" in config"
      Revert "t6006: drop "always" color config tests"
      Revert "color: check color.ui in git_default_config()"
      tag: respect color.ui config

Job Snijders (1):
      gitweb: add 'raw' blob_plain link in history overview

Joel Teichroeb (3):
      stash: add a test for stash create with no files
      stash: add a test for when apply fails during stash branch
      stash: add a test for stashing in a detached state

Johannes Schindelin (14):
      run_processes_parallel: change confusing task_cb convention
      git-gui (MinGW): make use of MSys2's msgfmt
      t3415: verify that an empty instructionFormat is handled as before
      rebase -i: generate the script via rebase--helper
      rebase -i: remove useless indentation
      rebase -i: do not invent onelines when expanding/collapsing SHA-1s
      rebase -i: also expand/collapse the SHA-1s via the rebase--helper
      t3404: relax rebase.missingCommitsCheck tests
      rebase -i: check for missing commits in the rebase--helper
      rebase -i: skip unnecessary picks using the rebase--helper
      t3415: test fixup with wrapped oneline
      rebase -i: rearrange fixup/squash lines using the rebase--helper
      Win32: simplify loading of DLL functions
      clang-format: adjust line break penalties

Johannes Sixt (1):
      sub-process: use child_process.args instead of child_process.argv

Jonathan Nieder (8):
      vcs-svn: remove more unused prototypes and declarations
      vcs-svn: remove custom mode constants
      vcs-svn: remove repo_delete wrapper function
      vcs-svn: move remaining repo_tree functions to fast_export.h
      pack: make packed_git_mru global a value instead of a pointer
      pathspec doc: parse_pathspec does not maintain references to args
      technical doc: add a design doc for hash function transition
      strbuf doc: reuse after strbuf_release is fine

Jonathan Tan (40):
      fsck: remove redundant parse_tree() invocation
      object: remove "used" field from struct object
      fsck: cleanup unused variable
      Documentation: migrate sub-process docs to header
      sub-process: refactor handshake to common function
      tests: ensure fsck fails on corrupt packfiles
      sha1_file: set whence in storage-specific info fn
      sha1_file: remove read_packed_sha1()
      diff: avoid redundantly clearing a flag
      diff: respect MIN_BLOCK_LENGTH for last block
      diff: define block by number of alphanumeric chars
      Doc: clarify that pack-objects makes packs, plural
      pack: move pack name-related functions
      pack: move static state variables
      pack: move pack_report()
      pack: move open_pack_index(), parse_pack_index()
      pack: move release_pack_memory()
      pack: move pack-closing functions
      pack: move use_pack()
      pack: move unuse_pack()
      pack: move add_packed_git()
      pack: move install_packed_git()
      pack: move {,re}prepare_packed_git and approximate_object_count
      pack: move unpack_object_header_buffer()
      pack: move get_size_from_delta()
      pack: move unpack_object_header()
      pack: move clear_delta_base_cache(), packed_object_info(), unpack_e=
ntry()
      pack: move nth_packed_object_{sha1,oid}
      pack: move check_pack_index_ptr(), nth_packed_object_offset()
      pack: move find_pack_entry_one(), is_pack_valid()
      pack: move find_sha1_pack()
      pack: move find_pack_entry() and make it global
      pack: move has_sha1_pack()
      pack: move has_pack_index()
      pack: move for_each_packed_object()
      Remove inadvertently added outgoing/packfile.h
      Add t/helper/test-write-cache to .gitignore
      git-compat-util: make UNLEAK less error-prone
      fast-export: do not copy from modified file
      oidmap: map with OID as key

Junio C Hamano (58):
      t1408: add a test of stale packed refs covered by loose refs
      clean.c: use designated initializer
      http.c: http.sslcert and http.sslkey are both pathnames
      connect: reject ssh hostname that begins with a dash
      Git 2.7.6
      Git 2.8.6
      Git 2.9.5
      Git 2.10.4
      Git 2.11.3
      Git 2.12.4
      Git 2.13.5
      Git 2.14.1
      Start post 2.14 cycle
      perl/Git.pm: typofix in a comment
      The first batch of topics after the 2.14 cycle
      diff: retire sane_truncate_fn
      progress: simplify "delayed" progress API
      The second batch post 2.14
      t4200: give us a clean slate after "rerere gc" tests
      t4200: make "rerere gc" test more robust
      t4200: gather "rerere gc" together
      t4200: parameterize "rerere gc" custom expiry test
      rerere: represent time duration in timestamp_t internally
      rerere: allow approxidate in gc.rerereResolved/gc.rerereUnresolved
      The third batch post 2.14
      Prepare for 2.14.2
      The fourth batch post 2.14
      The fifth batch post 2.14
      The sixth batch post 2.14
      RelNotes: further fixes for 2.14.2 from the master front
      The seventh batch post 2.14
      travis: dedent a few scripts that are indented overly deeply
      subprocess: loudly die when subprocess asks for an unsupported capa=
bility
      cvsserver: move safe_pipe_capture() to the main package
      cvsserver: use safe_pipe_capture for `constant commands` as well
      gc: call fscanf() with %<len>s, not %<len>c, when reading hostname
      The eighth batch for 2.15
      Git 2.10.5
      Git 2.11.4
      Git 2.12.5
      Git 2.13.6
      Git 2.14.2
      branch: fix "copy" to never touch HEAD
      merge-strategies: avoid implying that "-s theirs" exists
      The ninth batch for 2.15
      The tenth batch for 2.15
      The eleventh batch for 2.15
      The twelfth batch for 2.15
      Git 2.15-rc0
      Prepare for -rc1
      Git 2.15-rc1
      checkout doc: clarify command line args for "checkout paths" mode
      Crawling towards -rc2
      fetch doc: src side of refspec could be full SHA-1
      Preparing for rc2 continues
      branch doc: sprinkle a few commas for readability
      Prepare for 2.14.3
      Git 2.15-rc2

Kaartic Sivaraam (15):
      hook: cleanup script
      hook: name the positional variables
      hook: add sign-off using "interpret-trailers"
      hook: add a simple first example
      commit: check for empty message before the check for untouched temp=
late
      hook: use correct logical variable
      t3200: cleanup cruft of a test
      builtin/branch: stop supporting the "--set-upstream" option
      branch: quote branch/ref names to improve readability
      help: change a message to be more precise
      commit-template: change a message to be more intuitive
      t/README: fix typo and grammatically improve a sentence
      doc: camelCase the config variables to improve readability
      branch: change the error messages to be more meaningful
      setup: update error message to be more meaningful

Kevin Daudt (3):
      stash: prevent warning about null bytes in input
      doc/for-each-ref: consistently use '=3D' to between argument names =
and values
      doc/for-each-ref: explicitly specify option names

Kevin Willford (9):
      format-patch: have progress option while generating patches
      rebase: turn on progress option by default for format-patch
      commit: skip discarding the index if there is no pre-commit hook
      perf: add test for writing the index
      read-cache: fix memory leak in do_write_index
      read-cache: avoid allocating every ondisk entry when writing
      merge-recursive: fix memory leak
      merge-recursive: remove return value from get_files_dirs
      merge-recursive: change current file dir string_lists to hashmap

Lars Schneider (13):
      t0021: keep filter log files on comparison
      t0021: make debug log file name configurable
      t0021: write "OUT <size>" only on success
      convert: put the flags field before the flag itself for consistent =
style
      convert: move multiple file filter error handling to separate funct=
ion
      convert: refactor capabilities negotiation
      convert: add "status=3Ddelayed" to filter process protocol
      convert: display progress for filtered objects that have been delay=
ed
      travis-ci: move Travis CI code into dedicated scripts
      travis-ci: skip a branch build if equal tag is present
      travis-ci: fix "skip_branch_tip_with_tag()" string comparison
      entry.c: update cache entry only for existing files
      entry.c: check if file exists after checkout

Manav Rathi (1):
      docs: improve discoverability of exclude pathspec

Martin Koegler (2):
      diff-delta: fix encoding size that would not fit in "unsigned int"
      diff-delta: do not allow delta offset truncation

Martin =C3=85gren (33):
      builtin.h: take over documentation from api-builtin.txt
      git.c: let builtins opt for handling `pager.foo` themselves
      git.c: provide setup_auto_pager()
      t7006: add tests for how git tag paginates
      tag: respect `pager.tag` in list-mode only
      tag: change default of `pager.tag` to "on"
      git.c: ignore pager.* when launching builtin as dashed external
      Doc/git-{push,send-pack}: correct --sign=3D to --signed=3D
      t5334: document that git push --signed=3D1 does not work
      config: introduce git_parse_maybe_bool_text
      config: make git_{config,parse}_maybe_bool equivalent
      treewide: deprecate git_config_maybe_bool, use git_parse_maybe_bool
      parse_decoration_style: drop unused argument `var`
      doc/interpret-trailers: fix "the this" typo
      convert: always initialize attr_action in convert_attrs
      pack-objects: take lock before accessing `remaining`
      strbuf_setlen: don't write to strbuf_slopbuf
      ThreadSanitizer: add suppressions
      Documentation/user-manual: update outdated example output
      treewide: correct several "up-to-date" to "up to date"
      pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
      config: remove git_config_maybe_bool
      refs/files-backend: add longer-scoped copy of string to list
      refs/files-backend: fix memory leak in lock_ref_for_update
      refs/files-backend: correct return value in lock_ref_for_update
      refs/files-backend: add `refname`, not "HEAD", to list
      builtin/commit: fix memory leak in `prepare_index()`
      commit: fix memory leak in `reduce_heads()`
      leak_pending: use `object_array_clear()`, not `free()`
      object_array: use `object_array_clear()`, not `free()`
      object_array: add and use `object_array_pop()`
      pack-bitmap[-write]: use `object_array_clear()`, don't leak
      builtin/: add UNLEAKs

Matthieu Moy (2):
      send-email: fix garbage removal after address
      send-email: don't use Mail::Address, even if available

Max Kirillov (2):
      describe: fix matching to actually match all patterns
      describe: teach --match to handle branches and remotes

Michael Forney (1):
      scripts: use "git foo" not "git-foo"

Michael Haggerty (77):
      add_packed_ref(): teach function to overwrite existing refs
      packed_ref_store: new struct
      packed_ref_store: move `packed_refs_path` here
      packed_ref_store: move `packed_refs_lock` member here
      clear_packed_ref_cache(): take a `packed_ref_store *` parameter
      validate_packed_ref_cache(): take a `packed_ref_store *` parameter
      get_packed_ref_cache(): take a `packed_ref_store *` parameter
      get_packed_refs(): take a `packed_ref_store *` parameter
      add_packed_ref(): take a `packed_ref_store *` parameter
      lock_packed_refs(): take a `packed_ref_store *` parameter
      commit_packed_refs(): take a `packed_ref_store *` parameter
      rollback_packed_refs(): take a `packed_ref_store *` parameter
      get_packed_ref(): take a `packed_ref_store *` parameter
      repack_without_refs(): take a `packed_ref_store *` parameter
      packed_peel_ref(): new function, extracted from `files_peel_ref()`
      packed_ref_store: support iteration
      packed_read_raw_ref(): new function, replacing `resolve_packed_ref(=
)`
      packed-backend: new module for handling packed references
      packed_ref_store: make class into a subclass of `ref_store`
      commit_packed_refs(): report errors rather than dying
      commit_packed_refs(): use a staging file separate from the lockfile
      packed_refs_lock(): function renamed from lock_packed_refs()
      packed_refs_lock(): report errors via a `struct strbuf *err`
      packed_refs_unlock(), packed_refs_is_locked(): new functions
      clear_packed_ref_cache(): don't protest if the lock is held
      commit_packed_refs(): remove call to `packed_refs_unlock()`
      repack_without_refs(): don't lock or unlock the packed refs
      t3210: add some tests of bogus packed-refs file contents
      read_packed_refs(): die if `packed-refs` contains bogus data
      packed_ref_store: handle a packed-refs file that is a symlink
      files-backend: cheapen refname_available check when locking refs
      refs: retry acquiring reference locks for 100ms
      notes: make GET_NIBBLE macro more robust
      load_subtree(): remove unnecessary conditional
      load_subtree(): reduce the scope of some local variables
      load_subtree(): fix incorrect comment
      load_subtree(): separate logic for internal vs. terminal entries
      load_subtree(): check earlier whether an internal node is a tree en=
try
      load_subtree(): only consider blobs to be potential notes
      get_oid_hex_segment(): return 0 on success
      load_subtree(): combine some common code
      get_oid_hex_segment(): don't pad the rest of `oid`
      hex_to_bytes(): simpler replacement for `get_oid_hex_segment()`
      load_subtree(): declare some variables to be `size_t`
      load_subtree(): check that `prefix_len` is in the expected range
      packed-backend: don't adjust the reference count on lock/unlock
      struct ref_transaction: add a place for backends to store data
      packed_ref_store: implement reference transactions
      packed_delete_refs(): implement method
      files_pack_refs(): use a reference transaction to write packed refs
      prune_refs(): also free the linked list
      files_initial_transaction_commit(): use a transaction for packed re=
fs
      t1404: demonstrate two problems with reference transactions
      files_ref_store: use a transaction to update packed refs
      packed-backend: rip out some now-unused code
      files_transaction_finish(): delete reflogs before references
      ref_iterator: keep track of whether the iterator output is ordered
      packed_ref_cache: add a backlink to the associated `packed_ref_stor=
e`
      die_unterminated_line(), die_invalid_line(): new functions
      read_packed_refs(): use mmap to read the `packed-refs` file
      read_packed_refs(): only check for a header at the top of the file
      read_packed_refs(): make parsing of the header line more robust
      for_each_string_list_item: avoid undefined behavior for empty list
      read_packed_refs(): read references with minimal copying
      packed_ref_cache: remember the file-wide peeling state
      mmapped_ref_iterator: add iterator over a packed-refs file
      mmapped_ref_iterator_advance(): no peeled value for broken refs
      packed-backend.c: reorder some definitions
      packed_ref_cache: keep the `packed-refs` file mmapped if possible
      read_packed_refs(): ensure that references are ordered when read
      packed_ref_iterator_begin(): iterate using `mmapped_ref_iterator`
      packed_read_raw_ref(): read the reference from the mmapped buffer
      ref_store: implement `refs_peel_ref()` generically
      packed_ref_store: get rid of the `ref_cache` entirely
      ref_cache: remove support for storing peeled values
      mmapped_ref_iterator: inline into `packed_ref_iterator`
      packed-backend.c: rename a bunch of things and update comments

Michael J Gruber (11):
      Documentation: use proper wording for ref format strings
      Documentation/git-for-each-ref: clarify peeling of tags for --forma=
t
      Documentation/git-merge: explain --continue
      merge: clarify call chain
      merge: split write_merge_state in two
      merge: save merge state earlier
      name-rev: change ULONG_MAX to TIME_MAX
      t7004: move limited stack prereq to test-lib
      t6120: test name-rev --all and --stdin
      t6120: clean up state after breaking repo
      t6120: test describe and name-rev with deep repos

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (17):
      branch: fix branch renaming not updating HEADs correctly
      revision.h: new flag in struct rev_info wrt. worktree-related refs
      refs.c: use is_dir_sep() in resolve_gitlink_ref()
      revision.c: refactor add_index_objects_to_pending()
      revision.c: --indexed-objects add objects from all worktrees
      refs.c: refactor get_submodule_ref_store(), share common free block
      refs: move submodule slash stripping code to get_submodule_ref_stor=
e
      refs: add refs_head_ref()
      revision.c: use refs_for_each*() instead of for_each_*_submodule()
      refs.c: move for_each_remote_ref_submodule() to submodule.c
      refs: remove dead for_each_*_submodule()
      revision.c: --all adds HEAD from all worktrees
      files-backend: make reflog iterator go through per-worktree reflog
      revision.c: --reflog add HEAD reflog from all worktrees
      rev-list: expose and document --single-worktree
      refs.c: remove fallback-to-main-store code get_submodule_ref_store(=
)
      refs.c: reindent get_submodule_ref_store()

Nicolas Morey-Chaisemartin (7):
      stash: clean untracked files before reset
      pull: fix cli and config option parsing order
      pull: honor submodule.recurse config option
      imap-send: return with error if curl failed
      imap-send: add wrapper to get server credentials if needed
      imap_send: setup_curl: retreive credentials if not set in config fi=
le
      imap-send: use curl by default when possible

Paolo Bonzini (4):
      trailers: export action enums and corresponding lookup functions
      trailers: introduce struct new_trailer_item
      interpret-trailers: add options for actions
      interpret-trailers: fix documentation typo

Patryk Obara (10):
      sha1_file: fix definition of null_sha1
      commit: replace the raw buffer with strbuf in read_graft_line
      commit: allocate array using object_id size
      commit: rewrite read_graft_line
      builtin/hash-object: convert to struct object_id
      read-cache: convert to struct object_id
      sha1_file: convert index_path to struct object_id
      sha1_file: convert index_fd to struct object_id
      sha1_file: convert hash_sha1_file_literally to struct object_id
      sha1_file: convert index_stream to struct object_id

Philip Oakley (4):
      git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
      git gui: cope with duplicates in _get_recentrepo
      git gui: de-dup selected repo from recentrepo history
      git gui: allow for a long recentrepo list

Phillip Wood (7):
      am: remember --rerere-autoupdate setting
      rebase: honor --rerere-autoupdate
      rebase -i: honor --rerere-autoupdate
      t3504: use test_commit
      cherry-pick/revert: remember --rerere-autoupdate
      cherry-pick/revert: reject --rerere-autoupdate when continuing
      am: fix signoff when other trailers are present

Ralf Thielow (2):
      sequencer.c: fix and unify error messages in rearrange_squash()
      sequencer.c: unify an error message

Raman Gupta (1):
      contrib/rerere-train: optionally overwrite existing resolutions

Ramsay Jones (9):
      credential-cache: interpret an ECONNRESET as an EOF
      builtin/add: add detail to a 'cannot chmod' error message
      test-lib: don't use ulimit in test prerequisites on cygwin
      test-lib: use more compact expression in PIPE prerequisite
      t9010-*.sh: skip all tests if the PIPE prereq is missing
      git-compat-util.h: xsize_t() - avoid -Wsign-compare warnings
      commit-slab.h: avoid -Wsign-compare warnings
      cache.h: hex2chr() - avoid -Wsign-compare warnings
      ALLOC_GROW: avoid -Wsign-compare warnings

Randall S. Becker (1):
      poll.c: always set revents, even if to zero

Ren=C3=A9 Scharfe (81):
      tree-diff: don't access hash of NULL object_id pointer
      notes: don't access hash of NULL object_id pointer
      receive-pack: don't access hash of NULL object_id pointer
      bswap: convert to unsigned before shifting in get_be32
      bswap: convert get_be16, get_be32 and put_be32 to inline functions
      add MOVE_ARRAY
      use MOVE_ARRAY
      apply: use COPY_ARRAY and MOVE_ARRAY in update_image()
      ls-files: don't try to prune an empty index
      dir: support platforms that require aligned reads
      pack-objects: remove unnecessary NULL check
      t0001: skip test with restrictive permissions if getpwd(3) respects=
 them
      test-path-utils: handle const parameter of basename and dirname
      t3700: fix broken test under !POSIXPERM
      t4062: use less than 256 repetitions in regex
      sha1_file: avoid comparison if no packed hash matches the first byt=
e
      apply: remove prefix_length member from apply_state
      merge: use skip_prefix()
      win32: plug memory leak on realloc() failure in syslog()
      strbuf: clear errno before calling getdelim(3)
      fsck: free buffers on error in fsck_obj()
      sha1_file: release delta_stack on error in unpack_entry()
      tree-walk: convert fill_tree_descriptor() to object_id
      t1002: stop using sum(1)
      t5001: add tests for export-ignore attributes and exclude pathspecs
      archive: factor out helper functions for handling attributes
      archive: don't queue excluded directories
      commit: remove unused inline function single_parent()
      apply: check date of potential epoch timestamps first
      apply: remove epoch date from regex
      am: release strbufs after use in detect_patch_format()
      am: release strbuf on error return in hg_patch_to_mail()
      am: release strbuf after use in safe_to_abort()
      check-ref-format: release strbuf after use in check_ref_format_bran=
ch()
      clean: release strbuf after use in remove_dirs()
      clone: release strbuf after use in remove_junk()
      commit: release strbuf on error return in commit_tree_extended()
      connect: release strbuf on error return in git_connect()
      convert: release strbuf on error return in filter_buffer_or_fd()
      diff: release strbuf after use in diff_summary()
      diff: release strbuf after use in show_rename_copy()
      diff: release strbuf after use in show_stats()
      help: release strbuf on error return in exec_man_konqueror()
      help: release strbuf on error return in exec_man_man()
      help: release strbuf on error return in exec_woman_emacs()
      mailinfo: release strbuf after use in handle_from()
      mailinfo: release strbuf on error return in handle_boundary()
      merge: release strbuf after use in save_state()
      merge: release strbuf after use in write_merge_heads()
      notes: release strbuf after use in notes_copy_from_stdin()
      refs: release strbuf on error return in write_pseudoref()
      remote: release strbuf after use in read_remote_branches()
      remote: release strbuf after use in migrate_file()
      remote: release strbuf after use in set_url()
      send-pack: release strbuf on error return in send_pack()
      sha1_file: release strbuf on error return in index_path()
      shortlog: release strbuf after use in insert_one_record()
      sequencer: release strbuf after use in save_head()
      transport-helper: release strbuf after use in process_connect_servi=
ce()
      userdiff: release strbuf after use in userdiff_get_textconv()
      utf8: release strbuf on error return in strbuf_utf8_replace()
      vcs-svn: release strbuf after use in end_revision()
      wt-status: release strbuf after use in read_rebase_todolist()
      wt-status: release strbuf after use in wt_longstatus_print_tracking=
()
      archive: don't add empty directories to archives
      refs: make sha1 output parameter of refs_resolve_ref_unsafe() optio=
nal
      refs: pass NULL to refs_resolve_ref_unsafe() if hash is not needed
      refs: pass NULL to resolve_ref_unsafe() if hash is not needed
      mailinfo: don't decode invalid =3DXY quoted-printable sequences
      refs: pass NULL to refs_resolve_refdup() if hash is not needed
      refs: pass NULL to resolve_refdup() if hash is not needed
      coccinelle: remove parentheses that become unnecessary
      path: use strbuf_add_real_path()
      use strbuf_addstr() for adding strings to strbufs
      graph: use strbuf_addchars() to add spaces
      tag: avoid NULL pointer arithmetic
      repository: use FREE_AND_NULL
      run-command: use ALLOC_ARRAY
      test-stringlist: avoid buffer underrun when sorting nothing
      fsck: handle NULL return of lookup_blob() and lookup_tree()
      .mailmap: normalize name for Ren=C3=A9 Scharfe

Ross Kabus (1):
      commit-tree: do not complete line in -F input

Sahil Dua (2):
      config: create a function to format section headers
      branch: add a --copy (-c) option to go with --move (-m)

Santiago Torres (1):
      t: lib-gpg: flush gpg agent on startup

Stefan Beller (51):
      diff.c: readability fix
      diff.c: move line ending check into emit_hunk_header
      diff.c: factor out diff_flush_patch_all_file_pairs
      diff.c: introduce emit_diff_symbol
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
      diff.c: migrate emit_line_checked to use emit_diff_symbol
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
      diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
      diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
      submodule.c: migrate diff output to use emit_diff_symbol
      diff.c: convert emit_binary_diff_body to use emit_diff_symbol
      diff.c: convert show_stats to use emit_diff_symbol
      diff.c: convert word diffing to use emit_diff_symbol
      diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
      diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
      diff.c: buffer all output if asked to
      diff.c: color moved lines differently
      diff.c: color moved lines differently, plain mode
      diff.c: add dimming to moved line detection
      diff: document the new --color-moved setting
      attr.c: drop hashmap_cmp_fn cast
      builtin/difftool.c: drop hashmap_cmp_fn cast
      builtin/describe: drop hashmap_cmp_fn cast
      config.c: drop hashmap_cmp_fn cast
      convert/sub-process: drop cast to hashmap_cmp_fn
      patch-ids.c: drop hashmap_cmp_fn cast
      remote.c: drop hashmap_cmp_fn cast
      submodule-config.c: drop hashmap_cmp_fn cast
      name-hash.c: drop hashmap_cmp_fn cast
      t/helper/test-hashmap: use custom data instead of duplicate cmp fun=
ctions
      commit: convert lookup_commit_graft to struct object_id
      tag: convert gpg_verify_tag to use struct object_id
      t8008: rely on rev-parse'd HEAD instead of sha1 value
      t1200: remove t1200-tutorial.sh
      sha1_file: make read_info_alternates static
      submodule.sh: remove unused variable
      builtin/merge: honor commit-msg hook for merges
      push, fetch: error out for submodule entries not pointing to commit=
s
      replace-objects: evaluate replacement refs without using the object=
 store
      Documentation/githooks: mention merge in commit-msg hook
      Documentation/config: clarify the meaning of submodule.<name>.updat=
e
      t7406: submodule.<name>.update command must not be run from .gitmod=
ules
      diff: correct newline in summary for renamed files
      submodule: correct error message for missing commits
      branch: reset instead of release a strbuf
      tests: fix diff order arguments in test_cmp

Stephan Beyer (1):
      clang-format: add a comment about the meaning/status of the

Takashi Iwai (2):
      sha1dc: build git plumbing code more explicitly
      sha1dc: allow building with the external sha1dc library

Taylor Blau (8):
      pretty.c: delimit "%(trailers)" arguments with ","
      t4205: unfold across multiple lines
      doc: 'trailers' is the preferred way to format trailers
      doc: use "`<literal>`"-style quoting for literal strings
      t6300: refactor %(trailers) tests
      ref-filter.c: use trailer_opts to format trailers
      ref-filter.c: parse trailers arguments with %(contents) atom
      ref-filter.c: pass empty-string as NULL to atom parsers

Thomas Braun (1):
      completion: add --broken and --dirty to describe

Thomas Gummerer (3):
      read-cache: fix index corruption with index v4
      refs: strip out not allowed flags from ref_transaction_update
      http-push: fix construction of hex value from path

Todd Zullinger (1):
      api-argv-array.txt: remove broken link to string-list API

Tom G. Christensen (2):
      http: fix handling of missing CURLPROTO_*
      http: use a feature check to enable GSSAPI delegation control

Torsten B=C3=B6gershausen (3):
      convert: add SAFE_CRLF_KEEP_CRLF
      apply: file commited with CRLF should roundtrip diff and apply
      test-lint: echo -e (or -E) is not portable

Urs Thuermann (1):
      git svn fetch: Create correct commit timestamp when using --localti=
me

W. Trevor King (1):
      Documentation/merge-options.txt: describe -S/--gpg-sign for 'pull'

William Duclot (1):
      rebase: make resolve message clearer for inexperienced users

brian m. carlson (14):
      builtin/fsck: convert remaining caller of get_sha1 to object_id
      builtin/merge-tree: convert remaining caller of get_sha1 to object_=
id
      submodule: convert submodule config lookup to use object_id
      remote: convert struct push_cas to struct object_id
      sequencer: convert to struct object_id
      builtin/update_ref: convert to struct object_id
      bisect: convert bisect_checkout to struct object_id
      builtin/unpack-file: convert to struct object_id
      Convert remaining callers of get_sha1 to get_oid.
      sha1_name: convert get_sha1* to get_oid*
      sha1_name: convert GET_SHA1* flags to GET_OID*
      sha1_name: convert uses of 40 to GIT_SHA1_HEXSZ
      vcs-svn: remove unused prototypes
      vcs-svn: rename repo functions to "svn_repo"

joernchen (1):
      cvsserver: use safe_pipe_capture instead of backticks

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
      branch: add test for -m renaming multiple config sections
      tests: don't give unportable ">" to "test" built-in, use -gt

=C3=98ystein Walle (1):
      rev-parse: rev-parse: add --is-shallow-repository

=C5=81ukasz Gryglicki (1):
      merge: add a --signoff flag

