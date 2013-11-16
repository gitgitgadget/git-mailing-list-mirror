From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 3/3] Documentation/gitk: document -L option
Date: Sat, 16 Nov 2013 18:37:57 +0100
Message-ID: <d532afe2eda5d5dff2f28af33831de5d1d0492e9.1384622379.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch> <cover.1384622379.git.tr@thomasrast.ch>
Cc: Paul Mackerras <paulus@samba.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhjpD-0007WZ-4L
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3KPRiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:38:20 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38523 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab3KPRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:38:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A66684D6570;
	Sat, 16 Nov 2013 18:38:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3MHP3NkyQYJ4; Sat, 16 Nov 2013 18:38:05 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 426504D65B4;
	Sat, 16 Nov 2013 18:38:04 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <cover.1384622379.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237938>

The -L option is the same as for git-log, so the entire block is just
copied from git-log.txt.  However, until the parser is fixed we add a
caveat that gitk only understands the stuck form.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 Documentation/gitk.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index d44e14c..1e9e38a 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -98,6 +98,22 @@ linkgit:git-rev-list[1] for a complete list.
 	(See "History simplification" in linkgit:git-log[1] for a more
 	detailed explanation.)
 
+-L<start>,<end>:<file>::
+-L:<regex>:<file>::
+
+	Trace the evolution of the line range given by "<start>,<end>"
+	(or the funcname regex <regex>) within the <file>.  You may
+	not give any pathspec limiters.  This is currently limited to
+	a walk starting from a single revision, i.e., you may only
+	give zero or one positive revision arguments.
+	You can specify this option more than once.
++
+*Note:* gitk (unlike linkgit:git-log[1]) currently only understands
+this option if you specify it "glued together" with its argument.  Do
+*not* put a space after `-L`.
++
+include::line-range-format.txt[]
+
 <revision range>::
 
 	Limit the revisions to show. This can be either a single revision
-- 
1.8.5.rc2.348.gb73b695
