From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 12/13] fast-export: trivial cleanup
Date: Wed, 28 Nov 2012 23:11:08 +0100
Message-ID: <1354140669-23533-13-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdpru-0003JU-94
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825Ab2K1WMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:12:07 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932823Ab2K1WME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:12:04 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RbAzQQQe2+POCZW/OBw0iOkeCRrsaMgb340e9N/NAsw=;
        b=RuffWkAN4RGOnZNDAlIl6aGPQizhfXryLHvjLQLLvlq5D3CpLa0euPJa9LGL1Ykwor
         2xV6NEKVPLP/dhtQJpBe6ySP1d5QNUJChqeS771JF2rw/9AZ1Gituz9djY+9XAUF5elY
         GtR5ztgmceY0lOWudq63NADdliQmCFnVoGE2RMXIFgbL8tOi/EgSIF0+I1BF+5lp5J/l
         Yu1kv3jNmzNzoCwHH4LRccr9Lukn+5fI8l+URrV7HUNjWERWmJf4D1VjgtZk1QZiDT+G
         KcjDfayJEMwjndarpYlRaJ0mnTv21og0mYy+MRjZUT3yrgHI2PCB+snN/ZZ4ivFQtO8L
         EnPg==
Received: by 10.204.9.22 with SMTP id j22mr6081446bkj.114.1354140724063;
        Wed, 28 Nov 2012 14:12:04 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id q22sm13863734bkv.16.2012.11.28.14.12.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:12:02 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210790>

Setting 'commit' to 'commit' is a no-op. It might have been there to
avoid a compiler warning, but if so, it was the compiler to blame, and
it's certainly not there any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9b70ec1..191936c 100644
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
1.8.0.1
