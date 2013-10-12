From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 08/14] submodule: add --staged options
Date: Sat, 12 Oct 2013 02:04:46 -0500
Message-ID: <1381561488-20294-13-git-send-email-felipe.contreras@gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMZ-0004MJ-72
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805Ab3JLHL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:29 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:50025 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab3JLHL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:26 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so3467647obc.14
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hAjGQSQhk6Y1wUNJYc6c3YrDF/lZDa73MDGwQc0EhJ0=;
        b=dLq0KjHHyAmHTS/UF0DXCVqP7Ez37NQj3Ueg1sS6BIVT3UxK8xU4urNA5tcqq651W8
         tvTMP8y1uKK5hXvWcpXrZt10JrglnJczr+WT2cly08kQR5Ty6nKxGPi3G+YVfXD5Hxn1
         7fyui4unfXwiXvSD9J2Y7rzfX6CjUhZeIJ36WldADSDZBfY8VdnsyZ/P+VutffNXaaj1
         +NTiqW4m+2oGedII0zLBhp1At8lZdWntLe7eGrReQRM8sc2r5mEG5ZyaelK59pXwXfFC
         NLL7E/niX8S9ifeM7cMbG3vHNsbXq3rUrKbqg0dki68x7EkuwpLXJQ2vRglX9aGklWjL
         fHLQ==
X-Received: by 10.60.173.205 with SMTP id bm13mr17710852oec.25.1381561885395;
        Sat, 12 Oct 2013 00:11:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm101374115oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235974>

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
index 2979197..823b783 100755
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
@@ -972,7 +972,7 @@ cmd_summary() {
 	while test $# -ne 0
 	do
 		case "$1" in
-		--cached)
+		--cached|--staged)
 			cached="$1"
 			;;
 		--files)
@@ -1181,7 +1181,7 @@ cmd_status()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		--cached)
+		--cached|--staged)
 			cached=1
 			;;
 		--recursive)
@@ -1348,7 +1348,7 @@ do
 		esac
 		branch="$2"; shift
 		;;
-	--cached)
+	--cached|--staged)
 		cached="$1"
 		;;
 	--)
-- 
1.8.4-fc
