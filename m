From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/41] mailmap.c: use error_errno()
Date: Sun,  1 May 2016 18:14:46 +0700
Message-ID: <1462101297-8610-31-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:18:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNx-0007v9-Uf
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbcEALR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:58 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33781 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbcEALR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:57 -0400
Received: by mail-pa0-f65.google.com with SMTP id vv3so18836876pab.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CN35PeU9RhzK6gSqCLtNprGBO2u1QztOAktnyXOgtg0=;
        b=xsRkBNGMyPo3YVN8MIRy9pFtejCA/PeRct810KFLEdHeofCgS6V5slIKcy2nZcoA4s
         vQEWwqUfvTZc334ya/+2fMCfesJ+TDOW2l03NOKMG2Na9O5vNCEPeHPS1e3otKpCFdyB
         h1CWagYdjSJMwNE3T73dTt7hDi2a/uEJ4/f0H5SWhaLCB0hLh6mabOPlJmEK3vTYg4HT
         vTLXYomfcL2XVpHPTY+9bCT6onxivwIHyBGr2gThViK3ZWwPyb1UkuO5zkoDHovea7Bs
         CYHzh0wG8vSz2qwyb7U85HEvBw4m+jQ99v3MWtlGTmYDyZarJc7MhgXuitpI1AwT348v
         KgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CN35PeU9RhzK6gSqCLtNprGBO2u1QztOAktnyXOgtg0=;
        b=Qq872JLMHzRRXprsf6lTB22QJUHN+Ot1bLBNgxU7Xcw8E4sU/CaGy4th8yJRDBakNi
         8FfGeY5hYu6LxupfIWi2VIpah6Z7jyjrMJBFmhOuIF0h/HLM/nKNM+/gG0omNrQR7SK0
         Q5M7birV2bbpz1MzPa3WxIGDXU9DOVjcb4J1+gsKlrnSAgnwoCeeBO0wC6Pnt8MJf5aP
         RKczWoISPtdGfqDKbwWqecpcZFEXS8p6RhdUbZCrO7cOlmKFZVZhOqYuzfpwNaL88S7P
         KR+aulnF6V/sANUHZbPeZR88d2rGdJHn70I0/3YtCZnS2QWZuPwXeZzx1HAOLGGky7oR
         R3DA==
X-Gm-Message-State: AOPr4FWssV2wyZwPp+nQlK2YjZceROjVY/Pv3vjibRFFB6Xvr/4a3oBn4I6V7Vw+Hr0cEg==
X-Received: by 10.66.241.73 with SMTP id wg9mr14887797pac.91.1462101477054;
        Sun, 01 May 2016 04:17:57 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id yl5sm37360534pac.38.2016.05.01.04.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:52 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293180>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 mailmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 9726237..b5c521f 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -189,8 +189,7 @@ static int read_mailmap_file(struct string_list *ma=
p, const char *filename,
 	if (!f) {
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to open mailmap at %s: %s",
-			     filename, strerror(errno));
+		return error_errno("unable to open mailmap at %s", filename);
 	}
=20
 	while (fgets(buffer, sizeof(buffer), f) !=3D NULL)
--=20
2.8.0.rc0.210.gd302cd2
