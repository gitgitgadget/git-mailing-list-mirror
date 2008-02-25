From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Sun, 24 Feb 2008 23:30:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802242319200.19024@iabervon.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com> <alpine.LSU.1.00.0802202221130.17164@racer.site> <7v4pc316gq.fsf@gitster.siamese.dyndns.org> <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com> <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
 <alpine.LNX.1.00.0802202351400.19024@iabervon.org> <7vk5kyyirk.fsf@gitster.siamese.dyndns.org> <7vwsotoey8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 05:31:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTUzf-0002gW-Ff
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 05:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbYBYEad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 23:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbYBYEad
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 23:30:33 -0500
Received: from iabervon.org ([66.92.72.58]:39572 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbYBYEac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 23:30:32 -0500
Received: (qmail 31297 invoked by uid 1000); 25 Feb 2008 04:30:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 04:30:30 -0000
In-Reply-To: <7vwsotoey8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74991>

On Sun, 24 Feb 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> >
> >> [url "rewritten"]
> >> 	insteadOf = "original"
> >
> > That's much clearer than anything I've seen in this thread which
> > one is the one you cannot use yourself and which one is what you
> > have to use to get it to work.
> 
> Although I am willing to step in when they need help, I usually
> try not to finish up other people's patches, especially when I
> know they are capable.
> 
> But I wanted to take 'next' into a shape as close to the -rc1 as
> possible early, so here is my stab at it.  This will be in 'next'
> tonight.

Thanks; that's exactly what I would have done (assuming I didn't miss 
places like last time). Except that it should say that it's still 
undefined if you use:

        [url "foo"]
                insteadOf = "baz"
        [url "bar"]
                insteadOf = "baz/sub"

in that you can't predict whether "baz/sub/a" will be "bar/a" or 
"foo/sub/a". This is actually what I'm most concerned about, since there 
is actually a logical expectation (the one that matches more will be used 
in preference to the less specific one), but that's not implemented. 
Someday, we'll probably want to implement it, and that'll change the 
behavior of this particular case.

	-Daniel
*This .sig left intentionally blank*
