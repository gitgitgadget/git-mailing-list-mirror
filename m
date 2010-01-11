From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] string-list: remove print_string_list, since it is not used anymore.
Date: Mon, 11 Jan 2010 16:29:49 -0500
Message-ID: <1263245389-1558-1-git-send-email-tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 22:38:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NURyD-0004AT-3r
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 22:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab0AKVig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 16:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285Ab0AKVig
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 16:38:36 -0500
Received: from mail-qy0-f185.google.com ([209.85.221.185]:46491 "EHLO
	mail-qy0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0AKVif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 16:38:35 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2010 16:38:35 EST
Received: by qyk15 with SMTP id 15so9727000qyk.23
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=KLaRiK9NlItoIFk7+cYbaj9IzaDuELdnRHGC729Jxbo=;
        b=sqxllTxrxt6J2sGYc9x6CsezYdGjndnUFAM1BMDGa2K6SV6Ko1ghc/4Tq7tpkx46xA
         x2UILfjg7aTGGwB/T23j3I2qMvWWJAUrW2XjXnE6XUyQfjPW064CDZQXq4FKm3bV1Udz
         leCC7Lv9ug4EM/5n8ue9+PzcNulkEgYULJHjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=TSdis9oBgdGlwn7ePGsIVABrBH9YcHWAjqn5q4+Q00yJDFTUQMfh+7D/nRo5d41L+g
         lQvLya7w9wVdsrWPkyYlqHhzurAki8Kxk7+bNT6O9L2oAt5i+3rknR1L0JMl/1tVowi3
         ZGEzvZF3vZI+CbjoGB8zV6d0Mjj/Ru9vtPopo=
Received: by 10.224.23.131 with SMTP id r3mr16958974qab.273.1263245419111;
        Mon, 11 Jan 2010 13:30:19 -0800 (PST)
Received: from localhost ([201.53.2.165])
        by mx.google.com with ESMTPS id 6sm5106907qwk.51.2010.01.11.13.30.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 13:30:16 -0800 (PST)
X-Mailer: git-send-email 1.6.6.103.g699d2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136668>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 string-list.c |   10 ----------
 string-list.h |    1 -
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/string-list.c b/string-list.c
index 1ac536e..e929745 100644
--- a/string-list.c
+++ b/string-list.c
@@ -138,16 +138,6 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 	list->nr = list->alloc = 0;
 }
 
-
-void print_string_list(const char *text, const struct string_list *p)
-{
-	int i;
-	if ( text )
-		printf("%s\n", text);
-	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].string, p->items[i].util);
-}
-
 struct string_list_item *string_list_append(const char *string, struct string_list *list)
 {
 	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
diff --git a/string-list.h b/string-list.h
index 6569cf6..8598257 100644
--- a/string-list.h
+++ b/string-list.h
@@ -12,7 +12,6 @@ struct string_list
 	unsigned int strdup_strings:1;
 };
 
-void print_string_list(const char *text, const struct string_list *p);
 void string_list_clear(struct string_list *list, int free_util);
 
 /* Use this function to call a custom clear function on each util pointer */
-- 
1.6.6.103.g699d2
