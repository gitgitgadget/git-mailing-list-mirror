Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8EE1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 16:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbeKGB07 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:26:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36473 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388863AbeKGB07 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:26:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so12491284wmf.1
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PF/TSvkKXxLACNvvhVWUb5JHM8s7l3/uOe7xguyYa/k=;
        b=YwrDg0k4i5KiQGuskawyMaoYyP/kurkgrHOsZpMqepI6sVRdlbCQ7pWH9YGVoivLQU
         P+jM4aI1hI0ye7z+z/DtfNDl59fn2b+84WZtE5KxElugEuHPFYsbND/msMNB/8tgC19o
         o1PSh02oQcLuqjHNo4+uoW0IalaUmoXr+eG+WLm0swpKfS3EhvLkiphKDwKnOwuK2BWe
         WSFJbHXyAE+xZLFmKSZGhlcJARNDojWLHZoY4wu3F1ebdto/aFWdTXB5pV8PDSkNcJPq
         yt5ZR1lBNR1NncV/xIJLDZbyM89ro6nOBODoi4m6898Dfbxq/trXpB6cHeGFB/5hv6au
         Zmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PF/TSvkKXxLACNvvhVWUb5JHM8s7l3/uOe7xguyYa/k=;
        b=kmgyy2w908lvaEzCB7Muskbdlp/mP53PAlYO4ScbyG04qk/5D54zrPnWgdjifDrzDl
         QQitEu3134aLat64ZiPby1iT+fRwNxWHhuzgUxn6fZa/3Ntl9w8kXr8oQ3mNVmIaBBhe
         fJXRYTjwCAMdd9AQ6x6bTfcbgK4B6tVMJf2mB/bdBYeC0WUTOvp8IqwaCzniJRE0gG7a
         fuiZNbiOZcGTG0HX5MuL2Ef5iIH2XA2mNgLXp02iTIIcZ9tpPgvV9HxLOj2hSG71CErT
         WvbKv/qA6Gyw5Pzn6p2NfPM69Ru+PgyFpRGVAlgVbgW5eUFQHVfJE9GAzujH+XTryivN
         Uu2Q==
X-Gm-Message-State: AGRZ1gLlQ7x8ui2HyfvTZKBTVAoNjxQI8N/l8SQIJiYmkoSxVxUux3HE
        pmbvW5gD3q/KmcG0ad9SoEk=
X-Google-Smtp-Source: AJdET5f7etjSq2KrRrJTg97M/OZdAOYAnptTxr4S5gJT1h1R9F246Z0Fc2DKy4DNNaWAyWpZGZ9ZKw==
X-Received: by 2002:a1c:8314:: with SMTP id f20-v6mr2603789wmd.120.1541520065287;
        Tue, 06 Nov 2018 08:01:05 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id h125-v6sm1355783wmf.48.2018.11.06.08.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 08:01:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
References: <20181105200650.31177-1-avarab@gmail.com> <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com> <87efbz6xys.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811061140560.45@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1811061140560.45@tvgsbejvaqbjf.bet>
Date:   Tue, 06 Nov 2018 17:01:03 +0100
Message-ID: <874lcu6vr4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 06 2018, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 5 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Mon, Nov 05 2018, Eric Sunshine wrote:
>>
>> > On Mon, Nov 5, 2018 at 3:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> >> Add a --no-patch option which shows which changes got removed, added
>> >> or moved etc., without showing the diff associated with them.
>> >
>> > This option existed in the very first version[1] of range-diff (then
>> > called branch-diff) implemented by Dscho, although it was called
>> > --no-patches (with an "es"), which it inherited from tbdiff. I think
>> > someone (possibly me) pointed out that --no-patch (sans "es") would be
>> > more consistent with existing Git options. I don't recall why Dscho
>> > removed the option during the re-rolls, but the explanation may be in
>> > that thread.
>>
>> Thanks for digging. Big thread, not going to re-read it now. I'd just
>> like to have this.
>
> In my hands, the well-documented `-s` option works (see e.g.
> https://git-scm.com/docs/git-diff#git-diff--s), although I have to admit
> that the `git-range-diff` manual does not talk about the diff-options.
>
> And for the record, for me, `git range-diff A...B --no-patch` *already*
> works.

Neither of those works for me without my patch. E.g.

    ./git-range-diff -s 711aaa392f...a5ba8f2101
    ./git-range-diff --no-patch 711aaa392f...a5ba8f2101

This is on current next, 2.19.1.1182.g4ecb1133ce. What version are you
on?

>>
>> > I was also wondering if --summarize or --summary-only might be a
>> > better name, describing the behavior at a higher level, but since
>> > there is precedent for --no-patch (or --no-patches in tbdiff), perhaps
>> > the name is fine as is.
>>
>> I think we should aim to keep a 1=1 mapping between range-diff and
>> log/show options when possible, even though the output might have a
>> slightly different flavor as my 4th paragraph discussing a potential
>> --stat talks about.
>>
>> E.g. I can imagine that range-diff --no-patch --stat --summary would not
>> show the patch, but a stat as described there, plus e.g. a "create
>> mode..." if applicable.
>>
>> This change implements only a tiny fraction of that, but it would be
>> very neat if we supported more stuff, and showed it in range-diff-y way,
>> e.g. some compact format showing:
>>
>>     1 file changed, 3->2 insertions(+), 10->9 deletions(-)
>>     create mode 100(6 -> 7)44 new-executable
>>
>> > The patch itself looks okay.
>> >
>> > [1]: https://public-inbox.org/git/8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de/
>>
