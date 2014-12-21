From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] completion: add --irreversible-delete for format-patch
Date: Sun, 21 Dec 2014 11:50:07 +0000
Message-ID: <20141221115007.GA23500@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 12:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2f1a-0008Gj-6O
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 12:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbaLULuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 06:50:09 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41323 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaLULuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 06:50:08 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F4F1F8A1;
	Sun, 21 Dec 2014 11:50:08 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261613>

Normally I would use "-D", but send-email (which normally passes options
to format-patch) interprets the "-D" as a case-insensitive abbreviation
for "--dry-run", preventing format-patch from seeing "-D".

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Case-insensitivity strikes again! :<
 What a wacky default for Getopt::Long...  And it's probably too late
 for us to disable case-insensitivity in CLI parsing for send-email.

 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2fece98..41d8ff8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1257,6 +1257,7 @@ __git_format_patch_options="
 	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
 	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
 	--output-directory --reroll-count --to= --quiet --notes
+	--irreversible-delete
 "
 
 _git_format_patch ()
-- 
EW
