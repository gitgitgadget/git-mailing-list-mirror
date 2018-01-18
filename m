Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10141F406
	for <e@80x24.org>; Thu, 18 Jan 2018 05:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbeARF4p (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 00:56:45 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:35381 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753433AbeARF4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 00:56:45 -0500
Received: by mail-qt0-f172.google.com with SMTP id u10so27601288qtg.2
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 21:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yO4PFcKjTWGDwj0gTSSPwftC0BjAopXTAesgNPHmx08=;
        b=CDZbtlmudcb6IoVqmgMS3UrDkEMWuKeV+Oi7Dc4YF7TXHybMZTODVRVOjo6JUZ0rQ6
         osc/J2tibawO6mtQr2LIHyRtGJKEUZ4VUwWr6SnzCPXOzDhJtiWELdv3Q4HV3ANosGBr
         wPFf/SpDPON8pmu2tSI/6cbWW8L1CNjCjf0l0BB9idMHCD+CQvwXNLnPO7yVeHyJi97V
         qdkOjUcsSiB3wBnqR1d5xv7PVHFTtq8Nd6tzR75zjQScp9/+/fxxXdkBqkUFYNZA1CfC
         uSj6EKEwCu05LN4as+s/ebHcmWO2TfsCEukZHVvpof8tAS6uslqJ53apZI658O+dA9ZF
         YhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yO4PFcKjTWGDwj0gTSSPwftC0BjAopXTAesgNPHmx08=;
        b=kz0Hq/sJ/DkBehGc95UJ0mXkaZJCSKFDzKoQZ34RcTeLa49t84bJKnR8t0lBfi12Zw
         Gqll5xPz1+SRRw1nigbmdTKr8zIGjDvFDLoxWmaxM92ot/wjtUNeZWjnZptUSiiv2OJd
         W+MpLsq4J5qk8ZN0kgZ8w54nE3JhZFdQqnOSYqY56A+5gVJbuw9Img5BRjkgRnmEqugL
         Glckpb4c0dQ+QFaN7ODfIBKqL5Cnypzofmmwe4Tr8vdOeIhmmM/s1m0D793cLodTUIxT
         4miEvTB5rrE6EYlzC5afdVD5QEKR5gf/1jNVsMVDJVlr8GVuHp0OFBrQ9T+3uiBeQxbZ
         0bfw==
X-Gm-Message-State: AKwxytegIVWE5PzXFKEuuD76E/qqoAwx8F/554ZzTnn4K1FZGyFutlRn
        c8ZxwLvXYWLSVcLhY4/0lYskxRoHNJLnAmf+9mtYFQ==
X-Google-Smtp-Source: ACJfBot1Whg6hoKskUlZAEdDetmgSTHUfdNoYvF4oGlLDpyHdhi0l5AiHvRhc/QWDM9LPGDS2RNZ7bIYNzqa6iRjl8k=
X-Received: by 10.55.104.1 with SMTP id d1mr9597239qkc.71.1516255004278; Wed,
 17 Jan 2018 21:56:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.146 with HTTP; Wed, 17 Jan 2018 21:56:43 -0800 (PST)
In-Reply-To: <20180117214515.GB13128@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc532-75f3ef78-26cb-4751-9ded-eb0e8d23833b-000000@eu-west-1.amazonses.com>
 <20180115214419.GE4778@sigill.intra.peff.net> <CAL21Bmm0u4NgnPZMOh8PZqQ0is3inANKmCAr7MTaQHVyEOO7XQ@mail.gmail.com>
 <20180117214515.GB13128@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 18 Jan 2018 08:56:43 +0300
Message-ID: <CAL21BmmZ1aPFS-=ctXH3p40o6CAQR3hWS6AXRB8061kE4h22uA@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] cat-file: move struct expand_data into ref-filter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-18 0:45 GMT+03:00 Jeff King <peff@peff.net>:
> On Tue, Jan 16, 2018 at 10:00:42AM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=
=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>
>> > I think some of these will want to remain in cat-file.c. For instance,
>> > split_on_whitespace is not something that ref-filter.c itself would ca=
re
>> > about. I'd expect in the endgame for cat-file to keep its own
>> > split_on_whitespace flag, and to set it based on the presence of the
>> > %(rest) flag, which it can check by seeing if the "rest" atom is in th=
e
>> > "used_atom" list after parsing the format.
>>
>> Yes, maybe we will need to leave some part of expand_data variables.
>> But, if it would be only "split_on_whitespace", it's better to make
>> just one flag without any other stuff. Actually, I thought about
>> moving related logic to ref-filter also. Anyway, it's hard to say
>> exact things before we code everything. Do I need to fix commit
>> message and make it more soft?
>
> Yeah, I think it might just be split_on_whitespace, and that could live
> on as a single variable in cat-file.c.
>
> I don't think it makes sense to move that part to ref-filter, since it's
> not about formatting at all. It's about how cat-file parses its input,
> which is going to be unlike other ref-filter users (which don't
> generally parse input at all).
>
> -Peff

OK, I will leave split_on_whitespace in cat-file for now. :) There are
so many places that are more important now, in my opinion, so I am
planning just to leave this variable and do other stuff, and I will
return to this question later.
