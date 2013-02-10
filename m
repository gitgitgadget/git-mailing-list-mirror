From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 12/15] user-manual: Use request-pull to generate
 "please pull" text
Date: Sun, 10 Feb 2013 10:10:38 -0500
Message-ID: <3d860e7c19b33ebc2725eb86ec481f966e3007de.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZK-0000Zz-8z
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760773Ab3BJPL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:28 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:46983 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759215Ab3BJPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:21 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000ACGFIE6410@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:17 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id C99C08792A0; Sun,
 10 Feb 2013 10:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509061; bh=tryQA66AkzJF4b47BL9Wko841jNDINpO5wRYD76yQxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=iuEvDHYHe+OOq13R6Q9FZbUXha9UEXepPzevTeRJ4vVpER+K6DhiwTvLHBf72ELCP
 p0mD/QRMu15K1krQOouZ8AB+Ml1DNQOZ0lNdyZb3Kna5ROM8iCEjac9W9DJs91GDp9
 7rBYYJe+2fjbJtlTd+eThGc+M6Ab4+ti3V4tyi5g=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215909>

From: "W. Trevor King" <wking@tremily.us>

Less work and more error checking (e.g. does a merge base exist?).

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 31054a2..6446791 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2298,17 +2298,14 @@ these changes, just apply directly to the `release` branch, and then
 merge that into the `test` branch.
 
 To create diffstat and shortlog summaries of changes to include in a "please
-pull" request to Linus you can use:
+pull" request to Linus you can use linkgit:git-request-pull[1]:
 
 -------------------------------------------------
-$ git diff --stat origin..release
+$ git request-pull origin git://example.com/proj.git release
 -------------------------------------------------
 
-and
-
--------------------------------------------------
-$ git log -p origin..release | git shortlog
--------------------------------------------------
+where the `git://` URL points to your <<public-repositories,public
+repository>>.
 
 Here are some of the scripts that simplify all this even further.
 
-- 
1.8.1.336.g94702dd
