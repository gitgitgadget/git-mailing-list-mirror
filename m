From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] sh-setup: explicitly mark CR as a field separator
Date: Sun, 25 Oct 2015 13:50:32 +0100 (CET)
Message-ID: <214d877df18f3189b1809946817aab9765450ea9.1445777347.git.johannes.schindelin@gmx.de>
References: <cover.1445777347.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 13:50:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqKl7-0005Sr-8w
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 13:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbbJYMup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 08:50:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:65137 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbbJYMuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 08:50:44 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MLelb-1ZrA6N2NmN-000t2Z;
 Sun, 25 Oct 2015 13:50:32 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445777347.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:yTLoL4aYE4ZxGVZ/wS6tw2f5o9KKoNoV4vtaAifaU9ILHzcOqr4
 W6Cm/kpgG3jbfv2R9ZyuX+4MeZ8tMmGsNiN+lgFqoUhXVLzRkwYNpUHFQv7Y9VkkEvKjLL0
 xTxK1iX9pn6zF23MiQpydlnswpf7Stb0svdOoT8PI+XH6eMYPae+15UOgnKuTCAIwXJ4dEg
 Ny3QmorAPIi+9kbFXWBmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o39sCQWe4cY=:96tw7Ev6C5scA1a7Z8bhQq
 WhhVCx9MqMy2cXRFTdZ8H/5om3fMjUbXsIwceHBV7zPxNKf0uuriiHlFKFdx8RQCGyq+vXIYb
 CBZRLTLEhZX/X7eAOhnT6E+KJWiBXyis6wNaxQrxQ6KxHb4dhUBzaj+2P5FrQJHLn74wwnfgq
 /uPHe+VQhF4sVeZcIhMIP840Yb/ot4U8uyNE3Y0tRaerFiegM7sMrTco/ZqIWPTXqiFzhWX0Z
 NBXxQO22bG8Ee5ZsZFef60s3WcRZrluVBvBp/3EJ9Ml3vsUs1OVO25u1+zaoaH6CbHIL2JoYC
 iGtuLNswTkqrt27ovAJS816bamI5V7HCjUvHooMiouCVvGKt9c/CNmosXHRcVjumQCNfH3sOp
 8iQAHdlm/wTmK7tdjqjtqCUSKR07d/iFrdEjG/grP4H3bHC+wgT51AJa+w/6BR3n5nrSEZS8+
 xylxRz1n8vNw+ulIJFX2rk/Nsh5vnhBdEsjOiJwD7NEtdYuxX+/hiDSrxPmaGDXRENPWxgcR2
 pzxzSYK8EygJbMASXG1LtdcyC98GcFKE97i6cb8OoLwuWoXI3OWBHPYPWQsRJoB46tTtEuED5
 EGGMPmYj8li6KciVspBWidlPEzVQmj+wkxbzPxJESdkekzwZfTdUfTMcvVwS9e86CQ6cW0/Y3
 pBxYUkKnka1pEEFKUEpxboE8iTDbWUVsT5fwsTmcPwsiGlrDp9Y2RDbNFUwKt/G3Opgg3pd7y
 WipLmvcMoX8Zezy29CYz5GhSka0IfUcn2rkxawO0JoWmfRIf7AG3v+eZsrRLOcCcMSzoTNud 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280144>

This is the correct thing to do, really: we already specify LF as
field separator.

Incidentally, this fixes the problem interactive rebase has when the
editor wants to save text with CR/LF line endings, as WordPad does
in Windows 10.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-sh-setup.sh               | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4691fbc..94dfe04 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -13,7 +13,7 @@ unset CDPATH
 # do not equate an unset IFS with IFS with the default, so here is
 # an explicit SP HT LF.
 IFS=' 	
-'
+'"$(printf '')"
 
 git_broken_path_fix () {
 	case ":$PATH:" in
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5dfa16a..98eb49a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1261,7 +1261,7 @@ test_expect_success 'static check of bad SHA-1' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-test_expect_failure 'editor saves as CR/LF' '
+test_expect_success 'editor saves as CR/LF' '
 	git checkout -b with-crlf &&
 	write_script add-crs.sh <<-\EOF &&
 	sed -e "s/\$/Q/" <"$1" | tr Q "" >"$1".new &&
-- 
2.1.4
