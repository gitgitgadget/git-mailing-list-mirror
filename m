From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 04:12:23 +0200
Message-ID: <20100418021223.GP10939@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004180246.18263.jnareb@gmail.com>
 <20100418005917.GO10939@machine.or.cz>
 <201004180324.54722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 04:12:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Jzt-0005Ld-IC
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 04:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626Ab0DRCM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 22:12:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35713 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756574Ab0DRCM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 22:12:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D3C8F86208F; Sun, 18 Apr 2010 04:12:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004180324.54722.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145202>

On Sun, Apr 18, 2010 at 03:24:53AM +0200, Jakub Narebski wrote:
> On Sun, Apr 18, Petr Baudis wrote:
> > On Sun, Apr 18, 2010 at 02:46:16AM +0200, Jakub Narebski wrote:
> 
> > > Or is it
> > > meant as web analogue of git-gui: a committool, with ability to create
> > > new commits, perhaps to edit files (and add them, delete them, move them
> > > around), a bit like ikiwiki with Git backend, or other Git based wikis
> > > and blogs?
> > 
> > Yes. Though it is probably supposed to be real Git frontend with Git
> > semantics, not something more abstract with Git under the hood.
> 
> Hmmm... doesn't look so easy.  What to do about simultaneous access
> (what webmin does?), and working directory (what ikiwiki does?)?

  I would expect it to work the same as if you work in single working
copy from multiple shells. If multiple people want to collaborate, each
should have their own clone to begin with.

> Well, you can always add some of "Web Client" functionality directly
> to gitweb (for example dispatch must be, I think, in gitweb).

But I don't think you can reasonably separate a major portion of web
client that would not depend on gitweb functions like href(), format*()
etc. all over the map.

> Or you
> can (ab)use "do $gitwebgui_pm;" instead of "require $gitwebgui_pm;",
> like in http://repo.or.cz/w/git/jnareb-git.git/commitdiff/261b99e3#patch3
> (second chunk).

This already occured to me, yes. It's tempting to have this as the
emergency way out, shall other things fail. But .

> OTOH we can always make gitweb "use Git;" and move some of its routines,
> to it after generalization (e.g. config management using single run of
> "git config -l -z", unquoting paths, parsing commit/tag/ls-tree/difftree
> etc., date parsing and conversion).

Yes, but not things like href(), git_header_html() and other absolutely
essential routines.

> > > 3. Split Gitweb, add "Web Client" as one of modules.  Might be best
> > >    from the purity point of view, but is practical only if it is
> > >    integrated in gitweb.  That would require getting gitweb maintainer
> > >    out of GSoC.   Also I am not sure how feaible this approach would be.
> > 
> > Would it be really required to get gitweb maintainer out of GSoC in
> > order to go this way? Why?
> 
> Well, at least someone who would be able to manage integrating split
> gitweb.  I think that splitting gitweb, and doing it well, is quite
> outside this GSoC 2010 proposal: it would be too much. 

This was my hesitation at the beginning, but I'm not really sure if
it's really so hard, _if_ we resist the temptation to snowball unrelated
cleanups on top of it. Conceptually, it isn't really hard to do, is it?
The only tricky thing would be making sure instaweb still works and
installation is still easy, but I don't see anything really difficult in
this area either...?

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
