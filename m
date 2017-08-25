Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAEA208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 19:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758391AbdHYThs (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 15:37:48 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35443 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758384AbdHYThq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 15:37:46 -0400
Received: by mail-pg0-f46.google.com with SMTP id 63so3935308pgc.2
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/FP0Kpn3wjS33KkAKbT86+D+mPOYMk5x29lH5K4WK4=;
        b=UUenAyeks8IRqpISFMBeRDQFccrsz7B+IK7XxR6ZyGTcA1Yzyw6pDW0qOkh1H3Exdb
         UQmR6tX7HUEaHUwBW/jDcmeJSOuDJMkPg/SPp/pU5birU1w7icXptf8TDt9wUgViM7wT
         jlIg6PXe8V+RoacrSJgWA5rseHqfDiYi5T2qdNKzNOKPayW6P1ApI0PRWdLyzEnE2omA
         6h1ngVBinEWf5pdtIB6VUM48uCIeit82jgOUmQolputguJqSFXLx2cF2nPQMaOmRRl+k
         NU2FqwR+oQEr2h0rQtUnO8m1A80QYln8vgO7Xz1iBsKPRLwI8mmefuo8E85tkwk+WT9k
         w42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/FP0Kpn3wjS33KkAKbT86+D+mPOYMk5x29lH5K4WK4=;
        b=ki8/0qT3RrIesDjFMDUaqmlIqnj8FDy6BsAo08jpMXFZ3ccA9Wg3bq2r/i+QW/oswW
         p3VSAtKLNq0YbW6uQMv49NpkIgUSWruHULe4nE4Fzyt1Ee20stdVUOuRWGFvVVUkOSlw
         fW9fYTZvucxtDSfcoV2O+Vrw0+1+wjvUxCWN5jqXMiMStCNFzYF2v5Fwfx3iWVMtsN3U
         6x2SYxkAIwpF0btxmSR9Q2EDOU3m5D4909PyEOLGQp4tMWlQYCvSEH9WgbkBF5ZT885q
         Y1G97D3pxx26RsuFM4EvhUgbRak44BhedljcM8NPuGV+x/MgDVxnBtmv2G/Ln67/kfE8
         wh4Q==
X-Gm-Message-State: AHYfb5iT0MpkXe6+tb6C8E+hYzHs6+Wh3zD58qHFfZDbEZNy2f7Uy/3i
        W6lRuCI1Yv5TyBFL7YhzFw==
X-Google-Smtp-Source: ADKCNb5ltXFmy4PRWTyh34CJWfs37Tabn541OFlZqEYKeYOjQOzuER7I6km3Vn+STpsbAUW/TvXl5Q==
X-Received: by 10.84.130.104 with SMTP id 95mr11566653plc.411.1503689865838;
        Fri, 25 Aug 2017 12:37:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f5e9:c606:d78a:b54a])
        by smtp.gmail.com with ESMTPSA id 3sm13883214pfj.92.2017.08.25.12.37.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 12:37:44 -0700 (PDT)
Date:   Fri, 25 Aug 2017 12:37:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Ivan Vyshnevskyi <sainaen@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] push: anonymize URL in error output
Message-ID: <20170825193743.GD103659@google.com>
References: <20170823094929.13541-1-sainaen@gmail.com>
 <20170823155826.m4s5y55x2esfoass@sigill.intra.peff.net>
 <82741094-19a6-e071-227d-f92b3b077a69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82741094-19a6-e071-227d-f92b3b077a69@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/24, Ivan Vyshnevskyi wrote:
> On 23/08/17 18:58, Jeff King wrote:
> > On Wed, Aug 23, 2017 at 12:49:29PM +0300, Ivan Vyshnevskyi wrote:
> > 
> >> Commits 47abd85 (fetch: Strip usernames from url's before storing them,
> >> 2009-04-17) and later 882d49c (push: anonymize URL in status output,
> >> 2016-07-14) made fetch and push strip the authentication part of the
> >> remote URLs when used in the merge-commit messages or status outputs.
> >> The URLs that are part of the error messages were not anonymized.
> >>
> >> A commonly used pattern for storing artifacts from a build server in a
> >> remote repository utilizes a "secure" environment variable with
> >> credentials to embed them in the URL and execute a push. Given enough
> >> runs, an intermittent network failure will cause a push to fail, leaving
> >> a non-anonymized URL in the build log.
> >>
> >> To prevent that, reuse the same anonymizing function to scrub
> >> credentials from URL in the push error output.
> > 
> > This makes sense. I suspect that most errors we output should be using
> > the anonymized URL. Did you poke around for other calls?
> Yes, I tried to check and unfortunately there are couple of places with
> possible leaks:
> * 'discover_refs()' in remote-curl.c when there's a HTTP error (see a
> real-life scenario with an authz error in my response to Lars) -- is it
> ok to include transport.h just to use one function or is there a cleaner
> way?
> * 'setup_push_upstream()' in push.c when a command doesn't have a branch
> names (haven't saw problems with this in the wild, but could occur
> during the CI setup) -- for this one, probably anonymization should
> happen when the 'remote->name' field is set in the 'make_remote()'; same
> question though, is it ok to include transport.h here?
> 
> Also there's an case of verbose output: I'm not sure I should change it,
> but it does print out the non-anonymized URLs at least during push.
> > 
> > The general structure of the patch looks good, but I have a few minor
> > comments below.
> > 
> >> Not sure how much of the background should be included in the commit message.
> >> The "commonly used pattern" I mention could be found in the myriad of
> >> online tutorials and looks something like this:
> > 
> > My knee-jerk reaction is if it's worth writing after the dashes, it's
> > worth putting in the commit message.
> > 
> > However, in the case I think it is OK as-is (the motivation of "we
> > already avoid leaking auth info to stdout, so we should do the same for
> > error messages" seems self-contained and reasonable)
> Well, I tend to be wordy, and most of the commit messages I saw were
> rather short, so decided to split. Wonder, if maybe example command
> should be included without the rest of it. Would it be useful?

I'm guilty of writing short commit messages (something I need to work
on) but when looking through logs I much prefer to see longer messages
explaining rationals and trade-offs.

> > 
> >> diff --git a/builtin/push.c b/builtin/push.c
> >> index 03846e837..59f3bc975 100644
> >> --- a/builtin/push.c
> >> +++ b/builtin/push.c
> >> @@ -336,7 +336,7 @@ static int push_with_options(struct transport *transport, int flags)
> >>  	err = transport_push(transport, refspec_nr, refspec, flags,
> >>  			     &reject_reasons);
> >>  	if (err != 0)
> >> -		error(_("failed to push some refs to '%s'"), transport->url);
> >> +		error(_("failed to push some refs to '%s'"), transport_anonymize_url(transport->url));
> > 
> > This leaks the return value. That's probably not a _huge_ deal since the
> > program is likely to exit, but it's a bad pattern. I wonder if we should
> > be setting up transport->anonymous_url preemptively, and just let its
> > memory belong to the transport struct.
> Ah. Thanks! I knew I'd fail in the memory management even with the
> one-line patch. :)
> 
> About 'transport->anonymous_url': not sure if it's worth it. There are
> four calls to 'transport_anonymize_url' right now and it looks like the
> new one in my patch is the first that has a transport struct instance
> near by. The next likely candidate for update 'discover_refs()' also
> gets the url as an argument.
> > 
> >> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> >> index d38bf3247..0b6fb6252 100755
> >> --- a/t/t5541-http-push-smart.sh
> >> +++ b/t/t5541-http-push-smart.sh
> >> @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
> >>  	grep "^To $HTTPD_URL/smart/test_repo.git" status
> >>  '
> >>  
> >> +cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
> >> +#!/bin/sh
> >> +exit 1
> >> +EOF
> >> +chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
> >> +
> >> +cat >exp <<EOF
> >> +error: failed to push some refs to '$HTTPD_URL/smart/test_repo.git'
> >> +EOF
> > 
> > I know the t5541 script, which is old and messy, led you into these bad
> > constructs. But usually in modern tests we:
> > 
> >  1. Try to keep all commands inside test_expect blocks to catch
> >     unexpected failures or unwanted output.
> > 
> >  2. Use write_script for writing scripts, like:
> > 
> >       write_script "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-\EOF
> >       exit 1
> >       EOF
> > 
> >  3. Backslash our here-doc delimiter to suppress interpolation.
> > 
> >> +test_expect_success 'failed push status output scrubs password' '
> >> +	cd "$ROOT_PATH"/test_repo_clone &&
> >> +	test_must_fail git push "$HTTPD_URL_USER_PASS/smart/test_repo.git" +HEAD:scrub_err 2>stderr &&
> >> +	grep "^error: failed to push some refs" stderr >act &&
> >> +	test_i18ncmp exp act
> >> +'
> >> +rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
> > 
> > Similarly, this "rm" should probably be a test_when_finished in the
> > block with the write_script (unless you really need to carry it over
> > several test_expect blocks, in which case there should be an explicit
> > test_expect cleaning it up).
> Thanks! You're right. I just followed examples in the file.
> Updated [1], will send with the next patch version.
> 
> > 
> > Instead of grepping for the exact error, should we instead grep for the
> > password to make sure it is not present on _any_ line?
> > 
> > -Peff
> > 
> One possible issue I see is that this will make it overlap with the
> 'push status output scrubs password' case above. But if it's not a
> problem, I can replace last two lines with just a 'test_i18ngrep !'
> 
> [1]:
> https://github.com/sainaen/git/blob/af17713/t/t5541-http-push-smart.sh#L380-L392

-- 
Brandon Williams
