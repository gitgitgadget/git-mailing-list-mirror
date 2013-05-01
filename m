From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/5] index-pack: remove dead code (it should never happen)
Date: Wed,  1 May 2013 17:59:32 +0700
Message-ID: <1367405974-22190-4-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 12:59:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXUkk-0007Lw-0A
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760540Ab3EAK7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 06:59:10 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40488 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759472Ab3EAK7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:59:07 -0400
Received: by mail-pd0-f177.google.com with SMTP id p11so766553pdj.8
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2FBSLcZRi/jbbZyDdR/EEgACbnPuH5Qf1Mnne7RS9Ac=;
        b=reFxlBv1JuvUyG1bS0mGdjqKXB9QaabBfU+lziAWTNcviTD4wTicOxv0iOa0XjTau5
         rUe6avRR/OPWkR1+j7deXY8r3g33DeERAFGlHR7P7T5Z+LDjrJlPXqoi6wgf21lEQUC6
         YKTlMPPZH8FiOFWDV7oy7/aW/GtVU1mk0qIkCDy5B0HU+TzgSxg+UA/RFdkO/m5bRmPU
         P0sBITTknVlFB4nDZopUDREoZe7n7vn/t8XcCdvUEiiKeJbnrARxReOKIe81BJiEigyR
         Rx9jVvcBGqeZxWpyOAy9AoVQg/C615WuWWy3O9cU3JH1mtUBL+FETwYK7rG+/iegB3EU
         gjag==
X-Received: by 10.66.27.17 with SMTP id p17mr4291591pag.108.1367405946897;
        Wed, 01 May 2013 03:59:06 -0700 (PDT)
Received: from lanh ([115.74.47.19])
        by mx.google.com with ESMTPSA id vb8sm2593367pbc.11.2013.05.01.03.59.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 03:59:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 May 2013 17:59:56 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223083>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 79dfe47..1fd56d9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -747,8 +747,7 @@ static void sha1_object(const void *data, struct ob=
ject_entry *obj_entry,
 			int eaten;
 			void *buf =3D (void *) data;
=20
-			if (!buf)
-				buf =3D new_data =3D get_data_from_pack(obj_entry);
+			assert(data && "data can only be NULL for large blobs");
=20
 			/*
 			 * we do not need to free the memory here, as the
--=20
1.8.2.83.gc99314b
