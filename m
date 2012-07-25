From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 1/7] i18n: New keywords for xgettext extraction from sh
Date: Wed, 25 Jul 2012 11:53:42 +0800
Message-ID: <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:54:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsgE-00007r-6o
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359Ab2GYDyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:54:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52643 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271Ab2GYDyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:54:21 -0400
Received: by pbbrp8 with SMTP id rp8so705020pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Krbp54tOfujGMdc4rllOwxbS6e1ATrgn8oFLUWEMs44=;
        b=pnQ+33uVJQtaFYFYODJMtRMr0lRE7TUTYe5tQJaAZV/ebdoo61wuOvBgYmJn8yucbL
         RkkDFv3ysIxyyW8cSmFFqMpjQrqLh729hGALaRBpeJsofe3HBXyXx+qp7v7st6GmfkCa
         FCdEuaN8fvwRLKrclKMM4ZGxM3fsUNefRX4ySIoXFpyrINpw4jGD233uMLQwWcRqwCx9
         eq+QUgnynqa6aCtzA9+rfTeEcyKI6+rTdn/t4Si3ew7u64IXJX50qMyamJpWJtDkP2Jj
         YCqzk1B2BEDuE6cum32WScX5dZLsPfxkrnPw2myJuCIQ7x55LddO7IfWRMtn3pGHUNN7
         Ol0g==
Received: by 10.68.195.167 with SMTP id if7mr50569428pbc.16.1343188460317;
        Tue, 24 Jul 2012 20:54:20 -0700 (PDT)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id rg10sm13463345pbc.54.2012.07.24.20.54.15
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:54:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <cover.1343188013.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202110>

Since we have additional shell wrappers (gettextln and eval_gettextln)
for gettext, we need to take into account these wrappers when running
'make pot' to extract messages from shell scripts.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b0b34..d3cd9 100644
--- a/Makefile
+++ b/Makefile
@@ -2387,7 +2387,8 @@ XGETTEXT_FLAGS = \
 	--from-code=UTF-8
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
-XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell
+XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
+	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
 LOCALIZED_C := $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH := $(SCRIPT_SH)
-- 
1.7.12.rc0.16.gf4916ac
