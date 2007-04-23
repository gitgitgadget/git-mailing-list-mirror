From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 2/4] Use the Git sort order.
Date: Tue, 24 Apr 2007 00:39:48 +0200
Organization: Dewire
Message-ID: <200704240039.48892.robin.rosenberg.lists@dewire.com>
References: <20070422212907.26396.12810.stgit@lathund.dewire.com> <20070422213602.26396.59463.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Apr 24 00:40:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg7CU-0004iw-0y
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 00:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422AbXDWWj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbXDWWj7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 18:39:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25096 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754421AbXDWWj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 18:39:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9776F8028A0;
	Tue, 24 Apr 2007 00:34:04 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07635-03; Tue, 24 Apr 2007 00:34:04 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 24674802873;
	Tue, 24 Apr 2007 00:34:04 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070422213602.26396.59463.stgit@lathund.dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45372>

Oops, lost the decoration here.

-- robin

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit
/core/project/GitProjectData.java
index 0c4683e..5c250c0 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -274,11 +274,11 @@ public class GitProjectData {
                return (RepositoryMapping) c2mapping.get(r);
        }

-       public TreeEntry[] getActiveDiffTreeEntries(IResource r)
+       public TreeEntry[] getActiveDiffTreeEntries(IResource res)
                        throws CoreException {
                String s = null;
                RepositoryMapping m = null;
-
+               IResource r = res;
                while (r != null) {
                        m = getRepositoryMapping(r);
                        if (m != null) {
@@ -296,7 +296,7 @@ public class GitProjectData {

                if (s != null && m != null && m.getActiveDiff() != null) {
                        try {
-                               if (r.getType() == IResource.FILE)
+                               if (res.getType() == IResource.FILE)
                                        return m.getActiveDiff().findBlobMember(s);
                                else
                                        return m.getActiveDiff().findTreeMember(s);
