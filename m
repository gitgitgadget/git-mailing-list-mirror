Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469BA211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 12:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeK3XmE (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 18:42:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:33013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeK3XmD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 18:42:03 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHoC5-1gVieK3Ylx-003dA7; Fri, 30
 Nov 2018 13:32:49 +0100
Date:   Fri, 30 Nov 2018 13:32:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: do not let its diff-options affect
 --range-diff (was Re: [PATCH 2/2] format-patch: allow for independent diff
 & range-diff options)
In-Reply-To: <xmqq36rjkkn7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811301331320.41@tvgsbejvaqbjf.bet>
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com> <20181128201852.9782-3-avarab@gmail.com> <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet> <8736rkyy4h.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet>
 <871s74yms3.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet> <87tvjzyiph.fsf@evledraar.gmail.com> <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com> <xmqqwoovkx5s.fsf_-_@gitster-ct.c.googlers.com>
 <xmqq36rjkkn7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4nf2ZTn+dxqpTIseIAKqOUGVWH3zm0uXAbJy7a8CVRLwRnjqW8S
 hYnoVdbI0qrU6BTdOG08Z7AfvJv0eZpWLQt1wKTrO4xCFSRAl/3TXBuB1S+P7qIxcCLRP4b
 fdwsAahmUAaw5puXx8t0aPmNo4eljQq3/wh2OD1+BCdnNo69BVHK6zpVqzDKZFmaGIbY0WL
 8ri74/TY0XoHsWguxlZ4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PoibfqTICc0=:1iKzTdiSWawCoQCyRJoHOb
 5cAGCHXBOP1okqwvxrIvlpN4mSfig29CguVl23b20WTJJZzBtPACkaSss/kKLSca3aBnPRQ7t
 a/BFrQfcwGlq8gzVj8ClJpHZMY41fG7vePkcSuaMcfEwcyGe7WrsQTWP2kYxeHSX7++KijHdh
 qYI5my/M/C1J/Sfnx5tx62jdZqrtZMiJw0/0nkjH9TtHmBAKsYYS7IVFatd3MSAsjhddbOO16
 t5tGwhPc+8N6aEHnDGzpvSIYotbCT6dqJWXbrMFnHkoJbRTaf6muu8+VCW7+JsDtHExGi1HoI
 wv7QD/HUAClnIlgpr7TByFa7m2or8KuRI0XsXkVBRgWom40D0bpAzcIVM4jCnOU02dIvmAfRQ
 GQMzdyd3rDnCizsbCoHtq/BWNVAwromarZCUujRlt5dyEv10VVPbLGzzmwQt5bhHzxwcGrCU1
 LusSAd+bD8Q9of2t6c5UC3kmXBjkgxOG3PJZISWX+ZTjfOkNdAh5UsD3Al6PG7C4yDE8ROewE
 5TXUReqdnQzN29fQSVUspvfsZfTrxnNbXzyBjhc/VJ3w+ZeOSdQgNKKt27+QsjHEppRmBZNbj
 j6MhOoMmikx2+Djgxt9ygqLBbMPO1WkEoBWCWsw2Yl+G39j+6q1AbZ6XDe4rAnD5CJDr5wN8q
 ROwIUNgRL/u/zxfuuMCxTdn3jvy7NF7UyDYtJH4hbetZd9/WNMlHWRYXZ5dRQQFtTtpb/6ph+
 VwqXp94pn7fMvKQI2XdWNvrkc84OuFiyNHVL8D7PHpimeGYEl99j3M7t55cHu9KW7bdTdM3Yy
 XlcHINboTyTqy1spNYxsA5RPXCqEf3+RuMgtonT3ySP2uXK7MyAqrs1sqeo+IKtcGuS6X6Z/n
 hwJRdJkfTsSzTs0QjxWHW2vvZ4dMFMcbMo0uH4ubXiFXQrZTeo1JzmWO+it8Die4H3VknTGfs
 p3QygKFrZaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 30 Nov 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> I had to delay -rc2 to see these last minute tweaks come to some
> >> reasonable place to stop at, and I do not think we want to delay the
> >> final any longer or destablizing it further by piling last minute
> >> undercooked changes on top.
> >
> > So how about doing this on top of 'master' instead?  As this leaks
> > *no* information wrt how range-diff machinery should behave from the
> > format-patch side by not passing any diffopt, as long as the new
> > code I added to show_range_diff() comes up with a reasonable default
> > diffopts (for which I really would appreciate extra sets of eyes to
> > make sure), this change by definition cannot be wrong (famous last
> > words).
> 
> As listed in today's "What's cooking" report, I've merged this to
> 'next' in today's pushout and planning to have it in the -rc2.  I am
> not married to this exact implementation, and I'd welcome to have an
> even simpler and less disruptive solution if exists, but I am hoping
> that this is a good-enough interim measure for the upcoming release,
> until we decide what to do with the customizability of range-diff
> driven by format-patch.
> 
> In addition to this, I am planning the "rebase --stat" and "reflog
> that does not say 'rebase -i' but 'rebase'" fixes merged to 'master'
> before cutting -rc2.

Thank you for integrating them. That way, we have an -rc2 with no issues
in the built-in rebase/rebase -i that we know of.

Ciao,
Dscho
