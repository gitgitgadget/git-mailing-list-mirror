From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 25/46] line-log: convert to use parse_pathspec
Date: Sun, 14 Jul 2013 15:35:48 +0700
Message-ID: <1373790969-13000-26-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:38:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHpS-0002Zv-7M
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab3GNIiq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:38:46 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58988 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3GNIip (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:38:45 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so9797767pdi.25
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GmWMfL3o76+q6pzWiLnBCJd4yi7fkhOcE2lQ9Rbd9cI=;
        b=N8gR0VMYLmjigCrlWzRj3mTtcMWFTAxQWbz09ZL+0FU2x6DWQs5iz9R4JvJMqZXM6P
         j7CKY0Nd1ZagRYGeaxGEVY/RxUL+ILNM/g1zGcI3Bbq54gGGX6AOHG1mDuqcHYdT/9X/
         3a5ABBeEyJsm+Z7nXnadqTbSWAS9hm3heXNdWrQpDDSReB5ZgVPolrG1YpeEof9b34iJ
         LAswWYismL2cxrtRw8MFkg74N82atSt8As1PVJlxolVVRaoIiK2Yz6RdxyjF0EqLr2fu
         7pfH7AJZInI6EQ/d53PVx6K6D7VfbxXYNsBcy5KSNeLCV+W/hY5oRhlnqFrggy2QElam
         lEPA==
X-Received: by 10.68.189.202 with SMTP id gk10mr48180347pbc.47.1373791125392;
        Sun, 14 Jul 2013 01:38:45 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id s5sm54536730pbo.38.2013.07.14.01.38.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:38:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:38:57 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230337>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 line-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 4bbb09b..843a334 100644
--- a/line-log.c
+++ b/line-log.c
@@ -747,7 +747,7 @@ void line_log_init(struct rev_info *rev, const char=
 *prefix, struct string_list
 			r =3D r->next;
 		}
 		paths[count] =3D NULL;
-		init_pathspec(&rev->diffopt.pathspec, paths);
+		parse_pathspec(&rev->diffopt.pathspec, 0, 0, "", paths);
 		free(paths);
 	}
 }
--=20
1.8.2.83.gc99314b
