From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4-rc4
Date: Sun, 20 Jan 2008 18:37:27 -0800
Message-ID: <7vsl0r3nvc.fsf@gitster.siamese.dyndns.org>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 03:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGmY2-0005e3-S7
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 03:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbYAUChf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 21:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756199AbYAUChf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 21:37:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136AbYAUChe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 21:37:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CA04381D;
	Sun, 20 Jan 2008 21:37:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 85130381C;
	Sun, 20 Jan 2008 21:37:29 -0500 (EST)
In-Reply-To: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 11 Jan 2008 23:11:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71209>

The fourth rc for the next feature release GIT 1.5.4 is available
at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.rc4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.rc4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.rc4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.4.rc4-1.$arch.rpm	(RPM)

I was hoping that this would be the last rc before 1.5.4 final,
and in fact the change between -rc3 and -rc4 is fairly small.

Notable fixes are:

 * http-push fixes (Gr=C3=A9goire Barbier);
 * fix to performance regression during partial commit (Linus);
 * ref/heads are now enforced to point at commit (Linus);
 * fix for fast-import reading some part of its own output (Shawn);
 * "diff --color-words" showed unchanged lines in metainfo color (Jeff =
King);

Also we have a handful gitk and git-gui updates.

This however still lacks two patches that I think we might want
in the final (please see "What's not in 'master'" message). I
asked for comments but I guess they were lost in the noise or
something.  It's not a very good sign that we had too many
discussions on the list that are totally unrelated to 1.5.4, and
I had to scroll back more than 1000 articles to skip them to
find the announcement for the -rc3 X-<.  So we will either have
another rc to include those two fixes after getting feedbacks,
or ship the final one with two known breakages.  The former
would be preferred, and it would be better if they can be done
earlier.

Even though we had some RPM specfile changes that I cannot
easily check myself, nobody reported breakages after -rc3.  I am
taking this as "no news is a good news", but it may turn out
that nobody has been testing/double-checking, and it may come
back and bite us when we do the final one.  That's also
something I cannot do much about.

But other than that, I think we are in good shape.

----------------------------------------------------------------

Changes since v1.5.4-rc3 are as follows:

Bill Lear (1):
      Correct spelling in diff.c comment

Brandon Casey (4):
      close_lock_file(): new function in the lockfile API
      Improve use of lockfile API
      refs.c: rework ref_locks by abstracting from underlying struct lo=
ck_file
      fast-import.c: don't try to commit marks file if write failed

Christian Couder (2):
      git-gui: Initial french translation
      git-gui: add french glossary: glossary/fr.po

Christian Stimming (4):
      git-gui: Update glossary: add term "hunk"
      git-gui: Update German translation
      git-gui: Fix broken revert confirmation.
      git-gui: Improve German translation.

Dan McGee (3):
      Remove usage of git- (dash) commands from email hook
      cvsimport: remove last use of repo-config from git standard tools
      Update git-completion for new 'remote rm' option

Dave Peticolas (1):
      Documentation: fix and clarify grammar in git-merge docs.

Dmitry Potapov (1):
      treat any file with NUL as binary

Eric Wong (1):
      git-svn: handle leading/trailing whitespace from svnsync revprops

Gr=C3=A9goire Barbier (4):
      http-push: disable http-push without USE_CURL_MULTI
      http-push: fix webdav lock leak.
      http-push: fail when info/refs exists and is already locked
      http-push and http-fetch: handle URLs without trailing /

Jakub Narebski (1):
      autoconf: Add checking for unsetenv function

Jean-Luc Herren (1):
      Make default pre-commit hook less noisy

Jeff King (5):
      git-clean: fix off-by-one memory access when given no arguments
      color unchanged lines as "plain" in "diff --color-words"
      send-email: detect invocation errors earlier
      send-email: validate patches before sending anything
      send-email: add no-validate option

Jim Meyering (2):
      fast-import: Don't use a maybe-clobbered errno value
      doc typo: s/prior committing/prior to committing/

Johannes Schindelin (1):
      gitk: make Ctrl "+" really increase the font size

Junio C Hamano (8):
      builtin-commit.c: remove useless check added by faulty cut and pa=
ste
      Revert "builtin-commit.c: remove useless check added by faulty cu=
t and paste"
      Fix git-rerere documentation
      Squelch bogus progress output from git-rebase--interactive
      Document lockfile API
      Officially deprecate repo-config.
      http-push: clarify the reason of error from the initial PROPFIND =
request
      GIT 1.5.4-rc4

Kristian H=C3=B8gsberg (1):
      git-commit: fix double close(2) that can close a wrong file descr=
iptor

Lars Hjemli (1):
      Move sha1_file_to_archive into libgit

Linus Torvalds (4):
      Fix performance regression for partial commits
      Make builtin-commit.c more careful about parenthood
      Make 'git fsck' complain about non-commit branches
      Be more careful about updating refs

Mark Drago (1):
      hg-to-git: improve popen calls

Mark Levedahl (1):
      git-gui: Makefile - Handle $DESTDIR on Cygwin

Martin Koegler (1):
      parse_commit_buffer: tighten checks while parsing

Miklos Vajna (3):
      Add using merge subtree How-To
      ls-remote: add -t and -h options.
      Include rev-list options in git-log manpage.

Peter Karlsson (1):
      git-gui: Updated Swedish translation after mailing list review.

Shawn O. Pearce (3):
      git-gui: Allow 'Create New Repository' on existing directories
      git-gui: Refresh file status description after hunk application
      Fix random fast-import errors when compiled with NO_MMAP

Thomas Zander (1):
      core-tutorial typofix
