From: Jeff King <peff@peff.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 28 Feb 2011 18:03:11 -0500
Message-ID: <20110228230311.GA7533@sigill.intra.peff.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
 <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
 <20110227084317.GB3356@sigill.intra.peff.net>
 <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuC7i-0002LX-Bk
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab1B1XDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 18:03:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555Ab1B1XDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 18:03:10 -0500
Received: (qmail 29895 invoked by uid 111); 28 Feb 2011 23:03:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 23:03:09 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 18:03:11 -0500
Content-Disposition: inline
In-Reply-To: <1298820840.19827.69.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168160>

On Sun, Feb 27, 2011 at 10:34:00AM -0500, Drew Northup wrote:

> The concept of a "staging area" is definitely of limited use for many of
> us attempting to learn how git works. The very fact that the object
> cache and the Index (or multiple, as is useful at times) are distinct
> elements is useful and should be mentioned somewhere.

Now your terminology has _me_ confused. What is the "object cache"?

> Alas, creating in the user's mind that there is a distinct unified
> "staging area" acts against this dissemination of knowledge. It
> definitely didn't help me.

I'm not sure what you mean by "distint unified staging area". It is a
conceptual idea that you will put your changes somewhere, and when they
look good to you, then you will finalize them in some way.

But note that it is a mental model. The fact that it is implemented
inside the index, along with the stat cache, doesn't need to be relevant
to the user. And the fact that the actual content is in the object
store, with sha1-identifiers in the index, is not relevant either. At
least I don't think so, and I am usually of the opinion that we should
expose the data structures to the user, so that their mental model can
match what is actually happening. But in this case, I think they can
still have a pretty useful but simpler mental model.

> If we use "staging area made up of the object store and information kept
> in the Index" then we tie a knot on everything, make it clear that it
> may be more complex than that--and you don't have to care, and we do not
> foreclose on the possibility of more complete explanation later. That
> does not bother me. We do however need to recognize that "staging area"
> is an idiom of limited portability and deal with that appropriately.

Sure, I'm willing to accept that the specific words of the idiom aren't
good for people with different backgrounds.

One analogy I like for the index is that it's a bucket. It starts out
full of files from the last commit. You can put new, changed files in
the bucket. When it looks good, you dump the bucket into a commit. You
can have multiple buckets if you want. You can pull files from other
commits and put them in the bucket. You can take files out of the bucket
and put them in your work tree.

So maybe it should just be called "the bucket"?

I'm not sure that's a good idea, because while the analogy makes sense,
it doesn't by itself convey any meaning. That is, knowing the concept, I
can see that bucket is a fine term. But hearing about git's bucket, I
have no clue what it means. Whereas "staging area" I think is a bit more
specific, _if_ you know what a staging area is.

So there are two questions:

  1. Is there a more universal term that means something like "staging
     area"?

  2. Is the term "staging area", while meaningful to some, actually
     _worse_ to others than a term like "bucket"? That is, does it sound
     complex and scary, when it is really a simple thing. And while
     people won't know what the "git bucket" is off the bat, it is
     relatively easy to learn.

     And obviously, replace "bucket" here with whatever term makes more
     sense.

> A particular Three Stooges episode comes to mind here for me.

Wow, 180,000 messages and this is somehow the first Three Stooges
analogy on the git list.

-Peff
