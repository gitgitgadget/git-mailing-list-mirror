Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F371020248
	for <e@80x24.org>; Thu, 11 Apr 2019 18:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDKSVF (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 14:21:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43389 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKSVE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 14:21:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so5742354oig.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d1IEck52kmD6S7DPIgDk46zTYK6fd9mygFcbW2WPgGo=;
        b=UXrDllcwdKscKjLSr0CsbMC9Vy8CkKvXe07H8gHqe3vWS2YKqPqP+KnAZq787Mulaj
         P1zLTZyUlxsivw7+BsaJcx51JyI9Gmczc/OT3yHnP1HEJ4DFwoH21mneeuPeUt5RFxPP
         p/CcO0GBOnKScyaZgWgh5Nhftm5rwLc/5ru934ITrTRFNFVbwUvfcegnVGU6sOoNe2sC
         RqP/uSZsEXdQ1byZp2irQMqkH0M/zzpyVVoI6WfLchGSncKqVo9KFQIiRE3rf2U90Ydt
         OXN4uEZBImZAPfpnJuvwW4WNZavr8EJR2YEjTbW5qlw0YUJFTOPMcqRktuBw+AbCC3RT
         9P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d1IEck52kmD6S7DPIgDk46zTYK6fd9mygFcbW2WPgGo=;
        b=anTlOps2Geq/zD4Vowe2GDeQErGwI9WxrrhKhRar78tag0t//aNB0iWEEp3czDS0fE
         m5SrsL3FpdUKgpq0ggFc36N+vqleTLEAERTOqjJ0woSgrJw1y85TVU51clpgnwD7waA+
         1DtYJMXZnbHOplMzqCtVwFHfJQDU6kUJAWsdfq9rSy3gEYoZXIk2Itm2RJRgHPYts70u
         AN/c3OfN275/kxSSAKvVgUehXvxQV45F+zyq7hY8QV2PWtEO84u5iOne8KJvhDvXYEl1
         3rTUM008aT87MZ6p7HBLyCqnmM+K4o4FrEc+mbjHfY/1iyrVbelUaZsdverFxUi7fjKi
         UzpA==
X-Gm-Message-State: APjAAAVkQdJBHbwOu8FP8v7RDjUCP46mZsKLhJtfWJx8Ifk9JlQ5vUa+
        Un/cuHv+w0hanpuX9PN07byYnrRcqme4K90d5LuUhA==
X-Google-Smtp-Source: APXvYqyq7c3toU4l8d9G1eJ3Y/KxFYLHddvYDG5+OAN42y9yqbv3JwkrW9/BwaxCUSk7mk7GAfmSQkp9n6a4YIqzhwc=
X-Received: by 2002:aca:5757:: with SMTP id l84mr7834946oib.155.1555006863623;
 Thu, 11 Apr 2019 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
 <20190404015744.GF4409@sigill.intra.peff.net> <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
 <20190404120613.GB22324@sigill.intra.peff.net> <CAHd499CUCoShsQHYZotFqprfDUf_owg_Urbt29fkNRV6LhFc3Q@mail.gmail.com>
 <20190405222100.GA10787@sigill.intra.peff.net>
In-Reply-To: <20190405222100.GA10787@sigill.intra.peff.net>
From:   =?UTF-8?Q?B=C3=A1rbara_de_Castro_Fernandes?= 
        <barbara.fernandes@usp.br>
Date:   Thu, 11 Apr 2019 15:20:52 -0300
Message-ID: <CAJ+V80pY0L7onX600dmSaMuFFnH5n52-3CmnRyDKr-7ZkZ92mA@mail.gmail.com>
Subject: Re: Feature request: Add --no-edit to git tag command
To:     Jeff King <peff@peff.net>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Em sex, 5 de abr de 2019 =C3=A0s 19:21, Jeff King <peff@peff.net> escreveu:
>
> On Thu, Apr 04, 2019 at 08:56:16AM -0500, Robert Dailey wrote:
>
> > > I was thinking it was just the --no-edit fix. :) Even with the "--ame=
nd"
> > > thing, though, it's probably a little light for a 3-month-long GSoC
> > > project. :)
> >
> > I apologize for the confusion. I'm not fully aware of any per-option
> > philosophies in Git, so I may be unaware of the misunderstanding my
> > request is causing. Let me attempt to clarify.
>
> I think most of the confusion was just bad reading on my part. :)
>
> > My goal as a user is to correct a tag. If I point a tag at the wrong
> > commit, I simply want to move that tag to point to another commit. At
> > the moment, the only way I know to do this is the -f option, which I
> > just treat as a "move" for the tag. I realize that may not be its
> > intent in the implementation, but from a user perspective that's the
> > end result I get.
> >
> > So if I treat -f as a "move this tag", I also want to say "reuse the
> > existing commit message". So again, in my mind, that means -f
> > --no-edit. Which means "I'm moving this tag and I want to keep the
> > previous commit message".
> >
> > I hope this makes more sense. If getting this means not using -f or
> > --no-edit at all, and is instead a whole different set of options, I'm
> > OK with that as long as the end result is achievable. It's impossible
> > to write a script to "move" (-f) a bunch of annotated tags without an
> > editor prompting me on each one. So this "--no-edit" addition would
> > assist in automation, and also making sure that we simply want to
> > correct a tag, but not alter the message.
>
> Yeah, I think what you want to do is perfectly reasonable. The only
> reason not to use "-f" is because it already means other things, and we
> don't want to overload it.

This new proposed --amend option, although semantically different,
would have a very similar functionality to the already existing -f
option. So should we, perhaps, change -f's behavior to treat the tag
as a new one, treating the old one as if it never existed (as I think
Junio was saying)? By this I mean the command should fail if the user
doesn't give a SHA-1 and the previous message wouldn't be preloaded.
--amend, on the other hand, would give the user an opportunity to
revise the tag by opening, by default, the editor with the
pre-existing message unless given the '--no-edit' option, and if not
given a SHA-1 it would keep on using the previous one.

> Calling it "--amend" would make perfect
> sense (and then fixing "--no-edit" so it lets you avoid opening the
> editor). So I think there are two bits of work:
>
>   1. Add an "--amend" option, which allows overwriting an existing tag
>      and pre-populates the message with the existing tag's message.
>
>   2. Make --no-edit work like the patch I showed earlier (assuming that
>      your --amend still opens an editor by default).
>
> -Peff
