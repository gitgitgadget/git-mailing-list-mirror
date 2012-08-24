From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Makefile: do not mark strings for l10n from test programs
Date: Fri, 24 Aug 2012 12:43:01 +0700
Message-ID: <1345786986-10826-2-git-send-email-pclouds@gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 07:43:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mgU-00008d-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab2HXFnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 01:43:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39005 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab2HXFno (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:43:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2795592pbb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZpopZ5N3jlb80FipyWdVGNcflB1k4c55+GOLqoWdXWY=;
        b=d+DddOAI0sl+iqWhEUL4UZ4W8yKoCYuQhdyj9yfEGbSY3TsOrhKBe99x2i+reTFYpx
         OroBGJ3r+lY1BmSbyvNJ59z/iOHW2c8DARDhWaZuz8yk1DB5b/SMtZPKtyPHbkescBNF
         bSiUpDiWOU6ztMYNR2oQLFL4NnFMgv6GA6Cu031LSE2qREwSNow8R3r5mYjbunCnGiUw
         evDcsTbNeX/U+isCNP4kbZGkwVsaLu9sNs4G+6IPiBeuwhcBPcmSw1iNT+cQhTozfIiz
         Vz6dDycBsNq8YsqL4txfWcGpFoJNqz5PVWrrW2hkdlCrlQwGq8V/B+3KdpO87q1WWT/F
         sGWQ==
Received: by 10.66.88.202 with SMTP id bi10mr8397549pab.10.1345787024558;
        Thu, 23 Aug 2012 22:43:44 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id or1sm7592571pbb.10.2012.08.23.22.43.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 22:43:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:43:26 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204182>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6b0c961..ddeb04d 100644
--- a/Makefile
+++ b/Makefile
@@ -2398,7 +2398,8 @@ XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=
=3DC \
 XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell \
 	--keyword=3Dgettextln --keyword=3Deval_gettextln
 XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --keyword=3D__ --language=3D=
Perl
-LOCALIZED_C :=3D $(C_OBJ:o=3Dc) $(LIB_H) $(GENERATED_H)
+C_OBJ_NOTESTS:=3D $(filter-out test-%,$(C_OBJ))
+LOCALIZED_C :=3D $(C_OBJ_NOTESTS:o=3Dc) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH :=3D $(SCRIPT_SH)
 LOCALIZED_PERL :=3D $(SCRIPT_PERL)
=20
--=20
1.7.12.rc2
