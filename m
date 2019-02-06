Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A0C1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 11:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBFLlj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 06:41:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:47005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfBFLlj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 06:41:39 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSx9-1gosTI2pUB-0035s9; Wed, 06
 Feb 2019 12:41:31 +0100
Date:   Wed, 6 Feb 2019 12:41:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
In-Reply-To: <xmqqzhraru5x.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902061234250.41@tvgsbejvaqbjf.bet>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org> <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet> <xmqqzhraru5x.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YNapI5dZ95fMT7PCTpr9vO/+wBDFmnDpdrKgeouJkv3qipyxOIj
 Q/cSTEIFHOZTj1FrZ3ut40z4/h8hpGaiBOlhzkB1fqmlVeYLFJeHY/sLjo4Fa+ApRtiWRcC
 JSUP6BcGvnhEXzsFpkdtcONBFvaVayx6yOYjNMax+webMPAm/XQj9dFTaVTsNLmRNSWMemJ
 PiggNfXTKt57XKtA6cS5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NzUM2ubuTEc=:unKuECzuXQiHlAPID+BC6s
 Zkhq6yeVJ7MEtgPMBQR2G6W8dy5FSs91mGc69T0VmHKBWwtBk/PRDxS7ncgiVqGOcyiKwagZE
 pGuAwGq4kS/6zvPuDWc9XByPmeAI+5eVgca3HSi1BIbdqjUIs6/yQFNSmO4Lfczigv6J11mUo
 ztNP5iNzOjB+jN/swK3yK7XvcjqniXr1CJ/avpxGdU2txss5PS/fXpzlUCzCCAVMWg4fQM+Bn
 FcVIH4Uz10M3AgFKZpY/Iskr3Hw4pqwJivgjDc5MYzc1XoCgtLUlbHmh5AUN1SbrjCpPalyQu
 +C87ermgzJ0Y+IilTuEh0+Ng8+i7/1Atro7u8zAdUPTAOZRD4ZIfawP0Z2P58tLOtmaMEUyxh
 /kV4p5PstN4njNoj2w2WoZuLwIOannqSmGEDPG/hV7L27z6Q78KEbF52mlwWnWrdDfV/5zTYX
 9mc1vlSH7Ycv6s9lKYIqheZMUZhxDB9RuwOzEMyH8DHZ0TJPRqzd7Y4A+R6bqtHBd75FFqAvV
 Qp30oL9ZtpzOdLb89ZH0vCknUhYpxIwIfVuDRAvIUVyRUDzyu/rl+WW+Yi0ebfvOzke2cL8+x
 vxLRqOtLLIx8UCDK9JVktwmMhT7XFX/bSnoAsETNk5Z8NzUp2Mo53kYJnMImvULd2CbP6u3t7
 HwuJW74f3nTqVgZu5aUBRlplvv7MtRtkEeOmEWskwLAC2/UL3klnr9T58xL5FH1XTEWDgWIVq
 rGVyEbzQ9N6cVgOmoJVfM8/BJhnXfYvOLwjRJAfK+Ttbi6nrT7lv7kCQ7lCqBqk9B3ivAcTR2
 bdRF4uSKGJcw1OyOCB5gLOHPA0pvnw7jX0ooEnp4ZdSLEVf8E47XzM5NZQoJFlV8Owp1QVO4L
 /mfhXV20qu7ncLi/U69lFbrr5Azq/itd8lt+3rUkpHXyt/Jt4awKrCEBGdn2etmEeCIMGG2LC
 jQSKZ6VMcyw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 5 Feb 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Thanks for finding it.  This needs to be squashed into bfc3fe33
> >> ("strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`",
> >> 2018-12-20)?
> >
> > Since you want to open that can of worms again, you will also want to
> > squash ed5d77f7d382 (stash: fix segmentation fault when files were
> > added with intent, 2019-01-18) into 1f5a011d90ec (stash: convert
> > create to builtin, 2018-12-20). It will have trivial merge conflicts,
> > and the addition of the regression test will be surprising without
> > modifying the commit message to explain that there was a regression
> > that was fixed very late in the development, and that that regression
> > test intends to guarantee that it won't need to be fixed again.
> 
> Are you saying that I should not merge the series as is but expect
> an update that does these squashing?

No, I thought I had made my wish clear in the past: to advance
ps/stash-in-c to `next` a long time ago, mainly because it became obvious
that Paul is too occupied with University things to really pay attention
to the discussions on the Git mailing list. Consequently, we cannot really
do the regular thing where the branch is cooked in `pu` because the main
contributor is not really able to spend the time cooking. So to me, it
sounded like the safest way forward (without losing the entire
ps/stash-in-c branch) would be to merge it into `next`, with known fixes
on top, and cook it from there, with more cooks involved (which I heard
some people believe is not a wise thing to do, but then, we do that in Git
all the time).

So what I tried to say is that I am a bit opposed to start squashing into
Paul's patches, and rather do things on top as the --intent-to-add fixup
that I already provided. You seemed to suggest completely otherwise, which
got me puzzled.

> I was planning to make this a merge-down day, but let me exclude this
> topic from the "for next" batch just in case for today.

Well, you're the boss of git.git. I find it sad though, personally, that
we could not move this forward, especially since we introduced the safety
hatch for the very purpose of moving this forward, all the way into the
upcoming release.

I would have wished that ps/stash-in-c went into `next` already, what with
the few corner case bug fixes we had recently.

Ciao,
Dscho
