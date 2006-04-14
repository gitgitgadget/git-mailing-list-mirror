From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff --stat: no need to ask funcnames nor context.
Date: Thu, 13 Apr 2006 21:37:44 -0700
Message-ID: <7vzmiovkkn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604140012560.10924@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 06:38:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUG4A-0005XK-LQ
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 06:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWDNEhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 00:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWDNEhr
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 00:37:47 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:27832 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965094AbWDNEhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 00:37:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414043745.ZYFP24539.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 00:37:45 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604140012560.10924@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 14 Apr 2006 00:15:30 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18683>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, you can say "git diff --stat" (to get an idea how many changes are
> uncommitted), or "git log --stat".
>     
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Nice.

-- >8 --
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

84981f9ad963f050abf4fe33ac07d36b4ea90c6d
diff --git a/diff.c b/diff.c
index c120239..f1b672d 100644
--- a/diff.c
+++ b/diff.c
@@ -438,8 +438,8 @@ static void builtin_diffstat(const char 
 		xdemitcb_t ecb;
 
 		xpp.flags = XDF_NEED_MINIMAL;
-		xecfg.ctxlen = 3;
-		xecfg.flags = XDL_EMIT_FUNCNAMES;
+		xecfg.ctxlen = 0;
+		xecfg.flags = 0;
 		ecb.outf = xdiff_outf;
 		ecb.priv = diffstat;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
-- 
1.3.0.rc3.g9306
