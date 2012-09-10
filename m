From: Jeff King <peff@peff.net>
Subject: Re: checkout extra files
Date: Mon, 10 Sep 2012 16:11:15 -0400
Message-ID: <20120910201115.GB32437@sigill.intra.peff.net>
References: <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <20120910161904.GC9435@sigill.intra.peff.net>
 <7vpq5told4.fsf@alter.siamese.dyndns.org>
 <20120910171954.GA15583@sigill.intra.peff.net>
 <7vhar5oemu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:11:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAKO-0003px-CW
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756123Ab2IJULU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:11:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39993 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab2IJULT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:11:19 -0400
Received: (qmail 32551 invoked by uid 107); 10 Sep 2012 20:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 16:11:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 16:11:15 -0400
Content-Disposition: inline
In-Reply-To: <7vhar5oemu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205170>

On Mon, Sep 10, 2012 at 12:35:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I would argue the opposite; if it is about a specific point, then put it
> > with the point. Otherwise, you are asking the reader to remember back to
> > an earlier point (that they may not even have read; in reference
> > documentation, the point of a list is often to let readers skip from
> > bullet to bullet easily).
> 
> You need to follow all the rules when composing your command line.
> You cannot simply ignore ones that are inconvenient for you and pick
> only the one you like.

Of course. But note that I said "reference documentation". It is quite
frequent that you have read it a long time ago, or understand already
most of what it is saying, and you are re-reading it again looking for
rules about a _specific_ element (say, wildcards). You might not have
just now read the bit about disambiguation, but you do not need to; you
already know it, or it might not be relevant to what you are doing.

> The second and the third one are related in the "sides of the same
> coin" sense; you either have "--" in which case no disambiguation
> checks are done, or don't in which case your command line may get an
> ambiguity error, so in that sense, you could say "I am writing '--',
> so point C does not apply to me and I skip".  But whether you do or
> do not say '--', you have to have your revs before pathspecs, so you
> cannot skip point A.

I think we need to be realistic about the readers of our documentation.
Sometimes people will sit down and read all the way through, and we need
the text to flow and make sense for that case. But just as often, they
will be curious about one specific point, and we need to make it as easy
as possible for them to see when a new point is being made, and when
they can stop reading because they have wandered into a new point that
they may already know.

Which is why I think the best thing we can do for such a casual reader
is make sure that the typography helps group related text together. In
this specific example, imagine I am a seasoned Unix user and a new git
user. If I were reading about "--" and revs versus paths, that would be
news to me, because it is about git. When I see the next bullet is about
quoting "*" to pass it through the shell to git, I say "Of course. That
is how Unix shells work" and stop reading. It seems like a disservice to
the reader to include more on the "--" disambiguation _after_ that
bullet point.

> So I do not think a bullet list is designed to let the readers skip
> and forget (or "may not even have read").  If that is the case,
> perhaps we would need to use something else to give the set of rules
> that apply to the command line here.

I think it is OK here. As a tool for people reading the whole text, I
think the list is a bad format, since the elements do not follow a good
parallel structure (as you said, the second and third are much more
related than the first and fourth).

So I was tempted to suggest removing the list altogether and turning it
into paragraphs.

But as I said, I think breaking the points with whitespace helps the
casual reader using it as a reference. I'm not sure you agree, but maybe
what I've written above will change that. If not, I think I've said as
much as is useful on the matter and I'll stop talking. :)

> I think the following is probably the best.
> 
>     * A (revs and then paths)
>     * B (with "--", no dwim is done).
>     * C (without "--", disambiguation kicks in. By the way, this
>       means your script had better avoid this form; make sure you
>       use "--").
>     * D (pathspecs are patterns).
> 
> without the trailing paragraph, which is meant only for people who
> write their script without using "--" by mistake, i.e. it only
> belongs to point C.

Hmph. Isn't that what I suggested in my first email? :P

I am fine with the series you sent.

-Peff
