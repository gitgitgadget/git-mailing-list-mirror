From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 16:22:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041618291.14781@racer.site>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com>
 <1186206085.28481.33.camel@dv> <20070804141438.GA15821@pe.Belkin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: git-owner@vger.kernel.org Sat Aug 04 17:23:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHLTJ-0000Zj-SL
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 17:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759625AbXHDPXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 11:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbXHDPXO
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 11:23:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:59403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758659AbXHDPXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 11:23:13 -0400
Received: (qmail invoked by alias); 04 Aug 2007 15:23:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 04 Aug 2007 17:23:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Z67sX1fkZZ9C0ilIzt3PaiNbFjF1Z6rt+KuD1Qo
	655T8WYSe+Tmna
X-X-Sender: gene099@racer.site
In-Reply-To: <20070804141438.GA15821@pe.Belkin>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54866>

Hi,

On Sat, 4 Aug 2007, Chris Shoemaker wrote:

> IMO, here are some things that would probably be easier with an external
> patch stack:
> 
>    - directly editing the diff hunks
>    - moving single diff hunks between patches
> 
> Maybe there are others, too, but these are things I just don't do
> nearly as frequently as the things that git-rebase -i is good at.  (I
> use git-rebase -i *constantly*).

Good to hear!  (I almost missed this mail, since I usually skip the StGit 
mails.)

> > The "cd ..", "quilt push -a" and off I am. That 
> > the "database" of quilt is in a known format and I can hack on 
> > it with an editor is a plus for me :-)
> > [end of quote]
> 
> That sounds more like an argument from familiarity than anything else.
> Nobody (reasonable) directly hacks git's internal binary format.  The
> "known format" I can hack with my editor is just the content itself.
> Honestly, when you have commit-handling that is as good as git's,
> there's really very little appeal left to editing the diffs directly.

Of course, you _could_ just export the patches as one mbox, edit them, and 
reapply them:

	git format-patch --stdout HEAD~4 > mbox.txt
	$EDITOR mbox.txt # even moving hunks
	git reset --hard HEAD~4
	git am mbox.txt

If the need is great enough, it should be easy to hack something like this 
into git rebase -i.

Ciao,
Dscho
