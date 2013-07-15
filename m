From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 9/9] mailmap: style fixes
Date: Mon, 15 Jul 2013 02:54:13 -0400
Message-ID: <1373871253-96480-10-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:55:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uycgb-00046m-0I
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab3GOGy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:56 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48864 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab3GOGyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:55 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so25108378iec.41
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ljdS93+6I7vyPuB8SBp58+lo4Cn47ERXjsGkY7gGp6U=;
        b=dUFp/XhLgSwcKTkH6MkPSb+mI07mJez2fYqoHRV2/ZCWlOWbUlwqpLGmXcoYr3t55t
         Glipa7TPCy8sIr1O0wRc+CFMuNkKP2QrRDPvlqRESGGtl59LMOODJK+ehYmrhUJx/WgP
         J9DSee8kTckcchQxNAc7wxd/uyvr8bWxDxq/tjH07d/1dhsttKzN0Cf7kBIj/9qZfeKR
         el0g1inAT55+dc9QZbneq0/zyv6ttCtZwZ9W7/0VS0Psei1+5MgstQAEz+ZBy8WXC/US
         8zLaVfMTnVkfwVrqnqx1gieIFVG+rwk6JY0R4DNb4iZFUMqv/5hz9C2DRSppi29UkxBx
         Da6A==
X-Received: by 10.42.158.9 with SMTP id f9mr16807596icx.111.1373871295129;
        Sun, 14 Jul 2013 23:54:55 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230433>

From: Junio C Hamano <gitster@pobox.com>

Wrap overlong lines and format the multi-line comments to match our
coding style.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 mailmap.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 928e6e5..44614fc 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -31,7 +31,8 @@ struct mailmap_entry {
 static void free_mailmap_info(void *p, const char *s)
 {
 	struct mailmap_info *mi = (struct mailmap_info *)p;
-	debug_mm("mailmap: -- complex: '%s' -> '%s' <%s>\n", s, debug_str(mi->name), debug_str(mi->email));
+	debug_mm("mailmap: -- complex: '%s' -> '%s' <%s>\n",
+		 s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
 	free(mi->email);
 }
@@ -39,8 +40,10 @@ static void free_mailmap_info(void *p, const char *s)
 static void free_mailmap_entry(void *p, const char *s)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
-	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n", s, me->namemap.nr);
-	debug_mm("mailmap: - simple: '%s' <%s>\n", debug_str(me->name), debug_str(me->email));
+	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n",
+		 s, me->namemap.nr);
+	debug_mm("mailmap: - simple: '%s' <%s>\n",
+		 debug_str(me->name), debug_str(me->email));
 
 	free(me->name);
 	free(me->email);
@@ -50,7 +53,8 @@ static void free_mailmap_entry(void *p, const char *s)
 }
 
 static void add_mapping(struct string_list *map,
-			char *new_name, char *new_email, char *old_name, char *old_email)
+			char *new_name, char *new_email,
+			char *old_name, char *old_email)
 {
 	struct mailmap_entry *me;
 	int index;
@@ -76,7 +80,8 @@ static void add_mapping(struct string_list *map,
 	}
 
 	if (old_name == NULL) {
-		debug_mm("mailmap: adding (simple) entry for %s at index %d\n", old_email, index);
+		debug_mm("mailmap: adding (simple) entry for %s at index %d\n",
+			 old_email, index);
 		/* Replace current name and new email for simple entry */
 		if (new_name) {
 			free(me->name);
@@ -88,7 +93,8 @@ static void add_mapping(struct string_list *map,
 		}
 	} else {
 		struct mailmap_info *mi = xcalloc(1, sizeof(struct mailmap_info));
-		debug_mm("mailmap: adding (complex) entry for %s at index %d\n", old_email, index);
+		debug_mm("mailmap: adding (complex) entry for %s at index %d\n",
+			 old_email, index);
 		if (new_name)
 			mi->name = xstrdup(new_name);
 		if (new_email)
@@ -97,11 +103,12 @@ static void add_mapping(struct string_list *map,
 	}
 
 	debug_mm("mailmap:  '%s' <%s> -> '%s' <%s>\n",
-		 debug_str(old_name), old_email, debug_str(new_name), debug_str(new_email));
+		 debug_str(old_name), old_email,
+		 debug_str(new_name), debug_str(new_email));
 }
 
 static char *parse_name_and_email(char *buffer, char **name,
-		char **email, int allow_empty_email)
+				  char **email, int allow_empty_email)
 {
 	char *left, *right, *nstart, *nend;
 	*name = *email = NULL;
@@ -305,21 +312,25 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
 }
 
 int map_user(struct string_list *map,
-			 const char **email, size_t *emaillen,
-			 const char **name, size_t *namelen)
+	     const char **email, size_t *emaillen,
+	     const char **name, size_t *namelen)
 {
 	struct string_list_item *item;
 	struct mailmap_entry *me;
 
 	debug_mm("map_user: map '%.*s' <%.*s>\n",
-		 (int)*namelen, debug_str(*name), (int)*emaillen, debug_str(*email));
+		 (int)*namelen, debug_str(*name),
+		 (int)*emaillen, debug_str(*email));
 
 	item = lookup_prefix(map, *email, *emaillen);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
-			/* The item has multiple items, so we'll look up on name too */
-			/* If the name is not found, we choose the simple entry      */
+			/*
+			 * The item has multiple items, so we'll look up on
+			 * name too. If the name is not found, we choose the
+			 * simple entry.
+			 */
 			struct string_list_item *subitem;
 			subitem = lookup_prefix(&me->namemap, *name, *namelen);
 			if (subitem)
@@ -340,8 +351,9 @@ int map_user(struct string_list *map,
 				*name = mi->name;
 				*namelen = strlen(*name);
 		}
-		debug_mm("map_user:  to '%.*s' <%.*s>\n", (int)*namelen, debug_str(*name),
-				 (int)*emaillen, debug_str(*email));
+		debug_mm("map_user:  to '%.*s' <%.*s>\n",
+			 (int)*namelen, debug_str(*name),
+			 (int)*emaillen, debug_str(*email));
 		return 1;
 	}
 	debug_mm("map_user:  --\n");
-- 
1.8.3.2.804.g0da7a53
