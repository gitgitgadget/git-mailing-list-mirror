From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 04/11] Use "git merge" instead of "git pull ."
Date: Tue, 27 Aug 2013 19:58:18 +0200 (CEST)
Message-ID: <1685937666.34465.1377626298173.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 19:58:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENX5-00052T-MU
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 19:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab3H0R6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 13:58:19 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:57258 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752196Ab3H0R6T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 13:58:19 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 3B6693AE4A2;
	Tue, 27 Aug 2013 19:58:18 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 352353481FC;
	Tue, 27 Aug 2013 19:58:18 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 2A2912D684B;
	Tue, 27 Aug 2013 19:58:18 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-10.arcor-online.net 2A2912D684B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626298; bh=KWPih8z3FR5zDeBey/EvQzbgczalWtBA0Ll6Ix4S9VY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=r6rQ6VnE9nH1sqVaxp6SIP4640nWklT3SbO7XUeDNRvUaX5esdgr/XljDV6edXQao
	 Bzxjp7VKWTb+qZdV18cJ1ReNQh+nYy4mvBkLtFVEpQiGcUYBtSUrUC/gVH+fu1f7RC
	 rKkW7qqQtAcC0WV5ZCyvqw2HlxBakpco0oTkj2C4=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 19:58:18 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233124>


"git pull ." works, but "git merge" is the recommended
way for new users to do things. (The old description
also should have read "The former is actually *not* very
commonly used".)

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3f44ca0..6241a43 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1793,7 +1793,7 @@ $ git pull . branch
 $ git merge branch
 -------------------------------------------------
 
-are roughly equivalent.  The former is actually very commonly used.
+are roughly equivalent.
 
 [[submitting-patches]]
 Submitting patches to a project
@@ -2255,11 +2255,11 @@ commit to this branch.
 $ ... patch ... test  ... commit [ ... patch ... test ... commit ]*
 -------------------------------------------------
 
-When you are happy with the state of this change, you can pull it into the
+When you are happy with the state of this change, you can merge it into the
 "test" branch in preparation to make it public:
 
 -------------------------------------------------
-$ git checkout test && git pull . speed-up-spinlocks
+$ git checkout test && git merge speed-up-spinlocks
 -------------------------------------------------
 
 It is unlikely that you would have any conflicts here ... but you might if you
@@ -2271,7 +2271,7 @@ see the value of keeping each patch (or patch series) in its own branch.  It
 means that the patches can be moved into the `release` tree in any order.
 
 -------------------------------------------------
-$ git checkout release && git pull . speed-up-spinlocks
+$ git checkout release && git merge speed-up-spinlocks
 -------------------------------------------------
 
 After a while, you will have a number of branches, and despite the
-- 
1.8.3.msysgit.0


---
Thomas
