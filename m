From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/6] Ref rename
Date: Wed, 20 May 2009 01:13:12 +0200
Message-ID: <1242774798-23639-1-git-send-email-robin.rosenberg@dewire.com>
References: <20090507155117.GS30527@spearce.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed May 20 01:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6YV8-0003FB-Eq
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbZESXN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 19:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbZESXN1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 19:13:27 -0400
Received: from mail.dewire.com ([83.140.172.130]:25879 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359AbZESXN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 19:13:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E2FA8145D12E;
	Wed, 20 May 2009 01:13:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5OJ-VrdffaQj; Wed, 20 May 2009 01:13:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.11])
	by dewire.com (Postfix) with ESMTP id BDEA3800277;
	Wed, 20 May 2009 01:13:21 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.dirty
In-Reply-To: <20090507155117.GS30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119571>

Ok, an update with most of your comments and a mix of other fixes
founding since then during testing.

Robin Rosenberg (6):
  Make sure we get the right storage for loose/pack/loose and packed
    refs
  Add ref rename support to JGit
  Add ref rename support to the branch dialog
  Allow non-ASCII ref names when writing the packed-refs file
  Use Constants.PACKED_REFS in RefWriter
  Improve error reporting in the branch dialog

 .../src/org/spearce/egit/ui/UIText.java            |   15 ++
 .../ui/internal/dialogs/BranchSelectionDialog.java |  119 ++++++++++++----
 .../src/org/spearce/egit/ui/uitext.properties      |    6 +
 .../tst/org/spearce/jgit/lib/RefTest.java          |   94 ++++++++++++
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  152 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   56 +++++++-
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   20 +++-
 .../src/org/spearce/jgit/lib/RefRename.java        |  101 +++++++++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   29 +++-
 .../src/org/spearce/jgit/lib/RefWriter.java        |    2 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   16 ++
 11 files changed, 567 insertions(+), 43 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
