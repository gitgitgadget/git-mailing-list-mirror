From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/4] index-pack: remove dead code (it should never happen)
Date: Fri,  3 May 2013 19:35:13 +0700
Message-ID: <1367584514-19806-4-git-send-email-pclouds@gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
 <1367584514-19806-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 14:34:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYFCR-00023g-3m
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 14:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762058Ab3ECMer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 08:34:47 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45976 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761902Ab3ECMeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 08:34:44 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa10so910073pad.19
        for <git@vger.kernel.org>; Fri, 03 May 2013 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1O2iMXUtFDZyk3fkQ3jl6oHO8lt24ATjrrow/E6vLHQ=;
        b=Yb2oeKCQrqx4i3v11o0IgzcgdONI8sTLSSkJsUHF2AYXq3VllDsR7BPeYkP4Spr5Bj
         L/piQtnVBedg5Z0mWLe2bldvk6/wvoQDLttoIwCORUgqncmxKhKxPYwCbjwVUO2nXODI
         le5k3Lnx13OJDxrLgd55Fd7N5VnrEA3QgS8j67cWrUiRhHOntI3co73lhIWFNI9EenOg
         XVyIRlITiuhFVcOoONBmbN97cSDBGcH9TC6tY9TZbS0f4Tqjz8TkO7cIv9GFLpgNfY8N
         VoX+4rytajlKkEXwv0rSLCi/oUREVGKZUX8gBeLewCwa0pAoR1Y4VAi4oMsHbX4uwK9J
         BqJg==
X-Received: by 10.68.92.100 with SMTP id cl4mr13631210pbb.130.1367584484166;
        Fri, 03 May 2013 05:34:44 -0700 (PDT)
Received: from lanh ([115.74.38.7])
        by mx.google.com with ESMTPSA id xe3sm962297pbc.30.2013.05.03.05.34.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 05:34:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 03 May 2013 19:35:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367584514-19806-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223307>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 79dfe47..f52a04f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -747,8 +747,7 @@ static void sha1_object(const void *data, struct ob=
ject_entry *obj_entry,
 			int eaten;
 			void *buf =3D (void *) data;
=20
-			if (!buf)
-				buf =3D new_data =3D get_data_from_pack(obj_entry);
+			assert(data && "data can only be NULL for large _blobs_");
=20
 			/*
 			 * we do not need to free the memory here, as the
--=20
1.8.2.83.gc99314b
