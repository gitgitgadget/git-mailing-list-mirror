From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 1/7] i18n: New keywords for xgettext extraction from sh
Date: Wed, 25 Jul 2012 16:34:06 +0800
Message-ID: <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 10:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stx3W-0002NX-Kk
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 10:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab2GYIes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 04:34:48 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56034 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753Ab2GYIeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 04:34:46 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so445314ghr.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=Krbp54tOfujGMdc4rllOwxbS6e1ATrgn8oFLUWEMs44=;
        b=MNqCO/j780ALjvRM/p4+5g4tfoZ+bs5QOjCbRyL8dTXUYk6ByNYWjr1v0UyhVjChnK
         +ODW2HVOGxDiK0fWcm9q1gtRHw0YF/Y9Mx8Hgg98YcDQZ0/YryDSHSnczgcj21Ghb4as
         EV/VU84POuvcA80Hq4zBQeam7dYWgT1RwInM2P8nItbZ4mnx0cbv9WHn/O/dhkkdzJgl
         j9cXLyMLO9L4p2x+uU3GHcsrZatIPVrWOLkTl568eBUW+36lJc3y7jcaIVK+AsqBIx64
         82mWls+XS6ZhHZmuQFtoSx+Me4wIrf6Ch63eYzQYSsHMNg/qBrxM+m4XBQD2sZgLcZkc
         xYFw==
Received: by 10.66.75.97 with SMTP id b1mr11055185paw.15.1343205285617;
        Wed, 25 Jul 2012 01:34:45 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1313386pbb.49.2012.07.25.01.34.38
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 01:34:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <cover.1343205009.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202136>

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
