From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/6] fetch: align all "remote -> local" output
Date: Sun,  5 Jun 2016 10:11:39 +0700
Message-ID: <20160605031141.23513-5-pclouds@gmail.com>
References: <20160603110843.15434-1-pclouds@gmail.com>
 <20160605031141.23513-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 05:12:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OUC-0004Ys-LS
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbcFEDMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 23:12:20 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34722 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFEDMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:12:16 -0400
Received: by mail-pa0-f65.google.com with SMTP id x1so9021237pav.1
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcq34VDHtiedfo9bvLYrwZv7LZBBourtWe15kdyoQhg=;
        b=dtXypgLWRquk3rGwbQSBP5mxKclNE7Oi62Po9VAKBPK00CJ6jSCkrsWeJbiFk8Rv9g
         o2xEYtsRMRWpA1TvlSJWuF/gvAEOrH5syvYSmIzxoULP6FkWFoLUxPhKaxbToUk33kPj
         SU6Rqi0ueEdMk1NBSZwwzQVRVz+Z20qKrZ20wEGOAedTZqpfcAvsyqbVAn2xjLcHTn2g
         6TGusVvX2r7TZsACY3h0ec9qrPhwXStKiPzS9NXMkXfpCx0HfYaudzl2SzTw5cMlLYug
         TFXdL7aenlrB8iTx0R4gbvB7lLer7N4YETzQmxv66S5nTlwMElZTuX0aTynn/fbusIxm
         4jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcq34VDHtiedfo9bvLYrwZv7LZBBourtWe15kdyoQhg=;
        b=f4h2v7guJqiAXoUjT7gkkdY3Guabz/ktL52M4bh0IPLLZANddM+0t41hELVn+7W3s2
         s3fkj+icPbQoW+zuKt6ZRWJ/yNjim7m/GTxICDLYXTYboztn6ngpNSWipCIUa2AhJ19Y
         eOwaYa7+uWWbBa+XcNGa/p3Bd4wZNKftAB7DTzLMGKfKtLTCyN9rpas2EpQmUnX7kmi0
         UJSG72PKGkzfTzFPJjz7tPOUn1Dz3lWOgzVZdHm0qGeyQaUN9LeSp9RjE3cei0G5PMIm
         /btnXSLoLZ0r+xq7gw91FnxAg2E5z6OZOCszc0cxFJhhQ4jAW0lRkT3NCFN8BMZ67F9l
         VP0g==
X-Gm-Message-State: ALyK8tLhrELDsMcbPpjhuV89YFe2VODBa4HM9m8+/gkWvAYuPhmZK9m2rpZhKFERhs1crw==
X-Received: by 10.66.132.72 with SMTP id os8mr15427529pab.63.1465096335953;
        Sat, 04 Jun 2016 20:12:15 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id i191sm951235pfe.8.2016.06.04.20.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 20:12:15 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 05 Jun 2016 10:12:11 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160605031141.23513-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296455>

We do align "remote -> local" output by allocating 10 columns to
"remote". That produces aligned output only for short refs. An extra
pass is performed to find the longest remote ref name (that does not
produce a line longer than terminal width) to produce better aligned
output.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8177f90..c42795b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "connected.h"
 #include "argv-array.h"
+#include "utf8.h"
=20
 static const char * const builtin_fetch_usage[] =3D {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -449,14 +450,53 @@ fail:
 			   : STORE_REF_ERROR_OTHER;
 }
=20
-#define REFCOL_WIDTH  10
+static int refcol_width =3D 10;
+
+static void adjust_refcol_width(const struct ref *ref)
+{
+	int max, rlen, llen;
+
+	/* uptodate lines are only shown on high verbosity level */
+	if (!verbosity && !oidcmp(&ref->peer_ref->old_oid, &ref->old_oid))
+		return;
+
+	max    =3D term_columns();
+	rlen   =3D utf8_strwidth(prettify_refname(ref->name));
+	llen   =3D utf8_strwidth(prettify_refname(ref->peer_ref->name));
+
+	/*
+	 * rough estimation to see if the output line is too long and
+	 * should not be counted (we can't do precise calculation
+	 * anyway because we don't know if the error explanation part
+	 * will be printed in update_local_ref)
+	 */
+	if (21 /* flag and summary */ + rlen + 4 /* -> */ + llen >=3D max)
+		return;
+
+	if (refcol_width < rlen)
+		refcol_width =3D rlen;
+}
+
+static void prepare_format_display(struct ref *ref_map)
+{
+	struct ref *rm;
+
+	for (rm =3D ref_map; rm; rm =3D rm->next) {
+		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
+		    !rm->peer_ref ||
+		    !strcmp(rm->name, "HEAD"))
+			continue;
+
+		adjust_refcol_width(rm);
+	}
+}
=20
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local)
 {
 	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
-	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
+	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
 }
@@ -618,6 +658,8 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 		goto abort;
 	}
=20
+	prepare_format_display(ref_map);
+
 	/*
 	 * We do a pass for each fetch_head_status type in their enum order, =
so
 	 * merged entries are written before not-for-merge. That lets readers
--=20
2.8.2.524.g6ff3d78
