Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5977E1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHLTXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:23:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:33249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfHLTXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565637793;
        bh=hpg5udfLOTh4+T8l/icDGxpUQonV5wkJnLZOIlmUJJY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hseYiBmXr8qqrWwOC32KORrDRBhjut/CBuYAvbhSIMCwPeQWFaQ45cqKbb7qY6oFy
         D3u6o99DXnOd18AwZPEPtvzkB56xhZ0vywVMon/wAzoVx7tKBcPE9BEvE2FLKgM5f0
         ydJTGIXiLYq+oDVfpfyuZNFzhkhVZ4EcqKCVvgKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McEDD-1hh6Ep42kx-00JaKM; Mon, 12
 Aug 2019 21:23:13 +0200
Date:   Mon, 12 Aug 2019 21:23:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     git@vger.kernel.org, l.s.r@web.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
In-Reply-To: <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908122118020.46@tvgsbejvaqbjf.bet>
References: <20190810220251.3684-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet> <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1838313867-1565637497=:46"
Content-ID: <nycvar.QRO.7.76.6.1908122123100.656@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:3jzA/LeIVSsLzfbziGzekWDnVWsN6LGAFrb3/WcpFCGBWBqqXKL
 8NU5BW07sSyhKS9DY9s7GetNFSQUD4FU+0Ub/653VtT75yZlm4dkf/vRk40XEB6lhndbuau
 +WVdBEFy7gR7Ul3p/D1VNSnyvkfIRFt8e7jNt/LXz8VZLeZjwij+kGiVRGMHpN5kR2uCXOw
 mqzKF2B0luBVo3rbqn0Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k8t4Rjpfnl0=:Rgyi9DS1kJlESWNrJPf4Li
 2+lUWIQ/vr2d/FSKP+oJhy9iNMRuLETtKWxW/+8DT5zCmv5XkNScoGszrDDGaqIbGwVietm3+
 P0MzqjXx1ipCfSVQn502bvxzLnDTHzZNIwYx0Geba6J5mJ0tTkhSD9mICfDYN1QakGgc22dCR
 uVkSyA6jQQiTmKdon/QBQ3YjSJuXjmDaiQaWmvDfkQYIqr+YZTyhlVmFqjjEV+vIvOpLVBPsb
 fMdOkEJXB5f716/EA5bSHrRG+KFzaN48sDHpQtJXaZyqh83gBhX57khFMeQkARXomEsA8o2yv
 lMfoPEiYRHjR8Njxt/KZurMVATzSGaaRMuMm7eLnvHoAODpJMW+InbzOyWu0k7iJnkKVI53Ax
 87bI2fVUTstwOwH/odiQG/Q72OU5K0sXExJfbBAy6tgZPU2ZlNUwFdVWcCB+28yGwkbH9iO5V
 iDl28lUF56wrrDtDn86WXQOWejj7xReM1SCSmdh98pWTFtE+WkoyXybytAz5Cb2O5oqj3ZqUq
 aidiVAmaWVW84nOC7T3Xm0N5JPIxSwi4GwOYlQaxwV032cziUaMi9Qq/lbub9wFQ+JjcYZFvY
 QYNC2YKh+VES7QsMDX82eH/XcflXDPLjywEJ5F6V/JgYZT33QdCEokwS3/wEtmrQLkpLD4CKI
 ZU/N3MOsB2ZGg/EO1hUz7bhBlOzm+Lg/r+IrwBs95yqD2XPMvsjyEIUcRuUTKnnO8CKAxe2Fe
 S2Sjp1QtfcAXwaL9e5UCl7TjkSw8C9mrQtREtWs7uRfYA3EY2of6E/gONhV4p/JcsOBBHsQE6
 2GGEBP34bi/9kscQct4YmzMArhTTZ0W63cBhvZnccbqD1W4XJxzN7Df7weqIuKnKDt+clH6RO
 6wFbq+MiJmfWBLRvAmkvQhkTQ6SR28NqEdG/tOHwrCrk4T8nuqqO5dZPi2dDlccIjY0GL284S
 j0qF4IXt+BH5u0qQNxBJJAdlGHYOzcMn8ZKTq5+9j/sqFBoRj0tK+32uvY/w07stT71ds8hvi
 7SHItQGnB/5ih4E7NEyypaDBH1GBaiTXPP5EbRjjxjhiuhnEFn9dnuyaNLvFpBKdKDaYSuViH
 JYLl4bvJr7xAC+I3CLKHAhtCOv4Cb4oSV8f0iJ+s+IAcDs/zy4WoEkGHu4GAbu5dyJ2Dj6INL
 O+ugk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1838313867-1565637497=:46
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1908122123101.656@tvgsbejvaqbjf.bet>

Hi Carlo,

On Sun, 11 Aug 2019, Carlo Arenas wrote:

> On Sun, Aug 11, 2019 at 4:20 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 10 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > > cURL is very strict about its allocator being thread safe and so tha=
t might
> > > be an issue to look for.
> >
> > Looks good to me.
>
> it is not ready yet for using though, at minimum I have to fix the #ifde=
f
> so there is no risky of breaking someone's build because they happen
> to still be using and old enough cURL (ex: 7.10)
>
> there is also the risk that xmalloc might not be sufficiently thread
> safe (ex: when it triggers unuse_one_window() through the use of a
> try_to_free_routine in packfile.c but we could mitigate the risk for
> now by doing it only first #ifdef NED (I promise to take it out before
> it even gets to next, assuming Junio would trust me enough after the
> last blow up to even get it into pu)

I was under the impression that we _already_ use `xmalloc()` in plenty
of multi-threaded scenarios...

And yes, nedmalloc meets the demand: it is thread-safe. All allocators
to be used by Git have to be.

> alternatively, getting some feedback from people that know that code
> better like Shawn, since I have to admit I haven't read it enough to
> be fully confident it is safe (although I believe it was enough, or I
> wouldn't had sent it for feedback otherwise)

If you are referring to Shawn Pearce (and I assume you do, because the
other Shawn I found in the shortlog only worked briefly on `git clean`
and `git p4`), I have the sad duty to inform you that he passed away.

> > Still, it is a good idea to ask libcurl to use the same allocator as G=
it.
>
> and it should have a positive performance impact, which should be nice
> to look for.

I actually do not expect any performance impact, given that
communicating via HTTP(S) is partially a waiting game, in any case, the
network will be the bottleneck, not allocating memory.

Ciao,
Dscho

--8323328-1838313867-1565637497=:46--
