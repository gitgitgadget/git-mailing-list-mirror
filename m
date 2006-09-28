From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Use "hash1..hash2" instead of "from hash1 to hash2"
Date: Fri, 29 Sep 2006 00:11:12 +0200
Message-ID: <877iznbq0v.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 00:13:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT46D-0001SR-Bh
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWI1WLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 28 Sep 2006 18:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWI1WLR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:11:17 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:60374 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1750806AbWI1WLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 18:11:16 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8SMBDQ04879
	for <git@vger.kernel.org>; Fri, 29 Sep 2006 00:11:14 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28054>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh   |    2 +-
 git-merge.sh   |    2 +-
 git-resolve.sh |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 50ad101..1bc6108 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -182,7 +182,7 @@ fast_forward_local () {
 		;;
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
-		echo >&2 "  from $local to $2"
+		echo >&2 "  $local..$2"
 		git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
 		;;
 	    *)
diff --git a/git-merge.sh b/git-merge.sh
index 5b34b4d..fd587c5 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -197,7 +197,7 @@ f,*)
 	;;
 ?,1,"$head",*)
 	# Again the most common case of merging one remote.
-	echo "Updating from $head to $1"
+	echo "Updating $head..$1"
 	git-update-index --refresh 2>/dev/null
 	new_head=3D$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -u -v -m $head "$new_head" &&
diff --git a/git-resolve.sh b/git-resolve.sh
index 729ec65..6e4fb02 100755
--- a/git-resolve.sh
+++ b/git-resolve.sh
@@ -46,7 +46,7 @@ case "$common" in
 	exit 0
 	;;
 "$head")
-	echo "Updating from $head to $merge"
+	echo "Updating $head..$merge"
 	git-read-tree -u -m $head $merge || exit 1
 	git-update-ref -m "resolve $merge_name: Fast forward" \
 		HEAD "$merge" "$head"
--=20
1.4.2.1.g5a0f
