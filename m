From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/7] Import Wizard cleanup fixes and test
Date: Thu,  8 Jan 2009 17:56:24 +0100
Message-ID: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyCi-0001Nk-D9
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbZAHQ4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbZAHQ4g
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:36 -0500
Received: from mail.dewire.com ([83.140.172.130]:25768 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbZAHQ4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 45D5E1484F73;
	Thu,  8 Jan 2009 17:56:33 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FnfLsMmfnzrz; Thu,  8 Jan 2009 17:56:32 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6CD5D1484F48;
	Thu,  8 Jan 2009 17:56:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104935>

This series cleans up a few missing things regarding URI parsing
concering Windows paths, missing shortcuts and a couple of string
not using the NLS mechanism.

The last patch is experimental. It is a fully automatic test of
the import wizard. It must be in the Java or Classic Edition of
Eclipse (the JEE version starts with the wrong perspective) and
ran for me on Linux (UTF-8) and Windows. It also required the
SWTBot 2.0 dev edition to work.

-- robin

Robin Rosenberg (7):
  Create the import wizard question checkbox properly
  Fix two strings in the cloning wizard that were not translated.
  Add shortcuts to the Git cloning wizard
  Normalize paths to /-format when parsing GIT URI's
  Add UNC test case to URIish test
  Treat null scheme as file: in git import wizard
  Create an automatic UI test for the Git Import Wizard

 org.spearce.egit.ui.test/.classpath                |    8 +
 org.spearce.egit.ui.test/.project                  |   28 ++
 .../.settings/org.eclipse.jdt.core.prefs           |  320 +++++++++++++
 .../All org.spearce.egit.ui tests.launch           |   41 ++
 org.spearce.egit.ui.test/META-INF/MANIFEST.MF      |   19 +
 org.spearce.egit.ui.test/build.properties          |    4 +
 .../ui/internal/sharing/GitCloneWizardTest.java    |  480 ++++++++++++++++++++
 .../src/org/spearce/egit/ui/test/Activator.java    |   50 ++
 .../src/org/spearce/egit/ui/UIText.java            |    6 +
 .../ui/internal/clone/CloneDestinationPage.java    |    4 +-
 .../components/RepositorySelectionPage.java        |   14 +-
 .../src/org/spearce/egit/ui/uitext.properties      |   32 +-
 .../tst/org/spearce/jgit/transport/URIishTest.java |   20 +
 .../src/org/spearce/jgit/transport/URIish.java     |    3 +-
 14 files changed, 1006 insertions(+), 23 deletions(-)
 create mode 100644 org.spearce.egit.ui.test/.classpath
 create mode 100644 org.spearce.egit.ui.test/.project
 create mode 100644 org.spearce.egit.ui.test/.settings/org.eclipse.jdt.core.prefs
 create mode 100644 org.spearce.egit.ui.test/All org.spearce.egit.ui tests.launch
 create mode 100644 org.spearce.egit.ui.test/META-INF/MANIFEST.MF
 create mode 100644 org.spearce.egit.ui.test/build.properties
 create mode 100644 org.spearce.egit.ui.test/src/org/spearce/egit/ui/internal/sharing/GitCloneWizardTest.java
 create mode 100644 org.spearce.egit.ui.test/src/org/spearce/egit/ui/test/Activator.java
