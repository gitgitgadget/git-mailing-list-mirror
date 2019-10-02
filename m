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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACCD1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 08:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfJBIGa (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 04:06:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:37549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJBIGa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 04:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570003579;
        bh=4r4JTvHH3bJeskrfzo32i+YhZ/ddaZIO6c7vSrqP9Vo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dTW4I5rkgA9Fa6qHh2PcrEmkHCqMLtWOSMjp7f1e2ulfEIf4juUi0XFOkbnWQa6Jz
         96uyG/ywD3YwpzK6j+UG5EXrlNEVlX9ps6eFUn3BSSA0zOeBSz7Y/gTHAghWsNNFpG
         yvAdeI5VR6t9raDt4s2VZ45nFT/pn+VkY0Xj3eSo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1iWHgk078v-00IzlH; Wed, 02
 Oct 2019 10:06:19 +0200
Date:   Wed, 2 Oct 2019 10:06:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 1/5] sequencer: update `total_nr' when adding an item
 to a todo list
In-Reply-To: <xmqqbluzhp8g.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910021005050.46@tvgsbejvaqbjf.bet>
References: <20190925201315.19722-1-alban.gruin@gmail.com> <20190925201315.19722-2-alban.gruin@gmail.com> <xmqqbluzhp8g.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RxupK0lrd+Cw4jWPSrYdRJ+ByNnaDFmhH8uY/sbiL86tVsqAhf4
 AVP5EN9/CEwxSIswpDrayvaqveZWpoOjZuM7i2jHHvymd78m5BaH52zITEYgrbtCjNOJups
 OF8mFrA4vpP3kDdUJk3dfbfxaGMq4gt1rAydtg/QFNVZO2KjQuBinLMhtjfmepu9qEqjGM2
 oUQNIYp/lEQaXx1UasNag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GdwGPb9j+YE=:6ZPVOZ/H8B6WG0WynnA6K5
 aD/2E473dzA73t7oDmPzOLOtPJLdoMgMD3nleWlYyW5QlvlbofnMA4/E29CQFm99Cftghv55M
 hRxC6yd7EG+bPgUXsY1I6q7Kysx+N357Awj1x9qPweexCnjxUwXj14hlWR8BklxuvKygGk48y
 1AHv5sZRqAnU9OIVLrkzWbg5iNXWuRJ7bgUTRJPQMOfz2gDJaBavLVdgzqHsFvMXUivgstEUQ
 ssGg8SqrffMkKvofi+a99ICAtaCZ6LPdFHBF0wJH8u6+6yksmzNIH614naCrQ7JbWC6Q7ALLu
 xxFzTWNfLXVxKMVThVKbzz0BjcPz8KK9dI9WKatn2BtdWdWFg23IMDFtPIBl7sVv0pIW0mQhC
 wu3PEuoPu08ZrWPwRW5PrIH5Lt8nqsB80q9uZ6ijVvs3CUZPRPAfBOwnlXE16Ukl4psYUf0vR
 Tbj2Rln66jRnLbcjlWt0YhbrhB/nefAMblnJXAtbri5fQB1MXwJkXNpTB+Z9xuA58tuELpPuS
 ZpaoVpfjajqZfz+mdYH/+iueUornH+h+/yXdWvXTqxpaN/eExuUffWmdX10QXsun6js0Bc9Tx
 sp2xiZ3Me7/EZo5uk61c3WUdrwaZt4mypQtwNlyHUt3E5J112SvZ7XFEtC1U+JUwOlz+jbGou
 JejU2x2PZNgw57RfK4GDDqFCD1Ah7rByHdtSnHwalugY7N3MMMW004oye7b/0P3t+EgoxDdco
 IyIqZNFJN0fDIgis2MKwKPvJsbfKhmKIAv7gTdzI4Bz8CBH77XnyKdcaMt1ePqSMUE/ktbRyI
 Tiyid/RJtRWdnc34zCcb5pawH7mlGTGFPU8ka7aJUN5bLzL+bIf4vhw19ErUtoLOr0dZeXaUQ
 te+At7+gt03YYyXyfQw8KjxMR4ifXgad/4n1t4hjqtnt/QoQsau9F+wPkPEfB2EEtmeUKr+BK
 7KNKFt//NlprpU5ak0TWNCy0qUYt4CRj9qlkvBpxT38SLbqANJNO20y/QatL/PcOAOon/9KIH
 lrzpOaysHD99pnW0GVeI9s8wcQPMiolKdvZZQYFvUtsiXp0c19A7v1TcLFoWbGmH52opi9CS/
 EV8zxbnsfDHtBkCe7mdGRTpNmPJyT+KRgEFV5UzbfpGJ/QL5MFrsLMTszZ3eTPhYre1gteVJG
 CBbcu77eTTRLPL6PlNN0wGg2Ozl+l//1fIDEGMkEtqKLaqk6NxW/J3JqtPUQZPhT9jIwp/kav
 lxYE+Vz6MP/1PJ1SVokpObZIpRZDEgvJBB1CbiXAz4sFuXtkZJnDomF9zW5M=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 2 Oct 2019, Junio C Hamano wrote:

> Alban Gruin <alban.gruin@gmail.com> writes:
>
> > `total_nr' is the total amount of items, done and toto, that are in a
> > todo list.  But unlike `nr', it was not updated when an item was
> > appended to the list.
>
> s/amount/number/, as amount is specifically for something
> that cannot be counted.
>
> Perhaps a stupid language question but what is "toto"?

"in toto" is Latin for "in total", if I remember correctly.

But in this instance, I think it is merely a typo and should have been
"todo" instead. That is what the "total_nr" is about: the number of
"done" and "todo" items, added together.

Ciao,
Dscho

>
>
> > This variable is mostly used by command prompts (ie. git-prompt.sh and
> > the like).
> >
> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> >  sequencer.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index d648aaf416..575b852a5a 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_li=
st)
> >  static struct todo_item *append_new_todo(struct todo_list *todo_list)
> >  {
> >  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
> > +	todo_list->total_nr++;
> >  	return todo_list->items + todo_list->nr++;
> >  }
>
