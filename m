Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A796A1F406
	for <e@80x24.org>; Wed, 17 Jan 2018 23:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeAQXEN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 18:04:13 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35295 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeAQXEL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 18:04:11 -0500
Received: by mail-it0-f66.google.com with SMTP id e1so11209368ita.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EgC8KLgDeGM6rlcmcojfe3H3Nbhib4ZlEe6Dg5BEwfs=;
        b=lDeHgAAS2N2iyTAZcrfHFJBxZ9964Xep42EZyDrOogAMpmDjxe8iMwBhnRUqzjel8x
         CEjlr6B5rvHELbMYcUOZDKXmhRqK45wKu9AowW8jPDUpuwB/fGhiigrgho6RodUMX8OM
         t/JLcCZU3OQYAfIYDViFNjYVXdX9eFolvOcYOR1a2WWRuPY+enHhOtLGL8vNirzw6atu
         2akB3oupuHaYZMtH0YcZbYFqx7Ldp9T0W2B42FnGo4/NXKxcVAcWgD7TbJcKelZrjB3P
         V0F+w7kRE8jHDmyCSD3yK14m/xvfrAZ0OMGDrovsOb0M7cpucWK1QecOsiNAuyoaK9wN
         Cy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EgC8KLgDeGM6rlcmcojfe3H3Nbhib4ZlEe6Dg5BEwfs=;
        b=JiKTIvzw9PlzYBDTBtJ5Svo6cFctXmB7meVTePtUICraoHciWD3ojzEXWaGsTVkrfy
         iU9u4t5933HWerktCpgbu/pQe513VOmEeKusdcJzEtDziGiMJgUZqhx4hxkZ7UEXOjCt
         mLER8uQlArfEg9RTmt5FTaBNkqE8ODrI4rg6wHagHl9mzftFky4CD44h4Bp4OGa+BaSK
         2fipmzJxyMsBndAW7H1APVoztiAR1kWVJBnAkTzyGIP77RgN82UrdIpypfBxBjYst8Jt
         TbGbWdWGXK3QZpsD+wSu4ncr8WkP3e86qIilTD2L+BFXnHWiZkpJUrBAD9pEHyvD8jUA
         HjXw==
X-Gm-Message-State: AKwxytfXEm4NmaK5Q2jo0fmzY4a9jIWO99fl+a77oVzlOOTfkaMxW1XL
        m9To3SPagAQM6Rt47Y1ka1HyMd188rR6A6E04Ac=
X-Google-Smtp-Source: ACJfBou1qb/qb3WSaHGtRJmtpNdb9MGl6UR6JF8a82Yx4GHJX68Sr3NHLXjPHvvft0A+HgwVN5hJomhRoyJfBWkybZg=
X-Received: by 10.36.84.205 with SMTP id t196mr15033130ita.128.1516230250814;
 Wed, 17 Jan 2018 15:04:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Wed, 17 Jan 2018 15:04:09 -0800 (PST)
In-Reply-To: <20180117214906.GC13128@sigill.intra.peff.net>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <20180115213335.GB4778@sigill.intra.peff.net> <20180115220946.GF4778@sigill.intra.peff.net>
 <CAL21BmmmX5-uisj+_=sDHwJO=fpXc41Wriw+uuxtR=gOio-HZQ@mail.gmail.com> <20180117214906.GC13128@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 18 Jan 2018 00:04:09 +0100
Message-ID: <CAP8UFD1hnP3yab-qDKPkNcj5VadUD_HW5+V1e2nwPAB8r31zoQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 10:49 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 16, 2018 at 10:22:23AM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=
=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>
>> >> In other words, I think the endgame is that expand_atom() isn't there=
 at
>> >> all, and we're calling the equivalent of format_ref_item() for each
>> >> object (except that in a unified formatting world, it probably doesn'=
t
>> >> have the word "ref" in it, since that's just one of the items a calle=
r
>> >> might pass in).
>>
>> Agree! I want to merge current edits, then create format.h file and
>> make some renames, then finish migrating process to new format.h and
>> support all new meaningful tags.
>
> I think we have a little bit of chicken and egg there, though. I'm
> having trouble reviewing the current work, because it's hard to evaluate
> whether it's doing the right thing without seeing the end state.

Yeah, to me it feels like you are at a middle point and there are many
ways to go forward.

As I wrote in another email though, I think it might be a good time to
consolidate new functionality by adding tests (and perhaps
documentation at the same time) for each new atom that is added to
ref-filter or cat-file. It will help you refactor the code and your
patch series later without breaking the new functionality.

> So what
> I was suggesting in my earlier mails was that we actually _not_ try to
> merge this series, but use its components and ideas to build a new
> series that does things in a bit different order.

Yeah, I think you will have to do that, but the tests that you can add
now for the new features will help you when you will build the new
series.

And hopefully it will not be too much work to create this new series
as you will perhaps be able to just use the interactive rebase to
build it.

I also don't think it's a big problem if the current patch series gets
quite long before you start creating a new series.
