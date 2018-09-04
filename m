Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8361F428
	for <e@80x24.org>; Tue,  4 Sep 2018 17:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIDVo5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:44:57 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37284 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeIDVo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:44:57 -0400
Received: by mail-vk0-f68.google.com with SMTP id 79-v6so1643851vkm.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tNZfa3i/fac16Iw3MDVvRfti4DmoKE8NSm3GnpRiR/U=;
        b=XUwvTbe/1SOSDqKMZc1PivXv84qXZHrwZSUCDvT54oeYhQbdzR+C7yDi30K4TlILJe
         Hl8rUmC3uWvOmISrN5+mp75BqSyPYssOb6II1GMGUcy49pcacyUPUXdHZxtwQ5ucU4uw
         EAonv37otRrSZdWw/Cf0okl9BRBU3OfpeqNoaDN+F+NtpomSsKYjmV3MedRejhnVc+Ae
         Li4Dz+FPb+G4UaKHz6pCxMzal+52EYr/If3+J+SkOr7iAxg/GBLZSiXQuggMbZXYuMfb
         qr6RQsCUXRkwtO2JFA7PpKy4wbh+t/xrQWqV3rgd2xMCt1V16xoRgD8MA1yVkkV2eKd1
         8tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tNZfa3i/fac16Iw3MDVvRfti4DmoKE8NSm3GnpRiR/U=;
        b=gkjTWqS2S0V2V5WbE572mWFb4+tpHR43sl83G94VsDhzNoFt1luOMsdhYpHTF0+AyJ
         9fO+ljI5eHpU6K5q4q6kRbnJckl7qvMWLSRa+qY9jVLSNPMyticBNwDKBKPfv+SPZGd1
         r6CxSiGM221KHS2gpCsBXT+Oa9BqeOtgWuEvg4Uze78aLcFIa5J+bUH0XDVUgmZMlSKR
         4B53KPL7clcf40WVCNE5ccZdYlnFXM9wyogJ8lOoe4A199nFcOTNcqtBm4kLROlDDRO8
         GWgTEefyo5EffSQxuWRtm1lxuyLQ2n9zS4JTUrR1aVmdv+Os9PwqjMTxWL+XJ2rmCAt1
         uFIA==
X-Gm-Message-State: APzg51CPFFSe2a+a2kg1cquy9RYiqYvnYwSfgXKzve3JB1TEkxE4nC7t
        cFUj8oCF+im7GWPbHjUeqog=
X-Google-Smtp-Source: ANB0VdaWujJppptr2cUHoKfC93mD4pjhmCuMSuy71o+dxF2hGyfTdN2bZLO/eeKqo37uV1jKQfHpow==
X-Received: by 2002:a1f:801:: with SMTP id 1-v6mr6580022vki.66.1536081534320;
        Tue, 04 Sep 2018 10:18:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j202-v6sm3724627vsd.24.2018.09.04.10.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 10:18:53 -0700 (PDT)
Date:   Tue, 4 Sep 2018 10:18:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>,
        git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should
 accept --author
Message-ID: <20180904171850.GA34268@aiede.svl.corp.google.com>
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de>
 <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet>
 <xmqqpny1at28.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1808301350340.71@tvgsbejvaqbjf.bet>
 <87r2igca0s.fsf@evledraar.gmail.com>
 <xmqq1sag7wxx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1sag7wxx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> I believe the "official" way, such as it is, is you just put
>> #leftoverbits in your E-Mail, then search the list archives,
>> e.g. https://public-inbox.org/git/?q=%23leftoverbits
>
> I think that technique has been around long enough to be called a
> recognised way, but I do not think it is "the" official way.  It is
> one of the efforts to allow us remember what we might want to work
> on, and focuses on not wasting too much efforts in curating.
> Another effort to allow us remember is http://crbug.com/git that is
> run by Jonathan Nieder.
>
> Anybody can participate in curating the latter.

Yes, exactly.

Ævar, if you would like to keep better track of #leftoverbits, please
feel free to make use of https://crbug.com/git/new. It even has a
"leftover bit" template you can use.

Thanks and hope that helps,
Jonathan
