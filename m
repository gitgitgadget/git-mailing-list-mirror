From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/2] quote: move comment before sq_quote_buf()
Date: Sat,  3 Oct 2015 21:10:47 +0200
Message-ID: <1443899447-8665-2-git-send-email-chriscool@tuxfamily.org>
References: <1443899447-8665-1-git-send-email-chriscool@tuxfamily.org>
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 03 21:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiSED-0003AS-VX
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 21:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbbJCTML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 15:12:11 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37420 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbJCTLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 15:11:51 -0400
Received: by wicfx3 with SMTP id fx3so67547289wic.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oxzc5n2F7kHz9WcN1yUb5T+Fm6gSeR4xWqY7tepytlg=;
        b=I/Ncx/I/JPnWKLbUaTWkNkvTzXw1ExzSFYqCdV4p7bC4H3kOcAyxTvYLcf+B/5URgk
         yXBD8B8898hniSyDzv3luNQ6830DBxrt3mH5CkN1SvmgWOUrjtJKMrOVzD4FYD0CIECt
         WQL4LF3hzlZmmiOzBs+xnWH6vvesEAi5HwoYbxoSL6xqR3EU/bdv+TT78zogSD6XPKKG
         Qu0FBt7cPPmdEH6FozUZxDCJg91C3d2CyYyrxkW8cAwjhCOfBpy1ryYpfX1qbPAcgv9O
         2/02cl8Scne4AsAiJ3Vaa5AGFHxSk/p2/CEFf5y3HDfH2tZFvE6BbIZuVG2xs06MYH3w
         4fVg==
X-Received: by 10.194.134.98 with SMTP id pj2mr25721049wjb.30.1443899510255;
        Sat, 03 Oct 2015 12:11:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id lj12sm5499262wic.0.2015.10.03.12.11.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Oct 2015 12:11:48 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.0.rc2.23.g0e57679
In-Reply-To: <1443899447-8665-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278983>

A big comment at the beginning of quote.c is really
related to sq_quote_buf(), so let's move it in front
of this function.
---
 quote.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/quote.c b/quote.c
index 890885a..fe884d2 100644
--- a/quote.c
+++ b/quote.c
@@ -4,6 +4,11 @@
 
 int quote_path_fully = 1;
 
+static inline int need_bs_quote(char c)
+{
+	return (c == '\'' || c == '!');
+}
+
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
@@ -16,11 +21,6 @@ int quote_path_fully = 1;
  *  a'b      ==> a'\''b    ==> 'a'\''b'
  *  a!b      ==> a'\!'b    ==> 'a'\!'b'
  */
-static inline int need_bs_quote(char c)
-{
-	return (c == '\'' || c == '!');
-}
-
 void sq_quote_buf(struct strbuf *dst, const char *src)
 {
 	char *to_free = NULL;
-- 
2.6.0.rc2.23.g0e57679
