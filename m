From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] Update 'git remote' usage and man page to match.
Date: Wed, 11 Nov 2009 20:56:56 -0500
Message-ID: <32c343770911111756q5cf5b9a9obfc739d3a8a237c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 02:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Ovp-00025y-5g
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 02:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759896AbZKLB4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 20:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759888AbZKLB4x
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 20:56:53 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53481 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759522AbZKLB4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 20:56:52 -0500
Received: by bwz27 with SMTP id 27so1721887bwz.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 17:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=/NmjD29r3ocRLxmjcrEaJiGH42ODL5ApvGCVHqfho3g=;
        b=Bw0d3NfncoJNX9TPZ1yIRHRRDucUzs5rfMvztvPgx86F8qG2vwQhhJbtEouK151kq7
         ws08P4gb8uHtSTWhxmuWhk5AxC7l+ZyxQHRzrXUayNtAPRoVAB13ek2WXinscGLEIHV+
         Biw2n5d8vEEAnukww+ENzF1j048HX1HTnnQpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=voicMBCeDSp13fjLWAgCaTXcIPvYdNZtl4bkls5yS6dE0zSDSKD8ouj7Z86Kk+W7//
         hKbAYUeYZEOM5rWETUMMJ3ZVyTcundMVPukg5wZP/4+eFJ6GVNNiq0Fsn/xOerwvCIHP
         Eh2TSzmOO9NGOqmmaiCfRSAbbHjU0KRE7lQGw=
Received: by 10.216.87.68 with SMTP id x46mr800710wee.2.1257991016926; Wed, 11 
	Nov 2009 17:56:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132732>

This commit:

1) Removes documentation of '--verbose' from the synopsis portion
of the usage string since it is a general option.

2) Removes the 'remote' option from 'git remote update' in the
man page.  This option had already been removed from the usage
string in the code, but the man page was not updated to match.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

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
