From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stupid quoting...
Date: Wed, 20 Jun 2007 03:19:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706200307070.4059@racer.site>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org>
 <86ir9l1ylc.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706190156110.4059@racer.site>
 <86sl8owfqj.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706191048570.4059@racer.site>
 <86645kutow.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 04:20:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0pnd-0003ru-4N
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 04:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758937AbXFTCT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 22:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758935AbXFTCT7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 22:19:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:53402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758548AbXFTCT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 22:19:58 -0400
Received: (qmail invoked by alias); 20 Jun 2007 02:19:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 20 Jun 2007 04:19:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6NPkpG+66vC9YKfTUd9cnWAKHNi1k48wV79PPcU
	roFthnEM+b83k+
X-X-Sender: gene099@racer.site
In-Reply-To: <86645kutow.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50521>

Hi,

[sorry for responding so late, your mail got stuck in the GWB-like spam 
filter.]

On Tue, 19 Jun 2007, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Tue, 19 Jun 2007, David Kastrup wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > Don't just throw away backwards compatibility, only because it does 
> >> > not fit your wishes.
> >> 
> >> There is no backwards compatibility involved here _at_ _all_.
> >
> > I was not talking about Git here. The specification for SMTP is not
> > going to change just because you want it. There are still mail
> > servers out there which speak 7-bit, and the standard requires you
> > to cope with them.
> 
> Is there a reason you elide all the relevant material before replying?
> I repeat: this is the task of MIME, uuencode or a number of other
> mechanisms.

The problem there, of course, is that you still might want to reply to the 
patch, even if the name was chosen as non-ASCII (which is a sin, if you 
believe in UNIX).

Usually, comments are not done on the filenames, so they can be as escaped 
as they want in an email, as long as the commenter still recognizes their 
names.

> git is not a mail transport system, and there are far too many other 
> problems in unarmored mail (like spaces, wrapping and other stuff) that 
> it would make any sense to mangle diffs and other material in a manner 
> that makes it quite unprocessable for _both_ human readers as well as 
> scripts intended to process them.

There you have a point. If the name is non-ASCII, it uses a specific 
encoding. if the human reader has a different encoding set in her display, 
is it any better to display garbled characters (possibly leaving the 
console in a corrupted state), or to display escaped characters?

And scripts have been known to get encodings all wrong, so I think the 
escaping is the best way out, absent a perfect knowledge of what encoding 
the file name was meant for.

> Anyway, it has become quite clear from this exchange that you have 
> already made the decision not to be convinced by me and will not be 
> deterred from that, even though the problem is not the one you initially 
> tried deriding me for (spaces in filenames).

I am sorry. No, really, I am sorry that you received it as derision. By 
all means, it was _not_ meant as that. The problem was on my side, not 
yours: I simply did not get that you were talking about non-ASCII 
characters, even if you were talking about them.

> Hopefully some developer with less of an attitude towards non-ASCII 
> usage will find himself able to follow the arguments with some more 
> objectivity.
> 
> I don't see our discourse leading anywhere: the points have been made.

I would really, really, really like to see a solution. Alas, I cannot 
think of one, other than _forcing_ the developers to use ASCII-only 
filenames.

Note that there is no convention yet in Git to state which encoding your 
filenames are supposed to use. And in fact, we already had a fine example 
in git.git why this is particularly difficult. MacOSX is too clever to be 
true, in that it gladly takes filenames in one encoding, but reads those 
filenames out in _another_ encoding. Thus, a "git add <filename>" can well 
end up in git-status saying that a file was deleted, and another file 
(actually the same, but in a different encoding) is untracked.

Again, I would be _so_ glad if you solved the problem, now that I actually 
understand it.

Ciao,
Dscho
