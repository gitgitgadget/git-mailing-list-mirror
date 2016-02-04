From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v3] Add user.explicit boolean for when ident shouldn't be
 guessed
Date: Thu, 4 Feb 2016 07:36:46 +0200
Message-ID: <20160204053646.GA24453@gmail.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <20160203082112.GA27454@gmail.com>
 <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
 <20160203192227.GA13878@gmail.com>
 <20160204040111.GA27371@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 06:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRCb8-0000GW-Gn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 06:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbcBDFgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 00:36:51 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36112 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbcBDFgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 00:36:50 -0500
Received: by mail-wm0-f49.google.com with SMTP id p63so195417113wmp.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 21:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=x211Kf4gfNCWJr5CnMWc0JdjmNwwLwHGNoEqnQcC9OA=;
        b=PAYSTdqQoa3oXH+EGPtXNTQ0sv1hL2ifHPJ1Th1tB/AD88OXoy9bHYdFIFEcqpH32c
         AUJXQaRZCKMkudkVCoB1wdHeWcmJl4Pf68pnZzmObmNmOwcFura8S1sprR5W7To01npZ
         s/D0UcgYH6p+6Y7/MU/e1zehRWaO3bFjcvuhFnzZ7WpjRmBvNs+4tTwxA9bUtbOuGI2I
         THjZjZlYq4EzctAG0rTOlWnY16I9i0zM9K7yUuAE5kHNXkKnyIPsyqHbC+IMDLRT3zj+
         ZxZijY4fyIuPqoRh9IhRonIEpfgyEur9SL+R//lo9Uzpqc4bR7/CwKrQz8WfEDihz/TB
         Y3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=x211Kf4gfNCWJr5CnMWc0JdjmNwwLwHGNoEqnQcC9OA=;
        b=GLqT1HlYpxBuH6KiFfma6rxZHtyC1o5NyFdSSwzVioxnXQq/oCYWo9IC+4ctK6ej3T
         o4FFm16At2YxxpAxzoOqWHpmFeQz9mTsYMgwvn5AXivfHw6Kv1gR1H0QD5SRqF/inOSe
         lpDzt+5NFo+S5Fy1ynDZKLskum9GVXLPn++p/xmuaJfomUw1tSbYD0nMbeo5hDIh57Po
         aIIRC60OBFqvDFir9JYDZjZTq0//RsxcNRCKfJTsZg9HmPYP1M9XNPAUAXYdq8bkJpWX
         6+wHGH9gMEhkHCJnVPRke5SixmirArbv4wnA2OzYpL/nvtUagtEB514b8JXxf0mlNqOc
         64tw==
X-Gm-Message-State: AG10YOSSlQfd3K7PzfB2nORhz4OWiQaMlvwQJpqrnC/zm74MO6gkr+zTbOrVgGnCCJP8Ng==
X-Received: by 10.28.30.132 with SMTP id e126mr30111998wme.42.1454564208910;
        Wed, 03 Feb 2016 21:36:48 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id w17sm10913492wmw.5.2016.02.03.21.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 21:36:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160204040111.GA27371@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285398>

On Wed, Feb 03, 2016 at 11:01:11PM -0500, Jeff King wrote:
>[..]
> > > * Do these new tests really deserve a new test script, or would they
> > > fit into an existing script? (Genuine question.)
> > 
> > I am not sure. IMHO it makes sense to have a new test script for a new
> > feature.
> 
> I hope we never have more than 9999 features, then. :)
> 
> On to the patch itself...
> 
> > @@ -373,6 +374,21 @@ const char *fmt_ident(const char *name, const char *email,
> >  		die("unable to auto-detect email address (got '%s')", email);
> >  	}
> >  
> > +	if (ident_explicit) {
> > +		if (name == git_default_name.buf &&
> > +		    !(committer_ident_explicitly_given & IDENT_NAME_GIVEN) &&
> > +		    !(author_ident_explicitly_given & IDENT_NAME_GIVEN))
> > +			die("requested explicitly given ident in config, "
> > +			    "but user.name is not set, or environment is "
> > +			    "not set");
> > +		if (email == git_default_email.buf &&
> > +		    !(committer_ident_explicitly_given & IDENT_MAIL_GIVEN) &&
> > +		    !(author_ident_explicitly_given & IDENT_MAIL_GIVEN))
> > +			die("requested explicitly given ident in config, "
> > +			    "but user.email is not set, or environment is "
> > +			    "not set");
> > +	}
> > +
> 
> I'm not sure why this block is effectively repeated here, in
> git_author_info(), and in git_committer_info(). Don't the latter two
> just call fmt_ident?

Suspected that. Originally I started changing git_committer_info() and
git_author_info(), and only changed fmt_ident() later when I saw it
covers more cases. But the flow was confusing enough so I wasn't sure
whether to keep it.

> To be honest, I had expected something much simpler, like this (I
> omitted the config parsing for brevity):
>[..]
> In a sense, that encourages a nice workflow for your intended feature.
> You have to do:
> 
>   git clone -c user.name=... -c user.email=... clone ...
> 
> to set up your ident in the newly-cloned repository, or else clone will
> yell at you. But it's a little unfriendly. If you are just cloning to
> view and not make commits, you don't need your ident set up. And worse,
> if you forget to add your "-c" ident, clone will go through the trouble
> to copy all of the objects, and only then complain about your ident.

I think that forcing to give the configuration in 'git clone' could be
problematic for automated tools (e.g. o build) that invoke 'git clone'
just for building purposes (i.e. read-only) to a tool-managed directory.
And what about sub-modules clones? It would be hard to distinguish manual
clones and automatic clones anyway.

> So I'd argue that this should only kick in for the strict case. Which
> means the check _has_ to go into fmt_ident, and we have to somehow
> inform fmt_ident of the four cases:
> 
>   1. this ident came from git config
> 
>   2. this ident came from the environment, but from explicit variables
> 
>   3. this ident came from the environment; we guessed but the results
>      look pretty good
> 
>   4. this ident came from the environment; it's probably bogus
> 
> Right now we can identify type 4, with the *_is_bogus flags. We can
> identify 3, because EXPLICITLY_GIVEN flags won't be set. But we can't
> tell the difference between types 1 and 2.
> 
> I suppose there is also a type 0: "this ident was from GIT_COMMITTER_*
> and we did not bother to look up ident at all". But I think we agree
> that strictness and explicitness don't even come into play there.

Looks like an enum type would be better here instead of a set of booleans.

> So I think we can make this work by adding another variable to
> communicate the difference between types 1 and 2, and then act on it in
> fmt_ident only when "strict" is set. And I think "user.explicit" is not
> quite the right config name there. "user.guessIdent" is perhaps closer,
> but what we are really saying is "the ident must come from git config".
> So maybe "user.useConfigOnly" or something?

Yes, seems to me that useConfigOnly is better than both so far.

> I also wonder if we could simply expose the 4 levels of above in a
> variable, and default it to type-3. That would let people loosen or
> tighten as they see fit. But it would be a more complicated patch, so if
> nobody really cares about it beyond this use case, it may be overkill.

I get the impression from this and your later E-Mails that there are
much more cases to cover when testing this feature (and I would not
like to break stuff implementing this, obviously).

The code should be cleaned up anyway. I only delved into that code for
the first time two days ago, so it would take me more time to come up
with a new one (though reading your overview here of the cases is going
to be helpful, thanks).

-- 
Dan Aloni
