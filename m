Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0871F453
	for <e@80x24.org>; Tue,  6 Nov 2018 17:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbeKGDOq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 22:14:46 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42102 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389738AbeKGDOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 22:14:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id h21-v6so10777915edq.9
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ch+s+iopome0dve3L8YW8lKyEDOTYvismdRFpj1G8fQ=;
        b=osYDyQbtjpo4+fEfFR5MqpGKPbSkODqJtkGXuxC9QSD6YGTg8Ucmbr0ZeSkXQ35/kO
         BIGLuog7BIAdg3Hw5Q0q3YKOtq4JHSgyMNtrxoTVJiIxEhz+J7CgCrzEUPMb23ZcWnZI
         2dzy091XlUkzLN6+Ps4//fyTaqwU4h0eRbe0o8MlViRTsIVkMHrDQu6WgR4Pyl/UfcHk
         bqkhQtUkAptXrnjoVvlCmkN9SW18Av3QsQufewmI9zkk2umq+kY5ljXHDNa15twcnFen
         9bVv4SAFk+urxihu4LndIJ22oTPUDd0jT2ONVYjg55FmbxtKuhJ0N9FlMAKKh8l3V9Q7
         F56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ch+s+iopome0dve3L8YW8lKyEDOTYvismdRFpj1G8fQ=;
        b=mFmtm/bOOmQPGyUB7QzQDjTvANmAxBdNdBLjpY0o4oUs/N2x7pEfxX+ny6KpdB5/HI
         bZ/RlL1MwDr03frrdxFrmWwYQZADR6lMlxtK1OA6UgMScZs9K9XoMvJyvjLj+nCIwaoo
         hbwrHAm4Y70iTxXYI1Re5yDTkvS20lWmumyQTmh0U2EjESn5TB+d3wD8MCfhDgLzCmHJ
         X3L40p6XxPgFQfzbHmN8S7FeqyM5MF4Xz6NTBV+r7gcIX8cViq2RDTgph2XTDdrapG5X
         WrCSEAmkLcJQm/QmdH+TSbrbqih11ckVETLtPgn9IwNZ6PtB/O/YgD+3e/bpKsPQGxlO
         nmng==
X-Gm-Message-State: AGRZ1gKB1uDs6Ep8bNpeyxBJNOe9cZ4qXcgF9Qq/V9zPIA8sgLL2PPfP
        qbdLvXQnH6shTCKpfEa6ztc=
X-Google-Smtp-Source: AJdET5eyGVcfttFtlrGxfQkVTsRLDFjNSXuN1ytilRdXL3Qu81n5fwYTBFZlJ8P+osAUWpL3qW7nRg==
X-Received: by 2002:a50:977a:: with SMTP id d55-v6mr21827182edb.244.1541526504503;
        Tue, 06 Nov 2018 09:48:24 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id s14-v6sm7588866ejb.20.2018.11.06.09.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 09:48:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        andals@crustytoothpaste.net, Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
References: <20181104181026.8451-1-pclouds@gmail.com> <20181106171637.15562-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181106171637.15562-1-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 18:48:22 +0100
Message-ID: <871s7y6qs9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 06 2018, Nguyễn Thái Ngọc Duy wrote:

> OK here is a less constroversal attempt to add new trailers. Instead
> of changing the default behavior (which could be done incrementally
> later), this patch simply adds a new option --append-trailer to revert
> and cherry-pick.
>
> Both will show either
>
>     Reverts: <commit>[~<num>]
>
> or
>
>     Cherry-picked-from: <commit>[~<num>]
>
> --append-trailer could be added to more commands (e.g. merge) that
> generate commit messages if they have something for machine
> consumption.
>
> After this, perhaps we could have a config key to turn this on by
> default (for revert; for cherry-pick it will turn off "-x" too). Then
> after a couple releases, the we got good reception, we'll make it
> default?
>
> No tests, no proper commit message since I think we're still going to
> discuss a bit more before settling down.
>
> PS. maybe --append-trailer is too generic? We have --signoff which is
> also a trailer. But that one carries more weights than just "machine
> generated tags".
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

The implementation looks fine to me, but as noted in
https://public-inbox.org/git/8736se6qyc.fsf@evledraar.gmail.com/ I
wonder what the plausible end-game is. That we'll turn this on by
default in a few years, and then you can only worry about
git-interpret-trailers for repos created as of 2020 or something?

Otherwise it seems we'll need to *also* parse out the existing messages
we've added.
