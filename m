From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] fixup! completion: graduate out of contrib
Date: Thu,  8 May 2014 23:07:55 -0500
Message-ID: <1399608475-19893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 06:18:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WicGn-0005rp-6F
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 06:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbaEIESp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 00:18:45 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:54852 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaEIESp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 00:18:45 -0400
Received: by mail-yk0-f181.google.com with SMTP id 131so3014321ykp.12
        for <git@vger.kernel.org>; Thu, 08 May 2014 21:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iAEWj5X1wZLyOD+cYzf38kD7DY+7sU27UUwryOldg/w=;
        b=GJGhVeDBFe2tYv00dbzf6TmarPy6v9S1N+mid+VOQUev/KzKf3JA+3uKGlTw/3eK+b
         SIGgo2LqKeHRAxKJCPK0fFv/eXq+ZcvbPrZ+u437S+yzcewg4I2xx0j3oUEzEubR2+rI
         k7iIL+G0WsEb689VldQVIgmD+9A4/6Rw23NnbEqqBVg2wGaou9ZhU6X3hruPyEetMPCp
         OicP4GQbV4Jps8flH5YLOP24++LQe9Xgpzq8lpULysh6PB/MIwJjWca0gWHfLbN10tai
         o+v+22OKonk6rBRiFaSDHtAPGu0Q/OGFY4hf3pAKsec9LPP7PTO6VNpFji/0J4OiO14L
         z7jQ==
X-Received: by 10.236.131.42 with SMTP id l30mr11279620yhi.130.1399609124631;
        Thu, 08 May 2014 21:18:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 46sm4523824yhg.36.2014.05.08.21.18.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 21:18:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248512>

Actually we need a symlink for gitk. At least ArchLinux doesn't do that,
so we would be fixing at least one bug.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 2690903..a3d27d8 100644
--- a/Makefile
+++ b/Makefile
@@ -2349,6 +2349,9 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -D -m 644 shared/git-completion.bash '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git
+	ln git '$(DESTDIR_SQ)$(bashcompdir_SQ)'/gitk || \
+		ln -s git '$(DESTDIR_SQ)$(bashcompdir_SQ)'/gitk || \
+		cp '$(DESTDIR_SQ)$(bashcompdir_SQ)'/git '$(DESTDIR_SQ)$(bashcompdir_SQ)'/gitk
 	$(INSTALL) -D -m 644 shared/git-prompt.sh '$(DESTDIR_SQ)$(sharedir_SQ)'/git-core/git-prompt.sh
 	$(INSTALL) -D -m 644 shared/git-completion.zsh '$(DESTDIR_SQ)$(sharedir_SQ)'/zsh/site-functions/_git
 ifndef NO_GETTEXT
-- 
1.9.2+fc1.27.gbce2056
