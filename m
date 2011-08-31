From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] (short) documentation for the testgit remote helper
Date: Wed, 31 Aug 2011 20:14:58 +0200
Message-ID: <1314814498-13699-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 31 20:15:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QypJh-0006Sx-WC
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 20:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005Ab1HaSPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 14:15:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39661 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756967Ab1HaSPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 14:15:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7VIEIFG031219
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 20:14:18 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1QypJT-0006e6-OL; Wed, 31 Aug 2011 20:14:59 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1QypJT-0003Za-Md; Wed, 31 Aug 2011 20:14:59 +0200
X-Mailer: git-send-email 1.7.7.rc0.75.g56f27
In-Reply-To: <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 31 Aug 2011 20:14:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VIEIFG031219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1315419261.43519@XDzAkqkANLlOjFlIg3o9wA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180499>

While it's not a command meant to be used by actual users (hence, not
mentionned in git(1)), this command is a very precious help for
remote-helpers authors.

The best place for such technical doc is the source code, but users may
not find it without a link in a manpage.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

While we're improving the docs, this is one more thing that would have
saved me some time ...

 Documentation/git-remote-helpers.txt |    2 ++
 Documentation/git-remote-testgit.txt |   30 ++++++++++++++++++++++++++++++
 git-remote-testgit.py                |   14 ++++++++++++++
 3 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-remote-testgit.txt

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 526fc6a..674797c 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -362,6 +362,8 @@ SEE ALSO
 --------
 linkgit:git-remote[1]
 
+linkgit:git-remote-testgit[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
new file mode 100644
index 0000000..2a67d45
--- /dev/null
+++ b/Documentation/git-remote-testgit.txt
@@ -0,0 +1,30 @@
+git-remote-testgit(1)
+=====================
+
+NAME
+----
+git-remote-testgit - Example remote-helper
+
+
+SYNOPSIS
+--------
+[verse]
+git clone testgit::<source-repo> [<destination>]
+
+DESCRIPTION
+-----------
+
+This command is a simple remote-helper, that is used both as a
+testcase for the remote-helper functionality, and as an example to
+show remote-helper authors one possible implementation.
+
+The best way to learn more is to read the comments and source code in
+'git-remote-testgit.py'.
+
+SEE ALSO
+--------
+linkgit:git-remote-helpers[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index e9c832b..91d4409 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -1,5 +1,19 @@
 #!/usr/bin/env python
 
+# This command is a simple remote-helper, that is used both as a
+# testcase for the remote-helper functionality, and as an example to
+# show remote-helper authors one possible implementation.
+#
+# This is a Git <-> Git importer/exporter, that simply uses git
+# fast-import and git fast-export to consume and produce fast-import
+# streams.
+#
+# To understand better the way things work, one can set the variable
+# "static int debug" in transport-helper.c to 1, and/or the "DEBUG"
+# variable in git_remote_helpers/util.py to True, and try various
+# commands.
+
+
 # hashlib is only available in python >= 2.5
 try:
     import hashlib
-- 
1.7.7.rc0.75.g56f27
