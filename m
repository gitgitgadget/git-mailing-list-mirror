From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] diff-no-index.c: rename read_directory() to read_dir()
Date: Wed,  8 Sep 2010 01:47:59 +1000
Message-ID: <1283874483-32017-2-git-send-email-pclouds@gmail.com>
References: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 03:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot9cQ-00051e-2u
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 03:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab0IHBiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 21:38:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33851 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0IHBiU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 21:38:20 -0400
Received: by pwi3 with SMTP id 3so1635270pwi.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 18:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zepzKnspjciclP/WHyBMjtxSMY3Z9J+rRaJO/iaNghY=;
        b=TgwKXI5nbUZ9z+cQ8qGIyssAoI1o0RJg2wRPd7xpsrNbOOVPX6c6xAOQ6ENCPffyEm
         XPabR6nYT41ybMcTbUiLu7+sdZ0ROvHdRwgZ3ZmMKBYVv19ubDpMhNnRWMrwjStCRqld
         rV4OF7YiYGBYQgahLTHEtMcHIS1gY26TmAlQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ewC8anpbrY0EusYlOIcXs0HGFfeSppLAjr13gzd3OiXSGmyhcIZ3FlwRvToyY5optd
         LR2SHkH9RLBU62npcsOzURWxkIXD8fsclSZYPNw47TOD2m7p60Lt2WXMkTNulRyRBxr4
         hA3syc+l5ov5okSjpEuuaa3jZQ1Xn5Cha0b9A=
Received: by 10.142.222.8 with SMTP id u8mr249238wfg.329.1283909900189;
        Tue, 07 Sep 2010 18:38:20 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id t11sm6506197wfc.22.2010.09.07.18.38.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 18:38:16 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Sep 2010 01:48:12 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155753>

This name clashes with one in dir.h, to be included later on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-no-index.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index ce9e783..859a8ba 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
=20
-static int read_directory(const char *path, struct string_list *list)
+static int read_dir(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -68,9 +68,9 @@ static int queue_diff(struct diff_options *o,
 		struct string_list p2 =3D STRING_LIST_INIT_DUP;
 		int len1 =3D 0, len2 =3D 0, i1, i2, ret =3D 0;
=20
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_dir(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_dir(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
--=20
1.7.1.rc1.69.g24c2f7
