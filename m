Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C748202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 21:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933408AbdKAVgV (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 17:36:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:60119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964794AbdKAVgN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 17:36:13 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7sF-1dOWG30wFj-00oUJW; Wed, 01
 Nov 2017 22:36:04 +0100
Date:   Wed, 1 Nov 2017 22:36:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order
 of the commits
In-Reply-To: <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711012235070.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com> <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1711011316590.6482@virtualbox>
 <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:R1cPka6Zcw0n1H6jTxAhY+4ky6p5ddKQkj/RvHK3S1Y99NZ8eKu
 CNCTKku6Wft0yMuxDLE3Ci9tyW5f3Y8cQHEoBnnuzuAbWo0ZaKxC7IOlihH5eid19fkj9SY
 jtylCARyKyA3DRnuL9F/TCojirweY9hSYHYTPuMkxQ+0Gcmhje1KCzsNPseHsl63HFmg4Qk
 /AfpE38454qawlT9+ZCRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qFwuo1fk1Po=:/0+g/15K5hFQ4lD7goUfG6
 KsVBDzoa67+OgFlpQDOIGjqaaDhV7jV11aG1k8QF+jSJMXSC0UTv4Qxaw1eawPT25gdd001hE
 HVloFRaomwxJlC7FlpRfAd6Ytwirk1WQn6ZU66X2Y/FAmy6Sh412Ue69JO/Zl0k7IE1u5uDLT
 ZQHgjSbg85bKdTjww92rHpk7waLNE/q/2PbmikwHw7WeYGN7ptW1s6FbPTQVGXIoyt0D4YCqI
 RAXDN1LxaqKtfaomI26nkpZ9HDAL2RCn25+0XqdtkEqDgXjYNYa+IvQYxtbaH/Ihd2HoLHCT3
 9S0YwQk4h5569/LWl623tIa+HIWuuY2c3aCZhRwPAsf21+N8zSAShvPCKwnoIi8tsAPmwgTVi
 RUV8F6p1VgPPyhDMSin+3arAf0qZDX/ZExtRvUTsKxZmRd1Zp882wp8VLsW7qGhh5TftVETIR
 LV+FKIwL8jcvOuj4h1skfALvZkhv8LP2MpFjCD67W4w0YJ2JJ7X7X0URx//YzT5aY7IG8ekY2
 DgZKsMEjf42m4SNli5Y0tqoBTIiI+hYGKkEntr0UrzQXai5cudWAd9Xse7t9odIN1NxGb31uK
 DEvC3NdpHdoFB/GHg2GQN64OozxmUqN6tpwxBtXoGKVzMt+4W16nEvF3wHeZmnkF4Pp6v5bmW
 YwvA6sOisBkzyfjaS1366YApqy6xctuFdEy6BJqIvqiZ+qTc41RWGA5pSvW/9drHVn9UjbeF9
 QjDM4HOfu6nlQBS/6sHlNdOoSAEoYFwWOLgmw5ZH7NYJiudKW8PfM6QlowppHta1S/rE+3Kxh
 +GiG5aCJQ38F80Qz/TXx6czGycc/aQ5PV6ieL7Xkyi/aaoM20U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Nov 2017, Junio C Hamano wrote:

> On Wed, Nov 1, 2017 at 9:26 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >         ...
> >         (
> >                 for x in four three
> >                 do
> >                         git rm $x &&
> >                         git commit -m "remote $x" ||
> >                         exit
> >                 done
> >         ) &&
> >         test 0 -eq $? &&
> >         ...
> >
> > Ugly? Yes. Correct? Also yes.
> 
> I think returning non-zero with "return" is how other tests avoid an
> extra level of subshell.
> Ugly? Yes. Correct? Questionable but it seems to work for those who
> wrote them ;-)

Given that the test_expect_* functions evaluate the code, it makes me
wonder whether those `return` statements really return appropriately, or
one call level too low.

Ciao,
Dscho
