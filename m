From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] bash completion: Add long options for 'git describe'
Date: Fri, 25 Jul 2008 12:02:50 +0200
Message-ID: <1216980170-14136-1-git-send-email-trast@student.ethz.ch>
Cc: gitster@pobox.com, "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:03:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMK9G-0000nM-8B
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbYGYKCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYGYKCl
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:02:41 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:25896 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbYGYKCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:02:41 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 25 Jul 2008 12:02:39 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 25 Jul 2008 12:02:38 +0200
X-Mailer: git-send-email 1.6.0.rc0.48.g3fa0a
X-OriginalArrivalTime: 25 Jul 2008 10:02:38.0851 (UTC) FILETIME=[91EA0D30:01C8EE3D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90021>

---

It seemed so tedious to type --always so I wrote this instead ;-)

 contrib/completion/git-completion.bash |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3b04934..421431c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -665,6 +665,17 @@ _git_commit ()
 
 _git_describe ()
 {
+	__git_has_doubledash && return
+
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--all --tags --contains --abbrev= --candidates=
+			--exact-match --debug --long --match --always
+			"
+		return
+	esac
 	__gitcomp "$(__git_refs)"
 }
 
-- 
1.6.0.rc0.48.g3fa0a
