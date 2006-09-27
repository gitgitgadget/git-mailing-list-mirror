From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Corrected copy-and-paste thinko in ignore executable bit test case.
Date: Wed, 27 Sep 2006 15:51:13 -0400
Message-ID: <20060927195113.GA21668@spearce.org>
References: <20060927151849.GF20705@spearce.org> <7vr6xx9jta.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:51:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSfRA-0008MB-5Y
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030723AbWI0TvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030727AbWI0TvS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:51:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52134 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030723AbWI0TvR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:51:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSfQx-0006md-OH; Wed, 27 Sep 2006 15:51:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5AF8320FB28; Wed, 27 Sep 2006 15:51:13 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6xx9jta.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27927>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > This test should be testing update-index --add, not git-add as these
> > are two completely different implementations of what is essentially
> > the same task.
> 
> Thanks -- I'd rephrase the last sentence, though.

-- >8 --
Corrected copy-and-paste thinko in ignore executable bit test case.

This test should be testing update-index --add, not git-add to
ensure all possible interfaces behave the same way.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t3700-add.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index d36f22d..c20e4c2 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -35,7 +35,7 @@ test_expect_success \
 	'git repo-config core.filemode 0 &&
 	 echo foo >xfoo2 &&
 	 chmod 755 xfoo2 &&
-	 git-add xfoo2 &&
+	 git-update-index --add xfoo2 &&
 	 case "`git-ls-files --stage xfoo2`" in
 	 100644" "*xfoo2) echo ok;;
 	 *) echo fail; git-ls-files --stage xfoo2; exit 1;;
-- 
1.4.2.1.g1e40
