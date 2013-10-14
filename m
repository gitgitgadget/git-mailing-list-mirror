From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/14] submodule: add --staged options
Date: Mon, 14 Oct 2013 17:29:27 -0500
Message-ID: <1381789769-9893-13-git-send-email-felipe.contreras@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:36:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqkj-0007Zn-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab3JNWgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:36:23 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36674 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218Ab3JNWgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:36:20 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so5363742obc.27
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hAjGQSQhk6Y1wUNJYc6c3YrDF/lZDa73MDGwQc0EhJ0=;
        b=oTIR223qcSx/k407KwMjw+K0ocQe9HyWsPUt7LeKx8ENAlYJVEjhB1FT4M+26o9qq4
         MJc0pQGJzZs6wSbDBIeDez/Geqf7YtquN2oexcx6rNZni956e7okhPPKKU3/Qf5HMmxA
         QM1tJyNgztnas2xsc7yy3PHX6/iXjUuUBLnl35m9GtNiX+WF/CTwZ7abpBZXkYFfut4i
         RxcJtgp0cT5v4EVZjDxx+2X9QyKiJCl7Y74wd7mYFcs0q6/dQeD9SE4151SkEG14kv6Q
         ZBNUxB0U6aY4zOmL/1XJGOGHgKT2gy2XNKOLwqaZmqno4vj6VWytO4C1ZLMsyvPLR+GL
         tAAQ==
X-Received: by 10.60.93.67 with SMTP id cs3mr30326721oeb.12.1381790180439;
        Mon, 14 Oct 2013 15:36:20 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm121853055oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:36:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236141>

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
