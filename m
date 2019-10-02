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
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D7D1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 09:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfJBJtO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 05:49:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:36697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfJBJtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 05:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570009744;
        bh=XfqMKZZXBmo8qSkLQlZ1y+f+u0k4/KSe2bZ/U48oQ3w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iTjmSPMdeqkfRiYgo6636S9RPwPsI6VmfAH/FD7MWQXe1yY9Wupi1L2l8IXiOAvlU
         velVM+WWd98Kyk2R+sxlOu8m4PD745otUxKWzyzV33CGOz0LjtOSeezO5Ie4YIc3Ke
         P0pkxg1ba48+ujKLL9SUEHbhU2l+iPDuF6P91lmk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1icrqH1eST-00YUlt; Wed, 02
 Oct 2019 11:49:04 +0200
Date:   Wed, 2 Oct 2019 11:48:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 1/5] sequencer: update `total_nr' when adding an item
 to a todo list
In-Reply-To: <xmqqh84red54.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910021147390.46@tvgsbejvaqbjf.bet>
References: <20190925201315.19722-1-alban.gruin@gmail.com> <20190925201315.19722-2-alban.gruin@gmail.com> <xmqqbluzhp8g.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910021005050.46@tvgsbejvaqbjf.bet> <xmqqh84red54.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GrQMzYDukzE1+ZiL5Iaz1q7DHkLoC9ObgR69ePTdWkrX8gfHcLV
 kpK+8ue0revJrpMD8ZKTCmu7yIjVNQi4CznOZOpd+dg4KpLKGE8a22S97b3WfRk4zA6ZSTv
 ZT9WLAdmXO4Fq8TtcmPYIeLlF7o3VRPUF1SIOzIVdMr9CsRmKwzr1ScSvgogWaznK5GjOWh
 bPAYu3i5MoieOhCOhytvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3BIYQOjM9rs=:dKa1aAAV9vxg3XHd3aZl+K
 IZuT5Fb8BfsaS54+8F/+SnaQ9tjbfQqbp5NEynuHODgHGkLuCPzO+/fF6WNyuvY8KMFxyYa/R
 W6nV+EPAP0u3ByCKqdM08Q6OWO7fqpOI0KYg3EXvsEzFoiM4IgECkm1tvgLzvVxFNceZQG0l2
 29RIWGG+d1FbHxzYW6nng1GjwOWpUFYd1rkU2Mbk2fPNg1Hqyk7fH3nDA4JlNtNfhkjXcCUvV
 3W0vyjS1h/+38XeHQT+N0+CIEx9M1R9qdH3FlMneDY118mV71VmJ9lBOqj0Ixe87jrsIq84H+
 VdQuOq99lqZxJ7cTuKXp8PlDSTU2A3GOxt/icKc7p3cTAdC8xnlEUgEgrC3zVzkMCxfNV8sHC
 dIyc73Rp+xfVtHCIp6ozerr3d9VasRECBhJ0zy1fuL6k0E96tNyp1iO0WXU7t8SQ0gAwbgSpr
 5oZDrHHRUlwHq4Aumc4nrEfC6XDukJrkXsJLPnyVuNCdXY/K9QvhbkE5O4Pm4D06+wKnhVSGD
 szDULbj2UxIbb0FfLH69YgJQQNgbV9zPZD9y+bCCwDmjNwUSFIZqRaXssZS9PVIzPNyPeWUh0
 mfxI5243VFMrSN4ZVvkKnocmKjXhs/vUrw1fqp02/2+dfktPB+Vosk4qXiSkSDS+JqhweiGiw
 TTbXnJmM4V8xs/6FOY5QVAhmK7lIFriacLtl0Rs6UDTxd+Sds3nYjE72m/YrB9X8pD64ghWcM
 Qnd1v4OnwtO/H8E5UmmKy2T990ONuIMa7ZhPh5v1B17HmY6HoR48HS6k0VDZP8OKZP0YtHAA6
 pT2aHC6J6HjwCeQ/DED7smnb6MTVeP3rTfX/rdeapXW3HdoeRtQxgiifnzLp1CoBEEUePaPkD
 4RiimTM744cJuoVWpiayfL5weJgsNjpjzxJbLON9htWW88cIRJt7Q1pWyRbxiSwikLVrdmQ5C
 k58mDcH8S79qAOBfY70yLRiWi4H+WiP1k+EqN11p53sMnhkRSGnG7HVcBuXevd3fagkD2r4Lw
 XRv9rr/3VUoezg1te33vk21Rqap/19H3Mc2FBVuLTQIOKSD2xyzZPAjQ5qksYkU1G3SzAiQ1/
 OkBLoroLMhg3vRprCeK3EiyXCHKv2eJfNdDrljlWM2jdqGAaw9ki1RwgGtLCT8UIdg+/5pEYH
 Rc5CTfpMTF/tdY9u0TodmKqmxE+9YWjEh4O2CauKGESxCOPMK0SVHLBxqzdPcdD9bDuk052VW
 WOFEUYppsKDVTs3EdMByOjZsXDLe5vXRQkpiGeZ66O14tcokguOTosMDvvYw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 2 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 2 Oct 2019, Junio C Hamano wrote:
> >
> >> Alban Gruin <alban.gruin@gmail.com> writes:
> >>
> >> > `total_nr' is the total amount of items, done and toto, that are in=
 a
> >> > todo list.  But unlike `nr', it was not updated when an item was
> >> > appended to the list.
> >>
> >> s/amount/number/, as amount is specifically for something
> >> that cannot be counted.
> >>
> >> Perhaps a stupid language question but what is "toto"?
> >
> > "in toto" is Latin for "in total", if I remember correctly.
>
> And "Toto" can also be "Toyo Toki", one of the two large and well
> known Japanese manufacturers of porcelain things you see in
> bathrooms--oh how appropriate in this project ;-).

You made me laugh out loud! :-)

> > But in this instance, I think it is merely a typo and should have been
> > "todo" instead. That is what the "total_nr" is about: the number of
> > "done" and "todo" items, added together.
>
> If I were writing this, I would probably say "... the total number
> of items, counting both done and todo,..." and with 'counting both'
> I wouldn't have been so puzzled.

I also like it better the way you put it.

Ciao,
Dscho

>
> Thanks.
>
> >
> > Ciao,
> > Dscho
> >
> >>
> >>
> >> > This variable is mostly used by command prompts (ie. git-prompt.sh =
and
> >> > the like).
> >> >
> >> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> >> > ---
> >> >  sequencer.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/sequencer.c b/sequencer.c
> >> > index d648aaf416..575b852a5a 100644
> >> > --- a/sequencer.c
> >> > +++ b/sequencer.c
> >> > @@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo=
_list)
> >> >  static struct todo_item *append_new_todo(struct todo_list *todo_li=
st)
> >> >  {
> >> >  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc)=
;
> >> > +	todo_list->total_nr++;
> >> >  	return todo_list->items + todo_list->nr++;
> >> >  }
> >>
>
