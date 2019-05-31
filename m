Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA681F462
	for <e@80x24.org>; Fri, 31 May 2019 11:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEaLgI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 07:36:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:41235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfEaLgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 07:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559302532;
        bh=CeordEY5LT7bR83XA38oiPPmmCw8hHkUfTu81vxCP3Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hgE831lvspXfyLY9tMM/I14Ow5DyDk/uAzkBd7RMkmVsQssGTSAbZm/Tjqt1T8dUg
         L4F/NKmmj9kZ4Cy1ngYIRgFNishFSDgIrjkbO2rcE5IoR3QoXmAs+BsLUJgsOJn/3f
         HwMrdxt4DzavYVhLSpdZrvS0eqrzczOrGTFlttdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlESk-1gzGk61PLK-00b6So; Fri, 31
 May 2019 13:35:32 +0200
Date:   Fri, 31 May 2019 13:35:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 04/16] promisor-remote: implement
 promisor_remote_get_direct()
In-Reply-To: <2329a4c7-bfb9-10ce-9d1c-8c754d6dee05@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905311332560.44@tvgsbejvaqbjf.bet>
References: <20190409161116.30256-1-chriscool@tuxfamily.org> <20190409161116.30256-5-chriscool@tuxfamily.org> <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com> <nycvar.QRO.7.76.6.1905302235000.44@tvgsbejvaqbjf.bet>
 <2329a4c7-bfb9-10ce-9d1c-8c754d6dee05@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qz41fNWJ4NXjl9zh9Z9h8nVwtcVccVEPHjmKXlSF22KPWcA11Hm
 lMtsE2Q4rvNjVl+xPhJE6Cu+nUG8VTgM+DMwfDnby802tWzxNXRz4jyehz+NxM17Dny03uI
 8C7Xzzwwdh5ViQ3o/Q17uAwFseaqp8tgwhUIR9L/pbiJBuIn5yk9rvcJC/ZW8LCpszzo/eu
 Z2LlNRdgLZDzd9u1YetyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ajl8si0L1YA=:6dzpzRSBYjSGq9uAw+C4kW
 dNuVkXcH2EhgsdWwOjyFA59kPJVVkgKrU0fUWIOJ+OtaVwT0TG2FBVfKPMX9RlE6X0dqMRAFe
 0kWU28oX/5CukGzJJ9/o3giquUa3/K9v3dVUO478oynFh/gjsQY9LahKq+BSKK14jjoTWcG88
 ljuNJIUYVHo7k53Pb+ZIQeCIvYUPz9wATQXkTNchTPYyq3O2N6oIirO5s+gxYkvYtd3Qljutu
 fp8YMf7VOyECGWUpI/n2hfjBJchZAP0SgMl7NPul2rFakz6h9XZd/K05bMh/MJ8e0+TOSMfvJ
 nAGhG/q7s3TtdroKpd2C5zucIsLopSsoj6OEI/HgGQsjr9LJtipLNjp65GJH9mHk3PAeFPtxs
 T0yugaHuTwrWQTBcINi2Z2P0yGgiTf0yOIxyd3GhFnNk7IV8VbDdZjgB8rv141pJ6cWHAXHzQ
 y+YMw5PzJsTj6893lzWvpJ8HiOyHK2k7iXgxxVLAogcfkraK8yd9o6GEs66YkuSaLrKRzeMf5
 CBnHEUK8NAx8RU4ekfhrTPjWQky0PSznAHwUrG+nltHuZkMF5y/Fi1UaPmf2mduegMXKVAPeb
 YUsAtJlW75SLZM+4FkeBK7vy+HC+QPhP/4PF8V8z8YLr8NvLx7v5Tvcn+HUDluLbFyimnNoj8
 cJkyZFfEe6jDAIO4/K8tD8juHTeEpctGJH6Ryc1R4jYpGt2adtuCrSz0vqTT5gh9ddnJHymk+
 Cnr0DaGcfieKRblfvwi6WcbRH6ZTN6Eppqnh6vCNQh7lJMvwqTz1+XRJw09LeODpE1oesY/eZ
 WQoSHGjg9bs8I9zLGXIB07NBa5Ov3u5u4jdHWpt4I2zXALUh388hR3KjCV2HPuxnYJPQ3Z7ci
 tr7H4nh3z3Mb2/KZsCgpi8P1SX6eirHTuhUxDyhYQXbi7OE5Lo8L2D5GdQqO7oW8jnVDKSSmE
 szaFH9iIthR9j5Dl6W8fuTmafUviEaN/ryxQkHVxaFPQ8tr1+WhZN
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Thu, 30 May 2019, Derrick Stolee wrote:

> On 5/30/2019 4:46 PM, Johannes Schindelin wrote:
> >
> > On Thu, 30 May 2019, Derrick Stolee wrote:
> >
> >> On 4/9/2019 12:11 PM, Christian Couder wrote:
> >>> From: Christian Couder <christian.couder@gmail.com>
> >>>
> >>> +{
> >>> +	int i, missing_nr =3D 0;
> >>> +	int *missing =3D xcalloc(oid_nr, sizeof(*missing));
> >>> +	struct object_id *old_oids =3D *oids;
> >>> +	struct object_id *new_oids;
> >>> +	int old_fetch_if_missing =3D fetch_if_missing;
> >>> +
> >>> +	fetch_if_missing =3D 0;
> >>
> >> This global 'fetch_if_missing' swap seems very fragile. I'm guessing =
you
> >> are using it to prevent a loop when calling oid_object_info_extended(=
)
> >> below. Can you instead pass a flag to the method that disables the
> >> fetch_if_missing behavior?
> >
> > FWIW I mentioned the very same concern here:
> > https://public-inbox.org/git/nycvar.QRO.7.76.6.1903272300020.41@tvgsbe=
jvaqbjf.bet/
> >
> > The situation is *pretty* bad by now. I see `fetch_if_missing` mention=
ed
> > 25 times in `master`, and all but one are in .c files or in cache.h.
> >
> > The flag is actually used only in `oid_object_info_extended()`, and th=
at
> > function accepts an `unsigned flags`, so one might think that it could=
 be
> > extended to accept also a `OBJECT_INFO_LOOKUP_FETCH_IF_MISSING`. But t=
hen,
> > there are many callers of that function, some of them also pretty low =
in
> > the food chain. For example, `oid_object_info()` (does not accept `fla=
gs`)
> > or `read_object()` (does not accept flags either).
> >
> > So it looks as if the idea to pass this flag down the call chain entai=
led
> > a pretty serious avalanche effect.
>
> It could be approached in small bits.
>
> First, add an OBJECT_INFO_NEVER_FETCH_IF_MISSING flag that overrides
> fetch_if_missing, and then use the flag in small places like this one.
> Then, build up to the other methods as appropriate.

That is a good idea. I fear that it will still take a Herculean effort to
get there, as some of the call paths strike me as rather deep...

> > An alternative that strikes me as inelegant, still, but nevertheless
> > better would be to move `fetch_if_missing` into `struct repository`.
>
> This is literally the _least_ we should do to reduce our dependence on
> globals. Maybe this happens first, then the flag idea could be done bits
> at a time.

Okay, then, I added https://github.com/gitgitgadget/git/issues/251 so we
won't forget.

BTW I am rather happy about the way the GitGitGadget issues turn out: I
added a couple of left-over bits, and could already close two tickets
after other developers pointed out that they had already been addressed,
something an unsuspecting GSoC student, for example, could not otherwise
have found out very easily (or for that matter, I myself...).

Ciao,
Dscho
