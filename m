Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7ACC28B2B
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 10:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiHPK4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbiHPKzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 06:55:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959726D575
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660644567;
        bh=kehraDIdy0O5vJyaS0/nGIeg42A8xEViJ2vPuGwceYM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gZv3rcj3ZAKZMd78/hNKVSqdSsowG/fFPhtWJ9OxHiALThBCfWmbARhF9Y0EtIXFB
         RU/2CJ1SypMrAYkgWs3aw0HvaFQzdL5LzicOQceaOHzamzB6SMmkb8+P5o9NTkVFcf
         xyb8S4YDtIJuHhWBSPX6QHMrWFpMjCJc+Xlec3RU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1o8TBH1QBk-00FUNG; Tue, 16
 Aug 2022 12:09:27 +0200
Date:   Tue, 16 Aug 2022 12:09:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] cmake: avoid editing t/test-lib.sh
In-Reply-To: <23d86b94-3e2e-bdeb-3385-a996c07b699d@gmail.com>
Message-ID: <8o4q98s3-sr2r-34qq-p7pr-8o44061o0n76@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com> <23d86b94-3e2e-bdeb-3385-a996c07b699d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ge549NsEGWZfeyQitBs9kd/rtbF8UygNzhNkVElNTomTznmI+sY
 +KQJvZkyHmxpId4fagi5qucTOhli0NUxp6/OruN5tm2XeY++SRuU77QOKb63LEJMFOSHVns
 sJg9/xgWWV30jqb2CcuDQOZiU83XkXlphLmqbaUWwP8GQn8TNVYywqkZ6Bk0V6K55G9TdYN
 13klSK9rrbJ3aWQc9o6Bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HoXZz6TbAhY=:NboZyCML1sXXHAKGGJ9KEk
 bZ14TeGFCB7yvfCbtmYtQKwe9UcEcIiA4Ysn36AZ55YbnfJRc4/Py20tKZl5K5nMZ551wpnwO
 PtNEYn8NGAfSssJK/YmGp6Fo8k+2IMH3EXvzH9/smwDrdKjHOvYEN4GHjS6ZJBKvQzb7MkcYo
 Ne3PGiElACMgC5aVURrhyM939ja6DKJeis+qXvAlXvOVdWPU2DvrhevIrtP7KgPbIA+LclE04
 BYXFj1AroZ8TYFr1vJzUiOjz2dqphKQSCsZR1u1QllzlGAwqqvYqtuqz8SkVA13CP+FB/jSlM
 Q3yAEdvwrOCBzl7NXBFeU7v3giOB0RZclls83UBZCHgXbkdKzzEfOOkxzMLAWIWoA10zP7gja
 HXLcmxLzJLSyin5F5zNDSlh7TCv1Ujiz0vu/9SrxWuyseGs8JWaEfMdt/IMVZx1CP1fRJMjDc
 jTcLzYlQ7NJfrwn6z7Vv9AtlbdWBuzMW0wMYAuWIGS+/xYRmWPglplqdBP/DcUgecpQsU/exZ
 ARUxZrlKsbi/q1wt2Hw9sNwu2NljF/hzEluHA5ZPng50IMlnMyNTCCVAKCqR8D94aKowVx/6H
 RxGnbAPkpRso5a3o/BScqhg0Fa8cI0U98oSrLldgFfiLpDH4w12lqYYzxNCam3AUAi3ODpifn
 wqR5dRbElvCmHdilQSkG+wpVKyBrzsHYZXVhq6bnk9K6u1+IhWUG0x3XkPzKCqpoDkrh/9N2m
 xOciRzkQG7D5bYa8s3jnzn22LJd+MoK4vjT9tSRk7PW4nhSqJZVpwNyaH7Twik4nxQm5fie7s
 fZx+3h/csvhP2XBInSwo1cC6SD8U6JQBxl/fOY0++W6rq7jD9FA2dh2xpaXS0VH0Wt14GLXQi
 by5RkbNGaaHhD1g5ai2ZR4k71od8UseRGPBPEawC6SbyHki36KS5FTchVbiHoxCvSvItauPE0
 eko53kUL+1UUouTV5JvNVd0durbD3oiYYD7qkjvA3pnC+dAb69YGDqx5G91QIwEaz1AvO/93T
 b3tG6Quky8XyocernYOoHjHJM3Etggga7SSOmC2nAbKw410ll8lgdZuqO9O1TgXLwOMwD+r5t
 7KmQgvMsS+TWi6H1HoFH7zjvdu1y+SgDH1NG/VI8WsDW33CGp72LGH5rw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 11 Aug 2022, Phillip Wood wrote:

> On 10/08/2022 16:02, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 7f5397a07c6c (cmake: support for testing git when building out of t=
he
> > source tree, 2020-06-26), we implemented support for running Git's tes=
t
> > scripts even after building Git in a different directory than the sour=
ce
> > directory.
> >
> > The way we did this was to edit the file `t/test-lib.sh` to override
> > `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
> > directory.
> >
> > This is unideal because it always leaves a tracked file marked as
> > modified, and it is all too easy to commit that change by mistake.
> >
> > Let's change the strategy by teaching `t/test-lib.sh` to detect the
> > presence of a file called `GIT-BUILD-DIR` in the source directory. If =
it
> > exists, the contents are interpreted as the location to the _actual_
> > build directory. We then write this file as part of the CTest
> > definition.
>
> I think it is really good to get away from editing the test files, but o=
ne of
> the nice things about CMake's out of tree builds is that you can have se=
veral
> build directories with different build configurations and this change do=
es not
> support that. Could we pass the build directory to the test scripts as a
> commandline option or environment variable instead? e.g.
>
>   foreach(tsh ${test_scipts})
>    	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
> +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint
> --build-dir=3D${CMAKE_BINARY_DIR} -vx
>
>   		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>   endforeach()
>
> Doing that would avoid changing the main Makefile to remove a file which
> almost certainly does not exist every time make is invoked as well.

This is indeed tempting, but one of the things I recommend to Visual
Studio users for ages already is to run the tests in a Git Bash, i.e.
outside of Visual Studio, to allow for passing `--run=3D...` options and t=
he
likes. This recommendation predates support for CTest, naturally, but it
is still valid.

And that recommended way of running tests would be broken by the suggested
change because the tests would no longer run except when using CTest.

Besides, while the semantics look tempting, the implementation details do
not. The reason is that we use `GIT_BUILD_DIR` to source the
`GIT-BUILD-OPTIONS` and to validate that Git was built, long before we
parse the command-line in `t/test-lib.sh`. I want to refrain from the
prerequisite extensive refactoring required to support this, at least in
the context of this here patch series.

Can we maybe agree that the proposed patch is a net improvement over the
status quo, and think about a better solution independently (without
blocking this here patch)?

Ciao,
Dscho
