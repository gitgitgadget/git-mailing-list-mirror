Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B9A1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 19:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeCZTh3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 15:37:29 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37149 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeCZTh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 15:37:28 -0400
Received: by mail-wm0-f42.google.com with SMTP id r131so10738903wmb.2
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4lLA/aVo6rTU2g/9Asze/EHRovTiPd87PRfj6/AKtz8=;
        b=UKUc3JOegBXhgyA2aZsd5E7ejAaHsUQwpkFMNgbZLgsIQw8LhsXbnPKFBUmZaqufZf
         M8jwYYRAbkTuUj5h+gGmw4tDRTbUreDmkLlib750L9Q3bzEaSgXcqlvxKUVuSDQohxJw
         70TlhRMnf0OznaWJjenIHoZvfLVhVlTPcps9NlxF6lPWgkxAWR/W79pLSt7lAXPMwUeZ
         cBMnh95vrFlM9Y5JfhuQC8VOzzztv43bJXWoe77sQKSXXyNWrTsFgmfShzTA7jNtWVjg
         DO+IDnZt5jGxx7btOEaybxjqXK8AuH2MHDNwv5Nm3sS3aH8N6fG7aqJYxQveB0RUy8dQ
         a7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4lLA/aVo6rTU2g/9Asze/EHRovTiPd87PRfj6/AKtz8=;
        b=LxaP9UNAHf4bVj97lgW4B7jR9SVbG5dsW/9q5GcCipU9P4P3hM2J2NyufJeTy8J5rT
         aoO+sx4B4n8xv7RVVhhC0jVOwql2dJEjyxJ+n2PXupdxA6sOrSEUBlhUYMjyu778eBY6
         rXcJ6erXozXpNwlZG/tSDookmzFE3d0+HN0KRKsgaa8QKGe53yfeVmr5qoZFhmADB8Rn
         uvNmf82+QrU1SpFnHZUkxM4R5FKJfAu8bnmhR302k6EPKin0XyeJC0yL7N20GfhsrZah
         0T69NLDE06j8Q1is/K/S7TN7xcYDa+ABqHvjy/JArDKG9PM5ZKysINBWfJwDK7qMvaj5
         /97w==
X-Gm-Message-State: AElRT7F/5Ea4+53QiUh9lzxJ89habO+5P/DW+35O53x4L1UjHr9eAdlU
        01x1HUu4K/iLxJrjImN/6H0=
X-Google-Smtp-Source: AIpwx4+knnHDAIJWWKg5iUKezuaAfNsXHrkCYgbvzeLNfDwwRmWTbtFw0DbwTOlH1AmjX55T69WvvA==
X-Received: by 10.28.0.72 with SMTP id 69mr9988076wma.105.1522093046554;
        Mon, 26 Mar 2018 12:37:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 95sm17533894wrb.47.2018.03.26.12.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 12:37:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
        <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
        <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
        <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
        <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
        <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
        <xmqqd0zqd8dw.fsf@gitster-ct.c.googlers.com>
        <3d845e99-e392-a62f-b83e-33b58482fc54@jeffhostetler.com>
        <CAKk8isp_qx1ajgRryhBw6TYBoaa8fJU6hP3JyUWAx20knQSLXA@mail.gmail.com>
Date:   Mon, 26 Mar 2018 12:37:24 -0700
In-Reply-To: <CAKk8isp_qx1ajgRryhBw6TYBoaa8fJU6hP3JyUWAx20knQSLXA@mail.gmail.com>
        (Wink Saville's message of "Mon, 26 Mar 2018 11:43:46 -0700")
Message-ID: <xmqqtvt2bpcb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Should we add a "_Static_assert" that sizeof(uintmax_t) >= sizeof(uint64_t) ?

If that expression compiles, then both types are understood by the
platform.  Because

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stdint.h.html

tells us:

    Greatest-width integer types

    The following type designates a signed integer type capable of
    representing any value of any signed integer type: intmax_t

    The following type designates an unsigned integer type capable of
    representing any value of any unsigned integer type: uintmax_t

    These types are required.

we know what that expression evaluates to, no?

