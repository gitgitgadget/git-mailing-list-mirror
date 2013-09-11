From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/21] fixup! pack-objects: prepare SHA-1 table in v4
Date: Wed, 11 Sep 2013 13:06:02 +0700
Message-ID: <1378879582-15372-2-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Sep 11 08:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdZq-0004SI-5e
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab3IKGGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:06:54 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43556 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab3IKGGx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:06:53 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so8678959pde.38
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=idtwXl/VVToE4Xqsxzw9XY1ciwa7u7LpEpf5wTUByAs=;
        b=iTK9RuOr3ke2jH4baj6fsI9pGf8cYN2eQN9KLRkxT6p5ji6T1+Qoh9ZTPJOxMz8QAl
         SEXdMt0ElIdW5CylMreCRbK1YLNXlpQc2TrSyyCD/e4B3DR9eLeyv2M1mfdkQ+fwZTUS
         6AY45LK666ksG4coKoor82E8RG8EEmp6Hj61GKXEgqzu4al6OfiPSBlpuI1pbxQt5GT7
         HO/xLjGWwIj4fWsNjEmBufiKYjjkhSR5vMn7SY1zgP/lJOJJt2b9T8aCLbG0XExwtFAY
         qB1WXShC5yjtYTAbi4b4DRv8gA4rOsMrrcyYF/+mBR+7s8cfa1tPTGkhkTMAYLYBu/62
         QiWw==
X-Received: by 10.68.253.67 with SMTP id zy3mr13962836pbc.137.1378879613140;
        Tue, 10 Sep 2013 23:06:53 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ta10sm1108805pab.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:06:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:06:45 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234525>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 remove debugging code

 builtin/pack-objects.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1efb728..945b817 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -816,7 +816,6 @@ static void prepare_sha1_table(uint32_t start, stru=
ct object_entry **write_order
 		struct object_entry *e =3D write_order[i];
 		if (e->idx.offset > 0) {
 			v4.all_objs[v4.all_objs_nr++] =3D e->idx;
-			fprintf(stderr, "%s in\n", sha1_to_hex(e->idx.sha1));
 			e->idx.offset =3D 0;
 		}
 	}
--=20
1.8.2.82.gc24b958
