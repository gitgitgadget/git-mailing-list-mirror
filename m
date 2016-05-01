From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 37/41] transport-helper.c: use error_errno()
Date: Sun,  1 May 2016 18:14:53 +0700
Message-ID: <1462101297-8610-38-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpOf-0008J2-8V
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbcEALSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:18:36 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35761 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbcEALSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:18:35 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so19088228pac.2
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVMDjXB7MwRk56ezfUFvtUWFXZYtncTgl5sm5H4rVkU=;
        b=AZa7C6SEhn5KfGvndaHCCokfdYOfQbymo/gHy6zRn/tZoUIS+LYtCnvYeAlgyueDLb
         +RhUGInnExek/FfvQ+RBNnGuZ2BnhtQhhFJnp/JEaCUc3Rf4UzmWPCSOc50m+cAwPPyL
         je4ipvRh1aiReT66Z4QxN2JyFMvmsMTQlju+iASOn6zqlA8m4pi0tFPxVrvAkWNU0LtK
         ewElKm7CFuZQjm/QKNU8iPeqdPvDyFn4gqTbA1D0OdC+25agMYTCe53Na/5z1Pa/ZErT
         PDsiOO+T2YBQ57SvlCPRyREoqIMdP8nXiELTy4L3RtSVcLp2NqB3ZCuI0rgu3u4Mn5UE
         ipsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVMDjXB7MwRk56ezfUFvtUWFXZYtncTgl5sm5H4rVkU=;
        b=R3Rvv5EBmzWEp8J8P96olp1DCEYigRQncuB6XUC5gKA/9MxGf/bkf8x2JpcWwOZQmU
         fOSIQ4bX6gTOOZO5LMILb5nHuwf8i8nmh86aR0mWtyB1fF+1mUxMESDLgmTXqkN3yTSd
         AQH7dGjtWsVpXSWswu6qV1GT82pMshj1K7dPnmN6LSwleFHH+6yxfM1HSCIXSkrKa8yp
         duAyHymU8EYutPktixjI51emfVOcBLj8EGZVfNF/cTVPd9g1hRUlotMMzyTTdHug3XVd
         Mnz2aB4LF8uSlT128o1M5e6wJ6CAy6rn1r8/ge7seJggWem4EhjpFVcWckUbUhJGl+A4
         hpIw==
X-Gm-Message-State: AOPr4FVRRkTTQYbiyfxkPK+tD19JMvo75tydbc2pxodNPMIulhepRdY742Rg+CHvn0A3hQ==
X-Received: by 10.66.231.98 with SMTP id tf2mr43396595pac.56.1462101514945;
        Sun, 01 May 2016 04:18:34 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id y2sm37062423pfi.39.2016.05.01.04.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:18:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:18:30 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293187>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b934183..f09fadc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1166,7 +1166,7 @@ static int udt_do_read(struct unidirectional_tran=
sfer *t)
 	bytes =3D read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK && errno !=3D EAGAIN &&
 		errno !=3D EINTR) {
-		error("read(%s) failed: %s", t->src_name, strerror(errno));
+		error_errno("read(%s) failed", t->src_name);
 		return -1;
 	} else if (bytes =3D=3D 0) {
 		transfer_debug("%s EOF (with %i bytes in buffer)",
@@ -1193,7 +1193,7 @@ static int udt_do_write(struct unidirectional_tra=
nsfer *t)
 	transfer_debug("%s is writable", t->dest_name);
 	bytes =3D xwrite(t->dest, t->buf, t->bufuse);
 	if (bytes < 0 && errno !=3D EWOULDBLOCK) {
-		error("write(%s) failed: %s", t->dest_name, strerror(errno));
+		error_errno("write(%s) failed", t->dest_name);
 		return -1;
 	} else if (bytes > 0) {
 		t->bufuse -=3D bytes;
@@ -1306,7 +1306,7 @@ static int tloop_join(pid_t pid, const char *name=
)
 {
 	int tret;
 	if (waitpid(pid, &tret, 0) < 0) {
-		error("%s process failed to wait: %s", name, strerror(errno));
+		error_errno("%s process failed to wait", name);
 		return 1;
 	}
 	if (!WIFEXITED(tret) || WEXITSTATUS(tret)) {
--=20
2.8.0.rc0.210.gd302cd2
