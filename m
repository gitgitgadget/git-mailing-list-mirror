Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1255B1F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 11:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCULx1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 07:53:27 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:42330 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeCULx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 07:53:26 -0400
Received: by mail-oi0-f50.google.com with SMTP id c18-v6so4031794oiy.9
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 04:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VDPlVq45XMz9oyg1yNxo+7VR4z0Qdj1cq86uRifJw1I=;
        b=OnroJZviE8NOxjbW68XdTUxGLkZlGhwJFnBF/Y8czcQ/WbR/IWDHOvH4p4QJTSYViD
         tDO4bCi/A4iIPPzQqLek+GiJvBwGxnxRsjM9QaEc+ujyQUNGqkygLpwpm+nAwQYjVIgy
         GGCaDmWjSc9LRczrGn+/SGvfQ+rJbC9UBbi8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VDPlVq45XMz9oyg1yNxo+7VR4z0Qdj1cq86uRifJw1I=;
        b=Zr1Kj9I0Asmm5lLsHfEM87TEw4JURoa0R5T6SFO5wTQoc/ccLbn7ATfJBGs4+osqrF
         rF3qPtzXBTRyYJnBr2EuRjKBiMzWC0OKHaWgapaYJWNWxqeKMoj/RzwOe/LwI2guAR/0
         qeioc0p1DPSE8W5W0zL3epORbZgXPon6T0nWvZH961XsDGiBmz/LoR7bTqb3T669PFkd
         hZEjysaO7h9bklI+T6/cSa7iQ72dwGsZBCLqzm3BrW3uma7x2Btmab2LDRQkCV1ueBdz
         H7fpsF68Md+0/GPY2+EvSNZzw0IDF9ok7O7V55dMuJjqRbPcWvkyxrPkcD2KsLpFRlI4
         8Tkg==
X-Gm-Message-State: AElRT7Gg3MLFpORuYYkzqr/V/myJGG/PDmJKZviS4ePW26mPLK7HPdZw
        3Myu9hzupvntx0ONWz26aXRJO9wKNdJd4iDTslZ2BA==
X-Google-Smtp-Source: AG47ELuGfeqGAEa1at8OZsHp9bwpJQtbbseR82iaZkaJiQUX9s+utV4gXUmtCO8a7fHAkZe8IaR/qQp2H5RcaTLe3/c=
X-Received: by 10.84.78.138 with SMTP id c10mr11066885oiy.236.1521633205685;
 Wed, 21 Mar 2018 04:53:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 04:53:24
 -0700 (PDT)
In-Reply-To: <87muz1brgt.fsf@evledraar.gmail.com>
References: <CAHnyXxSqtB=bSbA83V6HC6-aPCxw60h1iKQaa6ChwsmcUUCd0w@mail.gmail.com>
 <87muz1brgt.fsf@evledraar.gmail.com>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Wed, 21 Mar 2018 07:53:24 -0400
Message-ID: <CAHnyXxQRfzAT75P7dxvdEEN_FRYCc7j97VEfL8tTUgVdeK-O+g@mail.gmail.com>
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

First, apologies since I didn't get the in-reply-to correct in my
email header. I'm not sure how to do that (using gmail/gsuite).

Meant to reply to:
https://public-inbox.org/git/20180321075041.GA24701@sigill.intra.peff.net/

> Just before the context your patch quotes, we have this in gitignore(5)
> already:
>
>     [...]It is not possible to re-include a file if a parent directory
>     of that file is excluded. Git doesn=E2=80=99t list excluded directori=
es for
>     performance reasons, so any patterns on contained files have no
>     effect, no matter where they are defined.[...]
>
> I can't see how your change to the documentation doesn't just re-state
> what we already have documented, which is not to say the docs can't be
> improved, but then we should clearly state this in one place, not
> re-state it within the span of a few paragraphs.

Context:

This came up originally because of confusion with .gitattributes
patterns, since gitattributes doesn't have the same `foo/` matching
behavior. Jeff King was kind enough to prepare a patch for that
documentation here:
https://public-inbox.org/git/20180320041454.GA15213@sigill.intra.peff.net/

Re-reading the section you quoted again a couple of times you're
correct, but somehow that wasn't clear to me despite reading/searching
for what I wanted to see several times.

While what I wrote may need improvement, I think there are a couple of
valid concerns with the way this behavior is documented currently:

  - Generally: Reading about pattern matching for .gitignore is
awkward on its face, since positive matches have negative consequences
(in other words `include =3D !match`).
  - Specifically: This behavior that is specific to `foo/` matches is
documented in the section for `!foo` matches. If you're trying to find
the implications of `foo/` you may not have read about `!foo` as
carefully.

Since this behavior is practically applicable to both pattern formats,
and since patterns in the sum of a repo's .gitignore files can get
somewhat complicated, I think it would be a good idea to either:

  - Do this and basically explain the same behavior twice in two
pattern format sections, or
  - Pull the documentation for this behavior out into another section
where users would be likely to find and understand it if they're
looking into either pattern format

Does that make sense?

What do you think?

Thanks for the feedback,

- Dakota
