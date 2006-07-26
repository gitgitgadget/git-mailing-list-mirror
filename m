From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 04:10:58 +0200
Message-ID: <20060726021058.GV13776@pasky.or.cz>
References: <Pine.LNX.4.63.0607251809340.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060726010358.20964.80443.stgit@machine> <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 04:11:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5Yrk-0002RY-RH
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 04:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWGZCLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 22:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWGZCLB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 22:11:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53422 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030358AbWGZCLA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 22:11:00 -0400
Received: (qmail 25677 invoked by uid 2001); 26 Jul 2006 04:10:58 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607260356480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24199>

  Hi,

Dear diary, on Wed, Jul 26, 2006 at 04:01:03AM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> After a lot of fiddling, it works here. Remarks:

  thanks for the testing!

> - It is not at all easy to run git (Perl scripts) in-place. At least for 
>   Python, you can set a variable in config.mak and be done with it.

  Does setting prefix to the same directory as where your Git tree is
help?  (If so, we might want to document it.)

> - private_Error.pm is not used. I had to rename it for Error.pm to be
>   picked up.

  Hmm, yes, I guess it is copied in place only during the installation.
We might add something like

	all:
		cp private-Error.pm blib/lib/Error.pm

to the perl/Makefile. Opinions?

> - It even passes t7001 now. _After_ I spent two hours rewriting it in C.

  Thanks for the patience - I hope we will finally get all the remaining
Perl problems sorted out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
