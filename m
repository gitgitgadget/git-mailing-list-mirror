Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98746201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbdEPDky (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:40:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34577 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdEPDkx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:40:53 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so19606592pgb.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 20:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=9475whPBGefNrC3F7m+rXxoTBMqj4qs5ouczzsMuG0E=;
        b=I+HHeedeJAvjw1P0PhwhVC8RtkmllKSvVzUfSA2sgv76JetE6G67aZQzV1CmHxtpap
         5yZdJu7jdzLsIEQFQgWopOKSFlQOm/2reMmM10xHeKvVNZSATkm5tCddjeaG7WdnUeOT
         AJ3eZFgS2zO90n4gSlr677d5GarAH1wGUINuIbIlQbZBE4VR4yZvSUqyv2hWweGXaoI8
         GFBMc87yQ7AWicCxClDmazERyrZFixfWctJfa8T6eY8Sx50eaJj198w7WlUFuZ+zmxsn
         HPWQK0y7WX/7b8JtOhHLnxtcIWd8YMyjvadLm0yLkeBEBPRJvb2J2assJ4sKnT5XaGZ5
         s0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=9475whPBGefNrC3F7m+rXxoTBMqj4qs5ouczzsMuG0E=;
        b=nXYq0zSMUn+iRJz0KOsvUvHB3nr7GmAnSz8uwMmE0mdkbjgjI3m+6fJFHH/+vYTt/b
         jjOVK8qDp3KdesmR5YYFT40Lc2qTpGmF6ppZgsL/RVRBnkkuK7vl4bOcrw1urLAmgSU4
         hSchezcFYOcMAHvYUYOxtd6K+cf5j6spHesq7AVQk+qrQOBdP1m3yrbju85Hh/QxjSez
         SXr6QR80C66IwdYur6Xd4+vBKAfVLvypF+/uWPc8gcxGjoj8G/EN+DG+HZLlBpL+YgQJ
         ByiOQg6qq3QgYCaYkjeUvCizxCqyuljqJwauUHHAYQ4aw7lz4epqvAYyVEPFPFjKsd/f
         Cwcg==
X-Gm-Message-State: AODbwcBBcCedYeX+AEQww8qVOjxXABXC2fcA8+CO0EaHIVHbAP8LNo/N
        yXcUSum3/ky7gQ==
X-Received: by 10.98.102.208 with SMTP id s77mr9703181pfj.22.1494906053092;
        Mon, 15 May 2017 20:40:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id l198sm19235663pga.50.2017.05.15.20.40.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 20:40:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
        <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
Date:   Tue, 16 May 2017 12:40:51 +0900
Message-ID: <xmqqr2zp31vg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Interesting. The "exec" string is still run with a shell. E.g.:
> ...
> I wonder if this is falling afoul of the optimization in run-command's
> prepare_shell_cmd() to skip shell invocations for "simple" commands.
> ...
> So I suspect if you added an extraneous semi-colon, your case would work
> again (and that would confirm for us that this is indeed the problem).

Wow, that's a brilliant analysis.

> The optimization in run-command is very old, but the switch to
> rebase--helper presumably moved us from doing that exec in the actual
> shell script to doing it via the C code.
>
> Which means your exported-function technique has been broken for _most_
> of Git all along, but it just now affected this particular spot.
>
> I'm not sure how to feel about it. In the face of exported functions, we
> can never do the shell-skipping optimization, because we don't know how
> the shell is going to interpret even a simple-looking command. And it is
> kind of a neat trick. But I also hate to add extra useless shell
> invocations for the predominantly common case that people aren't using
> this trick (or aren't even using a shell that supports function
> exports).

I was about to write this off as "an unfortunate regression, a
fallout that will likely left unfixed, due to lack of a good
practical workaround."

The point of rewriting things in C and using run_command() interface
was to avoid shell overhead.  We are doing an exec already, but
adding a shell invocation in the middle will double the number of
exec (and probably add an extra fork as well), which probably is
measurable on systems with slow fork/exec.

The "semicolon" trick is way too obscure, but perhaps can be
documented as an escape hatch?

