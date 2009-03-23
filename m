From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] Documentation: git-format-patch.txt rewordings and cleanups
Date: Mon, 23 Mar 2009 03:21:23 -0700
Message-ID: <1237803683-14939-1-git-send-email-bebarino@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 11:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhJ5-0001bo-UW
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbZCWKV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbZCWKV2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:21:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:61028 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbZCWKV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:21:28 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1015458rvb.5
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=SNhShEuj94qUOfFj/lQtGr18wHkOpLnkyCl2WvNFrn8=;
        b=LcCTl0PkAuGBjIMXl830GDuU19wJKwxFNxH2UABkK8FRRxp2zeYZBq5ofyW27sBdnj
         lsPeyUaDWgO9W30RFMGvokISTUykT75hsYN49W7rA/KIhItNCN2Fmr8TCz94fPe5bsfh
         sI93mfo/PatNOzs3/pz7doxqSBz8lw6HwkC6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=DYxUWOShxNF/fksxB1l1KXPTeMP9RL0UcgdqUXdBW2nznDdpfYErKE32aJBrVbtK5K
         /JCKLMXHEXNBd40QsHXMlx9d5BFUrmwiQ+NK9q38DuPx7fAF4R8vS6axeeFJkS1bypfm
         Cs/wVnCVKy1lHP04Z+tyAghJ/wv4UUF2dLZZ0=
Received: by 10.142.230.11 with SMTP id c11mr2787823wfh.246.1237803686073;
        Mon, 23 Mar 2009 03:21:26 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id b8sm6243084rvf.3.2009.03.23.03.21.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 03:21:25 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 23 Mar 2009 03:21:23 -0700
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114271>

Clarify --no-binary description using some words from the original
commit 37c22a4b (add --no-binary, 2008-05-9). Cleanup --suffix and
--thread descriptions. Add --thread style option to synopsis. Clarify
renaming patches example.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
Is the synopsis getting too heavy? Maybe it should be changed to:

    git format-patch [<options>] [<common diff options>] [<revision range>]

 Documentation/git-format-patch.txt |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c2eb5fa..f31098b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,9 +9,9 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git format-patch' [-k] [-o <dir> | --stdout] [--thread]
+'git format-patch' [-k] [-o <dir> | --stdout] [--thread[=<style>]]
 		   [--attach[=<boundary>] | --inline[=<boundary>] |
-		     [--no-attach]]
+		    --no-attach]
 		   [-s | --signoff] [<common diff options>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
@@ -132,9 +132,9 @@ include::diff-options.txt[]
 	the Message-Id header to reference.
 +
 The optional <style> argument can be either `shallow` or `deep`.
-'Shallow' threading makes every mail a reply to the head of the
+'shallow' threading makes every mail a reply to the head of the
 series, where the head is chosen from the cover letter, the
-`\--in-reply-to`, and the first patch mail, in this order.  'Deep'
+`\--in-reply-to`, and the first patch mail, in this order.  'deep'
 threading makes every mail a reply to the previous one.  If not
 specified, defaults to the 'format.thread' configuration, or `shallow`
 if that is not set.
@@ -169,24 +169,24 @@ if that is not set.
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
+Note the first letter is not required to be a dot, you will need to
+include the leading dot `.` if you want a filename like
+`0001-description-of-my-change.patch`.
 
 --no-binary::
-	Don't output contents of changes in binary files, just take note
-	that they differ.  Note that this disable the patch to be properly
-	applied.  By default the contents of changes in those files are
-	encoded in the patch.
+	Do not output contents of changes in binary files, instead
+	display a notice that those files changed.  Patches generated
+	using this option cannot be applied properly, but they are
+	still useful for code review.
 
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message
-in the repository configuration, new defaults for the subject prefix
-and file suffix, control attachements, and number patches when outputting
+in the repository configuration, defaults for the subject prefix
+and file suffix, configure attachments, and number patches when outputting
 more than one.
 
 ------------
@@ -234,8 +234,8 @@ $ git format-patch -M -B origin
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
1.6.2
