From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 04/13] Use "git merge" instead of "git pull ."
Date: Sat, 24 Aug 2013 09:27:43 +0200 (CEST)
Message-ID: <694030462.1090937.1377329263413.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8GD-0005sJ-As
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab3HXH1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:27:45 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:42662 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755188Ab3HXH1p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:27:45 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id 76D5035A354;
	Sat, 24 Aug 2013 09:27:43 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 72E5118BD5;
	Sat, 24 Aug 2013 09:27:43 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 6E1C239A001;
	Sat, 24 Aug 2013 09:27:43 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-10.arcor-online.net 6E1C239A001
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329263; bh=66hYBkti33gj/qUFpb86PC5DrZVLteLOHoFICGOCz7s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=EwCLyhPyEaUkr7xsOFt79I00nhUGo9yuVcw5uYN9WCVCRKnb0xd0i46yUiQnJHNoa
	 K01sHcTyCLVQlEbjsFxKBL7NVRWJhcOnM8EVKpSWjcnykRMWdM1uQFKoqQMq7u7MPn
	 8FNGHHCnWtYJK76yEL7PKSuFI4Lh/9zY2vSWXy4g=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:27:43 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232871>


"git pull ." works, but "git merge" is the recommended
way for new users to do things. (The old description 
also should have read "The former is actually *not* very
commonly used".)

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b450980..8a1a441 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1784,17 +1784,6 @@ repository that you pulled from.
 <<fast-forwards,fast-forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
-The `git pull` command can also be given `.` as the "remote" repository,
-in which case it just merges in a branch from the current repository; so
-the commands
-
--------------------------------------------------
-$ git pull . branch
-$ git merge branch
--------------------------------------------------
-
-are roughly equivalent.  The former is actually very commonly used.
-
 [[submitting-patches]]
 Submitting patches to a project
 -------------------------------
@@ -2259,7 +2248,7 @@ When you are happy with the state of this change, you can pull it into the
 "test" branch in preparation to make it public:
 
 -------------------------------------------------
-$ git checkout test && git pull . speed-up-spinlocks
+$ git checkout test && git merge speed-up-spinlocks
 -------------------------------------------------
 
 It is unlikely that you would have any conflicts here ... but you might if you
@@ -2271,7 +2260,7 @@ see the value of keeping each patch (or patch series) in its own branch.  It
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
