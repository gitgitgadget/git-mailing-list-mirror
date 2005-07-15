From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Complain about sysadmins in the present tense.
Date: Thu, 14 Jul 2005 20:10:20 -0600
Message-ID: <m14qawx1ir.fsf_-_@ebiederm.dsl.xmission.com>
References: <m1oe94yjow.fsf@ebiederm.dsl.xmission.com>
	<7vr7e03m4k.fsf@assigned-by-dhcp.cox.net>
	<m1br54x324.fsf@ebiederm.dsl.xmission.com>
	<7v8y083k5o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 04:11:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtFft-0001Uk-AP
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 04:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbVGOCK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 22:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbVGOCK7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 22:10:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21950 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263148AbVGOCKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 22:10:41 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F2ALRB022925;
	Thu, 14 Jul 2005 20:10:21 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F2ALi9022924;
	Thu, 14 Jul 2005 20:10:21 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v8y083k5o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 14 Jul 2005 18:58:11 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Actually I could not see something the system administrator
>> had bone being anything but present tense.  If you have to type
>> 500+ characters just to login, I think you would have noticed
>> and complained to your sysadmin earlier...
>
> I think "must have hate you" is simply an incorrect grammar, not
> present tense.  You mean "must hate you", perhaps?

Yes.  It looks like I failed to delete the have :(
Somethings you just can't see when you know what you meant.

Here is a patch to fix it up.

Eric

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com> 
---

 Documentation/git-commit-tree.txt |    2 +-
 Documentation/git-var.txt         |    2 +-
 ident.c                           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

554595e307653e90e5945bcef739fde935d7bcef
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -70,7 +70,7 @@ You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
 Your parents must have hated you!::
     The password(5) gecos field is longer than a giant static buffer.
-Your sysadmin must have hate you!::
+Your sysadmin must hate you!::
     The password(5) name field is longer than a giant static buffer.
 
 See Also
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -38,7 +38,7 @@ You don't exist. Go away!::
     The passwd(5) gecos field couldn't be read
 Your parents must have hated you!::
     The password(5) gecos field is longer than a giant static buffer.
-Your sysadmin must have hate you!::
+Your sysadmin must hate you!::
     The password(5) name field is longer than a giant static buffer.
 
 See Also
diff --git a/ident.c b/ident.c
--- a/ident.c
+++ b/ident.c
@@ -32,7 +32,7 @@ int setup_ident(void)
 	/* Make up a fake email address (name + '@' + hostname [+ '.' + domainname]) */
 	len = strlen(pw->pw_name);
 	if (len > sizeof(real_email)/2)
-		die("Your sysadmin must have hate you!");
+		die("Your sysadmin must hate you!");
 	memcpy(real_email, pw->pw_name, len);
 	real_email[len++] = '@';
 	gethostname(real_email + len, sizeof(real_email) - len);
