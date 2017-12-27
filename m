Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAE81F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752637AbdL0Xml (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:42:41 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:42782 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdL0Xmk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:42:40 -0500
Received: by mail-io0-f193.google.com with SMTP id x67so30615549ioi.9
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lmq1WvCHsvQiBIPY2h4Yx7sErBjOPURfCN0DwEODJuY=;
        b=eHgUsKoyurMuez+ZsIy0Lk0enT+GOg0nANWzBnyd27E39xPCvo4Q+KiGo39Bidj7LY
         YPspLH4KTjeoDx2WmnIPumQqNBuAM7XVFtSQ8tv4k78Kx0cMBxeToarzb5hFSsNKyePs
         OCm3DHdfgZj3ZtPHz3sSLxBmN7q/2eWqo9hTZsaD7Y28vPJybP4EVczciNz6XGe0gjsl
         jaQ/buJOkedE1bSh9gqXgRA/4Rg0qGkB9DE8jXYd0Of3UAI00KQB8j2bq3E6HyOx/74t
         qQI2adlVt+2g3nMEXb/wHM1ErgAzYqPOpqcd/1UWBuYKNNOQ+npklVIA/8tVOl2yIJwU
         OkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lmq1WvCHsvQiBIPY2h4Yx7sErBjOPURfCN0DwEODJuY=;
        b=WBk1RqEDtHfD0CWvzZyb0YkSt7h19z3fXYEERo/sdSbNW3piGVTRlVDuzH4s7OHEkh
         Jm8fuC8yR4HkLovaST2skbOXx8u43pweZF92MNtPTccoguu+Ft9P/cthAqL+r4b9q/Xr
         jX0kQvNUeQJ2NiCRhs/88kUpVwrRlum3fA/sUlz61nZEZ+K6LwB55vY8Oi15gt8bTvD9
         skLPLe0xYlKQ3hwV/eqnSEVOVyLT57emJJ+jJD8W9pfYpXpvzsmvU3zUQ9BqlnAllQ4Q
         p0oZGycthHqCnjr/eMV1srebrJ2mHkUNKK/JQ65dau8XVXg6MrIG0oJSvThDtHp0VpLz
         NCLQ==
X-Gm-Message-State: AKGB3mLEf1tlsCPr/fkVA8K5ImbOMFN4dJpNk5zvBbDO8rMhx446A0Sf
        bFSwm899RsehN3nK1SC7sZc=
X-Google-Smtp-Source: ACJfBov7kQrjSSQevgs7sWvS29Cb3BvN3d1EmfhGm6UE4GqiAeppdzSVApFMAo4PvUe0frqhqpXzwg==
X-Received: by 10.107.191.6 with SMTP id p6mr991553iof.278.1514418159495;
        Wed, 27 Dec 2017 15:42:39 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t23sm11144812ite.36.2017.12.27.15.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 15:42:39 -0800 (PST)
Date:   Wed, 27 Dec 2017 15:42:37 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com
Subject: Re: [PATCH 2/2] Windows: stop supplying BLK_SHA1=YesPlease by default
Message-ID: <20171227234237.GC181628@aiede.mtv.corp.google.com>
References: <20171227230038.14386-1-avarab@gmail.com>
 <20171227230038.14386-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171227230038.14386-3-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+git-for-windows
Ævar Arnfjörð Bjarmason wrote:

> Using BLK_SHA1 in lieu of the OpenSSL routines was done in [1], but
> since DC_SHA1 is now the default for git in general it makes sense for
> Windows to use that too, this looks like something that was missed
> back in [2].
>
> As noted in [3] OpenSSL has a performance benefit compared to BLK_SHA1
> on MinGW, so perhaps that and the Windows default should be changed
> around again, but that's a topic for another series, it seems clear
> that this specific flag is nobody's explicit intention.

I have some memory of performance issues on Windows when DC_SHA1 was
introduced leading to interest in a mixed configuration with DC_SHA1
only being used where it is security sensitive (e.g. for object naming
but not for packfile trailers).

Did anything come of that?

In any event removing this BLK_SHA1 setting looks like a good change
to me, but I'd rather that Windows folks weigh in.

Thanks,
Jonathan

[...]
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -361,7 +361,6 @@ ifeq ($(uname_S),Windows)
>  	NO_REGEX = YesPlease
>  	NO_GETTEXT = YesPlease
>  	NO_PYTHON = YesPlease
> -	BLK_SHA1 = YesPlease
>  	ETAGS_TARGET = ETAGS
>  	NO_INET_PTON = YesPlease
>  	NO_INET_NTOP = YesPlease
