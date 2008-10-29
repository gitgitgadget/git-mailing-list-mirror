From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 3/7] Documentation: rework SHA1 description in git push
Date: Wed, 29 Oct 2008 21:25:41 +0100
Message-ID: <1225311945-17100-4-git-send-email-mail@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:28:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHeA-0006P1-A4
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbYJ2UZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbYJ2UZy
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:25:54 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:42698 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243AbYJ2UZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:49 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id ADAD61407F;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id E403014070;
	Wed, 29 Oct 2008 21:25:48 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99405>

Get rid of a double pair of parentheses. The arbitrary SHA1 is a
special case, so it can be postponed a bit.

Also mention HEAD, which is possibly the most useful SHA1 in this
situation.

Mention that a SHA1 cannot be automatically matched to a <dst>.

Add HEAD as an example of an arbitrary SHA1.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 02c7dae..fb9fb97 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -38,9 +38,7 @@ OPTIONS
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
-The <src> side represents the source branch (or arbitrary
-"SHA1 expression", such as `master~4` (four parents before the
-tip of `master` branch); see linkgit:git-rev-parse[1]) that you
+The <src> side represents the source branch that you
 want to push.  The <dst> side represents the destination location.
 +
 The local ref that matches <src> is used
@@ -63,6 +61,10 @@ the local side, the remote side is updated if a head of the same name
 already exists on the remote side.  This is the default operation mode
 if no explicit refspec is found (that is neither on the command line
 nor in any Push line of the corresponding remotes file---see below).
++
+The <src> can be an arbitrary "SHA1 expression", such as `HEAD`
+or `master~4` (see linkgit:git-rev-parse[1]). In this case, a
+<dst> location has to be named.
 
 --all::
 	Instead of naming each ref to push, specifies that all
@@ -193,6 +195,10 @@ git push origin master::
 	with it.  If `master` did not exist remotely, it would be
 	created.
 
+git push origin HEAD:master::
+	Push the current head to the remote ref matching `master` in
+	the `origin` repository.
+
 git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
-- 
1.6.0.2.514.g23abd3
