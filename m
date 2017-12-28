Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 510BC1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 11:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbdL1LRv (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 06:17:51 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41128 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdL1LRu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 06:17:50 -0500
Received: by mail-wr0-f193.google.com with SMTP id p69so30080176wrb.8
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ETdhiSJ8IfYZL/klxwSVxOL/QHbBuaFi0rO0lmh8hok=;
        b=GOyOeHa+Lmkq2uBpZH/e0QHZ9jSf8ngmZ62gESoHiz/OGYC8mLe5jHycw+nEUnQssH
         CpoKu8kXn5PprUYTgC0qYML8OPf0DMesMy292xGUxDnRhEbb11KBvpJJZuKxvboUK9r4
         G/wQjhO2MgkUtkT5VHKEXFIP0eqkpl1cKOKhrkF+/SEwSthuyFm4eAkeFywaK6MnzWQW
         YjfJ2d0WJhErdl8rr+tPJIp2ZSQpOU5vO68OJXqEEb5VvHUYBdJRL67jGlZz9+rKPDej
         4al50VLimqxCOOSd3D8z0bN8SlkcPStNB+N0N194djMcfMnaFQDZ15BtcYCcFXfnTxUJ
         gxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ETdhiSJ8IfYZL/klxwSVxOL/QHbBuaFi0rO0lmh8hok=;
        b=mOmzbclOpPEVcakSrJIjdsX/jmiUMvwFFdefqEPVnOMHCyw7ONalQISTDcH5QIrCwh
         aPSNVz93h/CW2DwNNMnneVpLSKADQ1pqicNPEbPA1aEQuAxZdH3N34M1+NrV7RsUbgP6
         WrXxBrui74sv0eRqdSvzwSr2Tv3Kr7yLctMe3gdiqWT+QWzjG5M46A/JO1kM6IsGSvs0
         KsBA2j5+FqOZE6Trfad31jjqHpEEasRIC5xkiFTiltT24PtF3yIISiiXCO5yfR6fmcyu
         BJakBmsk9sL+s7LAeEzxRXOXclSkhLwN4rm30w8z0x/FJn6rwQVyWbq+VgMffMxY6Lal
         bGVw==
X-Gm-Message-State: AKGB3mJXE3qZq+2guNhAQMR2VEN38NbA1XETGvU5JPoNYRkGT6EXMRje
        il19jm2VCMo89/uO97uAcYnXeB6n
X-Google-Smtp-Source: ACJfBos5PmnYKbITPyeQkNx2Narkcr9kzZutvO7MCTuQ2TCKkoJOEA7emJY8nEsm3x+Nbu3NOZeh2Q==
X-Received: by 10.223.160.40 with SMTP id k37mr25652918wrk.66.1514459869682;
        Thu, 28 Dec 2017 03:17:49 -0800 (PST)
Received: from [10.32.248.174] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id g92sm79051993wrd.72.2017.12.28.03.17.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Dec 2017 03:17:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 3/4] travis-ci: save prove state for the 32 bit Linux build
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKj=3ZQhjwtUFXFsMPzFrs7CYntrjJOcdQfOZ+0jjVVGVog@mail.gmail.com>
Date:   Thu, 28 Dec 2017 12:17:47 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3474967-F081-4CD5-8A7E-81615EC5B3B7@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com> <20171227163603.13313-1-szeder.dev@gmail.com> <20171227163603.13313-4-szeder.dev@gmail.com> <DB47DCB3-DF66-437A-BF0B-4DF1838C2F7F@gmail.com> <CAM0VKj=3ZQhjwtUFXFsMPzFrs7CYntrjJOcdQfOZ+0jjVVGVog@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Dec 2017, at 22:42, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Wed, Dec 27, 2017 at 7:46 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>> +     --volume "${HOME}/travis-cache:/tmp/travis-cache" \
>>=20
>> I assume "${HOME}/travis-cache:/usr/src/git/t/.prove" would not
>> work because that would be a mapping in another mapping?
>=20
> 't/.prove' is a file, but '.../travis-cache' is a directory.  It must
> be, because Travis CI caches whole directories.

Of course. Your solution is the right one.

Thanks,
Lars=
