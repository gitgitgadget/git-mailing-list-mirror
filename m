From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/13] ctype: make sane_ctype[] const array
Date: Mon, 15 Oct 2012 13:25:50 +0700
Message-ID: <1350282362-4505-1-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNe88-00076u-NS
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2JOG0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:26:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2JOG0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:26:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4624959pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5fr+zOeu3UKHI6sEDMABJWiLrY9GlcOv8WjI4oDtFqI=;
        b=siIEsIpnGiNWNvDCnlGuu63ea4XEb3V/nCTcI2NE/u9Z7w78UVTS86Zv2jygrvpi66
         Cy3JK3dp0nJbKE1lUESXy7PAMOeghCb9bpwRfzyHFrE7OE+O5R/E69Fk6fmOFOvevzE9
         wBkajRWnR04q8p+ACOyXeJJwePA+pmnH6Vn+mUWsv96RLjOw2AOKUF/6FqzhG4vSpkm1
         FpQJOhz6QGZ2eDIs5Zb3Nvuc0tGfGBM2KuIeGTZp1dF3A65n6rR0LhH28wwblg0fT4Hc
         jXOPJ63rNyrGAuKpThmH9EGopAOE2cesq0/oDcVx8ObcGbcwgQXsGoxWdtv2dua57QMj
         iZIg==
Received: by 10.66.78.104 with SMTP id a8mr30279818pax.38.1350282373444;
        Sun, 14 Oct 2012 23:26:13 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pv9sm8569284pbb.67.2012.10.14.23.26.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:26:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:26:03 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207699>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ctype.c           | 2 +-
 git-compat-util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ctype.c b/ctype.c
index 9353271..faeaf34 100644
--- a/ctype.c
+++ b/ctype.c
@@ -14,7 +14,7 @@ enum {
 	P =3D GIT_PATHSPEC_MAGIC  /* other non-alnum, except for ] and } */
 };
=20
-unsigned char sane_ctype[256] =3D {
+const unsigned char sane_ctype[256] =3D {
 	0, 0, 0, 0, 0, 0, 0, 0, 0, S, S, 0, 0, S, 0, 0,		/*   0.. 15 */
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,		/*  16.. 31 */
 	S, P, P, P, R, P, P, P, R, R, G, R, P, P, R, P,		/*  32.. 47 */
diff --git a/git-compat-util.h b/git-compat-util.h
index 5bd9ad7..80767ff 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -470,7 +470,7 @@ extern const char tolower_trans_tbl[256];
 #undef isupper
 #undef tolower
 #undef toupper
-extern unsigned char sane_ctype[256];
+extern const unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
--=20
1.8.0.rc0.29.g1fdd78f
