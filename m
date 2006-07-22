From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Defaulting fetch to origin when set in the repo-config
Date: Sun, 23 Jul 2006 00:54:40 +0200
Message-ID: <87mzb1s11r.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Jul 23 00:55:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4QN9-000895-Kq
	for gcvg-git@gmane.org; Sun, 23 Jul 2006 00:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWGVWyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 22 Jul 2006 18:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWGVWyf
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 18:54:35 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:4052 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751072AbWGVWyf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Jul 2006 18:54:35 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k6MLt3d00901
	for <git@vger.kernel.org>; Sat, 22 Jul 2006 23:55:04 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24081>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>

---

diff --git a/git-fetch.sh b/git-fetch.sh
index a393a50..c2eebee 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -70,7 +70,8 @@ case "$#" in
 0)
 	test -f "$GIT_DIR/branches/origin" ||
 		test -f "$GIT_DIR/remotes/origin" ||
-			die "Where do you want to fetch from today?"
+			git-repo-config --get remote.origin.url >/dev/null ||
+				die "Where do you want to fetch from today?"
 	set origin ;;
 esac
=20
