From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] bash completion: Add long options for 'git rm'
Date: Wed, 23 Jul 2008 15:21:08 -0600
Message-ID: <1216848068-49674-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLlmn-0005Jk-Ve
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbYGWVVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbYGWVVM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:21:12 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:34324 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbYGWVVL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:21:11 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2598978rvb.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=GP1YkzLD2pTE5RUVNRKCR+Q0tpLPAPaGfhlE6JzX8ms=;
        b=Xk7XAEXt7Y9LBS384tjHpGg1WMLqb/xNAqh1pUw9vEhUgg6u9cnfRyAcAiQQAX5Vj6
         sU2yC0fOjEvAIzFrBfm50pKHqR+ECnhEf4xknFtJyvkrZXsZbUntkIF5msFMzmyVGi5P
         b6qcwDNjQCKWfYoA7Md/V9YX2lSAehgzgjQBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RsVx8lGmOnLfYd268kCSeU+LFT92SUSOWW3gPDjHJhCB3kY5vPq/IFslRdZdUMjvgB
         uFNtt10cXC6bKddny4PsNxcBx2GNIBOECEdmcxzmjILz/o+SnX7wxRGNW/cyY/meh+Pg
         qID0GcibndH+MslC852WRdNHZkWlI1woMvFt8=
Received: by 10.141.69.1 with SMTP id w1mr112879rvk.185.1216848070303;
        Wed, 23 Jul 2008 14:21:10 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id f42sm3638888rvb.5.2008.07.23.14.21.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 14:21:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89770>

Options added: --cached --dry-run --ignore-unmatch --quiet

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2edb341..4b7ef69 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1170,6 +1170,20 @@ _git_reset ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_rm ()
+{
+	__git_has_doubledash && return
+
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--cached --dry-run --ignore-unmatch --quiet"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_shortlog ()
 {
 	__git_has_doubledash && return
@@ -1425,6 +1439,7 @@ _git ()
 	rebase)      _git_rebase ;;
 	remote)      _git_remote ;;
 	reset)       _git_reset ;;
+	rm)          _git_rm ;;
 	send-email)  _git_send_email ;;
 	shortlog)    _git_shortlog ;;
 	show)        _git_show ;;
-- 
1.6.0.rc0.14.g95f8
