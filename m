Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54A11FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdBMWis (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:38:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:62642 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbdBMWir (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:38:47 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsCdj-1cGD7E1M6h-013ygT; Mon, 13
 Feb 2017 23:38:19 +0100
Date:   Mon, 13 Feb 2017 23:38:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
In-Reply-To: <b530c820-9956-4396-d853-c7d70ccaf11d@kdbg.org>
Message-ID: <alpine.DEB.2.20.1702132337470.3496@virtualbox>
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de> <20170210050237.gajicliueuvk6s5d@sigill.intra.peff.net> <alpine.DEB.2.20.1702101647340.3496@virtualbox> <20170210160458.pcp7mupdz24m6cms@sigill.intra.peff.net>
 <9913e513-553e-eba6-e81a-9c21030dd767@kdbg.org> <xmqq60kdev2r.fsf@gitster.mtv.corp.google.com> <b530c820-9956-4396-d853-c7d70ccaf11d@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IYgmg0tpopwwIRX5c8St8epjml0Wz5oPn/6O4MzirdQJzFKhwfs
 CH0/3fHd6ntdnzahNYjU6INxWjPQJye2aCSgLGw0JQpSrJgAcFjIEox8jsZrw75sf3FDv11
 BxaRBcuaMuy43VCZFUmv7/0/UxH9SPeyuvJgJOTSNUkp4Pdv6N8jhiaH6/gpEhv6RlFMIyd
 enHJqFeufjfwh9+7fGneA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IjatyRqTvIU=:ebs1FBM1i3OxNUsbraDNbE
 vBz6cejMO9wokBzuqiPgDsPnAr8ckiFwFlryKbWzwOTVfWtGHSCIvRk3CrOoJXzlv501GcGI2
 lV7GPrkiik7P/XIpQ7FnQI6drP5mDbMpumff5qSpeHlkCzaXGE2oq0CnX716pnH1EXN/w1Hy7
 yNAlYkM7Qw8ONT4WR4cz24bhnaXMkJigIKUGS+SHkz14hZ3pnY8ivip8D5VKxfMAvzCEWbdtz
 MvHW4I/l+tX8rub1Ai3VyygTgYcgx1+Y/nrUFYz0f8DgdOcE6dr5b6Bn+aieW07OeaYzGiITW
 YZgbw+xhAiKnBFDwmg0wKWqcGM16MX/bW6CN9O/AtuwGa6Ocx5imaaoaSebqxg31FwdHySxFx
 nPWevkm/H0lBnWSZdVosihd+w9HVJBNnY4GMN1vTNOg3Wm2YRk0T1QlRbPUsngGL5mMbjj2xZ
 oE4OsDRAaT7YU3FWSJ34Nle5CSbc5ppDtviKbgNNLVmJvvf+CxCZsaf67K2OH5qqrnMPS3sEZ
 DoTkzuvZjXmLaopVLNqnu1fyX3X4bikXzhcsrsE67ffLJ0Ug0BSoDnyUZZ0yCFDDr5yOgRxR/
 uc90+C/T7nIcOBax/MiJhYBDsLjAYgirZkurzMckxybvVWHmbrR4zlIwS+4WD17D7GhQs0wIl
 WRUw/72f5Qqz/5WLHjzoLpvofk3iciEjFrj+EPWP4mf4G6N9/2zxg5Y6VbUUt+9ScO2So+M5z
 bHrlGsmROHhNFFT/5e2rxK0TpAMf1HhnZmFwIxC8TT+6lThuSzOOHWdE9dW18AjUS5y9crwpT
 xSf/uDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 13 Feb 2017, Johannes Sixt wrote:

> Am 13.02.2017 um 20:42 schrieb Junio C Hamano:
> > I have been operating under the assumption that everybody on Windows
> > who builds Git works off of Dscho's Git for Windows tree, and patches
> > that are specific to Windows from Dscho's are sent to me via the list
> > only after they have been in Git for Windows and proven to help
> > Windows users in the wild.
> >
> > The consequence of these two assumptions is that I would feel safe to
> > treat Windows specific changes that do not touch generic part of the
> > codebase from Dscho just like updates from any other subsystem
> > maintainers (any git-svn thing from Eric, any gitk thing from Paul,
> > any p4 thing Luke and Lars are both happy with, etc.).
> >
> > You seem to be saying that the first of the two assumptions does not
> > hold.  Should I change my expectations while queuing Windows specific
> > patches from Dscho?
> 
> Your first assumption is incorrect as far as I am concerned. I build
> from your tree plus some topics. During -rc period, I build off of
> master; after a release, I build off of next. I merge some of the topics
> that you carry in pu when I find them interesting or when I suspect them
> to regress on Windows.  Then I carry around a few additional patches
> that the public has never seen, and these days I also merge Dscho's
> rebase-i topic.

In addition, you build from a custom MINGW/MSys1 setup, correct?

Ciao,
Johannes
