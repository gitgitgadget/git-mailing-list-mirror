From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 15/19] fsck: Document the new receive.fsck.<msg-id> options
Date: Mon, 22 Jun 2015 17:27:00 +0200
Organization: gmx
Message-ID: <9d82c4ab5c93d70b80e333833959f543ccc68ba0.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:27:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73d9-0007VW-50
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbbFVP1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:27:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:63871 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744AbbFVP1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:27:05 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LvlTo-1Z1k890d9o-017SdG; Mon, 22 Jun 2015 17:27:01
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:EN4cdP1jCv5gFcIWBFAYb9THSURs+e7+uKdZ2YVMG4Y+9cHPn+U
 Geay5jRL4GSH+viDJbuukQ6Gc9KL26hfO23MWlrCxiUywvSIw6Xs3XFYQYCUhxqWhJZO2bq
 c+p5LIWLGbk0WJ0AWJp4kxYJfY0fbwUSizoUTZPAvGtgcDzj90vf/mNw3d/fJOk1O6Q4TZ+
 bVw8DxgQ0Vf0Vwosh86BQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y9GKZeKwv0A=:cicJQMGsf2Zw8Rsu4F4M3J
 i16WJTUm0qqJx4fpeagWpheUUWVd6bkUzNGkc2VY3AzxP55QqM1UOIyhLVw6lysQBjw2iPyoU
 oLSE0HGMfpWKJ5Wc1HSS2A53c6/ilgOaHVojh9reFezb+0v4m7kq0wHK4j8njw5aIfRcfg2Wg
 PRRT5hzUkmoWyGXHW2dPLdDN1L1eBC8fhoKYdA1dT7HOHRQ1QGS7wiPZFviuyKUs8dZav8oTU
 Ywfhm63TRpiiMVzd1S6G6G967CtViwtlCILn6hlbmpiKMmvJbUqK0EpjBo+psUoSj7TCRYFhS
 vFOmA/669oiOVXaIZlqDShH3VCgF/jrZhVHbVBW0kP1jrYPoM6MFSq+AcVoNuWHWxbFW5JlZj
 BN8Av7NH9WkqH3STZEyLpfP/MnQ2hoIkE2ED2OrdVJVcKWm6iAhnW2x676NwBs3d+kk5Axq/F
 CeW4zNJNB7skNiBKt70z7vv2T1PoCkgEW4eY91vpQDlXZZECqrxpSuO22efR7zhhjSl0SyjjB
 nMXvSUyFB88+57vweZEbVbaFAlrc2puD40KGyOfS/NJEfQyQnKXZpLIAZU+Ug3e1d5wBUYToO
 RTTAOPDOGoyURbXwiYCvNAdHguqMw9Qc6/O6x0wqVH5immsz0/G0WXkgOoQboBY00yNGtYyoo
 E4RIZKmJpkateTaimEJ5NmqD5KdMrIEDRJxEVNSq5b59SNGKQQP/g7pjE08qOrKo10LQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272386>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..4e5fbea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2205,6 +2205,20 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
+receive.fsck.<msg-id>::
+	When `receive.fsckObjects` is set to true, errors can be switched
+	to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
+	setting where the `<msg-id>` is the fsck message ID and the value
+	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
+	the error/warning with the message ID, e.g. "missingEmail: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.missingEmail = ignore` will hide that issue.
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
2.3.1.windows.1.9.g8c01ab4
