From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 7/7] FindBugs: Disable clone() idiom tests
Date: Mon,  4 May 2009 16:30:48 -0700
Message-ID: <1241479848-20687-7-git-send-email-spearce@spearce.org>
References: <1241479848-20687-1-git-send-email-spearce@spearce.org>
 <1241479848-20687-2-git-send-email-spearce@spearce.org>
 <1241479848-20687-3-git-send-email-spearce@spearce.org>
 <1241479848-20687-4-git-send-email-spearce@spearce.org>
 <1241479848-20687-5-git-send-email-spearce@spearce.org>
 <1241479848-20687-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Matthias Sohn <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Tue May 05 01:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M17dK-00068Y-R1
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 01:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbZEDXbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 19:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbZEDXa6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 19:30:58 -0400
Received: from george.spearce.org ([209.20.77.23]:52551 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbZEDXav (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 19:30:51 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 67D5038196; Mon,  4 May 2009 23:30:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C478438197;
	Mon,  4 May 2009 23:30:50 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc4.206.g03e16
In-Reply-To: <1241479848-20687-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118275>

We tend not to implement Cloneable, but instead define our own
form of clone() on objects that we want to permit making clones
of.  This is because Cloneable is a rather poor interface in
the JVM with its implicit field copying, but the method name
is the right name for us.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.jgit/.fbprefs |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/.fbprefs b/org.spearce.jgit/.fbprefs
index d6f94c3..81a0767 100644
--- a/org.spearce.jgit/.fbprefs
+++ b/org.spearce.jgit/.fbprefs
@@ -1,5 +1,5 @@
 #FindBugs User Preferences
-#Mon May 04 20:17:32 CEST 2009
+#Mon May 04 16:24:13 PDT 2009
 detectorAppendingToAnObjectOutputStream=AppendingToAnObjectOutputStream|true
 detectorBadAppletConstructor=BadAppletConstructor|false
 detectorBadResultSetAccess=BadResultSetAccess|true
@@ -10,7 +10,7 @@ detectorBooleanReturnNull=BooleanReturnNull|true
 detectorCallToUnsupportedMethod=CallToUnsupportedMethod|true
 detectorCheckImmutableAnnotation=CheckImmutableAnnotation|true
 detectorCheckTypeQualifiers=CheckTypeQualifiers|true
-detectorCloneIdiom=CloneIdiom|true
+detectorCloneIdiom=CloneIdiom|false
 detectorComparatorIdiom=ComparatorIdiom|true
 detectorConfusedInheritance=ConfusedInheritance|true
 detectorConfusionBetweenInheritedAndOuterMethod=ConfusionBetweenInheritedAndOuterMethod|true
-- 
1.6.3.rc4.206.g03e16
