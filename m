Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4281F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCPSTH (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:19:07 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39508 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCPSTF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:19:05 -0400
Received: by mail-qt0-f171.google.com with SMTP id v11so3887885qtj.6
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I4v6fc/e6P9uu06zkXpE37v5VirkeH6nhGmAL+y2i9c=;
        b=XbvzfPZhRE5oczF7zWEVKNFbIMJ6WD/MgegAi42EfPFDyOdjwqok7JrCWRtKNMnQm8
         Ux0HvcpPbKjE5pGYnWSP3e6xaNKuxyI/PnSkjeAZhdQ5Fm6kA9XN34agle/Ee8HWoJKA
         JwYQnVDQRS2hK2NJQR31eBXolK1sG5p3xg5CpbPUw/B4Vp9p/mDpRC2fQk9lHukva487
         5KmHI2VISuVp8g3YceoB/lZ9ynj1scb6YTKUQg7IP1gPgYXGGRaG5V/iuqLPQ3chtRmF
         AgPawfBVGoM5vg7Tfe8Eu4qHlbNn325TTSyXJ80plCuE7UNOAhPAvFrdrbGt/V9FvJHB
         vaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I4v6fc/e6P9uu06zkXpE37v5VirkeH6nhGmAL+y2i9c=;
        b=DAQFHcDqNjb235mwncZVEL5h7G4C2FNFtpk6zjN3Jr6URK9+zcm+rQn8CQuqu8rGxb
         8K50tRHJkhPLT7KJZ5Ru95f7cnkMNEgDTwtgHWE1DKJSMTAokW2K39OEDMp+IUX5xtM4
         SiJQlKJfTzFKsRVsu/ZR9rZIwVzl8F7wqfO/fjQ7MS5N04UUla4oazG3YVgfSjKy3rXX
         aVXIOnRLoYIjdQZwApD02+o6d7Kq25iRGcbxZO5wbDZm56wP2SkLsEe8Dc4CGdn5Mq5l
         aI2GKPAp1MmjlwRfeJ+clVaqPQcp5EXLnpETCdmpel+sK5BUD2JAK8YAYbPMO7rWWsOf
         xjXQ==
X-Gm-Message-State: AElRT7GPcAKw21/sMtqw39DoZd963itOpWknhPXjNzuP/73q8d/a/ALj
        /Zn5Bt9QHt/4h4WSN0y5U+sY57uAqamhYwYR5ak=
X-Google-Smtp-Source: AG47ELtL/noga7QjBfJ6tkGDXSSsA2P1JugMPZO1Rhe/DbUzJkMrt8I0XlciqoBjeEjOxO5TJzgdQW5mta0NYhwcwvM=
X-Received: by 10.200.50.174 with SMTP id z43mr4077330qta.250.1521224344800;
 Fri, 16 Mar 2018 11:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Fri, 16 Mar 2018 11:19:04 -0700 (PDT)
In-Reply-To: <xmqqfu4z3o61.fsf@gitster-ct.c.googlers.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
 <20180315225746.18119-5-lars.schneider@autodesk.com> <CAPig+cSvBi1pJYC-DND1_x9rHhmoAPs90B_3Fg53-X5FjtCQhA@mail.gmail.com>
 <328BE614-1927-450A-85D1-7391D0BB5C47@gmail.com> <CAPig+cQpDKHwzjCHpka+v1uGaJNfJGSmXpAVwPWVXSf5F1pR-g@mail.gmail.com>
 <xmqqfu4z3o61.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 16 Mar 2018 14:19:04 -0400
X-Google-Sender-Auth: dSeDlXr2aSSsjznOkGuT8rP-fws
Message-ID: <CAPig+cS2xRPP9P7GZMgkKzE899AQiMkkpNsGeB-MwmAymAzCiQ@mail.gmail.com>
Subject: Re: [PATCH v12 04/10] utf8: teach same_encoding() alternative UTF
 encoding names
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 1:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> However, I'm having a tough time imagining cases in which callers
>> would want same_encoding() to return true if both arguments are NULL,
>> but outright crash if only one is NULL (which is the behavior even
>> before this patch). In other words, same_encoding() takes advantage of
>> is_encoding_utf8() for its convenience, not for its NULL-handling.
>> Given that view, the two explicit is_encoding_utf8() calls in
>> same_encoding() seem redundant once the same_utf_encoding() call is
>> added.
>
> So... does that mean we'd want something like this, or do you have
> something else in mind?
>
>         int same_encoding(const char *src, const char *dst)
>         {
>                 static const char utf8[] = "UTF-8";
>
>                 if (!src)
>                         src = utf8;
>                 if (!dst)
>                         dst = utf8;
>                 if (same_utf_encoding(src, dst))
>                         return 1;
>                 return !strcasecmp(src, dst);
>         }

I am not proposing anything like that for this patch or patch series.
I'm merely asking why, after this patch, same_encoding() still
contains the (in my mind) now-unneeded conditional:

    if (is_encoding_utf8(src) && is_encoding_utf8(dst))
        return 1;

If I'm reading the current code correctly, same_encoding() will crash
when either (but not both) of its arguments is NULL and the non-NULL
argument is not a variation of "UTF-8". If both arguments are NULL,
then it won't crash, but I don't believe that it was intentional that
it should crash for some NULL cases but not others; rather, not
crashing when both are NULL is an _accidental_ side-effect of relying
upon is_encoding_utf8().

If I understood him correctly, Lars's justification for retaining the
conditional in question even after the patch is to maintain the
non-crashing behavior for both arguments being NULL, even though it
will continue to crash when only one is NULL. That justification
doesn't makes sense to me since I can't imagine clients relying on
accidental behavior of sometimes crashing, sometimes not, hence my
question to Lars.

As for your snippet above which ensures that 'src' and 'dst' are
non-NULL, that (or some variation) would be fine if we ever expect
callers of same_encoding() to pass NULL for either of those arguments,
but such a fix is outside the scope of this patch and even this patch
series (which does not require such a fix), IMHO.
