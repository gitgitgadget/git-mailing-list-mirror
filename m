Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8408D1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeCYQsb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:48:31 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38505 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753525AbeCYQsa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:48:30 -0400
Received: by mail-wm0-f47.google.com with SMTP id l16so11340431wmh.3
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=754OEzCfks1q7M1D9RXQjDMJwK0YjaZ8/hwd1fl5cvE=;
        b=IuBmZFgQTwpcKi69eNwjNyAdYQZnetC9H0SmflCN+lkp5OM3Pg7g6WtWHCWY4CE3C+
         SCgtOifiY9V3wesorj2JU02H/6I6Ysm5h0EVVdVERwJ5n9RlFpJ2f7c1VQnYYff9E+iw
         /OW236FLjzEAu8978qdm6v/d6w4oQWrvoXhAUnymz6wrM9RA7SOTDcsFTFgAAONZUVYe
         blzQiJnpG5CoCuhEqZuVgplMowPmUublCIUYEQn4McTVl192HUZtNxywx0vUFGe1eB0O
         OrD4Uaa4G9kMuaVBLcyZOsZv0nZ5Lmf4EBnMOHJZS/1PmWA6u3QuR05nTcm6uwyhWZk5
         2H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=754OEzCfks1q7M1D9RXQjDMJwK0YjaZ8/hwd1fl5cvE=;
        b=byUANZJVkzmb4OoiOU5wJoORfXm/sHZyOxzEnJTZ4TKcTGcCfkpfUqhLKSMkMvTuS1
         vONVIzmxYUBpt/7fWNV83pBcz5AYf4O/C7WV0i7UH+0lXNZ1+WLmj+FASCPQyX+ww/JQ
         d4a+VarvBeAvXdrBQ8PyxsIqrgjvgAtdMj44lJIeSBMHkM6/XPlgYNa5XRRfWXGJQBk6
         hUlIhWaQyEy8gkIK9xACJaGUXGMxCNk6mQQb0kTt0BLGIkdu87CFMfEpsY7MiHw36pIy
         VxtSdgkOSfhiU/J3rTbbxRq54typgb3YY9rxxpnd/iHgYVbkR0KeNNBWlm++fMGeSGJK
         kDxg==
X-Gm-Message-State: AElRT7GkOPUK92MZKIcarVrAedyOTpb6KKBH4rJrqTIQIt32xBc8SeHS
        5+Etxgkk3NrM+Xp+J8+OKOI=
X-Google-Smtp-Source: AIpwx4+n3Wt8bBGLhjwFpgQifvYGE9XJ7qrTcDDg9B6LeYoosP3+m2bhJcv5R8m/BBrxd2WnYx/6Dw==
X-Received: by 10.28.156.196 with SMTP id f187mr5986657wme.63.1521996509266;
        Sun, 25 Mar 2018 09:48:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v4sm3837075wra.36.2018.03.25.09.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 09:48:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Yasushi SHOJI <yasushi.shoji@gmail.com>
Subject: Re: [PATCH] bisect: use oid_to_hex() for converting object_id hashes to hex strings
References: <9839073c-84ca-f00e-d0e1-801e521ef29e@web.de>
        <20180325152022.GD74743@genre.crustytoothpaste.net>
Date:   Sun, 25 Mar 2018 09:48:28 -0700
In-Reply-To: <20180325152022.GD74743@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 25 Mar 2018 15:20:22 +0000")
Message-ID: <xmqqfu4of6eb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sun, Mar 25, 2018 at 12:57:36PM +0200, René Scharfe wrote:
>> Patch generated with Coccinelle and contrib/coccinelle/object_id.cocci.
>> 
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> This is a belated follow-up to f0a6068a9f (bisect: debug: convert struct
>> object to object_id).
>
> This looks good to me.

Thanks.
