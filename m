From: Johan Herland <johan@herland.net>
Subject: [RFCv4 0/5] CVS remote helper
Date: Mon, 17 Aug 2009 05:35:56 +0200
Message-ID: <1250480161-21933-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johannes.Schindelin@gmx.de, Johan Herland <johan@herland.net>,
	barkalow@iabervon.org, davvid@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 05:36:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mct1g-0006ij-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 05:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727AbZHQDgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 23:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbZHQDgb
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 23:36:31 -0400
Received: from smtp.getmail.no ([84.208.15.66]:47236 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756704AbZHQDgb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 23:36:31 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00CDD4OV4N60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 05:36:31 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00M7C4OTJP20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 05:36:31 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.17.32416
X-Mailer: git-send-email 1.6.4.262.gca66a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126109>

Hi,

Another iteration of the patch series implementing a CVS remote helper.
Changes from the previous iteration:

- Python coding style fixes suggested by PEP8, PyLint, David Aguilar, etc.

- Documentation/git-remote-cvs.txt compile fix

- git_remote_cvs/Makefile fixes from David Aguilar (his v2 series)

- rebased onto current 'pu' (minus jh/vcs-cvs)

- split up patch 2/4 into two parts to fit on the Git mailing list


Have fun! :)

...Johan


Johan Herland (5):
  Basic build infrastructure for Python scripts
  1/2: Add Python support library for CVS remote helper
  2/2: Add Python support library for CVS remote helper
  git-remote-cvs: Remote helper program for CVS repositories
  Add simple selftests of git-remote-cvs functionality

 Documentation/git-remote-cvs.txt   |   85 +++
 Makefile                           |   46 ++
 configure.ac                       |    3 +
 git-remote-cvs.py                  |  683 ++++++++++++++++++++++++
 git_remote_cvs/.gitignore          |    2 +
 git_remote_cvs/Makefile            |   35 ++
 git_remote_cvs/__init__.py         |   27 +
 git_remote_cvs/changeset.py        |  126 +++++
 git_remote_cvs/commit_states.py    |   62 +++
 git_remote_cvs/cvs.py              |  998 ++++++++++++++++++++++++++++++++++++
 git_remote_cvs/cvs_revision_map.py |  418 +++++++++++++++
 git_remote_cvs/cvs_symbol_cache.py |  313 +++++++++++
 git_remote_cvs/git.py              |  680 ++++++++++++++++++++++++
 git_remote_cvs/setup.py            |   17 +
 git_remote_cvs/util.py             |  186 +++++++
 t/t9800-remote-cvs-basic.sh        |  524 +++++++++++++++++++
 t/t9801-remote-cvs-fetch.sh        |  291 +++++++++++
 t/test-lib.sh                      |    1 +
 18 files changed, 4497 insertions(+), 0 deletions(-)
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
