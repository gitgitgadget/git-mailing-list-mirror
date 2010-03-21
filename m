From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Improve documentation for git-remote-helpers
Date: Sun, 21 Mar 2010 22:56:33 +0530
Message-ID: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 18:27:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOvX-0001fn-3a
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0CUR0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:26:54 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:63346 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab0CUR0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 13:26:53 -0400
Received: by ywh2 with SMTP id 2so1436562ywh.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=vyDzceoYpr2/q6BK+OPkJaf7zVXHsSjNcVaLrTotc7U=;
        b=XwCSlXuEpL4ia4YjlBnRyCRQ25S3cq5HB9OUxJ6wRowPMpZcfVS4YckOWjO7w7uPof
         FZbXF4LjqgWW5wgBxh4FyjF/CIfpqziyHCDKpUW/2sYLLGcPOpn0ttMbL96ri3fEI0hi
         eifpQhe1PWGvsHXCZ5H/K+/uRYDeIAtwEPsFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=EkE+mJw3xIv2Z4GiUp6/LzFS9QblPjADdeo11RSO4Sxt3qRw8W8INRUKp2Oivkl2Ss
         FlxIh7tN6vbPKb4xQVdVeYSB6W1tyTIp9Lw9iE1/0JXzibhCXXhcVB953TN3zHUUjNT9
         Cnfzix46qYOYrQLJJ3YEBnkXEWq7la290Giqc=
Received: by 10.91.160.5 with SMTP id m5mr3241837ago.120.1269192413130; Sun, 
	21 Mar 2010 10:26:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142838>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..54b36c8 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,8 @@ git-remote-helpers(1)

 NAME
 ----
-git-remote-helpers - Helper programs for interoperation with remote git
+git-remote-helpers - Helper programs for interacting with main git
+programs without linking to them

 SYNOPSIS
 --------
@@ -13,10 +14,19 @@ DESCRIPTION
 -----------

 These programs are normally not used directly by end users, but are
-invoked by various git programs that interact with remote repositories
-when the repository they would operate on will be accessed using
-transport code not linked into the main git binary. Various particular
-helper programs will behave as documented here.
+invoked by various git programs that interact with remote
+repositories.  For a program to qualify as a remote helper, it must
+implement a subset of the capabilities documented here, and conform to
+the remote helper protocol. Remote helpers interact with the main git
+programs via text streams, and do not link to them.
+
+The curl helper is one such program. It is invoked via
+'git-remote-http', 'git-remote-https', 'git-remote-ftp', or
+'git-remote-ftps', and implments the capabilities 'fetch', 'option',
+and 'push'.
+
+Remote helpers are often useful when native interoperability with a
+foreign versioning system is desired.

 COMMANDS
 --------
@@ -122,7 +132,7 @@ CAPABILITIES
 	This helper supports the 'fetch' command.

 'option'::
-	This helper supports the option command.
+	This helper supports the 'option' command.

 'push'::
 	This helper supports the 'push' command.
-- 
1.7.0
