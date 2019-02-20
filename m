Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797521F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfBTLRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:17:09 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41638 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBTLRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:17:09 -0500
Received: by mail-wr1-f51.google.com with SMTP id n2so13341480wrw.8
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Yx90io3oQN6lvhsrFRfHQj7zTnpUzY/vxnpAUV48a2U=;
        b=ZPfjEfrhGIs9eGrcaXa4BEskkaBwQ6ae0a1ESANYsuRHHMZklKhtS1UJie7a9MT+/c
         75sk/Sk61YmkJA0+McYUkEw38n6qPHTLNg707xkZSZyUCe4ubSyRp+3dm//VSnvSwziG
         RYJFlSXlag8ndOLrTBnYN0A4FO7e6LU0+k4xHdZOC0iRIdzSnvI1SwnG5lejeHVlvLF2
         L3+j4Y8U+5q7MNW5mxpWeaoVlwBQScyNntu/kA9HNHkKziC1l1+AjYgT/A2FDzr16Hfq
         gdDvsCxKbKKfaF8vCWZOWV0ZMT2IpKoVeS5VmrfishrW7LteAuAg0KwpT816Z2+mi3y+
         Lfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Yx90io3oQN6lvhsrFRfHQj7zTnpUzY/vxnpAUV48a2U=;
        b=ON0ESvAnEFKC+soO6f4C/CKiAsoV3hWdZND5C5k5klBsV1APIPPDHHAzs1voJwubcQ
         Bo9jIy28wLvZvJmE9DJux/GRyPqfIrffmHtIC/PJFRkJiRcVdyDsLJ9B4xVALdyGL4TG
         /zMfyphNXujqs44OaEQMkqcuLuGqUKgS9Txqn+N4LbvWEuESep7GVFFaY2X3020Ayp+L
         7UWjBxn9j/uSrlcHNYnD9ywt4rwyjaoxbWH/rHJTJ+/E+JJz8Lw0+3NWUZQZGAUjlzGq
         xHS7ytLQUI6GYMsDsFpOKV+uJ+33KF+VOKr/huXRgHZEeqcIveno/jNGV2y+M62OGrRW
         8xRA==
X-Gm-Message-State: AHQUAuZlwETF0M+G7+tHEOiQ3kpfzpAiN86y4mJZVZbrxEMTSGwQ5Q/b
        3KRf9Va+LkZhCjQUmt+72cdbbUFu
X-Google-Smtp-Source: AHgI3IYUbfawR9Uxwzki21fxmJ8ka6zHxCQgkKfSeRhiKtTeleDhzAQCp2RQq5bQbC0/YMG9u3Tx/g==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr15325777wru.242.1550661427263;
        Wed, 20 Feb 2019 03:17:07 -0800 (PST)
Received: from szeder.dev (x4db9774d.dyn.telefonica.de. [77.185.119.77])
        by smtp.gmail.com with ESMTPSA id j124sm5349224wmb.48.2019.02.20.03.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:17:06 -0800 (PST)
Date:   Wed, 20 Feb 2019 12:17:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        msuchanek@suse.de, jpyeron@pdinc.us
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
Message-ID: <20190220111703.GP1622@szeder.dev>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
 <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com>
 <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
 <20190219100136.GO1622@szeder.dev>
 <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1902191547510.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 03:58:00PM +0100, Johannes Schindelin wrote:
> On Tue, 19 Feb 2019, SZEDER Gábor wrote:
> 
> > On Tue, Feb 19, 2019 at 09:02:43AM +0100, Senol Yazici wrote:
> > > 1. Dictator
> > > Concern: "Bad" connotation.
> > 
> > "Benevolent dictator" is a well-established term in open source
> > projects, and it has an inherently good connotation.
> 
> It is a well-established term, alright. Does it have an inherently good
> connotation? No, absolutely not. Every time anybody calls me the BDFL of
> Git for Windows, it annoys me, to say the least.

I would consider this an honour, but I'm not in danger of being
labelled as such.


> > > Suggestion for substitution: Principal or principal integrator.
> > 
> > These are poor substitutions.
> 
> I agree that those are poor substitutions, but shooting down without
> giving better alternatives is a poor way to reply ;-)

I'm not interested in changing these words, but I'd like to prevent
making things worse, so I'll leave the burden of providing better
alternatives with those who actually want to pursue these changes.

