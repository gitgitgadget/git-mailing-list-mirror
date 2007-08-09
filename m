From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Thu, 09 Aug 2007 07:51:08 +0200
Message-ID: <85odhhntmb.fsf@lola.goethe.zz>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
	<Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de>
	<85lkclrdpr.fsf@lola.goethe.zz> <20070809032610.GA24573@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 07:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ0vU-0006oe-Ks
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 07:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763408AbXHIFvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 01:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757691AbXHIFvN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 01:51:13 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:34750 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756530AbXHIFvM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 01:51:12 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id A3A4B17F411;
	Thu,  9 Aug 2007 07:51:10 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 93781ABAE0;
	Thu,  9 Aug 2007 07:51:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-052-115.pools.arcor-ip.net [84.61.52.115])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 61EC030A992;
	Thu,  9 Aug 2007 07:51:10 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 535D31C3C79D; Thu,  9 Aug 2007 07:51:09 +0200 (CEST)
In-Reply-To: <20070809032610.GA24573@spearce.org> (Shawn O. Pearce's message of "Wed\, 8 Aug 2007 23\:26\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3904/Thu Aug  9 04:01:48 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55410>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Kastrup <dak@gnu.org> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > General question: should this not be in git-gui rather than gitk?  Gitk as 
>> > of now is really more a viewing tool.
>> 
>> Well, yes.  But git-gui only works on a single branch head at a time,
>> and that is not enough for rebasing.
>
> Sure.  But so does git's command line tools.  They tend to only
> work on a single branch at time, the one called `HEAD`.

"tend", and many accept an explicit override: rebase accepts three
commit names, for example.  Those that _write_ into the repository
usually _end_ up at HEAD, but most need not start there.

And git-gui does not have any operation either looking at or working
other than on the current HEAD.  No diff, no file view, no rebase,
nothing.

> So "single branch head at a time" is *not* why git-gui doesn't
> support rebase.  Its because nobody has gotten around to writing it.

I never claimed that it is not possible to put a rebase in there (the
patch does this, after all).  I just said that it does not _fit_ in
there since you can't actually look at what you are rebasing on.

>> Could git-gui perhaps be merged with giggle at some point of time?
>
> Unlikely.  A while ago I considered "Stay in Tcl/Tk or move to
> something more 'powerful/better/faster/Linus friendly'" and stayed
> in Tcl/Tk.  I doubt git-gui will leave Tcl/Tk.  giggle is Gtk based.

My bad: git-gui has a nice polished look on my systems (Ubuntu Feisty)
while gitk has an ugly retro-blockish old-font Tk look; so not looking
at the innards, I had assumed they were implemented using different
systems.

> I decided that any sort of rebase operation in git-gui must be *at
> least* as easy to use/user friendly as `rebase -i` is.  Anything
> less is just mocking the end-user.  Or something like that.  Anyway,
> since git-gui is restricted to a graphical interface and most such
> interfaces have these pointy rodents available we can do fancy
> things like dragging to express what we want to have happen, instead
> of moving lines of text around.
>
> Want to write a patch (or series of patches) for git-gui?

User interfaces are really not what I am good at, and I don't even
have enough time to deal with the things I am good at.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
