Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15EFC433E9
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4BD64F6B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSOXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:23:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:54993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhCSOXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 10:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616163794;
        bh=FywjijLkPYDV9Ao5Kc4BXUUOGOETRM+40PzbWxEoRMU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aEAk6xB9Sj/3Cta4Lqgzld1u/0XzhojiNsvC4JUbzV5xxCVENORWWoljfjGrZ96v/
         GdlJqCd0yBiMNEmz9JDSowx/vp/mK58xEcPx/AVJS6YoReirK+xw+N3+SmIUzajdBE
         0Cye46r/9N65R3kRp6ee266cOLbjWKoDeTXB+MpA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.24.97] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1lbTzh3wjc-00yiFr; Fri, 19
 Mar 2021 15:23:14 +0100
Date:   Fri, 19 Mar 2021 15:23:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: Submodules and SHA-256/SHA-1 interoperability
In-Reply-To: <YE0Vki0HNOYhYIYh@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2103191521290.57@tvgsbejvaqbjf.bet>
References: <YCmbKrTsJhgPHYLc@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2103011621000.57@tvgsbejvaqbjf.bet> <YE0Vki0HNOYhYIYh@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AZEAovDFIIjC1y/I1JBBkCDNUNFR3x86OisqXuNbkQhtWgo+Vu9
 Yu/GnpeZkxIGJ3IdjC1GSVtYrDrtYbWO5NR9aNvPiOUPMTHQlN2GcuMRdRsigCVUbvMnx6o
 6bacmdC1xT7JF3DnMJPIGboP1UiH0rzWGqo0JU0smNflbBtmU/6CxAJqHbGH8fb5xiovphW
 NiB0tsr9epQ/Qu4uj9PCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ndOke9f1EVY=:bPYeYo5X8AdJZuOXKQs2om
 h+wbNfpv0NSQikdihUjX920mJrCwe2OUXUAuU0/uisAl6jl99iA20IGK0eoDFERAvgGnf4KVB
 NPqAIHcqKielzijlJcHwU6eLQSAK8fV0m/GjP/OPJMQnMdPBjjKNAMfY8uQ/5pGCBpweYOqtt
 gaVBIf8VQkp0C4035kS1Ew/Q1yckLTTbkkPo7/Qm99P0KqydZ7YRuzWEY9wNrv/QRr5JBPkZV
 LLYSbJ747YuC4C5jsMqa508SXc9aG+qxxMkrNW1FSPl8F3H6tuD/0yE9rj6JKQJSJV1bIaS45
 wJkbbHtXjyhsRyJhqYr6/4oqwWJi4SCkpkUSK+qOcfcGiMCtnvAFlKIDRQ7bxfTkfrsxHxRDl
 4mUlbjBPqNmzxq9KPX2DlC+YC86OKHTWSM9VDn4tUOgkPj0mKhze2XagWSjcVBU1gKyyVSa8J
 bqDNLFf5v5asHMSZUK1bDL+qrB4vbqxMsG3iOrXbWihlg5EwB/BI31rlmHm2m6PkxbqOVjEbH
 C5imtmmVtLmVhqOkDx1AS5bIey5wrEZIX0GvesGXEUvW66EMjUu6f3J9TeOsvI1/3phhDAP2p
 VNp7/EbGsGYey65mi6DCkgXp8D7dyC8moyPbrM2zqoyP5o/5OZ3fuJeKe7yq4XdOrSTvuHqXF
 8v3nTVmGLNJDnWqc2zh1EQ8Jnei4wcsb4ILrtdOKBEZCpWTIeob1673rg7KI6ZJN+zkbeHZkT
 tavPeRiE5M4QMge7GiMiIMyiK+j2CFPqkYy90C6vUWKdPv8AA6xnhXiQE8Yxi+y55na0Vd31f
 JhwIRD/acllv+wMHVh6iQQy6ats1pe8/1KoquYl2dYpNCCbtVIri+NxX9NyBiDEu3sQtiy0jL
 5KgK/P93sGSlGh+Mcg4S/0gfQEd1J4/DOWzaDRB6w=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 13 Mar 2021, brian m. carlson wrote:

> On 2021-03-01 at 19:28:13, Johannes Schindelin wrote:
> > While my strong urge is to add "Remove support for submodules" (which =
BTW
> > would also plug so many attack vectors that have lead to many a
> > vulnerability in the past), I understand that this would be impractica=
l:
> > the figurative barn door has been open for way too long to do that.
> >
> > But I'd like to put another idea into the fray: store the mapping in
> > `.gitmodules`. That is, each time `git submodule add <...>` is called,=
 it
> > would update `.gitmodules` to list SHA-1 *and* SHA-256 for the given p=
ath.
> >
> > That would relieve us of the problem where we rely on a server's abili=
ty
> > to give us that mapping.
>
> This is true, but it ends up causing problems because we don't know
> where the .gitmodules file is for a given revision.  If we're indexing a
> pack file, we lack the ability to know which .gitmodules file is
> associated with the blobs in a given revision, and we can't finish
> indexing that file until we have both hashes for every object.
>
> While we could change the way we do indexing, we'd end up having to
> crawl the history and that would be very slow.

Hrm, that's a valid point.

I just wish that we could make this more independent of servers. There
_might_ be a way to work around the flaw you pointed out, e.g. adding the
mappings from `.gitmodules` to the repository-local SHA-1 <-> SHA-256
mapping. But maybe somebody else can think of a better way?

Ciao,
Dscho
