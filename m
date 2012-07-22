From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/7] i18n: New keywords for xgettext extraction from sh
Date: Sun, 22 Jul 2012 09:26:05 +0800
Message-ID: <e488b5e8f40859a842f80855a3dd4861a4ced6d0.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sskxa-00012u-VY
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 03:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab2GVB1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 21:27:21 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52289 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab2GVB06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 21:26:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8575153pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=H1sRfUOJ2glC9Xuh2/gFcXlHGIbtxoqYgS6g1BjJg18=;
        b=TcsEr4LEdeT8r8ccRgzuBh+pg3NA/MlKpj0dRaoWo4OXjF1gMwoMNswt+qFOF0AtCj
         HJAnCgW/Yh3W0NjE1cq1MHsBqAO5io+45TOzpcyOtkcmkOMiFhpNOD84uxblXP+OU5Or
         ls5KZz9n6itVCYBT0bIidWUmE2vmsnGm6oj2FZgLef/2kbibMrciglKDceMBLpEvDAkE
         9zgFKuvip0JnpQ3DE7EdLyNuL+a1MrgmzPj3st83WZNib6w68fbMJWnfZOQR2gczSmuw
         WfyutG0EBLqehudymBKUDpgpP0FskNX2XtptffwxUxqOzO85p30NcJuN6cZ/dwYKA732
         5Bkw==
Received: by 10.68.189.135 with SMTP id gi7mr25100406pbc.68.1342920417990;
        Sat, 21 Jul 2012 18:26:57 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id rg10sm6946850pbc.54.2012.07.21.18.26.53
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 18:26:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <cover.1342920089.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201839>

Since we have additional shell wrappers (gettextln and eval_gettextln)
for gettext, we need to take into account these wrappers when run
'make pot' to extract messages from shell scripts.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
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
