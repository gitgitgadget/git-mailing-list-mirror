From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] fetch/push: fix usage strings
Date: Sat, 10 Apr 2010 10:50:19 +0800
Message-ID: <1270867819-5224-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 04:50:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0QmM-0007OT-Nq
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 04:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab0DJCud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 22:50:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:64668 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab0DJCuc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 22:50:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1432587qwh.37
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2+fLg50ndmbE/TelIU6PvNwOuyfPhKVghiKl0PhWpTo=;
        b=hwg9p+0SSn/pT2xAodPDgjOFNnzfGHP4vf6cArlTj4HkZXzpGyOVGNkFdJo0xNlfcC
         KR7O+L+nmHKIvSXUsmpS/2163yIEypS7NZAH9ebEHZU22eq41GyGg4NYUjaLp+Rui/pI
         rnnIfjhKSB7JiGNRz3XvOu7X59UPDpLYG4/Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ip9/IGOI5afshlfCA0Cxf2msJ9QdYAioR8sJqmeoI/HD0kpvntLhhaJCsx8HmpE/l7
         0O77EIoli3rsbrxpkAKjG75avZNW7V0C1CWs/OmJd0Y4eMilq7uxYt9wniD3s3khpOXr
         CW1YeTJZwQ9cs5suDwzNTzXN2auI12hWgbZps=
Received: by 10.229.191.18 with SMTP id dk18mr1365902qcb.9.1270867831631;
        Fri, 09 Apr 2010 19:50:31 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id v26sm2655508qce.1.2010.04.09.19.50.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 19:50:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc0.240.gba75f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144496>

 - use "<options>" instead of just "options".
 - use "[<repository> [<refspec>...]]" to indicate that <repository> and
   <refspec> are optional, and that <refspec> cannot be specified
   without specifying <repository>.

Note that when called without specifying <repository> (eg. "git fetch
-f"), it is accurate to say that the "git fetch [<options>]
[<repository> ...]" case takes precedence over "git fetch [<options>]
<group>".

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Related to, but does not depend on, the recent ls-remote patch.

 Documentation/git-fetch.txt |    8 ++++----
 Documentation/git-push.txt  |    2 +-
 builtin/fetch.c             |    8 ++++----
 builtin/push.c              |    2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 948ea26..400fe7f 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -8,13 +8,13 @@ git-fetch - Download objects and refs from another repository

 SYNOPSIS
 --------
-'git fetch' <options> <repository> <refspec>...
+'git fetch' [<options>] [<repository> [<refspec>...]]

-'git fetch' <options> <group>
+'git fetch' [<options>] <group>

-'git fetch' --multiple <options> [<repository> | <group>]...
+'git fetch' --multiple [<options>] [<repository> | <group>]...

-'git fetch' --all <options>
+'git fetch' --all [<options>]


 DESCRIPTION
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 59dc8b1..4857024 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-v | --verbose] [-u | --set-upstream]
-	   [<repository> <refspec>...]
+	   [<repository> [<refspec>...]]

 DESCRIPTION
 -----------
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 957be9f..8470850 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -14,10 +14,10 @@
 #include "transport.h"

 static const char * const builtin_fetch_usage[] = {
-	"git fetch [options] [<repository> <refspec>...]",
-	"git fetch [options] <group>",
-	"git fetch --multiple [options] [<repository> | <group>]...",
-	"git fetch --all [options]",
+	"git fetch [<options>] [<repository> [<refspec>...]]",
+	"git fetch [<options>] <group>",
+	"git fetch --multiple [<options>] [<repository> | <group>]...",
+	"git fetch --all [<options>]",
 	NULL
 };

diff --git a/builtin/push.c b/builtin/push.c
index 62957ed..f4358b9 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"

 static const char * const push_usage[] = {
-	"git push [<options>] [<repository> <refspec>...]",
+	"git push [<options>] [<repository> [<refspec>...]]",
 	NULL,
 };

--
1.6.6.1368.g82eeb
