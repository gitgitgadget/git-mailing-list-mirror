Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0ECB1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 08:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfJCIJX (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 04:09:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:34465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfJCIJW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 04:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570090155;
        bh=0l6ScxZTvgJqgeOp4lc+mMkK7tDF9/eDqQcE5+oKBeM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a0axzK7DEVini6wXCJDe8I9aD6gvW31oxrbc1lS+M3J0ZvuPvm8Tr0Np5IJzNG66W
         2uNJqf/95+QuIf0dSSL5G0PGEGbXZL2tBtwYBi+Fqva3faGjm+XjWFQyyA/EViDsoj
         ZLBaRi2bT0Ip86n+W6O2sQmXo9wCZmqP9Qitkbr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1hmLi94BuZ-00qlNr; Thu, 03
 Oct 2019 10:09:15 +0200
Date:   Thu, 3 Oct 2019 10:08:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v5 2/3] grep: make PCRE2 aware of custom allocator
In-Reply-To: <xmqqwodmbewl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910031007060.46@tvgsbejvaqbjf.bet>
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com> <20190809030210.18353-3-carenas@gmail.com> <nycvar.QRO.7.76.6.1908271057280.46@tvgsbejvaqbjf.bet> <CAPUEspjJNSrJQT7xV2fsdp2t5odW5fzzPdDxuar_5x_JPUtf6Q@mail.gmail.com>
 <xmqqwodmbewl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uJ2Yk8oge2fliE3GdprHcES3/BV9fyIoDVPOHlbyVqPKODWp5I+
 Hiex6zmDM+avSyqk7T982WsFETVopcFSdVf7GdSSlxo97S2LoZChhMqEAhv9I7YdpUAH0K2
 0uq+MRrm+Vao32yaAXHQIaQKLQhF+DrULO7uCL9lfwM2Vtn1FYt2Nc/jkqfYbmoAXt9sVPG
 mPOkZBubyCOnVBhXHC45w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eU/unrsXtbQ=:n3l4Lq7Y8797fV5kc8o4T9
 tPXJ5p/3V90ZTVJsoTg4vosXIomr/DI/eY8VZPpnaHjRKLtD32emLm+vHuIv3MfkiRAE8Jeny
 CdHyIfxmzSlTwSZoWWd3KIFSRoG/jnHkEs8JpGxuuOJRPeLnzDizCzbpGa8G2XAY19OlJHSN3
 POxcPx53lIob6rUntxAPKa6DRuA866izg9+LeOWoKi+jWQpi4Pb83DaS4yv9i7RkPhw0nt0wY
 ajLLjWWE8cVmDZA/TJK5FXjNc6gbIt1iwSRomDDGlHGJblxsL4aCIzoMUtCuiBNnxYRIDdsQS
 XlDAkwv9u9SZNUgh32K6ED5gYCf887gTa9OKRGpxwM0vR235hNsH/ipVRfeI/lQrUF0Lvj58Y
 wt95G248HfSbWiXdrmyr4qzFgkT9yQzixQPXOJdu2J51AfhAcrBXMBCduCI9kYFfdv/jrOa5l
 Pvefqd5TJvOi/mTtBwAQ+n7lx5gdZBXgUriqbAUklo2B16ZMs6r+2Mv/c/fV5ficyGghlIz32
 CWYyneffxdXmpNbYyjCV2uBU9riyUNWfH+rVJ4U62G9UPnbh8OgF5jnqqIg+/9pgOpmuAG4Lm
 SuXVDmuof0/n2wELtbBkNhr9TV9fzeOBFYlLx3JC8XUMuIWFofuxERZzpV1CZts5qVjtHm64/
 TOf/W/3rVqFSBVS9885N2jmOB4fHM8ufhQu6uAIX9+PG7vZdssnS+jBB946GwFzgpHnJgNNwZ
 dCWXSQPPMXOUIG2WAXn6dM0bePK9jU8AYcp9NUITc8Tx8JLNAnWOZWdhtNiu5boIkTK/JQH7d
 3Fe/DbhjEWyGWNPJhwEdWXMyheQ1BcG9wjVsdvSlZ+FGvhLt7+5WMuGyJv9bIvkuN+NuDX0RF
 OjJBk4+NlLVSNGUFqQ+tlzdAPD2bcG+52bGRUU4lYcya5L6FB6z4sErRLwkdSM9vTSRcWKKIM
 a2gxRjs48nF+Vz+JrCLFFaP1kLujjNReCbf1EzWGjCdXoidA895O/vgcVkylOuBa4xMgYP61b
 iDLIfapPqAacl5G8ZaFD46xdaUrSEf0TkgKS7cBlK7heqxk+kgPmVTv6hWJW9iTFF9FZe3coz
 F9bVgj/vrKBwK7MXb8aaQvX1BKY5MA36kQ/k9f61/zeJ9XgE5IGWXZhzV7cA68n+U41HDp/Mj
 PgyuZQApNlsPlmNKwia5S5Qapjv0RgZ23S3iqiO5V0sNl43Z3gwi3vg+sCFNTu1/DjAY4Y0N4
 jyLCFWTyhsFfVdRQ4hQQxuifBbA3KIMvJ11CDzBC/We8DLZ1cpfuMpbVWg6k=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 3 Oct 2019, Junio C Hamano wrote:

> Carlo Arenas <carenas@gmail.com> writes:
>
> > On Tue, Aug 27, 2019 at 2:07 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> Unfortunately, this is _still_ incorrect.
> > ...
> > Just to clarify, I think my patch accounts for that (haven't tested
> > that assumption, but will do now that I have a windows box, probably
> > even with mi-alloc) but yes, the only reason why there were references
> > to NEDMALLOC was to isolate the code and make sure the fix was
> > tackling the problem, it was not my intention to do so at the end,
> > specially once we agreed that xmalloc should be used anyway.
> > ...
> > apologize for the delays, and will be fine using your squash, mine,
> > the V6 RC (my preference) or dropping this series from pu if that
> > would help clear the ugliness of pu for windows
>
> So,... have we seen any conclusion on this?  Can any of you guys
> give us a pointer to or copies of the candidate to be the final
> solution of this topic, please?

I still need
https://github.com/git-for-windows/git/commit/719beb813e4f27f090696ce583df=
3e5f3c480545
and
https://github.com/git-for-windows/git/commit/3369c322bbd95820b971701fef7d=
b44b26dd826f
to fix that part in Git for Windows' `shears/pu` branch (i.e. the
continuously rebased patch thicket).

Ciao,
Dscho
