Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9D41F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDTVBB (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:01:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:38289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752047AbeDTVBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:01:00 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzoSt-1eN2wx3r0t-0151lj; Fri, 20
 Apr 2018 23:00:53 +0200
Date:   Fri, 20 Apr 2018 23:00:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Isaac Chou <Isaac.Chou@microfocus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fast-export: fix regression skipping some
 merge-commits
In-Reply-To: <CAN0heSreFmd_0QnTjgYdpOZ8y7iNc3J+dYcpo5oKJBF2ff5-jQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <MW2PR18MB228432C95C18DE786957DE70E5B40@MW2PR18MB2284.namprd18.prod.outlook.com> <20180420181248.2015922-1-martin.agren@gmail.com> <nycvar.QRO.7.76.6.1804202041400.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAN0heSreFmd_0QnTjgYdpOZ8y7iNc3J+dYcpo5oKJBF2ff5-jQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1877655014-1524258052=:4241"
X-Provags-ID: V03:K1:alGQJ4lx7PwWv6o3okDr2VgL6I5j7Nk9/4dN/e4XmoO849Oz70k
 Dx28HZd0zx3OHE8Jig7QxDnbIoVfr+KvEICCvtUMyWAMhErXIYZc51MZBFciH5Bgs1v2z+k
 5kkgN+NaOloi9mEn09NwKK3t2C0wLjtO0Hv9axTmTIW8wYQ7EJo7PeXIL6WsCI26+f921RV
 1sx0HEDNMGO2WMiFAfO+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JeDko5NiESE=:bkvlaP72ntdzLN4ATJT8Hi
 GOAth38fSRwrMgMaXCHI8avfJhgThz1sbtq9nOuqCKIt0LaEtLpHdgyu8tkCIiYz4FK68zIss
 Gqoa6DwTu2A58y3XcvxnQqH6bjG0ER/CihErtPDeyAD7gYSVygQajjepOh4V0BwkRr/uo3j4a
 LQgu0Dulr8QJX0/Bq8iOLmiAEXO9J5JiFbcUnA+wX8BLKvCOT5CWA2RB30aHbD6IAVst/TAeL
 3t3UaFjsfqi0OoJy0VzcJ+14SZgTamaO3o/Jo6qr7RJyvm7aC2GR66gjuH5Bg7dbnW32uR/0h
 BSBY5haHSVHglVtUTyXdDRncesHmsNVSJ7AAVkseNxEieOhBK5bPT0RBwAp1vkeQIzcDUiNV2
 tFt6xWE01XH2ptgoW4Ri5pj4I6FIa3hQ5Z0ouzuZlcFdv4ObG7Bb+8AhBzGx6ZEvc68EiDMT9
 vlBkH+9Xf9Z9XPhj/XTXNmj+2yElmk+stL3/0CGt2uNmeIx6pmZElltfAw/BT70DTP4vnloyy
 bIT78qtvKnFXvgYGKs0JBgPA5Dd0Od4GC25wfxh40BcEstsW6HBPKpxzvfMSkL0OMW1j6/lIB
 ROzG2Kcz85goYdBKhpKMrduP/WB8+Vrs4s8fzfS010BES/WdjHuMFX7ZespsEN50RmlpxQ7MR
 vL1P4HAZq6twp1p3XWjc1PZ5CvJSfp2vKDfQi5dOJXygesCo0JnihL3q5rVgQrjsDuGJThJFV
 BYqzYj1mJ2FiacdTYiJpcX4Zr+KshZBbrCCMtMOFoCgcZ64yaVe4B2Ap66H0GIuciwe050OKB
 M+NPg0n9jlk/APcU4HsPNqIuD8gYiGIk2LTyTxl/LiOk5TaHNk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1877655014-1524258052=:4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Martin,

On Fri, 20 Apr 2018, Martin =C3=85gren wrote:

> Thanks a lot for your comments. I will give this some testing, check
> that your proposed test fails and succeeds as it should, and so on, then
> try to wrap this up.

Thank you so much!

> Between you cleaning up the test and providing a different
> implementation, there's not much left for me to take credit for. Can I
> forge your From: and Signed-off-by: on this?

I disagree, all I did was to play a variation of your tune. You are the
composer of this patch, you performed all the hard work (analysis,
implementation & testing), and you deserve the credit.

It would please my ego a bit, of course, if you could add a "Helped-by:
Dscho" line... ;-)

Ciao,
Dscho
--8323329-1877655014-1524258052=:4241--
