Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82E720248
	for <e@80x24.org>; Sat,  6 Apr 2019 20:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfDFU2x (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 16:28:53 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45604 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDFU2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 16:28:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id f19so1318695edw.12
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=a6R2dQEpZ4XcvlnOhjBhnVIt6sBWWvaOgfrheqVLZG0=;
        b=ZooDGNsPwwGkXtOqZf6L0/HKy0VxN5x+cgLjO5s2jQ5XbnaCecdT4RkXJGkOTegYSf
         Z/S0FwqMakctqsIcY6eVtDOqodKrmJmOXRcOdF9aFhZgZiQBHZ+W246uDGFOaSJ6/d8K
         FBs80BMQyYwJdhBatscNyFuzXr/5QVtDQcTOR03RaIPWqIGnNEpNeAkl2afti0IYqvVm
         qD/Fh2cVdj0qgPRTD1kHdFdy/VdPVGyHxYJxwpQxr8+C7dhnuriiB3HNqqoMCFSprSWA
         yiGFAnCi+TmxrL3UJ+zIpJ6oCzlzN5n9ipxq7L3dpe1EcYRYzkZ/sL5G+22gTlL9zaC0
         gc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=a6R2dQEpZ4XcvlnOhjBhnVIt6sBWWvaOgfrheqVLZG0=;
        b=YfyeeDLVqqVDVtBtbeDIjUK5Q9cTsRIdGEXIfUDQ52RJ7vm8nEe9UsBo1LxQ9cPlBt
         BmSrzxy6DmiOpnAO0bifUGC9aRob3p9sVhamWMr39n5AtYvTyJyegPRXwIBGbSmC7cdn
         jRIofcgTwSWaVsrd2zSu1TemmdaCZbozb9djmN0zT0axwsSt6uJY1F1e7PkwGOyi3c1r
         tdnYLzoGNY1g9mWE4xSAbZWIZDHC9arwpBYuevH8pCImIG8zpTjoUyGzOcDi/P0A2UP0
         kVeHhqIbiDcLg68EAYqt6cKZ9HoM/6haJqATp5VvxCCYUdHxWiRL/poY61kEhzU3k1Mx
         cpYw==
X-Gm-Message-State: APjAAAU/5oWuW/f02XYawJRTSxJ1Q+xpoJAYPHPBjXg2j/5zw8igB+H9
        gyTKmXS4NLHUoc3HDOdInBczTVDh
X-Google-Smtp-Source: APXvYqypFvsyotMFM2SxK3CHP52/pYxssLllTyt+iRUTWQMU+rjOqJ3rcktsKOkWqx5VId6noyLSNA==
X-Received: by 2002:a17:906:4e4d:: with SMTP id g13mr11417959ejw.11.1554582531102;
        Sat, 06 Apr 2019 13:28:51 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id d23sm4668889eja.42.2019.04.06.13.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 13:28:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com> <CACsJy8CmkFNv7Fy+rSY0Q=1DhYSrpSfU=XEpSS6QRLASJtsVew@mail.gmail.com> <xmqqmul5e9y0.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqmul5e9y0.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 06 Apr 2019 22:28:48 +0200
Message-ID: <87d0lyanen.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 04 2019, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Apr 4, 2019 at 5:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>>> * nd/precious (2019-04-01) 1 commit
>>>  - Introduce "precious" file concept
>>>
>>>  "git clean" learned to pay attention to the 'precious' attributes
>>>  and keep untracked paths with the attribute instead of removing.
>>>
>>>  Will merge to 'next'.
>>
>> There was no conclusion from the last thread if I remember correctly
>> and I kind of gave up on it. If you want to include anyway, should we
>> go for a more specific attribute (e.g. "clean") and leave "precious"
>> for later whenever it's better defined?
>
> I'd rather pick between (1) using the final name for the concept we
> want to eventually achieve, i.e. "precious", and starting small,
> i.e. "initially, only git-clean knows about it", or (2) doing
> nothing.  Per-command 'precious-this', 'precious-that' that would be
> left as interface wart for years is not a pretty sight I want to
> see.

I think we shouldn't squat "precious" in general without seeing where we
want to go with it, which I tried to sum up in
https://public-inbox.org/git/87ftsi68ke.fsf@evledraar.gmail.com/

But aside from that larger discussion, I see no problem with having some
"+clean" or "-clean" attribute with basically Duy's current patch in
nd/precious with the equivalent of "s/precious/clean/". Duy suggested
this in
https://public-inbox.org/git/CACsJy8C377NmLv9edNYjinKAQf-P1y5+Nwhdj3vRkz_E_=
_x43Q@mail.gmail.com/

I see the desire to keep some untracked stuff you know about as
different from what amounts to a workaround for merge/checkout
inadvertently stomping on your checkout and shredding your data, without
(as noted in my upthread summary) us having the full picture of whether
that's even needed as a permanent configurable workaround, or we could
"just" fix that "bug".

But on the subject on the implementation of nd/precious (assuming
s/precious/clean/) I'm concerned that this "I want to keep *.o on
'git-clean'" use-case leaves us with no way to do what you can now do
with:

    git clean -dxff

Now the git-clean documentation promises:

    "Cleans [...] files that are not under version control"

And, for -x:

    "Don=E2=80=99t use the [repository's] ignore rules[...]This allows remo=
ving
    all untracked files, including build products"

Except now we have a feature that's ostensibly exactly for this "build
products" use-case, but doesn't yield to the -x option, which we've
documented as being the escape hatch for exactly that sort of thing.

In my mind "clean" has two fundamentally different use-cases. a) I made
this repo and trust its .gitignore file b) I didn't make it/don't trust
it and/or I just want to be guaranteed to get the exact same checkout a
"git clone" would give me.

Now you can do "git clean -dxff" (and if submodules init && ...) for
"b", but the "precious" patch in the current form completely breaks "b"
to satisfy a use-case of "a".

I think we should at the very least have a "-xx" like "-ff" now as an
escape hatch, but more conservatively shouldn't be breaking the
reasonable assumption a user of "-x" could make so far, which is "ignore
repo config, just wipe it all".
