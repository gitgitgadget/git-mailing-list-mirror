Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17A11F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 05:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfJPFRX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 01:17:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45372 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfJPFRW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 01:17:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so13912717pfb.12
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 22:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fxxjjZ32rB6eM/uCFN7WMmQ2zU+vDNho0T8P9PNqvVM=;
        b=tpu8ewRBcfO0RZgvTOn6fvf28d1y1owFX5apwzxjaCne/WTZW5Us8dEmB6OV9itzl1
         vS6ESuiY3fAmNXT/5H87fuuK9enLJqHYdavVR5vpuWkrd8OzRTFB6nG2zs5zNScAP867
         4qETibBxOEtQqdEqT1uXQj97mbAbURZ3Ua6vr2a0e9hu+rxBdrImryxC3V8NLLTZFSma
         phfJkkO6WCdoIRTQUr+3NVxUAGt51xPL5YmLap6Oq7wHznrECbywkBsAdVv1NxtSquyv
         UQM2iJj1PMKERR3PIxl1EK2jOZ3e0RyCUSOsZjNG2qVkSZKcdHc/dcF+BdgwX9+4g+Br
         3akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fxxjjZ32rB6eM/uCFN7WMmQ2zU+vDNho0T8P9PNqvVM=;
        b=tmdtjISUeE/fn5IURqxc1uuus7pj0HLj4xF+gdkXYi5bfg9uAiFTuADMasY3W3c4QB
         cwVMFuhpUFapJNPdiVWsvBRjfYiPos09yDsgdzc7bMYgjS/19A0AfP50aH4EbP6NA563
         vhdfjT8tyqUXVipYm83E/Vurbz5LJhCKsVaauHmnl6RRZQwVOR+fVv7LTzsVUIm6BueZ
         mlPGCcZLlX3JsIijhnUbVTdO44w4PvvFsbuTiL9o87EWNEd3LPcUgepocxGGgn4mi4w6
         abs6ef/dJI8J8janDmEwFiiHOG/wJzsBPBQp3P3v5o9E5binBZosqyOdqb4VnFaVk+J0
         C67Q==
X-Gm-Message-State: APjAAAWzzzWKH7U0cM9VLHD1aCg6wh091XupIzCno6xf95LlEmJcU3A0
        7BlJgQ7LemcK9F8xmr/1kKo=
X-Google-Smtp-Source: APXvYqxmAGZvxirvpMBSioGOBAnDunFLn2aBvyZKKf3T2nCYCyE5y05L1BKdQCTKIH2M0WVG0H2qPQ==
X-Received: by 2002:a63:cf46:: with SMTP id b6mr42397886pgj.90.1571203041567;
        Tue, 15 Oct 2019 22:17:21 -0700 (PDT)
Received: from localhost ([2402:800:6375:2b61:f51c:7233:c8a4:1e74])
        by smtp.gmail.com with ESMTPSA id f89sm1050288pje.20.2019.10.15.22.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 22:17:20 -0700 (PDT)
Date:   Wed, 16 Oct 2019 12:17:18 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] notes: copy notes to HEAD by default
Message-ID: <20191016051718.GA2034@danh.dev>
References: <20191015163631.21808-1-congdanhqx@gmail.com>
 <20191015163631.21808-2-congdanhqx@gmail.com>
 <xmqqpnixa1oh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnixa1oh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-16 11:01:34 +0900, Junio C Hamano wrote:
> Doan Tran Cong Danh <congdanhqx@gmail.com> writes:
> 
> > The target objects for copying notes was defaulted to HEAD from very
> > early stage of git-notes.
> >
> > However, that default was limited by commit bbb1b8a35a, ("notes: check
> > number of parameters to "git notes copy"", 2010-06-28).
> 
> Sorry, I don't quite get the above.  The said commit made sure 'git
> notes copy' gets the right number of arguments, saying """Otherwise
> we may segfault with too few parameters."""  I take that as a sign
> that before that commit it was not defaulting to HEAD but attempting
> to access the missing argv[2] (or whatever the index the <to-object>
> should be at) and dereferencing a NULL?
> 
>     ... goes and digs ...
> 
> I think v1.6.6.1-458-g74884b524e is the commit that made the command
> line parsing into the current shape, i.e. one parse_options() call
> in each of the subcommand that gets dispatched, and you are right
> that with that version a single argument given on the command line
> is taken as the <from-object> and <to-object> defaults to HEAD.
> 
> So... what happend between that vesrion and v1.7.1-200-gbbb1b8a35a?
> 
>     ... goes and looks at bbb1b8a35a again ...
> 
> Ah, I think there is an off-by-one.  When not from-stdin and not
> using rewrite-cmd, before that patch, we did not even check if
> from-obj exists, so in that sense, the commit had a right idea that
> it must check for "too few parameters", but it shouldn't have
> insisted that we have at least two.  It is OK to have just one,
> i.e. only the from-obj, for our purpose.

Yes, this is my intention.

> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> > index d3fa298c6a..a8f9a0f36c 100755
> > --- a/t/t3301-notes.sh
> > +++ b/t/t3301-notes.sh
> > @@ -908,6 +908,10 @@ test_expect_success 'allow overwrite with "git notes copy -f"' '
> >  	git notes copy -f HEAD~2 HEAD &&
> >  	git log -1 >actual &&
> >  	test_cmp expect actual &&
> > +	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
> > +	git notes copy -f HEAD~2 &&
> > +	git log -1 >actual &&
> > +	test_cmp expect actual &&
> >  	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
> >  '
> 
> This I am not sure is a good test to add to, especially as a fix to

I was writing this patch just before my bed time, just to get some
comments on the directions, e.g:
- loosen the argc requirements; or
- do the code cleanup

> bbb1b8a, which added this test:
> 
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 64f32ad94d..2d67a40fc1 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1044,4 +1044,10 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
>  	git log -1 > output &&
>  	test_cmp expect output
>  '
> +
> +test_expect_success 'git notes copy diagnoses too many or too few parameters' '
> +	test_must_fail git notes copy &&
> +	test_must_fail git notes copy one two three
> +'
> +
>  test_done
> 
> The lack of testing that "git notes copy <from-obj>" succeeding is
> why the off-by-one bug was not noticed, so I think that test (which
> still exists to this day) is the right place to add a test to
> protect this fix.

I don't think this is a good place to add this test either,
since the test description specificaly said it diagnoses too many or
too few parameters.

Anyway, the test `git notes copy one two three` still fails if we
accidentally allow 3 arguments since one two three isn't valid ref.
I'm gonna add a statement to assert the diagnose message.

Since I don't want to update the commit id (e.g. 10th, 11th, etc..)
of other test cases, I think it'd be better to modify the current test:

- for the test case without '-f' flag, remove HEAD if it's the target,
  and add a test-case to copy to somewhere else. Well, all of our current
  test cases only test with HEAD as target-object.
- for the test case with '-f' flag, I think I'll keep my current
  approach.

> 
> As to the log message, here is how I would explain/justify the
> change, if I were writing it.

I'll update the commit message.

-- 
Danh
