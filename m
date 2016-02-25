From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/5] Documentation/diff-config: fix description of diff.renames
Date: Thu, 25 Feb 2016 09:59:17 +0100
Message-ID: <1456390761-27015-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
 <1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, peff@peff.net,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 10:00:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYrmB-0007zy-TE
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 10:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759594AbcBYI7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:59:37 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36099 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758272AbcBYI7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:59:36 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8xOIa016241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 09:59:24 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1P8xP50010992;
	Thu, 25 Feb 2016 09:59:25 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456390761-27015-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 09:59:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1P8xOIa016241
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456995569.05638@lEkHrPEs920DDQDWq9ou8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287348>

The description was misleading, since "set to any boolean value" include
"set to false", and diff.renames=false does not enable basic detection,
but actually disables it. Also, document that diff.renames only affects
Porcelain.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/diff-config.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6eaa452..40e5de9 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -108,9 +108,13 @@ diff.renameLimit::
 	detection; equivalent to the 'git diff' option '-l'.
 
 diff.renames::
-	Tells Git to detect renames.  If set to any boolean value, it
-	will enable basic rename detection.  If set to "copies" or
-	"copy", it will detect copies, as well.
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enable.  If set to "copies" or "copy", Git will
+	detect copies, as well.  Defaults to false.  Note that this
+	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
+	linkgit:git-log[1], and not lower level commands such as
+	linkgit:git-diff-files[1].
 
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
-- 
2.7.2.334.g35ed2ae.dirty
