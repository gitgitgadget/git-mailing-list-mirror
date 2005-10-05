From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Quote the missing GIT_DIR.
Date: Wed, 05 Oct 2005 18:58:10 +0200
Message-ID: <8764sbq4t9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Oct 05 19:00:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENCba-0006s0-OG
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVJEQ5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Oct 2005 12:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVJEQ5t
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:57:49 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:49614 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1030252AbVJEQ5s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 12:57:48 -0400
Received: from bela (nb-sbejar.ifae.es [192.101.162.156])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j95GveI29155
	for <git@vger.kernel.org>; Wed, 5 Oct 2005 18:57:46 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9722>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>


---

 git-commit.sh |    2 +-
 git-fetch.sh  |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

applies-to: f1aeb5e1caeb925ef1f7dc9993096556d10b49a9
9dbea220044374b801516e7d6b4ceb390c2cbd94
diff --git a/git-commit.sh b/git-commit.sh
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -198,7 +198,7 @@ else
 	PARENTS=3D""
 fi
 git-status >>"$GIT_DIR"/.editmsg
-if [ "$?" !=3D "0" -a ! -f $GIT_DIR/MERGE_HEAD ]
+if [ "$?" !=3D "0" -a ! -f "$GIT_DIR/MERGE_HEAD" ]
 then
 	rm -f "$GIT_DIR"/.editmsg
 	git-status
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -49,7 +49,7 @@ rsync_slurped_objects=3D
=20
 if test "" =3D "$append"
 then
-	: >$GIT_DIR/FETCH_HEAD
+	: >"$GIT_DIR/FETCH_HEAD"
 fi
=20
 append_fetch_head () {
@@ -86,11 +86,11 @@ append_fetch_head () {
     if git-cat-file commit "$head_" >/dev/null 2>&1
     then
 	headc_=3D$(git-rev-parse --verify "$head_^0") || exit
-	echo "$headc_	$not_for_merge_	$note_" >>$GIT_DIR/FETCH_HEAD
+	echo "$headc_	$not_for_merge_	$note_" >>"$GIT_DIR/FETCH_HEAD"
 	echo >&2 "* committish: $head_"
 	echo >&2 "  $note_"
     else
-	echo "$head_	not-for-merge	$note_" >>$GIT_DIR/FETCH_HEAD
+	echo "$head_	not-for-merge	$note_" >>"$GIT_DIR/FETCH_HEAD"
 	echo >&2 "* non-commit: $head_"
 	echo >&2 "  $note_"
     fi
---
0.99.8.GIT
