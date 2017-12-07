Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CECEA20C32
	for <e@80x24.org>; Thu,  7 Dec 2017 01:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbdLGBE0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 20:04:26 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37055 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdLGBEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 20:04:24 -0500
Received: by mail-wm0-f41.google.com with SMTP id f140so10108785wmd.2
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 17:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lks733AiI9UdXimWr4RM8UsImRzodKME1MRsFzkZ3F8=;
        b=LOeEchhRe+d4FsIDLJJeQXCmEDsS76EZgxUF54W3T2Y2PzuqpXc7RuntDihVW9xuJF
         ErNrO+yuCvNG0p/6TIpvH4SO54HCqVMCAH0oMh3qKeRYcA9xOJ/RJcYwXm4zTqZq0Z5B
         pTTbK/Jrzcuzp4pP/FbCoj0ufXh4OjLop01nCHY6n6ijByK0PpWunoe2P8frQzQtDFAo
         D5bP9pVrVwj/ACw9G3LKNhU87cXziJ0qlUKZ5STxwms3XY83AM30KQ2j5iHBheEssTwO
         RvNyIG1h/QWaqncFmGQ62dtLvzCsLjWbVNLCXivj4DovhGGsV/AHXEr/fFbxBno+F80P
         J2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lks733AiI9UdXimWr4RM8UsImRzodKME1MRsFzkZ3F8=;
        b=BdPhuc9fo2M48xf0BeTEVEZ+czFJV503PgtDB6vvsljYHMUtX1GfkxBCW8mmxzMNyS
         lqgfcjiTcRFqnkEvm1rscdlfMSRaJpsqf11OfeN0dq6i5dEQLZT2ajisDtNx8pqGYQPm
         Eo2+HQhlhZwdd+PDRbgu1kySHJcfZYdIXS1Fi46D5zt17G196gAcJ2YTxxOhluhGuEoN
         EGPXWHG5K7AoUapABzhPB6koFZGSjUOack5DUCfsIi4ZFjYBZ9BEBRkzd//bT95YVTDt
         rBfBP2Bo+krVQMT85JECWhFuqQZlk4xg4wwImpeKinntnHBhKzFaaN9eVhNTUswIV2vb
         Gy6g==
X-Gm-Message-State: AJaThX6xQ1/hlFDnHjRPeb90Q0/At3oQcmm6st2HCgBQWp+EZ5X693I7
        Q5Ad8XNt4BKKsAaXjo0TwNJyl5RakoCgK6ZeeU4=
X-Google-Smtp-Source: AGs4zMbsughkLXA2WrtwdVxFRAYwZ/csTF43KcCoZt593lSc36ZNkOuFjMoelUJhtOZYGoqzLlxkkwmIbarILR2k48M=
X-Received: by 10.80.137.147 with SMTP id g19mr42664550edg.293.1512608663465;
 Wed, 06 Dec 2017 17:04:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 6 Dec 2017 17:04:02 -0800 (PST)
In-Reply-To: <20171207005639.GB1975@sigill.intra.peff.net>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
 <20171207002234.GA21003@sigill.intra.peff.net> <20171207002439.GB21003@sigill.intra.peff.net>
 <CA+P7+xpoaa5zaF13ageKKjpPKTECU6XjaRdSZy6WOP7Q0TX+yA@mail.gmail.com> <20171207005639.GB1975@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Dec 2017 17:04:02 -0800
Message-ID: <CA+P7+xo5Zw5AjbJ2RAkzAidii-JUZHK=SDO+zS2nT1CD9mu_fg@mail.gmail.com>
Subject: Re: git commit file completion recently broke
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 4:56 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 06, 2017 at 04:38:29PM -0800, Jacob Keller wrote:
>
>> >> But nope, it looks like the culprit is f7923a5ece (diff: use
>> >> skip_to_optional_val(), 2017-12-04), which switched over parsing of
>> >> "--relative".
>> >
>> > Oh, actually, I guess I was half-right. It feeds &options->prefix as the
>> > "default", meaning that we overwrite it with the empty string. I don't
>> > think "--relative" works for the semantics of skip_to_optional_value,
>> > since it needs:
>> >
>> >   --relative=foo: set prefix to "foo"
>> >
>> >   --relative: leave prefix untouched
>> >
>> > -Peff
>>
>> Yep, and apparently our test suite completely lacked any tests of
>> --relative on its own.
>>
>> I've sent a patch to add some tests.
>
> Great. I was also saddened by our lack of tests.
>
>> I don't know the exact best way to fix this, I guess we could just
>> revert it the changes to relative... but maybe we could add or modify
>> the semantics of skip_to_optional_val()?? What if it was changed so
>> that it left the value alone if no value was provided? This would
>> require callers to pre-set the value they want as default, but that
>> would solve relative's problem.
>
> I think that would work for this case. But just looking at others from
> the same series, I think they'd get pretty awkward. For instance we now
> have:
>

That obviously won't work for any case which sues
skip_to_optional_val_default() (since these provide a default value to
give in case none is provided.

>   else if (!strcmp(arg, "--color))
>         options->use_color = 1;
>   else if (skip_prefix(arg, "--color=", &arg))
>         /* parse "arg" as colorbool */
>
> which became:
>
>   else if (skip_to_optional_val_default(arg, "--color", &arg, "always"))
>         /* parse "arg" as colorbool */
>
> How would that look with the "leave it alone instead of assigning a
> default" semantics? It gets pretty clumsy, because you have to
> pre-assign "always" to some pointer. But then we can't reuse "arg", so
> we end up with something more like:
>
>   const char *color_val = "always";
>   ...
>   else if (skip_to_optional_val(arg, "--color", &color_val))
>

It obviously wouldn't. The only sensible solution is to have
"skip_to_optional_val_something()" which does this new behavior.

Or, change skip_to_optional_val() behave this new way, but
skip_to_optional_val_default() behave in the current way.

> But we need one such "color_val" for every option we test for, and we
> have to set all of them up before any matches (because we don't know
> which one we'll actually match). Yuck.
>
> I think we'd do better to just assign NULL when there's "=", so we can
> tell the difference between "--relative", "--relative=", and
> "--relative=foo" (all of which are distinct).
>
> I think that's possible with the current scheme by doing:
>
>   else if (skip_to_optional_val_default(arg, "--relative", &arg, NULL)) {
>         options->flags.relative_name = 1;
>         if (arg)
>                 options->prefix = arg;
>   }
>
> IOW, the problem isn't in the design of the skip function, but just how
> it was used in this particular case. I do think it may make sense for
> the "short" one to use NULL, like:
>
>   skip_to_optional_val(arg, "--relative, &arg)
>
> but maybe some other callers would be more inconvenienced (they may have
> to current NULL back into the empty string if they want to string
> "--foo" the same as "--foo=").
>
> -Peff

What you outlined above is probably the best we can do. We could even
add some extra helper which does that for us if we want.

I sent a patch that merely reverts the change to --relative and adds a
test for now though.

Thanks,
Jake
