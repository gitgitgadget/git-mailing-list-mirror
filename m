From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] git-completion.bash: add remote.pushdefault to config list
Date: Sun, 21 Apr 2013 18:35:51 +0530
Message-ID: <1366549551-18763-6-git-send-email-artagnon@gmail.com>
References: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 15:06:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTtyG-0007Es-Fk
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 15:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab3DUNGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 09:06:16 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57211 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab3DUNGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 09:06:10 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so3083783pab.15
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uztoaX4XpcHthxvLXATy5Rh83SOjVOkra9rBqazw6ok=;
        b=Kx6GNCP0l4xKKhmIUhN0Tf8kUO5PWDSiek4+15auSFDBTLk9qy/c/f5Eta2/OXLosP
         5lz7KUkqkGmBFOSjYXp6KYV7SomgCr3KQjOMkXSPQJ+Jl/JbQ1FUwUGBO/0HzkdaOwc7
         0rGHcrJnG7NvknAslRSDMBpiqrEkcjAIkiJNoAwKLR6dJJrViX/Ei/IGfdQb9dtlW9hE
         lEHUVbQxvVVIlYyClFVOX3CCxQ/+zFvdCUiybDIn09xkbmpDtguyz+bineOvBIshpJP2
         LxCHO3mdp2XB5NQVKYBAUrQS/bxRwQj6lDG+FpzmsNRBpKJqMZndrZK/WlvO7j6f/lUg
         a1qg==
X-Received: by 10.66.154.33 with SMTP id vl1mr7312773pab.60.1366549570319;
        Sun, 21 Apr 2013 06:06:10 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id aa8sm1570112pad.14.2013.04.21.06.06.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 06:06:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366549551-18763-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221951>

224c2171 (remote.c: introduce remote.pushdefault, 2013-04-02)
introduced the remote.pushdefault configuration variable, but forgot
to teach git-completion.bash about it.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fa0d604..d0cb4f1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1829,6 +1829,10 @@ _git_config ()
 		__gitcomp "false true"
 		return
 		;;
+	remote.pushdefault)
+		__gitcomp_nl "$(__git_remotes)"
+		return
+		;;
 	remote.*.fetch)
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
@@ -2208,6 +2212,7 @@ _git_config ()
 		receive.fsckObjects
 		receive.unpackLimit
 		receive.updateserverinfo
+		remote.pushdefault
 		remotes.
 		repack.usedeltabaseoffset
 		rerere.autoupdate
-- 
1.8.2.1.501.gd2949c7
