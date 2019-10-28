Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F161F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfJ1Var (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 17:30:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:55995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfJ1Var (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 17:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572298233;
        bh=WtPFG8nO5qa5OGKSfykUSBXcRxAE46hJLE2Acm0+UOg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i3IWoWuUiB8yMa4eNz/5exK4C25jYhXcJ9D1/xkFC02bQyxrwdTad4wm9Jm0BNJDY
         4O9OYXzoR1U+IQnxQryI98kU8wGKRAUhHRRqm4tGp4Mvjrq+Ny8+8cgZxNKwGLE+X3
         iQ+AcmcwTfdUnqQgEqnBdRF0nX3cE9bL7I4V1qsQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4zAs-1hxnm11s0K-010q8w; Mon, 28
 Oct 2019 22:30:33 +0100
Date:   Mon, 28 Oct 2019 22:30:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value
 in trie_find()
In-Reply-To: <20191028120054.GS4348@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1910282229480.46@tvgsbejvaqbjf.bet>
References: <20191021160043.701-1-szeder.dev@gmail.com> <20191021160043.701-6-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1910281155220.46@tvgsbejvaqbjf.bet> <20191028120054.GS4348@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-100152832-1572298233=:46"
X-Provags-ID: V03:K1:dez3qySyIkTwV0A7A6pnfpeAzOpsKBaeJb2o2AQDM1KqRPix7Vl
 GyLBIOPkkbHN+gQpeW7ljcItL7FCcfi54rVCkRreB9R0dtAxHnsTXDD6IZCWfr7dw9CX1mL
 WKpt1/A/qyYc7i7A/P/5dGqFNd3Ods3bUgNPqnPLmhoduXj71p79GYkjSV2ElliaG8/12xo
 8hf0ojqX6IGG0w83Z6gLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KdciAe8Na8g=:cdvYldbb3yCkfjOEzpKFTh
 Te9WQWeTw/DTZf9o12tpuXOI0lSYhKzW3frFNdvXLDs6viO846EI4EX4qV8yXhtB5CLuMeGzF
 TJGqnWV5Ba/9JJQ/4bo9kLhRgkRN3U4Y9MsdtGa2NnUIr9cNwGJTwdSb2D6ML6+kVTj0R4GMJ
 SUPRjkivefKqHF6x+y+/7IbCWV3CyBFVM8MVEiwmxxS9VAcFPniikCXSvWMMhD2pT/PiXC8uo
 EZc0mXTzS67Zf+mPy101ScdJbTCHB2LJ6t84gri5ROPoy4CQAmnRAyeWTXYZ+n1t2OI77gmt+
 mxTLh64W+PCS7BmLeMNVUp1uvnyZO1NYplhQwE89YqXN4ROYwFH6AqNBv5oDjoMnFkUT4i80R
 XtN/i3zdgT+UBR7jtlseQmZuZz7e0hkKFgrekVa9+2XPJaDaB6w9wAKnc+1mYY9BfAWTgsvlI
 VcwthLuKCBXpWuXyybF2Gw3rTYzHG3pEJB8rnc1bxkpzvzcXmQc4I2lAsXNRnJBxmz37+W0UW
 cYp8MicNRMr5i5hYhTxfzujQMGS+0KAWi/aO3zt1hepxnHSiJzKmWdhlbIGvMVHtquxGyuMMN
 Xz/THzkyCB0ABhui5mFC1GlTbs9etPhXPD5EtUhtsSjQTNd+s+C3urlUh2yT5hd4V3VbddQUY
 GF8Xv0WDsCebZEgisw4AxrrGiEyFtOuyJqgknTucsKSj+XTR0U+kKRg8eST6vIwk9A/MrAXdr
 FQmHIqxx4hqy/d7V7DI61lLnT+RK1TSN5CsWqPB0845uWDv/3AKtTm25Kc8HmUqJtfhu/OrAm
 P7XRuJa5iKgQi3Ge3U9hXY19EG+knZMa9U0by/v4MWJIldFOXFFTd6oAAndbB2+89ip5ohUZG
 +E93Z7uK2RYFP7K3IZqMQzb2v965jwOIonjtaLJjDEbtN5HLr3RjNQu/WPnI0hukqve4NqlYN
 S+dxDbvx7AT6vX+G5ZRs+nmx3KMpqc3zgCaGwtjEbUb7cZ8BM29z/JkScHHgLfePv9zCMqkwO
 Fi0gHNsMkx4u1Wg3KXzyiVZVsa2lX9LCKDAn/df2PRGC/xzZgYrxlGbmR2F5k4hEEa6jmQ2Ii
 1Nekzr5N/gkeXlmWBPUmPBBSqsYpxvd/UyQzzF2+mHCsQOy6JaJCrgxwkznlNzoPRY2ju4NUz
 JpG6Md4vtlyhh9OEzjGiYdicuK7EhDT1XGk/BfwdYx4PnUlQJOeXoDtRr/1/1NEb/yKg55NFm
 IMNBuR9tuXvAKuaR1Uudq/61j0Vk3fogK0ICZkxOQ3NocEpNOqLQweOXxZNU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-100152832-1572298233=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 28 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Oct 28, 2019 at 11:57:10AM +0100, Johannes Schindelin wrote:
> > >   - According to the comment describing trie_find(), it should only
> > >     call the given match function 'fn' for a "/-or-\0-terminated
> > >     prefix of the key for which the trie contains a value".  This is
> > >     not true: there are three places where trie_find() calls the mat=
ch
> > >     function, but one of them is missing the check for value's
> > >     existence.
>
> > Thank you for this entire patch series. Just one nit:
> >
> >
> > > diff --git a/path.c b/path.c
> > > index cf57bd52dd..e21b00c4d4 100644
> > > --- a/path.c
> > > +++ b/path.c
> > > @@ -299,9 +299,13 @@ static int trie_find(struct trie *root, const c=
har *key, match_fn fn,
> > >
> > >  	/* Matched the entire compressed section */
> > >  	key +=3D i;
> > > -	if (!*key)
> > > +	if (!*key) {
> > >  		/* End of key */
> > > -		return fn(key, root->value, baton);
> > > +		if (root->value)
> > > +			return fn(key, root->value, baton);
> > > +		else
> > > +			return -1;
> >
> > I would have preferred this:
> >
> > +		if (!root->value)
> > +			return -1;
> > +		return fn(key, root->value, baton);
> >
> > ... as it would more accurately reflect my mental model of an "early
> > out".
>
> The checks at the other two of those three callsites look like this,
> and I just followed suit for the sake of consistency.

Oh, okay. Sorry for the noise, then.

Thanks,
Dscho

--8323328-100152832-1572298233=:46--
