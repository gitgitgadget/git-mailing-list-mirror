Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE4B1F453
	for <e@80x24.org>; Wed,  1 May 2019 11:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfEALlv (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 07:41:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53012 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfEALlv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 07:41:51 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so9331850itf.2
        for <git@vger.kernel.org>; Wed, 01 May 2019 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05D3TEVOLfq3MdvSpM4ZapXcxQOhKoBPTZ8xNAXb/pk=;
        b=uxnr+3Mzj1kUOCnXIIOCaU40qxAOjdgAHZuAp71+g9HL9LZs5quSK7DQhi+pSQtcGV
         gjDxsYefqr5PXCp1XIScFT1vHU8jG6APKpv79P0fFciJdlvaczu7/RlSMHZw6lMQz/VT
         Q8dFCwiMYwbt38C4eLR+i/FB8aCd8OLO6qGB+LObNX2JIJmSqxKIkCA6sETH2Pi9vdgX
         6gHhjNkXpottwhQPjFnZvREWPlOPgOmaA4oHgE8eJTlrY3nx6oVpHEqqtGWQhslFH/Lw
         3AhSR/JCHLQatcNd7MR3gdpGcoxTIY5GYDyRE7VfebPCGPYzXHYFMKaJafHTqi3/zrM1
         Lhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05D3TEVOLfq3MdvSpM4ZapXcxQOhKoBPTZ8xNAXb/pk=;
        b=BY8CCJCHdSfTBF4DbWKqcJA5px4hpvkniUXI+PQ/epIWH1W2CuTImrnc3PGw9W6obF
         1dUAwR9USeApR+Ng7ZzL0+bvxXBLxkRWGWG9C0pOoPqmSEO/HAojYIuDTDLwnUQee9bP
         lY1U+h/8w4XGCdP0PeQcmHFCOE6/Bv0piMR+beOMjj0FLz+kaD8iG9JIWb+qqDJUWWoT
         R1794Q6YGTpmBtJo8Uy7niN3uyhBbxFKE5bCOVmaQfWJcGdrlno0rrMd7/0OwQtB0aqf
         QVTM/eF2aCY21mt4T7agbdgsV2+Mb3HA9fHiLnry62+AGsxA+xxkMcidGfy2yteXnqGd
         f/pA==
X-Gm-Message-State: APjAAAURZmzeiYGzICJuImFTUaM4wP1lUhmUn8z79XmGoZFDJKigdFVT
        IObGmNMzkHdxMd9ElB6pLVIwyWHN05ZbZetNGzM=
X-Google-Smtp-Source: APXvYqzLQ5JQJptFgUkO1szWD3/SAM35L5SEA+aFUk7ll5ACNS5P5ZQ5PSvdPVFhmdDT/+43GjFM+mZp5nw4x5xS4w4=
X-Received: by 2002:a02:ba85:: with SMTP id g5mr9258814jao.92.1556710910834;
 Wed, 01 May 2019 04:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com> <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com> <20190425143614.GA91608@google.com>
 <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com> <20190430211415.GB16290@sigill.intra.peff.net>
In-Reply-To: <20190430211415.GB16290@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 18:41:24 +0700
Message-ID: <CACsJy8B+hDqKnu+0tkPC42w+_6RhzYac1BxYtdyxctcARG=VCg@mail.gmail.com>
Subject: Re: How to undo previously set configuration? (again)
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 4:14 AM Jeff King <peff@peff.net> wrote:
> It's definitely not implemented universally; each consumer of the config
> option must decide on it (and it will probably always be that way to
> some degree, since we don't know the semantics of each options; recall
> that we may be holding config keys for other non-core programs, too).
> And we just haven't retro-fitted a lot of those older options because
> nobody has been bothered by it.
>
> That said, I am a proponent of having some kind of clearing mechanism
> (and I was the one who added credential.helper's mechanism, which has
> been mentioned in this thread).  I think it makes things a lot less
> difficult if we don't have to change the syntax of the config files to
> do it. With that constraint, that pretty much leaves:
>
>   1. Some sentinel value like the empty string. That one _probably_
>      works in most cases, but there may be lists which want to represent
>      the empty value. There could be other sentinel values (e.g.,
>      "CLEAR") which are simply unlikely to be used as real values.
>
>   2. The boolean syntax (i.e., "[foo]bar" with no equals) is almost
>      always bogus for a list. So that can work as a sentinel that is
>      OK syntactically.

Another question about the universal clearing mechanism, how does "git
config" fit into this? It would be great if the user can actually see
the same thing a git command sees to troubleshoot. Option 1 leaves the
interpretation/guessing to the user, "git config" simply gives the raw
input list before "clear" is processed. Option 2, "git config"
probably can be taught to optionally clear when it sees the boolean
syntax.
-- 
Duy
