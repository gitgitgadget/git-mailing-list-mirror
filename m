Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7A71F42B
	for <e@80x24.org>; Thu,  6 Sep 2018 08:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeIFMiD (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 08:38:03 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37738 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFMiD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 08:38:03 -0400
Received: by mail-wr1-f54.google.com with SMTP id u12-v6so10289535wrr.4
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aFNA93i4dhOxj1ckS7ECDfuCpGLP/rUv2NVngrbDrY8=;
        b=RJvePyjjSC9OFyoQD/Rfk97KnoXdjMfklOwUmrX4FNO3zKznHPMzHu1+8IKBjHiVnz
         GfbIp0YC/3rprg5W/Q6M+zT9NbyXJpu6KpCr0zYQrsr/l49R3oeqrutlBQv0Lr2+A+Gb
         XKG2ceMedr3hDr89oRmhTsm0+dUBwBUNx/zCN2c2OGNS1u4UIHfJHc8dGbf4ruX+haML
         YRREKEZ+zWZ7obwRv8egGRbb3VK/qqxVZRr0ACqOHuodoNcStxxJ5otWRp9A9TDMmqzh
         h5ui49li2Cf/gwA1eB0JjPdYmeIcMOKx18TiwJ9DExxJokkXWlC+9OvVOlrh18rl2DID
         y63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=aFNA93i4dhOxj1ckS7ECDfuCpGLP/rUv2NVngrbDrY8=;
        b=F7FGArvF03oZ/0Jag9tFirOBVRYGyNLJaglRR+4HZTibZW5nZVe62Nq8RPvHdFQlcM
         aVXA/WYxnQZQ/Klf2lZd75jmoTgfzzvW45/RcDlXceJYfClYPb774AOqw7UCLlwmaci6
         X/aZf2qrGeFgcQzshOAQW7H45MEB9B2BFO41zWnlNML+ZP7NtckgnXfl5SZBPcwSw+2h
         MNfEUKAz88v8DQcN+f3RNCQ24m4EcgqFRd4tBcx4qwn/Oh4tioLxA+SsBMNGTCxF84mc
         Z/MuGeELKTvWXvQktwIQJQzQun5U5fGoydCi57+1Y5IZbqTy9CBVQRdXmr8o5zFZAPIx
         jG9w==
X-Gm-Message-State: APzg51AWIbyDxfX2Lr7DDbofttx8tnMQwSe4/ulVbG4mPjNzF3j56Bn4
        3Mb3JLfRnhwmjCJFMTat71jO/wTv
X-Google-Smtp-Source: ANB0VdY97SsWdCSR0MnbGbEyHeQdpeF3Ozbr9U1TrVsmh7X+NJEt1mkEy12nEQP4+ahm7Av7FK+9ig==
X-Received: by 2002:adf:e2c5:: with SMTP id d5-v6mr1347796wrj.139.1536221029665;
        Thu, 06 Sep 2018 01:03:49 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b124-v6sm4440317wmh.17.2018.09.06.01.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 01:03:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/5] t0090: disable GIT_TEST_SPLIT_INDEX for the test checking split index
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-3-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906024810.8074-3-szeder.dev@gmail.com>
Date:   Thu, 06 Sep 2018 10:03:48 +0200
Message-ID: <87zhwvqcgr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, SZEDER Gábor wrote:
>  '
>
> +

^ stray newline being added here that shouldn't be added.
