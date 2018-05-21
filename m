Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34E4B1F51C
	for <e@80x24.org>; Mon, 21 May 2018 04:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeEUEsY (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 00:48:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41898 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeEUEsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 00:48:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id w15-v6so7061330wrp.8
        for <git@vger.kernel.org>; Sun, 20 May 2018 21:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HhUheHXRnDTRZf9MDPfTrkt2EbJ4qZBOhAetLRXrYoM=;
        b=YcuJAtWR/J/vgZomWe8sEbgKalC+etaKB7tlp6NYkV8h8gSm6du/K/+Wc5eo3XC05U
         Q2uTC/FHyNpQvj8Knm6oyDWc7UCcOJqKbqh6LwKlj8476IiHrAOXRMU1kCcCcLChjetD
         AOUqn1gRIqCS/DXG12j0FSPN7T4i7eYL+d7rCnBDb5b/EUYdi8Oyx9ZYIRKDiuI9C0YC
         oVKba1yosOc6c1joCASrtDFTMFozDctwX5BoVtjG0XyL6UN3UHrNtNazAqV6LL1lrzDK
         NFZ8AXVvwCsei6hfLdQWht0Lv+sPRczX4ylB9ieR+7ZVECgZl8QJXh6l4+AvxioOM2K4
         FgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HhUheHXRnDTRZf9MDPfTrkt2EbJ4qZBOhAetLRXrYoM=;
        b=owoZY6h5RY514pSn3XtX5RIt2PLw0Tx8UxeGC9FSr0V/E3+IohWM18URK8FHP1Fv8y
         gVb8STC8TI2GFOD1GQjuhzVp1Y4cccmswu3cnMiC3tuFKaQoBK3YmCcVzjBUtHnEQz1W
         cUXPjM7cacfNxP0uScLicATufswN0LRBuo1mlXehL7kRSFdQLKVSk7zDsKdgH1UqUHO5
         p02rH493H6GCkXIDFbnpoVKlyrbeFuytxlX7k3eeK7V3Gvuf4lKtgGl1xkzQ6gHgi+g7
         CQzQmP4Kw0fVXIVfUcDUGKRiaW6lFeEuqBaatGhV+zS2hUwSdjwP5eaQGt60JQhzaU+Y
         i0yA==
X-Gm-Message-State: ALKqPwdiqn9OnNS4kD6On5xks/aTJkIVUtEqfEBF3PHpitEVYeNF5DhP
        fvJptqbYwF14VgsxOdXdeTg=
X-Google-Smtp-Source: AB8JxZq41t/rC74UQUewSzysA00DnHYEXzSgoywvcebTnAk2WUoh+U+j6HnkiCqmwmRd0r+ONPLb1Q==
X-Received: by 2002:adf:90cd:: with SMTP id i71-v6mr14097812wri.136.1526878101923;
        Sun, 20 May 2018 21:48:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8-v6sm26519740wra.58.2018.05.20.21.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 21:48:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Date:   Mon, 21 May 2018 13:48:19 +0900
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 3 May 2018 17:30:20 +0200")
Message-ID: <xmqqvabh1ung.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been using both branch-diff and tbdiff while comparing rerolled
topics before accepting them.  One obvious difference between the
two is that the speed to compute pairing is quite different but that
is expected ;-)

Another difference that is somewhat irritating is that a SP that
leads a context line in a diff hunk that is introduced in the newer
iteration is often painted in reverse, and I do not know what aspect
of that single SP on these lines the branch-diff wants to pull my
attention to.

    https://pasteboard.co/Hm9ujI7F.png

In the picture, the three pre-context lines that are all indented by
a HT are prefixed by a SP, and that is prefixed by a '+' sign of the
outer diff.

We can use --dual-color mode to unsee these but it is somewhat
frustrating not to know what the branch-diff program wants to tell
me by highlighting the single SPs on these lines.

Thanks.
