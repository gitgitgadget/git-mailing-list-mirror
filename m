From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/6] add 'merge.stat' config variable
Date: Sun,  6 Apr 2008 03:23:44 +0200
Message-ID: <1207445027-3152-4-git-send-email-szeder@ira.uka.de>
References: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
	<1207445027-3152-1-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-2-git-send-email-szeder@ira.uka.de>
	<1207445027-3152-3-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Teemu Likonen <tlikonen@iki.fi>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 03:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiJd6-0004kF-PU
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 03:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbYDFBYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 21:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYDFBYE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 21:24:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56134 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYDFBYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 21:24:03 -0400
Received: from [127.0.1.1] (p5B132413.dip0.t-ipconnect.de [91.19.36.19])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1JiJbu1e5G-0003tY; Sun, 06 Apr 2008 03:23:55 +0200
X-Mailer: git-send-email 1.5.5.rc3.9.gba703
In-Reply-To: <1207445027-3152-3-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX197W84Yz6ZglS55w+3GHKzQTTkiGWKIbvhj0X9
 +Rx+dbiOIKHsCir1FjInr7TTkKgB5oSFdmwTMg8gBW5AKratB9
 BwmuGs15GKN1YIp8zoTxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78876>

This variable has the same effect, as 'merge.diffstat'.
Also mention it in the documentation.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-config.txt  |    4 ++++
 Documentation/merge-options.txt |    2 +-
 git-merge.sh                    |    1 +
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index cc815cc..6d0a797 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,3 +1,7 @@
+merge.stat::
+	Whether to print the diffstat berween ORIG_HEAD and merge result
+	at the end of the merge.  True by default.
+
 merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index bc81580..b89ace8 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,6 +1,6 @@
 --stat::
 	Show a diffstat at the end of the merge. The diffstat is also
-	controlled by the configuration option merge.diffstat.
+	controlled by the configuration option merge.stat.
=20
 -n, \--no-stat::
 	Do not show diffstat at the end of the merge.
diff --git a/git-merge.sh b/git-merge.sh
index 1b693ad..004e367 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -210,6 +210,7 @@ while test $args_left -lt $#; do shift; done
=20
 if test -z "$show_diffstat"; then
     test "$(git config --bool merge.diffstat)" =3D false && show_diffs=
tat=3Dfalse
+    test "$(git config --bool merge.stat)" =3D false && show_diffstat=3D=
false
     test -z "$show_diffstat" && show_diffstat=3Dt
 fi
=20
--=20
1.5.5.rc3.9.gba703
