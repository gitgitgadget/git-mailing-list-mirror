From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 01/12] ctype: make sane_ctype[] const array
Date: Wed, 10 Oct 2012 17:40:40 +0700
Message-ID: <1349865651-31889-2-git-send-email-pclouds@gmail.com>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:41:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtj5-0002VN-W2
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab2JJKlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:41:10 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33620 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab2JJKlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:41:07 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so465773pad.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gUSUCEYWJuX21z4r8iWxsO7dkyuxwLQzxximk60cSAU=;
        b=HewtnmfK5vYm9Bt9mbp6VdTWPjdMaktNy0QMAD3G+EoUtZ9y/7oMgZpM3EYDo4H/8E
         CPzYKMbWDzbupucciP2NCg3r2e3kXwdS8Kjf38B2GyE0ngr5FTj0VoWAT3ki38HLTSXm
         64nA7Gos297z0p4qurVjljoJ04Gw1hUcLWCMZbcnvGsr81a+NlRGP4JqH42mhfG+C3ZO
         YGm89oiE9/TgiwSVbvvdf0HX6iLbD0ABS9JB438RMQTIUoPkQ5SYa4Ajh/axiT0drK1r
         9uPVaZW+ZoQ8xz1Unsc4lCUi48gxmkJss3wIHM6msVpVcGlLjkAbUxw7GxZoJIkUBEqq
         5ieQ==
Received: by 10.66.75.137 with SMTP id c9mr9299329paw.84.1349865667025;
        Wed, 10 Oct 2012 03:41:07 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id kt2sm838595pbc.73.2012.10.10.03.41.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:41:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:40:58 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207386>


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
1.7.12.1.406.g6ab07c4
