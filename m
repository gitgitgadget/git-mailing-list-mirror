From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/4] fast-export: trivial cleanup
Date: Tue, 30 Oct 2012 20:06:24 +0100
Message-ID: <1351623987-21012-2-git-send-email-felipe.contreras@gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTH9O-0002n0-6g
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934216Ab2J3TGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:06:43 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52686 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934115Ab2J3TGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:06:42 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so340997bkc.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C8djensifASljo+29dQahc4UEkZob0L8la9JkPYuzYA=;
        b=iSokV+8Zk2TWuX9CMhJsCdqgdL/90kg5AmMG7coElPrV2AIPzIF7xWU+Je1mA22ihy
         MN0e5tylETmG3+bEn0tuHARllV3rphKx6tG29irs0i0PoGoKW0ygDrCjFueO5esVevpb
         fXErPoiFWOVeHLwzc4nOC7hlPwvq0v3vUPJ2WaZTIRMmPsLeUvp3E/hMFpl3UJJxQxyg
         1OEwDZyf/g7AhEJpcVhmOjIpC+ak5yYz5NjwAlEBxRwf4FVWq6qjSNFitSgbhubwCXFn
         Adw6IjDGf0/SsXKG8U0OedwtS4DNv6ft0WELSroS+7MZqTw9i+6CrLe4aO5yADCeXNMN
         CdGQ==
Received: by 10.204.150.200 with SMTP id z8mr10203412bkv.139.1351624001695;
        Tue, 30 Oct 2012 12:06:41 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id k21sm1979512bkv.1.2012.10.30.12.06.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 12:06:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208727>

Setting commit to commit is a no-op. It might have been there to avoid a
compiler warning, but if so, it was the compiler to blame.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12220ad..065f324 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -483,7 +483,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 	for (i = 0; i < pending->nr; i++) {
 		struct object_array_entry *e = pending->objects + i;
 		unsigned char sha1[20];
-		struct commit *commit = commit;
+		struct commit *commit;
 		char *full_name;
 
 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
-- 
1.8.0
