From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4-rc5
Date: Mon, 28 Jan 2008 02:56:41 -0800
Message-ID: <7vk5lutdzq.fsf@gitster.siamese.dyndns.org>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
	<7vsl0r3nvc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 11:57:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRg3-0000DP-Oj
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbYA1K4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 05:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754882AbYA1K4v
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:56:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbYA1K4t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 05:56:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A0C9317C7;
	Mon, 28 Jan 2008 05:56:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D2DBC17C6;
	Mon, 28 Jan 2008 05:56:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71879>

The fifth and hopefully the last rc for the next feature release
GIT 1.5.4 is available at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.rc5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.rc5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.rc5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.4.rc5-1.$arch.rpm	(RPM)

The changes since -rc4 are quite small, and except for git-gui
updates they are all reasonably trivial fixes.  Please give it a
good testing.

----------------------------------------------------------------

Changes since v1.5.4-rc4 are as follows:

 Documentation/RelNotes-1.5.4.txt |   37 ++++++---
 Documentation/fetch-options.txt  |   12 ++-
 Documentation/git-clone.txt      |    8 ++
 Documentation/git-http-push.txt  |    3 +
 Documentation/git-pull.txt       |    7 ++-
 Documentation/git-send-email.txt |    2 +
 Documentation/git-submodule.txt  |    5 +-
 Documentation/git-svn.txt        |   11 ++-
 GIT-VERSION-GEN                  |    2 +-
 Makefile                         |   18 ++++-
 builtin-commit.c                 |   15 +++-
 builtin-pack-objects.c           |    3 +-
 config.mak.in                    |    1 +
 configure.ac                     |    6 ++
 fast-import.c                    |   65 ++++++++++++++-
 git-compat-util.h                |    2 +
 git-cvsserver.perl               |    9 ++-
 git-gui/Makefile                 |    5 +-
 git-gui/git-gui.sh               |   28 ++++++
 git-gui/lib/choose_rev.tcl       |    3 +-
 git-gui/lib/commit.tcl           |  149 +++++++++++++++++++++------------
 git-gui/lib/error.tcl            |   18 ++--
 git-gui/po/glossary/fr.po        |   26 +++---
 git-gui/po/po2msg.sh             |   25 +++++-
 git-pull.sh                      |   12 +++-
 git-send-email.perl              |    2 +-
 git-submodule.sh                 |  169 +++++++++++++++++++++++++++-----------
 git-svn.perl                     |   10 +--
 http.h                           |    8 ++
 parse-options.c                  |   30 ++++++-
 t/t0040-parse-options.sh         |   11 +++
 t/t5520-pull.sh                  |   17 ++++
 t/t5710-info-alternate.sh        |   12 ++-
 t/t7400-submodule-basic.sh       |   56 ++++++------
 t/t9400-git-cvsserver-server.sh  |   17 +++-
 test-parse-options.c             |    1 +
 36 files changed, 596 insertions(+), 209 deletions(-)

Alex Riesen (1):
      Make t5710 more strict when creating nested repos

Brandon Casey (1):
      git-commit: exit non-zero if we fail to commit the index

Eric Wong (1):
      git-svn: default to repacking every 1000 commits

Gustaf Hendeby (1):
      send-email, fix breakage in combination with --compose

Jakub Narebski (1):
      autoconf: define NO_SYS_SELECT_H on systems without <sys/select.h>.

Johannes Schindelin (1):
      pull --rebase: be cleverer with rebased upstream branches

Junio C Hamano (5):
      git-submodule: rename shell functions for consistency
      git-submodule: fix subcommand parser
      git-submodule: add test for the subcommand parser fix
      Clarify that http-push being temporarily disabled with older cURL
      GIT 1.5.4-rc5

Mike Hommey (2):
      Add a missing dependency on http.h
      Documentation: add a bit about sendemail.to configuration

Miklos Vajna (2):
      git-clone -s: document problems with git gc --prune
      git pull manpage: don't include -n from fetch-options.txt

Nicolas Pitre (1):
      pack-objects: Fix segfault when object count is less than thread count

Pierre Habouzit (1):
      parse-options: catch likely typo in presense of aggregated options.

Robert Schiele (2):
      pre-POSIX.1-2001 systems do not have <sys/select.h>
      Makefile: customization for supporting HP-UX

Sam Vilain (1):
      git-svn(1): update instructions for resuming a git-svn clone

Shawn O. Pearce (10):
      git-gui: Honor the standard commit-msg hook
      git-gui: Correct window title for hook failure dialogs
      git-gui: Consolidate hook execution code into a single function
      git-gui: Correct encoding of glossary/fr.po to UTF-8
      Teach fast-import to honor pack.compression and pack.depth
      Document the hairy gfi_unpack_entry part of fast-import
      git-gui: Work around random missing scrollbar in revision list
      git-gui: Fallback to Tcl based po2msg.sh if msgfmt isn't available
      git-gui: Make the statistics of po2msg match those of msgfmt
      git-gui: Correctly cleanup msgfmt '1 message untranslated' output

Steffen Prohaska (3):
      submodule: Document the details of the command line syntax
      t9400-git-cvsserver-server: Wrap setup into test case
      cvsserver: Fix for histories with multiple roots
