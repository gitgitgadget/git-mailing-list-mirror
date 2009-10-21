From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] Remove a left-over file from t/t5100
Date: Wed, 21 Oct 2009 13:35:15 +0200
Message-ID: <1256124916-26486-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 14:04:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Zvp-00058G-0G
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 14:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbZJUMEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 08:04:35 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbZJUMEf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 08:04:35 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36481 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbZJUMEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 08:04:34 -0400
X-Greylist: delayed 1742 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 08:04:34 EDT
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1N0ZTZ-0003w5-Ba; Wed, 21 Oct 2009 13:35:33 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 23A8C6D9; Wed, 21 Oct 2009 13:35:33 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id DF5D9FA46; Wed, 21 Oct 2009 13:35:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.5.rc2.47.g49402
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130906>

This mbox file must have been added by accident in e9fe804 (git-mailinf=
o:
=46ix getting the subject from the in-body [PATCH] line, 2008-07-14).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I noticed this while I was looking at the effects of the next patch.

 t/t5100/0010 |   35 -----------------------------------
 1 files changed, 0 insertions(+), 35 deletions(-)
 delete mode 100644 t/t5100/0010

diff --git a/t/t5100/0010 b/t/t5100/0010
deleted file mode 100644
index f5892c9..0000000
--- a/t/t5100/0010
+++ /dev/null
@@ -1,35 +0,0 @@
-From b9704a518e21158433baa2cc2d591fea687967f6 Mon Sep 17 00:00:00 2001
-From: =3D?UTF-8?q?Lukas=3D20Sandstr=3DC3=3DB6m?=3D <lukass@etek.chalme=
rs.se>
-Date: Thu, 10 Jul 2008 23:41:33 +0200
-Subject: Re: discussion that lead to this patch
-MIME-Version: 1.0
-Content-Type: text/plain; charset=3DUTF-8
-Content-Transfer-Encoding: 8bit
-
-[PATCH] git-mailinfo: Fix getting the subject from the body
-
-"Subject: " isn't in the static array "header", and thus
-memcmp("Subject: ", header[i], 7) will never match.
-
-Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
-Signed-off-by: Junio C Hamano <gitster@pobox.com>
----
- builtin-mailinfo.c |    2 +-
- 1 files changed, 1 insertions(+), 1 deletions(-)
-
-diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
-index 962aa34..2d1520f 100644
---- a/builtin-mailinfo.c
-+++ b/builtin-mailinfo.c
-@@ -334,7 +334,7 @@ static int check_header(char *line, unsigned lines=
ize, char **hdr_data, int over
- 		return 1;
- 	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
- 		for (i =3D 0; header[i]; i++) {
--			if (!memcmp("Subject: ", header[i], 9)) {
-+			if (!memcmp("Subject", header[i], 7)) {
- 				if (! handle_header(line, hdr_data[i], 0)) {
- 					return 1;
- 				}
---=20
-1.5.6.2.455.g1efb2
-
--=20
1.6.5.1028.g985e.dirty
