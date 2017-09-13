Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C533220286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbdIMW1g (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:27:36 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44310 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdIMW1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:27:34 -0400
Received: by mail-pg0-f43.google.com with SMTP id j16so2941737pga.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mnrJCUka6v5PVIWwhmu40awx/vnllcru90gYQxUQZ48=;
        b=fpB7tRp5CK0tWo0gqHdKcKb6mnHiEqk+L0NXvihQZr3UKPompMmHPN21ffhUEE0Q98
         tIu2wCo5EaiYojcFvPfW1pGzQagj5glOCyJFTQIuG/aDSCHIs5oacQKorF4/CvdgVB+s
         UcwGA9Dc1JpvYBIZz4QRl8JFjNDIrmb4ykmXD7e9sEYNgiG0R3UqSC9DytQNvFVjGQmB
         FTq6iDxjhSdOOmo2jTDrHZkdvD+ehss8/HMYd7cJby3I/NWk0rRODaWfx15ZssCIP8ER
         0jqa3KJUwOHVNksmFQAfAM7fZmXxyUqNN4GGZrHOj9yAdzNbgr/5UQj7A9g3eJjkZaLJ
         ICvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mnrJCUka6v5PVIWwhmu40awx/vnllcru90gYQxUQZ48=;
        b=P4gjijaX8yQQNEPzw68Ff0YPhLqrzLcVvc2w8ifsrneoV+8wQVpFUU+rORjE0oS1Qs
         IAT0pWU5X5MQc5FTmm+kfOgO+wA1YFbvq0GkhtgeHwjNvM7gRVx+cKr/L8jaEvoQX5tE
         NXFG/82PJy8RrdkgmCNEJvfFoYeXbU3d5WzqFMaO8FqealcxuxEM402Xg2BZPWM0awWT
         Qy8A79JI3uYrPTSWdy10C72+r67MMvXyy5u7FJRbgfpGnfVUlEvA+1JKXQ8qUcvtrpWY
         0HoewwfX8AbhzlZm47TNKe+9F5UBXwC23efjy1WV3yvl00CcxnguOoLYTtaI4MK2Mywk
         rCdA==
X-Gm-Message-State: AHPjjUijClG25XhiknTEq/z3CU/2buphU0RXkn23twFQjW0Pxil7Z91N
        M9dCaoSEh4WbxQ==
X-Google-Smtp-Source: AOwi7QA584+biUjJTgLsDz64MLeLiVkpAKkLrnfaUptN0moeoGlDoqpUaBzo4Z6WENh64VlpBThUTg==
X-Received: by 10.84.150.129 with SMTP id h1mr3879175plh.59.1505341654175;
        Wed, 13 Sep 2017 15:27:34 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id u186sm22645925pgb.35.2017.09.13.15.27.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 15:27:33 -0700 (PDT)
Date:   Wed, 13 Sep 2017 15:27:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170913222731.GQ27425@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <20170913163052.GA27425@aiede.mtv.corp.google.com>
 <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
 <xmqq377q1c0g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq377q1c0g.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> In the proposed transition plan, the treatment of various signatures
> (deliberately) makes the conversion not quite roundtrip.

That's not precisely true.  Details below.

> When existing SHA-1 history in individual clones are converted to
> NewHash, we obviously cannot re-sign the corresponding NewHash
> contents with the same PGP key, so these converted objects will
> carry only signature on SHA-1 contents.  They can still be validated
> when they are exported back to SHA-1 world via the fetch/push
> protocol, and can be validated locally by converting them back to
> SHA-1 contents and then passing the result to gpgv.

Correct.

> The plan also states, if I remember what I read correctly, that
> newly created and signed objects (this includes signed commits and
> signed tags; mergetags merely carry over what the tag object that
> was merged was signed with, so we do not have to worry about them
> unless the resulting commit that has mergetag is signed itself, but
> that is already covered by how we handle signed commits) would be
> signed both for NewHash contents and its corresponding SHA-1
> contents (after internally convering it to SHA-1 contents).

Also correct.

> would allow us to strip the signature over NewHash contents and
> derive the SHA-1 contents to be shown to the outside world while
> migration is going on and I'd imagine it would be a good practice;
> it would allow us to sign something that allows everybody to verify,
> when some participants of the project are not yet NewHash capable.

The NewHash-based signature is included in the SHA-1 content as well,
for the sake of round-tripping.  It is not stripped out.

> But the signing over SHA-1 contents has to stop at some point, when
> everybody's Git becomes completely unaware of SHA-1.  We may want to
> have a guideline in the transition plan to (1) encourage signing for
> both for quite some time, and (2) the criteria for us to decide when
> to stop.

Yes, spelling out a rough schedule is a good idea.  I'll add that.

A version of Git that is aware of NewHash should be able to verify
NewHash signatures even for users that are using SHA-1 locally for the
sake of faster fetches and pushes to SHA-1 based peers.

In addition to a new enough Git, this requires the translation table
to translate to NewHash to be present.

So the criterion (2) is largely based on how up-to-date the Git used
by users wanting to verify signatures is and whether they are willing
to tolerate the performance implications of having a translation
table.  My hope is that when communicating with peers using the same
hash function, the translation table will not add too much performance
overhead.

Thank you,
Jonathan
