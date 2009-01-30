From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Quick and dirty mergetool fix
Date: Fri, 30 Jan 2009 14:22:31 +0000
Message-ID: <1233325351-31496-1-git-send-email-charles@hashpling.org>
References: <20090130140615.GA26321@hashpling.org>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: =?utf-8?q?Jonas=20Flod=C3=A9n?= <jonas.floden@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSuIC-0003XA-Qk
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298AbZA3OWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 09:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756281AbZA3OWg
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:22:36 -0500
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:48518 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756222AbZA3OWf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 09:22:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACKbgknUnw6U/2dsb2JhbADLEYQQBg
Received: from fhw-relay07.plus.net ([212.159.14.148])
  by relay.pcl-ipout02.plus.net with ESMTP; 30 Jan 2009 14:22:33 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1LSuGP-0001VU-5S; Fri, 30 Jan 2009 14:22:33 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0UEMVSv031525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 14:22:31 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0UEMVms031524;
	Fri, 30 Jan 2009 14:22:31 GMT
X-Mailer: git-send-email 1.6.1.235.gc9d403
In-Reply-To: <20090130140615.GA26321@hashpling.org>
X-Plusnet-Relay: 0265b29e5bf1c99a19ea8e68e60cf99e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107825>

---
 git-mergetool.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index aefdca7..db9ef43 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -161,9 +161,9 @@ merge_file () {
     local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
     remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && checkout_staged_file 1 "$prefix$MERGED" "$BASE"
-    local_present  && checkout_staged_file 2 "$prefix$MERGED" "$LOCAL"
-    remote_present && checkout_staged_file 3 "$prefix$MERGED" "$REMOTE"
+    base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
+    local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
+    remote_present && checkout_staged_file 3 "$MERGED" "$REMOTE"
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$MERGED':"
-- 
1.6.1.235.gc9d403
