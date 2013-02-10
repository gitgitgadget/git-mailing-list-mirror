From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 03/15] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 10 Feb 2013 10:10:29 -0500
Message-ID: <44d89e81a8465d3bbf50b106a8a844c9d90ac384.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZ4-0000Sa-3O
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758534Ab3BJPLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:03 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:39085 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab3BJPLC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:02 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000C3DFICRMA0@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:01 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id BE331879272; Sun,
 10 Feb 2013 10:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509059; bh=6N+JH5lYMmxL11RAIOyctejaaCH6+lLXJQPY9DnbAa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=YuokfV+x/H0Px1GSUQlrzy/KXKXE9Ue2K+Uuf7MnIJaBDEAmpSvlqva9Wttw+8ulI
 QJewIEFJ07vryVBiy1H1Z9X/6CwKEoMsZKWbCHXyT/yuykUMZ4p/WgMAxhPJuvVQYj
 nRcyWbMchmh1YJidfEAw2wdLWH/pR6FM1kzKxu9s=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215906>

From: "W. Trevor King" <wking@tremily.us>

There is no need to use here documents to setup this configuration.
It is easier, less confusing, and more robust to use Git's
configuration tools directly.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8524c08..53f73c3 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1994,14 +1994,17 @@ default.  See the description of the receive.denyCurrentBranch option
 in linkgit:git-config[1] for details.
 
 As with `git fetch`, you may also set up configuration options to
-save typing; so, for example, after
+save typing; so, for example, after either
 
--------------------------------------------------
-$ cat >>.git/config <<EOF
-[remote "public-repo"]
-	url = ssh://yourserver.com/~you/proj.git
-EOF
--------------------------------------------------
+------------------------------------------------
+$ git remote add public-repo ssh://yourserver.com/~you/proj.git
+------------------------------------------------
+
+or, more explicitly,
+
+------------------------------------------------
+$ git config remote.public-repo.url ssh://yourserver.com/~you/proj.git
+------------------------------------------------
 
 you should be able to perform the above push with just
 
-- 
1.8.1.336.g94702dd
