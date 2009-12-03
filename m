From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v3 0/3] bin-wrappers: test without dashed commands in PATH
Date: Wed,  2 Dec 2009 22:14:04 -0700
Message-ID: <1259817247-3724-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 06:14:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG41T-00031Q-QD
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 06:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbZLCFOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 00:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbZLCFOY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 00:14:24 -0500
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:42907
	"EHLO QMTA14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbZLCFOX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2009 00:14:23 -0500
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by QMTA14.emeryville.ca.mail.comcast.net with comcast
	id CUq61d0040mlR8UAEVEXs2; Thu, 03 Dec 2009 05:14:31 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA11.emeryville.ca.mail.comcast.net with comcast
	id CVEW1d0015FCJCg8XVEWz1; Thu, 03 Dec 2009 05:14:31 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 02B9C89114;
	Wed,  2 Dec 2009 22:14:27 -0700 (MST)
X-Mailer: git-send-email 1.6.6.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134432>

This patch series allows running the test suite and/or running an
uninstalled build without dashed commands in the PATH.

Changes since version 2:

   merged - The first 3 old patches (fixes to tests to avoid dashed
         commands, and added GIT_TEST_INSTALLED documentation) are
         now in master, so I am not duplicating them here.

   1/3 - Changed to use "@@BUILD_DIR@@" instead of "__GIT_EXEC_DIR__"
         for sed substitution, and to use single quotes around it
         when setting environment variables in wrap-for-bin.sh.
         But this patch still does not really try to handle
         strange characters in $(shell pwd); see earlier email
         thread about this.  (This is newer than pu.)

   2/3 - Fixed a couple of spelling errors in the --with-dashes
         documentation, and avoid "TOP".  (This is newer than pu.)

   3/3 - Replaced wording for running an uninstalled git.
         It now uses Junio's text: no change compared to his
         version of this patch that is currently in pu.

Matthew Ogilvie (3):
  build dashless "bin-wrappers" directory similar to installed bindir
  run test suite without dashed git-commands in PATH
  INSTALL: document a simpler way to run uninstalled builds

 .gitignore      |    1 +
 INSTALL         |   18 +++++++++++-------
 Makefile        |   49 ++++++++++++++++++++++++++++++++++++-------------
 t/README        |    9 +++++++++
 t/test-lib.sh   |   33 +++++++++++++++++++++------------
 wrap-for-bin.sh |   15 +++++++++++++++
 6 files changed, 93 insertions(+), 32 deletions(-)
 create mode 100644 wrap-for-bin.sh
