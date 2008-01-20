From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Update git-completion for new 'remote rm' option
Date: Sun, 20 Jan 2008 00:54:57 -0600
Message-ID: <1200812097-31197-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 07:55:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGU5d-00043C-FZ
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 07:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbYATGzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 01:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbYATGzE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 01:55:04 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:55818 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbYATGzB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 01:55:01 -0500
Received: by py-out-1112.google.com with SMTP id u52so2284134pyb.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 22:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/PU7mJTvV0l+m3Tt8l7vnqQhqKaAUnlF6AV58XfP7QY=;
        b=o+1ZJM1Mv18hbHVuI0LuZAVEbqZXtqvAtdBEdFd4aGlG/IxgsCsdQcPB/KDWWWscHlVx3Z9TddoJK3LokSk795KnpboAlNr3PxvyASKhht9s0vHzK8xIgNVV2MUZydCc7y98KCxW5WIU+3l1K/zCiubSW/daoWkbD0b6Gfs0NNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QcUVvU+2g4BWpHDIuz5rq27xzqlloQ9KTPfhn938h8Fpzoxg5E2b466QrROn7t+zJt2xkKEjp3OKAAwFJPYMsRIfsP45E3McZFQIA+RZkjc9W+3b5T23l0yEeppfDPdItJ1sutzzrE4fAfnG6UR5Mr7MhudfYlODVLn+nxtW+S4=
Received: by 10.35.70.17 with SMTP id x17mr6151921pyk.43.1200812100426;
        Sat, 19 Jan 2008 22:55:00 -0800 (PST)
Received: from localhost ( [76.197.238.51])
        by mx.google.com with ESMTPS id u6sm8599778pyb.23.2008.01.19.22.54.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Jan 2008 22:54:59 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71159>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 contrib/completion/git-completion.bash |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9b0033d..0d33f9a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -970,18 +970,18 @@ _git_remote ()
 	while [ $c -lt $COMP_CWORD ]; do
 		i="${COMP_WORDS[c]}"
 		case "$i" in
-		add|show|prune|update) command="$i"; break ;;
+		add|rm|show|prune|update) command="$i"; break ;;
 		esac
 		c=$((++c))
 	done
 
 	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
-		__gitcomp "add show prune update"
+		__gitcomp "add rm show prune update"
 		return
 	fi
 
 	case "$command" in
-	show|prune)
+	rm|show|prune)
 		__gitcomp "$(__git_remotes)"
 		;;
 	update)
-- 
1.5.4.rc3
