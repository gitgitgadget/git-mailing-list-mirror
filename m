From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 6/9] enable missing test cases and fix jgit executable creation
Date: Wed, 23 Sep 2009 23:16:07 +0200
Message-ID: <1253740570-10718-6-git-send-email-struberg@yahoo.de>
References: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
 <1253740570-10718-2-git-send-email-struberg@yahoo.de>
 <1253740570-10718-3-git-send-email-struberg@yahoo.de>
 <1253740570-10718-4-git-send-email-struberg@yahoo.de>
 <1253740570-10718-5-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCM-0004af-85
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbZIWVQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbZIWVQG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:16:06 -0400
Received: from n6.bullet.re3.yahoo.com ([68.142.237.91]:46076 "HELO
	n6.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752878AbZIWVQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:16:00 -0400
Received: from [68.142.237.89] by n6.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:04 -0000
Received: from [216.252.111.169] by t5.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:04 -0000
Received: from [127.0.0.1] by omp104.mail.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:04 -0000
X-Yahoo-Newman-Id: 234652.47051.bm@omp104.mail.re3.yahoo.com
Received: (qmail 22263 invoked from network); 23 Sep 2009 21:16:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=NkFC/zKe5yq5Sh4AZLe9lZ9qj/DEm68yLrwYiiNUoVZdz5gVgqMZkVdxEXrJLHeBYxWRrw7GvtcKnGt00xRoMEIadxUnR2i4S1UydFRW8o0IMqh541HtZ67bWW6WBexLXxsXDPawXluJ+7aM9GYNox+RZwNso1VwHYDX4zBx5Ow=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:16:03 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: e7_TZZkVM1matrXW4KUOkKwaL4IY4VmcctlugmNbfadVWy2VkBCFGmhp3K0wI.J5DGrJKiEceGVkX2zVprBnpIihgmT.iuLtfIrFs17QmcxRTfldrDVcf_BG3JwdU3jqwINj36DQcd1nK32jW6lDV8OEIRFS.5Xy_W5QfarnhJfe6J4pUvdZHip8SW3HEfZdDBcTuznAnQV0XCVY9cYjozipneOHVng6zbe8DrMhZITks6MD80XYTAY.5ADDwOVeQK_.i9sAj4TwMb6.ycgMtq0TriioxoLm1KQ2pENvUgJUY_AA8.28J9ENPRqNdkA8lzPrfCh2cebIQGPWl1Naqn.cQKZmGFxtVug-
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1253740570-10718-5-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129001>

* enable the T000* tests in surefire

* fix the creation of the jgit executable by correcting the
use_self filtering and performing the copy task in binary mode

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 org.spearce.jgit.pgm/jgit.sh |    2 +-
 org.spearce.jgit.pgm/pom.xml |   12 +++++++++---
 org.spearce.jgit/pom.xml     |    5 +++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.pgm/jgit.sh b/org.spearce.jgit.pgm/jgit.sh
index 5e44356..6c101a0 100755
--- a/org.spearce.jgit.pgm/jgit.sh
+++ b/org.spearce.jgit.pgm/jgit.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-if [ "@@use_self@@" = "1" ]
+if [ "@use_self@" = "1" ]
 then
 	this_script=`which "$0" 2>/dev/null`
 	[ $? -gt 0 -a -f "$0" ] && this_script="$0"
diff --git a/org.spearce.jgit.pgm/pom.xml b/org.spearce.jgit.pgm/pom.xml
index ab399e5..47dfbf1 100644
--- a/org.spearce.jgit.pgm/pom.xml
+++ b/org.spearce.jgit.pgm/pom.xml
@@ -102,11 +102,17 @@
 						<phase>package</phase>
 						<configuration>
 							<tasks>
-								<concat destfile="${basedir}/jgit" force="no">
-									<fileset file="${basedir}/jgit.sh" />
+								<copy todir="${basedir}/target/">
+									<fileset file="${basedir}/jgit.sh"/>
+									<filterset>
+										<filter token="use_self" value="1"/>
+									</filterset>
+								</copy>
+								<concat destfile="${basedir}/target/jgit" force="yes" binary="true">
+									<fileset file="${basedir}/target/jgit.sh" />
 									<fileset file="${basedir}/target/jgit-cli.jar" />
 								</concat>
-								<chmod file="${basedir}/jgit" perm="a+x"/>
+								<chmod file="${basedir}/target/jgit" perm="a+x"/>
 							</tasks>
 						</configuration>
 						<goals>
diff --git a/org.spearce.jgit/pom.xml b/org.spearce.jgit/pom.xml
index eb01e16..f565dda 100644
--- a/org.spearce.jgit/pom.xml
+++ b/org.spearce.jgit/pom.xml
@@ -107,6 +107,10 @@
 						<groupId>org.apache.maven.plugins</groupId>
 						<artifactId>maven-surefire-plugin</artifactId>
 						<configuration>
+                            <includes>
+                                <include>**/*Test.java</include>
+                                <include>**/T00*.java</include>
+                            </includes>
 							<excludes>
 								<exclude>**/*TckTest.java</exclude>
 							</excludes>
@@ -125,6 +129,7 @@
 						<configuration>
 							<includes>
 								<include>**/*Test.java</include>
+                                <include>**/T00*.java</include>
 							</includes>
 						</configuration>
 					</plugin>
-- 
1.6.2.5
