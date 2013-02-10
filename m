From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 15/15] user-manual: Use --format=tar.gz to create a gzipped
 tarball
Date: Sun, 10 Feb 2013 10:10:41 -0500
Message-ID: <92a02e35df3dab70928e56e6790417243beea2af.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZd-0000ov-IU
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760551Ab3BJPLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:44 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:46983 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772Ab3BJPLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:18 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000CO7FICJ100@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:04 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 5D8F18792AE; Sun,
 10 Feb 2013 10:11:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509062; bh=YQPAoGHW4YTcZhwv3fYE8vHk6aqnKWGgkaf3LfFqScI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=meeAcxBtwCGQmnTdSY43yEnkggkejuq8mqG5NLSdf51qX07QyTpeDSl8PVBKxVuOi
 Hx2XABcjeL/UT4vVbma9scC+PFaCAaeov8rzjSz70aZGYUd7IccDTdFNP6lafUBJ2A
 ClpFpimrvxpXrzFL7pscLZifRF1krYGlUsQJciz8=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215916>

From: "W. Trevor King" <wking@tremily.us>

This functionality was introduced by 0e804e09 (archive: provide
builtin .tar.gz filter, 2011-07-21) for v1.7.7.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8024758..c04ea51 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -931,12 +931,19 @@ The linkgit:git-archive[1] command can create a tar or zip archive from
 any version of a project; for example:
 
 -------------------------------------------------
-$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
+$ git archive --format=tar.gz --prefix=project/ HEAD >latest.tar.gz
 -------------------------------------------------
 
 will use HEAD to produce a tar archive in which each filename is
 preceded by `project/`.
 
+Versions of Git older than 1.7.7 don't know about the 'tar.gz' format,
+you'll need to use gzip explicitly:
+
+-------------------------------------------------
+$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
+-------------------------------------------------
+
 If you're releasing a new version of a software project, you may want
 to simultaneously make a changelog to include in the release
 announcement.
-- 
1.8.1.336.g94702dd
