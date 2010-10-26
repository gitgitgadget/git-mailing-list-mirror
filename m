From: Bron Gondwana <brong@fastmail.fm>
Subject: Re: Why /var/cache/git?
Date: Wed, 27 Oct 2010 07:58:00 +1100
Organization: brong.net
Message-ID: <20101026205800.GA6544@brong.net>
References: <20101025103006.GA18782@brong.net>
 <4CC5A13F.2090702@eaglescrag.net>
 <20101026012224.GA3360@brong.net>
 <1288099299.8291.6.camel@drew-northup.unet.maine.edu>
 <20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Bron Gondwana <brong@fastmail.fm>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 26 22:58:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAqax-000060-JU
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 22:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab0JZU6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 16:58:05 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52156 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753080Ab0JZU6E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 16:58:04 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3A797544;
	Tue, 26 Oct 2010 16:58:04 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 26 Oct 2010 16:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=KlrUvRUZ0XNEWHcoFksWc/TzRuI=; b=EFwDYIPwEKi8lydT07HCLuEezRO0A7m63zB9UCIwMkvcpdgjIfKwNC4qBjkK77N2TWZDOuc4fGrZUfPp+5w8knxZFNPDpN2ShRn7EY3rpgAtIMHXLVuM+H4GbnU7gQUYisPJvOAMAJsIySOxGruZpW8M9x4cvAbQuzf2jYwlu5g=
X-Sasl-enc: efnBHKmkhOApi3HtY+zX6GVWHWZyAzfVHevL9PnqfyeA 1288126683
Received: from launde (124-168-121-62.dyn.iinet.net.au [124.168.121.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BC39440416B;
	Tue, 26 Oct 2010 16:58:03 -0400 (EDT)
Received: by launde (Postfix, from userid 1000)
	id C28F541F97; Wed, 27 Oct 2010 07:58:00 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20101026152218.3931.qmail@d862ae2b10e11a.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160007>

On Tue, Oct 26, 2010 at 03:22:18PM +0000, Gerrit Pape wrote:
> On Tue, Oct 26, 2010 at 09:21:39AM -0400, Drew Northup wrote:
> > On Tue, 2010-10-26 at 12:22 +1100, Bron Gondwana wrote:
> > > I have no problem with /var/git - it's /var/cache/git that worries
> > > me, since the FHS quite clearly says that blowing away /var/cache/*
> > > is not a problem.  It makes sense to back up /var/lib/ on any machine,
> > > since that's somewhere that contains application data.  We already
> > > back up a few things from /var/lib (like /var/lib/svn for example,
> > > at least until we finish this switchover!)
> > 
> > Bron,
> > Doing a 'git grep "/var"' on the git sources and then searching that
> > output for "cache" turns up nothing. I think you'd best bring this up
> > with the Debian package maintainer. Debian is well known for thinking it
> > knows better than the original authors where stuff should be--and that's
> > why I don't run Debian as a server (too much time spent transliterating
> > paths just to make stuff work properly--when I'm lucky; it makes an
> > excellent desktop for beginners).
> 
> Hi, it's also not my preference, but Debian adheres to the FHS.
> Unfortunately /var/git is not allowed by the FHS, so a different
> location must be chosen for Debian.  I chose /var/cache/git/, and
> suggested to populate that directory with symlinks to the repositories
> that should be available through git-daemon or gitweb, see
> http://bugs.debian.org/483788

Maybe you'd better read the FHS again to double check that you're
adhering.

http://www.pathname.com/fhs/pub/fhs-2.3.html#VARCACHEAPPLICATIONCACHEDATA

Purpose:

  /var/cache is intended for cached data from applications. 
  Such data is locally generated as a result of time-consuming 
  I/O or calculation. The application must be able to regenerate 
  or restore the data. 

I fail to see how git can regenerate the symlinks...

Bron.
