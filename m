From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 11/12] merge,
	pull: remove deprecated 'merge.diffstat' config variable
Date: Wed, 16 Apr 2008 02:39:10 +0200
Message-ID: <1208306351-20922-12-git-send-email-szeder@ira.uka.de>
References: <7vzls7so8m.fsf@gitster.siamese.dyndns.org>
	<1208306351-20922-1-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-2-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-3-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-4-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-5-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-6-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-7-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-8-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-9-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-10-git-send-email-szeder@ira.uka.de>
	<1208306351-20922-11-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:27:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlvhr-0007aE-LX
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 02:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001AbYDPAj3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Apr 2008 20:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbYDPAj3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 20:39:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.179]:49616 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbYDPAjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 20:39:23 -0400
Received: from [127.0.1.1] (p5B13305D.dip0.t-ipconnect.de [91.19.48.93])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1JlvgH3Wzu-00043u; Wed, 16 Apr 2008 02:39:22 +0200
X-Mailer: git-send-email 1.5.5.76.g546c
In-Reply-To: <1208306351-20922-11-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V01U2FsdGVkX1+aoRGqySxidYtBlJMw7tEkMw4elqFGDY9QQxs
 oUS9vRr3UY/nQmd2qAyKqI4wuDJmEnscrkc3H8sBA2axpb+m17
 ItsYrtUY6sWXSOGg6GWvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/merge-config.txt  |    3 ---
 Documentation/merge-options.txt |    3 +--
 git-merge.sh                    |    1 -
 3 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-confi=
g.txt
index 45b107d..896f914 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -2,9 +2,6 @@ merge.stat::
 	Whether to print the diffstat berween ORIG_HEAD and merge result
 	at the end of the merge.  True by default.
=20
-merge.diffstat::
-	Deprecated equivalent of merge.stat.
-
 merge.log::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index f22fc6e..0333913 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -1,7 +1,6 @@
 --stat::
 	Show a diffstat at the end of the merge. The diffstat is also
-	controlled by the configuration option merge.stat (and the
-	deprecated merge.diffstat).
+	controlled by the configuration option merge.stat.
=20
 -n, \--no-stat::
 	Do not show diffstat at the end of the merge.
diff --git a/git-merge.sh b/git-merge.sh
index 263b337..db79851 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -213,7 +213,6 @@ parse_config "$@"
 while test $args_left -lt $#; do shift; done
=20
 if test -z "$show_diffstat"; then
-    test "$(git config --bool merge.diffstat)" =3D false && show_diffs=
tat=3Dfalse
     test "$(git config --bool merge.stat)" =3D false && show_diffstat=3D=
false
     test -z "$show_diffstat" && show_diffstat=3Dt
 fi
--=20
1.5.5.76.g546c
