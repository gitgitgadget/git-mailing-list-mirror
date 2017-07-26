Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287A72047F
	for <e@80x24.org>; Wed, 26 Jul 2017 15:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbdGZP6L (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 11:58:11 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37942 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdGZP6K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 11:58:10 -0400
Received: by mail-it0-f44.google.com with SMTP id h199so69350326ith.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xfWVHa+ljeLf6m9BlSgWM6GBHNx0UBqj/Q6K3EsJMFI=;
        b=qIbOKg6RLserHBjGzcQi7oEbQk5DIjYyh22b+cK+w5gEsUMY/+SX9UQbMWFIGmmABP
         +GMzxM/yNqYQmk7knvi03By+succ+y87uHusJ0KYo7UJrkmrd2xxNhWGPwF7frzXNmtf
         tw7ryooCd6JJXHQosqr+vwzuh5ktAspMkJemYKh4Juob7z1LMt6yIUEKgdxoFC/PC1al
         TqH0nJoQAKJqws5gwBjlWea+aqnZLK5sC692BBKxHkJZ3jV3bnaqADYefDXjJB4epia5
         DNQRzuu93kBhVzDQ/AS1hqBMHIUhKc9W86WyQ0vX95tKxb37BFmn+1IIpNfHScNxbU9I
         uDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xfWVHa+ljeLf6m9BlSgWM6GBHNx0UBqj/Q6K3EsJMFI=;
        b=XALRqg/Cvq8maTo0U+ZXIdCI7vst6kPB/ECLnorKEyd2pJBo89QLZwDxY+Dyvl2iJK
         +gI+/SOQYpLcCutThFIWJkfqAkANc19bu6XeiqSJ1ULeZvAYslNQyPXx6uKzqb90U0gR
         3sMzFTvXH8Wp2Q2p9gbKwjgI7zjLx5KkkKe5AhcbEtLYeOYqWkYxWfrUhyRrHFIcECWL
         lAOVtY8grRMU1oryO1MDHFEsAuFOpT7aOdF4H4GuzK//L+55RF8npgcNR0T+kTknfjka
         W2TYMq6dAJg7GQaB7fhXBnSoJ2OdVK/r7W/XaHpcEKdD8XBeorVK4blLOdRiLAmdBbbb
         XYfg==
X-Gm-Message-State: AIVw113I9khmtHtKEDiA5IiJ6hIWX8sw7sa9L+DJjyjQBG8Dmu1lZTpg
        xGVz/RkTlEnnEkh1lC2Jw+oDl2xCd9AA
X-Received: by 10.36.76.10 with SMTP id a10mr1464876itb.96.1501084689879; Wed,
 26 Jul 2017 08:58:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.106 with HTTP; Wed, 26 Jul 2017 08:58:09 -0700 (PDT)
In-Reply-To: <CAP8UFD1FXPtzHF1J5ZfcsmMiHrfXQOd=qEghJQp3eFYsVd-nxQ@mail.gmail.com>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
 <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net> <CAP8UFD3VnpMuMpcfRcTwL4nRpOF5URj6zsQqiEWYwo=1pi5Phw@mail.gmail.com>
 <20170713205535.otzi3gjd63ubb2dm@sigill.intra.peff.net> <CAP8UFD1FXPtzHF1J5ZfcsmMiHrfXQOd=qEghJQp3eFYsVd-nxQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jul 2017 17:58:09 +0200
Message-ID: <CAP8UFD2NNBN=6GHbQPjz19hQUb+k_43YZBKimaA=3M6m4RH7Tw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 8:27 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Jul 13, 2017 at 10:55 PM, Jeff King <peff@peff.net> wrote:
>> On Thu, Jul 13, 2017 at 08:57:01PM +0200, Christian Couder wrote:
>>
>>> >> We want to make it possible to store the parameters to the 'run'
>>> >> script in a config file. This will make it easier to store, reuse,
>>> >> share and compare parameters.
>>> >
>>> > Because perf-lib is built on test-lib, it already reads
>>> > GIT-BUILD-OPTIONS.
>>>
>>> Actually the 'run' script also sources GIT-BUILD-OPTIONS, so maybe
>>> this is not necessary.
>>
>> Ah, right. The one that comes via perf-lib gets the variables into the
>> test scripts themselves. But anything "run" would need itself would come
>> from the source it does itself. And that's where GIT_PERF_MAKE_OPTS has
>> an effect.
>>
>>> Also are the variables in GIT-BUILD-OPTIONS exported already?
>>
>> No, I don't think so. But because both "run" and the scripts themselves
>> source them, they're available more or less everywhere, except for
>> sub-processes inside the scripts.
>
> Ok, I see.

Actually after taking another look at that, it looks like the following happens:

1) the run script sources the original GIT-BUILD-OPTIONS file from
../.. relative to its location
2) a git version is built in "build/$rev" using GIT_PERF_MAKE_OPTS
which generates a new GIT-BUILD-OPTIONS file in "build/$rev/"
3) when the actual perf scripts are run they source the original
GIT-BUILD-OPTIONS file (through perf-lib.sh which sources test-lib.sh)

I wonder how useful 1) is, as the variables sourced from original
GIT-BUILD-OPTIONS are not used inside the "run" script and not
available to its child processes as they are not exported.
Is it just so that if people add GIT_PERF_* variables to their
config.mak before building they can then have those variables used by
the run script?

I also wonder if it would be better at step 3) to source the
GIT-BUILD-OPTIONS file generated at step 2) instead of the original
one, because they can be different as the options in
$GIT_PERF_MAKE_OPTS will be baked into the new GIT-BUILD-OPTIONS file.
(Of course if $GIT_PERF_MAKE_OPTS was added to config.mak before
building, then they will be in the original one too. But
$GIT_PERF_MAKE_OPTS should work without that.)
