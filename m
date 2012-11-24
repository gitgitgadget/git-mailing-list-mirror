From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 9/9] fast-export: trivial cleanups
Date: Sat, 24 Nov 2012 04:25:20 +0100
Message-ID: <1353727520-26039-10-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Nu-00079n-Gf
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663Ab2KXD0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:26:06 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab2KXD0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:26:05 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VNEnkFMTDPsQXBKoxn3r23oraoEqXB+xFgZSdfskiz8=;
        b=K19Sv8RNgFdKIVg0IkHlUeL3Oto9sbQOSk7zYwjZlVSfZj3g2h3Y0v0885h/yjKP3o
         7D3uJJKR57hTrKJ2kQ9irIO/SmBG6sOqLsqUDq4PrCzpQnDMmWK1EnYMrpL7AkgkV7pv
         V/qx11XYKnjj767p6Zwje4+Z5tE/X7XW30J2GdJ0vb+u6aMS7Hu31BzhLFZ6Ue44Lm8H
         HYIJN5dLWLcGvxk0CJApC9cKEvgVfX4IuAF3LFezq2XDec7Y+qNrz5I/zJVYXwfEnvSw
         mla1up5BoHfqr5E9FFPbJFd48UZ/3m/r7T6OyStISLtt+r0oxx+HVJqMpOQgaQprrXii
         8O5Q==
Received: by 10.204.149.149 with SMTP id t21mr1674429bkv.85.1353727564052;
        Fri, 23 Nov 2012 19:26:04 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id n27sm5467980bkw.0.2012.11.23.19.26.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:26:03 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210308>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d88fa10..bf5c822 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -548,7 +548,6 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 static void handle_tags_and_duplicates(void)
 {
-	struct commit *commit;
 	int i;
 
 	for (i = extra_refs.nr - 1; i >= 0; i--) {
@@ -560,9 +559,7 @@ static void handle_tags_and_duplicates(void)
 			break;
 		case OBJ_COMMIT:
 			/* create refs pointing to already seen commits */
-			commit = (struct commit *)object;
-			printf("reset %s\nfrom :%d\n\n", name,
-			       get_object_mark(&commit->object));
+			printf("reset %s\nfrom :%d\n\n", name, get_object_mark(object));
 			show_progress();
 			break;
 		}
-- 
1.8.0
