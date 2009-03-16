From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 00/10] JGit cleanups
Date: Mon, 16 Mar 2009 21:14:33 +0100
Message-ID: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:16:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJET-0007a9-LJ
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbZCPUOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbZCPUOs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:14:48 -0400
Received: from mail.dewire.com ([83.140.172.130]:5242 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbZCPUOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:14:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5413D138AD5F;
	Mon, 16 Mar 2009 21:14:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3aZO2jJXYoW; Mon, 16 Mar 2009 21:14:44 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 24FF6138AD53;
	Mon, 16 Mar 2009 21:14:44 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113368>

Getting annoyed with all the noise I came up with series of cleanups. The
hunk parsing fixes are the one's I'm not really sure about, but my attempts
to find a case that would give an uncontrolled error did not find much
success.

-- robin

Robin Rosenberg (10):
  Require javadoc on protected methods in jgit core
  Rename the objectsUrl in the nested HttpObjectDB to
  Rename variables that hides others with different content in
    FetchProcess
  Rename a parameter i PackWriter that hides another with the same name
  Rename fields to avoid hiding of field names in ReadTreeTest
  Rename the gitDir fields to indicate they refer to another dir than
    the default
  Rename a parameter in PushProcessTest that hides another
  Drop unused end parameters in hunk parsing code
  Drop unused File arguments in IndexTreeWalker and WorkdirCheckout
  Drop an effectively unused parameter in IndexTreeWalker.

 .../.settings/org.eclipse.jdt.core.prefs           |    7 +-
 .../src/org/spearce/jgit/pgm/ReceivePack.java      |   10 +-
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |    9 +-
 .../src/org/spearce/jgit/pgm/UploadPack.java       |   10 +-
 .../tst/org/spearce/jgit/lib/ReadTreeTest.java     |  118 ++++++++++----------
 .../spearce/jgit/transport/PushProcessTest.java    |    4 +-
 .../.settings/org.eclipse.jdt.core.prefs           |    5 +-
 .../jgit/dircache/DirCacheBuildIterator.java       |    2 +-
 .../spearce/jgit/dircache/DirCacheIterator.java    |    2 +-
 .../src/org/spearce/jgit/lib/IndexTreeWalker.java  |   12 +-
 .../src/org/spearce/jgit/lib/ObjectId.java         |    2 +-
 .../src/org/spearce/jgit/lib/PackIndex.java        |    6 +-
 .../src/org/spearce/jgit/lib/PackWriter.java       |    8 +-
 .../jgit/lib/TreeVisitorWithCurrentDirectory.java  |    4 +-
 .../src/org/spearce/jgit/lib/WorkDirCheckout.java  |   17 ++--
 .../org/spearce/jgit/merge/StrategyOneSided.java   |    2 +-
 .../org/spearce/jgit/patch/CombinedHunkHeader.java |    2 +-
 .../src/org/spearce/jgit/patch/FileHeader.java     |   18 ++--
 .../src/org/spearce/jgit/patch/HunkHeader.java     |    6 +-
 .../src/org/spearce/jgit/patch/Patch.java          |    8 +-
 .../org/spearce/jgit/revplot/PlotCommitList.java   |    9 ++
 .../src/org/spearce/jgit/revplot/PlotWalk.java     |    4 +
 .../org/spearce/jgit/transport/DaemonService.java  |    4 +-
 .../org/spearce/jgit/transport/FetchProcess.java   |    8 +-
 .../org/spearce/jgit/transport/OpenSshConfig.java  |    2 +-
 .../spearce/jgit/transport/OperationResult.java    |   10 +-
 .../spearce/jgit/transport/PackedObjectInfo.java   |    2 +-
 .../src/org/spearce/jgit/transport/PushResult.java |    2 +-
 .../spearce/jgit/transport/RemoteRefUpdate.java    |    6 +-
 .../org/spearce/jgit/transport/TransportHttp.java  |   14 +-
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    7 +
 31 files changed, 173 insertions(+), 147 deletions(-)
