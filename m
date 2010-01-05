From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v4] Smart-http documentation: add example of how to execute from userdir
Date: Mon,  4 Jan 2010 23:59:41 -0800
Message-ID: <1262678381-86653-1-git-send-email-tarmigan+git@gmail.com>
References: <905315641001042359h7850c6cdrf9160030aff67839@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:00:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS4L9-0007h5-GL
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 09:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355Ab0AEIAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 03:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342Ab0AEIAK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 03:00:10 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:60790 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab0AEIAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 03:00:03 -0500
Received: by ywh6 with SMTP id 6so16172052ywh.4
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 00:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=c/9S9iQkqm+EE9jLRlPSMsSFZ5O+21NPtvIIDxysnJ0=;
        b=KXFBiQs+WAAp4y5xsp0vdxzN0vFsOysClAJVHAI7L/N9cGhkyYw2MxIy0i2ZRUUoMs
         niNMXz1XEAqYQC46OJVzLpYKLumprJ+4bR57iXYZMRgNLA8bCwW8+2edHqxpNTVwTa7j
         LgQ4eRjSt0UUaUU4xeXcqbiB4xnVR0dJNGJtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=aXx18KGC7IPtOQ8i7rkHAvJp3xeSL3R5b8EZMu33nXS+cXZAEyBE5BUb0Sdx8cL9DX
         0MXz9d+9rCDtGQ7JkLJDuR113fhjkdCjahPTpEeKgKcII+J3NWOi9dReqwJIwrEcPFx5
         DjIDakwwwcr1Ctay6M3UXkVCGINJHksTxiyxc=
Received: by 10.101.185.26 with SMTP id m26mr17817932anp.129.1262678402439;
        Tue, 05 Jan 2010 00:00:02 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 21sm7684380yxe.1.2010.01.04.23.59.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 00:00:00 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <905315641001042359h7850c6cdrf9160030aff67839@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136174>

Smart-http may be an attactive and easy way for people to setup git
hosting on shared servers whose primary web server configuration they
do not control.  To facilite this, provide an example of how it may be
done.

cc:  Tay Ray Chuan <rctay89@gmail.com>
cc: Shawn O. Pearce <spearce@spearce.org>
Edited-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 Documentation/git-http-backend.txt |   33 +++++++++++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 67aec06..7af1288 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -60,8 +60,8 @@ automatically by the web server.
 
 EXAMPLES
 --------
-All of the following examples map 'http://$hostname/git/foo/bar.git'
-to '/var/www/git/foo/bar.git'.
+Unless otherwise noted, the following examples map
+'http://$hostname/git/foo/bar.git' to '/var/www/git/foo/bar.git'.
 
 Apache 2.x::
 	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
@@ -144,6 +144,35 @@ ScriptAliasMatch \
 ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
 ----------------------------------------------------------------
 
+In the following example, the repository at
+'/home/$username/devel/foo/bar.git' will be accessible at
+'http://$hostname/~$username/cgi-bin/git/foo/bar.git'.
+
+From UserDir on Apache 2.x::
+       One way to configure 'git-http-backend' to execute and serve
+       from a user directory (for example, on a shared hosting
+       provider), is to have a symbolic link named 'git' that points
+       from the cgi directory to the 'git-http-backend' executable in
+       libexec.  The advantage is that this symbolic link always
+       points to the latest installed version; one does not have to
+       make any changes to the symbolic link when the installed
+       'git-http-backend' is updated.
++
+----------------------------------------------------------------
+SetHandler cgi-script
+SetEnv GIT_PROJECT_ROOT /home/$username/devel
+----------------------------------------------------------------
++
+Also add any needed authentication to the .htaccess file as discussed
+in earlier examples.
++
+Depending on the global configuration of the web server, the
+"FollowSymLinks" or "SymLinksIfOwnerMatch" options might be needed.
+If the web server does not follow any symbolic links, the
+'git-http-backend' executable may be copied into the cgi-bin directory
+and renamed to 'git' to acheive the same effect, but it will also need
+to be manually updated whenever a new version of 'git-http-backend' is
+installed.
 
 ENVIRONMENT
 -----------
-- 
1.6.6
