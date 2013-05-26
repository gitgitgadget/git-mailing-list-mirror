From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/4] index-pack: remove dead code (it should never happen)
Date: Sun, 26 May 2013 08:16:16 +0700
Message-ID: <1369530977-12746-4-git-send-email-pclouds@gmail.com>
References: <1369530977-12746-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 03:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgPYX-0008AE-V7
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 03:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808Ab3EZBPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 21:15:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35909 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758754Ab3EZBPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 21:15:23 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so5606616pab.41
        for <git@vger.kernel.org>; Sat, 25 May 2013 18:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uP3NLgqkOH/au9RPxUqklBWo2KVkHpEsHJz4/9gC+sg=;
        b=sWf/FdrweOIfGFhpZtvV8i+n9K/jGLXn8QoODncegnhWkG5TAq43Co+7xfKZUnVTQZ
         9oos6+GiD8XMhjU6rDqfGNPsSAiV+gaIuB7ejGuh5wGNhX1khUSj+Pzlp5nstnfBiCcK
         f7CeRzoSSHIFTnH1D7InkRKWAh8SCE2K25q7tmDFe2p+TCqkZwsNXP/hQDqGOgfBVEuW
         8bXhwGKuUTQGU/EmNk+riOWivVYOpJmfG8kMon9napVq04bYXul/AsTbpa3oiusMjYYE
         2HJ1t9/GGQwA5dL+aJCfBTr4avPp7v84UwHz6zlgWleBZVLxrCzWrA1M/ZO0/MYZHlKf
         JOUA==
X-Received: by 10.66.216.225 with SMTP id ot1mr24143885pac.154.1369530923097;
        Sat, 25 May 2013 18:15:23 -0700 (PDT)
Received: from lanh ([115.73.211.70])
        by mx.google.com with ESMTPSA id j10sm22354684pbh.23.2013.05.25.18.15.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 May 2013 18:15:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 26 May 2013 08:16:40 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1369530977-12746-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225540>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
