From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2] Documentation: git-format-patch.txt rewordings and cleanups
Date: Mon, 30 Mar 2009 22:14:33 -0700
Message-ID: <1238476473-22106-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 07:17:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWLV-00030m-LO
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762124AbZCaFOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762085AbZCaFOk
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:14:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:44525 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762095AbZCaFOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 01:14:39 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2825284rvb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 22:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=4ltshFj2O5Pk0f51JeZfd4r9IadotG8v9VLtW6oAurM=;
        b=AYc6Tun+Z1mhoXBYSmfH6Fey2sw65btJxH72Id8qdzqp0uRKWZHtSy6TBXlswlJrdX
         7yxO0abfDdO2x0JbL2nqjlCF6oWZnKExNHEHkYIWrmt6U2wo8Eq85bQ+3ZPuqRyFB7XV
         CU6k2kQuRHBVBiaMUC3mUa5o+GblMKjHaftkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xVyuUWvBueGAmS4NgyniSSE9helQpbGihEjOLb9Dx4DDxdpc5dE70T4pSzuZtFZOkG
         r2OnHM0hDaJS1uzVQU0Mz67GIN3pnmZ0vQhJpsTLq+gmVM1KVvWx0+kOjZTXpEu+zgHX
         3cV9jzY2p4hqEHRtEA/V5sjCgHnIVIKb19Y90=
Received: by 10.141.85.13 with SMTP id n13mr3257401rvl.102.1238476476861;
        Mon, 30 Mar 2009 22:14:36 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k41sm14814705rvb.16.2009.03.30.22.14.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 22:14:36 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 30 Mar 2009 22:14:33 -0700
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115213>

Clarify --no-binary description using some words from the original
commit 37c22a4b (add --no-binary, 2008-05-9). Cleanup --suffix and
--thread descriptions. Add --thread style option to synopsis. Clarify
renaming patches example.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
The --suffix words have been updated per the list discussion.
 Documentation/git-format-patch.txt |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c2eb5fa..e2b7939 100644
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
@@ -169,24 +169,23 @@ if that is not set.
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
+can use --suffix=-patch to get `0001-description-of-my-change-patch`.
 
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
@@ -234,8 +233,8 @@ $ git format-patch -M -B origin
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
