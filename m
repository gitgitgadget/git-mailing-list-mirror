From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 5/8] git-format-patch.txt: general rewordings and cleanups
Date: Thu, 23 Apr 2009 02:37:59 -0700
Message-ID: <1240479482-31366-6-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
 <1240479482-31366-2-git-send-email-bebarino@gmail.com>
 <1240479482-31366-3-git-send-email-bebarino@gmail.com>
 <1240479482-31366-4-git-send-email-bebarino@gmail.com>
 <1240479482-31366-5-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvQ9-0001FG-Iq
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbZDWJiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753829AbZDWJiZ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:7604 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbZDWJiX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:23 -0400
Received: by rv-out-0506.google.com with SMTP id f9so392313rvb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=jhcWl9MfoZZaeHP19r9jtygjwuRsze9th756VEMvnvc=;
        b=pdCA6Pi+veCY6yMZrkw7R+1C+VJWRNPY70ix52HNFalVdTbbf7DptAllF9+Erovb07
         Y/lN+bouBRZ256+ruJAxjt5YJ0XG9OBDQLGF8eC9ht6/OEi4ocjDFLZAW5jfIuwCDzAf
         0TsF53AECGqDwNTi3AxvD2VKrDqLdqKDoFYFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X2mCDqPp0RcQW5oSkjcwtYvsxZq0hKq3p18km32GNc8sqFeid+i/V00eX5KOUQhy/W
         IqtKxEjs2jydgj/LNZX5lqrJ34N1cEn8/EyzKLBl2+E1P4e2BKTqN4k4wwiHBY8qQOJi
         eMi9+VYPotLyIgL6/iZICIjz55WEKxDDz9Be4=
Received: by 10.141.33.8 with SMTP id l8mr252189rvj.294.1240479503314;
        Thu, 23 Apr 2009 02:38:23 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id f42sm2187712rvb.9.2009.04.23.02.38.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:22 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:20 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-5-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117321>

Clarify --no-binary description using some words from the original
commit 37c22a4b (add --no-binary, 2008-05-9). Cleanup --suffix
description. Add --thread style option to synopsis and reorganize it a
bit. Clarify renaming patches example and the configuration paragraph.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-format-patch.txt |   38 ++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4a43c64..5ac9e33 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,10 +9,10 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git format-patch' [-k] [-o <dir> | --stdout] [--thread]
-		   [--attach[=<boundary>] | --inline[=<boundary>] |
-		     [--no-attach]]
-		   [-s | --signoff] [<common diff options>]
+'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
+		   [--thread[=<style>]]
+		   [(--attach|--inline)[=<boundary>] | --no-attach]
+		   [-s | --signoff]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
@@ -20,6 +20,7 @@ SYNOPSIS
 		   [--subject-prefix=Subject-Prefix]
 		   [--cc=<email>]
 		   [--cover-letter]
+		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
 DESCRIPTION
@@ -170,18 +171,17 @@ if that is not set.
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
-	`--suffix=.txt`.
+	`--suffix=.txt`.  Leaving this empty will remove the `.patch`
+	suffix.
 +
-Note that you would need to include the leading dot `.` if you
-want a filename like `0001-description-of-my-change.patch`, and
-the first letter does not have to be a dot.  Leaving it empty would
-not add any suffix.
+Note the leading character does not have to be a dot; for example, you
+can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 
 --no-binary::
-	Don't output contents of changes in binary files, just take note
-	that they differ.  Note that this disable the patch to be properly
-	applied.  By default the contents of changes in those files are
-	encoded in the patch.
+	Do not output contents of changes in binary files, instead
+	display a notice that those files changed.  Patches generated
+	using this option cannot be applied properly, but they are
+	still useful for code review.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
@@ -192,10 +192,10 @@ not add any suffix.
 
 CONFIGURATION
 -------------
-You can specify extra mail header lines to be added to each message
-in the repository configuration, new defaults for the subject prefix
-and file suffix, control attachments, and number patches when outputting
-more than one.
+You can specify extra mail header lines to be added to each message,
+defaults for the subject prefix and file suffix, number patches when
+outputting more than one patch, add "Cc:" headers, configure attachments,
+and signoff patches with configuration variables.
 
 ------------
 [format]
@@ -243,8 +243,8 @@ $ git format-patch -M -B origin
 +
 Additionally, it detects and handles renames and complete rewrites
 intelligently to produce a renaming patch.  A renaming patch reduces
-the amount of text output, and generally makes it easier to review it.
-Note that the "patch" program does not understand renaming patches, so
+the amount of text output, and generally makes it easier to review.
+Note that non-git "patch" programs won't understand renaming patches, so
 use it only when you know the recipient uses git to apply your patch.
 
 * Extract three topmost commits from the current branch and format them
-- 
1.6.2.3
