From: Junio C Hamano <junkio@cox.net>
Subject: Re: [POLL] Who likes running Git without make install?
Date: Sun, 02 Jul 2006 23:54:47 -0700
Message-ID: <7vslljrxe0.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
	<7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
	<20060625010202.GX21864@pasky.or.cz>
	<20060625014009.GA21864@pasky.or.cz>
	<7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
	<20060625152157.GG21864@pasky.or.cz>
	<7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
	<20060701235906.GE29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 08:54:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxIKa-0004Wo-5D
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 08:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWGCGyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 02:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWGCGyt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 02:54:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58599 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750883AbWGCGys (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 02:54:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703065448.WTWK8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 02:54:48 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060701235906.GE29115@pasky.or.cz> (Petr Baudis's message of
	"Sun, 2 Jul 2006 01:59:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23158>

Petr Baudis <pasky@suse.cz> writes:

> Well, yes, it is ugly, but it was really cool that we could have used
> Git without installing it anywhere.
>
> But perhaps that's just me refusing to break his old ways of doing
> things. Does anyone else care about it? (And why?)

I do not think you need to break your old ways.  Perhaps a patch
like this might help.

-- >8 --
INSTALL: a tip for running after building but without installing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/INSTALL b/INSTALL
index f8337e2..ed502de 100644
--- a/INSTALL
+++ b/INSTALL
@@ -29,6 +29,19 @@ Issues of note:
    has been actively developed since 1997, and people have moved over to
    graphical file managers.
 
+ - You can use git after building but without installing if you
+   wanted to.  Various git commands need to find other git
+   commands and scripts to do their work, so you would need to
+   arrange a few environment variables to tell them that their
+   friends will be found in your built source area instead of at
+   their standard installation area.  Something like this works
+   for me:
+
+	GIT_EXEC_PATH=`pwd`
+	PATH=`pwd`:$PATH
+	PERL5LIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
+	export GIT_EXEC_PATH PATH PERL5LIB
+
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries:
 
