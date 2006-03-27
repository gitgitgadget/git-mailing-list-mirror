From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] cogito: Push tags over http
Date: Mon, 27 Mar 2006 21:12:11 +0200
Message-ID: <20060327191211.G54ad5023@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 27 21:13:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNx8X-00032Q-UK
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 21:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWC0TMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 14:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWC0TMR
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 14:12:17 -0500
Received: from ncs.stosberg.net ([217.195.44.246]:62905 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751212AbWC0TMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 14:12:16 -0500
Received: from leonov (p213.54.74.77.tisdip.tiscali.de [213.54.74.77])
	by ncs.stosberg.net (Postfix) with ESMTP id 71951AEBA007
	for <git@vger.kernel.org>; Mon, 27 Mar 2006 21:12:04 +0200 (CEST)
Received: by leonov (Postfix, from userid 500)
	id 189A9E73D8; Mon, 27 Mar 2006 21:12:12 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Received: from leonov ([unix socket]) by leonov (Cyrus v2.1.18-IPv6-Debian-2.1.18-1) with LMTP; Mon, 27 Mar 2006 21:03:46 +0200
X-Sieve: CMU Sieve 2.2
User-Agent: mutt-ng/devel-r796 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18087>


A trivial patch for cg-push allows to push tags over http.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>

---

 cg-push |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e9540d5f524c54102a93570031fb59156cec4188
diff --git a/cg-push b/cg-push
index b6b8954..4332b28 100755
--- a/cg-push
+++ b/cg-push
@@ -70,7 +70,7 @@ sprembranch=":refs/heads/$rembranch"
 
 if [ "${uri#http://}" != "$uri" -o "${uri#https://}" != "$uri" ]; then
 	# git-http-push doesn't like $sprembranch
-	git-http-push "$uri/" "$locbranch:$rembranch"
+	git-http-push "$uri/" "$locbranch:$rembranch" "${tags[@]}"
 elif [ "${uri#git+ssh://}" != "$uri" ]; then
 	send_pack_update "$name" "$(echo "$uri" | sed 's#^git+ssh://\([^/]*\)\(/.*\)$#\1:\2#')" "$locbranch$sprembranch" "${tags[@]}"
 elif [ "${uri#rsync://}" != "$uri" ]; then
-- 
1.2.GIT
