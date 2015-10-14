From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 27/31] mailinfo: move definition of MAX_HDR_PARSED to closer to its use
Date: Wed, 14 Oct 2015 13:45:53 -0700
Message-ID: <1444855557-2127-28-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxU-0002bU-Ix
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949AbbJNUrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:47:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33696 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358AbbJNUqc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:32 -0400
Received: by pabrc13 with SMTP id rc13so64160325pab.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=1FNYqYCqi8z74XyDRkRdB084OJGzkjmth00BNu/HchQ=;
        b=ZLg8nBgQybjmv0+pU5kC8i03tJkdCvGvxaODkElamSZMNaAAR7FaNLv7Wa58d7akUQ
         0ScxfqFNzbsHBjlb3vTmgwM78ZScSrlE3+sHye+PisR1PuScTOPdgmlcZsUyBOjqbFC/
         +Yv8FmUSNC62K3ZjRdImMnKZo6QfFvyxiU9spv3pOfy9cne0aDq/j3PHnfNPgKLd3eg1
         qbqK1UgeezqfDcTre+a65VoCfioeCRhlTYa1kJ9DVcQ0cfi7ThMO801GMT/5+aPpxeRd
         exUrEyE4c46fbZGgC3VlwKN8xYVb3lOLpt+DICNHjAh1qBTCpJdSer0cbHvFsUiVBbLF
         skdA==
X-Received: by 10.68.143.4 with SMTP id sa4mr5569682pbb.111.1444855592325;
        Wed, 14 Oct 2015 13:46:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id kw10sm11291479pbc.25.2015.10.14.13.46.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:31 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279611>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index f4771ee..de446ec 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -39,8 +39,6 @@ struct mailinfo {
 	struct strbuf log_message;
 };
 
-#define MAX_HDR_PARSED 10
-
 static void cleanup_space(struct strbuf *sb)
 {
 	size_t pos, cnt;
@@ -290,6 +288,7 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 	strbuf_trim(subject);
 }
 
+#define MAX_HDR_PARSED 10
 static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
-- 
2.6.1-320-g86a1181
