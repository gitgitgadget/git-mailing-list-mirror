From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Improve remote-helpers documentation
Date: Mon, 22 Mar 2010 08:30:11 +0530
Message-ID: <f3271551003212000p6399516cp44527635c0f84cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 04:00:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtXsl-0001NF-Se
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab0CVDAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 23:00:33 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:43882 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab0CVDAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 23:00:31 -0400
Received: by ywh2 with SMTP id 2so1604976ywh.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 20:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=34q4qFcKsW5vOXAo0iRklKa2BFPu/olgOr+e2Phe81o=;
        b=q7oQezJCwdKg2XDT59I8QUyXt39iLfZyD1kmCfdyCfgKXMjKV6SqZcl5PVjdYX3ktu
         j0QiaNZyDS0LOB+ggagR2Kr1+e5pQF0BsDBhOYHqvXuQRNKRat0PS4a/DVUD1SwWULCP
         iLuCyPAYTYswbjDvBozQrQPk0LU2EcNcxKe4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=YCSFEXsy18f3w+kH6pUpXIL2ORCxb0F7jS9PCeGL+zfcnIdZVVcZmM7YYIdev7Q00e
         yQEdEKM79SvOGmB6+0KyIeqH3BGMTJWei+EcuFgqkCQlwOHn+6qQNgfmMrbuArzvn6Rp
         VGOX+lweMmgb8qFwoAnQjWLjDHCKMgGghVr/8=
Received: by 10.91.164.27 with SMTP id r27mr3677290ago.20.1269226831074; Sun, 
	21 Mar 2010 20:00:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142886>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-remote-helpers.txt |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..97f301e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,7 @@ git-remote-helpers(1)

 NAME
 ----
-git-remote-helpers - Helper programs for interoperation with remote git
+git-remote-helpers - Helper programs for interacting with main git
without linking

 SYNOPSIS
 --------
@@ -13,10 +13,22 @@ DESCRIPTION
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
+and 'push'. The curl helper essentially helps in moving around native
+git objects.
+
+As opposed to native git objects, remote helpers can also provide a
+fast-import stream through the 'import' capability. This makes it
+especially useful when native interoperability with a foreign
+versioning system is desired.

 COMMANDS
 --------
@@ -122,7 +134,7 @@ CAPABILITIES
 	This helper supports the 'fetch' command.

 'option'::
-	This helper supports the option command.
+	This helper supports the 'option' command.

 'push'::
 	This helper supports the 'push' command.
-- 
1.7.0
