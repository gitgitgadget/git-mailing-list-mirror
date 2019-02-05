Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B20B1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 10:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfBEKit (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 05:38:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:53827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfBEKis (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 05:38:48 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDE6y-1guFtw14kG-00Gcj4; Tue, 05
 Feb 2019 11:38:46 +0100
Date:   Tue, 5 Feb 2019 11:38:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
In-Reply-To: <ea7b1875-1a23-e4e8-e30e-5b769d282323@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1902051136410.41@tvgsbejvaqbjf.bet>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org> <5d521649-0b21-04e3-3182-e8714fcbfeac@kdbg.org> <nycvar.QRO.7.76.6.1902041135320.41@tvgsbejvaqbjf.bet> <ea7b1875-1a23-e4e8-e30e-5b769d282323@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dZdNqVctMd9KdcABfsLti6v5oE5EtT5f00gENaGLdXGxj1Gf3Zd
 GuO10IUxvZApHh7jffEkmOMOWgXiD+Xb39cfJMma7s8h3FviWq54GpQZa1nWx0RsK9jsJK5
 rOvqWUAvPjbwnyN2GYJUbdlc8JPrLi+tWh9uSX19OV2MDef+yVWwq4DYR3s59YcoyHeEAjV
 W+LI+mheSCxu7JL4OMnNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fdjh0KhZUSc=:7HBh6zu5s7uX7Z+jJU6qEy
 oNd6haDuZklRuRZNzqLmNZ5zbyWjr7lf0KKwD3z35/LhE4USIeC9k0MFMIf00mFbM3OG//XRa
 OkhetvKJGBnSHqzJQmLQC+nZrpUjNDSD4LSIbmonHI4zJCP/+o9assDGunzVD+WHpwYioWQhg
 80Tq6bb/jrM4pMDUchoPrPkgM/oZf98PdMlkqAgY1Yvt9rZaL2AafGy6dAnJx8PSG0XcYqQse
 2tYXCtgUevK2B2xJvmCNxHGut30MgoWaYLvp1hHuF256juxcvUEtKjwewxDyl2xSSPNoDP4Cb
 dKow/ZeXvseDHif13M6xkqhTOlX1yt3rFTj9crNeiDKeRxpjYteUdmKPSUSfnfUXp4Sp8FgWh
 02C2dxfiGSxSQrFgOQ1m6W6m3ksHGwtNUN4fW4a0wUQmQq0tyaxwRs66CGIu3KATuhT+oXqNa
 TlIb/UZXf4gU/Dn5of6+0bWmA8XmAdgLWy6cRCdzKXAuzpEqQwCl2cBIqKtLB1qzpzuKsmSpw
 x5a6JZGrznZ4sk9s9NEBeAnCwBSFXs59nSKffzNyLOlNT0R89uIXkgWejJ8skg3GJXjE8a7md
 AmuzlO3MTTAS4mom4u+zLIzGBRgDKyDRUFeas0n8yjVjOWQAmjbySd+HAlsQreEK0Ir+BKdth
 LjG2/1h8+p4KOTtULI6e1+oDz6tAWOCpmtVVYRjd+B5F5mlp8v+Eh6OHDhnMOzSgMNKVGH6fQ
 o6K1wxJd2HQxyVyjQrLnVsHP9kPSYwAvrWnu8I5L3j6fh3RQRtymNXLc3VOAp0m6oQzzMbBqp
 sfxIJBMJWO3Q8QRXMsyKl9ZS3MSFJaki1rHnRUzt3o1QXiFW0tSxWCre5FoKMsc3IR+R+ZBTx
 pWxQJ6WruZylhZyBcJFG/XizPPAV6xoGO7t5bqzgDCG88ZEFMJdyHy4hetQ8wIBpekO4KQn2+
 0k8/bWpaFnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 4 Feb 2019, Johannes Sixt wrote:

> Am 04.02.19 um 11:38 schrieb Johannes Schindelin:
> > On Mon, 4 Feb 2019, Johannes Sixt wrote:
> > 
> >> Am 03.02.19 um 17:51 schrieb Johannes Sixt:
> >>> strbuf_vinsertf inserts a formatted string in the middle of an existing
> >>> strbuf value.
> >>
> >> Quite frankly, this is a really unusual operation, and I'd prefer to get
> >> rid of it. There is only one call, and it looks like it only wants to be
> >> lazy and save one strbuf variable.
> > 
> > The only reason why there are not more callers is that I did not convert
> > any of the appropriate places. We have quite a few places where we
> > allocate a new strbuf for the sole purpose of formatting something that is
> > then inserted into an already existing strbuf (possibly extending the
> > buffer, which might require a move of the buffer just because that
> > temporary strbuf is in the way).
> > 
> > It does not sound like good practice to me to allocate things left and
> > right, only to reallocate something that was just allocated anyway and to
> > copy things into that and then release things left and right.
> 
> I prefer separation of concerns at the expense of a bit of resource
> consumption that is not measurable. But that is the only argument that I
> have.

As far as I am concerned, the `strbuf_vinsertf()` function does not
conflate any concerns... It has one, very easily explained concern: to
interpolate text into the middle of a `strbuf`, much like `strbuf_vaddf()`
interpolates text at the end of one...

You found a bug in the implementation of that concern, is all, and fixed
it, for which I am grateful.

Ciao,
Dscho
