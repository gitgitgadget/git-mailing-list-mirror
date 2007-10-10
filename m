From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: use git log --no-color vs. "diff.color = true"
Date: Wed, 10 Oct 2007 10:58:30 +0200
Message-ID: <200710101058.30911.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfXLA-0005VO-10
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 10:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbXJJIym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 04:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbXJJIym
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 04:54:42 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:43454 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbXJJIym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 04:54:42 -0400
Received: from host72-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.72]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.72+2XYcYy2orPKV; Wed, 10 Oct 2007 10:54:38 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60485>

Setting "diff.color = true" in the configuration makes "git log"
output use color codes. These aren't parsed by gitk, so use
"git log --no-color" instead.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

Yes, this is the same fix that commit eeebd8d8c5ab63494abe200b30a840aa99ee7412
applied on git-svn.

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..999e3c2 100755
--- a/gitk
+++ b/gitk
@@ -92,7 +92,7 @@ proc start_rev_list {view} {
 	set order "--date-order"
     }
     if {[catch {
-	set fd [open [concat | git log -z --pretty=raw $order --parents \
+	set fd [open [concat | git log --no-color -z --pretty=raw $order --parents \
 			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
-- 
1.5.3.4
