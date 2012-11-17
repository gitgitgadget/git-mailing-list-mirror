From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 7/7] completion: remove the now unused __gitcomp_1() internal
 helper function
Date: Sat, 17 Nov 2012 12:05:53 +0100
Message-ID: <1353150353-29874-8-git-send-email-szeder@ira.uka.de>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 12:07:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgF2-0007g5-RU
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab2KQLG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:06:58 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:55955 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2KQLG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:06:57 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Lwje8-1TFvL51mcC-016PZ3; Sat, 17 Nov 2012 12:06:55 +0100
X-Mailer: git-send-email 1.8.0.220.g4d14ece
In-Reply-To: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:5Ak9eI8dXAL0Vu/zUXCC8rzHv9vCnVc5Uu+fWbty6ew
 1plZYa4hlKeDBqT/Yh4r55TPsmCozsnGz6CbQY7Xu8nvq1keZe
 OzBqSSz9lCXYtjJRstzHQYqSMaQM37vF/ZHWTEIFnwa1ts5Y8w
 QFrSz6yLFf2+5CN3JBmhne3Dn33jnI61Z4whdTpGX0RkPvwgRZ
 foaXAz36s1YpfKZfPnxgGeAcJgAeB8REGNyh5NDERV+YfHch/g
 sG6q/ZOSlHFOsRLXVm7Fn1UWHWORjNjiGbfY6atr27cANHu1f3
 zd7HWGIF8wTe2bVmMdf4FZ0GIL8/WtcpbVudF5nAhlXI2jk3TQ
 BdWENCXhkyMY0iGsYyWtrlwEagulmeMwSGYCUFPlxBUrtVwxzB
 0lbDVl1VVyBLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209946>

Since the __gitcomp_1() helper is basically only an implementation
detail of __gitcomp() that exists solely for performance reasons (see
ab02dfe5 (bash completion: Improve responsiveness of git-log
completion, 2008-07-13)), it's quite unlikely that anyone uses or ever
used it besides __gitcomp().  And now __gitcomp() doesn't need it
anymore either, so delete it.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 283ef99b..a281b28d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -56,19 +56,6 @@ __gitdir ()
 	fi
 }
=20
-__gitcomp_1 ()
-{
-	local c IFS=3D$' \t\n'
-	for c in $1; do
-		c=3D"$c$2"
-		case $c in
-		--*=3D*|*.) ;;
-		*) c=3D"$c " ;;
-		esac
-		printf '%s\n' "$c"
-	done
-}
-
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
--=20
1.8.0.220.g4d14ece
