From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/9] Switch jgit.pgm to J2SE-1.5 execution environment
Date: Fri, 25 Jul 2008 12:45:59 -0700
Message-ID: <1217015167-4680-2-git-send-email-spearce@spearce.org>
References: <1217015167-4680-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:47:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTFx-0005XG-IP
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbYGYTqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYGYTqM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:46:12 -0400
Received: from george.spearce.org ([209.20.77.23]:45925 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYGYTqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:46:09 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 004533841A; Fri, 25 Jul 2008 19:46:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 50A36383A5;
	Fri, 25 Jul 2008 19:46:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
In-Reply-To: <1217015167-4680-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90097>

We have been keeping the jgit library itself on Java 5, and the
jgit command line tools should also be on Java 5 and avoid using
any Java 6 APIs (for now).  Not all of our target platforms have
a Java 6 virtual machine available out of the box.

Since the pgm project broke out of the library project our code
already conforms to Java 5 APIs, so we just have to switch the
build path settings.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.jgit.pgm/.classpath |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.pgm/.classpath b/org.spearce.jgit.pgm/.classpath
index cc861d2..50dd6d3 100644
--- a/org.spearce.jgit.pgm/.classpath
+++ b/org.spearce.jgit.pgm/.classpath
@@ -2,7 +2,7 @@
 <classpath>
 	<classpathentry kind="src" path="src"/>
 	<classpathentry exported="true" kind="lib" path="lib/args4j-2.0.9.jar" sourcepath="lib/args4j-2.0.9.zip"/>
-	<classpathentry exported="true" kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>
+	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/J2SE-1.5"/>
 	<classpathentry combineaccessrules="false" exported="true" kind="src" path="/org.spearce.jgit"/>
 	<classpathentry kind="output" path="bin"/>
 </classpath>
-- 
1.6.0.rc0.182.gb96c7
