Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C83BC83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjH3S3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbjH3IHw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 04:07:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80EDF4
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693382857; x=1693987657; i=johannes.schindelin@gmx.de;
 bh=yarlZNUXKkiNrUFjdy0x6jb5d5ZsQC/NtUmiinynZ/k=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=V80YPNZf62tkWo+bHKjWY6ekWyVXuKsqm/lfyy9qUWi7bO6G9p2upm0eNyT4olSPft1Go4r
 JHCResrQUMXCqTL2eoEASoBjgakX2b/3fz5AK3l6C3BunadyKku0KxSPVbKJYyW/pzscYHnEx
 CMDzDbELzvlNEOB7YEACnylobwFoYoMmAqQMyBNNr1Frtycrzme8QMqeQOSYv2GH5DwpnWl4f
 lzM6e/WiFXs0SUJhow753nSuqS5469vbyOUZQMe/71DuTtVwg59sBowIs3VSZVVFJN5zi24Re
 Nt9toWeapi5N7v3YJ1fodQcVdJD1y/FHyoySc+3CLFm1RFMXa3vA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1qJJyk1GXD-00ITvm; Wed, 30
 Aug 2023 10:07:37 +0200
Date:   Wed, 30 Aug 2023 10:07:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .github/workflows: add coverity action
In-Reply-To: <20230830001844.GA227310@coredump.intra.peff.net>
Message-ID: <36143de8-8343-b75d-4ba6-d7241535ba91@gmx.de>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com> <6534ba5d-f4a6-71e6-5b0f-9cba2be8426e@gmx.de> <20230830001844.GA227310@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Md0rEjg//Vx2EUNmzuF7DDpKM/NOXzDBoehgQRyS+pv1j4PQ9IG
 WS5C8GZtoBny/A9ABC2Kg1JAdCiYqkDBN3FCKwoRyXzOD7B95THGCcuTEOmRbSMA2WFuM/R
 rB8QTQihCAMgYwEch1auoQASIBx+Dl4/c0wGSNLRW/YofmnrE+OafLGctbwmquCV04Pls1s
 mATR9g/gzUHxqQKKZgMJA==
UI-OutboundReport: notjunk:1;M01:P0:X+OISmznGt8=;b+++bki47btVN5Qy3oThpoICTM0
 Y2jWTWrRDT9ef8CHFYEkb2hnrsPpgPs+SjWOKvkMbdXM4y6uBrdbQjFDe1CWNZBG6u5Lsua8U
 m07Zy4bSQc9v9MBBW6DMhG1C2rPsi027FS2NkCsSOWoLEKvjUZHTI9Q/yHK5bdO2lk95b4Wjr
 E5KDjQ65GFgJgi+Ege06FOFjnmu6BGAAvcz+MCr/V/+tSl2qFQSqwKq/bLvsOkIq8tqpJGbja
 aXeEnMbYChN7yE3egWm9/irM2EK3EDJxmF0ypO7qGiMG6m/3onHyToiEMzHVTr0tSGNQiotWG
 CpFt4ViAx3kXdwun3KvBcYBkPc21/wUgKSdG0ogy5Mjhg8kuXwOuVm07n8WAR8XubusTcKYJw
 nDMv5Po65VEWSekNHS5wdiDnue6xF1iAAzkdqb/EH21y4pmn+P7laLi7H312yOJde7x+pzP/0
 Zdo7Y1bxKK9+HVVwJeBiM4ocdCPGq/ZAYMZngVSc3GPdop+dC82cMkWEwL/bx5bT7MJ8z82L2
 UO+6q+9c8RgmdeenCe6Z+Vox8Szv1u2mL9nT4KZ33rRPi2Zo4sGrjyICspz+Dld3OyDFEV7n2
 1o++FkOByLqIriT+n91VukWwMFw4eWjP/ex3Ar/oGJR/BaUkBCVQ3WsN/V3fPrEvYFWyYzh42
 xCHJEUhfFNEWSfsXOFhbsQlIs0KCJndRiPs0NfiwpA3VnqaBsfVmIQHbd0DbMhVBU3sojeDYL
 StWiVhxLKN17XKv+95PoJDSPlZKzJ/12zd+TwRL3l8+doSX+k3VuN4V/Rf3DbyMdHnkAzJ2De
 TGFXNBHh8zwCDdwIHFATIGiLIulLOuq9hzr/ohYrnbCZsuMKIkVsHfSYxhnUNAfrZeenVUnOH
 keAc8QqTGb0xzSmZWdHTWxX4QEy/YxOHJsF+J7ubmU214VhlzmlQT/T2MXK4oYdx7u6ojwRzf
 14BmNRzGb5QcNfKQS7zbduJ16Ew=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 29 Aug 2023, Jeff King wrote:

> On Tue, Aug 29, 2023 at 10:18:24AM +0200, Johannes Schindelin wrote:
>
> > - Limit it by repository "topics" (think: "repository tags"):
> >
> > 	if: contains(github.event.repository.topics, 'has-coverity-secrets')
>
> FWIW, I like this approach the most. [...]
>
> My gut feeling is that we should be able to do something with env
> variables [...]

Environment variables need an environment, i.e. a running build agent.
That's why they aren't available in our use case, but only inside a step
(which is too late for our purposes).

I am unsure why secrets aren't available in job-level `if:` expressions,
but they aren't, and that's that, for now.

> [...] it seems that the "vars" context (but not "secrets") is available
> to "jobs.*.if". I'm not sure if I missed before, or if that's a new
> feature since the last time I checked.

I had missed that, too. It was announced here:
https://github.blog/2023-01-10-introducing-required-workflows-and-configur=
ation-variables-to-github-actions/#configuration-variables
(I must have glanced over that post when I saw it because it talked about
required workflows, which are currently irrelevant to my interests).

FWIW the feature is documented here:
https://docs.github.com/en/actions/learn-github-actions/variables

And
https://docs.github.com/en/actions/learn-github-actions/variables#using-th=
e-vars-context-to-access-configuration-variable-values
specifically says:

	Configuration variables can be accessed across the workflow using
	`vars` context.

I.e. it suggests that the context can be used even in the `run-name`
attribute of any workflow. Nice.

FWIW I was unable to deduce any authoritative information as to where the
`secrets` context can be accessed from
https://docs.github.com/en/actions/learn-github-actions/contexts#secrets-c=
ontext,
but I must assume that access to that context is highly restricted and
probably cannot be used outside the `steps:` attribute, explaining why a
job-level (and in my previous tests, even step-level) `if:` condition
cannot access them.

> (I had mostly looked into this in the context of branch selection for
> our ci-config job, and I think we could do something similar there).

FWIW I concur.

Ciao,
Johannes
