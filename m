From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 15/18] Document the new receive.fsck.* options.
Date: Mon, 8 Dec 2014 17:15:29 +0100 (CET)
Message-ID: <78b9db79bd0b2c17e74b18d689d473861d44e405.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yY-0006Yo-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbaLHQPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:52305 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908AbaLHQPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:49 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0Lz0aC-1XtSZl3tPU-0149I7;
 Mon, 08 Dec 2014 17:15:29 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:eCYXm++UWbY9iK0WFD8liuvRuJOleJIgSKpxTDSRvec5en47Qbl
 GwFA0f96dTyHhevdPOyL5PHz8Vn3HNZFAiA7Fdks7EIiuwJInMqJ4to7LPRoz5qt+VkimUv
 W0pWYAVt/L7Wpmk4W0iM1dtGMf6dYfYb5duuhdu3n8aKjINC2rE5uSqXI1ZOF2WJb7wL/WA
 7WCgxiqufiiKsPElr72Vw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261071>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7deae0b..b3276ee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2109,6 +2109,20 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
+receive.fsck.*::
+	When `receive.fsckObjects is set to true, errors can be switched
+	to warnings and vice versa by setting e.g. `receive.fsck.bad-name`
+	to `warn` or `error` (or `ignore` to hide those errors
+	completely). For convenience, fsck prefixes the error/warning
+	with the name of the option, e.g. "missing-email: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.missing-email` to `ignore` will hide that issue.
+	For convenience, camelCased options are accepted, too (e.g.
+	`receive.fsck.missingEmail`).
++
+This feature is intended to support working with legacy repositories
+which would not pass pushing when `receive.fsckObjects = true`.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
-- 
2.0.0.rc3.9669.g840d1f9
