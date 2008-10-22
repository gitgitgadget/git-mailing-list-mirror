From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 2/3] Fix FileTreeIteratorTest on Windows/NTFS
Date: Wed, 22 Oct 2008 10:33:32 +0200
Message-ID: <20081022083332.GB17940@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:34:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZB5-00063h-Au
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbYJVIdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbYJVIdg
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:33:36 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:44538 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbYJVIdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:33:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 7E7E852C3D9;
	Wed, 22 Oct 2008 10:33:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XlrskG6jaM7l; Wed, 22 Oct 2008 10:33:32 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id EB58A52C3D4;
	Wed, 22 Oct 2008 10:33:32 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 4627E6DFB71; Wed, 22 Oct 2008 10:32:17 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 458D64F9FA3; Wed, 22 Oct 2008 10:33:32 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98845>

Replace '.' with ',' in the test paths to keep the original intent, but
make the test runnable on systems where files named "a." cannot be
reliably created. The problem seems to be that a file created as "a."
will end up as "a" on disk.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../jgit/treewalk/FileTreeIteratorTest.java        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

 With this all the tests pass on my Windows installation.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java
index ca31991..967557e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/FileTreeIteratorTest.java
@@ -47,7 +47,7 @@
 import org.spearce.jgit.util.RawParseUtils;
 
 public class FileTreeIteratorTest extends RepositoryTestCase {
-	private final String[] paths = { "a.", "a.b", "a/b", "a0b" };
+	private final String[] paths = { "a,", "a,b", "a/b", "a0b" };
 
 	private long[] mtime;
 
-- 
1.6.0.2.1166.g8d97a.dirty

-- 
Jonas Fonseca
