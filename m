From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 13:12:26 -0700
Message-ID: <CA+55aFzu72fxhms_azREiLz+hLDzT8XKJfJuYHZc=AQcZxmknw@mail.gmail.com>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
	<vpqr4j0rccf.fsf@grenoble-inp.fr>
	<CAFT1WNxm0Kx9vHx+NB92_tZV6KsVhefiVXa-K69YbWOkpCXSgA@mail.gmail.com>
	<20130327184657.GP2286@serenity.lan>
	<20130327190425.GA26380@sigill.intra.peff.net>
	<CA+55aFypcwbLwPLq++AU9FggCKLYkgkuN6i-gOD9pRioH1Dz2g@mail.gmail.com>
	<7vy5d8lijp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jim Kinsman <jakinsman@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwiN-0006KE-VI
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab3C0UM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:12:27 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:49003 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab3C0UM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:12:26 -0400
Received: by mail-vc0-f176.google.com with SMTP id ib11so6771260vcb.21
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=eZH44WTm2w0eoE9XzxFe1bpl/Q5JQqVe2gNvvfZRbhM=;
        b=qPeETeyRCCBzj2iwIiRwhuxckNKQmf99G0j3Qzaw1w/AkimvoLe/L9uyAYRnHQkMzC
         iYW4tdy3uC0nzGLq/oPwusN1JV/0yVEt3XWPcPUCuGpYAlY54HabzkBNdmunlaflhGTy
         tQIIUZpBYRRusMW7wpWsKz9W4Z2S71x1JZfBzkwcqBXB4QxeLBFZMT4+7+g660XI8gwe
         3OdovQLuRclNkvt+kEz4fbIvhhnZJisSru17F6TVC1E0CwnUr7ef2XQx7/rs6GbcVfts
         XLHA6UzoNAxlrm7S3cE5cvhI58L7Gtc2mDIMO8kSfswj4TQuJK6qdxhINP7XYCKT0nLv
         KNiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=eZH44WTm2w0eoE9XzxFe1bpl/Q5JQqVe2gNvvfZRbhM=;
        b=L/fvDeS9TEl/SPaA3oIqnWV5iImzWpyGZ9UqTqmHrYF7G0CP3Ss98bfKsnHuUMnCum
         jj7s1YaYKYlvz9h1j9eqPKEofDZKkARKzoHofIqimmPtURv5MPmglOHewvrbKW8b2/3q
         axRRZCg1zsj+HjFiVoOyMHNHZ0PwVFVkO448A=
X-Received: by 10.58.44.194 with SMTP id g2mr5101027vem.1.1364415146130; Wed,
 27 Mar 2013 13:12:26 -0700 (PDT)
Received: by 10.220.148.211 with HTTP; Wed, 27 Mar 2013 13:12:26 -0700 (PDT)
In-Reply-To: <7vy5d8lijp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 55Jq0eay5IdPcBegUt_Xf0qaBLI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219322>

On Wed, Mar 27, 2013 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Given that we haven't tweaked the parallelism or thread-cost
> parameters since the inception of the mechanism in Nov 2008, I
> suspect that we would see praises from some and grievances from
> other corners of the user base for a while until we find acceptable
> values for them

Looking at the parameters again, I really think they are pretty sane,
and I don't think the numbers are all that likely to have shifted from
2008. The maximum thread value is quite reasonable: twenty threads is
sufficient to cover quite a bit of latency, and brings "several
seconds" down to "under half a second" for any truly IO-limited load,
while not being disastrous for the case where everything is in cache
and we only have a limited number of CPU cores.

And the "at least 500 files per thread" limit is eminently reasonable
too - smaller projects like git won't have more than five or so
threads.

So I'd be very surprised if the values need much tweaking. Sure, there
might be some extreme cases that might tune for some particular
patterns, and maybe we should make the values be tunable rather than
totally hardcoded, but I suspect there's limited up-side.

It might be interesting for the people who really like tuning, though.
So in addition to "index.preload=true", maybe an extended config
format like "index_preload=50,200" to say "maximum of fifty threads,
for every 200 files" could be done just so people could play around
with the numbers and see how much (if at all) they actually matter.

But I really don't think the original 20/500 rule is likely to be all
that bad for anybody. Unless there is some *really* sucky thread
library out there (ie fully user-space threads, so filename lookup
isn't actually parallelised at all), but at least for that case the
fix is to just say "ok, your threads aren't real threads, so just
disable index preloading entirely).

                 Linus
