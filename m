From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 08/14] submodule: add --staged options
Date: Fri, 25 Apr 2014 13:12:41 -0500
Message-ID: <1398449567-16314-9-git-send-email-felipe.contreras@gmail.com>
References: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 20:24:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdknC-00079k-1D
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbaDYSXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 14:23:51 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42514 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaDYSXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:23:48 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so4698855obc.29
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O1ph8j9ZmpQwC8y0CyqLxB7DprknKYj1Ik2TuRkWPOA=;
        b=us/RUKQEv1jNdd5ShK9jbbXyzlBmTDwaeY3wq0xmcYugNSlyq6z2be/i4mIuSaa96V
         7Srv9vo0WC70Va1tApPmsnKwcKPMAhxMJ+4V7Xb0W67njJ2UuqWCBaegXrlUk/DkRTDD
         JnDimvxandFFkG1GB5UlI7tRvFy5zwxxr2S5dCZ0KguVhgqingWRW5TtnmLTyHWWfSgv
         JL3cwVyM1KxlWSY3w+nCxEQnFS71Vpf+I7w5vXVZxoFiAZFsrSFhMK23+o4f9y90DS2J
         N5BL8JIRv88eWGFgMt0N3yw07PoS9HzXComWRHnhXb2EMF1O+n9ilaPkdfi9Gxp2KUGz
         me6g==
X-Received: by 10.60.118.1 with SMTP id ki1mr8190915oeb.10.1398450228281;
        Fri, 25 Apr 2014 11:23:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm17046111obq.18.2014.04.25.11.23.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 11:23:47 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398449567-16314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247081>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-submodule.txt |  8 ++++++--
 git-submodule.sh                | 10 +++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bfef8a0..904e007 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -11,13 +11,13 @@ SYNOPSIS
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
-'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
+'git submodule' [--quiet] status [--cached|--staged] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase] [--reference <repository>] [--depth <depth>]
 	      [--merge] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
+'git submodule' [--quiet] summary [--cached|--staged|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--] [<path>...]
@@ -248,6 +248,10 @@ OPTIONS
 	commands typically use the commit found in the submodule HEAD, but
 	with this option, the commit stored in the index is used instead.
 
+
+--staged::
+	Synonym for `--cached`.
+
 --files::
 	This option is only valid for the summary command. This command
 	compares the commit in the index with that in the submodule HEAD
diff --git a/git-submodule.sh b/git-submodule.sh
index 4a30087..af6df79 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,11 +6,11 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
-   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] status [--cached|--staged] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
-   or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
+   or: $dashless [--quiet] summary [--cached|--staged|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
@@ -995,7 +995,7 @@ cmd_summary() {
 	while test $# -ne 0
 	do
 		case "$1" in
-		--cached)
+		--cached|--staged)
 			cached="$1"
 			;;
 		--files)
@@ -1200,7 +1200,7 @@ cmd_status()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		--cached)
+		--cached|--staged)
 			cached=1
 			;;
 		--recursive)
@@ -1367,7 +1367,7 @@ do
 		esac
 		branch="$2"; shift
 		;;
-	--cached)
+	--cached|--staged)
 		cached="$1"
 		;;
 	--)
-- 
1.9.2+fc1.2.gfbaae8c
