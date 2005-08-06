From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk "hyperlinks"
Date: Sat, 06 Aug 2005 09:31:38 -0700
Message-ID: <7vpssr9gd1.fsf@assigned-by-dhcp.cox.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
	<17140.47152.672091.474748@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 18:32:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1RaM-0001Is-C8
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 18:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbVHFQbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 12:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbVHFQbl
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 12:31:41 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52868 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263252AbVHFQbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 12:31:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806163139.HKKG8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 12:31:39 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17140.47152.672091.474748@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sat, 6 Aug 2005 23:16:32 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Good idea.  Also done. :)  It's on master.kernel.org now in my gitk.git
> directory.  Hopefully Junio will pull it into git soon.

I did, and will push it out shortly, but I think you need this
patch.  To make later merges from you easier, I will not put
this in my "master" branch.

------------
[PATCH] gitk proposed fix: handle more than one SHA1 links.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

c423b62a66d4c4f2a7856cada507f973e9140590
diff --git a/gitk b/gitk
--- a/gitk
+++ b/gitk
@@ -1802,6 +1802,7 @@ proc selectline {l isnew} {
 	set linkid [string range $comment $s $e]
 	if {![info exists idline($linkid)]} continue
 	incr e
+	incr i
 	$ctext tag conf link$i -foreground blue -underline 1
 	$ctext tag add link$i "$commentstart + $s c" "$commentstart + $e c"
 	$ctext tag bind link$i <1> [list selectline $idline($linkid) 1]
