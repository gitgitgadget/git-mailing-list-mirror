From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 15/19] fsck: Document the new receive.fsck.severity
 options.
Date: Sat, 31 Jan 2015 22:06:03 +0100
Organization: gmx
Message-ID: <4fb8d36a862fb5363b70e9d7bebd3577101be953.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:06:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfFD-0004lr-O4
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbbAaVGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:06:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:52506 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbAaVGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:06:13 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M9K5G-1YNl6Q1gIo-00CiAe; Sat, 31 Jan 2015 22:06:04
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:rFdCxY6N227rEeF9SaMHLCqgkSOeBhxVLmfGbe9Z2WF6EZQC5JU
 uXRKQh5W/JfGKIe7AXmsxAR2DpgTZu+Yi4vRBYp3a6UAfJ1UXJGNN3eS8mO4BcA0MO/ROLG
 blUNpWTgXed9exvVXl8v8r360jsxA+NkxDEl3THaD8v17/8aknJfKXkbzNz25ml+Cd1Bqu5
 BuObvg9Dh1Xq1xdP3Lz0Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263221>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..f893492 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2130,6 +2130,21 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
+receive.fsck.severity::
+	When `receive.fsckObjects` is set to true, errors can be switched
+	to warnings and vice versa by configuring the `receive.fsck.severity`
+	setting. These settings contain comma-separated lists of the form
+	`<id>=<level>` where the `<id>` is the fsck message ID and the level
+	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
+	the error/warning with the message ID, e.g. "missing-email: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.severity = missing-email=ignore` will hide that issue.
++
+This feature is intended to support working with legacy repositories
+which would not pass pushing when `receive.fsckObjects = true`, allowing
+the host to accept repositories with certain known issues but still catch
+other issues.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
-- 
2.2.0.33.gc18b867
