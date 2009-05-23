From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] post-receive-email: hooks.showrev: show how to include both web link and patch
Date: Sat, 23 May 2009 14:26:44 +0200
Message-ID: <87fxewc8e3.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 23 14:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7qKn-0005rm-HR
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 14:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZEWM0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZEWM0v
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 08:26:51 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33183 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbZEWM0u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 08:26:50 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 75D2E9400A6
	for <git@vger.kernel.org>; Sat, 23 May 2009 14:26:46 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 9B5F79400D0
	for <git@vger.kernel.org>; Sat, 23 May 2009 14:26:44 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 505DD2BC48; Sat, 23 May 2009 14:26:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119776>


Add a comment showing how to include a web link (i.e. gitweb/cgit)
and a patch in the email that is sent for each pushed commit.
---
The quoting was tricky enough that it's worth documenting.
At first I wanted to put \n\n in the printf, but to do
so would have meant using \\\\n\\\\n, and in the end,
the pair of "echo" statements seemed better.

FYI, I did this for glibc.git:
  http://sources.redhat.com/git/gitweb.cgi?p=glibc.git;a=summary

push-triggered messages have been sent to this list since May 21:
  http://sourceware.org/ml/glibc-cvs/2009-q2/

 contrib/hooks/post-receive-email |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 contrib/hooks/post-receive-email

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
old mode 100644
new mode 100755
index 60cbab6..2a66063
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -44,6 +44,10 @@
 #   --pretty %s", displaying the commit id, author, date and log
 #   message.  To list full patches separated by a blank line, you
 #   could set this to "git show -C %s; echo".
+#   To list a gitweb/cgit URL *and* a full patch for each change set, use this:
+#     "t=%s; printf 'http://.../?id=%%s' \$t; echo;echo; git show -C \$t; echo"
+#   Be careful if "..." contains things that will be expanded by shell "eval"
+#   or printf.
 #
 # Notes
 # -----
--
1.6.3.1.208.gf0011
