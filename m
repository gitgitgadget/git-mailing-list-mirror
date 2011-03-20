From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/9] column: add column.ui for default column output settings
Date: Sun, 20 Mar 2011 19:57:50 +0700
Message-ID: <1300625873-18435-7-git-send-email-pclouds@gmail.com>
References: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 13:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1IDy-000393-9P
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 13:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab1CTM7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 08:59:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57792 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab1CTM7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 08:59:08 -0400
Received: by mail-iy0-f174.google.com with SMTP id 26so5552163iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=1W3vpTZNtP25BDLQtcVr/S1ApBHKL9aiTSPxRYOTthc=;
        b=uPHy/r9d8KGuUqqDhWaWTCIrVG6ySncDvGYRfoah2lxjG80u4oyHy42PxqCYBXbpXq
         heHUHZFiW8+J70fx1GuQ3SB6gfqYKJkyutx3hNvKL7QSs0egsxbnI2wBYxwJcT+LHA8U
         RvhCd2oatG3ai6t2lJUuaMepCRQS8oOc+F3AI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mXFts4PJHd9LdbOeeVt2UhIwZn+4+uGWZxI1s8xnOGYk+V3U53ZD5k/mtYRjpYRpAi
         JsgQN812Y/N1hrCADdUxb1dJuv+WilmFz83ko07D3egSyRfuDq22yq926PmgP2GJ/hNR
         DXmZ+nnQpBEioSgEdcq9/OH8n4Ont7QZ/EL/4=
Received: by 10.43.70.81 with SMTP id yf17mr743774icb.464.1300625947845;
        Sun, 20 Mar 2011 05:59:07 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id s40sm2962407ibg.43.2011.03.20.05.59.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 05:59:07 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:58:58 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1300625873-18435-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169508>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   24 ++++++++++++++++++++++++
 column.c                 |   11 +++++++++++
 column.h                 |    3 +++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..7183712 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -805,6 +805,30 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they alway=
s
 	take precedence over this setting. Defaults to false.
=20
+column.ui::
+	Specify whether supported commands should output in columns.
+	This variable consists of a list of tokens separated by spaces
+	or commas:
++
+--
+`always`;;
+	always show in columns
+`never`;;
+	never show in columns
+`auto`;;
+	show in columns if the output is to the terminal
+`column`;;
+	fill columns before rows (default)
+`row`;;
+	fill rows before columns
+`dense`;;
+	make unequal size columns to utilize more space
+`nodense`;;
+	make equal size columns
+--
++
+	This option defaults to 'never'.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/column.c b/column.c
index 69d42f8..7c1a6f1 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,7 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "color.h"
 #include "utf8.h"
=20
 #define MODE(mode) ((mode) & COL_MODE)
@@ -21,6 +22,8 @@ struct column_data {
 	int *width;			/* index to the longest row in column */
 };
=20
+int git_core_column;
+
 /* return length of 's' in letters, ANSI escapes stripped */
 static int item_length(int mode, const char *s)
 {
@@ -350,6 +353,14 @@ static int parse_string(int *mode, const char *val=
ue,
 	return 0;
 }
=20
+int git_column_default_config(const char *var, const char *value, void=
 *cb)
+{
+	if (!strcmp(var, "column.ui"))
+		return parse_string(&git_core_column, value, -1);
+
+	return git_color_default_config(var, value, cb);
+}
+
 int parseopt_column_callback(const struct option *opt,
 			     const char *arg, int unset)
 {
diff --git a/column.h b/column.h
index 48c6345..0f4190d 100644
--- a/column.h
+++ b/column.h
@@ -9,9 +9,12 @@
 #define COL_ANSI         (1 << 6)  /* Remove ANSI escapes from string =
length */
 #define COL_DENSE        (1 << 7)  /* Shrink columns when possible, ma=
king space for more columns */
=20
+extern int git_core_column;
+
 extern int term_columns(void);
 extern struct string_list_item *add_to_columns(struct string_list *lis=
t, int mode, const char *string);
 extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
+extern int git_column_default_config(const char *var, const char *valu=
e, void *cb);
=20
 struct option;
 extern int parseopt_column_callback(const struct option *opt, const ch=
ar *arg, int unset);
--=20
1.7.4.74.g639db
