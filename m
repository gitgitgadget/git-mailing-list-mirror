From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 15:42:01 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808191523050.19665@iabervon.org>
References: <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
 <7vy72tit90.fsf@gitster.siamese.dyndns.org> <20080819175220.GA10142@coredump.intra.peff.net> <alpine.LNX.1.00.0808191407160.19665@iabervon.org> <20080819184525.GA17691@coredump.intra.peff.net> <alpine.LNX.1.00.0808191448530.19665@iabervon.org>
 <20080819190159.GB17943@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVX6k-0000L1-8e
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbYHSTmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYHSTmF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:42:05 -0400
Received: from iabervon.org ([66.92.72.58]:47279 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbYHSTmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:42:04 -0400
Received: (qmail 6145 invoked by uid 1000); 19 Aug 2008 19:42:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2008 19:42:01 -0000
In-Reply-To: <20080819190159.GB17943@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92914>

On Tue, 19 Aug 2008, Jeff King wrote:

> On Tue, Aug 19, 2008 at 02:57:04PM -0400, Daniel Barkalow wrote:
> 
> > Humans being recipients of emails, or humans being the users who typed the 
> > command? Unless you're cut-and-pasting out of a pager (which never works 
> 
> I meant the recipients of the emails.
> 
> > well for me if it's long enough to include diff headers, context, and some 
> > change), recipients of emails would get what scripts get. (I personnaly do 
> > that as "git diff > temp.patch" and read temp.patch into my mailer; this 
> > doesn't trigger starting a pager, and wouldn't trigger the default to be 
> > informative prefixes.)
> 
> OK, I didn't read your mail carefully enough. Yes, I do the same thing,
> so the "do this only if pager" rule would meet my requirement. OTOH, I
> don't know if that would satisfy the people who want this feature (but I
> will let them speak for themselves).

Ah, okay. I feel like the main application for this is "I typed some git 
diff command, started looking at it, my phone rang, I took the call, and 
now I don't know what I'm looking at, and the pager hides the command 
line, but quitting the pager loses my place." At least, that's the 
situation I'm often in.

> > Yeah, that's why I think that format-patch should work on content that you 
> > haven't committed, generating something you can dump right into an email 
> > (with the --- and diffstat that you'd get if you actually did commit and 
> > use format-patch now).
> 
> It's not clear to me:
> 
>   - how you would tell format-patch that's what you wanted to dump

Maybe an option? Maybe it should include it if the working tree is dirty?

>   - what parts would be included. There's no commit message or author.
>     We could guess at the author as if you were about to commit this.

Probably it should start just after the message, since that's what you've 
presumably got elsewhere.

>   - how this would be any real improvement over "git diff --stat -p". In
>     fact, I like the fact that I get _just_ the diff, which I then
>     paste. The headers would just be clutter I would have to delete.

That all-important "---" line? But I think the real advantage is that 
people who don't know that "git diff --stat -p" is the standard info for a 
patch email would be able to run the same command as usual.

	-Daniel
*This .sig left intentionally blank*
