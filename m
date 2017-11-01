Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA91C202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbdKAWTC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:19:02 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:57092 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933341AbdKAWTB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:19:01 -0400
Received: by mail-qk0-f170.google.com with SMTP id l194so4555855qke.13
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3wtKZ2JS24uCc1GbK9opby1hCf3PVesQHzc23dh//9U=;
        b=iOwhOYljQhcHoSZt+dvFnAxBPqdEXV4f1VHy07ZG4xsPMj9D6iKsRO8+yb+kiTWr0i
         Jm9d/gzClVFfrFsOGFlOD05/VtcyOwXeQcWRx2hl1OkN51sXztXW+jvHf5rgO5vL/rCk
         MVA+AsLRFSrt65WAD7kxr31MyW/n96+oN+fbRZRArvS6uy61MTnPu30+kUE7NBGquEq0
         vxb2SEuHW0+Xdne4NW21ppdegJtCHyJdm9twyG6cCmaK/Mk4xAx0GV1h4CSNCGRu9DYI
         Qfg9BbuPGtIo4LI5pxVdUfTkoSQD7eLuuulWYfScKCWQFV5z46pwm8c6yXPNbGWp+UTG
         ugVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3wtKZ2JS24uCc1GbK9opby1hCf3PVesQHzc23dh//9U=;
        b=N6BkXEffcS5tXB5uuvDkn2Dw02qPem5o+Q4ycYP3EbsLnKQ3nzuRdH0i7zgkew/1gn
         +TBEbSaRZCAmld/QUUGgRRxew5JunbYxkF+uVG/UgazyRfNrygWCqPAKVHSMaGWt2tL4
         7VERxMn+eN3AXpIc0c455teD3k4FHFJbIxKEUGPSr8BFkkxR0hj2o21TfDwL06zUEC4W
         HHg2M/DQ6fVpmj4Fp8LtEQGPozV/ggNAu2ITa13eMpNSbJRrEuqNTreQt0OALKGrxEQ6
         cqQPvnEVUzk6sPpLYd3G4uWnqbD4FHBTqi+ezv4bDwyrcEMsb5bW76eh4Z49EPRCEkMu
         3vbA==
X-Gm-Message-State: AJaThX6IVqB2OeMLrqqH38HCmx8G8y/o4ZtloczLfxiW46AP/rLFeRML
        AfS2VHx7VOtboind2Qa2rub3GrIwZllepwIFPHrpQg==
X-Google-Smtp-Source: ABhQp+SPWubJ1bd/e91jBy/4ik/EvGAK+j6hbyfxB0uI6tss6BLCu84Wa8aepW0i9XpEH8MtoCdqSO7hT6yRUkYU+A0=
X-Received: by 10.55.18.165 with SMTP id 37mr2115001qks.352.1509574740887;
 Wed, 01 Nov 2017 15:19:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 15:19:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711012307060.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011316590.6482@virtualbox> <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
 <CAGZ79kY-yooE4cZK0Sxh3AL32wi66PRh1LzB8e3djq=bnLDHFg@mail.gmail.com> <alpine.DEB.2.21.1.1711012307060.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 15:19:00 -0700
Message-ID: <CAGZ79kbYshVjUh2XhbLHtYmnRuFaCmuWZJZd7HifKAqJbNBPfw@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order of
 the commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> I think I'll go without the extra subshell and with s/return 1/false/ as
>> the exact value doesn't matter.
>
> You mean
>
>         for ...
>         do
>                 xyz ||
>                 false
>         done

Yes, I do.

> ? That does not work. Try this:
>
>         for a in 1 2 3; do echo $a && false; done && echo done

...   && echo $?
         1

> While it does not print `done`, it will print all of 1, 2 and 3.

We do not care about the internal state, aborting early, we rather
care only if the whole loop body was executed. Running the test

    test_expect_success 'witty title' '
        for a in 1 2 3; do echo $a && false; done && echo done
    '

not ok 1 - witty title

That is all we want to care about here?
Otherwise I may still have a misunderstanding.

Thanks,
Stefan
