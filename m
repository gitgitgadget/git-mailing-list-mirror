Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1217EC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9F261131
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhIILEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:04:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:39109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234458AbhIILEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631185389;
        bh=BU0B5D/Sm/0LZnwTTowuRu5n+VRhTLN2ZSlF/4CyIVk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h0kKLrPvzcddAdVm52Z3Km/p3jsH/BWzHiEwZXzOAEXzC03kn6lGx0m8aZRRP7Vqj
         Gwz0yFuebturY2X8T1NPQOnprOi8xupSmOIbkuZYtn6b3HMwbgnTZXfjI4tzeD47OF
         mdpTif70mfNsXRwpPntIwVq1y3ogwNUF+jFocbX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1mE4Y42aNR-00CUQB; Thu, 09
 Sep 2021 13:03:09 +0200
Date:   Thu, 9 Sep 2021 13:03:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/scalar, was Re: What's cooking in git.git (Sep 2021, #02; Wed,
 8)
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091259310.59@tvgsbejvaqbjf.bet>
References: <xmqqsfyf5b74.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HpmXQWANtK3t5JImuwDI6qRDTb8V1YCcJkTUP7VEFjhgK4ZITcT
 oIvZ8+gcV0vR/U8vfMb5Dk2fW066sIWRmOsu6sCwBSWZ6vqdfTBpF0fZxFYp8xm3x6bNCQx
 GERyIZFHNrU4xi1t+YZj7LDrmXxGj1OAHeTGXOlIhUVpDhxX5LwMquf2ubxPE/sHejX1R8+
 nFcBRLtcLF7fk+z62uhRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2fRhiJgzsBk=:+guNrbbCkf88Xyp8H8mdRm
 9KmC9+Lb/M8LhClti5x4UZJfOenfg6Hv/Ugl52bTj+DrcHllQnuqGBNhoHDAAIibRwR4eyK7l
 o6rPwNpgu1bG7Go7fjwujO0fGmdxNICgMfFuevgSXPNB69tne2QH/d00crq3ocNRR5B0au34G
 v6n2HJg2BFqxUuzkSOpAyDy+GOYulWRWkqocEC5KWxZ7BjJPtLimBAzEOkDbpkxZxKxLTZoBa
 NlsQSATesWr0sAA88FWRMIPiRIWOduTXt75RLgga5iSn2mh4X+FAFPm1koBK14JYhve0AbO9D
 fC1PeNYHBtu3Up0g33WzKurQaeM18yvj3N3e1Cfdxv/E8aG+PxAqjUeg6r7+nGfoIMCslaONp
 KZGRi2YaUqcUL4z2UnJJtYLL+zI7PuRSMHKh4prkgDPBW8aRlrQwg7u81FXaGXmsa0aVwaUPx
 Lc3RGC4fpZm4+tFp8CldgUbClQCI6DKopDK8Szpc8kwDTlomdgr4o06JefEvSDJQfR3Vp56NH
 vn+XbZakaoi6MsbC9ChqRpHdXlvgsRUNc7BYtn9jzTsyzTktTXNf0CGOD54y/0HC8XLl1pMEe
 mB4kQ/iaAxQ1O2PmnT/XQChiOZitnF/S5IzsfLWduh15barNL70aXUCRqfz7ymAFaXQ8F0fyc
 PQcNHsv7TIXm7c0sRYm8PaVNtLiSLsjd0tmEc5LRoGmRJTj8Wkw9+FWK54VipW5AiUwtemBVr
 PuwtRh5PTAmXQ38BRsLePxHGwq6Rs7j0mQXAUvQeHqapNt4NjpivHX/K5C+3YO55qdrAnFIwj
 lax+IMlvTGdUkAQMT1SUt287scGM8cQI2NdIK0S329P+xmSnn/53DZK9nskPXdkuLtI6Df+eA
 ecaryKdY3lesi+IEPcaRyfx0m9EucgMu8p+Oe4gB8J3671SLiOpWk7cHu4UjY7EeKJYFgVgr3
 utYtmnHgGbFU2byuP+HwnWJYFxh0HHP6aoTksLhxl/2npN/5v7Nxy0Ag9P4KemViJQrHr2Ju5
 a3g6BGyJdxfa3lL9W/2zjjXZZEn1BNDec4bR+a54tBmE2T8k+PDX+VOz5CTTTPxatNwmN7QZ2
 U77ZgObvvbLRqU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Sep 2021, Junio C Hamano wrote:

> * js/scalar (2021-09-03) 15 commits
>  - scalar: accept -C and -c options before the subcommand
>  - scalar: implement the `version` command
>  - scalar: implement the `delete` command
>  - scalar: teach 'reconfigure' to optionally handle all registered enlis=
tments
>  - scalar: allow reconfiguring an existing enlistment
>  - scalar: implement the `run` command
>  - scalar: teach 'clone' to support the --single-branch option
>  - scalar: implement the `clone` subcommand
>  - scalar: implement 'scalar list'
>  - scalar: let 'unregister' handle a deleted enlistment directory gracef=
ully
>  - scalar: 'unregister' stops background maintenance
>  - scalar: 'register' sets recommended config and starts maintenance
>  - scalar: create test infrastructure
>  - scalar: start documenting the command
>  - scalar: create a rudimentary executable
>
>  Add pieces from "scalar" to contrib/.

Thank you for picking it up. It seems as if the reviews are starting to
decrease to a point where I could imagine that we can start talking about
how to refactor things to start bringing the benefits to Git proper.

For what it's worth, I maintain a branch thicket on top of this branch
that has the remaining Scalar parts, both those parts that I still intend
to upstream as well as those parts that will most likely stay in
microsoft/git (e.g. the GVFS protocol-related parts, as it was decided
long ago that the VFS bits won't make it into Git proper, and
microsoft/git only needs these bits for compatibility with Azure Repos).

Here is the CI/PR run of that branch:
https://github.com/dscho/git/actions/runs/1216858695

And much more interesting is the run of the full Scalar Functional Tests
suite: https://github.com/dscho/git/actions/runs/1216858693

(Both pass, of course.)

Ciao,
Dscho
