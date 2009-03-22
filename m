From: Arto Jonsson <ajonsson@kapsi.fi>
Subject: [PATCH] bash completion: add options for 'git fsck'
Date: Sun, 22 Mar 2009 20:49:07 +0200
Message-ID: <20090322184907.GA31350@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 22 20:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlTbq-0006Df-59
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 20:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbZCVTm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756807AbZCVTm6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 15:42:58 -0400
Received: from mail.kapsi.fi ([217.30.184.167]:58282 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876AbZCVTm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 15:42:57 -0400
X-Greylist: delayed 3217 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2009 15:42:56 EDT
Received: from kapsi.fi ([217.30.184.161] helo=lakka.kapsi)
	by mail.kapsi.fi with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <ajonsson@kapsi.fi>)
	id 1LlSjV-00089F-M4; Sun, 22 Mar 2009 20:49:17 +0200
Received: from ajonsson by lakka.kapsi with local (Exim 4.63)
	(envelope-from <ajonsson@lakka.kapsi.fi>)
	id 1LlSjL-0000II-K1; Sun, 22 Mar 2009 20:49:07 +0200
Mail-Followup-To: spearce@spearce.org, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 217.30.184.161
X-SA-Exim-Mail-From: ajonsson@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114168>

Signed-off-by: Arto Jonsson <ajonsson@kapsi.fi>
---
 contrib/completion/git-completion.bash |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ed235f7..e738830 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -952,6 +952,21 @@ _git_format_patch ()
 	__git_complete_revlist
 }
 
+_git_fsck ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--tags --root --unreachable --cache --no-reflogs --full
+			--strict --verbose --lost-found
+			"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_gc ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1880,6 +1895,7 @@ _git ()
 	diff)        _git_diff ;;
 	fetch)       _git_fetch ;;
 	format-patch) _git_format_patch ;;
+	fsck)        _git_fsck ;;
 	gc)          _git_gc ;;
 	grep)        _git_grep ;;
 	help)        _git_help ;;
-- 
1.6.2.GIT
