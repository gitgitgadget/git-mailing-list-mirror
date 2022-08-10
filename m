Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D13C25B08
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiHJJ0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiHJJ0a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:26:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487858B56
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660123585;
        bh=AL65ZtRhZSZB6e++nkGAzjtBOejdRAf3urzqYhEvrgA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NMN5dN0ATy9b8uDpdl6Uw0+0rZyIobeG/cVbT1fiGxUwrfUPjI9cbHIHPMvRBeSdB
         6EhB8uH7EWFafL2lsYh7sLWKFCFHwFw34LlfXz0ILA4Nxt47KuPpf9dViO4odGZ8Wy
         OlT/XGFjP6BJG7KOEUPMsI2oe7Pj0kj8QdUSQaRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.204.74] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XPt-1nHS9h3kcT-014TgY; Wed, 10
 Aug 2022 11:26:24 +0200
Date:   Wed, 10 Aug 2022 11:26:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2022, #02; Fri, 5)
In-Reply-To: <xmqqa68evodq.fsf@gitster.g>
Message-ID: <o5340r34-027q-4ops-93o1-8368s4qropo5@tzk.qr>
References: <xmqqa68ixcrf.fsf@gitster.g>        <CAPig+cSz9RKj43_kwQFDQpN2Ggrimrw_DcOFnxGS+nBCPqDK5Q@mail.gmail.com> <xmqqa68evodq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OFwwzW1ty6s4rgqDPrkaI+Md3Y3rirSlMIWG0V3dgz+En8sD7UU
 4/Awc38jWHt74o0MqhxxPyUVHuWlEsJ+3X192vVSX8trzg814W83BF82QFHuCnmbUHdMzRo
 7UweFszV4IVQpx2vH8GbP85cjqJl4YCtMT3CJwOmtOu6l/SJIYq/UBCr9/eqAlH4t3Y4EJ4
 t0YyrXnlsZx6tVB1MYWJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IEPNVKeQRBA=:Zltxjd7rqwN5ONVPND8LpR
 +kSrCCA0BHIoyNB/Tyq9b+bmrP1jls7qD/ofVbiBrmfCwCj6V9ljw8LVLa4sXliwfLucLXa7i
 ZY4AtsxezD9hhfIA1cpsI434EbOwCITxIjmJXyVKzNoNAQ4acjD1fdPRrKsuEAKC/5T2rIJLQ
 rvofKY8kkLrg2pfgHzMxp4P8QyV7p3kFqzRJ4YV5gietebWvciMRKGjXdo0Aosu1n11ZiPa22
 FSE9TW1RMai6hwc3U7Fv4SZMpDGXnHRDB1D4fKK4NCTPcfI1t+BHjzKTp7wN8QE3agp6Ix+uN
 t+8odPrVdm7h+t4dhjVquviA1OdCYZY/WnouyTk4I0o4wIfxauzLQd+Ng8g9h02oekCFFvA9h
 UDdeHQ370aC9SXh/yuM18jbGVBNFMwrecQBOVdPqufjuezRfebTJA+Kx3bdMUprB4JaCbnlfi
 JU7TEw8QyPfOD8C3MCHgebdnT1+7g79Q4mYWmYEn2JqVx23suTWNmwUnt8pmErnDxUuJD+M4n
 spquNKPIhVZpVBJccg8PU4gtNu0Z+2TQ919N4nBSzd5sbThVlMYiA1GCK6iHz7Kcb3wETCTkM
 dZxMiutOYAll2abLzxQHFAsJ95+CSG/ZLNbm6HUyL07KWTGZuyQoz3/wOyXJEalioPsg3cFW1
 lYp6FHhz8tUjkCBJCLHU5Bu60F4Maoo3+4FtUko/mzT8KadsTdhnscZ659JvIJMNjeTT/R71V
 UugFjetaM1zhBm7p38Dco3orKRAqiECRzE4KL3DMA9dCIcHs1j+A1SHzMIfWs2ri7gARVehUO
 irOD3bRzvtes86bHK6gdtZzKUrDxMa7R0XQg/d8hgB1p2zDiMIgsG/v4k5fqBfGCEKCTbuC8+
 8HESVI1XBwNBG2oe3koyhBuWIF+/ZeWOhay9oRdsQl+IFad1QrlmJGJTcrqDqA5fX2vgiQ4jQ
 LiFS05ZTmJvfIenkXXoRbof9o4bOB5eq0LbCzo7S1u5xnfII1GjUDnkMzlbCRyye/gBVC4t02
 SLYb4+8LFdqJ0T+08FHhosIMfBKEfFtXBB9RjAX5MGylVl3i6WMQcuLjENcBu7+GEkFd7a5dY
 xPrm5MYhrt3dzMCExokgBmuchPq/CNz4sDy3ILD9lFHXRLX9xVTG1XRrA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Eric,

On Mon, 8 Aug 2022, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Fri, Aug 5, 2022 at 11:44 PM Junio C Hamano <gitster@pobox.com> wro=
te:
> >> * es/doc-creation-factor-fix (2022-07-28) 2 commits
> >>  - range-diff: clarify --creation-factor=3D<factor>
> >>  - format-patch: clarify --creation-factor=3D<factor>
> >>
> >>  Expecting a reroll.
> >>  source: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
> >
> > Per [1] and [2], I think the intention was to drop these patches
> > rather than moving forward with them.
> >
> > [1]: https://lore.kernel.org/git/CAPig+cQ94oC-6wftkP_=3DRSEsOVPKeuBWuM=
shDkwV+Xu_FjrKeg@mail.gmail.com/
> > [2]: https://lore.kernel.org/git/xmqqa68nlfiz.fsf@gitster.g/
>
> I think we are expecting a submission by Dscho to replace these two
> patches.

Oh? I thought Eric was on top of things much more than I am, I just tried
to provide clarity about the intentions behind the original wording.

Eric, please do feel free to Cc: me on any new iteration you want to send;
I won't be able to work on a patch to reword the `range-diff`
documentation.

Ciao,
Dscho
