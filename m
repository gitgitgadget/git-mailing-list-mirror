Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1F81F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeKNEpb (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:45:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35049 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNEpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:45:31 -0500
Received: by mail-it1-f195.google.com with SMTP id v11so20056052itj.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93nHcMlEnBcaD1hS9pIsL5X/046RiLWw417P5Q9+6co=;
        b=U6i049N/LUeP9Z+Ms/BLd0WXax+4IQM8jRfa00EuGcw3j/1S224VMLBDxv91tiaE0q
         FEjSs0GLgzL0m94rYI++iD9lUhUFOgPeQVPgMgtBWBjs5zaOnefcX6g8MvqUaONSsvBE
         SpFhZ5of2hvRqcl3wc6Xzu9u7EZO6cuiM1PjW1P865mGBCqyC3JOtORoRQIMlAvJS/cQ
         Hi5sNQIL/AaL1IRUvJKi7VburN6UwvolX/hx8fjaikDsBDvAexZ/EXxJYG8R3r/1iufX
         kOJ1UGIKAjtd6tzx3I2dn+XDVay+5B3IShZ5uOWTZgR52JISMmUd8J41dyOrHSImHRVt
         nMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93nHcMlEnBcaD1hS9pIsL5X/046RiLWw417P5Q9+6co=;
        b=Ppcts1P4y4BA7taW4DuH5wMVsoeTZ47iAeALVo+T0gXVxQKeuWi9DbRl0eh43TTpcb
         vldXLM/wnsgYFXIkiRdBnMnRnM+BW7I3WQswbCGNRHj/2SgEeP9HlVoeg2IcSY3LXs7B
         ojD07CghxzJv5/Aa1tzIG7s9VdHVp1Neu+s5L+pvdJdK/ia+UGdZoCvDtNQxXWuqRP6m
         sAaqtL2CNTXJDs2QGh/HIAhwQCartxEOhW9G215GWbJcqOA6HqvIqChC9MszqBgnhabv
         P0qVHxjWj+EKT7RPB21vRGCTExnVV21nifwQAlW4JLYmV3oWzvq9glk/uB69SbuMVE1S
         xAew==
X-Gm-Message-State: AGRZ1gKNCcQb5q99xHX2M4AO0W7Cb2WgSvahQM+24q5PIZWkqYi/+lfh
        t+tAP9GAEgVdpCr5EoZokPgFQcrWv5xJqUEj3G66Lg==
X-Google-Smtp-Source: AJdET5cMkpSve3ZrBf9PJZFHi6a4pOxopyA+cBuc4r6w4+CucT6Cd5zjKR1NRO5pHWKmwnv5aIn+FqeGhYQLJN+ND5Y=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr5541070jak.30.1542134768177;
 Tue, 13 Nov 2018 10:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net> <20181104234458.139223-3-sandals@crustytoothpaste.net>
 <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
In-Reply-To: <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Nov 2018 19:45:41 +0100
Message-ID: <CACsJy8AtWG=3nJuqG07seczqeb8taimzT4fPbFHc-_3Y8FE_5Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] sha1-file: provide functions to look up hash algorithms
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 7:42 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/4/2018 6:44 PM, brian m. carlson wrote:
> > +int hash_algo_by_name(const char *name)
> > +{
> > +     int i;
> > +     if (!name)
> > +             return GIT_HASH_UNKNOWN;
> > +     for (i = 1; i < GIT_HASH_NALGOS; i++)
> > +             if (!strcmp(name, hash_algos[i].name))
> > +                     return i;
> > +     return GIT_HASH_UNKNOWN;
> > +}
> > +
>
> Today's test coverage report [1] shows this method is not covered in the
> test suite. Looking at 'pu', it doesn't have any callers.
>
> Do you have a work in progress series that will use this? Could we add a
> test-tool to exercise this somehow?

Going by the function name, it should be used when hash-object or
other commands learn about --object-format=<name>.
-- 
Duy
