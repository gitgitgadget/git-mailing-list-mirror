From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.3.7
Date: Sat, 01 Dec 2007 13:38:39 -0800
Message-ID: <7vlk8e2izk.fsf@gitster.siamese.dyndns.org>
References: <7vpryugb7i.fsf@gitster.siamese.dyndns.org>
	<7vve7ztad4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 22:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iya3H-0000x6-Op
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 22:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbXLAVir convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2007 16:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbXLAVir
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 16:38:47 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39740 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbXLAViq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Dec 2007 16:38:46 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8CF8F2EF;
	Sat,  1 Dec 2007 16:39:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C90E99B807;
	Sat,  1 Dec 2007 16:39:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66739>

The latest maintenance release GIT 1.5.3.7 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.3.7.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.3.7.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.3.7.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.3.7-1.$arch.rpm	(RPM)

What's cooking for upcoming feature release v1.5.4 has been stablizing,
and hopefully this will be the last of v1.5.3 maintenance series.

By the way, if you are the package maintainer of git for a distro, or
the editor of an OSS oriented publication, and if you would like a copy
of release announcements, please let me know, so that I can add your
e-mail address to Bcc: on future announcement mails.  Sorry, but I
cannot handle subscription requests from individuals.

----------------------------------------------------------------
GIT v1.5.3.7 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.3.6
--------------------

 * git-send-email added 8-bit contents to the payload without
   marking it as 8-bit in a CTE header.

 * "git-bundle create a.bndl HEAD" dereferenced the symref and
   did not record the ref as 'HEAD'; this prevented a bundle
   from being used as a normal source of git-clone.

 * The code to reject nonsense command line of the form
   "git-commit -a paths..." and "git-commit --interactive
   paths..." were broken.

 * Adding a signature that is not ASCII-only to an original
   commit that is ASCII-only would make the result non-ASCII.
   "git-format-patch -s" did not mark such a message correctly
   with MIME encoding header.

 * git-add sometimes did not mark the resulting index entry
   stat-clean.  This affected only cases when adding the
   contents with the same length as the previously staged
   contents, and the previous staging made the index entry
   "racily clean".

 * git-commit did not honor GIT_INDEX_FILE the user had in the
   environment.

 * When checking out a revision, git-checkout did not report where the
   updated HEAD is if you happened to have a file called HEAD in the
   work tree.

 * "git-rev-list --objects" mishandled a tree that points at a
   submodule.

 * "git cvsimport" was not ready for packed refs that "git gc" can
   produce and gave incorrect results.

 * Many scripted Porcelains were confused when you happened to have a
   file called "HEAD" in your work tree.

Also it contains updates to the user manual and documentation.

----------------------------------------------------------------

Changes since v1.5.3.6 are as follows:

Bj=C3=B6rn Steinbrink (3):
      git-commit.sh: Fix usage checks regarding paths given when they d=
o not make sense
      t7005-editor.sh: Don't invoke real vi when it is in GIT_EXEC_PATH
      git-commit: Add tests for invalid usage of -a/--interactive with =
paths

Brian Downing (2):
      config: correct core.loosecompression documentation
      config: clarify compression defaults

J. Bruce Fields (7):
      git-remote.txt: fix example url
      user-manual: mention "..." in "Generating diffs", etc.
      Documentation: Fix references to deprecated commands
      user-manual: define "branch" and "working tree" at start
      user-manual: failed push to public repository
      user-manual: clarify language about "modifying" old commits
      user-manual: recovering from corruption

Jan Hudec (1):
      Improve description of git-branch -d and -D in man page.

Jeff King (5):
      send-email: add transfer encoding header with content-type
      Add basic cvsimport tests
      cvsimport: use rev-parse to support packed refs
      cvsimport: miscellaneous packed-ref fixes
      cvsimport: fix usage of cvsimport.module

Johannes Schindelin (2):
      bundle create: keep symbolic refs' names instead of resolving the=
m
      Replace the word 'update-cache' by 'update-index' everywhere

Johannes Sixt (1):
      t7003-filter-branch: Fix test of a failing --msg-filter.

Junio C Hamano (11):
      format-patch -s: add MIME encoding header if signer's name requir=
es so
      test format-patch -s: make sure MIME content type is shown as nee=
ded
      ce_match_stat, run_diff_files: use symbolic constants for readabi=
lity
      git-add: make the entry stat-clean after re-adding the same conte=
nts
      t2200: test more cases of "add -u"
      Make test scripts executable.
      Fix sample pre-commit hook
      git-checkout: describe detached head correctly
      scripts: do not get confused with HEAD in work tree
      Fix typo in t4008 test title
      GIT 1.5.3.7

Linus Torvalds (1):
      Fix rev-list when showing objects involving submodules

Matthieu Moy (1):
      Doc fix for git-reflog: mention @{...} syntax, and <ref> in synop=
sys.

R=C3=A9mi Vanicat (1):
      Make GIT_INDEX_FILE apply to git-commit

Steffen Prohaska (1):
      user-manual: Add section "Why bisecting merge commits can be hard=
er ..."
