From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] reset: update help text
Date: Tue, 29 Mar 2011 20:20:05 +0700
Message-ID: <1301404805-12095-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:20:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4YqS-0000Q5-C3
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 15:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab1C2NUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 09:20:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46740 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab1C2NUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 09:20:22 -0400
Received: by iyb14 with SMTP id 14so167612iyb.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ztQeezTISbQx23NxsEIoBm4KfrDJyH07jEiM9NLa6HE=;
        b=i0BJ0Tctq0s8i0vIsIxNtPS+eoDj9DoxBgceFmM5JWKKlvwkArYHeoO+8XwvtGnoiD
         /YuzY/P92GSiY2t+wo8lUiGfDNjtEPpuyx9lyA93hlI9cPG/oYqYJO6wLW4rAGu2/OoZ
         exSHN5fzFrM7Y9zIWNlazjjSTNgXrL1aHY0cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Y92jEB5xGuNDCRZhKsrs2q3xGMjfUoowh32Au/f0pQG1yjmH176C6ryR6xK6IhodDD
         rHYk5k1mt2Va4NoJZGlqdSzoCuRl32D97zTNuAB7HTg9zL6YVwth3QBJxHvIDQ3Vnxur
         xqfzGfhV/LG3HXqo4wOZGo0UCJ4mcoCf6fyfI=
Received: by 10.43.53.134 with SMTP id vq6mr7322280icb.263.1301404822047;
        Tue, 29 Mar 2011 06:20:22 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id 13sm3664270ibo.8.2011.03.29.06.20.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 06:20:18 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 29 Mar 2011 20:20:09 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170266>

State --mixed is the default so users don't have to open up man page.

Also make it clear how --hard and --merge are different.

Move -q to bottom because it's not that important to pay attention to a=
s
the first item.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reset.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index eb5f98c..7419c9e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -243,17 +243,17 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
 	struct commit *commit;
 	char *reflog_action, msg[1024];
 	const struct option options[] =3D {
-		OPT__QUIET(&quiet, "be quiet, only report errors"),
 		OPT_SET_INT(0, "mixed", &reset_type,
-						"reset HEAD and index", MIXED),
+				"reset HEAD and index (default)", MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
 		OPT_SET_INT(0, "hard", &reset_type,
 				"reset HEAD, index and working tree", HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
-				"reset HEAD, index and working tree", MERGE),
+				"like --hard but keep local changes in working tree", MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				"reset HEAD but keep local changes", KEEP),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
+		OPT__QUIET(&quiet, "be quiet, only report errors"),
 		OPT_END()
 	};
=20
--=20
1.7.4.74.g639db
