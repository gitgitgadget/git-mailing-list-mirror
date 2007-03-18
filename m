From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-fetch: Fix single_force in append_fetch_head
Date: Mon, 19 Mar 2007 00:16:23 +0100
Message-ID: <87abyai1mg.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:16:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT4bm-0007xO-LR
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 00:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbXCRXQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 19:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbXCRXQK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 19:16:10 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:43756 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970AbXCRXQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 19:16:09 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l2ING5q21188
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 00:16:06 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42540>


This fixes the single force (+) when fetched with fetch_per_ref.

Also use $LF as separator because IFS is $LF.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-fetch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index a650116..f97263a 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -114,8 +114,8 @@ ls_remote_result=3D$(git ls-remote $exec "$remote")=
 ||
=20
 append_fetch_head () {
 	flags=3D
-	test -n "$verbose" && flags=3D"$flags -v"
-	test -n "$force" && flags=3D"$flags -f"
+	test -n "$verbose" && flags=3D"$flags$LF-v"
+	test -n "$force$single_force" && flags=3D"$flags$LF-f"
 	GIT_REFLOG_ACTION=3D"$GIT_REFLOG_ACTION" \
 		git-fetch--tool $flags append-fetch-head "$@"
 }
--=20
1.5.0.4.1024.g8085-dirty
