Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40EC11F954
	for <e@80x24.org>; Tue, 21 Aug 2018 15:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHUSmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 14:42:33 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:40033 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeHUSmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 14:42:33 -0400
Received: by mail-io0-f181.google.com with SMTP id l14-v6so15697026iob.7
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5U76oQRQuEl1WDtMOkE20uuSX0ujLol3U58RnYb1iY=;
        b=BgzpKesi/n4XXIqRtRBXLK7cHniCgBJldikDb/O8a5mM5cAqcWQ/GKvO6qYupLgRRT
         D4epm9QUubzhCe9SMUwgIDP62fSgu78g+BBm9D1nrg5sx/4AfhlaL+Ds0EqCZE/FBt26
         VnUofFs1utgKyCJDs35TiFjvqY0o8oc/Em30J+idgw5WmR7zWPQAuONLYnWuqRKYLFQv
         +aoSd9+oT30ODVF4pWVv4rcoolkkMzXGF9rLaGE9mpELMIbD7eMwtjSvkO3WfusI2lWx
         PfQoPdPobdinxMHlhWFUgBo0afcb89dWeruvOpE+/Y73T5sXcq88JwbatFHPvR1c53bq
         yZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5U76oQRQuEl1WDtMOkE20uuSX0ujLol3U58RnYb1iY=;
        b=ZKckyur796QZKbxGRpnLhB71YJilwB8j6FBsvaq6yfwhzTtw82U+u8925ddGM7Ojnu
         DwanVUJCb4oMemF7DzgauW1CCeEyIm4JtJthHWuMkpoKYx5UwwEi8V1ZjRJN7rwoLfSB
         Nj4SPqlDd0UH65KcjhN4njDyreh3HSWTsQKPHvHS74UJleLevWkOYbxzaClxRsKlKPHc
         0cgxjUmuVgZD575TLShZa+1dYtH5AB6HEMUOf8ql6KEsu9Di5MZjMl3EhUvbPdrfH4kj
         MlZfoR/k0W5RwOHMq2cxMaXutFpJMyhaDMHiwBKMe4STpXCxGVg6ZwYS4TPCtqpFmagr
         3t8g==
X-Gm-Message-State: APzg51BXvOp8C4wesr5Hj4G4S65H3vzBHk8LrcQvAYd34fquA5iJn+TP
        oIZIUAvNZQzD5+Ze1u10e+2s6t//lGuSEqTgHso=
X-Google-Smtp-Source: ANB0VdaN7CJJa16loueOZAng0vvCL8aCkzauw/m/DnFOM9U3xbTWJ+gXh7tNi6wTZdN98ACgSOB5IbnOmBc6YcJACoo=
X-Received: by 2002:a6b:8fd0:: with SMTP id r199-v6mr6110395iod.118.1534864917976;
 Tue, 21 Aug 2018 08:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net> <87bma2qcba.fsf@evledraar.gmail.com>
 <20180816205556.GA8257@sigill.intra.peff.net> <5B7A7CDC020000A10002CDCF@gwsmtp1.uni-regensburg.de>
 <87woslpg9i.fsf@evledraar.gmail.com> <20180821010712.GA32126@sigill.intra.peff.net>
In-Reply-To: <20180821010712.GA32126@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Aug 2018 17:21:31 +0200
Message-ID: <CACsJy8CztYM4XqC1uZ+MxXaQjp8qWjNYyNM1=wD0Q=PyqAmfVg@mail.gmail.com>
Subject: Re: Antw: Re: non-smooth progress indication for git fsck and git gc
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 3:13 AM Jeff King <peff@peff.net> wrote:
> I _think_ they should work together OK without further modification.
> Once upon a time the caller had to say "don't show if we're past N%
> after M seconds", but I think with the current code we'd just show it if
> we're not completely finished after 2 seconds.
>
> So it really should just be a simple:
>
>   progress = start_delayed_progress("Hashing packfile", 0);
>
> That said, counting bytes would probably be ugly (just because the
> numbers get really big). We'd probably prefer to show a throughput or
> something.

Or just an ascii throbber. I think the important thing is communicate
"I'm still doing something, not hanging up". "Hashing packfile"
satisfies the "something" part, the throbber the "hanging".
-- 
Duy
