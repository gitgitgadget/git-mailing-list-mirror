From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 15/19] fsck: Document the new receive.fsck.* options.
Date: Wed, 21 Jan 2015 20:27:05 +0100
Organization: gmx
Message-ID: <15f7d22f08fe590c3a1e5b2bf524dc2877624ca2.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0vy-0003YU-W9
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbbAUT1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:27:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:52684 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbbAUT1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:27:12 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lm7MT-1XeOzo3Jsv-00Zd9E; Wed, 21 Jan 2015 20:27:05
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:1gH1g3s9VS1zN0bt4Gmoq5nOKE9P3lrRUJus4mpUc9248UWG2Ul
 A0vWiVfC70VryGdVRSa/I89u5obH9bP82n3nUn6/FiuWrGZbtlnEg/M9K/WN3/o6qPxUXwj
 4Gir0Qur07T3BGm/sJnHLuzaM53hYNRUVEJuWDkNEWgHrPpjRJL7Ck2IdDEcsrAglOzCjbF
 7r629Vp1BBtiJl2dQAvqw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262760>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..cc4cd91 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2130,6 +2130,34 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
+receive.fsck.error::
+receive.fsck.warn::
+receive.fsck.ignore::
+	When `receive.fsckObjects` is set to true, errors can be switched
+	to warnings and vice versa by configuring the `receive.fsck.*`
+	settings. These settings contain comma-separated lists of fsck
+	message IDs. For convenience, fsck prefixes the error/warning with
+	the message ID, e.g. "missing-email: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.ignore = missing-email` will hide that issue.
++
+--
+error;;
+	a comma-separated list of fsck message IDs that should be
+	trigger fsck to error out.
+warn;;
+	a comma-separated list of fsck message IDs that should be
+	displayed, but fsck should continue to error out.
+ignore;;
+	a comma-separated list of fsck message IDs that should be
+	ignored completely.
+--
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
