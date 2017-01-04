Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B9820756
	for <e@80x24.org>; Wed,  4 Jan 2017 21:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759098AbdADVqc (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 16:46:32 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35976 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdADVqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 16:46:30 -0500
Received: by mail-lf0-f67.google.com with SMTP id j75so2124589lfe.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 13:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ZNFZVh+8dXydxM5FfYHwk+KuwEyBo1FyDUnG7RR0hg=;
        b=Zy/yucm5sT7+WJ6ZBqiwDBFybRU/ksMis5+XLpgTbOmazXR5J2L7tm148zmVDSkReX
         3QfzVAT2buqv4bY2TRnEltAzT7SaoOJF7fowJ4ZUUd7d5l1pTmcj8Skeid4YIvo60IlS
         NniTKyinZPbvMT3dRqpP43d22bWv6BwX+16vTQRBh+PrTzJKNumoEu4b2muZmZVdzF4d
         D0Y8mEEsrFdSgBcCPJwiC1/o2tuyiQViD1SDhRVjTkBU9lBJCYElYTlsWowOlmH2xiBw
         sSLaS5Ocq8QB2CPXs7qaKflGWure5yOxi2/GaxGYVLut73j5NOVpOW/Ch28dZz1IBjHm
         hX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ZNFZVh+8dXydxM5FfYHwk+KuwEyBo1FyDUnG7RR0hg=;
        b=lLisDuDtp1JdogUoliqrP4qCAN8+0S/bbJLM508asEsRFnq1EmO35DoBfcXTcnwLvf
         gqAd28Mq0iX5fFCgZfcX0O0yQK17sUfuxVx9iIY7or+tgC6WZyAM1uhjCtgzQTWuJ814
         I5WK2IcNBc4B1RS7nwmls5i3KjqIbB4aPdvPHusg0coYNgEU18ctiqgS+wMeucxGu0nw
         6Vttne3+e9Xr+/wf7gWkuA7Vw6/cHSMbEtcdO7XHbt/faiN0UyY1RvvII0447i4V+eb/
         Yw+c1SLmbCcjdgpso/ykmnImXdfV24+LqXmFCihcBbQfCulpb6USjgDCtT83hLz7PbrR
         lCGQ==
X-Gm-Message-State: AIkVDXIm1cSn4F9lws8nI0diS42CDuYX8OjDLjazyNCEwFIy8hdpC5xpDUKsy3/WdBlT4OtUwJL5hAq6AnvbqQ==
X-Received: by 10.46.14.9 with SMTP id 9mr23089471ljo.59.1483566388741; Wed,
 04 Jan 2017 13:46:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Wed, 4 Jan 2017 13:46:07 -0800 (PST)
In-Reply-To: <CAGZ79kbdNuGe038Wb9OR1SKq-XYtsPrLsn6XueO6zsKKGFYiNg@mail.gmail.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
 <20170103190923.11882-1-bmwill@google.com> <20170104004825.3s27dsircdp5lqte@sigill.intra.peff.net>
 <3f9a530c-402f-f276-4721-fa6a8a6fef41@web.de> <20170104070107.huse2a6thz737epv@sigill.intra.peff.net>
 <20170104181318.GC69227@google.com> <CAGZ79kbdNuGe038Wb9OR1SKq-XYtsPrLsn6XueO6zsKKGFYiNg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 4 Jan 2017 13:46:07 -0800
Message-ID: <CA+P7+xp+j1ajPLjE-RukSmp33_bRkD7J65X-++frkYd9LWLSkQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] road to reentrant real_path
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 4, 2017 at 10:22 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jan 4, 2017 at 10:13 AM, Brandon Williams <bmwill@google.com> wro=
te:
>> On 01/04, Jeff King wrote:
>>> On Wed, Jan 04, 2017 at 07:56:02AM +0100, Torsten B=C3=B6gershausen wro=
te:
>>>
>>> > On 04.01.17 01:48, Jeff King wrote:
>>> > > On Tue, Jan 03, 2017 at 11:09:18AM -0800, Brandon Williams wrote:
>>> > >
>>> > >> Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS b=
ack to
>>> > >> MAXDEPTH due to a naming conflict brought up by Lars Schneider.
>>> > >
>>> > > Hmm. Isn't MAXSYMLINKS basically what you want here, though? It wha=
t's
>>> > > what all other similar functions will be using.
>>> > >
>>> > > The only problem was that we were redefining the macro. So maybe:
>>> > >
>>> > >   #ifndef MAXSYMLINKS
>>> > >   #define MAXSYMLINKS 5
>>> > >   #endif
>>> > >
>>> > > would be a good solution?
>>> > Why 5  ? (looking at the  20..30 below)
>>> > And why 5 on one system and e.g. on my Mac OS
>>> > #define MAXSYMLINKS     32
>>>
>>> I mentioned "5" because that is the current value of MAXDEPTH. I do
>>> think it would be reasonable to bump it to something higher.
>>>
>>> > Would the same value value for all Git installations on all platforms=
 make sense?
>>> > #define GITMAXSYMLINKS 20
>>>
>>> I think it's probably more important to match the rest of the OS, so
>>> that open("foo") and realpath("foo") behave similarly on the same
>>> system. Though I think even that isn't always possible, as the limit is
>>> dynamic on some systems.
>>>
>>> I think the idea of the 20-30 range is that it's small enough to catch
>>> an infinite loop quickly, and large enough that nobody will ever hit it
>>> in practice. :)
>>
>> I agree that we should have similar guarantees as the OS provides,
>> especially if the OS already has MAXSYMLINKS defined.  What then, should
>> the fall back value be if the OS doesn't have this defined?  5 like we
>> have done historically, or something around the 20-30 range as Torsten
>> suggests?
>
> As a fallback I'd rather go for a larger number than too small.
> The reason for the existence is just to break an infinite loop
> (and report an error? which the current code doesn't quite do,
> but your series actually does).
>
> If the number is too large, then it takes a bit longer to generate the er=
ror
> message, but the error path is no big deal w.r.t. performance, so it's fi=
ne
> for it taking a bit longer.
>
> If the number is too low, then we may hinder people from getting actual
> work done, (i.e. they have to figure out what the problem is and recompil=
e
> git), so I'd think a larger number is not harmful. So 32?
>

I think I agree as well.

Thanks,
Jake

>>
>> --
>> Brandon Williams
