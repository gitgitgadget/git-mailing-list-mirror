From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 07/15] user-manual: Mention 'git remote add' for remote
 branch config
Date: Sun, 10 Feb 2013 10:10:33 -0500
Message-ID: <1e3996dff5c19010aca1458b202b14cbb54b5d80.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Ya5-00015X-2k
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760883Ab3BJPL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:57 -0500
Received: from vms173007pub.verizon.net ([206.46.173.7]:38034 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772Ab3BJPLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:55 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000E1ZFIDFXA0@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:32 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 9B4CF879286; Sun,
 10 Feb 2013 10:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509060; bh=xvaJls/R2PwgVvBPBiSmape2OidMCT8TuXmLUF9NHc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=oX+rmH3XZo2ypLFjA/KQ0QCxJ3yyQjGoBxfsTT9/HC/7bk4kwDLTMC9EBsF+NlQiZ
 EIFsCbkt0vlCQvOOhmdv0ywPsjzLodaKG239Iy49gN6+BCNU2xWXkX8i+lnxL1XpuJ
 6wxB8r326y0Ry42dU37/X0SBbC0VTLMQO1SxDRxc=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215918>

From: "W. Trevor King" <wking@tremily.us>

I hardly ever setup remote.<name>.url using 'git config'.  While it
may be instructive to do so, we should also point out 'git remote
add'.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a68d6b9..424cdd6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2909,8 +2909,23 @@ Also note that all of the above configuration can be performed by
 directly editing the file .git/config instead of using
 linkgit:git-config[1].
 
+You can produce a similar configuration with:
+
+-------------------------------------------------
+$ git remote add example git://example.com/proj.git
+-------------------------------------------------
+
+which adds the following stanza to `.git/config`:
+
+-------------------------------------------------
+[remote "example"]
+        url = git://example.com/proj.git
+        fetch = +refs/heads/*:refs/remotes/example/*
+-------------------------------------------------
+
 See linkgit:git-config[1] for more details on the configuration
-options mentioned above.
+options mentioned above and linkgit:git-fetch[1] for more details on
+the refspec syntax.
 
 
 [[git-concepts]]
-- 
1.8.1.336.g94702dd
