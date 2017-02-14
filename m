Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C321FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 14:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbdBNOr0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 09:47:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:59243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752974AbdBNOrY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 09:47:24 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7DVi-1cRCH63IAw-00x0ct; Tue, 14
 Feb 2017 15:47:06 +0100
Date:   Tue, 14 Feb 2017 15:47:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
In-Reply-To: <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702141545380.3496@virtualbox>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de> <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NH/b6bxpz/9KSDMCUSCw7uvEXORpTJxJvvAziR9g/6FJYsIqAL2
 oPCg3QdyAjWjiI2cmb57FTcfMecqXIcShd5b5DM1sSrCWK9aLA+C6j5QndnsnR95zeMz3xF
 0G7jq+IK+1A7HMnJZ95jtceHMLusx+de6GssZbOjHMiPZNFcAigwA/sTxWVIGSLimpE+30r
 W3TNR+ucf+0IIQ6a/UQdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V0Uq3Du8EnE=:72b7mX2hvXpin5HYov4zUb
 t9bVOOJtSaVPVrMQnZZwjqd3CxehU6xZ0mUpP0KaxF+Ja3pXKR2R5+2wUth21KH0YXqiLHObe
 tYD5QQPHL3LSo1/ekOzzrSmfJzicVwa+LMjlRmQCEalJFV6b8KKPVL8c68fgEC7km8dp5ThYs
 lxgP2fHeHEDx6KBomCTX5OC3LJ37UmtyjGwOMKacHqBlTzhUwY4j1Mjk8n+dMEhS0lKR52QW/
 IfD/dmCfVJXwew986AswB6qx/adECa2dK7yDI+UhFGh/jHv375xen06ZmK3t6zJcfhB5Rt8sg
 CX4fhBQkSDtamD8KZ85WbGTULYRuoNmBzi2BXp1Wo3htb9oYSlUA0mNwuEyrkHm0Rbplvl0To
 9mcqglY2891BzqNC4j0miXylIp3aVty6DKQOmM6zMWqERmUZiBy9qzbBMVtCKT9wWGqtEf18X
 4BwFk7wspyMxZsW+rLpIR1VoG35uhOd6hImDWvXMrZvQs/Jfcc5FZsFBVJdUZmNSPjxduPSKp
 AFBkONdV/AIUmbsy1Y7IJO/7l9+8RBbIVL0Fz5fvdO096+EzOckhow5Exe6ZMP4NsUyGdXgJM
 DyyClPObGU4RVQfLYAjsxdq0c4y5SLSSlY4JbyGr4mYluHpz+NX4EJfcfxmKxQFTUzlII6XLY
 gFtfg2pqeB463xI7UpvbOV/+pDduvQszFE0v6yX/nmpHj8gxOcL3XC+GYJ+gRfIJWrCAlgWbt
 /gkURbDE6EgNlhm0p35dg++hAsFlH6zYTrkIXAmw/JruJgvipxUT40i2O7ok/EXOh/XfIDfwC
 64LhQPH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 13 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When removing the hack for isatty(), we actually removed more than just
> > an isatty() hack: we removed the hack where internal data structures of
> > the MSVC runtime are modified in order to redirect stdout/stderr.
> >
> > Instead of using that hack (that does not work with newer versions of
> > the runtime, anyway), we replaced it by reopening the respective file
> > descriptors.
> >
> > What we forgot was to mark stderr as unbuffered again.
> >
> > Reported by Hannes Sixt. Fixed with Jeff Hostetler's assistance.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > Published-As: https://github.com/dscho/git/releases/tag/mingw-unbuffered-stderr-v1
> > Fetch-It-Via: git fetch https://github.com/dscho/git mingw-unbuffered-stderr-v1
> 
> OK.  Should this go directly to 'master', as the isatty thing is
> already in?

From my point of view, it is not crucial. The next Git for Windows version
will have it, of course, and Hannes is always running with his set of
patches, he can easily cherry-pick this one, too.

Ciao,
Johannes

P.S.: Could you please cut the remainder of the mail that you are not
responding to? Thanks.
