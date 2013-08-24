From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 09/13] Improve section "Merge multiple trees"
Date: Sat, 24 Aug 2013 09:32:25 +0200 (CEST)
Message-ID: <1473018875.1091101.1377329545934.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:32:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8Kl-0004za-01
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab3HXHc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:32:27 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:41184 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab3HXHc0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:32:26 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id EF46326EEF;
	Sat, 24 Aug 2013 09:32:25 +0200 (CEST)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id EA03621204A;
	Sat, 24 Aug 2013 09:32:25 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id E5CC79BE5A;
	Sat, 24 Aug 2013 09:32:25 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-14.arcor-online.net E5CC79BE5A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329545; bh=qIuAMPF5Zlx3f5Eckia2ymLu/gpgHVIJXxE/H8iQsGo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=c5UZsZcdfmiSqUuzvzjVrx0SaXEJb2LcH4eTmCt2iZ1tE5oZrMxzdM84UvoFs5a+E
	 +J5wFwaTO30uLnDfeSM1fqbIGzyRQ/oC5AD90yoDvWOtToEZZiU/d4wRhL6IB/i5ha
	 VzDS6xSjWHCtQGHu+VEoRhvyOqm/jDI6zfYcWUb0=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:32:25 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232876>


Remove unnecessary quoting.
Simplify description of three-way merge.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d5baf03..f713f26 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3992,16 +3992,16 @@ Merging multiple trees
 
 Git helps you do a three-way merge, which you can expand to n-way by
 repeating the merge procedure arbitrary times until you finally
-"commit" the state.  The normal situation is that you'd only do one
+commit the state.  The normal situation is that you'd only do one
 three-way merge (two parents), and commit it, but if you like to, you
 can do multiple parents in one go.
 
-To do a three-way merge, you need the two sets of "commit" objects
+To do a three-way merge, you need the two commit objects
 that you want to merge, use those to find the closest common parent (a
-third "commit" object), and then use those commit objects to find the
-state of the directory ("tree" object) at these points.
+third commit object: the merge base), and then use those commit objects to find the
+state of the directory (i.e. tree object) at these points.
 
-To get the "base" for the merge, you first look up the common parent
+To get the base for the merge, you first look up the common parent
 of two commits with
 
 -------------------------------------------------
@@ -4009,8 +4009,8 @@ $ git merge-base <commit1> <commit2>
 -------------------------------------------------
 
 which will return you the commit they are both based on.  You should
-now look up the "tree" objects of those commits, which you can easily
-do with (for example)
+now look up the tree objects of those commits, which you can easily
+do with
 
 -------------------------------------------------
 $ git cat-file commit <commitname> | head -1
-- 
1.8.3.msysgit.0


---
Thomas
