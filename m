Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0753F1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966636AbeCSRMi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:12:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:56495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966255AbeCSRMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:12:35 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lm3bl-1eOMOu0361-00Zf5R; Mon, 19
 Mar 2018 18:12:33 +0100
Date:   Mon, 19 Mar 2018 18:12:19 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Clemens Buchacher <drizzd@gmx.net>
cc:     git@vger.kernel.org, manlio.perillo@gmail.com
Subject: Re: [PATCH 1/2] completion: improve ls-files filter performance
In-Reply-To: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
Message-ID: <nycvar.QRO.7.76.6.1803191802140.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1521274624-1370-1-git-send-email-drizzd@gmx.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1627093723-1521479002=:55"
Content-ID: <nycvar.QRO.7.76.6.1803191803270.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
X-Provags-ID: V03:K0:xO3lmgFLHo6C1K1J5VItYTUmG2Ypk7TuvYdcCjcmOKTx4sVJhfs
 Y0wy6e3OyLfSwcPhnhghlLFvr1ghp002IshYMiakYT0j2dm7wrNvq7uVa7KoGMdbWkZw2pr
 gxmrwZwcHcZ+Bpoigt4drtlviopGV/dGGCojL1ltYTisxOnv5GPh9xqORU4A9eNv8zni761
 NnXhUc+oUxar9LpBB8e4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Su8HZNCn0Ws=:yGmUGZVK3rtz8upcejb+OB
 3sLq/Ue+YYdUf/6Iu2pEB4NiZ/6WUvwHjjlCtLO+0rcFv1aUttg+Ve5488roADCh52c1Ni24a
 QDoTeb2RfDnUx+mbShKNitOoJ0/XnyObdl7vUUoTMeH8nLXDJ/Ge+EvvvdFDUIuUEmqmsN3/o
 KvWUeqMKqv50ZkTuSKmu5bzWOrAxhV1JfAYGfRgINqu+g9tk2RG+jDa+mbn0YeG/hT2JYej2m
 boJCPP79eE/uDLFRqlXcHETQpBCe7E/TlrrNeSnZv3lGp3Bk/XyXjsRNKUzzzEcKc8EaGuktg
 iJ6cLMhZxRCI8aAQi1F7jGyJNDga5gBKcwWyBvTxBP5ypZMIyiCjVAWkpA5IbWBTRbntDAZl4
 V4tBf6GLLiNqzyZOSQCvpafUfvIzuza9d1UeXqhuXSXA0nB+nkaQubSjpH4cB2TwOzV1PS0qy
 PB+sxoDL3/QOpHrbCwm+oKGYhtnNXcErjPmiqxuwvm+khyfxH1WL0yjVojzPWLatToTKU0oI3
 c2OVVitox11Y0b2u2uWc2SkJKNmoaXb9cDgT2MxHT3q8fXByIxo7rAvfYyJ79RaTMERQ5CR8i
 lPMZKdspTLilwYwBJz5Sn0h49yTo3IWZaJIuzOjByia1ThewmqrC8y08BiEyV4F8+oQTQev+y
 kPCObbwLllE5wyhtBXKe5YqCl5IDtIszjw6ldNc1JV6rg1mRcqLPpFo7GLWyBJiV9BfaDuOd8
 5bzV95AtRJIqbq9CdQ+6IKrrShiu1G3PtBBaJPBiueNsazHBt2ZJHeQovUDtd8hZO+kKyDq3I
 VjxOw5nXYdeZb5pfJ/PuL0FBrJkTHBtiLT3SmfEjM25a/iuAbU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1627093723-1521479002=:55
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <nycvar.QRO.7.76.6.1803191803271.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>

Hi drizzd,

first of all: thank you so much for working on this. I am sure it will
be noticeable to many Windows users, and also make my life easier.

On Sat, 17 Mar 2018, Clemens Buchacher wrote:

> From the output of ls-files, we remove all but the leftmost path
> component and then we eliminate duplicates. We do this in a while loop,
> which is a performance bottleneck when the number of iterations is large
> (e.g. for 60000 files in linux.git).
>=20
> $ COMP_WORDS=3D(git status -- ar) COMP_CWORD=3D3; time _git
>=20
> real    0m11.876s
> user    0m4.685s
> sys     0m6.808s
>=20
> Using an equivalent sed script improves performance significantly:
>=20
> $ COMP_WORDS=3D(git status -- ar) COMP_CWORD=3D3; time _git
>=20
> real    0m1.372s
> user    0m0.263s
> sys     0m0.167s
>=20
> The measurements were done with mingw64 bash, which is used by Git for
> Windows.

Technically, it is not the *mingw64* bash, but it is an MSYS2 Bash. This
does make a little bit of a difference because of the penalty incurred by
the POSIX emulation layer provided by the MSYS2 runtime.

(And it also addresses Gab=C3=B3r's question whether you ran the test suite=
, I
guess... it takes multiple hours to run it even once on a regular
computer.)

Ciao,
Dscho
--8323329-1627093723-1521479002=:55--
