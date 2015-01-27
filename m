From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.3.0-rc2
Date: Tue, 27 Jan 2015 15:35:02 -0800
Message-ID: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 28 00:35:20 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YGFfC-00056X-9g
	for glk-linux-kernel-3@plane.gmane.org; Wed, 28 Jan 2015 00:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759263AbbA0XfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 27 Jan 2015 18:35:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754454AbbA0XfF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2015 18:35:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF4E9320ED;
	Tue, 27 Jan 2015 18:35:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=9l1x2IqzLipJu62PXPfFswQvk
	08=; b=qwbjGwuizfeIUwuBzm1V5WmbEjBdNA8a2B9CC2x3pa/XBaikbjIOIBrni
	wuts/Dz6Q09KrbS+E7e8JRwHkoXKcgvbsmc6MFV7CbzWYGeh3xHAwXLL7zi/Chxa
	O6lDmS3Ow48Tf6bDngGfXx69QGYn9OrFAwDsNRfG+oVBKA6aMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ps7xbeX2+KAmOGo/MxX
	odacwsd9cxcp0zvlzpQ5KwHfkFh57T6yGquFRvv3kvqOVOkh5znb0/JzKAMJdHYA
	7KsCVR+UJTUOIpeaIit/kh0BI/BN5mfX6Xtcm4Kj4Kqv2HxslHZPxn/uQkQpp6Jj
	PQUu16Dj1kvGodGtEIHrE8Us=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4D1C320EC;
	Tue, 27 Jan 2015 18:35:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4FF0320DD;
	Tue, 27 Jan 2015 18:35:03 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E6C1BFA-A67D-11E4-9619-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263096>

A release candidate Git v2.3.0-rc2 is now available for testing
at the usual places.

Hopefully this can become the final v2.3.0 next week, almost as-is.
There are no regression noticed and/or fixed since -rc1, and the
changes are mostly l10n and minor documentation updates.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.3.0-rc2'
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

 * A few updates to build on platforms that lack tv_nsec,
   clock_gettime, CLOCK_MONOTONIC and HMAC_CTX_cleanup (e.g. older
   RHEL) have been added.


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

 * "git remote add $name $URL" is now allowed when "url.$URL.insteadOf"
   is already defined.

 * "git imap-send" now can be built to use cURL library to talk to
   IMAP servers (if the library is recent enough, of course).
   This allows you to use authenticate method other than CRAM-MD5,
   among other things.

 * "git imap-send" now allows GIT_CURL_VERBOSE environment variable to
   control the verbosity when talking via the cURL library.

 * The prompt script (in contrib/) learned to optionally hide prompt
   when in an ignored directory by setting GIT_PS1_HIDE_IF_PWD_IGNORED
   shell variable.


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

 * "git http-push" over WebDAV (aka dumb http-push) was broken in
   v2.2.2 when parsing a symbolic ref, resulting in a bogus request
   that gets rejected by recent versions of cURL library.
   (merge f6786c8 jk/http-push-symref-fix later to maint).

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
   (merge 6babe76 tf/prompt-preserve-exit-status later to maint).

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

 * Recent update in Git 2.2 started creating objects/info/packs and
   info/refs files with permission bits tighter than user's umask.
   (merge d91175b jk/prune-packed-server-info later to maint).

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

 * The usage string of "git log" command was marked incorrectly for
   l10n.
   (merge e66dc0c km/log-usage-string-i18n later to maint).

 * "git for-each-ref" mishandled --format=3D"%(upstream:track)" when a
   branch is marked to have forked from a non-existing branch.
   (merge b6160d9 rc/for-each-ref-tracking later to maint).

----------------------------------------------------------------

Changes since v2.3.0-rc1 are as follows:

Alex Henrie (1):
      l10n: ca.po: update translation

Alexander Kuleshov (1):
      cat-file: use "type" and "size" from outer scope

Benedikt Heine (1):
      l10n: de.po: fix typo

Jean-Noel Avila (2):
      l10n: fr.po v2.3.0 round 1
      l10n: fr.po v2.3.0 round 2

Jiang Xin (5):
      l10n: git.pot: v2.3.0 round 1 (13 new, 11 removed)
      l10n: zh_CN: translations for git v2.3.0-rc0
      l10n: git.pot: v2.3.0 round 2 (3 updated)
      l10n: zh_CN: various fixes on command arguments
      l10n: correct indentation of show-branch usage

Joan Perals (1):
      l10n: ca.po: various fixes

Johannes Sixt (1):
      t1050-large: generate large files without dd

Junio C Hamano (1):
      Git 2.3.0-rc2

Kacper Kornet (1):
      Fix unclosed here document in t3301.sh

Michael J Gruber (2):
      l10n: de.po: translate "leave behind" correctly
      l10n: de.po: correct singular form

Peter Krefting (2):
      l10n: sv.po: Update Swedish translation (2298t0f0u)
      l10n: sv.po: Update Swedish translation (2298t0f0u)

Ralf Thielow (4):
      l10n: de.po: translate "track" as "versionieren"
      l10n: de.po: fix typo
      l10n: de.po: translate 13 new messages
      l10n: de.po: translate 3 messages

Sven van Haastregt (1):
      Documentation: fix version numbering

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po(2298t): Updated and change Plural-Forms
      l10n: vi.po(2298t): Updated 3 new strings
