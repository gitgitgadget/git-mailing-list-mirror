Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65761F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbfIETfX (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:35:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41556 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIETfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:35:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so2478114pfo.8
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2P0W/EZ1KTaH3vgikbdG11Ze30p/CqRk3I2u3mms0N0=;
        b=e/JkaYcQ4eGFWnNEtADtpotQ2HaankTium/MTSfjWbRgL0LM6Xcu1L5kx+VKP+BkVK
         anXWtebf192ThzsKfM2MKCkA8/E+rgTBPZuKDrOGvVkZ67qkzdhtSOfibAGzaYeRTdrr
         9IHA8SgqByiQCfKATwCGz/kk8tclaCcRJxq+jVS5A7YwjP1ICv5l7keEvXsD/Ha6Qmxl
         qD1gPEJsKMedxQQp69eNAPszaGBfPulolJ0+aselc4r49jPsnLt6BZv0t+5a5TOcM5Gx
         3ZpMR5Jy6kD+Op7s46Y/XBBSsXR31T5K+VCCOZdq+/bERDThqWWUHTSlEYTNaoOwIZW6
         B6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2P0W/EZ1KTaH3vgikbdG11Ze30p/CqRk3I2u3mms0N0=;
        b=YmDqIBW032uDMD7UBfPyX7rdteAN2v2f242t7V4ECOiyqW8nOvBEwBO7MaQHNBaftY
         DDG+3G/uH0xz0y7FjRWHKzTXajMLEyEUQ6vPY1LM0ciEdqJyfBAjJNV69ShCuCuzOP80
         HZH8yuKrmOoDDm50CTGjvAkHg+M+ZPsrh9xBZQ3FwSjS0Xb1SLwdQY1VEG1SRSfN/Ub/
         3287VMrl0n8ZwMUb9iqhCgDxSny7E1Oza1buxxHv/3PbC9d90VZkElb1jd5TtQZ9ADtJ
         QTc7CTJeqbMpWo5rCI5SwV1ln2XGEtegw+qBbW1c6Yw72dmWlEa5iNRv7T5eJyXsK/Pz
         e4ig==
X-Gm-Message-State: APjAAAWxwdsvRG+Dsi7oSyixnzGnH4xgleJxDB5txCXrJIGV7fovknLb
        IHdA4FFNOteqXSTkzdy5Pk2Tz2ZDH4SzrDQ+mcs=
X-Google-Smtp-Source: APXvYqxKI+1QH01pvxL6gvV3e1HN5+bdCQu5bXg4LoZ5YJqC7bX+7RkfbBXOGpbZMDukK4NtDqRhWoi2TEzxkPSvl48=
X-Received: by 2002:a17:90a:8911:: with SMTP id u17mr5889714pjn.128.1567712122227;
 Thu, 05 Sep 2019 12:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com>
 <cover.1567534373.git.martin.agren@gmail.com> <20190904032609.GD28836@sigill.intra.peff.net>
In-Reply-To: <20190904032609.GD28836@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 5 Sep 2019 21:35:10 +0200
Message-ID: <CAN0heSpbRvNG9okz5pqkHqDMB2BM5T+FzAbaK3sVwzGC6fjpPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] asciidoctor-extensions: provide `<refmiscinfo/>`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 4 Sep 2019 at 05:26, Jeff King <peff@peff.net> wrote:
>
> On Tue, Sep 03, 2019 at 08:51:19PM +0200, Martin =C3=85gren wrote:
>
> > When I posted v1, it turned into quite a thread [1] on AsciiDoc vs
> > Asciidoctor vs Asciidoctor 2.0 and differences in rendering. (I am on
> > Asciidoctor 1.5.5.)
>
> Yes, sadly I still can't format the docs at all with 2.0.10 (which is
> what ships in Debian unstable).
>
> > do also think it makes sense to first make the "softer" switch to
> > Asciidoctor-by-default and get that particular hurdle behind us. Then,
> > once we're ok with dropping AsciiDoc entirely, we can do the switch to
> > an Asciidoctor-only toolchain.
>
> Yeah, I do still like that as an endgame, but I like what you have here
> as an intermediate step in the right direction.

Hmm, so this sounds like once I am happy with replacing AsciiDoc with
Asciidoctor 1(.5.5), I should rather not propose a series "let's default
to Asciidoctor!!!" but instead a slightly more careful "go with
Asciidoctor, but document that we work badly with v2 and that the 2nd
choice after Asciidoctor 1 should be AsciiDoc". Or do you see it
differently? (I wonder which Asciidoctor-version Junio would be on..)

Martin
