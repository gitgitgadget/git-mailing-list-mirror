From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] alias: trivial style fixes
Date: Sat, 21 Sep 2013 14:15:44 -0500
Message-ID: <1379790944-27673-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 21:21:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSjz-0005g3-FP
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 21:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3IUTVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 15:21:11 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:45057 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3IUTVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 15:21:11 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo20so2105038obc.41
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HT/4WG1PTV7unMimdOw8HSJBha6QFUMErROL4Z2T1go=;
        b=kma0HJp2G5Nvte6YAo6bnpUfDZe44Gb5zgSX7nwiU/HidJxwLXt/sWeYKBRZe5hkwy
         o0qLqe4UGtXe8XQ2uLce//K6e2rSjC0ImyxnokRxlb9MLA1lah97ceBs0ZaDymZzmHC0
         vJ49p+hlMor/bNAqIIB8YIVd1Ky174puYsyDYdnE4x23r0H82eCbeGKBurXJpD5FgpmK
         nJ5ZnWWdwFIHtLjy37hC6vdROCdT9u7RmKWaAKRP0Kh7SMvlWP87crxIxDRrqbPBTqjN
         ZBWqqbEZ+PDQ2TGliigIkNWHa1wEeR5SAY4At9JBRuWtkIJOG5kl02tEpdsVt8Ildkkc
         rUqQ==
X-Received: by 10.182.237.75 with SMTP id va11mr11936989obc.5.1379791270822;
        Sat, 21 Sep 2013 12:21:10 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm7861332oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 12:21:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235144>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 alias.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/alias.c b/alias.c
index eb9f08b..9938f03 100644
--- a/alias.c
+++ b/alias.c
@@ -5,7 +5,7 @@ static char *alias_val;
 
 static int alias_lookup_cb(const char *k, const char *v, void *cb)
 {
-	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
+	if (!prefixcmp(k, "alias.") && !strcmp(k + 6, alias_key)) {
 		if (!v)
 			return config_error_nonbool(k);
 		alias_val = xstrdup(v);
@@ -34,7 +34,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 	int src, dst, count = 0, size = 16;
 	char quoted = 0;
 
-	*argv = xmalloc(sizeof(char *) * size);
+	*argv = xmalloc(sizeof(**argv) * size);
 
 	/* split alias_string */
 	(*argv)[count++] = cmdline;
@@ -45,7 +45,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 			while (cmdline[++src]
 					&& isspace(cmdline[src]))
 				; /* skip */
-			ALLOC_GROW(*argv, count+1, size);
+			ALLOC_GROW(*argv, count + 1, size);
 			(*argv)[count++] = cmdline + dst;
 		} else if (!quoted && (c == '\'' || c == '"')) {
 			quoted = c;
@@ -76,12 +76,13 @@ int split_cmdline(char *cmdline, const char ***argv)
 		return -SPLIT_CMDLINE_UNCLOSED_QUOTE;
 	}
 
-	ALLOC_GROW(*argv, count+1, size);
+	ALLOC_GROW(*argv, count + 1, size);
 	(*argv)[count] = NULL;
 
 	return count;
 }
 
-const char *split_cmdline_strerror(int split_cmdline_errno) {
-	return split_cmdline_errors[-split_cmdline_errno-1];
+const char *split_cmdline_strerror(int split_cmdline_errno)
+{
+	return split_cmdline_errors[-split_cmdline_errno - 1];
 }
-- 
1.8.4-fc
