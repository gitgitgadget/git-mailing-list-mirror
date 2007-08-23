From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH] Fixed indeterminism in t2102-pull-policy-rebase
Date: Thu, 23 Aug 2007 08:55:32 +0200
Message-ID: <11878521324048-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 08:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO6bU-0005kQ-KU
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 08:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbXHWGzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 02:55:37 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbXHWGzh
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 02:55:37 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:34260 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbXHWGzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 02:55:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 877E1200A209
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 08:55:35 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16386-01-65; Thu, 23 Aug 2007 08:55:33 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E7539200A1E2;
	Thu, 23 Aug 2007 08:55:33 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 09A72BFC88; Thu, 23 Aug 2007 08:55:33 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc6.31.g3c3b
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56462>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
This test case was sometimes succeeding and sometimes failing.  This
seems to be how it was expected to work.

 t/t2102-pull-policy-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2102-pull-policy-rebase.sh b/t/t2102-pull-policy-rebase=
=2Esh
index 41f8168..670673d 100755
--- a/t/t2102-pull-policy-rebase.sh
+++ b/t/t2102-pull-policy-rebase.sh
@@ -10,8 +10,8 @@ test_description=3D'Excercise pull-policy "rebase".'
 test_expect_success \
     'Fork stack off parent branch, and add patches to the stack' \
     '
-    stg init &
     git branch -m master parent &&
+    stg init &&
     stg branch --create stack &&
     git repo-config branch.stack.stgit.pull-policy rebase &&
     git repo-config --list &&
--=20
1.5.3.rc6.31.g3c3b
