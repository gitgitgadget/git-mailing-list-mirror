From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 13/13] "git prune" is safe now
Date: Sat, 24 Aug 2013 09:37:52 +0200 (CEST)
Message-ID: <1590776724.1091303.1377329872606.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de,
	peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8Q2-0004nw-3V
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab3HXHhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:37:54 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:54365 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754875Ab3HXHhx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:37:53 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id A22CC5B7D4;
	Sat, 24 Aug 2013 09:37:52 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 9D9E4562D1D;
	Sat, 24 Aug 2013 09:37:52 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 9B34239A001;
	Sat, 24 Aug 2013 09:37:52 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-10.arcor-online.net 9B34239A001
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329872; bh=iMWqgYNLQpj9NKRmz3idd8DLqAygODZyqNZx+aooo6M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=tsUSnAHyCo9cyZOhGmin82yoRY3pTHJJI3M2Ud9/EA6WhE/Ymb/vQWdK+kugpC/5O
	 mdAcW2edhC5aAyBw8c+sCciEioAEV/5v0xzc3LSxHtn6XRm00K55SpbYWit4ysdpiv
	 JlDQ+gMDivOS3hm3rYFJG1KkNHuYyixs8EEVbO4g=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:37:52 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232880>


According to the man-pages of "git prune" and "git fsck",
both are safe nowadays.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 08d8c91..29945d9 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3283,17 +3283,7 @@ state, you can just prune all unreachable objects:
 $ git prune
 ------------------------------------------------
 
-and they'll be gone. But you should only run `git prune` on a quiescent
-repository--it's kind of like doing a filesystem fsck recovery: you
-don't want to do that while the filesystem is mounted.
-
-(The same is true of `git fsck` itself, btw, but since
-`git fsck` never actually *changes* the repository, it just reports
-on what it found, `git fsck` itself is never 'dangerous' to run.
-Running it while somebody is actually changing the repository can cause
-confusing and scary messages, but it won't actually do anything bad. In
-contrast, running `git prune` while somebody is actively changing the
-repository is a *BAD* idea).
+and they'll be gone. 
 
 [[recovering-from-repository-corruption]]
 Recovering from repository corruption
-- 
1.8.3.msysgit.0


---
Thomas
