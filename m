From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4] Document ls-files -t as semi-obsolete.
Date: Wed, 28 Jul 2010 09:24:27 +0200
Message-ID: <1280301867-20516-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20100728040047.GA17614@coredump.intra.peff.net>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 28 09:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe10p-0000aB-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab0G1HZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 03:25:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56109 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab0G1HZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 03:25:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6S7EKj6024475
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 09:14:23 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe10A-0006G0-DE; Wed, 28 Jul 2010 09:24:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe10A-0005LV-Ar; Wed, 28 Jul 2010 09:24:30 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <20100728040047.GA17614@coredump.intra.peff.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Jul 2010 09:14:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6S7EKj6024475
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280906064.2249@NueOqk6nZ5fdUSWLoigr9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152045>

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
Just s/diff-tree/diff-files/ (thanks to Peff for the correction) compared to v3.

 Documentation/git-ls-files.txt |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..bd919f2 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -106,8 +106,16 @@ OPTIONS
 	with `-s` or `-u` options does not make any sense.
 
 -t::
-	Identify the file status with the following tags (followed by
-	a space) at the start of each line:
+	This feature is semi-deprecated. For scripting purpose,
+	linkgit:git-status[1] `--porcelain` and
+	linkgit:git-diff-files[1] `--name-status` are almost always
+	superior alternatives, and users should look at
+	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
+	`--name-status` for more user-friendly alternatives.
++
+This option identifies the file status with the following tags (followed by
+a space) at the start of each line:
+
 	H::	cached
 	S::	skip-worktree
 	M::	unmerged
-- 
1.7.2.25.g9ebe3
