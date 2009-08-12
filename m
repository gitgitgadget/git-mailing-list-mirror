From: Johan Herland <johan@herland.net>
Subject: [RFCv3 0/4] CVS remote helper
Date: Wed, 12 Aug 2009 02:13:47 +0200
Message-ID: <1250036031-32272-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 02:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb1Tq-00075P-Ry
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZHLAOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbZHLAOI
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:14:08 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52004 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754135AbZHLAOH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 20:14:07 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO800DG3LZI8E10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 02:14:06 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO8000BCLZHU410@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 02:14:06 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.12.47
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125626>

Hi,

Another iteration of the patch series implementing a CVS remote helper, as
promised a couple of days ago. Changes from the previous iteration:

- Rebased on top of Daniel Barkalow's latest foreign VCS helpers work
  (aka. 'db/vcs-helper' (early part)). This means that all the "generic"
  foreign-scm patches that were part of the previous iteration are no
  longer needed, and only the CVS remote helper patches remain.
  Also, this series applies cleanly to current 'pu'.

- Replaced the "git-vcs-cvs" naming with "git-remote-cvs" throughout the code
  and documentation.

- Minor updates to the git-remote-cvs implementation in order to more closely
  follow the current remote helper API.

- Split up the patch series into somewhat smaller patches to (hopefully) be
  allowed onto git@vger.kernel.org.


Have fun! :)

...Johan


Johan Herland (4):
  Basic build infrastructure for Python scripts
  Add Python support library for CVS remote helper
  Third draft of CVS remote helper program
  Add simple selftests of git-remote-cvs functionality

 Documentation/git-remote-cvs.txt   |   85 ++++
 Makefile                           |   46 ++
 configure.ac                       |    3 +
 git-remote-cvs.py                  |  697 ++++++++++++++++++++++++++++
 git_remote_cvs/.gitignore          |    2 +
 git_remote_cvs/Makefile            |   27 ++
 git_remote_cvs/changeset.py        |  114 +++++
 git_remote_cvs/commit_states.py    |   52 +++
 git_remote_cvs/cvs.py              |  884 ++++++++++++++++++++++++++++++++++++
 git_remote_cvs/cvs_revision_map.py |  362 +++++++++++++++
 git_remote_cvs/cvs_symbol_cache.py |  283 ++++++++++++
 git_remote_cvs/git.py              |  586 ++++++++++++++++++++++++
 git_remote_cvs/setup.py            |   12 +
 git_remote_cvs/util.py             |  147 ++++++
 t/t9800-remote-cvs-basic.sh        |  524 +++++++++++++++++++++
 t/t9801-remote-cvs-fetch.sh        |  291 ++++++++++++
 t/test-lib.sh                      |    1 +
 17 files changed, 4116 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-cvs.txt
 create mode 100755 git-remote-cvs.py
 create mode 100644 git_remote_cvs/.gitignore
 create mode 100644 git_remote_cvs/Makefile
 create mode 100644 git_remote_cvs/__init__.py
 create mode 100644 git_remote_cvs/changeset.py
 create mode 100644 git_remote_cvs/commit_states.py
 create mode 100644 git_remote_cvs/cvs.py
 create mode 100644 git_remote_cvs/cvs_revision_map.py
 create mode 100644 git_remote_cvs/cvs_symbol_cache.py
 create mode 100644 git_remote_cvs/git.py
 create mode 100644 git_remote_cvs/setup.py
 create mode 100644 git_remote_cvs/util.py
 create mode 100755 t/t9800-remote-cvs-basic.sh
 create mode 100755 t/t9801-remote-cvs-fetch.sh
