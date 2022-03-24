Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC748C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 13:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350527AbiCXNoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiCXNoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 09:44:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FAFA94D0
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648129353;
        bh=8Z0CVG/jVv9pXVxaO/oqYibWnNYQ3nJR42e4BN4r4J4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T0k3p79cPorfdhohDQczhM0NPors6uzqRTLf0D6ACxmWjBhnkOsbGPVbSnL2cH2CG
         LwWXjz3RWDEFci9Re4CUHLF0HaoGoLGTbhvZvijwrcsIchm5XNXYi1G5vPSTSxCtJO
         7WYzoOT5Ex/yCjG2Aj41I/beAkNcMcFrP9CyeVXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([213.196.212.0]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1nM4wB3mQx-00Cw4k; Thu, 24
 Mar 2022 14:42:32 +0100
Date:   Thu, 24 Mar 2022 14:42:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Joel Marshall <joelmdev@gmail.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: Possible issue with rebase's --rebase-merges option
In-Reply-To: <CAK1xKQqGTmgGBH4TY2mpHZLit_49FDoEq2EewDE-v_fc2=ikYA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203241440130.388@tvgsbejvaqbjf.bet>
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com> <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com> <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com> <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com>
 <CAK1xKQppM3oseB=vdXbDbPjDeFxd9kd0jULcaC=ASkMsKiDCmQ@mail.gmail.com> <nycvar.QRO.7.76.6.2008101645410.50@tvgsbejvaqbjf.bet> <CAK1xKQpTUqLLZkYuFEOx7zy8wOib_ohwmiqt89qoj-rK8tnZ4A@mail.gmail.com>
 <CAK1xKQqGTmgGBH4TY2mpHZLit_49FDoEq2EewDE-v_fc2=ikYA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WMe6fbua9kjFHq/jMADtmgRSW9giJQR+rUODJwXOWAyOWbKk/hG
 fVrTapFv2zaoYuVsCWKBHWNhgQEnXo69uG+FhZFP+6SWqAz3mywaJ3a1tNfcWmdDnrXs24G
 UhtjRZR5NIXE4EjNjfvNz66M6DVZRrBRa9YpHSfxZ1ZVuO+cD/rbjDJA/aykOTY+wDnDsLB
 Wpn9lEB63hQlDWNvx3xjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vNU7C2SlWGI=:AzUtDpMYYwQZoQZ02oydi0
 HojINzyV5mCU1uvqToIKk6JREJ67ukqpjrcaqvFbpE5efLrqd8N16PK/1/S67GEBI64oNxn6v
 LqK5NCtZ6g4V9TdXUjpFsZqrSRam2PMrE+IYGVkAeApohLWqcYDK2pBMLvpMYq6azIesFeN+f
 waOM8Q0z6/hx5DnH5FeE10dPyshhEmbH2D0iiEy8X54sYOJMvPESZOcplOwcHIKCz/3TCFFEW
 y452wTQYq0szKKOEweTLyK2Fio2eLsF6m3stpQiUSFy70RfJThL2LNgVy5qjZfjL+7d7pYR16
 rk0xy6xXxwWYKsYncbGafw2zVnhLD0+lDUfbhMnnTIV+T3EFRH6FSsf4/e3y480lYQKtl2Sjj
 KEIkxpeDRo/677zUGgltfC80BqFOaqjI6hkfTt9zuQB/txEuWEyQQBhGjXxbarheigDqkVjcK
 i8p47zcvp/AIp0Vr1ntSqgxP4T3/whAu7RQLVkctkF6CcLTqTqeZv3qumR04R5vYVGYIDyQjE
 99A00wTE2xKefaUDix8aa1bPrRNxNlDrSbU81xhMO/e9Ux+6BFQdPKnJLQrghpr36bOXexQ1Y
 l5brXYQF4+EGw5UZ9YWwROpZgY/prLA/WFelP9RaThXfJuLbtS8QYaF+VXAF9j/PT192wwxtX
 V0sZnW6WmZJ6zxwG0KJkfrSjTsMstGZKxFvBPS9/cH2npCHf2UpbjKdinFqTmNdUyLHdtsoUe
 RZgxolG3wUrEgeRjQNbkVJvOVNvZwLCMP52w1TgoRRZk1VCN1HKBw0UQGPqxK6Vngh5Y8CDvw
 9DJAtIXByzp0rtFRkPtNREdFmT15x9/EF2EL+QfIWyRs3lHfRQpqciVcqQ4sLkqgTxqzJgbsp
 o4Z6ocDhkM/DMrZckAZCuCqGHqzZuM8OgezUzY6ZUmZSxiAGYqka2vrvpdCJHaDInlAEkaR7p
 9m/sKGeVwpmDxkgBzwOZiAnW9b1+mKNaGIIDZLHliQlOpPKAqrlJ5Ve6ZZHDJwfB/gKVlqrWy
 agp/ZDJJ3ePsKL/Lv8RCAEkx5O4QuoxhJpHjckygSRuHiT9JBWJAdk2DW+64N83nGJmOt3C0K
 /0IGRGf6V2Vl5A=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

please reply inline. What you did is called "top-posting" on this list and
is regularly discouraged.

On Tue, 22 Mar 2022, Joel Marshall wrote:

> I have confirmed that this is still an issue under certain
> circumstances. --rebase-merges works as expected if it is being used
> with simple feature branches, ie one commit after the other, no
> merges. Where things go off of the rails is when there are branches
> and merges coming off of and going into a feature branch. At that
> point using the --rebase-merges flag with rebase will create a similar
> mess to the images of the logs I attached back in July of 2022.

I wonder what happened to my suggestions to use
`--rebase-merges=3Drebase-cousins` or `git fast-export --anonymize`. They
seem to have faded without any echo.

Ciao,
Johannes

>
> On Wed, Dec 8, 2021 at 3:46 PM Joel Marshall <joelmdev@gmail.com> wrote:
> >
> > Hi all,
> >
> > Sorry to drop off on this for so long. I think this is still a
> > possible outstanding issue, yes? If so I will work on getting you a
> > copy of the repo as I did archive a copy at the state originally
> > mentioned in this issue.
> >
> > On Mon, Aug 10, 2020 at 10:46 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Joel,
> > >
> > > On Thu, 23 Jul 2020, Joel Marshall wrote:
> > >
> > > > I saved the state of the repo in a copy so I could come back to it=
 if
> > > > additional examples were needed but I had to clean up my live copy=
 so
> > > > I could get back to work. I'll get you some additional screenshots=
 in
> > > > the next few days. In the meantime, I'll try to give you some cont=
ext
> > > > around what I'm doing here. The parent branch is my main dev branc=
h
> > > > which consists of a series of clean branches and merges- the dev
> > > > branch basically looks like what you're seeing in the
> > > > --preserve-merges screenshot. I've also got a long running feature
> > > > branch that branches off of dev, and it also consists of many bran=
ches
> > > > and merges, each a subtask of the story related to the feature bra=
nch
> > > > as a whole. Occasionally to get the feature branch up to date with=
 the
> > > > newest features I'll rebase the whole thing on top of dev, which
> > > > should result in an unbroken chain of branches and merges as seen =
in
> > > > the --preserve-merges screenshot. While you can't see it in the
> > > > --rebase-merges screenshot, those merges show no ancestors when vi=
ewed
> > > > in reverse chronological order- they just trail off into oblivion.
> > >
> > > I could imagine that you might want to try this rebase with
> > > `--rebase-merges=3Drebase-cousins`.
> > >
> > > Otherwise, you might want to export your use case with `git fast-exp=
ort
> > > --anonymize` so that others (such as myself) have a chance of helpin=
g you.
> > >
> > > Ciao,
> > > Johannes
>
