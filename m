Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C78F20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 21:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKVYi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 16:24:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33052 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 16:24:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so13823181eds.0
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 13:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=op7iGpNyt9rBEH8tJ+FrMvV8/YJwF5uodLrA3mxp0Hg=;
        b=VWTIhfP8niGtVym30B+zTbCkFve/mJVqTqIceR9RsFANpmE91b4cljNTYth+n8AM/W
         WmwD4JtY3pCK7Ko60sLuJd2Idwnjw6G0Y/cfVCxd6Xg2JLK10VnRc48rINj3EwWOi7iY
         zMO8l3CxRMqITvG0/gUKVQcMJv+m3/FSKCr3qGHVKMGGn7x9R20tRGEyAof1vanlIB3N
         ft2cPGPiXKJk1kXBImoS6vlSoF1LZ4dieTYHAjqZeIxpX6QsH3VcwTb5JIKZo86G01JN
         jQ4JOrQBT2AEQsY+w4SY1BALiTaCnCAGnxQ+QcZGvssjpNGjn+HjDWEucSfdxqpLffRP
         T94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=op7iGpNyt9rBEH8tJ+FrMvV8/YJwF5uodLrA3mxp0Hg=;
        b=FJFqVe63nODr++WRRGAR49oy5yrS7Pc5iU+6OjDQ5ZB3TgGSNzwx9xbHH6TGlRp80F
         2sYj7WMMtGkvfHWkA9o01GOahtcxLLzdFzZTX3a9MZBNnKGobB8wIcdCEQOhLBcvrH5u
         vBzf+14Zm/utvId/zzP9W97joUICI3Lq8Mh5PvjqesjkhVmqFjoy7aZoQD2wBQKwq/qH
         2lRUkN3y5W9D5eRkXLXCcwAgn/izoVdUfkQ0rNSsfSEr7pgkalAlZ6jnwNYmJyOcasyF
         A5FBxth71G/IBCnBXcWxVmoQ9yQduYfov35HmHdq/7mHRRcsx/J3uzensp4OvK7zMja5
         EYfQ==
X-Gm-Message-State: AA+aEWalwnM8Ydye/xAKuockBzsFT5aMk2+YZThdYqe2Pxw05CTgONoy
        /EpcyoGpgYE1y0DQJxHa1Vhqh7uT0uE=
X-Google-Smtp-Source: AFSGD/WJLY6x/TcllnMXYmEb3vaF0JoX8efi3JtIGomCpZ7dPf26kUfC4CGbqi48A7SU6s4lPMGTrg==
X-Received: by 2002:a50:ea8d:: with SMTP id d13mr16370436edo.126.1544563475922;
        Tue, 11 Dec 2018 13:24:35 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id w13sm4283100edl.54.2018.12.11.13.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:24:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/3] Add a GIT_TEST_PROTOCOL_VERSION=X test mode
References: <20181211135501.GA13731@sigill.intra.peff.net> <20181211212135.21126-1-avarab@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181211212135.21126-1-avarab@gmail.com>
Date:   Tue, 11 Dec 2018 22:24:34 +0100
Message-ID: <87y38vn4dp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 11 2018, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Dec 11 2018, Jeff King wrote:
>
>> On Tue, Dec 11, 2018 at 12:45:16PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>
>>> >     I don't know if there's a good solution. I tried running the whole
>>> >     test suite with v2 as the default. It does find this bug, but it has
>>> >     a bunch of other problems (notably fetch-pack won't run as v2, but
>>> >     some other tests I think also depend on v0's reachability rules,
>>> >     which v2 is documented not to enforce).
>>>
>>> I think a global test mode for it would be a very good idea.
>>
>> Yeah, but somebody needs to pick through the dozens of false positives
>> for it to be useful.
>
> Here's that test mode. As noted in 3/3 there may be more bugs revealed
> by this, but let's first start by marking where the behavior differs.

...and I forgot to mention. This goes on top of Jeff's series here to
fix this "hidden refs" case.

> Ævar Arnfjörð Bjarmason (3):
>   tests: add a special setup where for protocol.version
>   tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=1
>   tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
>
>  protocol.c                           | 13 ++++++++++++-
>  t/README                             |  4 ++++
>  t/t0410-partial-clone.sh             |  1 +
>  t/t5400-send-pack.sh                 |  2 +-
>  t/t5500-fetch-pack.sh                |  4 +++-
>  t/t5503-tagfollow.sh                 |  8 ++++----
>  t/t5512-ls-remote.sh                 |  8 ++++----
>  t/t5515-fetch-merge-logic.sh         |  1 +
>  t/t5516-fetch-push.sh                |  4 +++-
>  t/t5537-fetch-shallow.sh             |  3 ++-
>  t/t5552-skipping-fetch-negotiator.sh |  1 +
>  t/t5601-clone.sh                     |  1 +
>  t/t5616-partial-clone.sh             |  3 ++-
>  t/t5700-protocol-v1.sh               |  1 +
>  t/t5702-protocol-v2.sh               |  1 +
>  t/t7406-submodule-update.sh          |  3 ++-
>  16 files changed, 43 insertions(+), 15 deletions(-)
