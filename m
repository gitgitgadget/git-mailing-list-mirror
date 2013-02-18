From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 1/9] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 17 Feb 2013 19:15:53 -0500
Message-ID: <0016ba69f4157996dfbe66938056c4192bed62c1.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EPP-0000V7-CC
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757389Ab3BRAQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:14 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:65233 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3BRAQN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:13 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00F403EV3280@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:08 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0B4A388564F; Sun,
 17 Feb 2013 19:16:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146567; bh=UuFyVFQMEgJNn/Rf56cVwX7/tsMDfGu+C+7vHAsSmH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=bYJDf4SB2sOXuBvMyZFuOEH+9C0pbp4Eg6jXvLWnZXpnKxNbE6lI8vENa/iHF/G/3
 Oo33QPvVc8dIEyKpZa681zy+fjS/qkPAPzN9tk6yyVTEUyKzba1msgekSk6p/rNYKg
 KUZcFA+TBG1lqTszgNbK3hZoiM3r+scXWiGI7rbQ=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216413>

From: "W. Trevor King" <wking@tremily.us>

There is no need to use here documents to setup this configuration.
It is easier, less confusing, and more robust to use `git remote add`
directly.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5077e7c..a060eb6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1998,16 +1998,21 @@ will not be updated by the push.  This may lead to unexpected results if
 the branch you push to is the currently checked-out branch!
 
 As with `git fetch`, you may also set up configuration options to
-save typing; so, for example, after
+save typing; so, for example:
+
+-------------------------------------------------
+$ git remote add public-repo ssh://yourserver.com/~you/proj.git
+-------------------------------------------------
+
+adds the following to `.git/config`:
 
 -------------------------------------------------
-$ cat >>.git/config <<EOF
 [remote "public-repo"]
-	url = ssh://yourserver.com/~you/proj.git
-EOF
+	url = yourserver.com:proj.git
+	fetch = +refs/heads/*:refs/remotes/example/*
 -------------------------------------------------
 
-you should be able to perform the above push with just
+which lets you do the same push with just
 
 -------------------------------------------------
 $ git push public-repo master
-- 
1.8.1.336.g94702dd
