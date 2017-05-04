Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3BD207B3
	for <e@80x24.org>; Thu,  4 May 2017 10:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdEDK3o (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 06:29:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:61617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdEDK3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 06:29:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV6PJ-1dZmb542VJ-00YN84; Thu, 04
 May 2017 12:29:35 +0200
Date:   Thu, 4 May 2017 12:29:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 01/25] mingw: avoid memory leak when splitting PATH
In-Reply-To: <789a242b-7369-f24c-0b92-09f415f9fcb5@web.de>
Message-ID: <alpine.DEB.2.21.1.1705041225090.4905@virtualbox>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de> <10fc0a4a37b4167f49c967ece08f531cb1e8d6b1.1493740497.git.johannes.schindelin@gmx.de> <789a242b-7369-f24c-0b92-09f415f9fcb5@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-206122965-1493893775=:4905"
X-Provags-ID: V03:K0:T1xLvUuBALU7Euajz/mBsVpsMj6ZKhcSzNNnP5YfL7ORj8FRerz
 Mwr63Ix35BCSNJqQqM+wTZj2obXfjK+DoYPIsBjIGDTQKoAF2MG+47RpWCpCkui6ufm5wj3
 HGa1R8YH9TWzFdjk0HiTY49SM4rzXLjSoCleypiP2lII3ZTJpqAnbMSl3EKgXCHuKqjzP99
 NLmuMfXHlBkaUoWDAr4bA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8RNTnmAF+hY=:IwAPYz+wSXrUygxPwg5b9A
 3hMJLuF3cMa92L/VgEMQA+7ta5d3H3CqzV/dfGDLgJNRMPSRzMNl3AOEn1yT8AmyQ8GoJW2HM
 nmxQNHcNQleLXUdlE8wtzW3OaGp0lWvtjwWPj/djXqOH0h7xsbBp6BmqakmTdzWuIzw2VW+7c
 HxNeMptqYTLVfgwsQPGFq9M4R2ma/Y32GPycsJi7mHNfNPoWcl/D2uTYM+EsDLMQu7ty+dGm9
 1G1LLvMXqfthhb29+GlJrJgc2R9IjMb2MZRjgiJHFKfRdBpfMGczDlUNKbiAPbY+RLhOHRkjA
 XC5uSaE6CrK/2CDm5EDOFQepPXOwCLNolX1C/4U2xU7J3zqFEE95vC6IdWKdITMPBaR26fHEv
 nv9gVb/+zHPw2Alc65kwKo8hBsa/n+jsZh+JswUW9CuXcMot/Tp5+6Tjum8XNF9Stvm61bAhX
 upewkF7/4997dNwx67wd0FnCmsHbOBB9TKmlUfQQ+ui663yAvcPFhBosveOmNjzWfTz/nb1/p
 ToaXjZIdRvl55zXkdndAHcF1vHwBhCTintsN8VNbomZBwpJOMTvzC9hHToH+PCx7DGfTjVPRK
 1g2s+E6DLJOiJYmO5rnipsWIU841EBLHeZ6W3rLRtMLbx+lJY9adusimGPcLRs7CmQhqKKDB+
 HYACunWXGU3zE96xqYaSK4iA7VAYUbylnjEKfpSZ5BitDGvua7xpQVyiUZ7w56KLS4t+u6d16
 N8j4ToVczLWTZtoV0vgWDf+nHVs701FlDh8rilkedJRPyn2GD1jlcw77r7UZDs5DAd8Den0BT
 YClE15z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-206122965-1493893775=:4905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Wed, 3 May 2017, Ren=C3=A9 Scharfe wrote:

> Am 02.05.2017 um 18:00 schrieb Johannes Schindelin:
> > In the (admittedly, concocted) case that PATH consists only of colons, =
we
> > would leak the duplicated string.
>=20
> Nit: It's about semicolons, right?  At least that's what get_path_split
> is searching for.  Or is there some kind of translation going on?

True, it is semicolons.

I'll reword the commit message to actually use `path delimiters`, to make
it more understandable to the Unix folk (who would most likely be puzzled
that PATH is separated by semicolons).

Thanks,
Dscho
--8323329-206122965-1493893775=:4905--
