Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06371F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeBIVwz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:52:55 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44318 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeBIVwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:52:54 -0500
Received: by mail-wr0-f194.google.com with SMTP id v65so2828645wrc.11
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vf6xsVspdWqJQ5Bn6qwfTLR20y3cvh5Fzq0HwWifBrc=;
        b=iXF/T6iNOP/6v3FQaeTiks41FP2/9nwFNIVmQsAwP2TdszdnLIa6bH/bQcMAKOTxG0
         hxID7TAfLOWObQng5iXYpYirPx6OB3retQr7ps+7nLQDA3GsRDEI9ShP+sI9eox8Rd83
         dUO/d1hXB1L4VVP/zhhqPBmNhGFc001x4BAY015pQCCfUw3FIMKixa3vrXKyys6mr2mf
         NNunKh0gOAtG2aml41bg+c0wErNa0A54trLJrEWniGn1lzd2P0MsksisP54BhczjussI
         C8nb1hhpdS1UUa8v5mDbP8T3BrZ0MyePOyRph2hWaVY1HWGUYrql/2+UWsU5UtOVGCvX
         PcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vf6xsVspdWqJQ5Bn6qwfTLR20y3cvh5Fzq0HwWifBrc=;
        b=KraS8rWkb0gXgN0KQ4EAkX8XSUye9QL/kDCgHHuOskV288juUg3Gkh+OHkoKCH4wO/
         gI/zm2fuwVJRX6fKNNaQT0BZxvKw54PHfVKPcRH3MEWAnmefiQQHMI/sN/3z8BKdsxSA
         Ep14Jk6MJ9PYOtFlcZ+4QKGOHi/Rfmh5JWp6EgaUwU0IXWVcrYiTQnzt411n1Fl54Pnn
         LzkQ9B3FtJHZJ+c8GRoOnwE4cFhFRug/+gnjkFRjpgthvA7k4cNWUSPnPH4uXiisS/3Y
         8mwZruIwsOJ0NHn8Z9IGLJEWU6+HuSOHY7dRbzlro4ODGudEsIi8xumymsB/9Wqo0YWK
         RJ7g==
X-Gm-Message-State: APf1xPDue/GBPlGLl3Y62aZ6+dmR9Cj/VNVRVGQN2jxEY2rSmIB48MnB
        79hHNn5ukW6/d/CiG/XAHbo=
X-Google-Smtp-Source: AH8x224OWDLRsCNHagBl7a8kwwXbwkaV/4ifxkW7h8zWkURWW49dfoBlHdSwiAavWWgLXplYM3FPrg==
X-Received: by 10.223.184.102 with SMTP id u35mr3517417wrf.143.1518213173380;
        Fri, 09 Feb 2018 13:52:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e26sm2032003wre.5.2018.02.09.13.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 13:52:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] update-index doc: note a fixed bug in the untracked cache
References: <20180209210431.409-1-avarab@gmail.com>
        <xmqq6076xabo.fsf@gitster-ct.c.googlers.com>
        <20180209210431.409-2-avarab@gmail.com>
Date:   Fri, 09 Feb 2018 13:52:52 -0800
In-Reply-To: <20180209210431.409-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 9 Feb 2018 21:04:30 +0000")
Message-ID: <xmqqwozlvnij.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +Before 2.17, the untracked cache had a bug where replacing a directory
> +with a symlink to another directory could cause it to incorrectly show
> +files tracked by git as untracked. See the "status: add a failing test
> +showing a core.untrackedCache bug" commit to git.git. A workaround for
> +that was (and this might work for other undiscoverd bugs in the
> +future):

s/undiscoverd/undiscovered/

But more importantly, would it help _us_ to encourage people to
squelch the diagnoses without telling us about potential breakage, I
wonder, by telling them to do this for other undiscovered cases,
too?

Will queue with the above typofix, together with the other one.  I
am not sure if we want to say "Before 2.17", though.

> +
> +----------------
> +$ git -c core.untrackedCache=false status
> +----------------
> +
> +This bug has also been shown to affect non-symlink cases of replacing
> +a directory with a file when it comes to the internal structures of
> +the untracked cache, but no case has been found where this resulted in
> +wrong "git status" output.
> +
>  File System Monitor
>  -------------------
