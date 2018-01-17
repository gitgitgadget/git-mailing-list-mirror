Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25291F406
	for <e@80x24.org>; Wed, 17 Jan 2018 22:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeAQWjU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 17:39:20 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:43011 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeAQWjT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 17:39:19 -0500
Received: by mail-it0-f42.google.com with SMTP id u62so11169124ita.2
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZQ/ZNS5QRhpzmxa5SC0lD6d0fWydq6IzsvkS7lSJbxU=;
        b=rNZU0qfneav6JZo57KaA45V3vyHiN3swspYpIEuwkXnWv7g1tN7+7W4DRXbX9evf7P
         fGaZgPL74nNe7SXTj6R96A0Mp7Diy5hNa8h0wXHa5znbZULUd2At8YXOBjHAV4CoJ1UI
         7ikxobjNP0g7dvVAK6MstPHbAutpyjNc3iuR/+bXbScpZdMY3CEZyV++vSMZ85/i9Yw3
         O4jF3NPVp0mQ2VN2Pn4OcVYUbrOAEUGc77QqXy2DF7vBoBZMAkltMq3ZJGWh9BdXgAaO
         7/izcGC8muYn0yTs4WXQ6WC2y9JBMtJJCJmlf3lILn88zOPGYXiolwbslSD7Cf0w5tWS
         QQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZQ/ZNS5QRhpzmxa5SC0lD6d0fWydq6IzsvkS7lSJbxU=;
        b=oz/EqeoEOevlr5ejMxtV9TCSrSl8RAU4ymgd6uZgc4+pioIYDbrmGmb1rQ6Cfvzl79
         VwGsDLgrqfhuaZE/kWj0x1EeLu02Wq6J4atRyNqEAJJEPZuB/gROyvELH/61Da+yEFC+
         aPRdY+b2DsZodM7VaoR435+BE6inYYxcco2Mkh9VNaQ61MbYxUvMGzQH2HKQw+PTvLe/
         7wvT+xKE54qoSAsVdLkjo/iENbGqb2ncw4yHxH/YgpmB/C4DPljYPg7mC89E/LFuc/Lm
         MxUTY0tirteWds7e9QKghYPfp2M0Kpzgj918N1wBRRzcViuOnfphYemjOFEjpEnM17me
         SdWw==
X-Gm-Message-State: AKwxytfWyUqs3UvFP12+68CK9xlkKdKpOsbXyu0Z9h3z8F9Di7dLZ1yB
        bA3WCnFZBvUqXthvtQziuC0NVfldn6HQfmEUfUA=
X-Google-Smtp-Source: ACJfBosmPc1gYMFtHjwVotgJmmwvzrSevEqBU3UxkZjyQm9lovdsyNGfZEZixaydb8Gm6x1HLoMPe+PETX7KKUjh4cI=
X-Received: by 10.36.101.2 with SMTP id u2mr17007883itb.55.1516228759000; Wed,
 17 Jan 2018 14:39:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Wed, 17 Jan 2018 14:39:18 -0800 (PST)
In-Reply-To: <20180117214354.GA13128@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 17 Jan 2018 23:39:18 +0100
Message-ID: <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 10:43 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 16, 2018 at 09:55:22AM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=
=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>
>> > IOW, the progression I'd expect in a series like this is:
>> >
>> >   1. Teach ref-filter.c to support everything that cat-file can do.
>> >
>> >   2. Convert cat-file to use ref-filter.c.
>>
>> I agree, I even made this and it's working fine:
>> https://github.com/git/git/pull/450/commits/1b74f1047f07434dccb207534d1a=
d45a143e3f2b

(Nit: it looks like the above link does not work any more, but it
seems that you are talking about the last patch on the catfile
branch.)

>> But I decided not to add that to patch because I expand the
>> functionality of several commands (not only cat-file and
>> for-each-ref), and I need to support all new functionality in a proper
>> way, make these error messages, test everything and - the hardest one
>> - support many new commands for cat-file. As I understand, it is not
>> possible unless we finally move to ref-filter and print results also
>> there. Oh, and I also need to rewrite docs in that case. And I decided
>> to apply this in another patch. But, please, say your opinion, maybe
>> we could do that here in some way.
>
> Yeah, I agree that it will cause changes to other users of ref-filter,
> and you'd need to deal with documentation and tests there. But I think
> we're going to have to do those things eventually (since supporting
> those extra fields everywhere is part of the point of the project). And
> by doing them now, I think it can make the transition for cat-file a lot
> simpler, because we never have to puzzle over this intermediate state
> where only some of the atoms are valid for cat-file.

I agree that you will have to deal with documentation and tests at one
point and that it could be a good idea to do that now.

I wonder if it is possible to add atoms one by one into ref-filter and
to add tests and documentation at the same time, instead of merging
cat-file atoms with ref-filter atoms in one big step.

When all the cat-file atoms have been added to ref-filter's
valid_atom, maybe you could add ref-filter's atoms to cat-file's
valid_cat_file_atom one by one and add tests and documentation at the
same time.

And then when ref-filter's valid_atom and cat-file's
valid_cat_file_atom are identical you can remove cat-file's
valid_cat_file_atom and maybe after that rename "ref-filter" to
"format".
