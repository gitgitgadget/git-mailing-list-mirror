From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] notes-merge: remove i18n legos in merge result message
Date: Thu, 31 May 2012 20:04:40 +0700
Message-ID: <1338469482-30936-5-git-send-email-pclouds@gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 15:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa58L-0007Dq-7y
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758040Ab2EaNJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:09:41 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54297 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab2EaNJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:09:40 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1271684dad.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kzFztjpsdJBXIUEzsUSrDqLd0HfAglOOc3e6t2SJn1Y=;
        b=jt9uy2Oe/8jWcjgofb7oERo+By/BTeZcHGRZOkGKhZeZwWz7l1au65yaNptxed3ZF5
         wjgrHdU9eTDr5Qo8GBTBq3X5flfbImKTRaHUxpNO4gvjuicGjtV2KTTDcvZI3cLFHYzS
         Wa9yktQiwb22DEiwGBKULBNXZcxC5SiYbFq7Rp5En/LPlA4zs2/6zMldQDiiPABY6Soq
         9gWDxDXmcwyMVS1LjbyLYpMitDXXsooyc8Szo4eYjFAFfPD6tLN/YKNE28ShIMMgvawk
         sol6/HwbGXWuPqc/bAVERTK8r0ASvdtWmmcXs2cQutMVzrsW9FedfFCLV7a0/+jfnhXp
         qe4Q==
Received: by 10.68.130.9 with SMTP id oa9mr6931202pbb.95.1338469780100;
        Thu, 31 May 2012 06:09:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id ir6sm2889170pbc.35.2012.05.31.06.09.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:09:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 31 May 2012 20:05:28 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198892>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 notes-merge.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 74aa77c..43d5ce0 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -523,9 +523,14 @@ static int merge_from_diffs(struct notes_merge_opt=
ions *o,
 	conflicts =3D merge_changes(o, changes, &num_changes, t);
 	free(changes);
=20
-	if (o->verbosity >=3D 4)
-		printf("Merge result: %i unmerged notes and a %s notes tree\n",
-			conflicts, t->dirty ? "dirty" : "clean");
+	if (o->verbosity >=3D 4) {
+		if (t->dirty)
+			printf("Merge result: %i unmerged notes and a dirty notes tree\n",
+			       conflicts);
+		else
+			printf("Merge result: %i unmerged notes and a clean notes tree\n",
+			       conflicts);
+	}
=20
 	return conflicts ? -1 : 1;
 }
--=20
1.7.10.2.549.g9354186
