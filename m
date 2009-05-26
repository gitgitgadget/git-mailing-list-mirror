From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-push: add bash completion
Date: Wed, 27 May 2009 00:37:08 +0200
Message-ID: <1243377428-27546-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 27 00:37:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M95Gr-0000jO-E5
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 00:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128AbZEZWhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756913AbZEZWhM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 18:37:12 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:45419 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbZEZWhK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 18:37:10 -0400
Received: by fxm12 with SMTP id 12so2420001fxm.37
        for <git@vger.kernel.org>; Tue, 26 May 2009 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vtSYG43mkJo3av48SfVi/j0fjfHhgJ9cfxyHRpFYuDY=;
        b=WOif4v9KHS8ovYEJLZkeqzFwYj2ffhBAV6tjGiG7F10pdPjbhZe5J1tXY5hTes+ai7
         vH/4UiTlWzKL+7JEL0tNRENdBxcBCeRskUDJK8xpdcaYeEAjcKl7Iwg3UaRGa6ZnS/uj
         TxrQa2oiM+FztJDeQx6YcEmlnX2G+iV1NVmhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ccCI4x6yGPCRwBJ0nhPTws9nd+UL/BLq8sJUw/2gE0jp1bRo4xReYHRUuI59VeDy/8
         5YBeVnPwoBfAkgXCDUxMAd8mVjG5CVu5efYPMzr7DANAleg8AXFEVidmZd771ICWh7qk
         80ncpYYFceF1C2nUwsiQaY3m0wUMZc4fR2O/s=
Received: by 10.86.33.10 with SMTP id g10mr7512410fgg.21.1243377431461;
        Tue, 26 May 2009 15:37:11 -0700 (PDT)
Received: from localhost (drsd-4db3d3cf.pool.einsundeins.de [77.179.211.207])
        by mx.google.com with ESMTPS id d4sm14327059fga.14.2009.05.26.15.37.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 May 2009 15:37:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.463.g124d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120014>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 contrib/tg-completion.bash |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index de8a7b5..5b9ef31 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -370,6 +370,26 @@ _tg_patch ()
 	esac
 }
 
+_tg_push ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	__tg_complete_arg "-r" && {
+		__tgcomp "$(__tg_remotes)"
+		return
+	}
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			-r
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_topics)"
+	esac
+}
+
 _tg_remote ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -449,6 +469,7 @@ _tg ()
 	info)        _tg_info ;;
 	mail)        _tg_mail ;;
 	patch)       _tg_patch ;;
+	push)        _tg_push ;;
 	remote)      _tg_remote ;;
 	summary)     _tg_summary ;;
 	update)      _tg_update ;;
-- 
tg: (b725fc9..) bw/push-completion (depends on: master)
