From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 02/11] Use current "detached HEAD" message
Date: Tue, 27 Aug 2013 19:56:04 +0200 (CEST)
Message-ID: <1022906213.34401.1377626164272.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 19:56:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENUz-0003Lv-HK
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 19:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab3H0R4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 13:56:07 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52354 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753525Ab3H0R4G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 13:56:06 -0400
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mx.arcor.de (Postfix) with ESMTP id 49C83E3B7D;
	Tue, 27 Aug 2013 19:56:04 +0200 (CEST)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 470A510C00B;
	Tue, 27 Aug 2013 19:56:04 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 421EA9BE44;
	Tue, 27 Aug 2013 19:56:04 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net 421EA9BE44
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626164; bh=trcgUhMZ/YRCP2WrKiETGxSiSx8iBv1Nt8r6f1D1P9E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=kmaipfywQ4hlikkdU0km0uUe7AV5eZGNeSjvaARn2AG2hUmKeSlek0EXEUeCvwEau
	 ELBdPpxK8RNb4c3UdetZd5IlpJN0LrRWLus5aZzlFQR+F/fD4L/PuXduKFH/KlqCJ+
	 3A2PiX0trDucMgZEeOKNzBInmXhetMgxqmPCc3oU=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 19:56:04 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233122>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 103ec9a..bdefd9a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -312,10 +312,17 @@ referenced by a tag:
 
 ------------------------------------------------
 $ git checkout v2.6.17
-Note: moving to "v2.6.17" which isn't a local branch
-If you want to create a new branch from this checkout, you may do so
-(now or later) by using -b with the checkout command again. Example:
-  git checkout -b <new_branch_name>
+Note: checking out 'v2.6.17'.
+
+You are in 'detached HEAD' state. You can look around, make experimental
+changes and commit them, and you can discard any commits you make in this
+state without impacting any branches by performing another checkout.
+
+If you want to create a new branch to retain commits you create, you may
+do so (now or later) by using -b with the checkout command again. Example:
+
+  git checkout -b new_branch_name
+
 HEAD is now at 427abfa... Linux v2.6.17
 ------------------------------------------------
 
@@ -326,7 +333,7 @@ and git branch shows that you are no longer on a branch:
 $ cat .git/HEAD
 427abfa28afedffadfca9dd8b067eb6d36bac53f
 $ git branch
-* (no branch)
+* (detached from v2.6.17)
   master
 ------------------------------------------------
 
@@ -3639,7 +3646,7 @@ working on a branch.
 
 -------------------------------------------------
 $ git branch
-* (no branch)
+* (detached from d266b98)
   master
 -------------------------------------------------
 
-- 
1.8.3.msysgit.0


---
Thomas
