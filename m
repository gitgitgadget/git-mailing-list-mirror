From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 5/8] git-format-patch.txt: general rewordings and cleanups
Date: Thu, 23 Apr 2009 09:16:52 -0700
Message-ID: <1240503412-6790-1-git-send-email-bebarino@gmail.com>
References: <49F05B90.8050208@drmicha.warpmail.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 18:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx1dY-0002fx-Bm
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 18:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZDWQRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 12:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753698AbZDWQRB
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 12:17:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:35460 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbZDWQRA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 12:17:00 -0400
Received: by rv-out-0506.google.com with SMTP id f9so569239rvb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0TvUREDp8yjLn7RNtaZVY+BWiuA13KU0X5vv+ymF5i4=;
        b=ml568zpOnFFmFFq0AdzaeQUXVRBIdkm/VQFkafhxMEdshgtZufpnppxuEQNKhlHR98
         t9Umx4TGGqGMtSNqGkcwDmvzUHx+bS68Rdr2r+8zbr2M9FxU84b/9XHyXhMCwxV3XRjv
         /M2dZE90tqEdmQF3eO7+Z1zqfIUGa1vXzsFuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GxHi9qhuBYIm+OeQbjIE116a2ByQbg2M59zd4R17zC7kCapWGZwAQV324aCUyv/oM3
         ONhaP7Tk0PBXYESNfqxsq3H7v8iJd/aX6rZcyc31SNOeTQBRakaFx0HC83BjYDlQZhr9
         t1nwIES0YkRuyHE3euW/eRf0cY2gc5AG8xfX8=
Received: by 10.141.172.7 with SMTP id z7mr369832rvo.126.1240503419665;
        Thu, 23 Apr 2009 09:16:59 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id g14sm314352rvb.18.2009.04.23.09.16.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 09:16:58 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 09:16:52 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <49F05B90.8050208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117345>

Clarify --no-binary description using some words from the original
commit 37c22a4b (add --no-binary, 2008-05-9). Cleanup --suffix
description. Add --thread style option to synopsis and reorganize it a
bit. Clarify renaming patches example and the configuration paragraph.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

    Fix some issues brought up by Michael J Gruber

 Documentation/git-format-patch.txt |   38 ++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4a43c64..6f1fc80 100644
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
+Note that the leading character does not have to be a dot; for example,
+you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 
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
+and sign off patches with configuration variables.
 
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
