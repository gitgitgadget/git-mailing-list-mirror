Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120AF1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfHZO3M (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:29:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:57017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbfHZO3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566829744;
        bh=cSRF/Za7jRwOxIu+gLrx/doBKOWr8gqIxdIPn9V21DM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JddCdvoysRbiysGzWYgDGrf9Hx0HVh8IsPD6IxV2kemvqRGYvIPXGxiN7FXSUwm15
         OchL16QRKDSN57AsyUHuEVBhrTKled1UayMAzOrqDVuuah2VLgINRQfp2rgDhpbRVP
         XYY2hZxooCWAsJ2qHXj3DE9PLehbqaIeKMdD1Jgk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaIsi-1hmmTY0Ew4-00JttH; Mon, 26
 Aug 2019 16:29:04 +0200
Date:   Mon, 26 Aug 2019 16:28:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: under --debug, show whether PCRE JIT is enabled
In-Reply-To: <CAPUEspg9F7RutCUCoRAAXmRePjiunq3-zG7cN3uz_t5DVMxP=g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908261626450.46@tvgsbejvaqbjf.bet>
References: <20190818201727.31505-1-dev+git@drbeat.li> <xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com> <CAPUEspg9F7RutCUCoRAAXmRePjiunq3-zG7cN3uz_t5DVMxP=g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zUprlPntJ2ig+VyW6cxf2zQeRGp3AT0Kx5Ow3Bzc9NPJjiT+RWs
 f0AzkbsE5GbbgBmFtn5Xztd3675fNHH62g6UDWBY7ymTq27tpOqGD4Qi8ty76jZeObjR+3F
 SNlaMjiVEfwDDO7yQDRIhWAe+WQ3u6QhDUixlMWYozD/tT2bjBzM9v9N3x2LHd+dGNjM0Ly
 w39U5yAPzMHOjfwmnEkIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqmF6luvuVg=:ap/fnlqZWgVYSDkdUoyfLk
 GosV2Qg/1MM/FQnd4H2zVvIxntyJas/l6wj2uOv0s7QDw+6DBd50cg1h0RwZ0wnn+wGEplIOJ
 5JdMBpaEGUnPFOo6Tj34B80fNnNyDJLEd5A3HQXOrxoXpYlWgTM/VjsPXg5N794ekHKRa7M3k
 RT8B8TNd67iood5gmdXs1h+eO/pfoSLkdiGYXAJN5QlzdwzVt0F0VAAI/zufCyPEkYfY8UNFi
 STrVAXuhZXjgvmPFQpXBdz5rcfY+ITk8Li0KuKbRQS+i4hdCXVbBzNrOwyv1wmgmjH2Uj+ZC6
 SGfpPQGrujRGhDki6qaDciMaEEOYMUKwYxx6sHFzbT2+3KVF/fjyF7NdxUZlYGhlzbqrkaKrW
 K7xwljS19v47bPewOFqpdTngbE04XYRYwWw9qDHwqAnV/j7vvD4pm8NW+UhYRkrEPofzDkoKg
 ppHnOAijk1YZEqlFvfJxnbgjxubuYksQ2DYERVZjFhCorCJMSZciZ79gv9xMdfOmdh6GFeqCj
 IpuGENXcTTsPUlk841BGWVYNGl+dmck5LwGWAYzMzvsC7NEMYcXmDY2htTsgd40VLsjhA4Ch1
 l1CNKxJZA4XdpPa8bXK5bSLpDam8fhXICJD3w8qxbxApynxRh35Ep6XET51Mo0h9YXVHCsYNP
 CpXCvF2nJ/MJv0GGSXuhjqu1TNp2a+DMXXCHrso7dOuDS4u2o7yAv9LNNUz67w2eBEZ3KSpHY
 yC66XhtdqSb9KiB+mqiqA+Z0UW+IUFFXirFltjt8+5LEQUgYbbr4Foqk7NCJazRcnLEkQnuh/
 yQNHJH70Anol8Vp6jjYtxTpmMoIcyllDYxsaMdOhY45G773Uxfk8wa+nVDAEIerDkHo1lwfnw
 I/SFGvsyF1PdTNOTB3DxENNg4d/z/OB8Qp/7dwV6MNq7wn0mX4TUT0sxic0Aud6Oh52z1H5j/
 pYKgg2SghmF8m1yiQpL94x0/gtbuJP/Cw+D7ytswTRlXGmnyHSwRy9x6qnUa1oDb3NThIB7XJ
 HPyd60emsihGBWLo9c+W4zWCmVQ34r5tfGYWw4Hd1aDKN8fbtbPFLl28DbAe/0ZNp99lp78Z+
 3j4zErb4vGftfl1Ln2ntadxvjinHoaWPs3JpLmRKFJCFzBxgNGqK8AUipSfGdrxx96WejfG/+
 F/YRg8D5kkW9eGn79PFSPXyY0cwz5YOJWAg2OxIru/g5JI5oIooNMIFaOq5DG6hF52L6s=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Sat, 24 Aug 2019, Carlo Arenas wrote:

> On Mon, Aug 19, 2019 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > There may be others I am missing.
>
> should we still support PCRE1?

While Git for Windows has no problem to just drop PCRE1 support, I would
like to take a longer road in Git. Like, deprecate it first (I don't
know how to do that effectively, though, as packagers usually ignore
compile warnings, maybe we need to add a Makefile knob
YES_I_WANT_TO_BUILD_WITH_PCRE1_INSTEAD_OF_PCRE2 and
YES_I_WILL_STATE_MY_REASONS_ON_THE_GIT_MAILING_LIST or something like
that).

Ciao,
Dscho
