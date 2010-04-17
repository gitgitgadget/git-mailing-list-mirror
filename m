From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v2] documentation: clarify direction of core.autocrlf
Date: Sat, 17 Apr 2010 17:55:26 +0100
Message-ID: <1271523326-6860-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 17 18:57:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3BKS-0005HT-TK
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 18:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab0DQQ5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 12:57:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61442 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab0DQQ5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 12:57:06 -0400
Received: by wyb39 with SMTP id 39so1739169wyb.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pECCrY7C5Uq3LPOwTXYnJpvk0oH9H76V95fu6N23jgs=;
        b=TRDUMyZ/S2Ppuc+tl8lBArgv/u4DaDWLgOXUMLT0PLTMt3KLQilJ0fbCS6MIKbQ3I/
         dSkVHQIe7Bu1/caihOeWUoZygn3Mwx8MaHuOxvUBosHdyaHjhpLmIHnq4xSvaXs9U5Mf
         tg+TiftgN2gXUtg6WPAojWcQIoGQMR92eiUwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ov4hkfLh8q0zMm5fUA5RD4YJxs8iKq075SC0PuwG0MEpZcr/HnDIWVw2i38iddRwK3
         lVMvgpb1s+K/Mcmc7JwFFG41eiBwXpfiuNf8Qzn0qJMABgpwtwOXhixSIiNZVwmsD3KS
         KELcJQyDF+g3lpm5AJVic/QcSyDXo9RwGbZIU=
Received: by 10.216.176.212 with SMTP id b62mr1482952wem.179.1271523425135;
        Sat, 17 Apr 2010 09:57:05 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id x14sm31582486wbs.12.2010.04.17.09.57.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 09:57:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.g2f822
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145156>

The description for core.autocrlf refers to reads from / writes to
"the filesystem", the only use of this rather ambiguous term, which
technically could be referring to the git object database. (All other
mentions are part of phrases such as "..filesystems (like NFS)..").

Other sections, including the section on core.safecrlf, use the term
"work tree" for the same purpose as the term "the filesystem" is used in
the core.autocrlf section, so that seems like a good alternative, which
makes it clearer what direction the addition/removal of CR characters
occurs in.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/config.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 626b19a..b2a4a92 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -198,11 +198,11 @@ core.quotepath::
 
 core.autocrlf::
 	If true, makes git convert `CRLF` at the end of lines in text files to
-	`LF` when reading from the filesystem, and convert in reverse when
-	writing to the filesystem.  The variable can be set to
+	`LF` when reading from the work tree, and convert in reverse when
+	writing to the work tree.  The variable can be set to
 	'input', in which case the conversion happens only while
-	reading from the filesystem but files are written out with
-	`LF` at the end of lines.  A file is considered
+	reading from the work tree but files are written out to the work
+	tree with `LF` at the end of lines.  A file is considered
 	"text" (i.e. be subjected to the autocrlf mechanism) based on
 	the file's `crlf` attribute, or if `crlf` is unspecified,
 	based on the file's contents.  See linkgit:gitattributes[5].
-- 
1.7.1.rc1.13.g2f822
