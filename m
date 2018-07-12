Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B8C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 13:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeGLNVK (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:21:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:38911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeGLNVK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:21:10 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5dMm-1g1rP43K2a-00xaR8; Thu, 12
 Jul 2018 15:11:34 +0200
Date:   Thu, 12 Jul 2018 15:11:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] rebase --rebase-merges: add support for octopus
 merges
In-Reply-To: <xmqqfu0p1luz.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807121509550.75@tvgsbejvaqbjf.bet>
References: <pull.8.git.gitgitgadget@gmail.com> <03d0907ec61f0ea53b59659c84b8a6662e9e7607.1531312689.git.gitgitgadget@gmail.com> <CAPig+cS1KQseynMCGC_6FZwzB0waJX8+C7CVKNqACzOhjB4uSg@mail.gmail.com> <xmqqfu0p1luz.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I1XRqnvvJFuLSKS7RXmBKVGrmUDtN1AEumRH/3TVyI6Bt79f2Z5
 IB8Y+XbZBRtf9cVxlEg2QEGBE4dow8ESmL7ks4mZR1aK0CeJRU7H8Q2SRM3J6iQW7Ok71Le
 APSixbP3Z5dGe57lvoXCBmqVlC21wVvzg29l8S35BfGIrIotIFz7XvJGy8VYPegEg7fhlio
 fWuiCTkVmgN3pias3FupQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tzmrJoEpI2A=:8TVRHtjyoEMmGTENnIJrkg
 t83e6hb4i1968JAc6E5/+8VJXLC8jcYuRa0/12CxWL3NlJnGnrZXvykgZ/4lgmOK/NJLaJDKj
 yLQlNDcmJ0N8k4hoUdrKSXjX/fOM5qrolh+vt4QEr9nlQCO9LLw1BsSDeRmZzi+1179hPMnbV
 bFnK9I/4R4S9/eXcZOJyFS51VpXwBHObXuiRL28GaMwp74BZCD5lG3S6KaTbOytQ2J4F1m68j
 htwEX4zGuRfBxaTebHvHCFf33ZM599fQy2YASeRumb+SVvJAcvwc/ioujCAXAJNmqIaj23heH
 we4mmms0SNZM09KU8dKDE8R+jyGGTQSBlhrreqNW8Z7kLzWxjRlPt3WTbs0kIPuFEN8t9kel/
 EtV6vtV4yaYYDMluyLxh5z1mWiiTb+foQfayaCmlqavgymckI8a+PeZAmqHZe0dOLJNd9orWt
 cqMAN1RHQV27BGbGzthQCJBpcs8R2kTgX5XBJ7lu996EW+/sqEU9k71g8Y34Hd3Djlq+/qj7c
 hJ7JAsJzliPJjdLs2aLiukMjFGm7IZUcVlCnJ25YYe3FaWL9KrYFi4Vi+aEHUYuoQUknqVd1W
 izAHvl/tm/eUuaQOKxLNW2MYLoEcPsSDOQ1rztOwyVgwpocezmgdAw7sRvOy7TyN8+n52uOPM
 jfn/bz70S7UGOQ4qCrJGCgjJ96tvAIgqT572ECgYT45tlIB8Qt6L9dDWDsvvcU3ZbOwk1P5FE
 cN+ky2DJUJr5r7VzQUwRelocGg0+1yrzPZrNWN9BcSBym1fHuDtk127PTTuQ8v7l+RwnDbHtM
 KoPYr70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Jul 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> @@ -2956,28 +2991,76 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
> >> +               cmd.git_cmd = 1;
> >> +               argv_array_push(&cmd.args, "merge");
> >> +               argv_array_push(&cmd.args, "-s");
> >> +               argv_array_push(&cmd.args, "octopus");
> >
> > argv_array_pushl(&cmd.args, "-s", "octopus", NULL);
> >
> > which would make it clear that these two arguments must remain
> > together, and prevent someone from coming along and inserting a new
> > argument between them.
> 
> A valid point.  It is OK to break "merge" and "-s octopus" into
> separate push invocations, but not "-s" and "octopus".  Or perhaps
> push it as a single "--strategy=octopus" argument, which would be
> a better approach anyway.

I had missed that in the documentation, as the synopsis does not mention
it.

Thank you!
Dscho
