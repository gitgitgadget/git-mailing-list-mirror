From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 1/7] i18n: New keywords for xgettext extraction from sh
Date: Wed, 25 Jul 2012 22:44:01 +0800
Message-ID: <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227045.git.worldhello.net@gmail.com>
References: <cover.1343227045.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:45:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su2py-000083-1z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370Ab2GYOon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:44:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63906 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933279Ab2GYOok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:44:40 -0400
Received: by pbbrp8 with SMTP id rp8so1516221pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Krbp54tOfujGMdc4rllOwxbS6e1ATrgn8oFLUWEMs44=;
        b=TyCp9ineZ6NfnM0aicqh+g2IdM4b609Sva+I4zbc8ZR9Ll781IAp59e2LxlOkxs5x6
         0UwRKR3j17StejlBQRHIo6KnkguhqwsziJDTIrq0v+CmHidppvQtr1TT8V+FMzboNZkQ
         NqusMocBRCRuemjS6VuoXP0oDKglP4V7LkQHTDwaGhsapbxPkbEYF6NZ8Ktw8rQPfTc+
         tpKNUBqve4ZlnVdpZ4XTH+lwrM5aWLxruEQiXHyplmr9m65iy/uUg7xUb8B0Lt7V+hKN
         3ndfqlTsFVE5ZKPvV1zc5cXDwSS6Eo4zyaFtOEsd/yp+RPpv8Ldd1v3y8XaOcncaRmWX
         Idzg==
Received: by 10.68.228.2 with SMTP id se2mr54670585pbc.109.1343227480136;
        Wed, 25 Jul 2012 07:44:40 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id op10sm14492740pbc.75.2012.07.25.07.44.32
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:44:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <cover.1343227045.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227045.git.worldhello.net@gmail.com>
References: <cover.1343227045.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202152>

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
