From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 9/9] user-manual: Use -o latest.tar.gz to create a gzipped
 tarball
Date: Sun, 17 Feb 2013 19:16:01 -0500
Message-ID: <27dea793fc101f8bd148385b753997867b987658.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:17:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EQ9-0000ml-MX
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422Ab3BRAQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:48 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:53018 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322Ab3BRAQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:43 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00IOM3EXZV30@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:30 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 924EE885676; Sun,
 17 Feb 2013 19:16:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146568; bh=/pdA0Z0Xlx64u5nBrQ+C2VgryneF/7JpvJhu0MEK63c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=GdsT0eoMAAjkfLRV+R7D+ygTAncUcxJv9muYjEfRQACjbLuqQ0Kgr/6IGrgceTJlO
 TNkG3XH8w4GjQHNa747WQ+QauoWcDBccYgWjTpj5jmEhStf6YtAhNXcHYOS+b3luRF
 Q+BdCfcPr8sFgWqSbk1au5J9hc1Ke5z0rNoJAtFQ=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216421>

From: "W. Trevor King" <wking@tremily.us>

This functionality was introduced by 0e804e09 (archive: provide
builtin .tar.gz filter, 2011-07-21) for v1.7.7.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3381c22..af6c09d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -931,11 +931,20 @@ The linkgit:git-archive[1] command can create a tar or zip archive from
 any version of a project; for example:
 
 -------------------------------------------------
-$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
+$ git archive -o latest.tar.gz --prefix=project/ HEAD
 -------------------------------------------------
 
-will use HEAD to produce a tar archive in which each filename is
-preceded by `project/`.
+will use HEAD to produce a gzipped tar archive in which each filename
+is preceded by `project/`.  The output file format is inferred from
+the output file extension if possible, see linkgit:git-archive[1] for
+details.
+
+Versions of Git older than 1.7.7 don't know about the 'tar.gz' format,
+you'll need to use gzip explicitly:
+
+-------------------------------------------------
+$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
+-------------------------------------------------
 
 If you're releasing a new version of a software project, you may want
 to simultaneously make a changelog to include in the release
-- 
1.8.1.336.g94702dd
