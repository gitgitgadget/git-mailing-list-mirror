Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F60BC433E2
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 19:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554E52076C
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 19:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="djrm3dWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGOTRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:17:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:60769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgGOTRC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 15:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594840612;
        bh=8DRk93OqDHeT+aMv4QbEMhib2KWyeMWs1UMC564csF0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=djrm3dWDztZffbPF+qMaDINTKgz7EyXwlIJeVIvIzMchSkmvJkhXS/HkxQaLLo8Gb
         ZWIl7f1aJRYQY/wfVorM7yI2wpm8jKkb5vpOtu868BIfSobYOMYaXDQzrXfQO3qrJH
         f27XcwilorhdoyR7PiopKFzfHRZdklYWPahtuz6k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([213.196.212.204]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1jw35P00PH-008c3a; Wed, 15
 Jul 2020 21:16:52 +0200
Date:   Wed, 15 Jul 2020 21:16:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: warn about un-enabled extensions
In-Reply-To: <3544e544-0ed5-c2d7-ff25-ad6d9349905e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007152115021.52@tvgsbejvaqbjf.bet>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com> <0bede821-139a-d805-934a-142004abaa4c@gmail.com> <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet> <xmqqzh82ktgm.fsf@gitster.c.googlers.com> <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <xmqqlfjkk8zv.fsf@gitster.c.googlers.com> <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com> <xmqqh7u8k5va.fsf@gitster.c.googlers.com> <3544e544-0ed5-c2d7-ff25-ad6d9349905e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Aw0bPfGSEbDjLRPAM3sgrjuR/S/jvzd5GMay+fMKTDEHsTi6OYk
 g0Qr6+YrCMxqU/SvdlB8R93eXCvauDfraizZOOzMEOTll4WGva+fY8QiPhwyKJUnYXQYeKV
 K9tuMh0x8z28NHNxHEBlSEzCHqx3ok9Kq0Rk3OU53W3EqQuxkUtHiw3QqXlgmGH1a6SJ02D
 aCioyWhYJ6kd0YHANhzZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ckyRWigHeSM=:42+7ostgbFNiREg+Hv8gD6
 JWjf6MMyCy7zfDcM9z57KIF/UDOq3F96J+uMEnTXAn3Bhf3kC9tIQTcd72HBIfk0hu1wnJLsL
 RDt3Ec/Kw+WyLdCktv3c6WbkqSs3cf1tT11GHwdpbVNxkVaXogoSDIs05MqbUPl1bZO0o+vC2
 dDmxOtqqkTkhpzJLH+tpWtu5p8xs+9mBOz4RppaARcN3x2NFkhOyzvAEI6AOxGzocJSYnRo5t
 r1EGGyy/7x6b9GuYgt9m+JRXMBMuxa+Hyj3FwmtwjkZUD56O/NBZpXyvA3o2Gs+oWQ6ejrhhF
 iSAyZz5mWm+UxI7WlpyUiq75dEaMC3pUc7T+nWMTNjvfmBHYrL2mVPx7C9UhD4ooWKi/pFp7B
 LHBnsYgWiGgE5OYPrfwlrpeyHHAlcEUSQ5cFRbReYunN5g10u3ZaZH/1LwOJWyKrxCyhldqTW
 tpVOWxpN8GacPxTc0h8pN9Cc4STI+abNV0qh0lFYdXzZciyFIargbJ1ts3XL3RrnHpsqqNx/s
 3Z40eVMbG7lD6Q8Dng/yownek2YuPNWeGcNae2c/U/C44PUV/YGA8zd6djHtDgy2M39haUS39
 QGHIes5Ye954vEgHJMbLCrloIh+oQkZSc3OQ0eQJUL/Lq/NpsFr/I2m1u1ugHZYjfVlHPe8dY
 w4Cpf+ppOq1jPY7tsMKkn0pOjwJywH/JOF06Y5/KGVSBxcqsPONsWZ5lPuHnddutgOrdtPFWo
 +H8+BW5nF2q+dLKLAYXOZm/r9l0c719asUQMKWGH24J99YkZa8IU2zpVQn5OrKZ1BBqGu7g91
 OTlw7fKhsFbhcHNnmbXJl2oPIT5JUX3GhsVwK9zexFbkiirLtYXe8yTcU30joO4QzvJvIzPzR
 rw16eNuGCjERl+SlA4kKHxJVzRjs4/K2fghyeU+f1dgqB3utiyg0mIRx5X8WaEiRCf/39LM0H
 GzdKX8NB1AWZUZBIZwx0+74hUOAG4iwCs79LG8YRbsPWV7LsQ1x8a/RUZ4nleSTdULZPB78Ya
 GiT0MaDc7gnK0MAh9ORngynx5vRKoGfO2yFqs06BQLbU9eYDiwBZ5fmd8VZW/Z//THAhw6Ymv
 7IjGFPb6WrI3AiWgWfbGkQi53HNCI9t1uSF79upLG4P0aqt2ijOpE5JnRMZqh+Ip7KF6XvzYL
 Dlp6/jUD0dk/GsxeqZ9xshe8g8mKeyEm4mjaHdmqLh4X7ioPOqIWyODKIOLDmLuAifjByg9jP
 ZRD8BPLl1sLmzd0AvOxAGH38WD+ghTbNZ9LVV3Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 15 Jul 2020, Derrick Stolee wrote:

> On 7/15/2020 2:09 PM, Junio C Hamano wrote:
> > Derrick Stolee <stolee@gmail.com> writes:
> >
> >> Your previous diff had this comment, which I thought to be
> >> helpful:
> >>
> >> +		/*
> >> +		 * Extensions are added by more "} else if (...) {"
> >> +		 * lines here, but do NOT mark them as allowed in v0
> >> +		 * by copy-pasting without thinking.
> >> +		 */
> >
> > Yeah, but it felt somewhat strange to have it at the end of one
> > entry, like this:
> >
> > +			unallowed_in_v0 =3D 0;
> >  		} else if (!strcmp(ext, "worktreeconfig")) {
> >  			data->worktree_config =3D git_config_bool(var, value);
> > +			unallowed_in_v0 =3D 0;
> > +		/*
> > +		 * Extensions are added by more "} else if (...) {"
> > +		 * lines here, but do NOT mark them as allowed in v0
> > +		 * by copy-pasting without thinking.
> > +		 */
> > +		} else {
> >  			string_list_append(&data->unknown_extensions, ext);
> >
> >
> > In any case, I updated the comment in front of the if/else if/
> > cascade to essentially say the same thing, and with test updates
> > this time.
>
> Thanks. I applied and tested this version. LGTM!

Sorry for being slow at the party; I'd much rather deal with Git issues
than with the paperwork I am fighting with.

Thank you for working on this, I am pretty happy with the state you
whipped it into, but take that with a grain of salt, as my brain is moosh.

Ciao,
Dscho
