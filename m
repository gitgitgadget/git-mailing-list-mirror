Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4311F461
	for <e@80x24.org>; Thu, 29 Aug 2019 11:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfH2LpV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 07:45:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:35355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfH2LpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 07:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567079111;
        bh=Puy11JxksnDZ1SsivGl/GkP8/2iMSCu4Bu251bY9msQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WG+Cah68Gu+A4y+hZDPxHrwdZTpWb596phV1fk8Q9qaTdiUqMTFxCtqV21RiZn/w3
         Jwa4Sin0JCs8JfwpEYKsZy64V1ex9AwEmFhrF5Lb6kq+9J57YHR5H3XIrkVydybsoA
         2fx5wck+QuXqyZWFJ+DYVyQ3uUzwzSxk0vS1JLHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1hjVs63Tjs-00X5tm; Thu, 29
 Aug 2019 13:45:10 +0200
Date:   Thu, 29 Aug 2019 13:45:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Gadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        "Philip.McGraw" <Philip.McGraw@bentley.com>
Subject: Re: [PATCH 1/1] git-p4: auto-delete named temporary file
In-Reply-To: <xmqqpnkozkqz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908291341330.46@tvgsbejvaqbjf.bet>
References: <pull.303.git.gitgitgadget@gmail.com> <CANg4QoGSVQWG3QXzoiA8oDsjXaXGoZ+WMNLSPpu75eJWdrWxLQ@mail.gmail.com> <xmqqo90bj2ye.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1908281424240.46@tvgsbejvaqbjf.bet>
 <xmqqpnkozkqz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M8ZeGUZdazf4ACoiUPVOIo52qLG1CWspKK2Rn5VLfURtt1HjJau
 l5dQOAxb192FXtkaSfj/GVmneVKYbpNVvSZddbQRYrVkFdQpawE7iFM/VyR6t6jHExKwX6p
 /kUdyZopir8Ew0T0VX2DYz0lufyEvL6xe4zexHKKtNdvYLxdclxSnDKvv+xfFmtDFoP6tYN
 P8vx8enB4Isx5nCIXFS1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AfZ0WXRpDYw=:DSpp9/uYzR20v1R1C1NFVv
 e6HFwaIIY3ASOsl/cJRTP2938rrVOtBzrF61VoRM4ZXzWkS6w33o5aAjqUJYVSqy7HVFazWug
 kyh8MUZK3TmW2aN45bUXBE1iibsyzyMMKsBMcu6b8ULW0jEBn2rbouYIXlIE8eZaCCWEfBw8c
 8pyI/E6HP6xDR87slQ4JF1KsaDi0q3xAp0BBCH+PcIYIcyWikIjy8ONEiya48NsHUkRsGNn8z
 nbGCz+toh5b+Gj7oeTHkVleTE6Twt97lbp4LXgvMwg+TqRWG/j6mC5NYQI+o6k8jraFjdsK4A
 6c8Gq20TK40FOxCSZnYTKyLl1m8W2xgGwVfD327AwiJxQBoi0fw/prAn40GL+xAAnycRYiNY1
 h+adc5GkEQYkLkHYs+H6ds9zgB7zK48Juf8MvD7XF3wdLbPvjWsgzrjd0mf5Fd+C131Nym3yd
 Ln2mKpT5E9KAMvb/r3l+yV9rHCOP4h7W45NriNeCmBZxjHn4WX40PvpoiXH0ttf2lXtQUxSC5
 8z+gQWH4vdnAK3tIw0bNZA99miBOtL461KebkQY5lZJGoyFEvCjeUHeEXouDUnWsRURqRGXrk
 ENHUlE42Me/LZ523CvHMRpm786UuCcZTxYgV6OGgNL0davL0YpiixilbexLyt/Ld3KHuQ5E9T
 Kbq92DzjnU++nQAmP0SWdbo8TiyUs9ARFJ2RYUdvGjTmMd6mGtCBwFkELP+TiaR4EvC2TSd2U
 TnryUfgQnzoc/pSI0yL+CME897QKNAgjPva9zJ2VXsd1uOIaqkjr/PsKPg/PFRFRYPMlKd2Wy
 gcjEq11711knrMUBlfai6b/mPL6st5RoupybY95oczsrwNsbzHExHTkM6Sr1pyFEIkaB4STp+
 o0PZegfgX/GjgPi0mSvTH6kWWqyMECgw+NJ/iR5l8ozRYRoNCYSxoUC+v2FL5o5plw4GaKUNc
 iiKJ1f8zTBrw47jDmECQ16xpi6bBbKVq+zoT3uYef5oRZJSdB/R71l1JfeJx+m75BRdLNCqEO
 vwyM4ZRATayeC0b+PhqVG0fDfT9VWSm0Y+tAw40DGcMH5FxzcvxoEnqSAxihl9jTghvat5VI6
 Vjnc8iFAtGKQFhx7Bn967vEHTdmez1rWesvdnJzlDkrTP3FMYpHpqt57WHo63N+WBAlgSFkgd
 yad9zN2mf/rNZamTqYlhFkW6xYX/Opb45pvqymIM3Kzm6hTn9cvdgZospdjFI343rUCKk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 28 Aug 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Yes, this was me trying to re-send the patch via GMail's web UI becaus=
e
> > the first time GitGitGadget sent it, it did not get through (only the
> > cover letter did).
>
> As long as that was manual screw-up, while fixing some glitches in
> the machinery, that is fine.  I care about automation running
> smoothly.

Indeed, I also care about automation, as that keeps me sane (I would not
be able to do everything I do without offloading substantial parts to
Azure Pipelines, like GitGitGadget).

I am quite a bit worried about this, as it seemed to happen at least
three times. I'll see if it happens again, and when it does, I will try
to save the mbox files as build artifacts, and then add another job that
I can run manually to re-send the mbox files that did not make it to the
mailing list (identified by the absence from public-inbox).

At the moment, I am still rather busy elsewhere, trying to catch up
after three weeks that I spent (or tried to spend) mostly offline.

And I am really sorry for not writing a reply to the thread when I tried
to re-send the patch manually, describing what I was doing, and why. I
will try to do better next time!

Ciao,
Dscho
