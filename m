Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D512420A21
	for <e@80x24.org>; Thu, 14 Sep 2017 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdINSqH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 14:46:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:53304 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbdINSqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 14:46:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnCkb-1dE0nG3wuz-00hPVU; Thu, 14
 Sep 2017 20:45:40 +0200
Date:   Thu, 14 Sep 2017 20:45:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wRhnIxLiofwHUgy0e0rrJssKcRkvWRvPbLhT1PRBq+TAcyo7BEj
 yRx7K5FmASBhxjX1HaOJElul0pGPcvjCYQyATkfoNyJcmNbETjxF4iTgxMYpj6Ir2cdeEW/
 BkTgH3jF3txAMeFziOd4yGDeIcVBnLYYj63b78PxDpxh2v/rG+38wYMVG4MqR4dqVZ/DonK
 vkX9Tu81Yxkea4CkkdshQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WM+4IUxZeFE=:DjRCTb3Uuc+KsQBjhVVTVT
 vrLsa7urY0S2OE4pP6bWu2L3UN7IcjwYatga+DPN/2/zgQv2/nYRC6CKhr8wkE2Y5a+NHiKej
 h3DFLdVEuMuepzo1r89zSX75GwbbOxD22u9DposggLSI57kayqy63kj2dvgN4tJCUBte3Fbsi
 y9S2RHWHr+df07mi5a0G4+pImC9MD/GMN4+FG97pCQbgEGgLJ2pjt41oPAQQRgUX0szkvlQrc
 LBK4sZX/EvZF4JHvnAUn0KqmSCATLVhS5n2yMLpPbzCKfUrLsgkJADa5X3de8hNdWas086K47
 biElaO0hIOi4wn/I1Jip1xBgxmZ4GbI/UGxe75h+kr2mBTFKuOdErmssUPQv2A5JZNkBibx1S
 Tcly5SNuztDCS7wdls1xiJw0CVTfwwGyZ6U/ud5kkt9RstHhfGZOerMJnsPOqbuxFqQu0De5k
 8rj8Ao+ntvFDsH5aIl4tRnZ0jPc1j9KP9lM0NSWzPTKLtv0iBK5VuF5xsbtGsURKk0uISy7ny
 ktJdN9RPIvbgVFshNUkiszKxGRIg+4t6SFX40+eaOaZGc2GUl6kGcOawHR0DOdOGvBfjPID60
 VE16oVTlCWwHWl+dVmaotcLkaPs0OriX9yfCHEWnndcO5TAFhbNN8VhsVvmqd3ryDtsrG0MXB
 OUkypHpnqeIT0NddszCDGiFUHrzFhqOn28IGFAihVOKXbNRKxC18PiaqXROksaC1GiXMwD+R+
 zhh2dpT9nS5owdhKfgaRPaVx4DjWbe/2qBWrXq3zVkeSQqMhOPJWRYjR7Tri+Kvej+0dvNxLh
 OnxZu8YTymYqWcBTtvtwgRwGDws+PmhYZoyrxZtY5boKMapBmI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus,

On Wed, 13 Sep 2017, Linus Torvalds wrote:

> On Wed, Sep 13, 2017 at 6:43 AM, demerphq <demerphq@gmail.com> wrote:
> >
> > SHA3 however uses a completely different design where it mixes a 1088
> > bit block into a 1600 bit state, for a leverage of 2:3, and the excess
> > is *preserved between each block*.
> 
> Yes. And considering that the SHA1 attack was actually predicated on
> the fact that each block was independent (no extra state between), I
> do think SHA3 is a better model.
> 
> So I'd rather see SHA3-256 than SHA256.

SHA-256 got much more cryptanalysis than SHA3-256, and apart from the
length-extension problem that does not affect Git's usage, there are no
known weaknesses so far.

It would seem that the experts I talked to were much more concerned about
that amount of attention than the particulars of the algorithm. My
impression was that the new features of SHA3 were less studied than the
well-known features of SHA2, and that the new-ness of SHA3 is not
necessarily a good thing.

You will have to deal with the fact that I trust the crypto experts'
opinion on this a lot more than your opinion. Sure, you learned from the
fact that you had been warned about SHA-1 already seeing theoretical
attacks in 2005 and still choosing to hard-wire it into Git. And yet, you
are still no more of a cryptography expert than I am.

Ciao,
Dscho
