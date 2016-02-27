From: tboegi@web.de
Subject: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Sat, 27 Feb 2016 19:28:44 +0100
Message-ID: <1456597724-26497-1-git-send-email-tboegi@web.de>
References: <20160208225806.GA3487@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: normalperson@yhbt.net, k_satoda@f2.dion.ne.jp,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 19:26:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjZo-0001Od-KO
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992511AbcB0S0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 13:26:45 -0500
Received: from mout.web.de ([212.227.17.12]:59072 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725AbcB0S0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:26:44 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MXYWA-1aO6JT42pq-00WYW9; Sat, 27 Feb 2016 19:26:34
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <20160208225806.GA3487@dcvr.yhbt.net>
X-Provags-ID: V03:K0:O+Nt84QYrjEkMn3Wfsf3j5atBKffKbJantv+pXrLN9CKvpWLyX6
 sKvxM8E7a9Mg2u0mSlUcoFlvnG1mVJtSlmGnuGPfYDQzJWzFhwExprkSCf/Rb94+sXNMlys
 MPyhyKlCwzGenuRZHMHqvS+NumCHTQcX5GLhJR1JKlTNydp1idK6QzV/wGjqOPl0xVH4HXm
 pL7+Wh9WIhffg1IJ7DyFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fjqIZoGeHAE=:xP6MriRHqVrX7PYG4kMev3
 CulNAa46yH8OQl64j0MEObzstuQWCjttcaZWvX7cBmb7ZLavDIaJUGDbRnH6ck30ECZNUoqZi
 LPPRam7SMoRLUZTe5/5bC8XOsMV31Ona7MhEcvYHbVLtkOIJdzF9iJYRfc9RD85+GjVIxTyUG
 l5/fX89DVwOjGTALHHX9eWcqTCbIgmlAFieZosTOu3Y37T3I8N+hs8mckBIt1yXSnorZUpLpG
 z3Q0R6hwAY3zr3FWThd8IymbPZZoo0Il+SA0EPT+MRwFlZYEqzhzznjAnHgOYdbG8vYu2E2ND
 qSDG/LO3N89av5W4EGLWoF5DBeXIqMu2sgNYUbZ+dxq+WrH02cVU795j/9Xp5aN0NIYRRBwpG
 UKektLCKO0Y37rkitck9yGjpFamRVPT+dto1LzXVE8wTT2ItTb3Q2IeJtTAZmrtfP92tvOSKl
 YwC8X7VYlkvfHvvNVXIKZNSOeK/O7u3JIN/giItjzXrYG9w3ITEL0mgm1wBDoF3jQ/Ey8bdNS
 5I30vD+Y94Hb7u3qKvu0jLD5z2AOlq2mAVGfjYFgpd9nbMLyx/VcRNruUscnahq1o3ts4Yvh1
 mGcumeJwBlyJXh8cHXAj+znM+6rgbgCdtl8PqilGZd8rPTIeG/fr9t/5XBqyPae23vInGtXTw
 19WJXkK8NQRfcBRAcQTZMrmRRr30gIhyYwetQNg8UbLlAqOy3k4CgLF2Wx0v2uTruVwlEMnZy
 wode7oy5dJH10ersBY7Twk1r3HOMhslsdwW6kJk27SAqHBhXih0UW8WijhBEN5uCjjLi2K1g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287717>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

HFS+ under Mac OS X doesn't allow file names like "\201\207",
so skip the tests using cp932.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9115-git-svn-dcommit-funky-renames.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn=
-dcommit-funky-renames.sh
index 0990f8d..805a9eb 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -93,7 +93,7 @@ test_expect_success 'git svn rebase works inside a fr=
esh-cloned repository' '
 # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
 # > "Private use area") when creating or accessing files.
 prepare_a_utf8_locale
-test_expect_success UTF8 'svn.pathnameencoding=3Dcp932 new file on dco=
mmit' '
+test_expect_success !UTF8_NFD_TO_NFC,UTF8 'svn.pathnameencoding=3Dcp93=
2 new file on dcommit' '
 	LC_ALL=3D$a_utf8_locale &&
 	export LC_ALL &&
 	neq=3D$(printf "\201\202") &&
@@ -105,10 +105,10 @@ test_expect_success UTF8 'svn.pathnameencoding=3D=
cp932 new file on dcommit' '
 '
=20
 # See the comment on the above test for setting of LC_ALL.
-test_expect_success 'svn.pathnameencoding=3Dcp932 rename on dcommit' '
+test_expect_success !UTF8_NFD_TO_NFC,UTF8 'svn.pathnameencoding=3Dcp93=
2 rename on dcommit' '
 	LC_ALL=3D$a_utf8_locale &&
 	export LC_ALL &&
-	inf=3D$(printf "\201\207") &&
+	inf=3D$(printf "\201\207"o) &&
 	git config svn.pathnameencoding cp932 &&
 	echo inf >"$inf" &&
 	git add "$inf" &&
--=20
2.7.0.303.g2c4f448.dirty
