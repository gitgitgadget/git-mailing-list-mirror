From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] repack: don't report "Nothing new to pack." if -q is given
Date: Tue, 3 Jul 2007 10:47:58 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070703084757.GA4694@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 10:48:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5e3P-00059Y-Iw
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 10:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbXGCIsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Jul 2007 04:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbXGCIsF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 04:48:05 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:60541 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755142AbXGCIsE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 04:48:04 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I5e3G-00076N-1P
	for git@vger.kernel.org; Tue, 03 Jul 2007 10:48:02 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l638m0Yq007587
	for <git@vger.kernel.org>; Tue, 3 Jul 2007 10:48:00 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l638m0cJ007586
	for git@vger.kernel.org; Tue, 3 Jul 2007 10:48:00 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51467>

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
This patch is on top of maint.  For master and next you need
s/name/names/.

Best regards
Uwe

 git-repack.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index ddfa8b4..d980275 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -65,7 +65,9 @@ args=3D"$args $local $quiet $no_reuse_delta$extra"
 name=3D$(git-pack-objects --non-empty --all --reflog $args </dev/null =
"$PACKTMP") ||
 	exit 1
 if [ -z "$name" ]; then
-	echo Nothing new to pack.
+	if test -q "$quiet"; then
+		echo Nothing new to pack.
+	fi
 else
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
--=20
1.5.2.2.1451.gb0e5e


--=20
Uwe Kleine-K=F6nig

exit vi, lesson II:
: w q ! <CR>

NB: write the current file
