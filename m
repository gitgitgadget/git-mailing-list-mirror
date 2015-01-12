From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.0-rc0
Date: Mon, 12 Jan 2015 15:57:17 -0800
Message-ID: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 13 00:57:46 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YAorg-0008Tg-N8
	for glk-linux-kernel-3@plane.gmane.org; Tue, 13 Jan 2015 00:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbbALX5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Jan 2015 18:57:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751223AbbALX5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2015 18:57:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BE232F628;
	Mon, 12 Jan 2015 18:57:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=D50jBVL9FLExVZI4oXywwzkOm
	PI=; b=oYFF7qbzsAbdeTvvrYwLSC2a6N8JDN9iI3ybMjT02Jvt0NUfL2KC1e7jI
	ZWmGY0lIxMOQFZ5SgAcPL36imyOwjbcUEa1rkGwC/Gh2lCPp1Cdpjdqy15Y76A/K
	wNHD/84H/iez0TRGta+UB3itbqR01/BvERbX+GP0m3c4qFI7So=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=vHgBn5NDi8eZ2PjBv7V
	87mbFDFC7m2ioc2EgkonoLFG1nMmCnwpJsEdsg2ENxvbJ6prZNtcGxnLKIC6tLTB
	wCfCcsXjSxeYtRCs9UhDmrjxE5OvHejLKQ6ENAdX6VgfXxtBBA6t51eaYSh0x0KG
	hmz7WKP54+Rfn5kaEgET32p4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22D2D2F627;
	Mon, 12 Jan 2015 18:57:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58DF02F626;
	Mon, 12 Jan 2015 18:57:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE336652-9AB6-11E4-9319-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262305>

An early preview release Git v2.3.0-rc0 is now available for
testing at the usual places.

With the slowness from the end-of-year holiday, this cycle turned
out to be a relatively lean one as I predicted (just 200 changes
since 2.2, as opposed to ~500 changes in an normal cycle), but that
is fine.  From time to time it is OK to have a release that does not
add many new things but just fixes niggles here and there.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.3.0-rc0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.3 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Updates since v2.2
------------------

Ports

 * Recent gcc toolchain on Cygwin started throwing compilation warning,
   which has been squelched.


UI, Workflows & Features

 * It was cumbersome to use "GIT_SSH" mechanism when the user wanted
   to pass an extra set of arguments to the underlying ssh.  A new
   environment variable GIT_SSH_COMMAND can be used for this.

 * A request to store an empty note via "git notes" meant to remove
   note from the object but with --allow-empty we will store a
   (surprise!)  note that is empty.

 * "git interpret-trailers" learned to properly handle the
   "Conflicts:" block at the end.

 * "git am" learned "--message-id" option to copy the message ID of
   the incoming e-mail to the log message of resulting commit.

 * "git clone --reference=3D<over there>" learned the "--dissociate"
   option to go with it; it borrows objects from the reference object
   store while cloning only to reduce network traffic and then
   dissociates the resulting clone from the reference by performing
   local copies of borrowed objects.

 * "git send-email" learned "--transfer-encoding" option to force a
   non-fault Content-Transfer-Encoding header (e.g. base64).

 * "git send-email" normally identifies itself via X-Mailer: header in
   the message it sends out.  A new command line flag --no-xmailer
   allows the user to squelch the header.

 * "git push" into a repository with a working tree normally refuses
   to modify the branch that is checked out.  The command learned to
   optionally do an equivalent of "git reset --hard" only when there
   is no change to the working tree and the index instead, which would
   be useful to "deploy" by pushing into a repository.

 * "git new-workdir" (in contrib/) can be used to populate an empty
   and existing directory now.

 * Credential helpers are asked in turn until one of them give
   positive response, which is cumbersome to turn off when you need to
   run Git in an automated setting.  The credential helper interface
   learned to allow a helper to say "stop, don't ask other helpers."
   Also GIT_TERMINAL_PROMPT environment can be set to false to disable
   our built-in prompt mechanism for passwords.

 * "git branch -d" (delete) and "git branch -m" (move) learned to
   honor "-f" (force) flag; unlike many other subcommands, the way to
   force these have been with separate "-D/-M" options, which was
   inconsistent.

 * "diff-highlight" filter (in contrib/) allows its color output to be
   customized via configuration variables.

 * "git imap-send" learned to take "-v" (verbose) and "-q" (quiet)
   command line options.

 * "git imap-send" now can be built to use cURL library to talk to
   IMAP servers (if the library is recent enough, of course).
   This allows you to use authenticate method other than CRAM-MD5,
   among other things.


Performance, Internal Implementation, Development Support etc.

 * Earlier we made "rev-list --object-edge" more aggressively list the
   objects at the edge commits, in order to reduce number of objects=E3=
=80=80
   fetched into a shallow repository, but the change affected cases
   other than "fetching into a shallow repository" and made it
   unusably slow (e.g. fetching into a normal repository should not
   have to suffer the overhead from extra processing).  Limit it to a
   more specific case by introducing --objects-edge-aggressive, a new
   option to rev-list.

 * Squelched useless compiler warnings on Mac OS X regarding the
   crypto API.

 * The procedure to generate unicode table has been simplified.

 * Some filesystems assign filemodes in a strange way, fooling then
   automatic "filemode trustability" check done during a new
   repository creation.  The initialization codepath has been hardened
   against this issue.

 * The codepath in "git remote update --prune" to drop many refs has
   been optimized.

 * The API into get_merge_bases*() family of functions was easy to
   misuse, which has been corrected to make it harder to do so.

 * Long overdue departure from the assumption that S_IFMT is shared by
   everybody made in 2005, which was necessary to port to z/OS.

 * "git push" and "git fetch" did not communicate an overlong refname
   correctly.  Now it uses 64kB sideband to accommodate longer ones.

 * Recent GPG changes the keyring format and drops support for RFC1991
   formatted signatures, breaking our existing tests.

 * "git-prompt" (in contrib/) used a variable from the global scope,
   possibly contaminating end-user's namespace.


Also contains various documentation updates and code clean-ups.


=46ixes since v2.2
----------------

Unless otherwise noted, all the fixes since v2.2 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * The logic in "git bisect bad HEAD" etc. to avoid forcing the test
   of the common ancestor of bad and good commits was broken.
   (merge 07913d5 cc/bisect-rev-parsing later to maint).

 * "git checkout-index --temp=3D$target $path" did not work correctly
   for paths outside the current subdirectory in the project.
   (merge 74c4de5 es/checkout-index-temp later to maint).

 * The report from "git checkout" on a branch that builds on another
   local branch by setting its branch.*.merge to branch name (not a
   full refname) incorrectly said that the upstream is gone.
   (merge 05e7368 jc/checkout-local-track-report later to maint).

 * With The git-prompt support (in contrib/), using the exit status of
   the last command in the prompt, e.g.  PS1=3D'$(__git_ps1) $? ', did
   not work well, because the helper function stomped on the exit
   status.
   (merge eb443e3 tf/prompt-preserve-exit-status later to maint).


 * Recent update to "git commit" broke amending an existing commit
   with bogus author/committer lines without a valid e-mail address.
   (merge c83a509 jk/commit-date-approxidate later to maint).

 * The lockfile API used to get confused which file to clean up when
   the process moved the $cwd after creating a lockfile.
   (merge fa137f6 nd/lockfile-absolute later to maint).

 * Traditionally we tried to avoid interpreting date strings given by
   the user as future dates, e.g. GIT_COMMITTER_DATE=3D2014-12-10 when
   used early November 2014 was taken as "October 12, 2014" because it
   is likely that a date in the future, December 10, is a mistake.
   This heuristics has been loosened to allow people to express future
   dates (most notably, --until=3D<date> may want to be far in the
   future) and we no longer tiebreak by future-ness of the date when

    (1) ISO-like format is used, and
    (2) the string can make sense interpreted as both y-m-d and y-d-m.

   Git may still have to use the heuristics to tiebreak between dd/mm/y=
y
   and mm/dd/yy, though.
   (merge d372395 jk/approxidate-avoid-y-d-m-over-future-dates later to=
 maint).

 * Git did not correctly read an overlong refname from a packed refs
   file.
   (merge ea41783 jk/read-packed-refs-without-path-max later to maint).

 * "git apply" was described in the documentation to take --ignore-date
   option, which it does not.
   (merge 0cef4e7 rw/apply-does-not-take-ignore-date later to maint).

 * "git add -i" did not notice when the interactive command input
   stream went away and kept asking the same question.
   (merge a8bec7a jk/add-i-read-error later to maint).

 * "git send-email" did not handle RFC 2047 encoded headers quite
   right.
   (merge ab47e2a rd/send-email-2047-fix later to maint).

 * New tag object format validation added in 2.2 showed garbage after
   a tagname it reported in its error message.
   (merge a1e920a js/fsck-tag-validation later to maint).

 * The code that reads the reflog from the newer to the older entries
   did not handle an entry that crosses a boundary of block it uses to
   read them correctly.
   (merge 69216bf jk/for-each-reflog-ent-reverse later to maint).

 * "git diff -B -M" after making a new copy B out of an existing file
   A and then editing A extensively ought to report that B was created
   by copying A and A was modified, which is what "git diff -C"
   reports, but it instead said A was renamed to B and A was edited
   heavily in place.  This was not just incoherent but also failed to
   apply with "git apply".  The report has been corrected to match what
   "git diff -C" produces for this case.
   (merge 6936b58 jc/diff-b-m later to maint).

 * In files we pre-populate for the user to edit with commented hints,
   a line of hint that is indented with a tab used to show as '#' (or
   any comment char), ' ' (space), and then the hint text that began
   with the tab, which some editors flag as an indentation error (tab
   following space).  We now omit the space after the comment char in
   such a case.
   (merge d55aeb7 jc/strbuf-add-lines-avoid-sp-ht-sequence later to mai=
nt).

 * "git ls-tree" does not support path selection based on negative
   pathspecs, but did not error out when negative pathspecs are given.
   (merge f1f6224 nd/ls-tree-pathspec later to maint).

 * The function sometimes returned a non-freeable memory and some
   other times returned a piece of memory that must be freed, leading
   to inevitable leaks.
   (merge 59362e5 jc/exec-cmd-system-path-leak-fix later to maint).

 * The code to abbreviate an object name to its short unique prefix
   has been optimized when no abbreviation was requested.
   (merge 61e704e mh/find-uniq-abbrev later to maint).

 * "git add --ignore-errors ..." did not ignore an error to
   give a file that did not exist.
   (merge 1d31e5a mg/add-ignore-errors later to maint).

 * "git checkout $treeish $path", when $path in the index and the
   working tree already matched what is in $treeish at the $path,
   still overwrote the $path unnecessarily.
   (merge c5326bd jk/checkout-from-tree later to maint).

 * "git config --get-color" did not parse its command line arguments
   carefully.
   (merge cb35722 jk/colors-fix later to maint).

 * open() emulated on Windows platforms did not give EISDIR upon
   an attempt to open a directory for writing.
   (merge ba6fad0 js/windows-open-eisdir-error later to maint).

 * A few code paths used abs() when they should have used labs() on
   long integers.
   (merge 83915ba rs/maint-config-use-labs later to maint).
   (merge 31a8aa1 rs/receive-pack-use-labs later to maint).

 * "gitweb" used to depend on a behaviour recent CGI.pm deprecated.
   (merge 13dbf46 jk/gitweb-with-newer-cgi-multi-param later to maint).

 * "git init" (hence "git clone") initialized the per-repository
   configuration file .git/config with x-bit by mistake.
   (merge 1f32ecf mh/config-flip-xbit-back-after-checking later to main=
t).

 * Git 2.0 was supposed to make the "simple" mode for the default of
   "git push", but it didn't.
   (merge 00a6fa0 jk/push-simple later to maint).

 * "Everyday" document had a broken link.
   (merge 366c8d4 po/everyday-doc later to maint).

 * A few test fixes.
   (merge 880ef58 jk/no-perl-tests later to maint).

 * The build procedure did not bother fixing perl and python scripts
   when NO_PERL and NO_PYTHON build-time configuration changed.
   (merge ca2051d jk/rebuild-perl-scripts-with-no-perl-seting-change la=
ter to maint).

----------------------------------------------------------------

Changes since v2.2.0 are as follows:

Alexander Kuleshov (1):
      clean: typofix

Alfred Perlstein (1):
      git-svn: support for git-svn propset

Beat Bolli (5):
      update_unicode.sh: simplify output capture
      update_unicode.sh: set UNICODE_DIR only once
      update_unicode.sh: shorten uniset invocation path
      update_unicode.sh: make the output structure visible
      update_unicode.sh: delete the command group

Ben Walton (1):
      t0090: tweak awk statement for Solaris /usr/xpg4/bin/awk

Bernhard Reiter (2):
      imap-send: use parse options API to determine verbosity
      git-imap-send: use libcurl for implementation

Christian Couder (5):
      commit: make ignore_non_trailer() non static
      trailer: reuse ignore_non_trailer() to ignore conflict lines
      trailer: add test with an old style conflict block
      bisect: parse revs before passing them to check_expected_revs()
      bisect: add test to check that revs are properly parsed

Christian Hesse (4):
      tests: create gpg homedir on the fly
      tests: skip RFC1991 tests for gnupg 2.1
      tests: replace binary GPG keyrings with ASCII-armored keys
      tests: make comment on GPG keyring match the code

Dan Wyand (1):
      git-sh-setup.sh: use dashdash with basename call

David Aguilar (4):
      mergetool--lib: remove use of $status global
      difftool--helper: add explicit exit statement
      mergetool: simplify conditionals
      mergetools: stop setting $status in merge_cmd()

David Michael (1):
      compat: convert modes to use portable file type values

Eric Sunshine (7):
      git-compat-util: suppress unavoidable Apple-specific deprecation =
warnings
      t2004: modernize style
      t2004: drop unnecessary write-tree/read-tree
      t2004: standardize file naming in symlink test
      t2004: demonstrate broken relative path printing
      checkout-index: fix --temp relative path mangling
      SubmittingPatches: explain rationale for using --notes with forma=
t-patch

Hartmut Henkel (1):
      l10n: de.po: fix typos

Jeff King (38):
      pass TIME_DATE_NOW to approxidate future-check
      checkout $tree: do not throw away unchanged index entries
      approxidate: allow ISO-like dates far in the future
      Makefile: have perl scripts depend on NO_PERL setting
      t0090: mark add-interactive test with PERL prerequisite
      t960[34]: mark cvsimport tests as requiring perl
      gitweb: hack around CGI's list-context param() handling
      docs: describe ANSI 256-color mode
      config: fix parsing of "git config --get-color some.key -1"
      t4026: test "normal" color
      parse_color: refactor color storage
      parse_color: support 24-bit RGB values
      parse_color: recognize "no$foo" to clear the $foo attribute
      diff-highlight: allow configurable colors
      push: truly use "simple" as default, not "upstream"
      credential: let helpers tell us to quit
      prompt: respect GIT_TERMINAL_PROMPT to disable terminal prompts
      for_each_reflog_ent_reverse: fix newlines on block boundaries
      for_each_reflog_ent_reverse: turn leftover check into assertion
      fsck: properly bound "invalid tag name" error message
      parse_color: drop COLOR_BACKGROUND macro
      read_packed_refs: use a strbuf for reading lines
      read_packed_refs: pass strbuf to parse_ref_line
      read_packed_refs: use skip_prefix instead of static array
      pkt-line: allow writing of LARGE_PACKET_MAX buffers
      t: support clang/gcc AddressSanitizer
      commit: loosen ident checks when generating template
      commit: always populate GIT_AUTHOR_* variables
      add--interactive: leave main loop on read error
      unpack-trees: propagate errors adding entries to the index
      read-tree: add tests for confusing paths like ".." and ".git"
      verify_dotfile(): reject .git case-insensitively
      t1450: refactor ".", "..", and ".git" fsck tests
      fsck: notice .git case-insensitively
      utf8: add is_hfs_dotgit() helper
      read-cache: optionally disallow HFS+ .git variants
      fsck: complain about HFS+ ".git" aliases in trees
      is_hfs_dotgit: loosen over-eager match of \u{..47}

Jim Hill (1):
      pre-push.sample: remove unnecessary and misleading IFS=3D' '

Johan Herland (9):
      builtin/notes: fix premature failure when trying to add the empty=
 blob
      t3301: verify that 'git notes' removes empty notes by default
      builtin/notes: improve naming
      builtin/notes: refactor note file path into struct note_data
      builtin/notes: simplify early exit code in add()
      builtin/notes: split create_note() to clarify add vs. remove logi=
c
      builtin/notes: add --allow-empty, to allow storing empty notes
      notes: empty notes should be shown by 'git log'
      t3301: modernize style

Johannes Schindelin (5):
      receive-pack: add another option for receive.denyCurrentBranch
      test-hashmap: squelch gcc compiler warning
      path: add is_ntfs_dotgit() helper
      read-cache: optionally disallow NTFS .git variants
      fsck: complain about NTFS ".git" aliases in trees

Johannes Sixt (2):
      Windows: correct detection of EISDIR in mingw_open()
      t5000 on Windows: do not mistake "sh.exe" as "sh"

Jonathan Nieder (2):
      Makefile: simplify by using SCRIPT_{PERL,SH}_GEN macros
      Makefile: have python scripts depend on NO_PYTHON setting

Junio C Hamano (38):
      checkout: report upstream correctly even with loosely defined bra=
nch.*.merge
      clone: --dissociate option to mark that reference is only tempora=
ry
      diff -B -M: fix output for "copy and then rewrite" case
      builtin/merge.c: drop a parameter that is never used
      merge & sequencer: unify codepaths that write "Conflicts:" hint
      strbuf_add_commented_lines(): avoid SP-HT sequence in commented l=
ines
      builtin/commit.c: extract ignore_non_trailer() helper function
      merge & sequencer: turn "Conflicts:" hint into a comment
      bisect: clean flags after checking merge bases
      get_merge_bases(): always clean-up object flags
      unpack_trees: plug leakage of o->result
      mergetool--lib: remove no-op assignment to $status from setup_use=
r_tool
      SubmittingPatches: refer to t/README for tests
      t/README: justify why "! grep foo" is sufficient
      t9001: style modernisation phase #1
      t9001: style modernisation phase #2
      t9001: style modernisation phase #3
      t9001: style modernisation phase #4
      t9001: style modernisation phase #5
      system_path(): always return free'able memory to the caller
      t5516: more tests for receive.denyCurrentBranch=3DupdateInstead
      run-command.c: retire unused run_hook_with_custom_index()
      t3102: document that ls-tree does not yet support negated pathspe=
c
      t3102: style modernization
      Start post 2.2 cycle
      First batch for 2.3 cycle
      tests: squelch noise from GPG machinery set-up
      Second batch for 2.3 cycle
      Git 1.8.5.6
      Git 1.9.5
      Git 2.0.5
      Git 2.1.4
      Git 2.2.1
      Prepare for 2.2.2
      Third batch for 2.3 cycle
      Fourth batch for 2.3 cycle
      Git 2.2.2
      Git 2.3.0-rc0

Justin Guenther (1):
      git-prompt.sh: make $f local to __git_eread()

Karsten Blees (1):
      pack-bitmap: do not use gcc packed attribute

Luis Henriques (2):
      send-email: add --[no-]xmailer option
      test/send-email: --[no-]xmailer tests

Michael Haggerty (11):
      cmd_config(): make a copy of path obtained from git_path()
      create_default_files(): don't set u+x bit on $GIT_DIR/config
      prune_remote(): exit early if there are no stale references
      prune_remote(): initialize both delete_refs lists in a single loo=
p
      prune_remote(): sort delete_refs_list references en masse
      repack_without_refs(): make the refnames argument a string_list
      prune_remote(): rename local variable
      prune_remote(): iterate using for_each_string_list_item()
      sort_string_list(): rename to string_list_sort()
      t1400: add some more tests of "update-ref --stdin"'s verify comma=
nd
      update-ref: fix "verify" command with missing <oldvalue>

Michael J Gruber (5):
      add: ignore only ignored files
      t3200-branch: test -M
      check-ignore: clarify treatment of tracked files
      gitignore.txt: do not suggest assume-unchanged
      branch: allow -f with -m and -d

Mike Hommey (1):
      sha1_name: avoid unnecessary sha1 lookup in find_unique_abbrev

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
      lockfile.c: store absolute path
      tree.c: update read_tree_recursive callback to pass strbuf as bas=
e
      ls-tree: remove path filtering logic in show_tree
      ls-tree: disable negative pathspec because it's not supported
      index-pack: terminate object buffers with NUL
      index-format.txt: add a missing closing quote

Onno Kortmann (1):
      Show number of TODO items for interactive rebase

Paolo Bonzini (4):
      git-send-email: delay creation of MIME headers
      git-send-email: add --transfer-encoding option
      git-mailinfo: add --message-id
      git-am: add --message-id/--no-message-id

Paul Smith (1):
      git-new-workdir: don't fail if the target directory is empty

Peter van der Does (1):
      Update documentation occurrences of filename .sh

Philip Oakley (1):
      doc: make clear --assume-unchanged's user contract

Ralf Thielow (3):
      builtin/push.c: fix description of --recurse-submodules option
      for-each-ref: correct spelling of Tcl in option description
      completion: add git-tag options

Ramsay Allan Jones (2):
      git-compat-util.h: don't define _XOPEN_SOURCE on cygwin
      t0050-*.sh: mark the rename (case change) test as passing

Ren=C3=A9 Scharfe (8):
      use args member of struct child_process
      use labs() for variables of type long instead of abs()
      use labs() for variables of type long instead of abs()
      use strbuf_complete_line() for adding a newline if needed
      commit-tree: simplify parsing of option -S using skip_prefix()
      merge: release strbuf after use in suggest_conflicts()
      transport: simplify duplicating a substring in transport_get() us=
ing xmemdupz()
      refs: plug strbuf leak in lock_ref_sha1_basic()

Ronald Wampler (1):
      git-am.txt: --ignore-date flag is not passed to git-apply

Ronnie Sahlberg (1):
      lock_ref_sha1_basic: do not die on locking errors

Slavomir Vlcek (3):
      builtin: move builtin retrieval to get_builtin()
      apply: fix typo in an error message
      Documentation/git-stripspace: add synopsis for --comment-lines

Stefan Beller (5):
      string_list: document string_list_(insert,lookup)
      mailmap: use higher level string list functions
      string_list: remove string_list_insert_at_index() from its API
      t5400: remove dead code
      Documentation/SubmittingPatches: unify whitespace/tabs for the DC=
O

Thomas Quinot (1):
      git_connect: set ssh shell command in GIT_SSH_COMMAND

Tony Finch (1):
      git-prompt: preserve value of $? inside shell prompt

Torsten B=C3=B6gershausen (2):
      init-db: improve the filemode trustability check
      t0027: check the eol conversion warnings

brian m. carlson (4):
      Documentation: change "gitlink" typo in git-push
      Documentation: add missing article in rev-list-options.txt
      rev-list: add an option to mark fewer edges as uninteresting
      pack-objects: use --objects-edge-aggressive for shallow repos

=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=
=D0=BE (2):
      send-email: align RFC 2047 decoding more closely with the spec
      send-email: handle adjacent RFC 2047-encoded words properly
