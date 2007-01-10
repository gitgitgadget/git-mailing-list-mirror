From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 09 Jan 2007 20:54:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701092045090.4964@xanadu.home>
References: <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
 <20070109142130.GA10633@coredump.intra.peff.net>
 <7virffkick.fsf@assigned-by-dhcp.cox.net>
 <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org>
 <20070109234421.GD30023@spearce.org> <eo1bqu$hji$1@sea.gmane.org>
 <20070110003433.GH30023@spearce.org>
 <Pine.LNX.4.64.0701092014390.4964@xanadu.home>
 <7vwt3vfzd1.fsf@assigned-by-dhcp.cox.net> <20070110014000.GA30765@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Sfd-0004qp-Lw
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbXAJByQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbXAJByQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:54:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33059 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637AbXAJByP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:54:15 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBM00MP2QME2DD0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jan 2007 20:54:15 -0500 (EST)
In-reply-to: <20070110014000.GA30765@spearce.org>
X-X-Sender: nico@xanadu.home
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36467>

On Tue, 9 Jan 2007, Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > Nicolas Pitre <nico@cam.org> writes:
> > 
> > >> Unfortunately .git/logs/HEAD wouldn't be created by default as its
> > >> not under refs/heads or refs/remotes.  Though it could be made to be
> > >> on by default, in which case it would only log changes while HEAD
> > >> is detached.  If HEAD is attached to a branch then .git/logs/HEAD
> > >> wouldn't be appended to (or even created), while the branch's own
> > >> log is still appended to.
> > >
> > > Is this worth the trouble and complexity?  After all detached heads are 
> > > not meant to be used for serious development.
> > 
> > I agree.
> 
>   git checkout v1.4.0
>   # dang, need some local fix
>   git commit -m tmpfix -a
>   git reset --hard v1.2.0
>   git reset --hard v1.3.0
>   # dang, need that local again fix - where is it?

    cd /
    ls
    # wow lots of files
    rm -rf .
    # dang dunk down

So just don't use git-reset but create a branch to preserve that local 
change instead.

> It ain't in ORIG_HEAD.  Its now only findable by
> fsck-objects/lost-found.

Which is good enough in that circumstance IMHO.  We cannot always try to 
prevent people from shooting in their foot if they really want to.

> But if you reflog a detached
> HEAD its there as HEAD@{2}.

But when your head is not detached anymore then HEAD@{2} changes 
meaning and that is rather not good.


Nicolas
