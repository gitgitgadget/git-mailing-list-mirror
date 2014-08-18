From: Travis Carden <travis.carden@gmail.com>
Subject: Re: Feature Request: `git remote prune --all`
Date: Mon, 18 Aug 2014 00:56:28 -0500
Message-ID: <CAByVDedhkUgXkey9dkPYxVQqvzRW4D9OOXt4uFa74+7PvX0mjA@mail.gmail.com>
References: <CAByVDef1_7x8Q1SL5wMtrKJQE51gvEOiKJ4xkpexXN5omBDn-Q@mail.gmail.com>
	<20140817071805.GC23808@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 07:56:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJFw4-0003tD-26
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 07:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbaHRF43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 01:56:29 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:61639 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaHRF43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 01:56:29 -0400
Received: by mail-yh0-f51.google.com with SMTP id f73so4132371yha.38
        for <git@vger.kernel.org>; Sun, 17 Aug 2014 22:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nkB9MHaMXw2QWkxQpl8wWacY1gUvKtTxh+6NM/EkIW8=;
        b=uI8REVWJ60IJVh6HnUY5Nu+t8AKt8wnEPDAA8xIk7eYTWYK9p08Cyxxh9giBFpLFUh
         nEkGYJDY6DP5LokK7KStcIN8lIb/22LfQbE/sGzDC2AkXVjQ/6B4N86It7Kwrcs7047f
         JcvdlGRS0oXn2ZowAC4uZOTgjZmXIItQ41r7p/UW9GxISMiwz1iLAFQI/hYRY8KYiaYC
         xbt5NI06Prf9/FNivFLi1SYLbmQqBqX3IwtxWvoaw4q/LfGrHlRSnx8/3LfEJkTj3X/z
         /KzSTyCH07dt45KkOhSm0PSX7hptnZLr6Y3Ktb5M68JEEQPwCUgGiLc4iOM/ACW6L0wA
         tyGQ==
X-Received: by 10.236.41.49 with SMTP id g37mr145312yhb.120.1408341388412;
 Sun, 17 Aug 2014 22:56:28 -0700 (PDT)
Received: by 10.170.159.130 with HTTP; Sun, 17 Aug 2014 22:56:28 -0700 (PDT)
In-Reply-To: <20140817071805.GC23808@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255381>

Thanks, guys! `git fetch --all --prune` satisfies my request. I
appreciate the education!

On Sun, Aug 17, 2014 at 2:18 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 16, 2014 at 07:52:44PM -0500, Travis Carden wrote:
>
>> I would like to propose the addition of a `git remote prune --all`
>> command option or similar mechanism for pruning all remotes in a
>> repository. For lack of such a feature, I've been using the following
>> bash alias:
>>
>> alias git-remote-prune-all='for REMOTE in `git remote`; do echo
>> "Pruning $REMOTE"; git remote prune $REMOTE; done;'
>
> I think in general we've been moving "git remote" away from actually
> interacting with the other side, and pushing those features into "git
> fetch". These days you can use "git fetch --prune --all" to do what you
> want.
>
> Note that this isn't _exactly_ the same thing. Fetch's prune will do a
> normal fetch and _also_ prune. There is no way to say "just prune, but
> do not update existing refs". If that detail is important, I think I'd
> rather see the feature go the other way from your request: teach
> git-fetch a "--prune-only" mode.
>
> -Peff
