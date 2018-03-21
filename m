Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154891F404
	for <e@80x24.org>; Wed, 21 Mar 2018 12:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeCUMNr (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 08:13:47 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:39155 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeCUMNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 08:13:47 -0400
Received: by mail-ot0-f176.google.com with SMTP id h8-v6so5317720oti.6
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+mpqEpbwJV6JMyanZCZH1tcozN5j5VTdhxUMBndizwM=;
        b=Ku7h+Iw4Aoc3nDl1a3KGKs+sZSjcyKhZHssfBlcR1EjqjjGSZKM8MHvP3ToKrlwaqw
         /NU+WB+sGhJLnhszyiZjuo7d3HhlQ1gttL2ZaitaHIWZDWZVp/VeXWVYcM0YS2wgwRM/
         c3Y7GixfSjC3hVtLB6SUI5pqmIH+65XfOwvh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+mpqEpbwJV6JMyanZCZH1tcozN5j5VTdhxUMBndizwM=;
        b=fRn9XrJpbWjVPBXdA5VVTWecfEWi8PoZfyyTNdSGy74OU9aOO9l4BOLZFjBKafqHhW
         /QxmoMssQCAWGOBVKtlwjyfJLYUFtxfCRGTyoFkaDQFTIaFe0hl831/oA0FU0ZGI6H7X
         t3NdHxukzewVPqmiR/w8ikr7nJYinpQTwuqPWSfgWxvsIRcoCcdH9rfEpmpBiOC8AfOp
         MdkpXahzvrItHSnxP3LEq8FHyLkDlv0THY+NhpidaMUrkCRPnPqogRqCiYwsY4kZ2V/g
         SG3+vps1rRVeabP0xsBm1FuSnu1DthBenKH1z0dyRoI5vYHm+6pSXuEqZkJU6ST2lAJJ
         Lnuw==
X-Gm-Message-State: AElRT7FzApIF1ZeYUF5lRnbx7TDBEzrsDrZsw/VV91SojIhwhUSA/a79
        6bRsnLabJJ34IwceujNmQJ0XLIGoGAAVIKSLSV0wWw==
X-Google-Smtp-Source: AG47ELsRAkLPO41yGXTqicluipufU7Yzwm9TbepjOMt8o3timHttVBnpqaXAyuML43BwxNSfCZvScTU5ATRK9jn6H6c=
X-Received: by 2002:a9d:213c:: with SMTP id i57-v6mr11403635otb.85.1521634426487;
 Wed, 21 Mar 2018 05:13:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 05:13:45
 -0700 (PDT)
In-Reply-To: <CAHnyXxQRfzAT75P7dxvdEEN_FRYCc7j97VEfL8tTUgVdeK-O+g@mail.gmail.com>
References: <CAHnyXxSqtB=bSbA83V6HC6-aPCxw60h1iKQaa6ChwsmcUUCd0w@mail.gmail.com>
 <87muz1brgt.fsf@evledraar.gmail.com> <CAHnyXxQRfzAT75P7dxvdEEN_FRYCc7j97VEfL8tTUgVdeK-O+g@mail.gmail.com>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Wed, 21 Mar 2018 08:13:45 -0400
Message-ID: <CAHnyXxQ6QH4St0D0u8BrW7i1=r2cgUjwDhRa4e98fmO1tksp-Q@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify non-recursion for ignore paths like `foo/`
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One additional note, I think I was was wrong about this:

  "In order to match `foo/` directories while allowing for
possible later exclusions, consider using a trailing wildcard (`foo/*`).
Note that matching directories with a trailing wildcard incurs some
additional performance cost, since it requires recursion into
subdirectories."

`foo/*` will let `!foo/file` work but still seems to prevent `!foo/bar/file=
`.

On Wed, Mar 21, 2018 at 7:53 AM, Dakota Hawkins
<dakota@dakotahawkins.com> wrote:
> First, apologies since I didn't get the in-reply-to correct in my
> email header. I'm not sure how to do that (using gmail/gsuite).
>
> Meant to reply to:
> https://public-inbox.org/git/20180321075041.GA24701@sigill.intra.peff.net=
/
>
>> Just before the context your patch quotes, we have this in gitignore(5)
>> already:
>>
>>     [...]It is not possible to re-include a file if a parent directory
>>     of that file is excluded. Git doesn=E2=80=99t list excluded director=
ies for
>>     performance reasons, so any patterns on contained files have no
>>     effect, no matter where they are defined.[...]
>>
>> I can't see how your change to the documentation doesn't just re-state
>> what we already have documented, which is not to say the docs can't be
>> improved, but then we should clearly state this in one place, not
>> re-state it within the span of a few paragraphs.
>
> Context:
>
> This came up originally because of confusion with .gitattributes
> patterns, since gitattributes doesn't have the same `foo/` matching
> behavior. Jeff King was kind enough to prepare a patch for that
> documentation here:
> https://public-inbox.org/git/20180320041454.GA15213@sigill.intra.peff.net=
/
>
> Re-reading the section you quoted again a couple of times you're
> correct, but somehow that wasn't clear to me despite reading/searching
> for what I wanted to see several times.
>
> While what I wrote may need improvement, I think there are a couple of
> valid concerns with the way this behavior is documented currently:
>
>   - Generally: Reading about pattern matching for .gitignore is
> awkward on its face, since positive matches have negative consequences
> (in other words `include =3D !match`).
>   - Specifically: This behavior that is specific to `foo/` matches is
> documented in the section for `!foo` matches. If you're trying to find
> the implications of `foo/` you may not have read about `!foo` as
> carefully.
>
> Since this behavior is practically applicable to both pattern formats,
> and since patterns in the sum of a repo's .gitignore files can get
> somewhat complicated, I think it would be a good idea to either:
>
>   - Do this and basically explain the same behavior twice in two
> pattern format sections, or
>   - Pull the documentation for this behavior out into another section
> where users would be likely to find and understand it if they're
> looking into either pattern format
>
> Does that make sense?
>
> What do you think?
>
> Thanks for the feedback,
>
> - Dakota
