From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: a few remaining issues...
Date: Wed, 10 Jan 2007 14:46:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701101442520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net> 
 <81b0412b0701050327u6bf2a716s1fb38fb62e2ebb9d@mail.gmail.com> 
 <Pine.LNX.4.63.0701101320300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0701100440n6fe9e406yfe712cf236a784e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 14:46:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4dmf-0008EE-S4
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 14:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbXAJNqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbXAJNqQ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 08:46:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:39212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932812AbXAJNqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 08:46:14 -0500
Received: (qmail invoked by alias); 10 Jan 2007 13:46:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 10 Jan 2007 14:46:12 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701100440n6fe9e406yfe712cf236a784e2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36509>

Hi,

On Wed, 10 Jan 2007, Alex Riesen wrote:

> On 1/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On 1/5/07, Junio C Hamano <junkio@cox.net> wrote:
> > > > This is not meant to be an exhaustive list, and I probably will
> > > > change my mind after I sleep on them, but before I go to bed,
> > > > here are a handful of glitches I think are worth fixing.
> > >
> > > Maybe we should at least mention another cygwin quirk:
> > > cygwin (or is it its bash?) treats .exe files and +x-files without
> > > extension somehow stupid: it prefers the file without extension
> > > to the .exe. For example, after installation of git-merge-recursive
> > > you have the old python script and git-merge-recursive.exe in
> > > the same directory. Guess which one is used... Right, the old
> > > python script. Same for count-objects and other recently
> > > rewritten scripts.
> > 
> > I just sent out a patch in my mail "[PATCH] Makefile: add
> > clean-obsolete-scripts target" which should help.
> 
> Well, you also have to give people at least notice _when_ the
> target should be called.

Okay. Fair enough. So maybe this is the wrong approach: maybe the "all" 
target should look for _all_ executables if there is a script of the same 
name, and in that case remove it; and the "install" target should do the 
same in the gitexecdir?

> > But in general, it should be fine to be called just once.
> 
> Don't think so. We still have candidates for conversion
> into C (git-checkout and git-commit being my favorites).

I was referring to

	make clean-obsolete-scripts; make; make clean-obsolete-scripts

being necessary, because the script somehow got a newer time stamp than 
the executable.

But yes, I think there are way more candidates, my pet peeves being 
git-ls-remote and git-fetch.

Ciao,
Dscho
