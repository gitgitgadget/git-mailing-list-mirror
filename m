Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6497E1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 16:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933814AbeFLQEm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 12:04:42 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35725 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933137AbeFLQEl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 12:04:41 -0400
Received: by mail-wr0-f171.google.com with SMTP id l10-v6so24686658wrn.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+4tLhv5oNbBDxBTUtjSeI8/dt0dTZ2Bs33wtWsEtXGw=;
        b=hl7xIKLQBjarYyjQqNZVQYhoe3LPydTDopyvLT6Ssi1n0g7JEA9lvHJcQuJfM8BMdM
         1g8DLYT2clQ7RnEcyacHGvLfuhG5HTyPIpkiEjf6DfKRlaeMRfbaZnb5YqG/SrVEOsJz
         1f7Tsdw9AFc9+ABgIglEbgLjCFqluiNq4oDVaC5AuFTt+mBwkLFGnT5nIATVNf2rTaKh
         bc3E6j67vdpBid1pSPi7gP6DkoyWPL7aJ1sD2GdfZ6Vrlk6QwilqitDEyiK3XDc4bgg2
         yjJOxJG0dcfIRHgjyJtvgNO0DzOFHCoN386+2OPwRsQcZD7MXwAdgmFcZ5FWuCiIj6Kb
         M4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+4tLhv5oNbBDxBTUtjSeI8/dt0dTZ2Bs33wtWsEtXGw=;
        b=ub6F+Z8HpQI7tSVKDWn3HqGTNBWPoFcBCCNTvzIWLlZvNJ4TYI2dLB17ewkMfg7uZR
         Rnia3A8xJJpssaKn7VpfQsN+CGv6KvMawe0o/5x/GSyE5RD9+7W+j8uHONLwvFGTNTUh
         sb7jtEILE3sBMiH+bYZ0U4Hhcm/JrMNVzG/ImjuY4lgymrgciIhS8hJaVQJCP0vaRDB+
         quuwZ8aQNDTMxjkOQhaxNYxgixMqxVfa1bCPHsPA6/+43ZadvmtLhugmlEfTNjQMpvZx
         TPU3FWAQNa2DbyopQeYiuUyA2HIc0fxlf/uAnjF8lCJrxWsZdkP/oiVfQrY1P5IVYaB1
         736A==
X-Gm-Message-State: APt69E2C+TUQzRzLxVwXMX8Un5QLPAJAmLBpmxnCfc4eseKDhPdR1451
        FwSuCnwrGnchxRwKA2FpX1Y=
X-Google-Smtp-Source: ADUXVKLXtmPgpTrUCEIy/naxargNJnNvsCaUnbUJWkkUrvcNtio/rtJisuf9yX19Fw3oqlWVUG92bA==
X-Received: by 2002:a5d:46c6:: with SMTP id g6-v6mr778571wrs.76.1528819479666;
        Tue, 12 Jun 2018 09:04:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v13-v6sm527631wrq.43.2018.06.12.09.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 09:04:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
References: <20180607145313.25015-1-git@jeffhostetler.com>
        <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
        <20180608090758.GA15112@sigill.intra.peff.net>
        <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
        <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
        <87fu1w53af.fsf@evledraar.gmail.com>
        <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
        <20180609065132.GD30224@sigill.intra.peff.net>
Date:   Tue, 12 Jun 2018 09:04:38 -0700
In-Reply-To: <20180609065132.GD30224@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 9 Jun 2018 02:51:32 -0400")
Message-ID: <xmqq602oat49.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In my experience the maintenance burden is not in the "connect to a
> socket" part, but the fact that you have to sprinkle the entry points
> throughout the code (e.g., "set 'cloning' flag to 1" or "I'm entering
> the pack generation phase of the fetch"). So I'd love to see us do that
> sprinkling _once_ where everyone can benefit, whether they want better
> tracing for debugging, telemetry across their installed base, or
> whatever.

I tend to agree.  Transport (or file) can stay outside the core of
this "telemetry" thing---agreeing on what and when to trace, and how
the trace is represented, and having an API and solid guideline,
would allow us to annotate the code just once and get useful data in
a consistent way.

> The mechanism to handle those calls is much easier to plug in and out,
> then. And I don't have a huge preference for compile-time versus
> run-time, or whether bits are in-tree or out-of-tree. Obviously we'd
> have some basic "write to stderr or a file" consumer in-tree.

If it makes readers fearful of big brother feel safer, I think we
probably can add code that is runtime controllable that is compiled
in conditionally ;-)

I do not quite buy "Big brothers who want this for their own in
house use case can afford to patch" argument, by the way.  If
anything, having a solid tracing mechanism (to which existing
GIT_TRACE support _should_ be able to serve as a starting point)
would mean small budget guys do not have to do their own investing
to collect useful data over their customer base (I am seeing an
analog in "popcon", opt-in stats of installed package in a distro,
which we can view as "telemetry data for distro installer program").

