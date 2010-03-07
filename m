From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/12] add core.columns
Date: Sun,  7 Mar 2010 19:09:40 +0700
Message-ID: <1267963785-473-8-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFMb-0006M7-JH
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab0CGMNe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:34 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33676 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab0CGMNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:32 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3254848pwj.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LZ8MxIFq4Ca+pGuY4Omve4m0v3kLOfa9rlGUjb0ImoA=;
        b=jrjuIyNMb+Fwhja/eJwzb9LL5MPelgROjTFfLyOxg2xw2VlSGIFP0fGD1zFpcBl0B/
         /jox78wzcK03CGlXL8FfdZQqFuNIlzRptuQ6Ltii3Jt0ZfycpEZ3jkdOqk5N0vX1jhDh
         1J2f+FohNSUWlDGhYjQqh5TbQ/5XQFkvxBsDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rJs0oRDl+jvrvLjngjga662/qN+qqfIahHSs6hFpQro4B5fAC0pLE+wB5ULIX3FshO
         H42iyEbNvtex2yChAuMGnM24KIP1aVosPmIWO57Ss/ys87h/wn0tcL0fNKtANAh3xTDJ
         Y868mBJBdabfUmWwfhEbn5R8Jrje7K7VL77kw=
Received: by 10.143.26.14 with SMTP id d14mr2317634wfj.59.1267964012303;
        Sun, 07 Mar 2010 04:13:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3610632pzk.4.2010.03.07.04.13.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:17 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141679>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    8 ++++++++
 cache.h                  |    1 +
 config.c                 |    6 ++++++
 environment.c            |    1 +
 4 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c80262b..d299eaf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -533,6 +533,14 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
=20
+core.columns::
+	Specify whether a command should output in columns. Only commands
+	that support `--columns` will be affected by this. This variable can
+	take either `never` (do not output in columns), `auto` (output in
+	columns if the output is to a terminal) or `always` (always output in
+	columns). Setting `--columns` or `--no-columns` will override this
+	variable. This option defaults to never.
+
 add.ignore-errors::
 	Tells 'git add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/cache.h b/cache.h
index 124f100..84211d2 100644
--- a/cache.h
+++ b/cache.h
@@ -549,6 +549,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_column_output;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/config.c b/config.c
index 6963fbe..602c4f6 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "color.h"
=20
 #define MAXNAME (256)
=20
@@ -523,6 +524,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.columns")) {
+		core_column_output =3D git_config_colorbool(var, value, -1);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 876c5e5..4329435 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ enum object_creation_mode object_creation_mode =3D OB=
JECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
+int core_column_output;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
--=20
1.7.0.1.370.gd3c5
