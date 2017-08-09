Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B961F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbdHIRzN (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:55:13 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34917 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdHIRzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:55:12 -0400
Received: by mail-lf0-f44.google.com with SMTP id t128so31440995lff.2
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4APv3NAO5iRnhq8YjhVB/RipLpqVe90azTnmYCaaaXA=;
        b=NGj+AvC/4JIjgsczt/NxC2KoxT0+ndqqtJEhCvjj66SAN28a3ow41GApsvmA3qNT6B
         uxkLoepxHeQIcnWvSKao2U2m4ky3Je80aic1/1zqYo2374LH86BHgeVpAtDsIy0Ss9cH
         3FiIY7HsmTyWvyI5EvTmvjEWK+xgSC5Tgcil6jwbuEqoIA/UUL4gJE/zkC4xhWZtyADG
         RPsDkxsSspvdK2vPzmW4Nvn5MQb2ZpOVjeTqXDq6q8qRHtYm/qG6PjkFl74hQAr3pt6s
         Ns5m20ICx5+SXpOw/8EOewhY8JBTIM1N9jpUFEHAvuTFD6awB5mJkheNWTN5dz1Fo0jj
         h8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4APv3NAO5iRnhq8YjhVB/RipLpqVe90azTnmYCaaaXA=;
        b=AEL67j6/z/qllmfPbkp0r8aOz8kj8wakuposjkSQZDGUn5tMJy71YOuwUX2V/ZWdl6
         A424k9hdvEJCitkq+PAzdIC200gJ5N3aXwzxjbLmqiWk95YmYVWyPoWiV/IUtO9R2gNc
         +plSHnTZ1u6WP6arCVYGC0lpPcwS+16LYvMtWYQu9m1XvPseRLH/IGq8IC2aFzQpUFAA
         LVRAXJsy4MdZ11DCX1A10UqFBvO/pdPmHP0Ej/9CcPW3KEPAKPp+JpOTs0GhZD8YZGCk
         W5FNCupc6qDgFzYWvj21fl96TQ2v2dUoku1K3KHSYnPAAO9Fm9bHgTXPR8xdv0onoWyQ
         cgOQ==
X-Gm-Message-State: AHYfb5jNTvNt2aMlNKCLiMQRPz0XaIa+73/UcEXvLerikQzi0QsnRqri
        U6OMkxAyNVgniJEaZ1yssKzvZ6gPntWD
X-Received: by 10.25.92.9 with SMTP id q9mr4004346lfb.117.1502301310904; Wed,
 09 Aug 2017 10:55:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 10:55:10 -0700 (PDT)
In-Reply-To: <CAGZ79kZxtq9Fe1usBgyNSpL1qAXiE-cVvBeWZf1_bP8bjMLwWw@mail.gmail.com>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170809122402.7y4g5g5y2kkrky5e@sigill.intra.peff.net> <CAGZ79kZxtq9Fe1usBgyNSpL1qAXiE-cVvBeWZf1_bP8bjMLwWw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 10:55:10 -0700
Message-ID: <CAGZ79kY072zvfV3QOA8-fr9sB26QqprxJLV46DrP6RUG4_inGw@mail.gmail.com>
Subject: Re: [PATCH 2/5] interpret-trailers: add an option to show only the trailers
To:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 10:52 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 9, 2017 at 5:24 AM, Jeff King <peff@peff.net> wrote:
>> In theory it's easy for any reader who wants to parse
>> trailers to do so. But there are a lot of subtle corner
>> cases around what counts as a trailer, when the trailer
>> block begins and ends, etc. Since interpret-trailers already
>> has our parsing logic, let's let callers ask it to just
>> output the trailers.
>>
>> They still have to parse the "key: value" lines, but at
>> least they can ignore all of the other corner cases.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
> ...
>> +test_expect_success 'only-trailers omits non-trailer in middle of block' '
>> +       cat >expected <<-\EOF &&
>> +               Signed-off-by: nobody <nobody@nowhere>
>> +               Signed-off-by: somebody <somebody@somewhere>
>> +               sign: A U Thor <author@example.com>
>> +       EOF
>> +       git interpret-trailers --only-trailers >actual <<-\EOF &&
>> +               subject
>> +
>> +               it is important that the trailers below are signed-off-by
>> +               so that they meet the "25% trailers Git knows about" heuristic
>> +
>> +               Signed-off-by: nobody <nobody@nowhere>
>> +               this is not a trailer
>
> Please see 60ef86a162 (trailer: support values folded to multiple lines,
> 2016-10-21), maybe we also want to test for
>
> VeryLongTrailerKey: long text with spaces and breaking
>     the line.
>
> For those parsing the trailer do we unbreak the line?
> Such that one line equals one trailer? or is the user of the parsed
> output expected to take care of this themselves?\

Nevermind, 4/5 solves that problem.
