From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull for update of netdev fails.
Date: Sat, 23 Sep 2006 05:44:07 +0200
Message-ID: <20060923034407.GF8259@pasky.or.cz>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 05:44:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQyRN-0005Bo-3A
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 05:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWIWDoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 23:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWIWDoK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 23:44:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25029 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750773AbWIWDoJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 23:44:09 -0400
Received: (qmail 9461 invoked by uid 2001); 23 Sep 2006 05:44:07 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	catalin.marinas@gmail.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27557>

Dear diary, on Wed, Sep 20, 2006 at 11:14:25PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> Another, even more serious problems with rebasing: You can introduce a bug 
> by rebasing. Meaning: git-rebase can succeed, even compilation is fine, 
> but the sum of your patches, and the patches you are rebasing on, is 
> buggy. And there is _no_ way to bisect this, since the "good" version can 
> be gone for good.

Yes, I agree that this really is a problem, but that's a fundamental
limitation. At least for StGIT-maintained floating branches the latest
bleeding edge StGIT could fix that. (Except that the problem outlined by
Linus is present here as well, first prune will wipe your older patch
versions and your patch log will be useless - Catalin? Can we store the
older patch versions references in something like
.git/refs/patches-old/?) And except that it does that only for you -
there should be a way to conveniently mirror (clone+pull) the patch
stack setup.

> As for the problem git-rebase tries to solve: you can get a clean branch 
> by cherry-picking what you have into a temporary branch, for the sole 
> purpose of being history clean.

That's not really a reliable option because after getting your patches
through Christopher Hellwig you _will_ need to go back and poke some
patches in that history.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
