From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Thu, 3 May 2007 01:45:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705030137520.28708@iabervon.org>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
 <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
 <7vejm3g0dg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705022330460.28708@iabervon.org>
 <7virba31wd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 07:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjU8q-0007sc-3O
	for gcvg-git@gmane.org; Thu, 03 May 2007 07:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbXECFpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 01:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbXECFpu
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 01:45:50 -0400
Received: from iabervon.org ([66.92.72.58]:2899 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290AbXECFpu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 01:45:50 -0400
Received: (qmail 8717 invoked by uid 1000); 3 May 2007 05:45:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2007 05:45:48 -0000
In-Reply-To: <7virba31wd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46066>

On Wed, 2 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sat, 28 Apr 2007, Junio C Hamano wrote:
> >
> >> We are indeed pretending.  Consider:
> >> 
> >>  (1) You push, and push succeeds.
> >> 
> >>  (2) Somebody fetches your result, works on it and pushes back;
> >>      this might happen in post-receive hook.
> >> 
> >>  (3) You fetch.  You should see somebody else's commit at the
> >>      tip, not what you pushed in (1).
> >> 
> >> By not fetching but instead of storing what you pushed, you are
> >> pretending that you re-fetched so fast that you gave no chance
> >> to anybody to perform (2) quickly enough.
> >
> > But you did effectively re-fetch instantaneously by doing an operation 
> > that atomicly updates the ref and reports success.
> 
> I do not think there is much point arguing over this; I am not
> fundamentally opposed to keeping a copy of what we just pushed
> to the other side.
> 
> But I think it needs to be documented that hooks on the remote
> side could do funny things, and probably we should strongly
> discourage people from doing such.

I don't see what's any *more* odd about this situation with my change than 
otherwise (and I'm afraid I'm missing something, which is why I'm still 
discussing it).

> You do need to take care of the case where we are _not_ tracking
> the remote side, though (i.e. lack of colon in the fetch
> refspecs).

Indeed. Is there documentation on all the possibilities for refspecs 
somewhere all together? I could only find it for particular programs, and 
didn't see a no-colon option permitted anywhere.

	-Daniel
*This .sig left intentionally blank*
