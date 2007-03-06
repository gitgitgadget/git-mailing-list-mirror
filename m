From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Fix diff-options references in git-diff and git-format-patch
Date: Mon, 5 Mar 2007 22:27:44 -0500
Message-ID: <20070306032744.GA15330@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 04:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOQLB-0007Tj-Me
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 04:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933897AbXCFD1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 22:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933905AbXCFD1r
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 22:27:47 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:34258 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933897AbXCFD1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 22:27:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 05B471FFC142
	for <git@vger.kernel.org>; Tue,  6 Mar 2007 03:27:44 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41532>

Most of the git-diff-* documentation used [<common diff options>]
instead of [--diff-options], so make that change in git-diff and
git-format-patch.

In addition, git-format-patch didn't include the meanings of the diff
options.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

On Mar 5, 2007, at 6:14 PM, Johannes Schindelin wrote:

> Actually, it is described briefly in the synopsis. But not in the
> options section. Care to provide a patch (see git-log.txt for an
> example how to include the diff options)?

Something like this?

 Documentation/git-diff.txt         |    2 +-
 Documentation/git-format-patch.txt |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 12a531d..044cee9 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -8,7 +8,7 @@ git-diff - Show changes between commits, commit and working tree, etc
 
 SYNOPSIS
 --------
-'git-diff' [ --diff-options ] <commit>{0,2} [--] [<path>...]
+'git-diff' [<common diff options>] <commit>{0,2} [--] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 59f34b9..84eabeb 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,8 +9,8 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git-format-patch' [-n | -k] [-o <dir> | --stdout] [--attach] [--thread]
-	           [-s | --signoff] [--diff-options] [--start-number <n>]
+'git-format-patch' [<common diff options>] [-n | -k] [-o <dir> | --stdout]
+		   [--attach] [--thread] [-s | --signoff] [--start-number <n>]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
 		   <since>[..<until>]
@@ -46,6 +46,8 @@ reference.
 
 OPTIONS
 -------
+include::diff-options.txt[]
+
 -o|--output-directory <dir>::
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
-- 
1.5.0.3.271.g5ced
