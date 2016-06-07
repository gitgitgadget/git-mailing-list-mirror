From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 17:30:50 -0400
Message-ID: <20160607213050.GF24676@LykOS.localdomain>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
 <20160607211707.GA7981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:31:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOaS-0001ls-OV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbcFGVax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:30:53 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35539 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbcFGVaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:30:52 -0400
Received: by mail-qg0-f43.google.com with SMTP id 93so65409239qgx.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JN3u9g4AgBoStWex8BOXnyQZNohhWddu/5S+jaFhHDg=;
        b=ptz7wsJFeAdVpaTXhWgF3Pvy7wc7XsAMklfpCGWzJtXoGHwqij4sZgUoCO3PTl3gQr
         jrDcuLXSEaFNAR6aK92ntJS+hOrnT60dUHm0GXjwUSLqf341ENFWf11q3qXbW+1hgK9X
         3pVENunfTf+3r+vzUDzAgigrXXiGGhrxiy5TE8ZVWgYWB+T8AHCfU2NGpcfn5AVljk4n
         51J/M29ykyUdtKTzurZyD13Qw+Q+WKFt+QyLP9ap7SwOLMMt9WrxXLa6P8LeNCwRQvRY
         ej7OLWRD+gL4/VgGTB5cDb6nQ6R1Iu29MTKCHrXZeO+uYula6Ai+Bghp1co1OZ7x+iuU
         q1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JN3u9g4AgBoStWex8BOXnyQZNohhWddu/5S+jaFhHDg=;
        b=apoZDiK/ZOjqy61Xkq3gnJ+Pa6z0HXPbDf6Bjhd9PLALmxr6GPsm+f9bkp9HDmznpD
         GwYpmzKDB14sVMNBk+/eytzQraMwQF3Gi7PnbBMb7UP93oOL+3JDGuroIkXGIqwTeu+I
         FTfFwSHKP6QIdSeZEMT9XrDg8s+fGM8Ddt93VLjkHNV25SfBEHUTgbs0zXo58PW2bukX
         s0m23izAyaQKgb2doG7KAF6pSeuYlHIilHnRuR7BnlfDF2uM734PHTpWPucuCGAiY6uF
         cCzUDng77NZbtnrdMrupJM6Lh0qeWsGvvMKMUR/gF0XYWk6A805WJ3/839ZTsOAdiV+b
         OA9Q==
X-Gm-Message-State: ALyK8tIs+lPFTAO3bWXOaBezUGGZvO2A010xqF49S0VaVgK/ZwYg8QPGhHD5fzHu3qUJoER/
X-Received: by 10.140.161.67 with SMTP id h64mr1688044qhh.96.1465335051440;
        Tue, 07 Jun 2016 14:30:51 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-EXP01.NATPOOL.NYU.EDU. [216.165.95.69])
        by smtp.gmail.com with ESMTPSA id 143sm7099644qkk.39.2016.06.07.14.30.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2016 14:30:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160607211707.GA7981@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296728>

On Tue, Jun 07, 2016 at 05:17:07PM -0400, Jeff King wrote:

> That is much more flexible, as they could even do some more complicated
> matching than a single string (though in practice, for security things,
> I think simpler is better).
> 
> I think this option is going to become a blueprint for other "extended"
> checks, too. E.g., you might also want to check that the tagger ident
> matches the uid on the signing key.
> 
> My main worry is that we'll accrue a whole bunch of such logic. And even
> though each one is relatively simple, it would be nice for callers to be
> able to ask us to just do the standard safety checks.

I agree with this. I can't think of other checks off the top of my head,
but I wouldn't be surprised if this is the case. 

I think that having custom flags for each check can also derive in each
package manager/user picking each check based on many different
rationales, which might lead to people overcomplicating things?

> 
> If we do go with the "print it out and let the caller do their own
> checks" strategy, I think I'd prefer rather than "--show-tagname" to
> just respect the "--format" we use for tag-listing. That would let you
> do:
> 
>   git tag -v --format='%(tag)%n%(tagger)'
> 
> or similar. In fact you can already do that with a separate step (modulo
> %n, which we do not seem to understand here), but like your example:

It worries me that, in this case, the patches for upstream managers
might be harder to integrate/pitch for users.

Also, maybe we could take both strategies? add a --check-name for
verify-tag and a --format for tag -v (I think either change is easy
enough to do).

> 
> > Or it could even do this:
> > 
> > 	tag="$1"
> > 	if ! git tag -v "$tag"
> > 	if ! git tag -v "$tag"
> >         then
> > 		echo >&2 "Bad tag."
> >                 exit 1
> > 	fi
> > +	tag=$(git tag --show-tagname $tag)
> > 	make dest=/usr/local/$package/$tag install
> 
> It is racy. That probably doesn't matter for most callers, but it would
> be nice to be able to get a custom format out of the "-v" invocation.

Oh yeah, I didn't consider this either. I also don't think it's such an
issue, but it sounds like a good idea not to have these races.

> 
> -Peff

Thanks!
-Santiago.
