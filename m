From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH 2/2] use git quote in git-bisect
Date: Mon, 17 Jul 2006 00:28:15 +0200
Message-ID: <20060716222815.GB10135@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 17 00:29:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from [209.132.176.167] (helo=vger.kernel.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2F6o-0004Ls-Gp
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 00:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWGPW2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 18:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWGPW2W
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 18:28:22 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:16092 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751327AbWGPW2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 18:28:22 -0400
Received: from fwd31.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1G2F62-0004kv-02; Mon, 17 Jul 2006 00:28:18 +0200
Received: from tigra.home (rA6ukoZr8eWyi+62q+lURCSfs+EBAgCs2ltJwjQHkV15KxIGVES66Z@[84.160.88.78]) by fwd31.sul.t-online.de
	with esmtp id 1G2F5z-08JrkW0; Mon, 17 Jul 2006 00:28:15 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 334EA277AF;
	Mon, 17 Jul 2006 00:28:15 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G2F5z-0002eZ-6i; Mon, 17 Jul 2006 00:28:15 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-ID: rA6ukoZr8eWyi+62q+lURCSfs+EBAgCs2ltJwjQHkV15KxIGVES66Z
X-TOI-MSGID: 2e7b3484-3ad1-4e4d-98b4-dbf9e259c2a6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23955>

The echo after git quote is just to match the behaviour of the
previous script exactly (yes, it is needed - it's bisect log output).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-bisect.sh |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 06a8d26..8407960 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -13,13 +13,8 @@ git bisect log			show bisect log.'
 . git-sh-setup
 
 sq() {
-	@@PERL@@ -e '
-		for (@ARGV) {
-			s/'\''/'\'\\\\\'\''/g;
-			print " '\''$_'\''";
-		}
-		print "\n";
-	' "$@"
+        git quote -- "$@"
+        echo
 }
 
 bisect_autostart() {
-- 
1.4.1.gb944
