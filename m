From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] rerere: remove i18n legos in result message
Date: Thu,  7 Jun 2012 19:05:14 +0700
Message-ID: <1339070715-31417-5-git-send-email-pclouds@gmail.com>
References: <0001-Remove-i18n-legos-in-notifying-new-branch-tracking-s.patch>
 <1339070715-31417-1-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu Jun 07 14:10:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbXl-0001FE-8D
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab2FGMKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 08:10:20 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35289 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab2FGMKS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 08:10:18 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so787685dad.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KUGYVEos3sXYfVeZ3Iv8jDz9MyvKIFWf1q7a5YMfcXs=;
        b=dnIaulQa3v0qevEUyvMHtNCT+o7WlMsQQhmDrAyWdfjqktqaheRmZ7XEqk/CdDb7Kq
         oPWzX6E977Gl2Bh2RISrN2ts9gxPkTqbvUsUwo4aWCk8TpNS7w+a897AaWowdrWAFEAP
         lWEnHO5//O0h4rEV4pfULnUr949PC+9X1sStByBl/SZQG+jSsRv9ze13LisO6nMcUH+r
         Gc9TL8M64LLxiIcNB/K6U8b62t0XXcTN0elHS8TI0sAgdMJKho+LYhjBjwQRfWZND91O
         PG3CsKV6Nkwwg/P/W/aQM23Szx7ZGlVlI92JlcJxLUPFJ7CShHH0uufd5TjwbVB+273J
         9HjQ==
Received: by 10.68.241.8 with SMTP id we8mr7791632pbc.130.1339071017683;
        Thu, 07 Jun 2012 05:10:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.113])
        by mx.google.com with ESMTPS id ob9sm3930315pbb.28.2012.06.07.05.10.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 05:10:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 19:05:58 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199399>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 rerere.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/rerere.c b/rerere.c
index dcb525a..da18fc3 100644
--- a/rerere.c
+++ b/rerere.c
@@ -544,13 +544,13 @@ static int do_plain_rerere(struct string_list *rr=
, int fd)
=20
 		if (has_rerere_resolution(name)) {
 			if (!merge(name, path)) {
-				if (rerere_autoupdate)
+				const char *msg;
+				if (rerere_autoupdate) {
 					string_list_insert(&update, path);
-				fprintf(stderr,
-					"%s '%s' using previous resolution.\n",
-					rerere_autoupdate
-					? "Staged" : "Resolved",
-					path);
+					msg =3D "Staged '%s' using previous resolution.\n";
+				} else
+					msg =3D "Resolved '%s' using previous resolution.\n";
+				fprintf(stderr, msg, path);
 				goto mark_resolved;
 			}
 		}
--=20
1.7.8
