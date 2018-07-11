Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CA81F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbeGKPmB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:42:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53741 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbeGKPmB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:42:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so2855708wme.3
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KdHjOIAVD1/8OZkBrKMISurUPX8NIgKf5uUpw8yxKn8=;
        b=kMPcUOSVRwiHWAE9sCFQr/FjiFvuzouWLkc7HutwzuenYwUyFsNqj4FlLcBDEZfQld
         2YujEdU+hp6dn+TPS9/uCXNXcayxUvz4ukJ6xT4+SVPEkngaj3Lp9+rpA/vIPg5Fdb1V
         mcLnYcD3Ii7sujL+vTHLrmqaUq9rec3SqKOgCORaaQi0gewt3E9wmnZ/cij31I+ooXN+
         Uvj5qit9I5ZfBbtDjuFeGwR3MZ6rvtJiBhAn7Px3+Evwj0BtnmMkQnt38kQWwG4cyi1x
         l0WZBq2yj+hntVa2kL8UENp64+UZAD6aS4ASlw2PN6PEgKDtWXcIJ6wrBgxo7GMKU2dj
         msZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KdHjOIAVD1/8OZkBrKMISurUPX8NIgKf5uUpw8yxKn8=;
        b=ZQwvhV4bP1onnD0HMoRhzHGiUvyreV/0X68F22T2G5wB9EVl5qT/4d8PJBxfdL5VYJ
         eIP/Dgiqw8VVgAEoc4v+aBUslmXarcRKlBpnoF09JQH98tLsiWbIrQUdjvuKqNJho+jc
         rSgdjk0G9cEP/GVz6uq7pN4l1iFHKONrYC2V8SvNG1rRFD/DXLpR2Wj77GiGJLvQ3qD3
         bMTFsY//oujpIrLoPEQVHypLEb77YoEcD9Xi7VlTWcbDBvdp3e8glF2NhYyGv6EjMuP5
         wvSjHnwWd7z7eP6b6wfh7WBmGAVMXH++fBDUL6zA7P980v3mGZ/Apia1KrI/Q/rDffY9
         SE5w==
X-Gm-Message-State: APt69E21QyW2181tgjcOhkIuK8Fjrro7MAfkjVIHrF0+pj6xH5fcIBCR
        nLV63aNQWFCQhNb3OegPLfSef1lf
X-Google-Smtp-Source: AAOMgpdJKxuQFjr1o7/2L/Y6TL/3u10be0P2YTWGXPBghKzcZTJ01uY4RJ2dMekBCuhUX1SZSZF8NA==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr17495361wma.63.1531323426183;
        Wed, 11 Jul 2018 08:37:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y3-v6sm1783648wmd.24.2018.07.11.08.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:37:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] de-confuse git cherry-pick --author
References: <20180709194636.GB9852@sigill.intra.peff.net>
        <20180709194912.GB7980@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807092222300.75@tvgsbejvaqbjf.bet>
        <20180710021505.GA10248@sigill.intra.peff.net>
        <20180710043120.GA1330@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807111057500.75@tvgsbejvaqbjf.bet>
Date:   Wed, 11 Jul 2018 08:37:04 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807111057500.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 11 Jul 2018 10:58:07 +0200 (DST)")
Message-ID: <xmqqr2k94wdb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> After poking at it a bit more, I've convinced myself that this is the
>> right thing, as options like "--branches" which expand into multiple
>> tips already push us into the other code path.
>> 
>> So here's a re-roll. The first one is identical except for the typo-fix
>> in the commit message.
>> 
>>   [1/2]: sequencer: handle empty-set cases consistently
>>   [2/2]: sequencer: don't say BUG on bogus input
>> 
>>  sequencer.c                     | 12 ++++++++----
>>  t/t3510-cherry-pick-sequence.sh |  7 ++++++-
>>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> ACK,
> Dscho

Thanks, both.  Queued and pushed out.
