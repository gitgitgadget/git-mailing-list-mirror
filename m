From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] daemon: documentation for --reuseaddr, --detach and --pid-file
Date: Fri, 14 Jul 2006 17:53:29 +0200
Message-ID: <E1G1Pyr-0004uv-JX@moooo.ath.cx>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx> <E1G0zj7-0001c1-8q@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 14 17:55:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Pyz-0003tS-2z
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 17:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbWGNPxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 11:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWGNPxe
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 11:53:34 -0400
Received: from moooo.ath.cx ([85.116.203.178]:54163 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161137AbWGNPxd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 11:53:33 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <E1G0zj7-0001c1-8q@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23893>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
Matthias Lederhofer <matled@gmx.net> wrote:
> Documentation will follow if the changes are ok.
Here it is.  I just found that --reuseaddr is not documented yet too
(I could really have used that while testing the git-daemon
patches...) but I have no idea how to describe it for someone who
does not know what it means.  Perhaps someone else has an idea.
---
 Documentation/git-daemon.txt |    8 +++++++-
 daemon.c                     |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 4c357da..f5b08a6 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
-	     [directory...]
+	     [--reuseaddr] [--detach] [--pid-file=file] [directory...]
 
 DESCRIPTION
 -----------
@@ -82,6 +82,12 @@ OPTIONS
 --verbose::
 	Log details about the incoming connections and requested files.
 
+--detach::
+	Detach from the shell. Implies --syslog.
+
+--pid-file=file::
+	Save the process id in 'file'.
+
 <directory>::
 	A directory to add to the whitelist of allowed directories. Unless
 	--strict-paths is specified this will also include subdirectories
diff --git a/daemon.c b/daemon.c
index e4ec676..810837f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -19,7 +19,7 @@ static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
-"           [--reuseaddr] [directory...]";
+"           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
-- 
1.4.1.g8b4b
