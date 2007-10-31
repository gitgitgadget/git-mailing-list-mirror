From: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [PATCH 1/3] Fix --strategy parsing in git-rebase--interactive.sh
Date: Wed, 31 Oct 2007 03:20:30 +0100
Message-ID: <1193797232-1062-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Oct 31 03:21:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3CS-0008Nq-6A
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 03:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbXJaCUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 22:20:36 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752236AbXJaCUg
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 22:20:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:54940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751607AbXJaCUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 22:20:35 -0400
Received: (qmail invoked by alias); 31 Oct 2007 02:20:33 -0000
Received: from i577B89A4.versanet.de (EHLO localhost) [87.123.137.164]
  by mail.gmx.net (mp035) with SMTP; 31 Oct 2007 03:20:33 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+ibJUJxBGiSAYwC2Uwi49EJcFM75t0vXi72t3vge
	2CGD1SNwTPUGi4
X-Mailer: git-send-email 1.5.3.4.456.g072a
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62780>

=46or the --strategy/-s option, git-rebase--interactive.sh dropped the
parameter which it was trying to parse.

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0dd77b4..f667ae8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -387,7 +387,6 @@ do
 		output git reset --hard && do_rest
 		;;
 	-s|--strategy)
-		shift
 		case "$#,$1" in
 		*,*=3D*)
 			STRATEGY=3D"-s `expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`" ;;
--=20
1.5.3.4.456.g072a
