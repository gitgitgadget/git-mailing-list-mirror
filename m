From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 3/3] Documentation: rework src/dst description in git push
Date: Mon, 26 Jan 2009 00:45:33 +0100
Message-ID: <1232927133-30377-4-git-send-email-mail@cup.kalibalik.dk>
References: <1232927133-30377-1-git-send-email-mail@cup.kalibalik.dk>
 <1232927133-30377-2-git-send-email-mail@cup.kalibalik.dk>
 <1232927133-30377-3-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 00:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREgz-0004qh-5u
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:47:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbZAYXpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbZAYXpm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:45:42 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:44952 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbZAYXpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:45:38 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id D2168308D4;
	Mon, 26 Jan 2009 00:45:10 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id B9D7130B53;
	Mon, 26 Jan 2009 00:45:08 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1232927133-30377-3-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107139>

This tries to make the description of ref matching in git push easier
to read. Beauty is in the eye of the beholder, though.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

This is a followup to
http://article.gmane.org/gmane.comp.version-control.git/99553/


 Documentation/git-push.txt |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6d478c5..1b3de4f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -38,20 +38,21 @@ OPTIONS
 	by a colon `:`, followed by the destination ref <dst>.
 	Find various forms of refspecs in examples section.
 +
-The <src> side represents the source branch (or arbitrary
-"SHA1 expression", such as `master~4` (four parents before the
-tip of `master` branch); see linkgit:git-rev-parse[1]) that you
-want to push.  The <dst> side represents the destination location.
+The <src> is often the name of the branch you would want to push, but
+it can be any arbitrary "SHA-1 expression", such as `master~4` or
+`HEAD` (see linkgit:git-rev-parse[1]).
 +
-The local ref that matches <src> is used
-to fast forward the remote ref that matches <dst>.  If
-the optional leading plus `+` is used, the remote ref is updated
-even if it does not result in a fast forward update.
+The <dst> tells which ref on the remote side is updated with this
+push. Arbitrary expressions cannot be used here, an actual ref must
+be named. If `:`<dst> is omitted, the same ref as <src> will be
+updated.
 +
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
+The object referenced by <src> is used to fast forward the ref <dst>
+on the remote side. If the optional leading plus `{plus}` is used, the
+remote ref is updated even if it does not result in a fast forward
+update.
 +
-A lonely <src> parameter (without a colon and a destination) pushes
-the <src> to the same name in the destination repository.
+`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
-- 
1.6.0.2.514.g23abd3
