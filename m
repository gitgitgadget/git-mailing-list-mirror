From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH 1/3] connect.[ch]: make parse_feature_value non-static
Date: Sat, 30 Jan 2016 19:28:08 +0100
Message-ID: <1454178490-17873-2-git-send-email-dennis@kaarsemaker.net>
References: <1454178490-17873-1-git-send-email-dennis@kaarsemaker.net>
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 19:34:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPaLt-0007OR-6W
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbcA3SeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:34:22 -0500
Received: from koekblik.kaarsemaker.net ([141.138.139.206]:53718 "EHLO
	koekblik.kaarsemaker.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574AbcA3SeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:34:16 -0500
Received: from spirit.home.kaarsemaker.net (unknown [145.132.209.114])
	by koekblik.kaarsemaker.net (Postfix) with ESMTP id E8DD0828B2;
	Sat, 30 Jan 2016 19:28:39 +0100 (CET)
X-Mailer: git-send-email 2.7.0-91-gf04ef09
In-Reply-To: <1454178490-17873-1-git-send-email-dennis@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285125>

We'll need it in the next patch.

Signed-off-by: Dennis Kaarsemaker <git@vger.kernel.org>
---
 connect.c | 3 +--
 connect.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index fd7ffe1..9e64b0b 100644
--- a/connect.c
+++ b/connect.c
@@ -12,7 +12,6 @@
 #include "transport.h"
 
 static char *server_capabilities;
-static const char *parse_feature_value(const char *, const char *, int *);
 
 static int check_ref(const char *name, unsigned int flags)
 {
@@ -179,7 +178,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	return list;
 }
 
-static const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
+const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp)
 {
 	int len;
 
diff --git a/connect.h b/connect.h
index c41a685..7daf702 100644
--- a/connect.h
+++ b/connect.h
@@ -9,6 +9,7 @@ extern int git_connection_is_socket(struct child_process *conn);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
+extern const char *parse_feature_value(const char *, const char *, int *);
 extern int url_is_local_not_ssh(const char *url);
 
 #endif
-- 
2.7.0-91-gf04ef09
