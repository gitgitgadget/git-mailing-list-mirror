From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Several trivial documentation touch ups.
Date: Fri, 5 May 2006 15:05:10 -0400
Message-ID: <BAYC1-PASMTP03B6442A6F1E6C8044D49BAEB50@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 05 21:10:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5gq-0001ms-4f
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWEETKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWEETKI
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:10:08 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:65239 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751628AbWEETKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 15:10:06 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 May 2006 12:10:05 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id D6754644C28
	for <git@vger.kernel.org>; Fri,  5 May 2006 15:10:04 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060505150510.55e08a99.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 05 May 2006 19:10:06.0246 (UTC) FILETIME=[850FC460:01C67077]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Move incorrect asciidoc level 2 titles back to level 1.

  Show output of git-name-rev in man page example.

  Reword sentences that begin with a period (.) in asciidoc
  numbered lists to work around conversion to man page bug.

  Mention that git-repack now calls git-prune-packed
  when the -d option is passed to it.

  [imap] section headers in the config file example need to be
  contained in a literal block.  imap.pass is the proper config
  file variable to use, not imap.password.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/git-clone.txt       |    2 +-
 Documentation/git-imap-send.txt   |    4 +++-
 Documentation/git-name-rev.txt    |    1 +
 Documentation/git-repack.txt      |    1 +
 Documentation/git-repo-config.txt |    6 +++---
 Documentation/git-reset.txt       |    2 +-
 6 files changed, 10 insertions(+), 6 deletions(-)

227b8dd1fa66a6d96a25e9fd8fc070be1ea31449
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 131e445..b333f51 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -101,7 +101,7 @@ OPTIONS
 	is not allowed.
 
 Examples
-~~~~~~~~
+--------
 
 Clone from upstream::
 +
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index cfc0d88..eca9e9c 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -29,6 +29,7 @@ CONFIGURATION
 git-imap-send requires the following values in the repository
 configuration file (shown with examples):
 
+..........................
 [imap]
     Folder = "INBOX.Drafts"
 
@@ -38,8 +39,9 @@ configuration file (shown with examples)
 [imap]
     Host = imap.server.com
     User = bob
-    Password = pwd
+    Pass = pwd
     Port = 143
+..........................
 
 
 BUGS
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 6870708..ffaa004 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -41,6 +41,7 @@ Enter git-name-rev:
 
 ------------
 % git name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a
+33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99^0~940
 ------------
 
 Now you are wiser, because you know that it happened 940 revisions before v0.99.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d2f9a44..9516227 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -38,6 +38,7 @@ OPTIONS
 -d::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
+	Also runs gitlink:git-prune-packed[1].
 
 -l::
         Pass the `--local` option to `git pack-objects`, see
diff --git a/Documentation/git-repo-config.txt b/Documentation/git-repo-config.txt
index ddcf523..fd44f62 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -34,10 +34,10 @@ convert the value to the canonical form 
 a "true" or "false" string for bool). If no type specifier is passed,
 no checks or transformations are performed on the value.
 
-This command will fail if
+This command will fail if:
 
-. .git/config is invalid,
-. .git/config can not be written to,
+. The .git/config file is invalid,
+. Can not write to .git/config,
 . no section was provided,
 . the section or key is invalid,
 . you try to unset an option which does not exist, or
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index ebcfe5e..b27399d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -43,7 +43,7 @@ OPTIONS
 	Commit to make the current HEAD.
 
 Examples
-~~~~~~~~
+--------
 
 Undo a commit and redo::
 +
-- 
1.3.1.g9c203
