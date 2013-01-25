From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] branch: reject -D/-d without branch name
Date: Fri, 25 Jan 2013 15:26:56 +0700
Message-ID: <1359102416-1240-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 09:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyedZ-0001JY-JR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 09:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab3AYI12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 03:27:28 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:40800 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3AYI11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 03:27:27 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so81739pbb.16
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ecZREswaZpZJfsla7yS/5oWdnTV7yBv2svB6TxIceEM=;
        b=LJNVQo1BB1umdRqBQRkGcR62qbKFeQX+8dotCwjTpjoVeq5I5QsjQR5oxyKeraVQjA
         K2MU3G6QT27w24oD0ypwsLe5xHNWiuVf+HJZc3pv1f6i3UiNQH1YV0oSzevTWsDK3JYl
         7O8qHAXy5EXKmcaM0hsA3HoU/BoVfOhb1ZNlwqC6J/chgT6zkZes37/DFM2MJe8iuVAK
         DmWobAXojzirUieVO0tdl3465lvwD2Dzu7cgnlMEN+Lwf1jqmj0gqWlsPUj+UiEXXBnF
         BcAXoz/dUnURUWX+BScB/buCPWU/L6/E0stS0raX1Ik0iTCduppEOa40Eoa2o5z9oKtH
         YziQ==
X-Received: by 10.68.83.68 with SMTP id o4mr12617083pby.25.1359102447196;
        Fri, 25 Jan 2013 00:27:27 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id qh4sm274044pbb.9.2013.01.25.00.27.23
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 00:27:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 25 Jan 2013 15:27:02 +0700
X-Mailer: git-send-email 1.8.1.1.380.g782aa97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214513>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 873f624..1d3e842 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -837,7 +837,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		colopts =3D 0;
 	}
=20
-	if (delete)
+	if (delete && argc)
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
 	else if (list) {
 		int ret =3D print_ref_list(kinds, detached, verbose, abbrev,
--=20
1.8.1.1.380.g782aa97
