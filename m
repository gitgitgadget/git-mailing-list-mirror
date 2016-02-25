From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2.1] Documentation/diff-config: fix description of diff.renames
Date: Thu, 25 Feb 2016 18:37:58 +0100
Message-ID: <1456421878-443-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1456390761-27015-2-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 18:38:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYzrl-0003pn-OW
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933369AbcBYRiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 12:38:09 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43182 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933304AbcBYRiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:38:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1PHc0m4018682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 18:38:00 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1PHc2Ht023862;
	Thu, 25 Feb 2016 18:38:02 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456390761-27015-2-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 18:38:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1PHc0m4018682
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1457026682.34351@W+nd0VB0ix9tikvUBuGmEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287404>

The description was misleading, since "set to any boolean value" include
"set to false", and diff.renames=false does not enable basic detection,
but actually disables it. Also, document that diff.renames only affects
Porcelain.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Oops, trivial fix for typo noticed by Felipe. I'm resending just this
one in case Junio wants to pick the latest version but I can obviously
resend the whole if needed.

 Documentation/diff-config.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6eaa452..b5e9bda 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -108,9 +108,13 @@ diff.renameLimit::
 	detection; equivalent to the 'git diff' option '-l'.
 
 diff.renames::
-	Tells Git to detect renames.  If set to any boolean value, it
-	will enable basic rename detection.  If set to "copies" or
-	"copy", it will detect copies, as well.
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled.  If set to "true", basic rename
+	detection is enabled.  If set to "copies" or "copy", Git will
+	detect copies, as well.  Defaults to false.  Note that this
+	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
+	linkgit:git-log[1], and not lower level commands such as
+	linkgit:git-diff-files[1].
 
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
-- 
2.7.2.334.g35ed2ae.dirty
