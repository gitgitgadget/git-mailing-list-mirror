From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3] Document ls-files -t as semi-obsolete.
Date: Tue, 27 Jul 2010 23:11:13 +0200
Message-ID: <1280265073-23037-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqaapcy6xq.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 27 23:12:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrRv-0007At-Ul
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab0G0VM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:12:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32949 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab0G0VM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:12:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6RL9chS024677
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 23:09:38 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdrQo-0001xL-NA; Tue, 27 Jul 2010 23:11:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdrQo-000609-KK; Tue, 27 Jul 2010 23:11:22 +0200
X-Mailer: git-send-email 1.7.2.25.g50ec3
In-Reply-To: <vpqaapcy6xq.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 27 Jul 2010 23:09:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RL9chS024677
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280869780.24408@LGG6ieHoA6HDeP7SW/0big
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151989>

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
Should fix the formatting issue.

Finally, I also added a mention of diff-tree --name-status too.

 Documentation/git-ls-files.txt |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 3521637..710e87a 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -106,8 +106,16 @@ OPTIONS
 	with `-s` or `-u` options does not make any sense.
 
 -t::
-	Identify the file status with the following tags (followed by
-	a space) at the start of each line:
+	This feature is semi-deprecated. For scripting purpose,
+	linkgit:git-status[1] `--porcelain` and
+	linkgit:git-diff-tree[1] `--name-status` are almost always
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
1.7.2.25.g50ec3
