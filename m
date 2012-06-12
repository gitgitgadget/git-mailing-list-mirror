From: Max Horn <max@quendi.de>
Subject: =?UTF-8?q?=5BPATCH=5D=20fast-export=3A=20report=20SHA-1=20instead=20of=20gibberish=20when=20marks=20exist=20already?=
Date: Tue, 12 Jun 2012 15:45:16 +0200
Message-ID: <1339508716-51880-2-git-send-email-max@quendi.de>
References: <1339508716-51880-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 16:10:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeRnf-0003Lk-PE
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab2FLOKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 10:10:14 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:55668 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751517Ab2FLOKM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 10:10:12 -0400
Received: from hilbert.math.nat.tu-bs.de ([134.169.53.151] helo=kaitain.math.nat.tu-bs.de); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1SeRQj-00079M-Qw; Tue, 12 Jun 2012 15:46:45 +0200
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1339508716-51880-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1339510212;c9a404ec;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199788>

=46rom: Johannes Schindelin <johannes.schindelin@gmx.de>

Cc: Pieter de Bie <pdebie@ai.rug.nl>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Max Horn <max@quendi.de>
---
 builtin/fast-export.c |    2 +-
 1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt(-=
)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 19509ea..ef7c012 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -610,7 +610,7 @@ static void import_marks(char *input_file)
 			die ("Could not read blob %s", sha1_to_hex(sha1));
=20
 		if (object->flags & SHOWN)
-			error("Object %s already has a mark", sha1);
+			error("Object %s already has a mark", sha1_to_hex(sha1));
=20
 		mark_object(object, mark);
 		if (last_idnum < mark)
--=20
1.7.10.4
