Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078031F597
	for <e@80x24.org>; Fri, 27 Jul 2018 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbeG0UnE (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 16:43:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38484 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbeG0UnE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 16:43:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so6076697wro.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WkfUJk3dyVxbPL4dzbpm3ejqPnXv3jvfdyWvmB63/3o=;
        b=WCVxAeC2u95+Lk6+Zbi58l65HCoEjNW8D9wU8V9UIPtZegJ5Oyr6pSe5pYwgkxRlpn
         L6dYflZXjBjqxBVmzk6sNjaAwR2U7+aEodfHxNSdrVaal14/Mj1f0yFAp86l34uLfxnz
         g0xt9Avf1eIXpBftlzGEDMhkDj4J28webhnNXcr5OvXh/D6H1grKSDww27MqMXvvMOQT
         k2UqShJp5RU+/6ZwnBaS5aMM8J445xZRimO2Zk3zmpJu8/eD30zj/092qORhvJ5jqdr1
         EQi7J9Y6038yJpT0EkA9neHrosm3LD5TJm9dnURm0oGOWex5xL20XdohqQQgNar1jK7x
         Xisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WkfUJk3dyVxbPL4dzbpm3ejqPnXv3jvfdyWvmB63/3o=;
        b=abuiCapPZSJmDT9/xX7OUwGpvAW3eueMEMIpOCof0iMwNA4LP6GzJKmbhxXbYPLmh0
         /uXP3mmJA+hfUHhJD/W1YNuVJtLUHrfNiWkjgyJcQzmVO0uwT884f1twhOcKCSeu1BW9
         MHf1WREXYa15pU0GO+SmXN52c7nsz1fZKHSqaB+yj+6/OYrK8yk9LwMLjDsVRA2gxtUm
         guvsDHzYXtlIM1cq+lyhMbM9yPCH5dG9bzMEGBlOXqTFTEzawr7PQEk+b1Y77fB7kicK
         LM9NbYUmBeUuEnCAXDd+5uJaGVPZD1U6yTmamlRlFrvLJcDHNQj7/7quQDrBSsYjH5Eh
         A51A==
X-Gm-Message-State: AOUpUlGp8SFXY8kM0CeSWdxU2n5WcMW9+DNONfOPk3tzLo+oIMAttuGO
        pGIgHeOX/yl7PSGQYC6/8BA=
X-Google-Smtp-Source: AAOMgpdQD15aig9ZlDYsOH9CM1G82UBWRsX9jozLvoU3tHh8MWKhfnPJPbbfnLBu9MbY019DvYssVQ==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr5862675wrr.280.1532719186548;
        Fri, 27 Jul 2018 12:19:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u18-v6sm9432952wrm.80.2018.07.27.12.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:19:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 02/10] config doc: don't describe *.fetchObjects twice
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-3-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 12:19:45 -0700
In-Reply-To: <20180727143720.14948-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:12 +0000")
Message-ID: <xmqqr2jomqpa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Refer readers of fetch.fsckObjects and receive.fsckObjects to
> transfer.fsckObjects instead of repeating the description at each
> location.
>
> I don't think this description of them makes much sense, but for now
> I'm just moving the existing documentation around. Making it better
> will be done in a later patch.

Good clean-up to make them better in a later step, which makes sense.
