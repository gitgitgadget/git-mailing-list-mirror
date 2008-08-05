From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 2/8] bash completion: Add completion for 'git clean'
Date: Mon,  4 Aug 2008 23:50:32 -0600
Message-ID: <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:52:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFT6-0007dV-7K
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbYHEFut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbYHEFur
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:50:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:56663 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbYHEFuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:44 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753909wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NAEYRIVjPdusFH3J/smP3y2mOdGi6vrTA0fknWiYmRc=;
        b=CCdB3gS6Yril5SEi5p3ksUsXejo5RIlcXFbtAP5V0jFloRZfQwOWjkHyEJslJMpIMK
         OgbBPFfzFmcd7e5Zh0ja6VweawZNik/LXi/V4Fnxn/L1RR8T+DMxIa+xydBbMvPdFQKx
         oRDdDJ1dBnoDXZ1ZudKsDDI2gEV074NcTwOnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EQl84oE13w2wxY6S+lP4kTsTA1TLTbYu79unJWPtGNAIVb0p6SZtRTh5KH8FQp6e1W
         B5a3ZLhH2JGi+h62rBCs+DFcrnR1O3n3UY5AM03s4nb0tl7zRJXZWeDgiiKbJfR4BW1b
         QVvcLgXD578ijaDet1D4yCdgA4nTvPoo7x9XQ=
Received: by 10.142.125.4 with SMTP id x4mr5267532wfc.349.1217915442695;
        Mon, 04 Aug 2008 22:50:42 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:42 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91422>

Added completions for all long options specified in the docs
        --dry-run --quiet

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6ffe259..72be4f1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -667,6 +667,20 @@ _git_cherry_pick ()
 	esac
 }
 
+_git_clean ()
+{
+	__git_has_doubledash && return
+
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--dry-run --quiet"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_clone ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1500,6 +1514,7 @@ _git ()
 	checkout)    _git_checkout ;;
 	cherry)      _git_cherry ;;
 	cherry-pick) _git_cherry_pick ;;
+	clean)       _git_clean ;;
 	clone)       _git_clone ;;
 	commit)      _git_commit ;;
 	config)      _git_config ;;
-- 
1.6.0.rc1.48.g2b6032
