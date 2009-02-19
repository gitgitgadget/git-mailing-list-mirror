From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document git blame --reverse.
Date: Thu, 19 Feb 2009 13:34:48 +0100
Message-ID: <1235046888-1782-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 13:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La8OB-00005E-5D
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757516AbZBSMu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757001AbZBSMu6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:50:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:53837 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851AbZBSMu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:50:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1JCYnKU001073
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Feb 2009 13:34:49 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1La877-0007LS-1m; Thu, 19 Feb 2009 13:34:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1La876-0000TX-V2; Thu, 19 Feb 2009 13:34:48 +0100
X-Mailer: git-send-email 1.6.2.rc1.14.g7f87d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 19 Feb 2009 13:34:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110684>

This was introduced in 85af7929ee125385c2771fa4eaccfa2f29dc63c9 but
not documented outside the commit message.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Actually, this doesn't fix the output of "git blame -h".
I guess a parseopt specialist could do that with a trivial patch.

 Documentation/blame-options.txt |    7 +++++++
 Documentation/git-blame.txt     |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 1ab1b96..7f28432 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -41,6 +41,13 @@ of lines before or after the line given by <start>.
 -S <revs-file>::
 	Use revs from revs-file instead of calling linkgit:git-rev-list[1].
 
+--reverse::
+	Walk history forward instead of backward. Instead of showing
+	the revision in which a line appeared, this shows the last
+	revision in which a line has existed. This requires a range of
+	revision like START..END where the path to blame exists in
+	START.
+
 -p::
 --porcelain::
 	Show in a format designed for machine consumption.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 6999cf2..5aa1dcc 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [--incremental] [-L n,m]
             [-S <revs-file>] [-M] [-C] [-C] [--since=<date>]
-            [<rev> | --contents <file>] [--] <file>
+            [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
 DESCRIPTION
 -----------
-- 
1.6.2.rc1.14.g7f87d
