Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186C8209AB
	for <e@80x24.org>; Mon, 26 Sep 2016 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754883AbcIZREe (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:04:34 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33633 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbcIZREd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:04:33 -0400
Received: by mail-pa0-f43.google.com with SMTP id fn2so2534592pad.0
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTmVyTTKH9R6piR5E9QHehqzGUQkLt8iCJqQK1gZAJI=;
        b=SJPgYEwhqLo08zT2qFzsFELc5D3QOuykWHWM7lIFFzps12nBYmrlxVvzvtCZChpHVg
         ct4+symEZI1PPx+WFa6noYfnEGMskEK/CF/0fup00EPpcgjZTDE2+mHuLb1vWtbkxiqG
         f+ezy8OO4dzpTiRCt+V9EOrw3sV9TMPPvxS93Jqpfk6dHRc7kFeIUROoGlrfEAU6CNz3
         RfQQWkg6rS02IXFn3zBavZ/+P6y78F7chsLATjRdvlGCuNArfa42DHkDqDE8R8PAGmAj
         hYujKII5/n9G1oBgAtjYrsrKhsHklTKh8V/pApVJe0ee0jC4UziKGnkQ8QzlR6oA5O+1
         WWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTmVyTTKH9R6piR5E9QHehqzGUQkLt8iCJqQK1gZAJI=;
        b=bNRAmP/1npO4pjTWGxv+urk9fOSWUtXUN6+yTnExAzZQefZ1Jn3HhxbNnnmTC8NW3O
         sUxD7ZNPkEoWSoUyRP7hpM+if7IZN1e35vyYT7ZBDdtGPAlKxjDI3DeGI0mEVi7WWxuq
         Nmqw9ry0h8GMJdsiWiy0PBZfLalh5ahO8moWywOY2SmqRzlJlFpda1+MS7QfOiiduQgG
         HRI2+R0zuwV217QBNc/zFJuRSj31ldC2XsccYZ1O0f3bB7BmUWNRkF0T5d4sNhKpJnEu
         O7gP/+YBSXubF47pLcaRlFXhJ9jAdZs3EB3CbH/AZf84TnTlYXCpGnme2ZItwpNntrKw
         K6jw==
X-Gm-Message-State: AE9vXwNWfyu25RoxpEhr8Cvbp0zFQMfKfBLVT7x+SY0/4w7S9vn4JYcIbNGULI75cp85yVax
X-Received: by 10.66.160.99 with SMTP id xj3mr40247197pab.73.1474909472240;
        Mon, 26 Sep 2016 10:04:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:2c34:dd90:c538:3321])
        by smtp.gmail.com with ESMTPSA id y11sm30576970pfa.4.2016.09.26.10.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 10:04:31 -0700 (PDT)
Date:   Mon, 26 Sep 2016 10:04:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] recursive support for ls-files
Message-ID: <20160926170429.GA3624@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
 <20160925163244.GB66080@google.com>
 <xmqqzimvygdt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzimvygdt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/25, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > On 09/25, Jeff King wrote:
> >> On Fri, Sep 23, 2016 at 05:13:31PM -0700, Brandon Williams wrote:
> >> 
> >> > After looking at the feedback I rerolled a few things, in particular the
> >> > --submodule_prefix option that existed to give a submodule context about where
> >> > it had been invoked from.  People didn't seem to like the idea of exposing this
> >> > to the users (yet anyways) so I removed it as an option and instead have it
> >> > being passed to a child process via an environment variable
> >> > GIT_INTERNAL_SUBMODULE_PREFIX.  This way we don't have to support anything to
> >> > external users at the moment.
> >> 
> >> I think we can still have it as a command-line argument and declare it
> >> internal. It's not like environment variables cannot also be set by our
> >> callers. :)
> >> 
> >> I don't mind it as an environment variable, though. In some ways it
> >> makes things easier. I just think "internal versus external" and the
> >> exact implementation are orthogonal.
> >
> > We may still want it to be an option at some point in the future.  This
> > way we can revisit making it an option once we know more about the other
> > uses it could have (aside from just being for submodules as someone
> > suggested).
> 
> I do not think it makes too much of a difference between environment
> and command line option.  We need an update to the "git" potty to
> say "you told me to use the submodule-prefix feature, but this
> subcommand is not prepared to accept it (yet)" and cause it to error
> out either way, which would mean that a series that introduces the
> feature needs to touch "git.c" anyway, so I would have expected us
> to add command line option first, simply because "git.c" is where it
> happens, optionally with the support for the environment variable,
> not the other way around.

In a previous email you mentioned that this feature should be completely
hidden from users, which is why I removed the command line option for
this latest series.  If that isn't what you intended that I can
definitely add the option to git.c.  And you would rather we perform the
checking in git.c to see if a subcommand supports the prefix versus
silently ignoring it if it hasn't?  I'm assuming this checking would
also be done in git.c?

> 
> >> > Also fixed a bug (and added a test) for the -z options as pointed out by Jeff
> >> > King.
> >> 
> >> Hmm. It is broken after patch 2, and then fixed in patch 3. Usually we'd
> >> try not to have a broken state in the history. It's less important in
> >> this case, because the breakage is not a regression
> >> (--recurse-submodules is a new feature, so you could consider it "not
> >> working" until the 3rd patch). But I think it's still a good rule to
> >> follow, because it makes the commits easier to review, look at later,
> >> etc.
> >> 
> >> For that matter, I do not understand why options like "-s" get enabled
> >> in patch 3. I do not mind them starting as disabled in patch 2, but it
> >> seems like "pass along some known-safe options" should be its own patch
> >> somewhere between patches 2 and 3.
> 
> Yes, exactly.
> 
> An obvious lazy way out to avoid breakage-in-the-middle and make
> incremental progress would be to squash everything into one patch,
> but we should and we should be able to do better.
> 
> I'd imagine this three-patch series would be more pleasant for
> future readers if it were structured like:
> 
>  [1/3] introduces the submodule-prefix as a global feature; at the
>        least it needs a way to invoke (either an environment, or an
>        option to "git" potty, or both) and prevent mistakes by
>        erroring out when it is attempted to call a subcommand that
>        does not support the feature (yet).
> 
>  [2/3] adds the --recurse-submodule feature in a limited form to
>        "ls-files".  I'd suggest for this step to pass through all
>        options and arguments that are safe and reasonably useful
>        to pass through without needing anything more than "ah, this
>        option was given, so let's stuff it to the argv-array". An
>        attempt to give things that are not yet passed through until
>        3/3 to lead to an error that says it is not allowed (yet).
> 
>  [3-N] each of the remaining steps after 3/N adds support for one
>        more thing to be passed that 2/3 refrained from doing, by
>        doing more than just "pass it in argv-array", and then remove
>        the "not yet supported" error that added by 2/3 for that one
>        thing.  The first of these "more things" would be to support
>        pathspecs as the receiving side would need code changes for
>        the matching logic.  There may be more, or there may be
>        nothing else that requires 4/N, 5/N, etc.

I can do another rework and structure the patch series more inline with
what you are suggesting here.

-- 
Brandon Williams
