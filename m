Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7960E1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 10:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeKZVWN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 16:22:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35551 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeKZVWN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 16:22:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so17715639wmh.0
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 02:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=dUNdLNJSzF+p2MTiulFl6gJqrhBZ81XWUc0u1nVLk3U=;
        b=MgoecJ104eFb/135nS2++hlfxB2zYmIEszuuJkI0k6DTcvZH1NuhjiwzsE6+8GwRzK
         5CBUiSLECBow+eXKpBoLHRX7XiJ7FjKLyvUmjlwY4bF6L88hdrzFCpZ8mXNmOnriJsSP
         0NLxwdjuzK47MiYV6SAFxDa3nk1fhKZjZHCXhlwxvH1Ku4u48zLjY4OaxRqzr8RI6q6K
         L6J4QbTdfV/dsRVLh+0oDsQCNJCRkuV+mfNxuoKYhPLGqkVizbUkm9Rv4AWYzEEiE3PI
         baKI3zGiiuHddAqg8eaAwJyw6AnNGFAhTXcC1QVCJRLpP37jAcM3fh9lFp3xxEAFqSgz
         P5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=dUNdLNJSzF+p2MTiulFl6gJqrhBZ81XWUc0u1nVLk3U=;
        b=dA440NJu8C3eummfvHkN6YaZfo+ETJObfahq/llZIw9eXviYgMQNVg7kZ6YBdz7Lby
         XWCWL9fBUbBf9/zVu3PkurShJXOmQvSaEfUp9R+N7nYP4LPiIxNDoJaiSmNrFUyhgzyb
         Zf0bcCs5FFVSePkS6NTdXwBJ2LfNNByUNojUoG/n+xdv3Op2Iwo4LngZl3PqhtMDKYqG
         Qlz1600sVa3DM9/KAen48NjPPMJ0u/WWPL3hCtfOanL6NpB08X3bD+hmuP9wtLnTAc/B
         xhpnf/yQPFClCHZPyBSjeNUwbrekhH4iyeizGNx1EAFx35COKCiOReU5Zc376BnAg4oj
         lJ9g==
X-Gm-Message-State: AA+aEWbSimk+XdgSz6WkMlm2CMl25znAp5jqXREDYJFrmt96grzew23T
        MJrEHVG5yIzZFicrHEK9Dr8=
X-Google-Smtp-Source: AFSGD/Xkd8BQ/lffSQSrURpA/xPYL0GJ1GI95OhAzcgzZfPvtzzFMOkJTKTCw3f3X5qdLSV7rCMbfA==
X-Received: by 2002:a1c:4485:: with SMTP id r127mr23879739wma.50.1543228110423;
        Mon, 26 Nov 2018 02:28:30 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id v19sm55526wrd.46.2018.11.26.02.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 02:28:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Per Lundberg <per.lundberg@hibox.tv>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com>
        <875zxa6xzp.fsf@evledraar.gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <20181112232209.GK890086@genre.crustytoothpaste.net>
        <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
Date:   Mon, 26 Nov 2018 11:28:28 +0100
Message-ID: <87wop0yvxv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 26 2018, Per Lundberg wrote:

> On 11/13/18 1:22 AM, brian m. carlson wrote:
>> This is going to totally hose automation.  My last job had files which
>> might move from tracked to untracked (a file that had become generated),
>> and long-running CI and build systems would need to be able to check out
>> one status and switch to the other.  Your proposed change will prevent
>> those systems from working, whereas they previously did.
>>
>> I agree that your proposal would have been a better design originally,
>> but breaking the way automated systems currently work is probably going
>> to be a dealbreaker.
>
> How about something like this:
>
> 1. Introduce a concept with "garbage" files, which git is "permitted to
> delete" without prompting.
>
> 2. Retain the current default, i.e. "ignored files are garbage" for now,
> making the new behavior _opt in_ to avoid breaking automated
> systems/existing scripts for anyone. Put the setting for this behind a
> new core.* config flag.
>
> 3. In the plan for version 3.0 (a new major version where some breakage
> can be tolerable, according to Semantic Versioning), change the default
> so that "only explicit garbage is garbage". Include very clear notices
> of this in the release notes. The config flag is retained, but its
> default changes from true->false or vice versa. People who dislike the
> new behavior can easily change back to the 2.x semantics.
>
> Would this be a reasonable compromise for everybody?

Possibly, but I think there's an earlier step zero there for anyone
interested in pursuing this (and currently I can't make time for it),
which is to submit a patch with tests and documentation showing exactly
the sort of scenarios where we clobber or don't clobber existing files.

As my https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
shows we have tests for this, but they're not explicit, and some want to
test some unrelated thing.

I.e. to test the cases where we clobber foo.c because foo.c now
explicitly exists, or cases where dir/foo.c is clobbered because "dir"
is now a tracked text file etc., are those the only two cases? I vaguely
suspect that there were other interesting cases, but at this point the
information has been paged out of the working set of my wetware. The
thread at
https://public-inbox.org/git/87o9au39s7.fsf@evledraar.gmail.com/ has
some notes about this.

Then as noted in
https://public-inbox.org/git/87wopj3661.fsf@evledraar.gmail.com/ the
reason we have this behavior seems to be something that grew organically
from a semi-related bugfix.

So I don't think we're at a point where we're all dug into our trenches
and some people want X and others want Y and in the name of backwards
compatibility we're going to stay with X. It may turn out that we just
want to retain 10% of X, and can get 99% of the safety of Y by doing
that.
