From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 1/7] i18n: New keywords for xgettext extraction from sh
Date: Wed, 25 Jul 2012 22:53:07 +0800
Message-ID: <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:54:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su2yJ-0006xB-2U
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415Ab2GYOxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:53:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40079 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381Ab2GYOxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:53:38 -0400
Received: by pbbrp8 with SMTP id rp8so1526654pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Krbp54tOfujGMdc4rllOwxbS6e1ATrgn8oFLUWEMs44=;
        b=vYTDlVqBxXKt33/yxjC3Pf2BmSoPYsytIxCJGcVC9r/eY/DsuTUnJLTtjIyfkW5m6M
         aR8qVgNKMgqz60JquiGoV5gE1DM1SyMH6B14QsCdxmdeiDJq7BWI+P5FbweNsrIi/BYe
         tGjPCEnqDy8goPDaM3CmhAHZBgAXQOeq+9a1cXUiiUATO9lyrq9F4ri0DueeqJPUmn/J
         RyPPZzYq/Hs9BmicUU4WICbD6phEf7JbU1keKFsqVS2FNDilJCe4UFaErM8u+h9BN+bW
         d6RBQh4V4tiQB7zOkkINGdwB8Z7pDRdwsyqsrr180z5huV+v3TEEU4uAGAVhP0w3eVUw
         JQDg==
Received: by 10.68.222.103 with SMTP id ql7mr53882882pbc.48.1343228018230;
        Wed, 25 Jul 2012 07:53:38 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1886775pbb.49.2012.07.25.07.53.30
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:53:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <cover.1343227806.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202160>

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
