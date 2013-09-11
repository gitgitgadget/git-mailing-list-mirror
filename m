From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/21] unpack-objects: report missing object name
Date: Wed, 11 Sep 2013 13:06:12 +0700
Message-ID: <1378879582-15372-12-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdb9-0006HT-O8
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab3IKGIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:08:15 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64415 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab3IKGIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:08:14 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so8705512pab.25
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o3iztVmEbDuqg4iOmbC1DSHPGjQsqdslcxHsziHnmX0=;
        b=kjEl1VdR4DhKEyn5gm692NzkBvrXkcIchM8hIFU0ruJy9TEuaTbt9R3X+LhNKs8mG5
         2BN24GmrzteaEl6F8gpF29iA1SVLpTznNaFdnZ4xy6DgUPioU4GCnoSU2BIPX+joecr+
         D07LsPpArm7n2IQbTdGsUgtwy/2FWKKrBBui+ThsSQI7bdZGjzSKxu3tGVqvwUuf2hoi
         EjkcpDU7faTU5HATe2tFYvSntZS8/qZXZFA4OYsavOYz74ebidyJOpk45UXYSJlaRHPV
         9lCtIPFXHZG5N3/4fYYH+2iIUBZMtJiPc1dMnyUn7CNihfBBUSgXUdh7Fo7wMoNyjeVE
         f3Xg==
X-Received: by 10.66.141.144 with SMTP id ro16mr1276942pab.173.1378879693934;
        Tue, 10 Sep 2013 23:08:13 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id bt1sm27470991pbb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:08:06 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234535>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2217d7b..6d0a65c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -193,7 +193,7 @@ static int check_object(struct object *obj, int typ=
e, void *data)
 		unsigned long size;
 		int type =3D sha1_object_info(obj->sha1, &size);
 		if (type !=3D obj->type || type <=3D 0)
-			die("object of unexpected type");
+			die("object %s of unexpected type", sha1_to_hex(obj->sha1));
 		obj->flags |=3D FLAG_WRITTEN;
 		return 0;
 	}
--=20
1.8.2.82.gc24b958
