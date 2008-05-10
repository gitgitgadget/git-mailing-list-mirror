From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 02/22] Replaced Java 6 API useage with Java 5 equivalent.
Date: Sat, 10 May 2008 15:00:20 +0200
Message-ID: <1210424440-13886-3-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juohm-0007ej-8B
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbYEJNAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755500AbYEJNAp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:00:45 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49340 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbYEJNAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:43 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4BE3ADA5014B
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:42 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogr-000860-01; Sat, 10 May 2008 15:00:41 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/iBDnFNr/9QlFTomPPCwZJtwY6eSEtA+m8MZDX
	jG/sFnZfseFhoKDQ6Gb8IaSj1eADDxOjpXaN3BwGaK8bvWqrLv
	afkPwDMiU9jVjspKXCPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81665>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/pgm/MainProgram.java      |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
index 72b0156..69cd96f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
@@ -17,7 +17,6 @@
 package org.spearce.jgit.pgm;
 
 import java.io.IOException;
-import java.util.Arrays;
 import java.util.Collections;
 import java.util.HashMap;
 import java.util.Map;
@@ -59,8 +58,11 @@ public class MainProgram {
 			if (command == null) {
 				throw new WrongCallException("Require one argument!");
 			}
-			final String[] commandArguments = Arrays.copyOfRange(args, 1,
-					args.length);
+
+			final String[] commandArguments = new String[args.length - 1];
+			System.arraycopy(args, 1, commandArguments, 0,
+					commandArguments.length);
+
 			command.execute(commandArguments);
 
 		} catch (WrongCallException e) {
-- 
1.5.2.5
