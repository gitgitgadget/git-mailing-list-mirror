From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-commit --review may permanently delete changes
Date: Sun, 24 Sep 2006 17:50:48 +0200
Message-ID: <20060924155048.GR20017@pasky.or.cz>
References: <20060728171152.G3a9ef049@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 17:51:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRWFr-0004I1-CM
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 17:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWIXPuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWIXPuv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 11:50:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54706 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751180AbWIXPuu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 11:50:50 -0400
Received: (qmail 28184 invoked by uid 2001); 24 Sep 2006 17:50:49 +0200
To: Dennis Stosberg <dennis@stosberg.net>
Content-Disposition: inline
In-Reply-To: <20060728171152.G3a9ef049@leonov.stosberg.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27671>

Dear diary, on Fri, Jul 28, 2006 at 07:11:52PM CEST, I got a letter
where Dennis Stosberg <dennis@stosberg.net> said that...
> If the patch is changed in the editor in such a way that cg-patch
> can not apply it, all changes made since the last commit are
> irrecoverably lost, which is _really_ bad.
> 
> This patch lets cg-commit reapply the old patch and keep the edited
> patch for manual fix-up.
> 
> Signed-off-by: Dennis Stosberg <dennis@stosberg.net>

Hmm, good catch. Unfortunately, we can't safely patch the original patch
over that either, since bits of the edited patch _might_ got applied.

As the first step, I've prevented Cogito from deleting any of the
temporary files and now it instead reports their name to the user and
lets him fix up the situation.

As the second stage, we should restore the original state of the tree. I
will do it when I get to it, patches welcome. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
