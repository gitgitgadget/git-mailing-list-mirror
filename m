From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/4] fetch: free all the additional refspecs
Date: Sat,  8 Oct 2011 00:51:06 +0200
Message-ID: <1318027869-4037-2-git-send-email-cmn@elego.de>
References: <1318027869-4037-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 00:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCJGM-00034q-TK
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 00:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759298Ab1JGWvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 18:51:17 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:53030 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759254Ab1JGWvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 18:51:12 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc5717.pool.mediaWays.net [77.188.87.23])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 8FF664618A;
	Sat,  8 Oct 2011 00:50:46 +0200 (CEST)
Received: (nullmailer pid 4078 invoked by uid 1000);
	Fri, 07 Oct 2011 22:51:09 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1318027869-4037-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183123>

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7a4e41c..30b485e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -883,7 +883,7 @@ static int fetch_one(struct remote *remote, int arg=
c, const char **argv)
 	atexit(unlock_pack);
 	refspec =3D parse_fetch_refspec(ref_nr, refs);
 	exit_code =3D do_fetch(transport, refspec, ref_nr);
-	free(refspec);
+	free_refspec(ref_nr, refspec);
 	transport_disconnect(transport);
 	transport =3D NULL;
 	return exit_code;
--=20
1.7.5.2.354.g349bf
