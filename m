Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9021F453
	for <e@80x24.org>; Tue, 23 Oct 2018 10:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJWSk2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:40:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43708 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeJWSk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:40:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so1048617eds.10
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JDMLZh9JzHQ/U/FNpN/N6PTXZfr6jdvWS839jPv7aow=;
        b=CaWVfiVMZ4/LoLzBOUQ97TTFgBtLTlKUdP9zKQjiWb0ENKwgWhLHeSVWfi9LfYi6I3
         EvWYZRtzyQn4xzB5RMLnSUCmKEqb5NRwgKZuXwqG+sn2jfgnL39iF14N1ik6Y9kYUV/3
         iFtfqPpzHXmXRK7WANGHE6I0914II1wSAPhhEv5r2iyvaFIIqezlbWEMvO4xV9cunUda
         47oVdXyFXjjiRs3Jnt5bxspo/2v5DyB58seW1srTyx3uFKg9yDrdL6DyAG0nmok2BzM8
         KlklOC1HXEIL53fL8xGWwy+nUGFu+S2xZCole8M699XU382MxAfrTHojwwKj8K/y37w8
         t+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JDMLZh9JzHQ/U/FNpN/N6PTXZfr6jdvWS839jPv7aow=;
        b=ZoEdLule1UsLsxlnbbN9n453RwcV434Pnbat7ERXGaggFbMG0bUcYrfe4nMn2f3EMR
         IIM/egVDxQlTmXgWvAHcQ0xS5i1fy57GoXEKtS5UpzEJbiTlgubAYhOBp4ZWZvy48hF4
         EjU3pSfEIux9cX6s/x+EZWsA3g76bC7VOYTgv0VMF4ih3duwY50ATTI6MOAoF5C+bFpH
         zqXg0HIcdWN7miXIP0+SQG8vjTDByYSFM/YjmvJopVi/WQNhl1UTSuPV3B6m6lpZTowx
         UDozUcJzTrarfS63bhtUfXDRZB+fvDuNU7xCfZmw9EkzzFzk9S960wupW/5dXAHoMnH/
         dHnA==
X-Gm-Message-State: ABuFfoiXEwnbYytS7FCVzY18rSeTcJSFWsv5rrL+9rA6GF+ib0fNf5S4
        78jpa35MNTtk747hypEudtI=
X-Google-Smtp-Source: AJdET5eXtl7X/oMflMWp0M1J/a8ua5GJC57gUmH2ehM6F84fNbBr7JhdE36n7TmQmkaP59hvq2vlIg==
X-Received: by 2002:a17:906:2545:: with SMTP id j5-v6mr6004464ejb.229.1540289860747;
        Tue, 23 Oct 2018 03:17:40 -0700 (PDT)
Received: from evledraar (223-81-146-85.ftth.glasoperator.nl. [85.146.81.223])
        by smtp.gmail.com with ESMTPSA id y21-v6sm267702eje.45.2018.10.23.03.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:17:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
References: <20181022153633.31757-1-pclouds@gmail.com> <878t2pd6yu.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet>
Date:   Tue, 23 Oct 2018 12:17:38 +0200
Message-ID: <8736sxc6gt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 23 2018, Johannes Schindelin wrote:

> Hi Ævar,
>
> On Mon, 22 Oct 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> So I think the only reason to keep it [GETTEXT_POISON] compile-time is
>> performance, but I don't think that matters. It's not like we're
>> printing gigabytes of _() formatted output. Everything where formatting
>> matters is plumbing which doesn't use this API. These messages are
>> always for human consumption.
>
> Well, let's make sure that your impression is correct before going too
> far. I, too, had the impression that gettext cannot possibly be expensive,
> especifally in Git for Windows' settings, where we do not even ship
> translations. Yet see the commit message of cc5e1bf99247 (gettext: avoid
> initialization if the locale dir is not present, 2018-04-21):
>
> 	The runtime of a simple `git.exe version` call on Windows is
> 	currently dominated by the gettext setup, adding a whopping ~150ms
> 	to the ~210ms total.
>
> I would be in favor of your change to make this a runtime option, of
> course, as long as it does not affect performance greatly (in particular
> on Windows, where we fight an uphill battle to make Git faster).

How expensive gettext() may or may not be isn't relevant to the
GETTEXT_POISON compile-time option.

The effect of what I'm suggesting here, and which my WIP patch in
<875zxtd59e.fsf@evledraar.gmail.com> implements is that we'd do a
one-time getenv() for each process that prints a _() message that we
aren't doing now, and for each message call a function that would check
a boolean "are we in poison mode" static global variable.

Perhaps some of that's expensive on Windows, but given the recent
patches by Microsoft employees to add GIT_TEST_* env options I assumed
not, but in any case it won't have anything to do with how expensive
gettext may or may not be, you'll already be paying that cost now (or
not, with NO_GETTEXT).
