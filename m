From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 15/18] fsck: Document the new receive.fsck.* options.
Date: Mon, 19 Jan 2015 16:51:44 +0100
Organization: gmx
Message-ID: <41d4880fc48ad39d4798c2f9a0cb38a6a41c41b3.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEjt-0006J3-2C
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbbASP72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:28 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751349AbbASP71 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:27 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFpimA026453;
	Mon, 19 Jan 2015 16:51:44 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFpiS7026452;
	Mon, 19 Jan 2015 16:51:44 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262619>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..7371a5f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2130,6 +2130,31 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
+receive.fsck.*::
+	When `receive.fsckObjects` is set to true, errors can be switched
+	to warnings and vice versa by configuring the `receive.fsck.*`
+	settings. These settings contain comma-separated lists of fsck
+	message IDs. For convenience, fsck prefixes the error/warning with
+	the message ID, e.g. "missing-email: invalid author/committer line
+	- missing email" means that setting `receive.fsck.ignore =
+	missing-email` will hide that issue.
++
+--
+	error::
+		a comma-separated list of fsck message IDs that should be
+		trigger fsck to error out.
+	warn::
+		a comma-separated list of fsck message IDs that should be
+		displayed, but fsck should continue to error out.
+	ignore::
+		a comma-separated list of fsck message IDs that should be
+		ignored completely.
++
+This feature is intended to support working with legacy repositories
+which would not pass pushing when `receive.fsckObjects = true`, allowing
+the host to accept repositories certain known issues but still catch
+other issues.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
-- 
2.0.0.rc3.9669.g840d1f9
