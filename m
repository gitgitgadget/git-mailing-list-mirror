Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92EFB1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 23:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbeARXC5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 18:02:57 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45148 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932379AbeARXCz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 18:02:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id i186so39343wmi.4
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 15:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XGQmKLyIQLMRsaduvCMMXpDaIjSsFHWxlhCUjq7mU+E=;
        b=E5B8ull7Y2+giHGqvpAAtSSJ09MzFPus65ymlAk4Xd/p9ruChfJfOOxMeHYIidMhiW
         K/dmU/w3SjP3BNsG2KezX38xolGRDu2brOWQoP+doIcdZ5pIVTBZEAF0Gl1cu/V0oCm6
         /OnJL/E88OOE3dNmWeDy6cvlAmxHSK93jfBxThMkTp8IaWeU7LuZnzOm6SwrwGKLHucR
         T1kGPZxvQlZzIKTAtUVr6X0gj9ktbESXEDyqt+BDSNa/SRX7mkwxL8LL8U27+bD7sXO2
         3HslwP7zbvLeCoMXHftOiHSL4Dfdb7dF3j9RP4TsUOIlIMS2TCTVC7LweuGaEtRScZ5o
         gKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XGQmKLyIQLMRsaduvCMMXpDaIjSsFHWxlhCUjq7mU+E=;
        b=SkwRoBaxIS1k4z1AAsqHIfQqVcBV2yV2JedqAmL/4Y6eyRHdOt/kT89Am8YeZyskA5
         ctP3+q8u/IPxW025WjJczACgg/GhGPGGABrMemHBzpJNth48jHuLU8p+qCWiOwDZ11Hb
         /PBXwoumEDXleXw8RLyRZTMiUKBt2aG1fuygzluKrDoAsjrvbr4AbaHEgo8eSiQi/3IT
         FShzZr1mL2RTUiApYIQYvaosavtW64oeVFMsP03CA4Q6RJURt1FUO35Dq3bXgh0BwnmM
         XdkRC47iXq9LPPLpwFWTAVytwX0Vx2Ocjz5fXhhu+9qLnWH+dro+sVwb6ilWk5ozUaIX
         87tQ==
X-Gm-Message-State: AKwxyteWOmIrNT+cD0UKvaf3BfzzO9J7Ier9z4G7t6Xz7HoEpl9EFdRd
        05AhKqcnQtfpmi2SXWQuC1U=
X-Google-Smtp-Source: ACJfBotajZEJvoJzZhZfgOS6ySUPeXz3gzQgT3a0lCmuOXtXOk6c7n1jEkXcgVmhhB/eDhHWnDWXVg==
X-Received: by 10.28.66.199 with SMTP id k68mr6561224wmi.104.1516316574037;
        Thu, 18 Jan 2018 15:02:54 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5E4A.dip0.t-ipconnect.de. [93.219.94.74])
        by smtp.gmail.com with ESMTPSA id n62sm5657180wma.40.2018.01.18.15.02.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jan 2018 15:02:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] describe: use strbuf_add_unique_abbrev() for adding short hashes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKj=eL5ZnnwKrxqtDYE+ijqJvcU-4bJNhjurvdn+Bpv7gUQ@mail.gmail.com>
Date:   Fri, 19 Jan 2018 00:02:52 +0100
Cc:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89BB7BC3-1EFB-414F-8849-B520AD4543E6@gmail.com>
References: <20180116171130.16568-1-szeder.dev@gmail.com> <7390fd9c-5969-61f1-86b8-6971eaf1432b@web.de> <CAM0VKj=eL5ZnnwKrxqtDYE+ijqJvcU-4bJNhjurvdn+Bpv7gUQ@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18 Jan 2018, at 23:40, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Thu, Jan 18, 2018 at 10:40 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> =
wrote:
>> Am 16.01.2018 um 18:11 schrieb SZEDER G=C3=A1bor:
>>> Unfortunately, most of the changes coming from 'strbuf.cocci' don't
>>> make any sense, they appear to be the mis-application of the "use
>>> strbuf_addstr() instead of strbuf_addf() to add a single string" =
rule:
>>>=20
>>>   -             strbuf_addf(&sb_repo, "%d", counter);
>>>   +             strbuf_addstr(&sb_repo, counter);
>>>=20
>>> It seems that those rules need some refinement, but I have no idea
>>> about Coccinelle and this is not the time for me to dig deeper.
>>>=20
>>> What makes all this weird is that running 'make coccicheck' on my =
own
>>> machine doesn't produce any of these additional proposed changes, =
just
>>> like at Ren=C3=A9's.  Can it be related to differing Coccinelle =
versions?
>>> Travis CI installs 1.0.0~rc19.deb-3; I have 1.0.4.deb-2.
>>=20
>> The version difference may explain it, but I couldn't find a matching
>> bugfix in http://coccinelle.lip6.fr/distrib/changes.html when I just
>> skimmed it.  I wonder if the following patch could make a difference:
>=20
> Yes, it does, now all those nonsense suggestions are gone on Travis =
CI.
>=20
>  https://travis-ci.org/szeder/git/jobs/330572425#L713
>=20
> Those "memmove() -> MOVE_ARRAY" suggestions are still there, of =
course.

Nice!

Travis CI runs Ubuntu Trusty as current base image with Coccinelle
version "1.0.0~rc19.deb-3": =
https://packages.ubuntu.com/trusty/coccinelle

I was experimenting with a docker container that has the latest stable
version of Coccinelle installed ("1.0.4.deb-2"). We could run this
docker container inside of the Travis CI job similar to the 32-bit job.
But with Ren=C3=A9's changes that doesn't seem to be necessary anymore!

- Lars


PS: Thanks a lot G=C3=A1bor for recognizing and fixing the invalid
    Travis CI Coccinelle build!=
