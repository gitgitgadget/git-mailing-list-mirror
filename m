From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cg-status: quote head name
Date: Mon, 14 Nov 2005 17:57:41 -0500
Message-ID: <1132009061.24084.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 23:58:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbnGn-000714-R3
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 23:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVKNW5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 17:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVKNW5n
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 17:57:43 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:58532 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932230AbVKNW5n
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 17:57:43 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EbnGg-0001Xu-1M
	for git@vger.kernel.org; Mon, 14 Nov 2005 17:57:42 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EbnGf-0001OC-CH; Mon, 14 Nov 2005 17:57:41 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11860>

cg-status should quote head name to deal with branches that have active
characters (e.g. spaces) in the name.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-status b/cg-status
index b67f505..2cb86be 100755
--- a/cg-status
+++ b/cg-status
@@ -124,8 +124,8 @@ if [ "$gitstatus" ]; then
 
 	echo "Heads:"
 	for head in $_git/refs/heads/*; do
-		headsha1=$(cat $head)
-		headname=$(basename $head)
+		headsha1=$(cat "$head")
+		headname=$(basename "$head")
 		[ "$headname" = "cg-seek-point" ] && continue
 		cf=" "; rf=" "
 		[ "$headname" = "$_git_head" ] && cf=">"


-- 
Regards,
Pavel Roskin
