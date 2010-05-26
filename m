From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 093/104] post-receive-email: document command-line mode
Date: Wed, 26 May 2010 18:01:03 +1200
Message-ID: <1274853674-18521-93-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lk-0004ff-TL
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934042Ab0EZGGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:41 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933948Ab0EZGG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 073E5338C7;
	Wed, 26 May 2010 18:02:08 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9je6WodVl7i; Wed, 26 May 2010 18:02:01 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id B87F7337FB;
	Wed, 26 May 2010 18:01:37 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147762>

From: Jonathan Nieder <jrnieder@gmail.com>

According to the default hooks/post-receive file, the hook is called
with three arguments on stdin:

  <oldrev> <newrev> <refname>

In command-line mode, the arguments come in a different order, because
the email hook instead calls:

  generate_email $2 $3 $1

Add a comment to explain why, based on comments from the mailing list
and the commit message to v1.5.1~9.  Thanks to Andy for the
explanation.

Requested-by: martin f. krafft <madduck@debian.org>
Cc: Andy Parkins <andyparkins@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/hooks/post-receive-email |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 58a35c8..30ae63d 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -23,6 +23,13 @@
 # possible for the email to be from someone other than the person doing the
 # push.
 #
+# To help with debugging and use on pre-v1.5.1 git servers, this script will
+# also obey the interface of hooks/update, taking its arguments on the
+# command line.  Unfortunately, hooks/update is called once for each ref.
+# To avoid firing one email per ref, this script just prints its output to
+# the screen when used in this mode.  The output can then be redirected if
+# wanted.
+#
 # Config
 # ------
 # hooks.mailinglist
-- 
1.7.1.rc2.333.gb2668
