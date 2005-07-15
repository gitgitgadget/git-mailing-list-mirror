From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 2/6] ident.c: Disambiguate the error messages in setup_ident
Date: Thu, 14 Jul 2005 18:52:31 -0600
Message-ID: <m1oe94yjow.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 02:52:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtERf-0002BL-AU
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVGOAwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVGOAwr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:52:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12221 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262998AbVGOAwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 20:52:46 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F0qW9n020776;
	Thu, 14 Jul 2005 18:52:32 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F0qWJb020775;
	Thu, 14 Jul 2005 18:52:32 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If your user name is too long it is your sysadmin who
hates you not your parents!

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 ident.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

935f88376b79fc19df6dff85ba57ed94f06d79f0
diff --git a/ident.c b/ident.c
--- a/ident.c
+++ b/ident.c
@@ -26,13 +26,13 @@ int setup_ident(void)
 	/* Get the name ("gecos") */
 	len = strlen(pw->pw_gecos);
 	if (len >= sizeof(real_name))
-		die("Your parents must have hated you");
+		die("Your parents must have hated you!");
 	memcpy(real_name, pw->pw_gecos, len+1);
 
 	/* Make up a fake email address (name + '@' + hostname [+ '.' + domainname]) */
 	len = strlen(pw->pw_name);
 	if (len > sizeof(real_email)/2)
-		die("Your parents must have hated you");
+		die("Your sysadmin must have hate you!");
 	memcpy(real_email, pw->pw_name, len);
 	real_email[len++] = '@';
 	gethostname(real_email + len, sizeof(real_email) - len);
