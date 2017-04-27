Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1147207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 12:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032784AbdD0Mng (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 08:43:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:51236 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031968AbdD0MnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 08:43:25 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7pDs-1dyjEi3tGi-00vS6F; Thu, 27
 Apr 2017 14:43:17 +0200
Date:   Thu, 27 Apr 2017 14:43:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Steve Hicks <sdh@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: reread the todo list if `exec` touched it
In-Reply-To: <CAABDHWZdsbP_NYW36nXc7WwjZf53PeEQrfaCUQrDpU4Zd9R2ew@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704271438290.3480@virtualbox>
References: <ffb8b1ddb7a8a22643d569565e1a4929b883fba5.1493234134.git.johannes.schindelin@gmx.de> <CAABDHWZdsbP_NYW36nXc7WwjZf53PeEQrfaCUQrDpU4Zd9R2ew@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GHrkQUXdXQWjxj1EeYwtxJl6QXMYX3v1ajPj1IOKcBcICcSqI1r
 d+xih5DsPeSZl5lstxdB1d8KfSZr+NMyHGNVZMG5XiTwH8MnJShPSgQ5SpC9YJYlmvn2W2V
 upJXztzs1+Z7ebSlH225ZAEJsICyn2G+xZL1mLzYHw5NaEf/OytTVHwBsa7mOi20ckzQ5Rw
 nNxtqpGhHiLdD6BnGrs8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ANuF4gfNrH4=:D19mgPHOkduDssZLh3M255
 6HkdfWxOuXz4SPD8f92Ye0ZJT/caVTj/wGX0e5sCbnX6VuDVyYwkeZDigx3BSjR+MmGCNfblo
 yA9eoRbEMSdCZRXQqbie8WBvtEhhwsjA6OUxLLbV92OOPVEQKyQBOWM1vUaTo9AZFl43a9F4T
 ghrqCfaOI/qQFbG1cMZPkp8fC5asWbPCz/6MJpYPaVFYa/yAO5MLZFKuYl/Q215i3uhgqRmnM
 iv20bfQyvAawWF4BrM6BlNRr7SU1pJGTCBMcxAerzxz6OxsZWceYCgTPNLX/ZkOETW6Eufttp
 J1077l4mV4Eo9BIFFRx5wDr55xQpWJcAX0neJhfo0zMsg9t29erHEKgFqbBkwRKP+mmKEDcBB
 XB2elGTZ0YgJjXlDn6A12wKio2ACgjITQIjdat/Vnz5tKh1OBHsSy8ApjPGIhVOlv9mjPaVjy
 i91z/qV8n/OmvaLnoW/w/HnsIlnn5mHvOEYttrEMI+x670y+9VgFh34zrZmHqFikHuDAtrrns
 Yee35cyQUSYZ7DN22qPjttfmmSvEVchns9VLEwdZFIH3VF0DEbSNkg1LjFK01+t5ZmX6azpo6
 h6lDVT6y5szsu2RINy8P62e9tWL9xOIVaYTslbRoIQqzdszuuzz6n9D1dy9kW91HP7nRQMwRv
 /0tzNx29xn1YhYkGndS1DDJImxCPcp6ZECk5ngrFTsatWxFbAOlW9H6DdtocSyRvveoMfDgJW
 cXu0/oM3RzGodFNZfqxXumUi4vxB42OGWXZI7rYnzFdkfemiR0OIhrscQrkBzvG/pCmcqTlqP
 2NMWGIx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steve,

On Wed, 26 Apr 2017, Steve Hicks wrote:

> On Wed, Apr 26, 2017 at 12:17 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > From: Stephen Hicks <sdh@google.com>
> >
> > In the scripted version of the interactive rebase, there was no
> > internal representation of the todo list; it was re-read before every
> > command.  That allowed the hack that an `exec` command could append
> > (or even completely rewrite) the todo list.
> >
> > This hack was broken by the partial conversion of the interactive
> > rebase to C, and this patch reinstates it.
> >
> > We also add a small test to verify that this fix does not regress in
> > the future.
> 
> For context on this "hack", I have a script [1] that allows passing
> multiple branches at once (or all branches beneath a given root).  It
> rewrites the todo file with some extra operations, like "branch",
> "push", and "pop", allows editing the modified todo, and then rewrites
> back to exec's.

For what it's worth, I used a slightly different approach in the Git
garden shears [*1*] (essentially, `git rebase -i -p` Done Right): I
override the GIT_SEQUENCE_EDITOR to call the script in a specific mode
that rewrites the todo and then launches the editor as per `git var
GIT_EDITOR`.

Ciao,
Johannes

Footnote *1*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh
