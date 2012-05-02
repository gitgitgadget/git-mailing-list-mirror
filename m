From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/10] archive-zip: remove uncompressed_size
Date: Wed,  2 May 2012 20:25:19 +0700
Message-ID: <1335965122-17458-8-git-send-email-pclouds@gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 15:30:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZdD-000182-My
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab2EBNaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:30:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64496 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab2EBNaD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:30:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1097342pbb.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7mBGCGEUtF1mJ+1AGOfXplHi9kjA8bWygMYvBq43PhM=;
        b=qBG6Ie+OQFLgJCyk/XOjF2ZKUrjEylAJqEttA1Gqi0blLSbsBmZJBUBKQETgy0qx4s
         ZSRCtEa+J734jePbZPBHs0Mx3gDyfYaVv4wlpK26CHYcrXdm2r2S8RzHOqGzuWWpicdX
         vyouhujeuthp9RE94r20dYmTrYfCXU3I5vtDj+yYngPD/bo2HX5trn8PuRx+uwA9LGi/
         SAJnwG66JdrZr/1uq9NuYW2jAZ0bEBtGwM675bK4VCl8zFgee4qgdFk3qdzW9NdcPpaw
         xrtWTVCvmNKSDhexoau/yu8Etk8NdP1b6OIQd4wZ7h7pBLI1j+OlluKQgn7PP4Lf3+hd
         6EYg==
Received: by 10.68.196.228 with SMTP id ip4mr6350620pbc.41.1335965403602;
        Wed, 02 May 2012 06:30:03 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.34.118])
        by mx.google.com with ESMTPS id rt4sm1999599pbc.3.2012.05.02.06.29.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 06:30:02 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 02 May 2012 20:26:33 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196810>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

We only need size and compressed_size.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive-zip.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 716cc42..400ba38 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -129,7 +129,6 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	struct zip_dir_header dirent;
 	unsigned long attr2;
 	unsigned long compressed_size;
-	unsigned long uncompressed_size;
 	unsigned long crc;
 	unsigned long direntsize;
 	int method;
@@ -149,7 +148,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 		method =3D 0;
 		attr2 =3D 16;
 		out =3D NULL;
-		uncompressed_size =3D 0;
+		size =3D 0;
 		compressed_size =3D 0;
 		buffer =3D NULL;
 		size =3D 0;
@@ -166,7 +165,6 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 			method =3D 8;
 		crc =3D crc32(crc, buffer, size);
 		out =3D buffer;
-		uncompressed_size =3D size;
 		compressed_size =3D size;
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
@@ -204,7 +202,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	copy_le16(dirent.mdate, zip_date);
 	copy_le32(dirent.crc32, crc);
 	copy_le32(dirent.compressed_size, compressed_size);
-	copy_le32(dirent.size, uncompressed_size);
+	copy_le32(dirent.size, size);
 	copy_le16(dirent.filename_length, pathlen);
 	copy_le16(dirent.extra_length, 0);
 	copy_le16(dirent.comment_length, 0);
@@ -226,7 +224,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	copy_le16(header.mdate, zip_date);
 	copy_le32(header.crc32, crc);
 	copy_le32(header.compressed_size, compressed_size);
-	copy_le32(header.size, uncompressed_size);
+	copy_le32(header.size, size);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, 0);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
--=20
1.7.8.36.g69ee2
