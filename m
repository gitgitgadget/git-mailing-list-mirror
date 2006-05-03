From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] add documentation for update-index --unresolve
Date: Wed, 3 May 2006 12:53:19 +0200
Message-ID: <20060503105319.GB10627@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Wed May 03 12:53:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbEyy-0001H8-TK
	for gcvg-git@gmane.org; Wed, 03 May 2006 12:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWECKxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 06:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWECKxW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 06:53:22 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:63185 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S965148AbWECKxW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 06:53:22 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Wed, 3 May 2006 12:53:20 +0200
Received: from spinlock.ch ([129.132.210.205]) by xfe0.d.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Wed, 3 May 2006 12:53:20 +0200
Received: (nullmailer pid 10739 invoked by uid 1000);
	Wed, 03 May 2006 10:53:19 -0000
To: git@vger.kernel.org, junkio@cox.net
Mail-Followup-To: git@vger.kernel.org, junkio@cox.net
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-rc3-g532f57da (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 03 May 2006 10:53:20.0650 (UTC) FILETIME=[CAB73EA0:01C66E9F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19469>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>

---

I am not sure if this is already clear enough. Maybe this needs more
explanation in the manpage?

---

 Documentation/git-update-index.txt |    6 +++++-
 update-index.c                     |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

aa88546740e88b674335e26e342b53e623dcb5c6
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 74844d1..a5afaaf 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
-	     [--really-refresh]
+	     [--really-refresh] [--unresolve]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin]
 	     [--verbose]
@@ -80,6 +80,10 @@ OPTIONS
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
 
+--unresolve::
+	Restores the 'unmerged' or 'needs updating' state of a
+	file during a merge if it was cleared by accident.
+
 --info-only::
 	Do not create objects in the object database for all
 	<file> arguments that follow this flag; just insert
diff --git a/update-index.c b/update-index.c
index facec8d..9fa3d2b 100644
--- a/update-index.c
+++ b/update-index.c
@@ -473,7 +473,7 @@ static void read_index_info(int line_ter
 }
 
 static const char update_index_usage[] =
-"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--cacheinfo] [--chmod=(+|-)x] [--info-only] [--force-remove] [--stdin] [--index-info] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
-- 
1.3.1.g7464
