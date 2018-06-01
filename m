Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3681F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750831AbeFABfe (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:35:34 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39735 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFABfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:35:33 -0400
Received: by mail-wm0-f48.google.com with SMTP id f8-v6so57138405wmc.4
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aP06KlyNvDZ8JV3zutPlck+vR/R1xHZrKfOgX3z9ZpQ=;
        b=VH2mlo4AegL8WJ1wZjl5/nDtpRO038JA71cu+uX8efkL7VRa+MUM9DCrM127fGnZEq
         /1W0ltlob7GpkfgF7QuKdbztC5KQa93TmbU9UDjJft8NNOuADaJMqV/EmD3SDGFk4kxy
         R8T1Ast/pkvZKM4oSDRs8s4svfeeGnQwFNgxM5YUXaWWH5x9/rE+Vsc/Uu7tUO5c8AJC
         SjnnmvNjyFPLV1lX73LMViPmK5vkspo+Dt6UeIFjZ6d8yKyLgRHc1ZqHYXNwcq1x83YV
         rbvtDbtSyvqHpOG0f0jZ3jiVYse5bCqLXR0FbnqTZgyo66wRa1e5E9V1ab2iQyMaEUKO
         QhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aP06KlyNvDZ8JV3zutPlck+vR/R1xHZrKfOgX3z9ZpQ=;
        b=ldBUrGWsVYYdA/gXWsQUwsAX7yjbGVVRUG8+tI80uu+Iu9KT3NHzROJK6ewgualLAH
         7BqcX1i1QAJHX1ee8fy3jO/c50RhwSB+Ee7DRZSFaKzVV5mvXsTUC/Z7iiMqx7HlbbGb
         ni3xkmXK+5eT/hwWf6zMOK1GkmUkRuhkFuxtxIESXV0kLn5dravG+/Rf6ZV3YRzu5sve
         Ndz3uX6xuozbCPgp0yOzG6JJdvPdUUuZnQg35B8yaLzobPXj1fSL3JPbUHJXbPvU6mmG
         i5Mp2kxaE9on1AoW9LGgjEH+c5jOsY9iwnXsaB+ESSpUaxcC7k0rpeeBmvffOGAjTlsa
         VrGA==
X-Gm-Message-State: APt69E2LyFPVR+4e7S2xVYvv+JnjMKvp+K6dqeggUHnwn33xlId9U2M1
        QfeJjAwHEffytsihr1oxlhY=
X-Google-Smtp-Source: ADUXVKI94ghRgeW+80+QRaG3Bl612mn1PkqP4wZ4p9mfM1VQtIZx9q2YFAsBGbdrYR6ne77TfQrGYA==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185-v6mr1160890wms.62.1527816931866;
        Thu, 31 May 2018 18:35:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e7-v6sm37973571wrn.88.2018.05.31.18.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 18:35:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
        <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
        <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
        <20180529211523.GA7964@sigill.intra.peff.net>
        <xmqqzi0hety4.fsf@gitster-ct.c.googlers.com>
        <20180531055100.GC17344@sigill.intra.peff.net>
Date:   Fri, 01 Jun 2018 10:35:30 +0900
In-Reply-To: <20180531055100.GC17344@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 31 May 2018 01:51:00 -0400")
Message-ID: <xmqq8t7zb865.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think you're proposing:
>
>   - step 0: warn about "-l" when it actually gets used, and otherwise
>     continue ignoring
>
>   - step 1: turn "-l" into "--list"
>
>   - step 2: there is no step 2
>
> ... So I
> guess the right rule is to warn when we are not in list-mode, and
> otherwise quietly accept it.
>
> That does mean that anybody who misses the deprecation warning may be
> surprised when "branch -l foo" starts listing instead of creating a
> branch with a reflog (whereas in the current 3-step plan, we have a
> period in the middle where that's a hard error). That may be OK, though,
> and is a natural consequence of getting to the end step sooner (even
> with a 3-step plan, anybody who skips the versions in the middle _could_
> be surprised).

Thanks for a concise and readably summary ;-)
