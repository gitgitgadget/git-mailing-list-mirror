Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D521F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeG3QXN (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:23:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45341 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbeG3QXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:23:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id f12-v6so3284277wrv.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1BR4xcwatqaAn+ogU7FN+eAxxUG50v1PCQ7vSTiiHx8=;
        b=kQ/Vc0c834tU3pMKaQbaD6M/49GZOffbSG3ZJDKU/sNq+SEluO6r4xl/rx2gjM3TQJ
         6VnxXjkv22bdH/8ZAFE8J3Em7vxu6OkW6p5dwaqQj38LKjZuWJpT34NLPQ9rCjBcOk+P
         uyk3lfT0+JvcXWKK9sjZ3j2fXL/v0HSoFs1Mxsm9PTL4rFHt3MzNB5FpJhZ3HMiX7d3P
         DpseFyCY2AoPLiHapjHu8JJbrXhoDLOCQHYla9mERJ++QXdbv72JrCRRasuv5pjzN4/c
         /nKXf/iRomDLm75zu13AxZCINuG8MdNWftsdUmcoQiS9IGZmDqOI7klYS4OE1HPgYupI
         GOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1BR4xcwatqaAn+ogU7FN+eAxxUG50v1PCQ7vSTiiHx8=;
        b=VI1q0pVB8CIAqs9L5cvrD3Nd8VfLizv7viM6bzdZxsFTs2fAAmfZhQbvPgUf4NvSXT
         H18KGpXfrd7Hd8HpcwKvAdpIzIwChkhflx63KWac9SOdIOEPXQKMW918kRVnmoeFUa1b
         9wMeHY6ZifbDGLI57Fx5aoPv2OEvKSW8IWBgpjcmpsEwA4Nf8AUjwDNmaUewYr1KwM5m
         z/dJhb2A4qZIHNhqJlAVdyDf/PGvrQdR8eF4tjOcbMx3ulbOg+OqwRO76U8w9Re79k2n
         pd3GbrRjrdwFFA6/RaxDMhtCHvgj3phHLxOwKySxp5PHBAM49Ut+I6Nf0w5itasM7GgJ
         pr2Q==
X-Gm-Message-State: AOUpUlH/oCKjJWS+Pqx1rS4GK3FS4re7Ce/PjZ3drBNZlCQtzGETAHhR
        64Rsfc0lj1gX1n4VwKkMWNs=
X-Google-Smtp-Source: AAOMgpdmpVQmZV+JouKtv8IFaVjT6P9fRke3Kb/uKQFYLijBrsWxJwncuyDrNK+6cINA4Ce5wDZNPw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13-v6mr17552736wru.80.1532962071398;
        Mon, 30 Jul 2018 07:47:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h5-v6sm14423185wrr.19.2018.07.30.07.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 07:47:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 10/10] fsck: test and document unknown fsck.<msg-id> values
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-11-avarab@gmail.com>
        <xmqqbmasl5hq.fsf@gitster-ct.c.googlers.com>
        <8736w3v51a.fsf@evledraar.gmail.com>
Date:   Mon, 30 Jul 2018 07:47:50 -0700
In-Reply-To: <8736w3v51a.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 28 Jul 2018 15:55:13 +0200")
Message-ID: <xmqqd0v4kcfd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> When fsck.<msg-id> is set to an unknown value it'll cause "fsck" to
>>> die, but the same is not rue of the "fetch" and "receive"
>>> variants. Document this and test for it.
> ...
> We could change it. This is just something I ran into and figured it
> should be tested / documented, and didn't feel any need to change it
> myself.
>
> The current behavior is probably more of an organically grown
> accident. Maybe we should make all of these warn.

Or die.  I do agree with your assessment that the discrepancy was
not designed, and my inclination for a correctness-centered feature
like fsck is to err on the side of caution, rather than letting a
misconfiguration pass unintended kinds of breakages through.

Thanks.

