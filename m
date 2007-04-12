From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.1.1
Date: Wed, 11 Apr 2007 19:09:34 -0700
Message-ID: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 04:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hboko-0001mX-Bg
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbXDLCJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Apr 2007 22:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbXDLCJi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:09:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46940 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161466AbXDLCJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2007 22:09:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412020935.OCCO1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 22:09:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m29b1W00p1kojtg0000000; Wed, 11 Apr 2007 22:09:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44311>

The latest maintenance release GIT 1.5.1.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.1.1.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.1.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.1.1.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.1.1-1.$arch.rpm	(RPM)

GIT v1.5.1.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.1
------------------

* Documentation updates

  - The --left-right option of rev-list and friends is documented.

  - The documentation for cvsimport has been majorly improved.

  - "git-show-ref --exclude-existing" was documented.

* Bugfixes

  - The implementation of -p option in "git cvsexportcommit" had
    the meaning of -C (context reduction) option wrong, and
    loosened the context requirements when it was told to be
    strict.

  - "git cvsserver" did not behave like the real cvsserver when
    client side removed a file from the working tree without
    doing anything else on the path.  In such a case, it should
    restore it from the checked out revision.

  - "git fsck" issued an alarming error message on detached
    HEAD.  It is not an error since at least 1.5.0.

  - "git send-email" produced of References header of unbounded length;
    fixed this with line-folding.

  - "git archive" to download from remote site should not
    require you to be in a git repository, but it incorrectly
    did.

  - "git apply" ignored -p<n> for "diff --git" formatted
    patches.

  - "git rerere" recorded a conflict that had one side empty
    (the other side adds) incorrectly; this made merging in the
    other direction fail to use previously recorded resolution.

  - t4200 test was broken where "wc -l" pads its output with
    spaces.

  - "git branch -m old new" to rename branch did not work
    without a configuration file in ".git/config".

  - The sample hook for notification e-mail was misnamed.

  - gitweb did not show type-changing patch correctly in the
    blobdiff view.

  - git-svn did not error out with incorrect command line options.

  - git-svn fell into an infinite loop when insanely long commit
    message was found.

  - git-svn dcommit and rebase was confused by patches that were
    merged from another branch that is managed by git-svn.

----------------------------------------------------------------

Changes since v1.5.1 are as follows:

Arjen Laarhoven (4):
      usermanual.txt: some capitalization nits
      t3200-branch.sh: small language nit
      t5300-pack-object.sh: portability issue using /usr/bin/stat
      Makefile: iconv() on Darwin has the old interface

Brian Gernhardt (3):
      Fix t4200-rerere for white-space from "wc -l"
      Document --left-right option to rev-list.
      Distinguish branches by more than case in tests.

Dana How (1):
      Fix lseek(2) calls with args 2 and 3 swapped

Eric Wong (3):
      git-svn: bail out on incorrect command-line options
      git-svn: dcommit/rebase confused by patches with git-svn-id: line=
s
      git-svn: fix log command to avoid infinite loop on long commit me=
ssages

=46rank Lichtenheld (7):
      cvsimport: sync usage lines with existing options
      cvsimport: Improve documentation of CVSROOT and CVS module determ=
ination
      cvsimport: Improve usage error reporting
      cvsimport: Reorder options in documentation for better understand=
ing
      cvsimport: Improve formating consistency
      cvsserver: small corrections to asciidoc documentation
      cvsserver: Fix handling of diappeared files on update

Geert Bosch (1):
      Fix renaming branch without config file

Gerrit Pape (1):
      rename contrib/hooks/post-receieve-email to contrib/hooks/post-re=
ceive-email.

Jakub Narebski (1):
      gitweb: Fix bug in "blobdiff" view for split (e.g. file to symlin=
k) patches

Jim Meyering (1):
      (encode_85, decode_85): Mark source buffer pointer as "const".

Julian Phillips (1):
      Documentation: show-ref: document --exclude-existing

Junio C Hamano (7):
      rerere: make sorting really stable.
      Fix dependency of common-cmds.h
      Documentation: tighten dependency for git.{html,txt}
      Prepare for 1.5.1.1
      Add Documentation/cmd-list.made to .gitignore
      fsck: do not complain on detached HEAD.
      GIT 1.5.1.1

Lars Hjemli (2):
      rename_ref(): only print a warning when config-file update fails
      Make builtin-branch.c handle the git config file

Ren=C3=A9 Scharfe (1):
      Revert "builtin-archive: use RUN_SETUP"

Shawn O. Pearce (1):
      Honor -p<n> when applying git diffs

Tomash Brechko (1):
      cvsexportcommit -p : fix the usage of git-apply -C.

Ville Skytt=C3=A4 (1):
      DESTDIR support for git/contrib/emacs

YOSHIFUJI Hideaki (1):
      Avoid composing too long "References" header.
