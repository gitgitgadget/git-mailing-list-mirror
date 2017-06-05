Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561D720D09
	for <e@80x24.org>; Mon,  5 Jun 2017 06:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbdFEGZD (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 02:25:03 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34361 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdFEGZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 02:25:03 -0400
Received: by mail-qt0-f175.google.com with SMTP id c10so18554015qtd.1
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZxxBQ0cFyLUCyXgt1NeK0KoPX6GSjACThDI5HgixjfQ=;
        b=AW7RGv1HIo41Yk70mM1icmDtesbT6VYKepIoERBjvQL5rbPECUzqPRItDvFSztqVPL
         Esd6MFkkEpZaSDCCuWivkKBN3Ae3Un7o1qoUmMUZIqebFXMj8BPS1Nci1m+jJqmTjW2a
         +R0yiDWuEIXJgpp8D6EKv7Kjqil7JVGoDlWgPXkEEpunb5/rcsnkq3VscuV6uIIqaREG
         Fcx7JqYVwAbkN1TKo5hRMpOqcoDTbKEh0fk4SEZVvkGWCXSwpirouCKNlrfR7ADgMWiL
         FO2bKJ1tLP3Wkr7ZIq/FhwbJDg3haJ4FE5M55pPD3AqVy4Am3yAILI+z5LTk046bBMKY
         zwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZxxBQ0cFyLUCyXgt1NeK0KoPX6GSjACThDI5HgixjfQ=;
        b=Faeao8ldVybStXfjL/TlDELoPd2wYb/+AlTxa/JdxG10WcuzgzeUHCJgAsbkjSYAcI
         zz34LytRtRU/7UaletnJh2dDzgaSIv2/GwVWOY8Pk3frXrjM//HsLUOwhqr+1WjRsvMY
         EOyNCICTZ/61MaxoYVmF4RxzoC6N09T8EYUb8aipdc3ZzYpMKi39ZDoAV3k6TnuoLizU
         608xN23I+SjKP7GRU0ZNDNTmYMadv6NoMvubslwGVb9cDPgYDvHOHWaZFi3KXWzEfNQI
         aqtGUCRMZoWf5+Mib03N/I4sSuBqhSte9Y2jQte3JqW58sMnttnEW7wpz4DDNjK5Okxk
         0pCw==
X-Gm-Message-State: AKS2vOwKBeLhq8couOB3DOCJaMdC01ET+4ocmErPNWG9fSPVHHhTB4lJ
        vkoNQ/WQbMq9q3leBbgkUzlB92KySQ==
X-Received: by 10.55.221.24 with SMTP id n24mr2037657qki.46.1496643902324;
 Sun, 04 Jun 2017 23:25:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Sun, 4 Jun 2017 23:25:01 -0700 (PDT)
In-Reply-To: <xmqqa85nur85.fsf@gitster.mtv.corp.google.com>
References: <20170602103330.25663-1-avarab@gmail.com> <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
 <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com> <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
 <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com> <CAP8UFD1u-C-T2X+H8WxxB7O+ajcGfygRBLN0t7+zJcOh_SrvFQ@mail.gmail.com>
 <xmqqa85nur85.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 5 Jun 2017 08:25:01 +0200
Message-ID: <CAP8UFD1LD+FVNvS_bR8KB7TWqmz01+gsyesubu3o0SWJvGAX9g@mail.gmail.com>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 4:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Sun, Jun 4, 2017 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>>> My feeling exactly.  Diagnosing and failing upfront saying "well you
>>>>> made a copy but it is not suitable for testing" sounds more sensible
>>>>> at lesat to me.
>>>>
>>>> This change makes the repo suitable for testing when it wasn't before.
>>>
>>> Perhaps "not suitable" was a bit too vague.
>>>
>>> The copy you made is not in a consistent state that is good for
>>> testing.  This change may declare that it is now in a consistent
>>> state, but removal of a single *.lock file does not make it so.  We
>>> do not know what other transient inconsistency the resulting copy
>>> has; it is inherent to git-unaware copy---that is why we discouraged
>>> and removed rsync transport after all.
>>
>> If we don't like git-unaware copies, maybe we should go back to the
>> reasons why we are making one here.
>
> We do need git-unaware bit-for-bit copy for testing, because you may
> want to see the effect of unreachable objects, for example.

I think there might be different kind of people interested in performance t=
ests.

Users with existing repositories might want to see how the different
Git versions perform on their real life repos.
Developers might want to test Git on different repos with different
characteristics.

For example some developers might want to test on repos with and
without a lot of unreachable objects, to make sure that the latest
changes they made improve perf in both cases. While some users might
only be interested in testing on their actual repositories to see how
the latest Git versions improve things (or not) in practice.

In this example the needs of developers would perhaps be better suited
if they could control the amount of unreachable objects in the tests,
while the needs of the users would be better suited if the tests just
used actual repos as is.

So I wonder what changes would be needed to the perf framework and the
perf tests to accomodate both of these kinds of needs.



> It's just that git-unaware copies, because it cannot be an atomic
> snapshot, can introduce inconsistencies the original repository did
> not have, rendering the result ineffective.
