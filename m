From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/5] fetch: free all the additional refspecs
Date: Sat, 15 Oct 2011 07:04:22 +0200
Message-ID: <1318655066-29001-2-git-send-email-cmn@elego.de>
References: <1318655066-29001-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 07:04:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REwQO-0001QL-9E
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab1JOFEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 01:04:41 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48782 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab1JOFE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:04:28 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc6671.pool.mediaWays.net [77.188.102.113])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5159446230;
	Sat, 15 Oct 2011 07:04:00 +0200 (CEST)
Received: (nullmailer pid 29045 invoked by uid 1000);
	Sat, 15 Oct 2011 05:04:26 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <1318655066-29001-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183639>

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e422ced..605d1bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -918,7 +918,7 @@ static int fetch_one(struct remote *remote, int arg=
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
