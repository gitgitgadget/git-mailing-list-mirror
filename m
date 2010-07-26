From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] Document ls-files -t as semi-obsolete.
Date: Mon, 26 Jul 2010 18:39:51 +0200
Message-ID: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 26 18:40:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdQjT-0008Co-R8
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 18:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248Ab0GZQkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 12:40:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54308 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab0GZQkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 12:40:46 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2010 12:40:45 EDT
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6QGTrtH010198
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Jul 2010 18:29:53 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdQib-0001LV-Qb; Mon, 26 Jul 2010 18:39:57 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdQib-0004tl-P2; Mon, 26 Jul 2010 18:39:57 +0200
X-Mailer: git-send-email 1.7.2.19.g9a302.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 26 Jul 2010 18:29:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6QGTrtH010198
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280766596.03484@2tAwEx4COEetKYsSnze63Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151856>

The behavior of "git ls-files -t" is very misleading (see
http://thread.gmane.org/gmane.comp.version-control.git/126516 and
http://thread.gmane.org/gmane.comp.version-control.git/144394/focus=144397
for examples of mislead users) and badly documented, hence we point the
users to superior alternatives.

The feature is marked as "semi-obsolete" but not "scheduled for removal"
since it's a plumbing command, scripts might use it, and Git testsuite
already uses it to test the state of the index.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Resurecting a very old patch:

http://thread.gmane.org/gmane.comp.version-control.git/144874

The earlier concerns were:

1) There are valid uses for "git ls-files -t" and
2) If documentation is bad, then it should be improved.

This version should adress 1) by mitigating the wording (deprecated ->
semi-deprecated, "almost always"). To answer 2), I don't think
spending energy documenting a feature that almost nobody uses is worth
it. At least, I'm not going to do it, and since nothing happened for
months, I guess no one else will.

 Documentation/git-ls-files.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..2cc3243 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -106,6 +106,12 @@ OPTIONS
 	with `-s` or `-u` options does not make any sense.
 
 -t::
+	This feature is semi-deprecated. For scripting purpose,
+	linkgit:git-status[1] `--porcelain` is almost always a
+	superior alternative, and users should look at
+	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
+	`--name-status` for more user-friendly alternatives.
+
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
 	H::	cached
-- 
1.7.2.19.g9a302.dirty
