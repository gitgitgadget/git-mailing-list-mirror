Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133F41F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeJKE3r (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:29:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47020 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeJKE3r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:29:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so6226627edg.13
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=09z9B7WZ6V+AoFRh6taZOSnT6Bm2S3ZE8VEkAefrPrY=;
        b=nOsiRClPREUaf4lB7t6EsMNUWdP34wjf5L5wXI1Muj4epY8v/TnzOkqrHbSyShHVXi
         bXeZl8Z+1deoTi30/1UJvzWtY4iO1y4GfTQJoWiCJEiGYieLzX4wq+tNTrENnTD+l/1m
         p2MQYTSIsQZatJ8zLY34YcQ0tQKgGaoi30RMniQda3EOaJePWoveFzwck9BGlxfApWyu
         KBy7eSYzDFbsJHacKaz8Z6kRT5XonfWWskiGqscNm/OTJ6SbGZ2CmRylw6s2vfWR5EbR
         ie3og+bSpaXnTCGSuatQ4P6x0aumKDMwIH+cR10aK3o3aUKszzXJ2WkH+yBBWPnVpTQb
         ugWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=09z9B7WZ6V+AoFRh6taZOSnT6Bm2S3ZE8VEkAefrPrY=;
        b=toTCgBy0RxLj20MdZcazqCB3OqecC+TwgLMRDpiMkp0r2tAjDmL2ogqBvTG8o9FcfE
         C5Yu3HjbEtmaHDYMe7DGeHI3PIaAE6JpKG4ommvyZ8MRuGHZp9IX3O09giDMH4cLaVjg
         FGk71A86Lq9UcgZpNjyxveVpPaItCMIvP+8dp5usf4HTCwb7jGDGp7HHLU/4G+GfSJZA
         fSK2hCf4fE1nGg/PRSdiFnRmr/xIw1EFDsYhmK54wtBhOZuUm7arFdbrabEbl76lw7wR
         OAHILMYQk6e9xpYicWRtXjjjlpKp8GOxhdAZvw+6Be5DcrpfJdiYWwnXtbyNcwB47OOI
         a7Dw==
X-Gm-Message-State: ABuFfoiHSilDT/z3dKpchnmf/EU+XaZzvV3OteR8qK0ElpCxDzrfLvf1
        RfidtH61V44rzysE4lalnj5bKaJFoAE=
X-Google-Smtp-Source: ACcGV63z156b6T0ezrTcLdLZXR7/vpCpankGk9sp2uc4oskQsEoAGj0T0N8hUVq2xJQ+QbtutgSbaA==
X-Received: by 2002:a50:8247:: with SMTP id 65-v6mr45034109edf.179.1539205549410;
        Wed, 10 Oct 2018 14:05:49 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id d23-v6sm7300016eds.47.2018.10.10.14.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:05:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing 3029970275
References: <20181010174624.GC8786@sigill.intra.peff.net> <20181010192732.13918-1-avarab@gmail.com> <20181010205611.GA195252@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010205611.GA195252@aiede.svl.corp.google.com>
Date:   Wed, 10 Oct 2018 23:05:47 +0200
Message-ID: <87sh1declw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Jonathan Nieder wrote:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> Add an --auto-exit-code variable and a corresponding 'gc.autoExitCode'
>> configuration option to optionally bring back the 'git gc --auto' exit
>> code behavior as it existed between 2.6.3..2.19.0 (inclusive).
>
> Hm.  Can you tell me more about the use case where this would be
> helpful to you?  That would help us come up with a better name for it.

From the E-Mail linked from the commit message[1] (I opted not to put
this in, because it was getting a bit long:

    Right. I know. What I mean is now I can (and do) use it to run 'git gc
    --auto' across our server fleet and see whether I have any of #3, or
    whether it's all #1 or #2. If there's nothing to do in #1 that's fine,
    and it just so happens that I'll run gc due to #2 that's also fine, but
    I'd like to see if gc really is stuck.

    This of course relies on them having other users / scripts doing normal
    git commands which would trigger previous 'git gc --auto' runs.

I.e. with your change that command:

    git gc --auto

Would change to something like:

    git gc --auto && ! test -e .git/gc.log

Which, as noted is a bit of a nasty breaker of the encapsulation, so
now:

    git gc --auto --auto-exit-code

Or just a variant of that which will have dropped the config in-place in
/etc/gitconfig, and then as before:

    git gc --auto

1. https://public-inbox.org/git/878t69dgvx.fsf@evledraar.gmail.com/
