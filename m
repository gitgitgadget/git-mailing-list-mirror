From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 03/15] contrib/git-credential-gnome-keyring.c: add static where applicable
Date: Sun, 22 Sep 2013 22:07:59 -0700
Message-ID: <1379912891-12277-4-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyOY-0001yp-Um
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab3IWFJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:06 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48500 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3IWFJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:04 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so3135372pab.27
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ILmQSaoG8GOq+6+95w+tvF1wIdMZnXuZ74saTu4C6M=;
        b=obbBsKQV0+sTnuQyIdu1fWyYwZX07mdRxlHxAQrwY/4p9LvPor1As2q/nhnxuf6Q03
         4CWPGOzn9T3W519GjuK//Jg/9mCPnFuLjnznvKM5qLtIMFQApM2KGyN9+TKvSSPnDL4L
         J/5/9uSzXeAQRv1WcihXKLg8n7C5JNmMJzbArN8U5A12GIYQJTgnfhydw2BREGI4OnjW
         SF7V+YKznT0PNAztgQ8O3pv75GBW3Qe2hWNopDQ0SL/0TLpsHjyf5KqvLZgftg72f3g+
         ls34ktXLh0+UxhAvPZ5GSQdqww/OoDSeRLs7T1o/KvTas/PGG/on17Kd0AVI5u4DbxnE
         yNEw==
X-Received: by 10.66.66.161 with SMTP id g1mr10964pat.175.1379912944334;
        Sun, 22 Sep 2013 22:09:04 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235187>

Mark global variable and functions as static.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c       | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 4334f23..ad23dbf 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -128,7 +128,7 @@ static char* keyring_object(struct credential *c)
 	return object;
 }
 
-int keyring_get(struct credential *c)
+static int keyring_get(struct credential *c)
 {
 	char* object = NULL;
 	GList *entries;
@@ -178,7 +178,7 @@ int keyring_get(struct credential *c)
 }
 
 
-int keyring_store(struct credential *c)
+static int keyring_store(struct credential *c)
 {
 	guint32 item_id;
 	char  *object = NULL;
@@ -212,7 +212,7 @@ int keyring_store(struct credential *c)
 	return EXIT_SUCCESS;
 }
 
-int keyring_erase(struct credential *c)
+static int keyring_erase(struct credential *c)
 {
 	char  *object = NULL;
 	GList *entries;
@@ -277,7 +277,7 @@ int keyring_erase(struct credential *c)
  * Table with helper operation callbacks, used by generic
  * credential helper main function.
  */
-struct credential_operation const credential_helper_ops[] =
+static struct credential_operation const credential_helper_ops[] =
 {
 	{ "get",   keyring_get   },
 	{ "store", keyring_store },
@@ -287,12 +287,12 @@ struct credential_operation const credential_helper_ops[] =
 
 /* ------------------ credential functions ------------------ */
 
-void credential_init(struct credential *c)
+static void credential_init(struct credential *c)
 {
 	memset(c, 0, sizeof(*c));
 }
 
-void credential_clear(struct credential *c)
+static void credential_clear(struct credential *c)
 {
 	free(c->protocol);
 	free(c->host);
@@ -303,7 +303,7 @@ void credential_clear(struct credential *c)
 	credential_init(c);
 }
 
-int credential_read(struct credential *c)
+static int credential_read(struct credential *c)
 {
 	char    buf[1024];
 	ssize_t line_len = 0;
@@ -358,14 +358,14 @@ int credential_read(struct credential *c)
 	return 0;
 }
 
-void credential_write_item(FILE *fp, const char *key, const char *value)
+static void credential_write_item(FILE *fp, const char *key, const char *value)
 {
 	if (!value)
 		return;
 	fprintf(fp, "%s=%s\n", key, value);
 }
 
-void credential_write(const struct credential *c)
+static void credential_write(const struct credential *c)
 {
 	/* only write username/password, if set */
 	credential_write_item(stdout, "username", c->username);
-- 
1.8.4.489.g545bc72
