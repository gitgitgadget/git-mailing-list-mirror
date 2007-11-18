From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.3.6
Date: Sun, 18 Nov 2007 15:14:15 -0800
Message-ID: <7vve7ztad4.fsf@gitster.siamese.dyndns.org>
References: <7vpryugb7i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 00:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IttLe-0002wz-FE
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 00:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbXKRXOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2007 18:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbXKRXOY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 18:14:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38405 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbXKRXOW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2007 18:14:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EA9D62F0;
	Sun, 18 Nov 2007 18:14:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 11A1997395;
	Sun, 18 Nov 2007 18:14:38 -0500 (EST)
In-Reply-To: <7vpryugb7i.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 31 Oct 2007 15:40:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65393>

The latest maintenance release GIT 1.5.3.6 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.3.6.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.3.6.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.3.6.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.3.6-1.$arch.rpm	(RPM)

----------------------------------------------------------------
GIT v1.5.3.6 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.3.5
--------------------

 * git-cvsexportcommit handles root commits better.

 * git-svn dcommit used to clobber when sending a series of
   patches.

 * git-svn dcommit failed after attempting to rebase when
   started with a dirty index; now it stops upfront.

 * git-grep sometimes refused to work when your index was
   unmerged.

 * "git-grep -A1 -B2" acted as if it was told to run "git -A1 -B21".

 * git-hash-object did not honor configuration variables, such as
   core.compression.

 * git-index-pack choked on a huge pack on 32-bit machines, even when
   large file offsets are supported.

 * atom feeds from git-web said "10" for the month of November.

 * a memory leak in commit walker was plugged.

 * When git-send-email inserted the original author's From:
   address in body, it did not mark the message with
   Content-type: as needed.

 * git-revert and git-cherry-pick incorrectly refused to start
   when the work tree was dirty.

 * git-clean did not honor core.excludesfile configuration.

 * git-add mishandled ".gitignore" files when applying them to
   subdirectories.

 * While importing a too branchy history, git-fastimport did not
   honor delta depth limit properly.

 * Support for zlib implementations that lack ZLIB_VERNUM and definitio=
n
   of deflateBound() has been added.

 * Quite a lot of documentation clarifications.


----------------------------------------------------------------

Changes since v1.5.3.5 are as follows:

Alex Riesen (1):
      stop t1400 hiding errors in tests

Ask Bj=C3=B8rn Hansen (1):
      When exec() fails include the failing command in the error messag=
e

Benoit Sigoure (2):
      git-send-email: Change the prompt for the subject of the initial =
message.
      git-svn: prevent dcommitting if the index is dirty.

Brad King (1):
      cvsexportcommit: fix for commits that do not have parents

Christian Couder (1):
      for-each-ref: fix off by one read.

David D Kilzer (2):
      RelNotes-1.5.3.5: fix typo
      RelNotes-1.5.3.5: fix another typo

David Symonds (1):
      Improve accuracy of check for presence of deflateBound.

Eric Wong (2):
      git-svn: fix dcommit clobbering when committing a series of diffs
      git-svn: t9114: verify merge commit message in test

Gerrit Pape (4):
      git-diff.txt: add section "output format" describing the diff for=
mats
      git-cvsimport: really convert underscores in branch names to dots=
 with -u
      git-daemon: fix remote port number in log entry
      git-mailsplit: with maildirs not only process cur/, but also new/

Jakub Narebski (1):
      gitweb: Update config file example for snapshot feature in gitweb=
/INSTALL

Jeff King (2):
      git-branch: remove mention of non-existent '-b' option
      git-send-email: add charset header if we add encoded 'From'

Jing Xue (1):
      replace reference to git-rm with git-reset in git-commit doc

Johannes Schindelin (1):
      Add Documentation/CodingGuidelines

Jonas Fonseca (3):
      Remove escaping of '|' in manpage option sections
      instaweb: Minor cleanups and fixes for potential problems
      Documentation: Fix man page breakage with DocBook XSL v1.72

Jonathan del Strother (1):
      Fixing path quoting in git-rebase

Junio C Hamano (12):
      grep with unmerged index
      refresh_index_quietly(): express "optional" nature of index writi=
ng better
      Makefile: add missing dependency on wt-status.h
      Start preparing for 1.5.3.6
      t/t3404: fix test for a bogus todo file.
      revert/cherry-pick: allow starting from dirty work tree.
      git-clean: honor core.excludesfile
      core.excludesfile clean-up
      Fix per-directory exclude handing for "git add"
      Update draft release notes for 1.5.3.6
      grep -An -Bm: fix invocation of external grep command
      GIT 1.5.3.6

Kristian H=C3=B8gsberg (1):
      Remove unecessary hard-coding of EDITOR=3D':' VISUAL=3D':' in som=
e test suites.

Marco Costalba (1):
      Remove a couple of duplicated include

Mike Hommey (1):
      Delay pager setup in git blame

Nicolas Pitre (3):
      print warning/error/fatal messages in one shot
      git-hash-object should honor config variables
      fix index-pack with packs >4GB containing deltas on 32-bit machin=
es

Ralf Wildenhues (3):
      git-clone.txt: Improve --depth description.
      Avoid a few unportable, needlessly nested "...`...".
      Fix sed string regex escaping in module_name.

Sergei Organov (6):
      git-filter-branch.txt: fix a typo.
      git-format-patch.txt: fix explanation of an example.
      Documentation: quote commit messages consistently.
      SubmittingPatches: improve the 'Patch:' section of the checklist
      core-tutorial.txt: Fix argument mistake in an example.
      git-remote.txt: fix typo

Shawn O. Pearce (2):
      Fix memory leak in traverse_commit_list
      Don't allow fast-import tree delta chains to exceed maximum depth

Vincent Zanotti (1):
      gitweb: correct month in date display for atom feeds

Wincent Colaiuta (2):
      Grammar fixes for gitattributes documentation
      Fix t9101 test failure caused by Subversion "auto-props"
