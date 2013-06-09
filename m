From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/45] line-log: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:58 +0700
Message-ID: <1370759178-1709-26-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ6G-0000zY-3o
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab3FIG1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:32 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:37600 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334Ab3FIG1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:31 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so5123415pbc.16
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GmWMfL3o76+q6pzWiLnBCJd4yi7fkhOcE2lQ9Rbd9cI=;
        b=FIcFPUgW5l778b0+KF2RIJrB3XMnyVfs1xytriFMiNaKUKuxFf0sp3pF5aTRe16Bot
         fDwawMUT42sTctdb2dn4njkBxrm8lQrZP+1WuAufjlnTKmsNrgnI4wHrwik61ggsqQvc
         cV22MKZZ6DIcKUoLqiZlm8TQNcjLiHEk1W8SV1iUL9NEIF6vXBD+z5u6bHGz085iKAHi
         1adZVFqZ677+CkCXydH5bPmSWqqjwi84WkU0Nvj1D5ePynFrHJTfGRMbC3S2Wtztb1gr
         Z6XD2MYeY/QMcVrlllsZDDAeVrVLhgI7idJxY3Htr7rt5W+57vEo74ZEXKX13R4yJKeV
         Q3rA==
X-Received: by 10.68.132.199 with SMTP id ow7mr5005716pbb.161.1370759251258;
        Sat, 08 Jun 2013 23:27:31 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id dr6sm10244072pac.11.2013.06.08.23.27.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:27:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:02 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226917>


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
