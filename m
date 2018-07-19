Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E141F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbeGSScu (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 14:32:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:35475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732150AbeGSScu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 14:32:50 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhGw-1foUlO1ZRm-00H63f; Thu, 19
 Jul 2018 19:48:28 +0200
Date:   Thu, 19 Jul 2018 19:48:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] repack -ad: fix after `fetch --prune` in a shallow
 repository
In-Reply-To: <20180717192002.GB30594@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807191946090.71@tvgsbejvaqbjf.bet>
References: <pull.9.git.gitgitgadget@gmail.com> <pull.9.v2.git.gitgitgadget@gmail.com> <20180717191531.GA30594@sigill.intra.peff.net> <20180717192002.GB30594@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F26/oS0/HyKwhmGamz9KHHUf36ifkznuRvCglibAAuMKYYTFnOt
 FOFMj4/Pd+YXOD2y1GiqifR4bnRoamiWljhYMQgxvaXJyLc/oWpZuM95juyUHZmPRNCj64T
 u2853wKEgJrKb+4ZjTSLL83ivgQiAUoRAgxVt4LiCTquUlYetoirxUuJctHrEdgRELQTe1k
 ZxHoo4gZYmx6wIxKgZr3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T8YOgOwZV5A=:bvGaqj6rZOpfbJBU4d5gOn
 fKhTyt2EfNig4t5lQuu/QedcUTU+KcI+1IcrrRy/3rqnG5vGbWEiSJcJYr8e78bFLpJBLWGLm
 nRvOxaCTTrRkWX6biINU4BvT6YXa6DZ1xrjjS9SBvKDwSMKNp5WAt7rKEScq/29RY9lS2H6u7
 o8Wy2QURHkkNffJmKnwTx4TSsKfwKWXfgWPBpBe3xWC5hP2cAPpzlL83mYmNVFsitY5TwZgmP
 fSpZaIuNSH6HARpgZ+aqjbZxPvfNGfKkMNW4q5vX0v/1HMHQ9PXDuq6NRsjR1Xpwolo9iRhOV
 R/WgwoidqpNciKW++dfMcNHJqmN7y5YpE+TTex+B/GlGKAuM3tkZV56wTBloUHhYlsposAWEY
 4C9fhR+v1UEg9z6jSn9LIwQTmz+6lBd6IJvDsxYTAJaCPww8207/+Cml6bDvOmiY+w/dKFywZ
 /lefKc0S9Dbbgsc+4ehlHlXYabOuWdcwAkUoYSe1TZxH0JNkNY3ankmSrM5GQshYghLVqcgBS
 vy3abw1o5FNdR8E54hSfOsMNzJNfySjQSAB17yJlwff5hw+ZNtZjQpmW4+rgb+NBH0D5lhndf
 zOdMKs3MWj/Fw0pVG4YzHajAlC1mDXp+sLcxSMjD+U40QMphl6fEA+PlFVmFBZbtzFMpQIMcw
 OattlKy++BEBO6aeRQmRPMGGGJp8/7wUhGdK3jYxtQhwLB2kxd8xDPNfoy/hMe1Kbvn0MtOUc
 ff8WNbljh53VcIq+gqH+0uXVmBmCD2PO7IodzwMBy2NdGEgxaUVm/Ei8zX+74G1RqSQHLdJOn
 6Vp8umT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 17 Jul 2018, Jeff King wrote:

> On Tue, Jul 17, 2018 at 03:15:31PM -0400, Jeff King wrote:
> 
> > > - Also trigger `prune_shallow()` when `--unpack-unreachable=<approxidate>` was passed to `git repack`.
> > > - No need to trigger `prune_shallow()` when `git repack` was called with `-k`.
> > 
> > I think you might have missed the bigger problem I pointed at, as it was
> > buried deep within my later reply. Try applying this patch on top, which
> > tests the opposite case (reachable shallow commits are retained):
> 
> By the way, I notice that the patches themselves are cc'd to you, but
> the cover letter isn't. So my reply went only to gitgitgadget, which
> (AFAIK) has not yet learned to work as a mail-to-comment gateway.
> 
> So I'm copying this to you directly to make sure you see it, but also
> because I'm not sure if the gitgitgadget cc behavior is intentional or
> not.

It is one of the existing TODOs to Cc: the person who hit "/submit". So I
am aware of it, and it is recorded in the TODO.md file.

But as the GitHub user might not be associated with a public email, this
will need an internal map that will be extended to whoever is in the list
of allowed users.

Ciao,
Dscho
