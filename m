From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH] Remove unnecessary git-rm --cached reference from status output
Date: Sun, 7 Jan 2007 20:18:26 +0100
Message-ID: <17825.18306.974000.40992@lapjr.intranet.kiel.bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 20:19:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3dXd-0005Hg-28
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 20:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbXAGTSp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 7 Jan 2007 14:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbXAGTSp
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 14:18:45 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:35353 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964947AbXAGTSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 14:18:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id EEE533AEE0;
	Sun,  7 Jan 2007 20:18:41 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15362-01; Sun, 7 Jan 2007 20:18:41 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 70A4D3AED7;
	Sun,  7 Jan 2007 20:18:38 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 5A6F43ADCC;
	Sun,  7 Jan 2007 20:18:38 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30445-07; Sun, 7 Jan 2007 20:18:35 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 8B2673ADCA;
	Sun,  7 Jan 2007 20:18:32 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1167765983316-git-send-email-j.ruehle@bmiag.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36187>

=46rom: =3D?utf-8?q?J=3DC3=3DBCrgen_R=3DC3=3DBChle?=3D <j-r@online.de>

Since git-reset has learned restoring the absence of paths git-rm --cac=
hed is
no longer necessary. Therefore remove it from the cached content header=
 hint.

Also remove the unfortunate wording 'Cached' from the header itself.

Signed-off-by: J=FCrgen R=FChle <j-r@online.de>
---
 !!This is based on next (or the jr/status series)!!

 This does not yet implement the other proposed changes to the header
 lines, pending further feedback.

 wt-status.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8aac526..c48127d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -56,9 +56,9 @@ void wt_status_prepare(struct wt_status *s)
 static void wt_status_print_cached_header(const char *reference)
 {
 	const char *c =3D color(WT_STATUS_HEADER);
-	color_printf_ln(c, "# Cached changes to be committed:");
+	color_printf_ln(c, "# Changes to be committed:");
 	if (reference) {
-		color_printf_ln(c, "#   (use \"git reset %s <file>...\" and \"git rm=
 --cached <file>...\" to unstage)", reference);
+		color_printf_ln(c, "#   (use \"git reset %s <file>...\" to unstage)"=
, reference);
 	} else {
 		color_printf_ln(c, "#   (use \"git rm --cached <file>...\" to unstag=
e)");
 	}
--=20
1.5.0.rc0.g525e
