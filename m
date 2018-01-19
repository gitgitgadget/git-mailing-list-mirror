Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA64C1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbeASR5L (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:57:11 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:41499 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755899AbeASR5J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:57:09 -0500
Received: by mail-it0-f50.google.com with SMTP id b77so3078426itd.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kcP7se02iLdfvN3MEvGS4HrP48xY7Gx55azf11T3SCM=;
        b=JRbUpwc7Nmt5XnwQBxZaQec3cpLfzbqdSG8Cq/hi4pgQVwYJUJs8xxP0/j9sOb+c27
         HKXGNOXsbPHj2SBx+7JWeY+CKQYVZ2cchQEEkjuzYRnf4X9WZcv+2kAndcTFTb/qFASY
         hJW/YHL8RLoxgbNbqCdh0SHZ6UFqJrcprmJyLYOovCOMskPtq/ifxAlikw+qsPiYrhOi
         Qyn33qyhqZY16BHgBk5oRvd8JlTxdNfJc3KqqE9VhAWtGi5ueq8VU/03jQqpn1WbIuDe
         Bic/SlwBJ0DEJBwRBrYw98lX7zO+5GywvYY8Nuz6iSVDMG8IP2xb1+QW7uHmDrm/Z+b3
         Uzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kcP7se02iLdfvN3MEvGS4HrP48xY7Gx55azf11T3SCM=;
        b=J1w7UzQCzq4QawkCfZZyuiHFsdoDYftEu63ifYSoPl8qOdiT8ulS0DJVP4fCiY+wqC
         hw6qLt1AahpE7M2tUv/BI5XIs+gzH5PzLiHJH9+uoCQztZajEOXnE3DmOsvRYrdHmGJJ
         UY2zKGaBihkiJyx1pn2Js5Bf5cnBStc4Hvp3wChEhIxBsUoVH8/Audo8xcUeSNPg6HKT
         Hu8YDacDhucQmAmADY6lO1mIn8OIqbfJ+TZH1WQ8rmG6VlpE5ecZ2ixlwF0bTStGDDth
         ouotuNX0AcbRYksdV3MfwCX04Tjudh6xN53P9vN92Z7Wk31Y1RtpcdbuV7pHtGpbaCq8
         Eo6Q==
X-Gm-Message-State: AKwxyteagkSHjgeBHt/0nP9TmM/nXrqfno/80msVBIZv5MrBv5QYFvSC
        6c742gReGHJU0kmVARFmjCG5RpqGPVPFxbhFyOpvLA==
X-Google-Smtp-Source: ACJfBou0bKlrHOnPkUZRLvJlWfDHbl4q9mtVUNztusiCg6SZOd73RAkbNGQBpylwigbybH1pZqworMmssFHQ/ZTHPH0=
X-Received: by 10.36.137.84 with SMTP id s81mr5454781itd.75.1516384628952;
 Fri, 19 Jan 2018 09:57:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.201.204 with HTTP; Fri, 19 Jan 2018 09:57:08 -0800 (PST)
In-Reply-To: <CAL21Bmn1yk_Cw11umpYf7X96JfmguZO48d8QHnx8tXwqT09aiw@mail.gmail.com>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
 <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com> <CAL21Bmn1yk_Cw11umpYf7X96JfmguZO48d8QHnx8tXwqT09aiw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Jan 2018 18:57:08 +0100
Message-ID: <CAP8UFD28TwpNgaVyyNuO4qZHnk8ajj53TnVCw9SxHrUAV03_HQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 6:22 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> 2018-01-19 20:14 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>> On Thu, Jan 18, 2018 at 7:20 AM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=
=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:

>>> And another thoughts here - we were thinking about creating format.h
>>> but decided not to move forward with it, and now we are suffering
>>> because of it. Can I create it right now or the history of commits
>>> would be too dirty because of it?
>>
>> It would also make it difficult to refactor your patch series if there
>> is a big move or renaming in the middle.
>>
>>> Also, do you mean just renaming of
>>> ref-filter? I was thinking that I need to put formatting-related logic
>>> to another file and leave all other stuff in ref-filter.
>>
>> Yeah, you can do both a move and a renaming.
>
> Thanks for a response! That thought is not clear enough for me. Do you
> want me to split ref-filter into 2 files (one is for formatting only
> called format and other one is for anything else still called
> ref-filter) - here is a second question by the way, do I need to
> create only format.h (and leave all realizations in ref-filter.c), or
> I also need to create format.c. Or, just to rename ref-filter into
> format and that's all.

Just renaming ref-filter into format (including the filenames) will
probably be enough, but it's also possible that it will make more
sense to keep some code only relevant to ref filtering into
ref-filter.{c,h}. We will be in a better position to decide what we
should do when the migration is finished.
