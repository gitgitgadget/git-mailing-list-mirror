Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D4C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B972067B
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JpW6tfh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgFNVbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:31:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:49005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgFNVbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592170255;
        bh=bZHod8NARQjg8Vgl4rZ89BuYenXyy1NEtxBxA0sdRBI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JpW6tfh5seeFaPbwS4h1t9Q37Il1FQ/D5qemGzSivW8l9q3RJ7cWQu0BqFrJ18Vf6
         xvrWJ1GRn6kRPgVMaUWTCSFZ1v+mF+ZeZMRzz358AX0T1Gu1LBnRYtsWW59QvFV3Mz
         Qi12bld8xq00NXLHn4CO9FCw74GTll3mBOlt2JrU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.43]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1jMDbw2ZrP-00TUV7; Sun, 14
 Jun 2020 23:30:55 +0200
Date:   Sun, 14 Jun 2020 10:57:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <731205c8-7d4b-d87a-17d1-520fdec7375d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006141055510.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <08e46af3-ff52-8bce-b75a-db8c390c9641@gmail.com> <xmqqwo4di49l.fsf@gitster.c.googlers.com>
 <731205c8-7d4b-d87a-17d1-520fdec7375d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1464577387-1592125063=:56"
X-Provags-ID: V03:K1:6LLG3pvpYka/iyLghKj832/ag0fuPQd7BSWwQYrrFxtOEgOSq46
 kVb/jICi/+JyCYfcMXm1JClLLD0qnkOv7Q6YSucGedBe2N1Jm+T8ZYQkrVwTGpqXYvbeSPj
 JD5/E2V4YlM7EUPwRzT65pB03sdX+7t4xIRC1ykEPpPURO4iTc4BveBnAXS5UeWLmPRxXNb
 dU3t1NFciFz6+HuYLJV/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uPt4yOXi2vw=:U3fZzhaX/PVnLh3sK/c7IK
 8BYB2nhNWlRODkYRPnbAEKK9QuCsqmaAhuWB7WbMKNIja6pK601N2E49wOJnbdyZe3yugFXgj
 SbBUN6O28iWxkb1m0ZPVUpHW6ZxT8P8Ul1TBZl6a00Q8QvHV9l4AkaeruMJ88bE2ZYXHZlz/A
 jLBvdTNmXWvAIRWMkZp0sSMxMLIv3oLbdsac52Auj51NSPmPM6Yr3r0keWAyVTRIwRMkEZxgG
 KBhcCz7On/bChxckG3HWLfXpeled8cvlHO7vFNkagYbrGBcUyZ87IQyE4MwxnS/gDUfbuEXat
 z1dbLmNPiuv+HDRDXdakiIaNclEf7xRMvQBNnnWqvhnJm+gvgUFuJyOD8PTnvlGlpMxDNMNq5
 zL8TlGggxgGXFSBI3ftulipKi7YM5ULIQ2EEWPlZihTbTcHKKcHfZ9eyIAAl1XY4FcHva3KPa
 EmiHT2scUPXUKqiW0FA+CutPnLbf31DyyXeRlV+zjdycX9wIdqgLh9hSUHfig9Dt7Ibm7zYCs
 czSyPouxP2q3uiFoEXsLpU3o2o8Yx7lG2KB6NkdlTckbcMoUFtIrwJ1Ai4YWmSoqLm59U1moj
 mIXdx3DZ9tgmfKTs2oOwBLER6yhxALS2PZavqD352yeZCDE2njRP1hiRcJzjf7UBXFI6BdES8
 ihrxb4s99lbiHfPFhoKOVGTK/h136NXXCFyrOjRwGgGZlwXb7FjuzePLapvQ5zOrTZjX+MVKE
 RyawK8pXjoSK09Ny3M/k20Gg9nu+E7YCMR77E9xdEqEnrG8dl8gPhcLaAtd4vD1cw7U3vDNzD
 STcbvB4KRf44W2ws7RkFogB+pnh6Lc6Lknl+Rx2ZbxrQl5w/MKPJ/Ztp0s0/eSl5G/hTgFbDi
 v4c2TcqQgrkfOcUCK9Ng/jrz0w09y1fdTo5RTuD7kUwlKPmQVxhapawkWovVDd0c6pNbQDnO4
 wzxl+NHhLVt62QyXllNVb9PnpOg0T50H7hVCS+ZWyi3NzTSKz4b6OH70vkukyohroyhVONbom
 1XBLTX7Woc1PtjfvgSkfkCgL654vZ+FqqgUqgordOU5rCZ2GAFRhoFehg1fZ4pjYKVW1MtOWX
 Y0+T2cc/sPPmSTF8iDr6CQlMIWdittoaAHU+t3P/2rSzhpLnQRMqd+s3TrziO8wocP82oXiVA
 c0qaO22I5VOvDRv0cblnwSnPpiFA64gjyBWBRSjy1bnEdmic6BlvK8v+TfuQevYVgG5RlJKE4
 5puTozkHehGVP15Eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1464577387-1592125063=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban,

On Sat, 13 Jun 2020, Alban Gruin wrote:

> Hi Junio,
>
> Le 12/06/2020 =C3=A0 01:14, Junio C Hamano a =C3=A9crit=C2=A0:
> > Alban Gruin <alban.gruin@gmail.com> writes:
> >
> >> Why adding yet another environment variable instead of relying only o=
n a
> >> config option?  I understand it's for the tests, but can't we add a
> >> shell function in test-lib.sh (and friends) that tries to read
> >> `GIT_TEST_DEFAULT_BRANCH_NAME', and, if it exists, sets
> >> `core.defaultBranchName'?
> >
> > Can you produce such a patch that does it cleanly?  My knee jerk
> > reaction is that I would suspect that you end up having to touch
> > many places in the t/ scripts, but if you prove otherwise, that
> > would certainly be appreciated.
> >
> > And no,
> >
> >     git () { command git -c core.defaultBranchName=3Dmaster "$@" }
> >
> > is not an acceptable solution.
> >
>
> I wanted to to do something like this:
>
>   if test -n "$GIT_TEST_DEFAULT_BRANCH_NAME";
>   then
>       git config core.defaultBranchName "$GIT_TEST_DEFAULT_BRANCH_NAME"
>   fi
>
> But since we do not have a repository to store the config, it won't
> work.  Sorry for the noise.

We actually would have `~/.gitconfig` because `HOME` is set to `t/trash
directory.<test-name>/`.

However, that would cause all kinds of issues when test scripts expect the
directory to be pristine, containing only `.git/` but not `.gitconfig`.

It was a good idea to bring up; I share brian's sentiment that it would
have been nice if it would have worked out.

Ciao,
Dscho

--8323328-1464577387-1592125063=:56--
