From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add Documentation/CodingStyle
Date: Wed, 7 Nov 2007 14:54:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071451010.4362@racer.site>
References: <20071106201518.GA6361@ins.uni-bonn.de> <20071106201809.GD6361@ins.uni-bonn.de>
 <20071106202600.GH6361@ins.uni-bonn.de> <7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711062317330.4362@racer.site> <7v640ega5q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmJt-0006u2-6p
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182AbXKGOyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759073AbXKGOyd
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:54:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:48716 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758663AbXKGOyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:54:32 -0500
Received: (qmail invoked by alias); 07 Nov 2007 14:54:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 07 Nov 2007 15:54:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19B0bknPUpB8a8j8KUlrFBPb0At7/QVtVsNvBxzSl
	LdlDZJt/hsRrM6
X-X-Sender: gene099@racer.site
In-Reply-To: <7v640ega5q.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63813>

Hi,

On Tue, 6 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> > new file mode 100644
> > index 0000000..622b80b
> > --- /dev/null
> > +++ b/Documentation/CodingStyle
> > @@ -0,0 +1,87 @@
> > +As a popular project, we also have some guidelines to keep to the
> > +code.  For git in general, two rough rules are:
> > +
> > + - Most importantly, we never say "It's in POSIX; we'll happily
> > +   screw your system that does not conform."  We live in the
> > +   real world.
> > +
> > + - However, we often say "Let's stay away from that construct,
> > +   it's not even in POSIX".
> > +
> 
> I am not sure if we want to have CodingStyle document, but the
> above are not CodingStyle issues.

Would you like to call it CodingConventions?

> If we are to write this down, I'd like to have the more
> important third rule, which is:
> 
>  - In spite of the above two rules, we sometimes say "Although
>    this is not in POSIX, it (is so convenient | makes the code
>    much more readable | has other good characteristics) and
>    practically all the platforms we care about support it, so
>    let's use it".  Again, we live in the real world, and it is
>    sometimes a judgement call, decided based more on real world
>    constraints people face than what the paper standard says.

Okay, will add.

> > +For C programs:
> > +
> > + - Use tabs to increment, and interpret tabs as taking up to 8 spaces
> 
> What's the character for decrement?  DEL? ;-)

Hehe.  As you undoubtedly guessed, I meant "indent"...

> > +   Double negation is often harder to understand than no negation at
> > +   all.
> > +
> > +   Some clever tricks, like using the !! operator with arithmetic
> > +   constructs, can be extremely confusing to others.  Avoid them,
> > +   unless there is a compelling reason to use them.
> 
> I actually think (!!var) idiom is already established in our
> codebase.

Yep, but when there are easier variants, AFAICT they were preferred.

> > + - Use the API.  No, really.  We have a strbuf (variable length string),
> > +   several arrays with the ALLOC_GROW() macro, a path_list for sorted
> > +   string lists, a hash map (mapping struct objects) named
> > +   "struct decorate", amongst other things.
> 
>  - When you come up with an API, document it.

Okay.

> > + - if you are planning a new command, consider writing it in shell or
> > +   perl first, so that changes in semantics can be easily changed and
> > +   discussed.  Many git commands started out like that, and a few are
> > +   still scripts.
> 
> No Python allowed?

Well, maybe we should allow that again.  Although I hoped we are over that 
now, as it would complicate the msysGit efforts tremendously.

Ciao,
Dscho
