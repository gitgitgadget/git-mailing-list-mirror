From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] git-fetch: Allow fetching the remote HEAD
Date: Tue, 30 Jan 2007 10:36:24 +0100
Message-ID: <87fy9sluuf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 10:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBpQ0-0002bB-Kw
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 10:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965473AbXA3Jgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 30 Jan 2007 04:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965468AbXA3Jgp
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 04:36:45 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:42232 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965473AbXA3Jgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 04:36:44 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0U9afU30178
	for <git@vger.kernel.org>; Tue, 30 Jan 2007 10:36:42 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38144>


=2E.. with:

$ git fetch ${remote} HEAD

Also

$ git fetch ${remote} :${localref}

worked, but

$ git fetch ${remote} HEAD:{localref}

didn't. Now both are equivalent.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-parse-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 9d26967..3e783b7 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -183,7 +183,7 @@ canon_refs_list_for_fetch () {
 			done
 		fi
 		case "$remote" in
-		'') remote=3DHEAD ;;
+		'' | HEAD ) remote=3DHEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
 		heads/* | tags/* | remotes/* ) remote=3D"refs/$remote" ;;
 		*) remote=3D"refs/heads/$remote" ;;
--=20
1.5.0.rc2.224.gb3a6
