From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] t4201: use ISO8859-1 rather than ISO-8859-1
Date: Thu,  3 Dec 2009 11:52:45 -0600
Message-ID: <cQVSAldE71QbE653CpBd7qjd43g8URlxW7WO99KN4T0njgcXAbpAJQhTbfLeU5wxWrW84lsFVZE@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 03 18:53:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGFs5-0002hF-0M
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 18:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbZLCRxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 12:53:07 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbZLCRxG
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 12:53:06 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50544 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbZLCRxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 12:53:05 -0500
Received: by mail.nrlssc.navy.mil id nB3Hr9OY002960; Thu, 3 Dec 2009 11:53:09 -0600
X-OriginalArrivalTime: 03 Dec 2009 17:53:09.0818 (UTC) FILETIME=[79C5C1A0:01CA7441]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134461>

=46rom: Brandon Casey <drafnel@gmail.com>

Some ancient platforms do not have an extensive list of alternate names=
 for
character encodings.  For example, Solaris 7 and IRIX 6.5 do not know t=
hat
ISO-8859-1 is the same as ISO8859-1.  Modern platforms do know this, so=
 use
the older name.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t4201-shortlog.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index dd818f6..a01e55b 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -53,7 +53,7 @@ GIT_DIR=3Dnon-existing git shortlog -w < log > out
 test_expect_success 'shortlog from non-git directory' 'test_cmp expect=
 out'
=20
 iconvfromutf8toiso88591() {
-	printf "%s" "$*" | iconv -f UTF-8 -t ISO-8859-1
+	printf "%s" "$*" | iconv -f UTF-8 -t ISO8859-1
 }
=20
 DSCHO=3D"J=C3=B6h=C3=A4nn=C3=ABs \"Dsch=C3=B6\" Schind=C3=ABlin"
@@ -72,7 +72,7 @@ test_expect_success 'shortlog encoding' '
 	git config --unset i18n.commitencoding &&
 	echo 2 > a1 &&
 	git commit --quiet -m "$MSG1" --author=3D"$DSCHOE" a1 &&
-	git config i18n.commitencoding "ISO-8859-1" &&
+	git config i18n.commitencoding "ISO8859-1" &&
 	echo 3 > a1 &&
 	git commit --quiet -m "$(iconvfromutf8toiso88591 "$MSG2")" \
 		--author=3D"$(iconvfromutf8toiso88591 "$DSCHOE")" a1 &&
--=20
1.6.5.3
