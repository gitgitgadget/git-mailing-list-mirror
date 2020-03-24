Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E8C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454DE2080C
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="S3T0qLy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgCXWZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:25:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:46855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgCXWZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 18:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585088710;
        bh=lWHm9QqHx6guAx9G0FlKwoAHLSRRsdst6TYmApKv8qY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S3T0qLy1ac16cXVviX/pUsdyf7Bq6iRpXN91PU0ZP/L1/y1+kaMkB/Pdj0uNlvHV8
         AXCRs+TRgGib6qBP3rSLQgMfsCLCZ6farfgiOyEEMJscVNZiibU2sVXujItsnoPAz9
         XmV1WNQ7/fj38gLgQ0VJ2w8ieRlK6QYuNsOgapXg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.32]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mxm3K-1jSMf22FNW-00zHIW; Tue, 24 Mar 2020 23:25:10 +0100
Date:   Tue, 24 Mar 2020 23:25:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
In-Reply-To: <20200324220532.GA647727@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2003242323120.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com> <20200323173258.GA3977@coredump.intra.peff.net> <20200323180445.GA31401@coredump.intra.peff.net>
 <xmqq8sjq6fob.fsf@gitster.c.googlers.com> <20200323201547.GA35429@coredump.intra.peff.net> <xmqqzhc63gmd.fsf@gitster.c.googlers.com> <20200323213109.GA44297@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2003242239300.46@tvgsbejvaqbjf.bet>
 <20200324220532.GA647727@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7VUeTtIZ3ilSFe3Obmk7wYNO/50rCpzbA+lfKy5l2PDbt9LRGVb
 tnFyFTtGD+nFaZSmSX1FpLuHUr2BnR0Bq6qVWOxcPBAZ/a6knH6BFEWmbBih1yhfJCDRDPU
 fjwR7mXsNHQfVWKZ0vvDmBqU5fp/75sn4wcusCccLth0YLUFeXB6JsAsMRZn1/IjLRVvwE+
 7gzaCC+etnvrHNer7P0pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nUTL3yn8rIU=:9briCDGlItCCLOeqg1tvkM
 e0IFs4/4P8szXUlbDjNvpE4xfaLLmOJPgYXl7CZQM1yartvJRbNbQE+OKFskC+EpC++e7pp6K
 3E2HZW/jus19s2iSh3rgL4ZrcRbPgpkxqfHChU4GieNEeOUrxEOnVhB0Y7I0lNHJ3EciHG3pp
 ULa1mWVYhzb+jDSP5kaIjH9rXPbp52fRhNjlq5ZmR40VBdG8DkQpfbRn0wv+iBPRiHR8yrs8t
 VC+e77bwiLg5T6R2kTx5e/5wzdQ+kiZV6nK5MxqZmGMUc4iSmBwOEb64CSHeKnruRBRd0cO2m
 89dzi+1EV771Re6ag1eK0rPLzVBelviOySDtYOFUKdvpsmKdADijDqenZzdVeBkx/1E0BdOLu
 aZFeeveW+ZTF+KKq2DfmQdJwsnhp+9ik3ouDBXbflLyre9TKhYHy+P6YUlOCM94V53Ef08/vZ
 lP7rGRTy7jF+oEQ3znrD9Hs1JE+Ju4JIZDwiSVVu1aM7XxD3tfMY1GyFnnFIgn7GMdOfk5+Bp
 gEIfksXgpnxf0w7VD9TnElAGhg+dJIZQcetH+i/IYkK8p9jqGmj4g56gbPuF5h0W+sy/Tiht3
 kiE9OXULb9BJ3uNVz/oHP/M8up9+/zRA4dMjAMdhzNIBPHCAP+G9Cg8scfwu//7EU2RQFxeVT
 f3OaetUI/B8kJ3zbTPFxK/RbBhHDSrYGaTGAid0IU9R9a/R+B+jVjjFkiqtZ0PCk/0PgYX4f4
 3wLNHLoSoFkpuOxkGPbK56/JYHzGmyE8PMdqArCoNVjQcBwEASoCESD5XtN2eeyw+Kc6FVZMU
 xe6sQucUDt09LhQdoC+GXbfcHxra1t/V+z9VIm4pYK10C9QyMxv9GGlSMv5bkcgW54Pzim1nN
 oo/lRmCZvCucMcemP5v87NbXmcS6AAo+1+1zuF6K2J44Wned3ktfrlDCLN6OXVkCIp24nJxUU
 /tk1Cd6GfCsde/wpGJ+yDlUUUsZbEHLHvgswBW0rfVF5qZkSJGCEAi11p++9Y6WNyNA7ncKCJ
 95TLMSdevdOBcTYPndx9VXLz4xctyJMFYmdqpBfCm48AbU3r4YYcWfEXopRJ+K+REKLfqT9y9
 UEBH5/yaw/cVEGt4Fs05OR/dCXvvxGmKP77X2putZPQ4hg4rSc4FKNF6K7NofVRVuYdIj4g91
 Pc817DyCgcYpkSjLJYFAN+o7FUk+RCNQY9JRB3cfVM6H5IiS46s9+MJFM79PhgLkUZR61eWIP
 wiavnDAs80sDD5Fdi
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 24 Mar 2020, Jeff King wrote:

> On Tue, Mar 24, 2020 at 10:41:58PM +0100, Johannes Schindelin wrote:
>
> > > The thing I was more worried about is that it's technically a behavi=
or
> > > change to set up GNUPGHOME when we're not going to use it (as well a=
s
> > > create the directory). But I find it hard to imagine a test that wou=
ld
> > > be affected where my suggested solution wouldn't be "fix the test".
> >
> > It is _half_ a change in behavior: in case that `gpg` was found, and d=
oes
> > not have a known-bad version, we set up the environment variable, _eve=
n
> > if_ the test-signing fails. In other words, we don't roll back the
> > environment variable.
> >
> > As such, I figure that setting it globally _before_ even evaluating th=
e
> > prereq is okay.
> >
> > Therefore, it is relatively easy to turn this thing into a set of lazy
> > prereqs, which is better, conceptually, I think. I am in the process o=
f
> > making it so.
>
> Er, isn't that what my patch did? I'm fine if you have another approach
> to present, but I'm worried we might be duplicating effort.

I missed that your second patch made `GPG` lazy, too.

My version is slightly different from yours, though: I do not insist on
setting the environment variable `GNUPGHOME` only after the `mkdir`
succeeds, as the `gpg --sign` later on might fail anyway, which means that
we _already_ could end up with `GNUPGHOME` set and the prereq `GPG` _not_
set.

Ciao,
Dscho
