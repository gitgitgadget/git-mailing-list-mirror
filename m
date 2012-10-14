From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 01/12] ctype: make sane_ctype[] const array
Date: Sun, 14 Oct 2012 09:34:59 +0700
Message-ID: <1350182110-25936-2-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE3T-0005DG-4I
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab2JNCfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:35:40 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42911 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2JNCfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:35:39 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3876368pad.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=p0A7+Jq29y3zkbakvqYeJLkWm35QlmmcK1zLlA8fEkU=;
        b=Uike8GUO0pgkPHUItfgAt2b863pN/tVOFEgMohGhd1tV9VlyRePZvcuGFUUE3lIvvy
         s5ZvhyWNhLA8dwDbXZNAhZplyNthPMArsi84LFotVnXPAngK+Uc68WRubV8azShvNw8o
         1VtOVLDzzJA52xXC0wPbwIRaDhgRp2K7Cw8vN/YG4/EJJiRT4doHfGivgujCm1iKOU/e
         tVBqR+gvpwN5nuW70+a9/YgxYoQE98tB4fNC5VLKOgVZX5fwZ9+Pdc/9fmkoXzLl1rp1
         AkfLm04A/jvNbRrrGQjIqXZ4XsVBxpxsYX+qlNrxVsfYBTxuTsC8MbLUcBcWa8mzYKQ7
         yrSw==
Received: by 10.66.72.134 with SMTP id d6mr22695031pav.13.1350182139079;
        Sat, 13 Oct 2012 19:35:39 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id uh7sm6815742pbc.35.2012.10.13.19.35.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:35:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:35:24 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207592>


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
index 2fbf1fd..f8b859c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -510,7 +510,7 @@ extern const char tolower_trans_tbl[256];
 #undef isupper
 #undef tolower
 #undef toupper
-extern unsigned char sane_ctype[256];
+extern const unsigned char sane_ctype[256];
 #define GIT_SPACE 0x01
 #define GIT_DIGIT 0x02
 #define GIT_ALPHA 0x04
--=20
1.8.0.rc2.11.g2b79d01
