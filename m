From: Ryan Anderson <ryan@michonline.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 16:27:39 -0400
Message-ID: <20050428202739.GE30308@mythryan2.michonline.com>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org> <42713379.7080107@lsrfire.ath.cx> <Pine.LNX.4.58.0504281217100.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:23:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRFXE-0004pf-94
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVD1U1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVD1U1z
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 16:27:55 -0400
Received: from mail.autoweb.net ([198.172.237.26]:35771 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262155AbVD1U1s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 16:27:48 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DRFbs-0003YA-Pd; Thu, 28 Apr 2005 16:27:44 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DRFbs-0000eS-00; Thu, 28 Apr 2005 16:27:44 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DRFbs-0007qV-9T; Thu, 28 Apr 2005 16:27:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504281217100.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2005 at 12:21:26PM -0700, Linus Torvalds wrote:
> On Thu, 28 Apr 2005, Rene Scharfe wrote:
> > 
> > I think you misspelled "cg-log". :-D
> 
> My fingers have a hard time learning new patterns, so I've got:
> 
> 	torvalds@ppc970:~/git> cat ~/bin/git   
> 	#!/bin/sh
> 	cmd="cg-$1"
> 	shift
> 	$cmd "$@"
> 
> until my fingers learn the new thing.
> 
> > Doing "cg-log | head" gives me 10 lines of log and nothing else.  Maybe
> > the problem has been fixed between 0.7 and the current version I'm using
> > (commit ID 49612c471eebd26efe926a71752e254c1cdc382d)?
> 
> no, this is current as of an hour ago, same head you have.
> 
> It's a bash-specific thing, and depends on how you compiled bash.
> 
> Defining "DONT_REPORT_SIGPIPE" in config-top.h when building bash gets rid 
> of it, but I really don't want to rebuild bash just because of this ;)

Debian's bash seems to have that set, so it's a bit hard for me to test
(I don't really have any non-Debian machines around these days for some
reason.)

Try adding "set -e" to the beginning of cg-log.

That may cause some *other* problems, but I think it will fix this
problem.

-- 

Ryan Anderson
  sometimes Pug Majere
