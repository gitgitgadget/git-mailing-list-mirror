From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH v3] Smart-http documentation: add example of how to execute from userdir
Date: Sat,  2 Jan 2010 13:18:21 -0800
Message-ID: <1262467101-5755-1-git-send-email-tarmigan+git@gmail.com>
References: <be6fef0d0912301818o678976ebqa3e339dc1ff1f2e8@mail.gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 22:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRBMu-0001z5-06
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 22:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab0ABVSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 16:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542Ab0ABVSf
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 16:18:35 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:58992 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0ABVSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 16:18:34 -0500
Received: by gxk3 with SMTP id 3so1814467gxk.1
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 13:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=aLFMucGdl+fjwuXHsT7l+FuSnyckN0HVbS1f8XBJlXQ=;
        b=LxrltdMx+rvH3gGX1DUX3gqZYufxm5fSA4agSEb5NAPRBLPQwaS9mP7IDbE08KLxOa
         cq81heus51stQRGlrOZDlZJBMRuNrBB9dqnrYgbc+NZROdauFHTN38Fm4vWT2QqQyjIx
         YfpnjLh515BV0ckzPLmyZ3S0c2kD2zmt5x70U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=F2eOnXBoh2bUG8jc+F3PptUsrUGVQWMSM2z7F9NuhkKasPrToYcebJzjZMaksRjgBw
         xIJicI/LmVzDjbs9bk7FM0/rv97BiEtedE+Cphdu1wcsE8gieaV3vlP++FC6sJ89499z
         Spd1+wruvKJXuoVvkkWwd2/9/t9tSg3CylJ1Y=
Received: by 10.150.80.16 with SMTP id d16mr31889242ybb.0.1262467114099;
        Sat, 02 Jan 2010 13:18:34 -0800 (PST)
Received: from localhost.localdomain (c-69-181-44-199.hsd1.ca.comcast.net [69.181.44.199])
        by mx.google.com with ESMTPS id 4sm6553919yxd.16.2010.01.02.13.18.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 13:18:32 -0800 (PST)
X-Mailer: git-send-email 1.6.6.236.gc56f3
In-Reply-To: <be6fef0d0912301818o678976ebqa3e339dc1ff1f2e8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136053>

Smart-http may be an attactive and easy way for people to setup git
hosting on shared servers whose primary web server configuration they
do not control.  To facilite this, provide an example of how it may be
done.

cc:  Tay Ray Chuan <rctay89@gmail.com>
cc: Shawn O. Pearce <spearce@spearce.org>
Editing-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 Documentation/git-http-backend.txt |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 67aec06..0485033 100644
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
@@ -144,6 +144,34 @@ ScriptAliasMatch \
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
+Options +SymLinksIfOwnerMatch
+SetEnv GIT_PROJECT_ROOT /home/$username/devel
+----------------------------------------------------------------
++
+Also add any needed authentication to the .htaccess file as discussed
+in earlier examples.
++
+If the web server does not follow any symbolic links, the
+'git-http-backend' executable may be copied into the cgi-bin directory
+and renamed to 'git' to acheive the same effect, but it will also need
+to be manually updated whenever a new version of 'git-http-backend' is
+installed.
 
 ENVIRONMENT
 -----------
-- 
1.6.6.236.gc56f3
