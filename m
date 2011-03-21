From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] Makefile: Cover more files with make check
Date: Mon, 21 Mar 2011 02:45:03 -0700
Message-ID: <1300700704-22674-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 10:45:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1bg0-0003gN-TS
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab1CUJpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:45:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54197 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1CUJpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 05:45:21 -0400
Received: by gwaa18 with SMTP id a18so2319375gwa.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=bB/kptxLcQPK2M9uN3KYvcVnfYGkeQ1b8PANxolMfNA=;
        b=oKZLaBx/0mH1YaXEbPVkXjU8R+T/02SHoD0gmNME77OAwu99jVfZp6HRI+vtvYRABs
         KoGSA0dp8wyAHwA91F1Ou9pigsNm5WqbjiJylxsiS0XKWCXT6v6uX1ozxnDx65oKsALh
         L+DIPx1/Ha7rerggg7YwkHcIDF6W/MCJKym78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MAgcb7EcrXSsEqHQjtKn5ZeEY17mxccvtCqygBdMBOhFOF6MGwnUQJMhnDvBrSmfft
         +pBeZzhVNUhNp+L16HXvQqvKWLqB7111ziQ0WHNGhRger8Mnyl6LkDVk5Mk7ibVhCoGi
         EkqCupZxCkFNItFvgz2rJ5Avv3oDZIhf00fkY=
Received: by 10.150.131.18 with SMTP id e18mr3610599ybd.316.1300700720366;
        Mon, 21 Mar 2011 02:45:20 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id d3sm3017300ybi.5.2011.03.21.02.45.11
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 02:45:13 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 21 Mar 2011 02:45:04 -0700
X-Mailer: git-send-email 1.7.4.1.343.ga91df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169567>

After the builtin/ move 'make check' doesn't cover the builtin/
directory. We could just add builtin/*.c but lets just use GIT_OBJS
instead so we cover future movement of the source files.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 654d8ac..97cd150 100644
--- a/Makefile
+++ b/Makefile
@@ -2176,7 +2176,7 @@ check-sha1:: test-sha1$X
 check: common-cmds.h
 	if sparse; \
 	then \
-		for i in *.c; \
+		for i in $(patsubst %.o, %.c, $(GIT_OBJS)); \
 		do \
 			sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; \
 		done; \
-- 
1.7.4.1.343.ga91df
