Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27ED51F407
	for <e@80x24.org>; Mon, 11 Dec 2017 06:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdLKF4G (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 00:56:06 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:36195 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdLKF4F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 00:56:05 -0500
Received: by mail-it0-f51.google.com with SMTP id d16so13146501itj.1
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 21:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mK/GVpubz9HSDT1nf4Foivons42lZ/y2TYKAkGgPxak=;
        b=MbwrofvlMgqALLUcib+Vbd5nSv3xFnzraCg7+d2PpXW6OtnvZb2ZwamgI9tC7PaKcw
         E06V8zWHw19RFkOhaq3F5+R7UVLBb72kETX7FvqElIKrYTwx5koDT3Q8bSArYCoblQQP
         hddTzlkvbEhV9KKNdOHO1BJXYqBRoe8sg+i7oiDWUKMCnyLYuwaCCEAp4e6jJ6Ehiy+u
         R9oz6sMGIqK+KJ/u57N4lqetZja645+ys8R/Rg+zfeGwLUArEzSw4hLAGIprSg40JLo1
         FcagY3q6ELdb+Kimvi5dGTPlw6ofAS1vT9qLH3oPdcStt6SD5tHd/iNi7T2K6vkW7SOv
         13Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mK/GVpubz9HSDT1nf4Foivons42lZ/y2TYKAkGgPxak=;
        b=a7a9XF4eCbLEo3+QFEkUuxeL6zbZmcoSDm7r98LNdPG6oDfyCQZjUQ27jVAXukrwJc
         fVPryI9O0qYgM43zkNFN5iH93C5iQKACfBK0tSWotsfMX0t0cedTUOCIle9lWli89FKJ
         zzg/NVpC8NK5OLRB3qHMiBQSDi/tcqOc1EP3jdRWNf16PUaHjmNcJoiES4Dyk5OcvbBh
         FN2nfwXZLcET4szB65LhoDxwWeDfsifHnOBzqvUq9iTIJl/tk35fFgBdN96jlESlZYaz
         ZUFjpQNZDzHVc9S0AwJjnZDRYh0LPsM/jOnDtcQ/mgJemKeSItShM0NxP2bVitb6UbCX
         ZSBg==
X-Gm-Message-State: AKGB3mKCsWEFU8lRLKe177n6/DqzfOClcrQwSBMg5uonrxyFnFhYwr5Y
        4eF+e8Lyo0YEGRNqp+494a3KMgmnZUVSpKTGHfk=
X-Google-Smtp-Source: AGs4zMZh0YNnbtsHFB05+7rFutNhIDAe//RknqZgreZMO27vZ0zLiO0SKRH+X3/O3q/cEVVpiXhXDK901+ixuAzi9z8=
X-Received: by 10.107.81.2 with SMTP id f2mr23438461iob.282.1512971764396;
 Sun, 10 Dec 2017 21:56:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 10 Dec 2017 21:56:03 -0800 (PST)
In-Reply-To: <20171210143914.GA19894@sigill.intra.peff.net>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
 <20171210143118.GB19453@sigill.intra.peff.net> <20171210143914.GA19894@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Dec 2017 06:56:03 +0100
Message-ID: <CAP8UFD26ZJQWtfzETHXjPoKWyL0f3qEuimohVysYo0WtmpSyBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] git-compat-util: introduce skip_to_optional_arg()
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 10, 2017 at 3:39 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Dec 10, 2017 at 09:31:18AM -0500, Jeff King wrote:
>
>> On Sat, Dec 09, 2017 at 09:40:07PM +0100, Christian Couder wrote:
>>
>> > The changes compared to v2 are:
>> >
>> >   - s/_val/_arg/ in the name of the functions
>> >   - s/val/arg/ in the name of the third argument of the functions
>> >   - works with NULL as third argument of the functions
>>
>> This whole series looks OK to me, but this third point made me wonder:
>> what would be the use of allowing NULL for the "arg" parameter?
>>
>> I didn't see any use of this in the series, and I'm having trouble
>> figuring out how it would be useful. E.g., if I do:
>>
>>   if (skip_to_optional_arg(arg, "--foo", NULL))
>>      ...
>>
>> what can I do in "..."? I know we matched _some_ type of "--foo", but I
>> cannot know whether it was "--foo" or "--foo=bar", nor what "bar" is. It
>> could only be used by some kind of vague validator to say "well, at
>> least this looks like an option that I _could_ parse if I wanted to".
>>
>> So I guess I don't mind it, as it does the most reasonable thing it can
>> when passed NULL, but I would be surprised if we ever actually exercise
>> the code path.
>
> And of course as soon as I sent this, I went back and double-checked.
> And indeed I totally missed this call:
>
>   +       else if (starts_with(arg, "-B") ||
>   +                skip_to_optional_arg(arg, "--break-rewrites", NULL)) {
>           if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)

Yeah, calls like this were discussed in:
https://public-inbox.org/git/xmqqh8t6o9me.fsf@gitster.mtv.corp.google.com/

> So that's kind-of weird, because we are parsing "-B", etc, and then
> expecting it to be _reparsed_ by diff_scoreopt_parse. So the two
> callsites must always match. IMHO this ought to do either:
>
>   - we should just ask diff_scoreopt_parser to tell us if this was a
>     valid option that it understood
>
> or
>
>   - parse up to the "=", and then ask the scoreopt parser to parse the
>     remainder. This would require us passing 'B'/'C'/'M' to the
>     function ourselves, I think that's a better pattern. It means we
>     could reuse the parser for things like config values if we wanted to
>     (our current diff.renames is a bool, but it would not be
>     unreasonable for it to take a score).
>
> None of that is a mess of your creation, though, so I'm OK punting on it
> for now.

Yeah, this could be part of the #leftoverbits.
