From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] attr: make it build with DEBUG_ATTR again
Date: Tue, 15 Jan 2013 09:49:26 +0700
Message-ID: <1358218166-16592-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <avila.jn@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 03:50:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuwbG-00055y-U1
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 03:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338Ab3AOCtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 21:49:46 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:44312 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756137Ab3AOCtq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 21:49:46 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so2635313pad.10
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 18:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=3AoBANNSzYfjezkWp3FhO7J8KCE0yDfDaqgTPgqialM=;
        b=rnoXeX1w9L5IHz8Ju4QjvrPY3a2k+p9Ax30G1JSVHJYvPQj/vi8Lj1W/eb3TW0dSGG
         16IjLR4xZ0LqyCNM/Pt4qspvz864Nz0coAjC2R7wPZyMvkz8p7OAUXQ4irCc6Z3lMrJ/
         LpXpxLKTYnuUw++Ehho8p5q2wptXFa9i8X7se0azcT7dH1PgGy9qeJAdImBUVglqbwvQ
         mptls22f3Q07POQabCPn/trPYG7oKmNhQ/22dUbQBU4oz0y20DR+8Dw+LXNFOed81uLR
         QPGoIB0zF6TQNkr72+T+qKfU7COwX8RCad4T4SsJkP+hWDSSMRBQYiFIVWQV99fOVTxV
         nqoQ==
X-Received: by 10.66.84.232 with SMTP id c8mr56460577paz.8.1358218185685;
        Mon, 14 Jan 2013 18:49:45 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ou3sm9268057pbb.46.2013.01.14.18.49.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 18:49:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 15 Jan 2013 09:49:28 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213570>

Commit 82dce99 (attr: more matching optimizations from .gitignore -
2012-10-15) changed match_attr structure but it did not update
DEBUG_ATTR-specific code. This fixes it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 097ae87..0575bf7 100644
--- a/attr.c
+++ b/attr.c
@@ -693,7 +693,7 @@ static int fill_one(const char *what, struct match_=
attr *a, int rem)
=20
 		if (*n =3D=3D ATTR__UNKNOWN) {
 			debug_set(what,
-				  a->is_macro ? a->u.attr->name : a->u.pattern,
+				  a->is_macro ? a->u.attr->name : a->u.pat.pattern,
 				  attr, v);
 			*n =3D v;
 			rem--;
--=20
1.8.0.rc3.18.g0d9b108
