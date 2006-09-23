From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][PATCH] for_each_ref() returning heads in wrong order
Date: Sat, 23 Sep 2006 19:42:35 +0200
Message-ID: <20060923174235.GB20017@pasky.or.cz>
References: <20060923160712.5890.73139.stgit@machine.or.cz> <20060923164759.GP8259@pasky.or.cz> <Pine.LNX.4.63.0609231919510.25853@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 19:42:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRBWS-0004Kj-FR
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 19:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWIWRmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWIWRmh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 13:42:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31452 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751374AbWIWRmh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 13:42:37 -0400
Received: (qmail 22520 invoked by uid 2001); 23 Sep 2006 19:42:35 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609231919510.25853@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27607>

  Hi,

Dear diary, on Sat, Sep 23, 2006 at 07:20:42PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Sat, 23 Sep 2006, Petr Baudis wrote:
> 
> > Dear diary, on Sat, Sep 23, 2006 at 06:36:21PM CEST, I got a letter
> > where Petr Baudis <pasky@suse.cz> said that...
> > > Using the #next branch I've now hit a problem with git-fetch-pack
> > > master choosing refs/bases/master (I geuss created by StGIT) instead
> > > of refs/heads/master. The old upload-pack returned the refs in the order
> > > heads-tags-everything_else but the new one just goes for whatever order
> > > readdir() returns them in (modulo merging with packed refs). I actually
> > > can't see the difference that caused this right now, though.
> 
> Why don't you just specify (or match) "heads/refs/master", so that 
> git-fetch-pack cannot choose anything wrong to begin with?

  hmm, does git-fetch prepend refs/heads/ to the refspecs or does it
pass them as is to git-fetch-pack?

  If the former, then we could as well do that, but in that case I'd
rather just require that for any refs passed to git-fetch-pack since
passing the "short form" just serves for buggy scripts to get confused
when someone adds some refs directory that sorts before heads/ to the
repository.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
