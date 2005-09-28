From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] Make some needlessly global stuff static
Date: Wed, 28 Sep 2005 14:04:54 +0200
Message-ID: <20050928120454.GB3906@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 14:06:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKagb-0002gf-Aa
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 14:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVI1MFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 08:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVI1MFO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 08:05:14 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:38125 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1750887AbVI1MFM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2005 08:05:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id D7FE52E04;
	Wed, 28 Sep 2005 14:05:11 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 06926-01-10; Wed, 28 Sep 2005 14:04:54 +0200 (MEST)
Received: from peppar.cs.umu.se (peppar.cs.umu.se [130.239.40.13])
	by mail.cs.umu.se (Postfix) with ESMTP id AE79D2DAB;
	Wed, 28 Sep 2005 14:04:54 +0200 (MEST)
Received: by peppar.cs.umu.se (Postfix, from userid 12006)
	id 8FB5B2E2E; Wed, 28 Sep 2005 14:04:54 +0200 (MEST)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9427>

Insert 'static' where appropriate.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
---

 fsck-objects.c |    4 ++--
 http-fetch.c   |    4 ++--
 update-ref.c   |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/fsck-objects.c b/fsck-objects.c
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -30,7 +30,7 @@ static void objreport(struct object *obj
 	fputs("\n", stderr);
 }
 
-int objerror(struct object *obj, const char *err, ...)
+static int objerror(struct object *obj, const char *err, ...)
 {
 	va_list params;
 	va_start(params, err);
@@ -39,7 +39,7 @@ int objerror(struct object *obj, const c
 	return -1;
 }
 
-int objwarning(struct object *obj, const char *err, ...)
+static int objwarning(struct object *obj, const char *err, ...)
 {
 	va_list params;
 	va_start(params, err);
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -26,7 +26,7 @@ struct alt_base
 	struct alt_base *next;
 };
 
-struct alt_base *alt = NULL;
+static struct alt_base *alt = NULL;
 
 static SHA_CTX c;
 static z_stream stream;
@@ -345,7 +345,7 @@ static int fetch_pack(struct alt_base *r
 	return 0;
 }
 
-int fetch_object(struct alt_base *repo, unsigned char *sha1)
+static int fetch_object(struct alt_base *repo, unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	char *filename = sha1_file_name(sha1);
diff --git a/update-ref.c b/update-ref.c
--- a/update-ref.c
+++ b/update-ref.c
@@ -6,7 +6,7 @@ static const char git_update_ref_usage[]
 
 #define MAXDEPTH 5
 
-const char *resolve_ref(const char *path, unsigned char *sha1)
+static const char *resolve_ref(const char *path, unsigned char *sha1)
 {
 	int depth = MAXDEPTH, len;
 	char buffer[256];
