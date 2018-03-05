Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627731F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeCEVSg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:18:36 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35042 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCEVSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:18:35 -0500
Received: by mail-ua0-f193.google.com with SMTP id c40so3010904uae.2
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QiYNW+U8RueSCym2IHk6hQY4o96mrxmDa7ZkS/ntl5U=;
        b=UoSuDwhky030y1wfe69dU6kZMDiSmfau3EvEBZBwy4S23uOOeR1+Iczkt9yv4yDx8O
         HtO4kPB36ZB2oA8nZgt0FqMSx7bclWluyfaViyn68CauoIflUpJXeaGl35xJyrFvJsH+
         TxG0px/bq23W2DsJvmgfG12PKoNH/yGvjcaCWt+xvToiN85pPqW6KsQrVIBxTyufIioV
         ZEI1CCznjY8u32wkzkBYh+VaG5SyKKmIUFwaZPgS65MFuToT3ymzTcDCHQhjdBPYRM4e
         OxKZ0gFJg6PHPlCTcVMmkUmDW1VxZbkLDhp4G/c5w+Ch8+X/o5rTvD8W6B4CWlkjSBRa
         x//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QiYNW+U8RueSCym2IHk6hQY4o96mrxmDa7ZkS/ntl5U=;
        b=oO6Xtbeh8dwF2Ey1163kU/3ryNISaMP0i9PivfWPyCLGj4tS+vgVeJHNEWCBLrFmNn
         tDnecPaOD7wcydHBwPsBhHxAcL/Sci/KZcYZinxy4irKZGJTc8GfhBZoGfgh4VHX1yDC
         GeuICwTv3hdP3e7uMSLN5bo/HRi5VtcSUYUfxhWzBNTQHlKko74QrwKdMkHc4N9/Etw3
         CHSyAxIOgADKcRZf8OJ5qh+/P/UQB0m+ayke+W/Ldu85sCI656/+XygjfuF/zuP7NsXO
         6YgQlaqSzn6xHFJOOtoYnnbDjY/cJGGZv2enocENv8A2Ir80bq+gZ5QhP4+snj0SQ7pL
         2vJA==
X-Gm-Message-State: APf1xPAxxAfUei9umYJgQI+x9z+BOu13vvU9z6zEfHElOi1SJlX8qcrF
        g959L0oq5r8IExUWUXvxwuZFI33m8CY269N/TmQ=
X-Google-Smtp-Source: AG47ELsLEW+i5a5coJdUfkaUMda1z33X/BiGPHCikIMoeVXpOx5ydVJr2ECLE7sEYsKSqcHoa+uoUHjeT3FoBvp2moY=
X-Received: by 10.176.69.204 with SMTP id u70mr11757693uau.39.1520284714912;
 Mon, 05 Mar 2018 13:18:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Mon, 5 Mar 2018 13:18:34 -0800 (PST)
In-Reply-To: <20180303071259.GB17312@sigill.intra.peff.net>
References: <20180223233951.11154-1-szeder.dev@gmail.com> <20180303071259.GB17312@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 5 Mar 2018 22:18:34 +0100
Message-ID: <CAM0VKjmaL16M87SVt9xh3nrHBT49Gygr7=9RqvfxA6E9D6OzmA@mail.gmail.com>
Subject: Re: [PATCH 00/11] Make the test suite pass with '-x' and /bin/sh
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 8:12 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 24, 2018 at 12:39:40AM +0100, SZEDER G=C3=A1bor wrote:
>
>> The first patch is the most important: with a couple of well-placed file
>> descriptor redirections it ensures that the stderr of the test helper
>> functions running git commands only contain the stderr of the tested
>> command, thereby resolving over 90% of the failures resulting from
>> running the test suite with '-x' and /bin/sh.
>
> I dunno. It seems like this requires a lot of caveats for people using
> subshells and shell functions, and I suspect it's going to be an
> on-going maintenance burden.

After finally figuring out the redirections in the first patch, I was
quite surprised by how few failing tests remained.  We only gathered 28
such tests over all these years; if it continues at this rate, that
probably won't be that much of a burden.  And the second patch provides
an escape hatch, should it ever be needed.

The current situation, however, is a burden much more frequently,
because the idiosyncrasies of TEST_SHELL_PATH and/or '--verbose-log' pop
up whenever trying to run any test script with '-x' that has such a test
in it.

I think this is the right tradeoff.

> That said, I'm not opposed if you want to do the work to try to get the
> whole test-suite clean, and we can see how it goes from there. It
> shouldn't be hurting anything, I don't think, aside from some
> mysterious-looking redirects (but your commit messages seem to explain
> it, so anybody can dig).
>
> Does it make descriptor 7 magical, and something that scripts should
> avoid touching? That would mean we have 2 magical descriptors now.

Tests can still use fd 7 as long as they don't intend to attach it
directly to that particular git command that is run inside one of these
test helper functions.

I settled on fd 7 because that fd is already used as stderr for the
'test_pause' and 'debug' helper functions and it isn't used in any of
our tests.
