From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/3] Improved object validation
Date: Thu, 30 Oct 2008 10:46:22 -0700
Message-ID: <1225388785-26818-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:47:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvbcU-0002IZ-QP
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 18:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbYJ3Rq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 13:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYJ3Rq3
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 13:46:29 -0400
Received: from george.spearce.org ([209.20.77.23]:50780 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbYJ3Rq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 13:46:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 73ED638377; Thu, 30 Oct 2008 17:46:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=4.0 tests=ALL_TRUSTED,BAYES_20
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4B59C38260;
	Thu, 30 Oct 2008 17:46:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.3.756.gb776d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99507>

This is mostly a resend as I haven't heard anything on the series.
One new patch at the end, to handle '.' and '..' cases.

Shawn O. Pearce (3):
  Check object connectivity during fetch if fsck is enabled
  Add --[no-]thin and --[no-]fsck optiosn to fetch command line tool
  Don't permit '.' or '..' in tree entries

 .../src/org/spearce/jgit/pgm/Fetch.java            |   20 +++++++++++++
 .../org/spearce/jgit/lib/ObjectCheckerTest.java    |   31 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/ObjectChecker.java    |    7 ++++
 .../jgit/transport/BasePackFetchConnection.java    |    4 ++
 .../spearce/jgit/transport/FetchConnection.java    |   22 ++++++++++++++
 .../org/spearce/jgit/transport/FetchProcess.java   |   13 +++++++-
 .../spearce/jgit/transport/TransportBundle.java    |    4 ++
 .../jgit/transport/WalkFetchConnection.java        |    4 ++
 8 files changed, 103 insertions(+), 2 deletions(-)
