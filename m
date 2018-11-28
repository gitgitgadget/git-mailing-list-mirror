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
	by dcvr.yhbt.net (Postfix) with ESMTP id E540C1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 14:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeK2B63 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 20:58:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42845 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2B63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 20:58:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so22320888edp.9
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 06:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oGsSt9Cbey9NGggsooIWlePFMmJfo/U0/ICCk/o6Qbw=;
        b=IbYWkbGbQTdrWpGkZNwojC9fA+l+g55wi2teqHSPFrg81FzYUh47EDxhnDebYXqGpb
         CTXOaGhVNiSzgN0yeIVe1nO5m0CEmH9ina+8yHrvmfma//+O99Vd4eiEiMbGNkQmpAsC
         uyjzang9AVx/ep/WY3aBlTKh/DECV9OPL37Q+OZglsIWBVtndXxiW5dGagwYRxFWPxJF
         3UD/0sM27P5EZOwFoFE17mO2GtDlDEkPioB68Qnht7ecdvldU8bTi+3NMY03evgxRV6d
         yKaM9vSInqp36pEZpZaHZepbytlgzmxBaGOCZB73eCliwpjru/dboYEEXy1ozJW8rFgj
         oPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oGsSt9Cbey9NGggsooIWlePFMmJfo/U0/ICCk/o6Qbw=;
        b=cCZms/ISl+uViPeKX/MIhMnPRl8GcIKGTm/PDY2XTk21L3PcOd/HDRXSmeYLTw3vcN
         iqMPYyRD7BGaNx7KaccgZlTSDk6Te14998TriiUSkUNq+gOz39LZjwHBxYOpDVnDo72Y
         lNY2HFIRVgv0VXSQdAnHEzUaOKeaZc63BQKeqdTLNrAp3/i8fsTLw75pS+eFP/Zo26pI
         lUxlD44q4ssYUF3nYv8IFWdA0pUGkDdvjph4tuoxJbFC7/iaUOVdDoDoDmGS7NuO5QtP
         eopip/WrBin4UidzmJdPOX35YqaEzWnYL2hkF4GPghXEglTMEe7aTsYDjv3n7YKnEZ96
         Wl9A==
X-Gm-Message-State: AA+aEWacZWc8OS5gzNdtssu25MpJHwNdAMXPikjitUjJENn6Qed63hRH
        NlgzCVL+/UIxu9mdk8CwKKLttaV9
X-Google-Smtp-Source: AFSGD/WZTNoYZM9X7Zxa9nXYtiltE5R9SaV6aROfhzkm+nXG4SubVAY1IHsN7IhCxsLbAj5biZyRXA==
X-Received: by 2002:a50:c299:: with SMTP id o25mr31352589edf.281.1543416991550;
        Wed, 28 Nov 2018 06:56:31 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id p16-v6sm1097774eju.73.2018.11.28.06.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 06:56:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>, max@max630.net,
        git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
References: <20181119101535.16538-1-carenas@gmail.com> <20181119184018.GA5348@jessie.local> <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com> <20181120091107.GA30542@sigill.intra.peff.net> <CAPUEsphaYBXp4V2FYqoB8-A2dyqppH=hSAaoQXGk4NMwXznCiA@mail.gmail.com> <20181121224929.GD5348@jessie.local> <CAPUEspjeiT=Odc7ENd0Qjeg=8w-+Qh9uGjL+BQXihiK1G1vkjA@mail.gmail.com> <20181122063714.GE5348@jessie.local> <CAPUEsph7z3nHjJ=idq5v0RPPjWwmGGMsbmPoyUChxUitBPeEBQ@mail.gmail.com> <20181122161722.GC28192@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181122161722.GC28192@sigill.intra.peff.net>
Date:   Wed, 28 Nov 2018 15:56:29 +0100
Message-ID: <878t1dz1wi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 22 2018, Jeff King wrote:

> On Thu, Nov 22, 2018 at 02:17:01AM -0800, Carlo Arenas wrote:
>> PS. upstreaming the PERL_PATH fix is likely to be good to do soonish
>> as I presume at least all BSD might be affected, let me know if you
>> would rather me do that instead as I suspect we might be deadlocked
>> otherwise ;)
>
> Yeah, the $PERL_PATH thing is totally orthogonal, and should graduate
> separately.

On the subject of orthagonal things: This test fails on AIX with /bin/sh
(but not /bin/bash) due to some interaction of ssize_b100dots and the
build_option function. On that system:

    $ ./git version --build-options
    git version 2.20.0-rc1
    cpu: 00FA74164C00
    no commit associated with this build
    sizeof-long: 4
    sizeof-size_t: 4

But it somehow ends up in the 'die' condition in that case statement. I
dug around briefly but couldn't find the cause, probably some limitation
in the shell constructs it supports. Just leaving a note about this...
