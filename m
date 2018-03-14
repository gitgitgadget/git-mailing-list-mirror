Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32F5F1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 22:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeCNWlx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 18:41:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33796 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNWlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 18:41:53 -0400
Received: by mail-wr0-f195.google.com with SMTP id o8so6416567wra.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EtRV2Ipnc+YRt/7nDBVrgrGA0vWT79cR04v+uTRXSJU=;
        b=eO6BM4dJ0HpjOMa2+mzsjzZurnl5wJOuOXf57LgeJWMQ7VuiH1OtIP2Z/6EO3SwNit
         gDFu+kCH23kiAU1mZGT58a1OIjrAKjcdxZDanXhVw57V9zhq7V0RcWxp4d+5r6IPmfD8
         gf8+BS6qERQ6USCzdG/3wj9Cv+290CYG01V3q043EnjgSZnhVtMnfoM/6/OXu0JuQOVv
         L/8eUlL6MxOFrRDcrLbUAA4rppkYkUaIDBHAmjjILaSbU86iGPOoQZFtc2Uk0naBbxHY
         tcfmk3Ukg9HWQKB5rZKeicc2ZZkMOM2JHG9nzQpkHlcULgZqhUTl0nmQEP31GyuOlSeR
         9N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EtRV2Ipnc+YRt/7nDBVrgrGA0vWT79cR04v+uTRXSJU=;
        b=RyrHWUh/KvZucuEq04fY5BgLOvCwmCcMnJ8sDDuLRZxCABVQXrRnog6EV4mIbesJLy
         63rFvquXoqs7ew36/sz/YMZtcFtMEykfIrZdYB+RW9qKiXlglW1IPcJ2yt8OUz29XL7E
         JehzdRHCFciLV53/2RurnyxhCxZVoFxP3msQTDeTxtShkOKdMntzNklMDT0HaAVit5AA
         xzMEDgceEePlkV2yVSC4Flyq3Bi8stD/q337E2lhHjKEDPBo8FS/r39skA8SfVAmuPFM
         qL98IFjuc/ATT+PV0ilkww2FqYSOROIslK0+zibR0MqIT00Vx24AiKL4jhnernDoXwcv
         WlYA==
X-Gm-Message-State: AElRT7FV8NL9/mlTUmHsr5JMIa5D3/7UxV3gEFahInpCNOaPP2BKNjtG
        +v/nkZfmjSxE3xB+9DLziOk=
X-Google-Smtp-Source: AG47ELv8LCC+Ox8b7X3LLOEZhlDAby9UkX7pkRe/kDW/0rZfjUIhLSIlyXDyOszd0IpjVhTX0DwodQ==
X-Received: by 10.223.179.211 with SMTP id x19mr5220481wrd.175.1521067311411;
        Wed, 14 Mar 2018 15:41:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a63sm4791435wrc.22.2018.03.14.15.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 15:41:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 0/3] Switch the default PCRE from v1 to v2 + configure fixes
References: <20180311132609.32154-1-avarab@gmail.com>
Date:   Wed, 14 Mar 2018 15:41:50 -0700
In-Reply-To: <20180311132609.32154-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 11 Mar 2018 13:26:06 +0000")
Message-ID: <xmqqo9jqxosx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This small series makes USE_LIBPCRE=YesPlease mean
> USE_LIBPCRE2=YesPlease, instead of USE_LIBPCRE1=YesPlease is it does
> now. Along the way I fixed a couple of minor issues in the PCRE
> detection in the autoconf script.
>
> Ævar Arnfjörð Bjarmason (3):
>   configure: fix a regression in PCRE v1 detection
>   configure: detect redundant --with-libpcre & --with-libpcre1
>   Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1
>
>  Makefile     | 26 +++++++++++++-------------
>  configure.ac | 26 +++++++++++++++-----------
>  2 files changed, 28 insertions(+), 24 deletions(-)

Makes sense.  Will queue.
