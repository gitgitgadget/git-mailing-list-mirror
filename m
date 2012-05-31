From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] rerere: remove i18n legos in result message
Date: Thu, 31 May 2012 20:04:41 +0700
Message-ID: <1338469482-30936-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 31 15:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa58V-0007MB-HD
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189Ab2EaNJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:09:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60694 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab2EaNJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:09:50 -0400
Received: by pbbrp8 with SMTP id rp8so1442077pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6wYQjgJszuso2pbwxk9BIMANIQyo22OVq8YyRyRo4Q4=;
        b=ijvVFhovxBsSB9WL9gtOlJz67jpAOMYETS0LgCEGacO74PeW75qtYZi2hKmZp2lspN
         88JdtICw3cEeG8mSQcOSzBVQ+KrDJ+aW3LNL8OqQSFYyioIAm2SNXEeJzHbbydKDQycf
         2GLYJxHuQ0RrkahQwhpez0N8vvCKd0kyH1d5JAs+rCELNKW6e9K1NT2XfGUVdfY9rW5E
         PIWNOmZC8jGDF8wDz8VsGi2/AIbFHMwGSeq8WAAoi4lCzNm4tUSnPViwS2KX5kbPHSZV
         xqQpuuf03heFqIGnesPgEkEtY9ucguysjIuyMFUyWqSSsiHBazfirX97tlIlnisB6sND
         PVgA==
Received: by 10.68.216.33 with SMTP id on1mr6285062pbc.105.1338469790141;
        Thu, 31 May 2012 06:09:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id ql3sm4130342pbc.72.2012.05.31.06.09.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:09:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 31 May 2012 20:05:39 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198893>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 rerere.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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
1.7.10.2.549.g9354186
