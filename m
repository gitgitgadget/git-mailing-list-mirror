From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 29/31] git-rebase--am: remove unnecessary --3way option
Date: Tue, 28 Dec 2010 10:30:46 +0100
Message-ID: <1293528648-21873-30-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYr-0005Wr-Bz
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab0L1Pd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:27 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58332 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab0L1PdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:33:14 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11286158qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iLN4/dDiY/RRivjnm1t6uX7LeFg+Vhbov2TgQUl11Bg=;
        b=Y8aEuyDflUeUyuoEsLOxOefdZQEDFuYdUMLBNvCg9hfqPIm0tCYOoXG/fPh0U9SDTi
         796uHjrbiZNsLd/bmysGVpmzsIyX7+WNrxLJ8iY4J501W5xvtEJUJyJr1TcbarTdD2Jy
         zGAT1fa46epWee/1RfjC30C2DSrujuG0IjL+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ctA01xhlZNsyYeu4GMJLyAxP020KFOp/K+snF+pSebpGE7PHfrRUIXbuVkEiWpgQBh
         ZawyUMCEE3oym35QjIdWNSG0ODURKIZJU13E6k+BBUAEmaW1h3US7FQ69H56GSNAffTs
         JyESBm+qwZrbBkTy76+akz9od1wwTBh9cdVm4=
Received: by 10.224.19.146 with SMTP id a18mr12897151qab.224.1293550393609;
        Tue, 28 Dec 2010 07:33:13 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.33.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:33:12 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164271>

Since 22db240 (git-am: propagate --3way options as well, 2008-12-04),
the --3way has been propageted across failure, so it is since
pointless to pass it to git-am when resuming.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 5acfa00..95608c6 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -7,12 +7,12 @@
 
 case "$action" in
 continue)
-	git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
+	git am --resolved --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	exit
 	;;
 skip)
-	git am --skip -3 --resolvemsg="$RESOLVEMSG" &&
+	git am --skip --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	exit
 	;;
-- 
1.7.3.2.864.gbbb96
