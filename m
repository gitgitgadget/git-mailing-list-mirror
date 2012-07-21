From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/7] i18n: New keywords for xgettext extraction from sh
Date: Sat, 21 Jul 2012 23:50:50 +0800
Message-ID: <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:52:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsbzC-0005hz-8G
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab2GUPw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:52:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55391 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2GUPvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:51:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8041000pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=+6+mBErLXV/48CZrRbL9AQWMsAmA5xKcvVTcX/KISio=;
        b=IAYsN1OytV8oFDIMeRjLOb/8LyZs5EcDuLKH0FQ1w0DR1jkjlnhSsIz2SsuRRqK/2N
         m5w6i6eqXS/d6xQs4IMGiffEw5769bfRHll2tDs9i91uacISHvw5QQq8bgp5zxR14ObF
         0yHwVEw/Nnh74Y+44HqZa/SNP9PGbD4cxR3K5Xu1O/keqeKEXLsD/9MownfZsHQajwA7
         4PVHk2UiMyqahWWAjJjYYLAudE4BlEUggLUPPU+e3oeun8g02EJ4KvstPor1ktRf/6xQ
         +6a3XT18RXJmccF6ACZqMRQuvFpuJc+EICd7hbv4S7PC+8V7/op5vMrgNMjIDjV8cXUT
         CfpA==
Received: by 10.68.221.70 with SMTP id qc6mr22870912pbc.92.1342885913143;
        Sat, 21 Jul 2012 08:51:53 -0700 (PDT)
Received: from localhost.localdomain ([123.116.228.123])
        by mx.google.com with ESMTPS id nj4sm6241849pbc.5.2012.07.21.08.51.47
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:51:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <cover.1342884458.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342884458.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201819>

Since we have additional shell wrappers (gettextln and eval_gettextln)
for gettext, we need to take into account these wrapers when run
'make pot' to extract messages from shell scripts.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 285c66..e1692 100644
--- a/Makefile
+++ b/Makefile
@@ -2376,7 +2376,8 @@ XGETTEXT_FLAGS = \
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
1.7.11.2.259.g37fc0e1
