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
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7621F461
	for <e@80x24.org>; Wed, 28 Aug 2019 11:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfH1LKC (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 07:10:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:36331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfH1LKC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 07:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566990591;
        bh=m2KyyEDtSxSERgrwK3hWRFBx3nKtu5THq0pYeVIqU6M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LQUwTRpMwc2xQmY5InsNWBre6AO+81JgdQ83mVEZRfzJY//fGd2VJh0IZ4e2pYPeM
         4bmbChMLDGBpTvIaiC22xuPwU5shxvvFg4n13Q8kPoKDf6K0IRmAerJ0pHLUDYdTsl
         RL19R2l9QoWvHMcFsTnBAvidwSXzasroxpQKWOQs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGS9o-1hyVyR0mtU-00DGdy; Wed, 28
 Aug 2019 13:09:51 +0200
Date:   Wed, 28 Aug 2019 13:09:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Proposing git-filter-repo for inclusion in git.git
In-Reply-To: <CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908281307250.46@tvgsbejvaqbjf.bet>
References: <CABPp-BEr8LVM+yWTbi76hAq7Moe1hyp2xqxXfgVV4_teh_9skA@mail.gmail.com> <xmqqlfvlne3k.fsf@gitster-ct.c.googlers.com> <CABPp-BFK65qL4GCs5bFuiPPYwMCDYrxMyYejacVS89d2GK4nDQ@mail.gmail.com> <20190823030059.47ftwfne6y436e5j@dcvr>
 <CABPp-BEDOH-row-hxY4u_cP30ptqOpcCvPibwyZ2wBu142qUbA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:euJKMAFSWcskpncyk4ZqddLWMk++2o/BhONovx+Z0hsIlOmydHC
 EBoGbxv9QoCfmYicq3ZncaotPaBF4TeK4G5zeudQhOCx9We2hL6PE6djyw2uSxa3tsgneS9
 FERLu2OQZv481cg3QLiy8zsHxd7EmKvbds6uE+76qMkxb8Oa4fYNLpYvnDUEAyiMhjYwI7L
 GS2EytIO0RsROGYz6F24Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1o9Wh7sCko4=:nv5YDJqcgwdt2y60FCxgh/
 c1aRoGSocU7MGHKWstAjzr32XGxkBxI21K+GSY2Xw47MEMMvvqSNNiqgCRYjaTX4o3uzowgbP
 D8+O6ZIi1UKnp6FIznHvnz2n1vvw8ZTnh5AoOswLPkuEVAEZ807H5mpym11OzA7dcnfayXR0i
 pwtoYRQk2bx+xnAhH3HX5bP8QrxvW1OrAcUNmjK9lCnMK/krv8E1cTgS2xuN+xq7N7nfJOO8f
 np29Qu2Z9Y1yWsSMXTygiNRcwxN9AQSJQHrq9wAbzJYS/XrAZz/Y5EmE3wJ36N6Y000jv+EFX
 i4L7Ic/nH6MOfhVrvHrYbp0h55uAzMkYW1tu/wg5duVHfKw+uAGuxmtgFiHGFB31oGqQZ1OqH
 TOpIYWkBwJp+dIs3wd3PqqKe/0/RShBl81n0fNK+Fid9n1ZGHmwRj3UQMNt6exVwMQ4iEgDgR
 WlhGMMdY++KskzF9z92MJDQ7wRDzLbYHPXYvCiG+MCP9sSzD/Y1MtWweFWMZqIrHsVedy5Rs+
 ojaLxiLtS0xlT8rQ0vsbGgsFwSvOYnu0ryN8Saqwsa2ZrCvvnjjUSDrubkWlKSUN+InYTloAd
 wnfciLLGuJAfwnf5Yz/8FYeeV6euzAQvFgl6yDbqkKx4Td4enJSwEmIh3H16/pt+pQE1R1TFp
 IXUC5OaCuz4fdcrwCpdaIPI75X1O/Mdt5YBv6zVzvxyQEaz1xnKqzzzG7xBLCSMZ/MaUpaddK
 T8FilfOFAEVoT1jrabSnrMpigiycJ55ySlOPa1lV7jWgwG+zgXffpb8PIHLXLEkkLF4/uOtpG
 CcOtSV9EaoUYN+DirdNZoogoA90h71muUVjSix0FDun5iZJZZNHkmYIVvn+IBUmfYuzKoOpDU
 Ppz9RxbxsEx6+oEVXBXHS9KGHEfXzgImLoIrILiG23+Y1JVDqsLhv+L9ficaulRAzlkdOl1s7
 ZdDl6NeMyq9AnexOMfFXXWCW4PaH1iVg4lKgXcReJhKt+ircFjslpqE1nHekHHApoMXo04Pv6
 rCwbRyukmwYmC49jzs6cgDlfkqwaTMcyjvGaq8ucTwyLHt3Qk5a11N2zfKiozWux8d6bAGICn
 s342YiDHUg1LaMitduVszuU2uYun5bVtOHNcbf+srj/K8qja0WuP5HxtmgIchaNaiThn9vAqs
 9DVT8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 23 Aug 2019, Elijah Newren wrote:

> On Thu, Aug 22, 2019 at 8:01 PM Eric Wong <e@80x24.org> wrote:
> >
> > Elijah Newren <newren@gmail.com> wrote:
> > >   * Remove git-filter-branch from git.git.  Mention in the release
> > > notes where people can go to get it.[1]
> > >
> > > filter-branch is not merely a slow or difficult-to-use tool, it's on=
e
> > > that *fosters* mistakes by making it hard to get things right in
> > > several different ways.  Granted, people exercise extra caution usin=
g
> > > filter-branch because they know they need to, but there are so many
> > > gotchas that they're likely to accidentally mess something up.  Thos=
e
> > > mess-ups are not always discovered immediately, and by then it's
> > > nearly cast into stone (rewriting being something you want to do ver=
y
> > > rarely).
> >
> > Is it possible to turn git-filter-branch into a fast, compatible,
> > and (maybe) safe wrapper for git-filter-repo?  That would "fix"
> > filter-branch and (if done carefully) not break existing uses.
>
> Ooh, what an interesting question.  I can probably ramble on a LOT
> longer than you expected about this...
>
> [...]

FWIW if anybody cares about my opinion: I would be totally fine with
integrating git-filter-repo into git.git, have it there for a major
version or two, then patch `git filter-branch` to spew out a deprecation
warning, and then remove that latter command a major version (or two)
later.

Ciao,
Dscho
