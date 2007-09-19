From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.3.2
Date: Wed, 19 Sep 2007 12:01:35 -0700
Message-ID: <7vir66pjhs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 21:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY4o2-0004UY-DP
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 21:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXISTBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2007 15:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbXISTBn
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 15:01:43 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbXISTBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2007 15:01:41 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A37C136372;
	Wed, 19 Sep 2007 15:01:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58724>

The latest maintenance release GIT 1.5.3.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.3.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.3.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.3.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.3.2-1.$arch.rpm	(RPM)


GIT v1.5.3.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.3.1
--------------------

 * git-push sent thin packs by default, which was not good for
   the public distribution server (no point in saving transfer
   while pushing; no point in making the resulting pack less
   optimum).

 * git-svn sometimes terminated with "Malformed network data" when
   talking over svn:// protocol.

 * git-send-email re-issued the same message-id about 10% of the
   time if you fired off 30 messages within a single second.

 * git-stash was not terminating the log message of commits it
   internally creates with LF.

 * git-apply failed to check the size of the patch hunk when its
   beginning part matched the remainder of the preimage exactly,
   even though the preimage recorded in the hunk was much larger
   (therefore the patch should not have applied), leading to a
   segfault.

 * "git rm foo && git commit foo" complained that 'foo' needs to
   be added first, instead of committing the removal, which was a
   nonsense.

 * git grep -c said "/dev/null: 0".

 * git-add -u failed to recognize a blob whose type changed
   between the index and the work tree.

 * The limit to rename detection has been tightened a lot to
   reduce performance problems with a huge change.

 * cvsimport and svnimport barfed when the input tried to move
   a tag.

 * "git apply -pN" did not chop the right number of directories.

 * "git svnimport" did not like SVN tags with funny characters in them.

 * git-gui 0.8.3, with assorted fixes, including:

   - font-chooser on X11 was unusable with large number of fonts;
   - a diff that contained a deleted symlink made it barf;
   - an untracked symbolic link to a directory made it fart;
   - a file with % in its name made it vomit;


Documentation updates
---------------------

User manual has been somewhat restructured.  I think the new
organization is much easier to read.


----------------------------------------------------------------

Changes since v1.5.3.1 are as follows:

Alexandre Julliard (1):
      hooks--update: Explicitly check for all zeros for a deleted ref.

Benoit Sigoure (1):
      Add test to check recent fix to "git add -u"

Carlos Rica (1):
      git-tag -s must fail if gpg cannot sign the tag.

David Kastrup (1):
      git-send-email.perl: Add angle brackets to In-Reply-To if necessa=
ry

Dmitry V. Levin (2):
      Makefile: Add cache-tree.h to the headers list
      git-commit: Disallow amend if it is going to produce an empty non=
-merge commit

Eric Wong (3):
      git-svn: fix "Malformed network data" with svn:// servers
      git-svn: understand grafts when doing dcommit
      Documentation/git-svn: updated design philosophy notes

Gerrit Pape (2):
      git-gui: lib/index.tcl: handle files with % in the filename prope=
rly
      git-clone: improve error message if curl program is missing or no=
t executable

J. Bruce Fields (13):
      user-manual: adjust section levels in "git internals"
      user-manual: move object format details to hacking-git chapter
      user-manual: rename "git internals" to "git concepts"
      user-manual: create new "low-level git operations" chapter
      user-manual: rewrite index discussion
      user-manual: reorder commit, blob, tree discussion
      user-manual: rewrite object database discussion
      user-manual: move packfile and dangling object discussion
      user-manual: fix introduction to packfiles
      user-manual: todo updates and cleanup
      documentation: replace Discussion section by link to user-manual =
chapter
      core-tutorial: minor cleanup
      git-apply: fix whitespace stripping

Jari Aalto (1):
      Documentation/git-archive.txt: a couple of clarifications.

Jean-Luc Herren (1):
      stash: end index commit log with a newline

Jeff King (1):
      git-push: documentation and tests for pushing only branches

Johannes Schindelin (2):
      revision walker: --cherry-pick is a limited operation
      apply --index-info: fall back to current index for mode changes

Junio C Hamano (13):
      git-apply: do not read past the end of buffer
      git-add -u: do not barf on type changes
      git-format-patch --in-reply-to: accept <message@id> with angle br=
ackets
      diff --no-index: do not forget to run diff_setup_done()
      Documentation/git-config.txt: AsciiDoc tweak to avoid leading dot
      Split grep arguments in a way that does not requires to add /dev/=
null.
      git-sh-setup: typofix in comments
      send-email: make message-id generation a bit more robust
      git-commit: Allow partial commit of file removal.
      git-commit: partial commit of paths only removed from the index
      Document ls-files --with-tree=3D<tree-ish>
      t/t4014: test "am -3" with mode-only change.
      GIT 1.5.3.2

Linus Torvalds (1):
      Fix the rename detection limit checking

Matthias Urlichs (1):
      git-svnimport: Use separate arguments in the pipe for git-rev-par=
se

Michael Smith (1):
      (cvs|svn)import: Ask git-tag to overwrite old tags.

Michele Ballabio (2):
      git-gui: show unstaged symlinks in diff viewer
      git-gui: handle "deleted symlink" diff marker

Mike Ralphson (1):
      Documentation / grammer nit

Nicolas Pitre (1):
      fix doc for --compression argument to pack-objects

Pierre Habouzit (1):
      Fix lapsus in builtin-apply.c

Ramsay Allan Jones (1):
      Fix a test failure (t9500-*.sh) on cygwin

Shawn O. Pearce (17):
      git-gui: Correct starting of git-remote to handle -w option
      git-gui: Fix detaching current branch during checkout
      git-gui: Properly set the state of "Stage/Unstage Hunk" action
      Don't allow contrib/workdir/git-new-workdir to trash existing dir=
s
      Cleanup unnecessary file modifications in t1400-update-ref
      Include a git-push example for creating a remote branch
      git-gui: Disable Tk send in all git-gui sessions
      git-gui: Avoid use of libdir in Makefile
      git-gui: Assume untracked directories are Git submodules
      git-gui: Trim trailing slashes from untracked submodule names
      Make --no-thin the default in git-push to save server resources
      git-gui: Don't delete send on Windows as it doesn't exist
      git-gui: Make backporting changes from i18n version easier
      git-gui: Font chooser to handle a large number of font families
      git-gui: Provide 'uninstall' Makefile target to undo an installat=
ion
      git-gui: Paper bag fix "Commit->Revert" format arguments
      git-gui: Disable native platform text selection in "lists"

Sven Verdoolaege (1):
      git-diff: don't squelch the new SHA1 in submodule diffs

Ulrik Sverdrup (1):
      Remove duplicate note about removing commits with git-filter-bran=
ch

V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 (1):
      Fixed update-hook example allow-users format.
