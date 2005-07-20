From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] cogito: master as the default remote branch
Date: Wed, 20 Jul 2005 12:41:35 +0200
Message-ID: <87ek9tkbds.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jul 20 12:43:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvC2H-00024X-Af
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 12:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVGTKmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Jul 2005 06:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVGTKmD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 06:42:03 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:1222 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261151AbVGTKlJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2005 06:41:09 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j6KAf4A04430;
	Wed, 20 Jul 2005 12:41:05 +0200
To: pasky@suse.cz, git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Recover the old behavior of the remote branch name

=2E.. specified in $_git/branches/$name and defaulting to master.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

 cg-pull |    2 +-
 cg-push |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -249,7 +249,7 @@ name=3D${ARGS[0]}
 [ "$name" ] || die "where to pull from?"
 uri=3D$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch=
: $name"
=20
-rembranch=3D$_git_head
+rembranch=3Dmaster
 if echo "$uri" | grep -q '#'; then
 	rembranch=3D$(echo $uri | cut -d '#' -f 2)
 	uri=3D$(echo $uri | cut -d '#' -f 1)
diff --git a/cg-push b/cg-push
--- a/cg-push
+++ b/cg-push
@@ -26,7 +26,7 @@ name=3D${ARGS[0]}
 [ "$name" ] || die "where to push from?"
 uri=3D$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch=
: $name"
=20
-rembranch=3D$_git_head
+rembranch=3Dmaster
 if echo "$uri" | grep -q '#'; then
 	rembranch=3D$(echo $uri | cut -d '#' -f 2)
 	uri=3D$(echo $uri | cut -d '#' -f 1)
