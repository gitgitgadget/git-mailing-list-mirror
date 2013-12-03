From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH] contrib/git-credential-gnome-keyring.c: small stylistic cleanups
Date: Tue,  3 Dec 2013 05:32:44 -0500
Message-ID: <1386066764-49711-1-git-send-email-john@szakmeister.net>
Cc: git@vger.kernel.org, John Szakmeister <john@szakmeister.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 03 11:34:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnnIw-0005ru-4m
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 11:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab3LCKeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 05:34:06 -0500
Received: from mail-qe0-f45.google.com ([209.85.128.45]:46969 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab3LCKeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 05:34:04 -0500
Received: by mail-qe0-f45.google.com with SMTP id 6so14770987qea.18
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 02:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=aLFdIXvcBBQ0yxPTvedPJMHr/l+AKd3ZFqlWf0pBE4s=;
        b=igRpRUw6PtFyXKLXVsKvdM4FSSL7bQVcJ6hfil9be6uKSmWbMEmwKQ6wcO9nna05XU
         czM8d4GWDrOsFcbCkHNdPqm/QPWa6NHZLvNOEuuP03fXdcoKoUUvATkit9QlWeW5yut+
         J09Py17EcM9zjGsivid7JL2IMxk1ei0kGwmJCpRMn+/87z0pcgdQZd20h4Ql55SDWYVX
         cmDt8MlFLosequ2509MHLUQ/cDM4rVKkjkIawrEtBsEAZIj55nIWgZ/EwLKF5MIU11Pp
         pxsgMGQzluXEA1FVTGK/yjydD2GSAfq081/MLXx6Zv7cWraNzwElesy6DtQoXYLBHhmw
         jaSQ==
X-Received: by 10.224.168.194 with SMTP id v2mr63280456qay.17.1386066842673;
        Tue, 03 Dec 2013 02:34:02 -0800 (PST)
Received: from localhost.localdomain (pool-173-59-254-58.bltmmd.fios.verizon.net. [173.59.254.58])
        by mx.google.com with ESMTPSA id b4sm26616637qai.7.2013.12.03.02.34.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 02:34:01 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238685>

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
The gnome-keyring credential backend had a number of coding style
violations.  I believe this fixes all of them.

 .../gnome-keyring/git-credential-gnome-keyring.c   | 55 ++++++++++------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 635c96b..1613404 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -95,9 +95,9 @@ static const char* gnome_keyring_result_to_message(GnomeKeyringResult result)
 
 static void gnome_keyring_done_cb(GnomeKeyringResult result, gpointer user_data)
 {
-	gpointer *data = (gpointer*) user_data;
-	int *done = (int*) data[0];
-	GnomeKeyringResult *r = (GnomeKeyringResult*) data[1];
+	gpointer *data = (gpointer *) user_data;
+	int *done = (int *) data[0];
+	GnomeKeyringResult *r = (GnomeKeyringResult *) data[1];
 
 	*r = result;
 	*done = 1;
@@ -132,27 +132,25 @@ static GnomeKeyringResult gnome_keyring_item_delete_sync(const char *keyring, gu
  */
 struct credential
 {
-	char          *protocol;
-	char          *host;
+	char *protocol;
+	char *host;
 	unsigned short port;
-	char          *path;
-	char          *username;
-	char          *password;
+	char *path;
+	char *username;
+	char *password;
 };
 
-#define CREDENTIAL_INIT \
-  { NULL,NULL,0,NULL,NULL,NULL }
+#define CREDENTIAL_INIT { NULL, NULL, 0, NULL, NULL, NULL }
 
-typedef int (*credential_op_cb)(struct credential*);
+typedef int (*credential_op_cb)(struct credential *);
 
 struct credential_operation
 {
-	char             *name;
+	char *name;
 	credential_op_cb op;
 };
 
-#define CREDENTIAL_OP_END \
-  { NULL,NULL }
+#define CREDENTIAL_OP_END { NULL, NULL }
 
 /* ----------------- GNOME Keyring functions ----------------- */
 
@@ -221,7 +219,7 @@ static int keyring_get(struct credential *c)
 static int keyring_store(struct credential *c)
 {
 	guint32 item_id;
-	char  *object = NULL;
+	char *object = NULL;
 	GnomeKeyringResult result;
 
 	/*
@@ -262,7 +260,7 @@ static int keyring_store(struct credential *c)
 
 static int keyring_erase(struct credential *c)
 {
-	char  *object = NULL;
+	char *object = NULL;
 	GList *entries;
 	GnomeKeyringNetworkPasswordData *password_data;
 	GnomeKeyringResult result;
@@ -298,8 +296,7 @@ static int keyring_erase(struct credential *c)
 	if (result == GNOME_KEYRING_RESULT_CANCELLED)
 		return EXIT_SUCCESS;
 
-	if (result != GNOME_KEYRING_RESULT_OK)
-	{
+	if (result != GNOME_KEYRING_RESULT_OK) {
 		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
@@ -312,8 +309,7 @@ static int keyring_erase(struct credential *c)
 
 	gnome_keyring_network_password_list_free(entries);
 
-	if (result != GNOME_KEYRING_RESULT_OK)
-	{
+	if (result != GNOME_KEYRING_RESULT_OK) {
 		g_critical("%s", gnome_keyring_result_to_message(result));
 		return EXIT_FAILURE;
 	}
@@ -325,9 +321,8 @@ static int keyring_erase(struct credential *c)
  * Table with helper operation callbacks, used by generic
  * credential helper main function.
  */
-static struct credential_operation const credential_helper_ops[] =
-{
-	{ "get",   keyring_get   },
+static struct credential_operation const credential_helper_ops[] = {
+	{ "get",   keyring_get },
 	{ "store", keyring_store },
 	{ "erase", keyring_erase },
 	CREDENTIAL_OP_END
@@ -370,7 +365,7 @@ static int credential_read(struct credential *c)
 		if (!line_len)
 			break;
 
-		value = strchr(buf,'=');
+		value = strchr(buf, '=');
 		if (!value) {
 			g_warning("invalid credential line: %s", key);
 			gnome_keyring_memory_free(buf);
@@ -384,7 +379,7 @@ static int credential_read(struct credential *c)
 		} else if (!strcmp(key, "host")) {
 			g_free(c->host);
 			c->host = g_strdup(value);
-			value = strrchr(c->host,':');
+			value = strrchr(c->host, ':');
 			if (value) {
 				*value++ = '\0';
 				c->port = atoi(value);
@@ -429,16 +424,16 @@ static void credential_write(const struct credential *c)
 static void usage(const char *name)
 {
 	struct credential_operation const *try_op = credential_helper_ops;
-	const char *basename = strrchr(name,'/');
+	const char *basename = strrchr(name, '/');
 
 	basename = (basename) ? basename + 1 : name;
 	fprintf(stderr, "usage: %s <", basename);
 	while (try_op->name) {
-		fprintf(stderr,"%s",(try_op++)->name);
+		fprintf(stderr, "%s", (try_op++)->name);
 		if (try_op->name)
-			fprintf(stderr,"%s","|");
+			fprintf(stderr, "%s", "|");
 	}
-	fprintf(stderr,"%s",">\n");
+	fprintf(stderr, "%s", ">\n");
 }
 
 int main(int argc, char *argv[])
@@ -446,7 +441,7 @@ int main(int argc, char *argv[])
 	int ret = EXIT_SUCCESS;
 
 	struct credential_operation const *try_op = credential_helper_ops;
-	struct credential                  cred   = CREDENTIAL_INIT;
+	struct credential cred = CREDENTIAL_INIT;
 
 	if (!argv[1]) {
 		usage(argv[0]);
-- 
1.8.3.1
