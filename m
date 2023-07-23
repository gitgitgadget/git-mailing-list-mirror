Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2912DC001B0
	for <git@archiver.kernel.org>; Sun, 23 Jul 2023 20:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGWUwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jul 2023 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWUwt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2023 16:52:49 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7794B2
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690145562; x=1690750362; i=tboegi@web.de;
 bh=5TXgm2NB36pL667RV1E1QqgtIEdwupwXssQnEyPF4KQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LbBtVQVO6UNwXsN5WS9Jj1dv0och7iAurqrQ4X9T2h72edzRYrfJPv5fXvLPhEMAeHKcAUu
 v0CQrEox4E/yHHTSu0NEHHqV0/VPF/Qx2Ndi3CBnKGn/hVkAYrw7e+SUeqVOCeDkls/URf5ct
 6Fn8F3byUgqXqPN92eZR5wwzf2gnyA7AFgzBz+S+JmK1CrlpbMvQyeIDRUTJtZtCgfsl7f2mC
 1Da7idRjTDWZ/AJWDJ0xBIRlFxUeAXYebzdyT6/LnBh/EQU1rgzwt78ftzUuWiXjuVraUbiM5
 Itm5UsbW0vIYt2/OZbFG89rW5qhRQg2oz8ryyFyEP16Q0d12GBWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1pwhKu1G2o-011kv9; Sun, 23
 Jul 2023 22:52:42 +0200
Date:   Sun, 23 Jul 2023 22:52:39 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Till Friebe <friebetill@gmail.com>, git@vger.kernel.org
Subject: Re: Lost files after git stash && git stash pop
Message-ID: <20230723205239.5snlakmd5ocy67q2@tb-raspi4>
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230722214433.3xfoebf7my5wsihf@tb-raspi4>
 <a373a659-a232-77cb-a177-a517b1f228f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a373a659-a232-77cb-a177-a517b1f228f4@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:tKU1Ob0gS00Q0SCbixEKEuMBdcUs82YHTS5d0ANiDNuymWacrTm
 BuJ8+vVaJDW0TUepWhU0UES21S3+yfpV1MQvfVsPEOI8hsNRR5XHgPAVsW/15sDZ8cGrXLT
 1X4TELNSeR+PUu5MxPn2UKRc7AZrwiAqEbyqL9biwLW5RBQ/TCNSQqd1efhSzLRGqBk1gJx
 GOCWTEtgmuINx/IdwB5RA==
UI-OutboundReport: notjunk:1;M01:P0:3mwoOxfb4us=;WUPrLLUYCe/tap9vQo1rXU6KJwC
 L2qAk7Y3oHNjGU02H19rJtqqSKXQJXrlF0LbpOs4xPhy40A+qxZzvNodhem474SJle31i5DWj
 qBswOOM2Ilp0sLKmr5Sffpet7hXEgGNF8r3sDtp4bc8Wj6yITbOnZ2KoI7btVMHljmqHHul8B
 KiUlInKzuZHcTRmvmNtu+PqAem48kRay3Vu9fgL2HEf7FcvjEWJ7OJZ7cwEq+BlnEWMzJ8G28
 /E/hvB5RsbYwbg7Vw6p4JJgpfgam3G2auo+rbr2mZ0soLU7+HdaONm0TrAwpE6gbMWpIA5WpU
 A38V7G92DRMaq3cDjmmEgkq75m/V5J+pgjlfVk8ZRDOX0R1xvjX+7McGaaRbs/x56NOw5ypZj
 nhIgP+UpAe2tdc4CepY/fK4yY4EDg0TeoX/uqyO8zpQ8gltlmkxkfvhulj16V7h7rrO6hkajB
 +AC0bGPaujiNG7aqUF7oSkMSNhHiTDlrXMam9vbS6eP1cnjMm4nIRV/cWLqiDbQBCtq5TLE6v
 pYsbOsCZSzN9bXKDFVlV0Kn0JW05p7h4yd/Dx0CPmLkPTR5NNjxUwlvmFZ+lInXEZINY1zuJT
 2rkCBoOJi2OOkOJnc2rY6g4MFLLVn0Ywx7Yl4WBvJD/usx7ecnL4mKRMFnQNKM4vcTBv6mmN9
 ubie6u2fC/8TPMqbkXiJVYEmK2dNdVxkwi+2mnsEjOCL2oTLUm1T1e6oQ2++bSD3YM3nB1mnQ
 UjxKVIwbl66ilNUJIpfswCowsjyqTQ2ot0nFXaLDzvWVUAV5ZVGFVADmEs4XRzmZyTJ3PK/7N
 g1e3gde3g2Yrc7RfBRbiSTyWcNa5VQi1alrBIuT4WA3fS/VTbP2r639QNQJJX6d+AIgzmWDqV
 0h4UQ+NU5F3XGG/Oysr+n4KRsR9Y+RfSFpy7tQWfAl3AeLldYb1831vR9LjQHMvwC6x/dNT0m
 JGZFMBnD235QDDQOKoeGCCKu1Po=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 23, 2023 at 11:01:29AM +0100, Phillip Wood wrote:
> On 22/07/2023 22:44, Torsten B=F6gershausen wrote:
> > On Fri, Jul 21, 2023 at 07:31:53PM +0200, Till Friebe wrote:
> > > Thank you for filling out a Git bug report!
> > > Please answer the following questions to help us understand your iss=
ue.
> > >
> > > What did you do before the bug happened? (Steps to reproduce your is=
sue)
> > > ```
> > > git init
> > > mkdir README
> > > touch README/README
> > > git add .
> > > git commit -m "Init project"
> > > echo "Test" > README/README
> > > mv README/README README2
> > > rmdir README
> > > mv README2 README
> > > git stash
> > > git stash pop
> > > ```
> > >
> > > What did you expect to happen? (Expected behavior)
> > > I expected that after the `git stash pop` the README file would be b=
ack.
> > >
> > > What happened instead? (Actual behavior)
> > > This README with "Test" file was deleted and I lost 5 hours of work.
> >
> > That is always sad to hear, when work is lost.
>
> Indeed it is. Thanks Till for providing an easy reproducer.
>
> > However, I personally wonder if this is a bug or not.
>
> I think whenever git overwrites an untracked file without the user passi=
ng
> some option indicating that they want to do so it is a bug.

OK, agreed after reading the next sentence.

> For example "git
> checkout" refuses to overwrite untracked files by default. Sadly this se=
ems
> to be a known bug in do_push_stash() where we are using "git reset --har=
d"
> to remove the stashed changes from the working copy. This was documented=
 in
> 94b7f1563a (Comment important codepaths regarding nuking untracked
> files/dirs, 2021-09-27). The stash implementation does a lot of necessar=
y
> forking of subprocesses, in this case I think it would be better to call
> unpack_trees() directly with UNPACK_RESET_PROTECT_UNTRACKED.

Thanks for the fast response.

This is not an area of Git, where I have much understanding of the code.
But is seems as if pop_stash() in builtin/stash.c
(and the called functions) seems to be the problem here ?

