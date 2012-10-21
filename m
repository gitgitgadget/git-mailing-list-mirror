From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.0
Date: Sun, 21 Oct 2012 15:10:18 -0700
Message-ID: <7vobjveat1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 00:10:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ3jO-0006py-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 00:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab2JUWKY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Oct 2012 18:10:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932225Ab2JUWKX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 18:10:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6CC48502;
	Sun, 21 Oct 2012 18:10:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=ArdNnRF5UU7/la1bNH6N1ZkgK
	dY=; b=rKytQqL/P1dSgn5hNvRrDFCC8+2u47Muf2+t63ohzGaxkLhd/aqgPcr12
	WTQ9f6L4Vs4prn9WX9PGtFPi6zGFRLs47woXHVY5RkzoBlEBevlUtEudnwElDSNs
	Kyte46ofJpAkDapUykboMTM0foHhMhUevMLPCTktPJfnZuf6h4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=VwvS9Tvdi/pz3P1dNTs
	mLgbdPHwA6/7B2xXCHuH4WlTLBUNQA8nkAdOE+irFQcJIwhUNk6HhUTdQlBVzrmA
	L03Z5Twh9SO9v0ttilr0xboGAVb/HRufLCvVCM9klWL8YQ2dNFZCWXZxRp7sA7G1
	IXMB2MK2feB4pX/mZ4l7ZBRU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 918558501;
	Sun, 21 Oct 2012 18:10:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6629684FB; Sun, 21 Oct 2012
 18:10:20 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A5F5150-1BCC-11E2-824B-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208157>

The latest feature release Git v1.8.0 is now available at the
usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

a03afc33f8f0723ad12649d79f1e8968526b4bf7  git-1.8.0.tar.gz
93c860cf4cd26d4b3e269b0903b833db1c1f0f8e  git-htmldocs-1.8.0.tar.gz
a6fa49be36f265e85b7252d36364d4c7f38530ea  git-manpages-1.8.0.tar.gz

Also the following public repositories all have a copy of the v1.8.0
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Enjoy.


Git v1.8.0 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

In the next major release (not *this* one), we will change the
behavior of the "git push" command.

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  We will use the "simple" semantics that pushes the
current branch to the branch with the same name, only when the current
branch is set to integrate with that remote branch.  There is a user
preference configuration variable "push.default" to change this, and
"git push" will warn about the upcoming change until you set this
variable in this release.

"git branch --set-upstream" is deprecated and may be removed in a
relatively distant future.  "git branch [-u|--set-upstream-to]" has
been introduced with a saner order of arguments.


Updates since v1.7.12
---------------------

UI, Workflows & Features

 * A credential helper for Win32 to allow access to the keychain of
   the logged-in user has been added.

 * An initial port to HP NonStop.

 * A credential helper to allow access to the Gnome keyring has been
   added.

 * When "git am" sanitizes the "Subject:" line, we strip the prefix fro=
m
   "Re: subject" and also from a less common "re: subject", but left
   the even less common "RE: subject" intact.  Now we strip that too.

 * It was tempting to say "git branch --set-upstream origin/master",
   but that tells Git to arrange the local branch "origin/master" to
   integrate with the currently checked out branch, which is highly
   unlikely what the user meant.  The option is deprecated; use the
   new "--set-upstream-to" (with a short-and-sweet "-u") option
   instead.

 * "git cherry-pick" learned the "--allow-empty-message" option to
   allow it to replay a commit without any log message.

 * After "git cherry-pick -s" gave control back to the user asking
   help to resolve conflicts, concluding "git commit" used to need to
   be run with "-s" if the user wants to sign it off; now the command
   leaves the sign-off line in the log template.

 * "git daemon" learned the "--access-hook" option to allow an
   external command to decline service based on the client address,
   repository path, etc.

 * "git difftool --dir-diff" learned to use symbolic links to prepare
   a temporary copy of the working tree when available.

 * "git grep" learned to use a non-standard pattern type by default if
   a configuration variable tells it to.

 * Accumulated updates to "git gui" has been merged.

 * "git log -g" learned the "--grep-reflog=3D<pattern>" option to limit
   its output to commits with a reflog message that matches the given
   pattern.

 * "git merge-base" learned the "--is-ancestor A B" option to tell if A=
 is
   an ancestor of B.  The result is indicated by its exit status code.

 * "git mergetool" now allows users to override the actual command used
   with the mergetool.$name.cmd configuration variable even for built-i=
n
   mergetool backends.

 * "git rebase -i" learned the "--edit-todo" option to open an editor
   to edit the instruction sheet.


=46oreign Interface

 * "git svn" has been updated to work with SVN 1.7.

 * "git p4" learned the "--conflicts" option to specify what to do when
   encountering a conflict during "p4 submit".


Performance, Internal Implementation, etc.

 * Git ships with a fall-back regexp implementation for platforms with
   buggy regexp library, but it was easy for people to keep using their
   platform regexp by mistake.  A new test has been added to check this=
=2E

 * The "check-docs" build target has been updated and greatly
   simplified.

 * The test suite is run under MALLOC_CHECK_ when running with a glibc
   that supports the feature.

 * The documentation in the TeXinfo format was using indented output
   for materials meant to be examples that are better typeset in
   monospace.

 * Compatibility wrapper around some mkdir(2) implementations that
   reject parameters with trailing slash has been introduced.

 * Compatibility wrapper for systems that lack usable setitimer() has
   been added.

 * The option parsing of "git checkout" had error checking, dwim and
   defaulting missing options, all mixed in the code, and issuing an
   appropriate error message with useful context was getting harder.
   The code has been reorganized to allow giving a proper diagnosis
   when the user says "git checkout -b -t foo bar" (e.g. "-t" is not a
   good name for a branch).

 * Many internal uses of a "git merge-base" equivalent were only to see
   if one commit fast-forwards to the other, which did not need the
   full set of merge bases to be computed. They have been updated to
   use less expensive checks.

 * The heuristics to detect and silently convert latin1 to utf8 when
   we were told to use utf-8 in the log message has been transplanted
   from "mailinfo" to "commit" and "commit-tree".

 * Messages given by "git <subcommand> -h" from many subcommands have
   been marked for translation.


Also contains minor documentation updates and code clean-ups.


=46ixes since v1.7.12
-------------------

Unless otherwise noted, all the fixes since v1.7.12 in the
maintenance track are contained in this release (see release notes
to them for details).

 * The attribute system may be asked for a path that itself or its
   leading directories no longer exists in the working tree, and it is
   fine if we cannot open .gitattribute file in such a case.  Failure
   to open per-directory .gitattributes with error status other than
   ENOENT and ENOTDIR should be diagnosed, but it wasn't.

 * When looking for $HOME/.gitconfig etc., it is OK if we cannot read
   them because they do not exist, but we did not diagnose existing
   files that we cannot read.

 * When "git am" is fed an input that has multiple "Content-type: ..."
   header, it did not grok charset=3D attribute correctly.

 * "git am" mishandled a patch attached as application/octet-stream
   (e.g. not text/*); Content-Transfer-Encoding (e.g. base64) was not
   honored correctly.

 * "git blame MAKEFILE" run in a history that has "Makefile" but not
   "MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
   confused on a case insensitive filesystem and failed to do so.

 * Even during a conflicted merge, "git blame $path" always meant to
   blame uncommitted changes to the "working tree" version; make it
   more useful by showing cleanly merged parts as coming from the other
   branch that is being merged.

 * It was unclear in the documentation for "git blame" that it is
   unnecessary for users to use the "--follow" option.

 * Output from "git branch -v" contains "(no branch)" that could be
   localized, but the code to align it along with the names of
   branches was counting in bytes, not in display columns.

 * "git cherry-pick A C B" used to replay changes in A and then B and
   then C if these three commits had committer timestamps in that
   order, which is not what the user who said "A C B" naturally
   expects.

 * A repository created with "git clone --single" had its fetch
   refspecs set up just like a clone without "--single", leading the
   subsequent "git fetch" to slurp all the other branches, defeating
   the whole point of specifying "only this branch".

 * Documentation talked about "first line of commit log" when it meant
   the title of the commit.  The description was clarified by defining
   how the title is decided and rewording the casual mention of "first
   line" to "title".

 * "git cvsimport" did not thoroughly cleanse tag names that it
   inferred from the names of the tags it obtained from CVS, which
   caused "git tag" to barf and stop the import in the middle.

 * Earlier we made the diffstat summary line that shows the number of
   lines added/deleted localizable, but it was found irritating having
   to see them in various languages on a list whose discussion language
   is English, and this change has been reverted.

 * "git fetch --all", when passed "--no-tags", did not honor the
   "--no-tags" option while fetching from individual remotes (the same
   issue existed with "--tags", but the combination "--all --tags" make=
s
   much less sense than "--all --no-tags").

 * "git fetch" over http had an old workaround for an unlikely server
   misconfiguration; it turns out that this hurts debuggability of the
   configuration in general, and has been reverted.

 * "git fetch" over http advertised that it supports "deflate", which
   is much less common, and did not advertise the more common "gzip" on
   its Accept-Encoding header.

 * "git fetch" over the dumb-http revision walker could segfault when
   curl's multi interface was used.

 * "git gc --auto" notified the user that auto-packing has triggered
    even under the "--quiet" option.

 * After "gitk" showed the contents of a tag, neither "Reread
   references" nor "Reload" updated what is shown as the
   contents of it when the user overwrote the tag with "git tag -f".

 * "git log --all-match --grep=3DA --grep=3DB" ought to show commits th=
at
   mention both A and B, but when these three options are used with
   --author or --committer, it showed commits that mention either A or
   B (or both) instead.

 * The "-Xours" backend option to "git merge -s recursive" was ignored
   for binary files.

 * "git p4", when "--use-client-spec" and "--detect-branches" are used
   together, misdetected branches.

 * "git receive-pack" (the counterpart to "git push") did not give
   progress output while processing objects it received to the puser
   when run over the smart-http protocol.

 * When you misspell the command name you give to the "exec" action in
   the "git rebase -i" instruction sheet you were told that 'rebase' is=
 not a
   git subcommand from "git rebase --continue".

 * The subcommand in "git remote" to remove a defined remote was
   "rm" and the command did not take a fully-spelled "remove".

 * The interactive prompt that "git send-email" gives was error prone. =
It
   asked "What e-mail address do you want to use?" with the address it
   guessed (correctly) the user would want to use in its prompt,
   tempting the user to say "y". But the response was taken as "No,
   please use 'y' as the e-mail address instead", which is most
   certainly not what the user meant.

 * "git show --format=3D'%ci'" did not give the timestamp correctly for
   commits created without human readable name on the "committer" line.

 * "git show --quiet" ought to be a synonym for "git show -s", but
   wasn't.

 * "git submodule frotz" was not diagnosed as "frotz" being an unknown
   subcommand to "git submodule"; the user instead got a complaint
   that "git submodule status" was run with an unknown path "frotz".

 * "git status" honored the ignore=3Ddirty settings in .gitmodules but
   "git commit" didn't.

 * "gitweb" did not give the correct committer timezone in its feed
   output due to a typo.

----------------------------------------------------------------

Changes since v1.8.0-rc3 are as follows:

Andrew Wong (2):
      git-gui: Detect full path when parsing arguments
      git-gui: Don't prepend the prefix if value looks like a full path

Beat Bolli (2):
      git-gui: Fix a loose/lose mistake
      git-gui: remove .git/CHERRY_PICK_HEAD after committing

Benjamin Kerensa (1):
      git-gui: fix a typo in po/ files

Clemens Buchacher (1):
      git-gui: fix git-gui crash due to uninitialized variable

Heiko Voigt (1):
      git-gui: open console when using --trace on windows

Junio C Hamano (1):
      Git 1.8.0

Marcus Karlsson (1):
      git-gui: Use PWD if it exists on Mac OS X

Pat Thoyts (2):
      git-gui: preserve commit messages in utf-8
      git-gui 0.17

Ralf Thielow (3):
      git-gui: de.po: consistently add untranslated hook names within b=
races
      git-gui: de.po: translate "bare" as "blo=C3=9F"
      git-gui: de.po: translate "remote" as "extern"

Vitaly _Vi Shukela (1):
      git-gui: Fix semi-working shortcuts for unstage and revert
