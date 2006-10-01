From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/2] merge and resolve: Output short hashes and .. in "Updating ..."
Date: Sun, 01 Oct 2006 05:34:17 +0200
Message-ID: <87u02o675y.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Oct 01 05:34:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTs5x-0001h5-Q8
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 05:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWJADeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 30 Sep 2006 23:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWJADeU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 23:34:20 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:63360 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751778AbWJADeU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 23:34:20 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k913YHQ12262
	for <git@vger.kernel.org>; Sun, 1 Oct 2006 05:34:18 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28168>



Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-merge.sh   |    2 +-
 git-resolve.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 5b34b4d..49c46d5 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -197,7 +197,7 @@ f,*)
 	;;
 ?,1,"$head",*)
 	# Again the most common case of merging one remote.
-	echo "Updating from $head to $1"
+	echo "Updating $(git-rev-parse --short $head)..$(git-rev-parse --shor=
t $1)"
 	git-update-index --refresh 2>/dev/null
 	new_head=3D$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -u -v -m $head "$new_head" &&
diff --git a/git-resolve.sh b/git-resolve.sh
index 729ec65..36b90e3 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -46,7 +46,7 @@ case "$common" in
 	exit 0
 	;;
 "$head")
-	echo "Updating from $head to $merge"
+	echo "Updating $(git-rev-parse --short $head)..$(git-rev-parse --shor=
t $merge)"
 	git-read-tree -u -m $head $merge || exit 1
 	git-update-ref -m "resolve $merge_name: Fast forward" \
 		HEAD "$merge" "$head"
--=20
1.4.2.1.g38049
