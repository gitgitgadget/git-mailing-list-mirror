From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 18:37:15 +0200
Message-ID: <20070502163715.GD4489@pasky.or.cz>
References: <200705012346.14997.jnareb@gmail.com> <200705021624.25560.kendy@suse.cz> <20070502161515.GC4489@pasky.or.cz> <200705021827.51335.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	releases@openoffice.org, dev@tools.openoffice.org
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 02 18:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjHpg-0004D3-2L
	for gcvg-git@gmane.org; Wed, 02 May 2007 18:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993506AbXEBQhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993507AbXEBQhT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 12:37:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38562 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993506AbXEBQhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 12:37:17 -0400
Received: (qmail 20789 invoked by uid 2001); 2 May 2007 18:37:15 +0200
Content-Disposition: inline
In-Reply-To: <200705021827.51335.kendy@suse.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46036>

  Hi,

On Wed, May 02, 2007 at 06:27:51PM CEST, Jan Holesovsky wrote:
> On Wednesday 02 May 2007 18:15, Petr Baudis wrote:
> 
> > On Wed, May 02, 2007 at 04:24:24PM CEST, Jan Holesovsky wrote:
> > > > What might help here is splitting repository into current (e.g. from
> > > > OOo 2.0) and historical part,
> > >
> > > No, I don't want this ;-)
> >
> > Are you sure? Using the graft mechanism, Git can make this very easy and
> > almost transparent for the user - when he clones he gets no history but
> > he can use say some simple vendor-provided script to download the
> > historical packfile and graft it to the 'current' tree. After that, the
> > graft acts completely transparently and it 'seems' like the history
> > goes on continuously from OOo prehistory up to the latest commit.
> 
> Interesting, I did not know that it is possible to do it so that it appears 
> transparently; this would be indeed a tremendous win - we could start nearly 
> from scratch ;-)
> 
> Please - where could I find more info?  Like what does the script have to do, 
> etc.

  you can see an example script at

	http://repo.or.cz/w/elinks.git?a=blob;f=contrib/grafthistory.sh

and I have tried vainly few times to get a similar script to the kernel
too

	http://lists.zerezo.com/linux-kernel/msg6599002.html

that can use both wget and curl and will also download tag refs for the
history.

  The format of the grafts file itself (.git/info/grafts) is pretty
simple (just one-graft-per-line where you first say the commit id and
then the parent commit(s) to be drafted onto it), please see
Documentation/repository-layout.txt for details.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
