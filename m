Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71861F461
	for <e@80x24.org>; Thu,  4 Jul 2019 21:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfGDVwd (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 17:52:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:57571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfGDVwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 17:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562277145;
        bh=ESIstmPJ0CfatT47+tQb8CsPq6aK6LB67NmApp0L/jk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DNjSml6iOeslhU8pvsc8AgzkiGgqEoouMYlxNRDtSys9zxsyG2ydrpc0d7SCa+CGN
         Lv3ye3xJnw+0QyYmnIwEpOnlmccTUxJv43PCiFnYrnGFYPRM5rE3Uqs4Cfj7vLsRKC
         qgO46zVqM/8fukrtElLT2gMwC4g7GP29/KLb4T1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1iWj250sCC-00uLMH; Thu, 04
 Jul 2019 23:52:25 +0200
Date:   Thu, 4 Jul 2019 23:52:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Beat Bolli <dev+git@drbeat.li>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mingw: get pw_name in UTF-8 format
In-Reply-To: <9bd9efde-8971-08f2-8417-1036286c9d1a@drbeat.li>
Message-ID: <nycvar.QRO.7.76.6.1907042350510.44@tvgsbejvaqbjf.bet>
References: <pull.147.git.gitgitgadget@gmail.com> <54fff4ef40d1dba2153de27413fb53e992228b5b.1561628237.git.gitgitgadget@gmail.com> <9bd9efde-8971-08f2-8417-1036286c9d1a@drbeat.li>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jU3g9f09Cl4f4W3IlLIdmm/EbEdkFXMbc/7KfgukOEbkhoBn58n
 9vs30nDTB51JjNtedksAm+fntH1kOIvNe9QHBOWXrCJjuV9XG3YBywKutClchcPH3BiuPF2
 SEYCDwuPvsSiI1/eEjHzqGxULKUw1uqiBsdRpO7opMgNQfYPVdCu6x5URGwCK+JZE0L5/SY
 Mnr5w+calFr+Yv/oPLwpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ThP4K7PG41g=:zMeI4uOj29oFYw6EWAXX3Z
 9wYIlAsi6ixKdWm6Fv9A8rMHKV4DIcO87PFiKaqjKZ8xJqvRYSVveMpL9J5fTy1kFb7GmbVuI
 nO9s/RTPteQU1OKAch+RjS2JiSkK3VpHExtsiRRG5yfKjJR/CjJzgwvqk7FtCXuONasQXBe+D
 zVeJYIfR1mV6bcHTBM9fBI1G94FMhWl7PKJOb4y0JpKhyD1Bowewm+SS9dNwp20W4NaDThqMq
 VQebezM4BMvR522NW/C063QzCU+JT3OREqdwBca1jUX1o6DTM61zVGpZbW2vCOIyGtHppFi5q
 A9TyY60eiZeIovMgBlJ9sc40TLaIAa4xKRNpPACbCHhbtWj2sdYW2BEPEE4F81K9GPGYz7Egx
 EbZnXjrfKXNCb3mZEQ5yYymI74+Oh8UX62kDug5EkfFjpF7RKOfmu1QlYn3ZUPEp+d3uvltUI
 vhlz3hp2aTgUkpz0WxBtBnKidByjmyH0JgTEDEDUyVYoQbacWt/rFPuzgTh15bugjhOafNnEb
 JmjQUlsZ/bUorevKXaB6YkhapM8RGKDzMAWJihu/Ae585+n90suX3bPZweXNwtS7+RweKGt9/
 +uMFKh9s7bbPGO9IR4N/0xuXpce6dxxM++sYXzAEsd2ad5dThPtq+k3aF03PplaYocAh226L8
 gJRZLT5GTroWsEiZykodccMPcWDFbvxZuVkmnsX5KmBnm51AcEwry8b8HHcPcWIbXR+cjVmPX
 xn0+FyrudTNPkb3ksXx+fxAV8MX3XloxSOptI/qHpISS72+hcpbMUfQgogSU1KGW+n1+peM2l
 M5HA35a9es07qURpCJo2TV4Qoon4YEzRxWapNBmXAGX0Y8E+bNYnn7CX59K9CUnI58RwFW7FP
 wc3REqxhdf8A99jFyKNRTacjuGPB4WvPsyd17UW3Vd6zCjTMhCxvSc8nbvVJycUyVEpKFdIYm
 qF8z6OdjjOtXYnX6EBvzfFsbkDcFYPvn9Wn7ti7bpXslsIaXck+wEJvEFl2LvDw8ezXnhfcHC
 QcxmDom6HLVVYVeA53rMFNFRi3wHG4r/z8AxfnZ1RuZsv7hRwYXGRVMhD9/ze1P1ZDQyAQ+yh
 ewfwCX4HrR4hvAFN37hXVtqj0LQA07+MfSY
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

On Thu, 4 Jul 2019, Beat Bolli wrote:

> On 27.06.19 11:37, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Previously, we would have obtained the user name encoded in whatever t=
he
> > current code page is.
> >
> > Note: the "user name" here does not denote the full name but instead t=
he
> > short logon name.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  compat/mingw.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 9b6d2400e1..8526876262 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1946,13 +1946,19 @@ struct passwd *getpwuid(int uid)
> >  	static unsigned initialized;
> >  	static char user_name[100];
> >  	static struct passwd *p;
> > +	wchar_t buf[100];
> >  	DWORD len;
> >
> >  	if (initialized)
> >  		return p;
> >
> > -	len =3D sizeof(user_name);
> > -	if (!GetUserName(user_name, &len)) {
> > +	len =3D sizeof(buf);
>
> I think this should be "len =3D sizeof(buf) / sizeof(buf[0])".
>
> GetUserNameW() takes the number of characters, not bytes.

Good catch.

How about I use `ARRAY_SIZE(buf)`? Since this is already in `next`, I will
prepare a follow-up patch.

Ciao,
Dscho

>
> > +	if (!GetUserNameW(buf, &len)) {
> > +		initialized =3D 1;
> > +		return NULL;
> > +	}
> > +
> > +	if (xwcstoutf(user_name, buf, sizeof(user_name)) < 0) {
> >  		initialized =3D 1;
> >  		return NULL;
> >  	}
> >
>
> Cheers,
> Beat
>
