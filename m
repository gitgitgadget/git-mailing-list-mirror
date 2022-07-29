Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47060C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 20:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiG2UXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 16:23:34 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99474E0E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659126200;
        bh=QRATVp1ANCKzrZB06c+9g+h5glySg7rP++v+pQBBGwM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CO3ClkwlkHlyTBMb9gHiyKznqiFyITAkrQkC9P9xR1INsRxqIjVGZQUTb/SIYd4TR
         dNFBlcxzjFhzfnDV4S9Vli9VARiiHKLmiVWHJcaZ8y4a+iRqZ7MUPXRKriU7g3sSwi
         Gh084YKtRjiR30IY7v109sMeH1DfwLzJ2Vt4I+mM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.155.233]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43GU-1oHWW02DvE-000NdQ; Fri, 29
 Jul 2022 22:23:20 +0200
Message-ID: <701c318c-1a1b-1793-90e8-807cf97dc948@web.de>
Date:   Fri, 29 Jul 2022 22:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: Lost file after git merge
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
 <220728.865yjhl8wk.gmgdl@evledraar.gmail.com> <xmqqilnhcgd7.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqilnhcgd7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O3jbbxDKHMWDIS0jq3PIVew/ePz9fEyOUyulAMRF9P+jwOiiOY6
 A8P72uY9o7qcvxaWXboe2qGL2DsWa9kaDbuiM8rvh01yynxt7ZWnAU4gwzfssqcp22Xmz1P
 P9HTEDbbhNw4LR3lIRIW6DFdvQv1ey7690iGMxGigjnhNdjeqaUiFoguKqBXHRIEtegTMhV
 avV9qLOy+Q+CYx1/CrOzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sQy6VYWCxAc=:B6I70igFoAaHFWm+dV35gx
 9dUim2HEOvs3DG6v/m82RSl2HmsARH1QOenJF6AEk/vFPUDAsHvR/oY7C/vpkh4DnckDt0KcP
 Q2GIeCT4jJAjOJToy6uq/nW5yPHqB5r8aDnVpcqqMRNDaiuJ7QLk4LiFDCZrTYlaWrN5rQ3gc
 iL+O2OMe2axrB4kIZfvgteSCNL2kZfr5GABLl7jPAwA6FGplxphastq6AThHiR5cJWiLe8vL0
 Js9Zmvy8LhUp2txHc/kt7cwoj5JelltrddQ3hJ4Ds4BS4a44QKnx9y5WOry1ExERgvOkJc/xG
 g2OFow0jbQWiN10tC8y7UP0ggRLo+kw5+I9IBR6Qy4eWYcciIdmfpdSzUqxfvsxEa0KLvNj/S
 jZTiTxIqPWoyMPSMlfsddtSfn56MquOzmQm6qy2aA2CtprERqoKv5Ieu8jypauTJnikeYe6Z2
 chVDyWtEjK9VlotcwclLefDxdls1c526B1HKHkMjIvNbWQE+2+wQfFipfv/fxHzFvqmfQuMSw
 Kmc1APDhpF3ouzd4rTafosVYUvuunB7VmBad115aMj8oIe0/UJZhR6b2ZU/AiKE28XqapzyI9
 XDk3ETKYEcvQ2YgF1I3boX1fSXFcXji41/sz68Lf5xC4Uwx8AQWriQ7ITsJ6PanKCW90Sjpfd
 EoPN+PcPsNhGF9ah+88ZsDR619vwNs4eWTL7bGn4/F2MErRVgEDd6I1n2VifayKdLfrLD7Qhj
 EwjLlIwb4WeY03bVkNfbAU1hQnrIjMzkJJdoa0gRe6EOTwlT7GXJsc+YJPvCeikBKneloUdxN
 MRUgDk6bMg0S5GbRy3Cj1Q2VZafcH9TZrDcdXRxX1huZ2MNPdW7OX7Ss811AtqruYokcvI7oq
 lU2ONkC8EmZj4zkhl6n2Nm+ZfZiIsJRY0qs/hgexniYqlHDursCDDTcAce6hGeUPEzuj7dNYS
 +5jAvyH6z6VVi53pWWja/M8/ymGQS5nyy0ov0BnIhU1zdqEvUS+z5Qx8Q7HOmBqTuSW0aNwmS
 QouHIQ4Aycv0pF9yBcZrGGzT1zi7aTEU0BzG4Mik7ktC8r+JloyPvfBK1ASoI9fAG4SyhKyDO
 lhmk7U575rXgENma25MiYxl510gEJk9CvqW
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.07.22 um 19:11 schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Jul 28 2022, La=C4=8Fa Tesa=C5=99=C3=ADk wrote:
>>
>>> 1. I added a file called 'new_file' to a master branch.
>>> 2. Then I created branch feature/2 and deleted the file in master
>>> 3. Then I deleted the file in branch feature/2 as well.
>>> 4. I created 'new_file' on branch feature/2 again.
>
> It heavily depends on how this creation is done, i.e. what went into
> the created file.  Imagine that a file existed with content A at
> commit 0, both commits 1 and 2 removed it on their forked history,
> and then commit 3 added exactly the same content A to the same path:
>
>           1---3
>          /     \
>     ----0---2---4---->
>
> When you are about to merge 2 and 3 to create 4, what would a
> three-way merge see?
>
>     0 had content A at path P
>     2 said "no we do not want content A at path P"
>     3 said "we are happy with content A at path P"
>
> So the net result is that 0-->3 "one side did not touch A at P" and
> 0-->2 "one side removed A at P".
>
> Three-way merge between X and Y is all about taking what X did if Y
> didn't have any opinion on what X touched.  This is exactly that
> case.  The history 0--->3 didn't have any opinion on what should be
> in P or whether P should exist, and that is why there is no change
> between these two endpoints.

The last sentence is not necessarily true.  You could also say that
0--->3 cared so much about path P having content A that it brought it
back from the void.  Determining whether a de-facto revert
- intended to return to an uncaring state of "take whatever main has" or
- meant to choose *that* specific content which incidentally is on main
is not possible from the snapshots at the merge point alone, I think.

Checking if 0...3 touched P and leaving that path unmerged out of
caution shouldn't be terribly expensive.

> The history 0--->2 does care---it feels
> that it is detrimental to the project to have P hence it removed.
>
> So the end result will remove P, if 3 added identical content as
> existed at 0 and removed at 1.
>
> If 3 added something different, then the picture becomes entirely
> different.  The history 0--->3 no longer has "no opinion".  It
> strongly believes that P having content A at 0 was wrong, and it
> should have content B, hence it changed it.  Now when that opinion
> collides with the opinion of the history 0--->2 that says it is
> wrong to have content A at path P, the person who is creating the
> merge at 4 needs to think and resolve.

