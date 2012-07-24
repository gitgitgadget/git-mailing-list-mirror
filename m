From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 1/7] i18n: New keywords for xgettext extraction from sh
Date: Tue, 24 Jul 2012 14:59:29 +0800
Message-ID: <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:00:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZ6K-0001YK-LH
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab2GXHAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 03:00:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43823 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2GXHAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 03:00:03 -0400
Received: by yhmm54 with SMTP id m54so6322967yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=/DPpz7lsXE0f1oj82iX/iC7bdueJZs433VhRNFbhY7I=;
        b=tc9RRD0LjOgEl01BNZ1O5vcb9xjbeuKxdzbUwARibJ+5vTv5O7F4UM0Xp/BAKT0qOI
         CclkFuWCC734gG86Z7DJYxxSfdkwa93oOtcmInN3hpssi7xCPRxQjqMtGCZ567/OMN0q
         Loledk2yRZ+rjfuxnSEEp4G8mUcRPln0fPY5LlNeiQG6ATbb+8x3ZCDcsuUU9GcC4vla
         B2fNdxkW0giJWKjYf++VFvhvzy48x5VCy/tTXR++QIplJOBj3FvTzIo411FidjNbNCb8
         Yiwg6ar99gq+8rXjdc9IQJu0qm80dX+dLXLzg5D3gngVxhCXo9c2+Ic9ppz8Q/H82lyO
         AI5A==
Received: by 10.66.73.5 with SMTP id h5mr2494612pav.79.1343113202196;
        Tue, 24 Jul 2012 00:00:02 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id tj4sm11577579pbc.33.2012.07.23.23.59.56
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:00:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.17.gcb766d3
In-Reply-To: <cover.1343112786.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202011>

Since we have additional shell wrappers (gettextln and eval_gettextln)
for gettext, we need to take into account these wrappers when run
'make pot' to extract messages from shell scripts.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
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
1.7.12.rc0.17.gcb766d3
