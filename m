From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 13 May 2007 23:21:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705132234001.18541@iabervon.org>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705132348290.4791@beast.quantumfyre.co.uk>
 <7vzm48pacj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705140121030.5520@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon May 14 05:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnR7X-0003qp-Cn
	for gcvg-git@gmane.org; Mon, 14 May 2007 05:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbXENDVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 23:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbXENDVH
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 23:21:07 -0400
Received: from iabervon.org ([66.92.72.58]:3364 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbXENDVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 23:21:06 -0400
Received: (qmail 27596 invoked by uid 1000); 14 May 2007 03:21:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 May 2007 03:21:05 -0000
In-Reply-To: <Pine.LNX.4.64.0705140121030.5520@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47218>

On Mon, 14 May 2007, Julian Phillips wrote:

> On Sun, 13 May 2007, Junio C Hamano wrote:
> 
> > Thanks for the status updates.  Although I do not recall Daniel
> > saying it explicitly, I have been assuming that his series was
> > aiming for the same all along.  It might be a good idea for you
> > two to compare notes sometime between now and v1.5.2?
> 
> Well, it can't be a bad idea, can it? ;)
> 
> Apart from the code itself (which can be found at
> http://git.q42.co.uk/w/fetch2.git), I don't have any actual notes, and since I
> haven't had a chance to work on it for a couple of weeks I'm not 100% sure of
> where I was at - due to lack of time I have tended to just spend a few hours
> adding some missing part when I found the time but I don't actually have a
> TODO list or similar (though I really should).
> 
> I'm also out of town with work for the first half of the coming week ... but
> I'm certainly willing to talk about what I have and haven't done.

I've actually been largely unsuccessful in figuring out how to do most of 
the fetch logic in C, but I was expecting that somebody would write it if 
the library were available.

I've been working on various little things that are a lot easier if the 
parsing is centralized:

 * update tracking refs on push
 * handle refspec patterns in match_refs so that send-pack/http-push can 
   take them and builtin-push doesn't need to do anything, and can also
   turn --tags into +refs/tags/*:refs/tags/*.

I've also been looking at doing something like your remote_ops, but also 
including something for push, and doing it in another library file (so 
push, fetch, and ls-remote can all share the same dispatch on type of 
url).

> (Daniel, hope you don't mind me adding you to CC ...)

Not at all; I hadn't noticed this thread yet, and it's quite related to 
what I'm working on.

	-Daniel
*This .sig left intentionally blank*
