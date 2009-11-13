From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] Update 'git remote' usage and man page to match.
Date: Thu, 12 Nov 2009 20:15:34 -0500
Message-ID: <32c343770911121715l7507b2d5j8c6cf8cccd1f1a61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 13 02:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8kmG-0004aj-Q3
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 02:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbZKMBPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 20:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbZKMBPa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 20:15:30 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:63870 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbZKMBPa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 20:15:30 -0500
Received: by fxm21 with SMTP id 21so2938674fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 17:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=zNC8725WF4X5ZL+D/a1u+c55nW8kCZwmDFdO7i4iUCM=;
        b=luGKgmtZ6Qjn5EAzkbjrSMAQWib48zUyESCRh1ARVhIONsfo/xiwJYHcc4jfSHzQ63
         LCQ1kgUzO06umlRMsM4MzHsU9CjDo/EbFUwml+WFqhGwoglQrZa5ELjKZYx7Jf3AMgt1
         aYPPh44Dwl+WIIoGQQT07a2DXxwPYyzAJi8+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=KFj6ac05FSm31ey8Ytc31MHlHP+PUgF07Q+ngx1cyLYpNVl+gMcGeICU2i8Mb7SOZG
         KYaYYiXAXJb2hdIo2LMEd8M9hySCJkExfSxsuB0ppzIwT42rJqb0Poe/viLY+QyKfEN6
         IVCxco4DiDYpFD/uUB54Nih2T1nq13kuLof18=
Received: by 10.216.86.142 with SMTP id w14mr1149339wee.74.1258074934739; Thu, 
	12 Nov 2009 17:15:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132813>

This commit:

1) Removes documentation of '--verbose' from the synopsis portion
of the usage string since it is a general option.

2) Removes the 'remote' option from 'git remote update' in the
man page.  This option had already been removed from the usage
string in the code, but the man page was not updated to match.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This is a resend of the patch at:
http://article.gmane.org/gmane.comp.version-control.git/132732

I forgot to include 'gitster at pobox dot com' on the original patch.
No changes were made to the patch itself.

Sorry for the noise.

 Documentation/git-remote.txt |    4 ++--
 builtin-remote.c             |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 82a3d29..32ff95b 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -9,14 +9,14 @@ git-remote - manage set of tracked repositories
 SYNOPSIS
 --------
 [verse]
-'git remote' [-v | --verbose]
+'git remote'
 'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git remote rename' <old> <new>
 'git remote rm' <name>
 'git remote set-head' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
 'git remote prune' [-n | --dry-run] <name>
-'git remote update' [-p | --prune] [group | remote]...
+'git remote update' [-p | --prune] [group]...

 DESCRIPTION
 -----------
diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..3756e91 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -8,14 +8,14 @@
 #include "refs.h"

 static const char * const builtin_remote_usage[] = {
-	"git remote [-v | --verbose]",
+	"git remote",
 	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
 	"git remote rm <name>",
 	"git remote set-head <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [group]",
+	"git remote update [-p | --prune] [group]",
 	NULL
 };

-- 
1.6.5.2.180.gc5b3e.dirty
