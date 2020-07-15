Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F754C433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2382A2065D
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Eq6I8hen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGOTVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:21:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:38473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgGOTVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 15:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594840890;
        bh=764sO1pIZr6DwR8LolqTGUA1N0dEpsruySaJ3Tq8yEQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Eq6I8henlYUziRSronDYbj5wa1SXcIm+Yp8Q5NvAJw/VOz/n0cpgFSBAa5ZORRXsT
         iFXv9G3jiMhOqDO3En91HCINSJT/p5RroWfHBfuEsglTNiUbeVgYU3IoPRvHtaN1Go
         ZpXGEHF7n3H+gBp6kXLIiAXKuqByD2IH80UggFaQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([213.196.212.204]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJlW-1kcr0v3Wwm-00jGmP; Wed, 15
 Jul 2020 21:21:29 +0200
Date:   Wed, 15 Jul 2020 21:21:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>, Xin Li <delphij@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: warn about un-enabled extensions
In-Reply-To: <xmqqd04wk5kr.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007152117310.52@tvgsbejvaqbjf.bet>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com> <0bede821-139a-d805-934a-142004abaa4c@gmail.com> <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet> <xmqqzh82ktgm.fsf@gitster.c.googlers.com> <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <xmqqlfjkk8zv.fsf@gitster.c.googlers.com> <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com> <xmqqd04wk5kr.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rXiR+KzaEWEXwDT5WVCu/hH2QoCcXJYAufmnXb+rdYm/XeyS/mi
 npM5gTUEKye/IMGL7gfZcSv8QjYkIri5LfxgJGJfJY35NbNIK5KYUxEeNVZ5W/eVYiA64Ul
 WjqrGpAczvvt5a21KERx+SM8f1RxOA4oBbdZJjhka0bJiJCW+k4aFPFY1JRDzsA107SZmk2
 D85X6HFtRjkyDcXAt5R/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rcTdVZbgIQc=:QWPicNBzH8IfBNByr1z/VE
 1IcuVyci2aHOs0ep971HqGRv36l3S/63lD2jthSPrKNwUsNIheub/Vbyanuqast85gJymPO4O
 6XfskZH2qnGLOyErYVG9U+waRyReuj4LRGzY3ponlPRI5fRzxtnGzvfPQ3Y+sCm7cruLJV75t
 7UJZYMRofuWx6AyiEqPT7GSVJDZ/8nuzzcehLBsvqQEqp3tis5GK30DGrNarXiMvz7pvMTg3D
 b2uPedw2IbzkTpnjwudd+9K5e7NHdtf/5MoW/UyDfQnFsOlXxO4MBbrjihXcoviRdjOdCGPPQ
 c+FJM2ch9214JkePU+TsMNKMqsh6vImCDCPIlr/usY9W3guRwALQv5x9FN+IeyvDOEcILz1FB
 UJb6PrBSvvLqcI5sm2Oqqlbp/9iB9lcwzx+Xo8isYm5bDjPi/h30AgGcF0L6YDktoJ3TuvM8w
 LWutMIDFi2HOy/WLiov7ReQaZIgST4xR8tAesxOsn0Ya/la+Xgv8dcQpMCus4r8GolhP+6EYj
 45GTLxScMvLjcMpJ3eK5snF1PEWsh8rl/+Hg6JP4z1MjAjrKmpumyfZStufifLyNmUKdg/UMl
 4oU/ewFEXGfVgJaFs11dsy6Qjpt8OWsaEjyS3fsr5GrACVDCa9TlOUXDyuw9MCIP+KCP50xRh
 uwGu0nRON18na5gv8gMk1DtIsaBOPKxmrlZh9AV8/j1Cz5XMa8PC1N2KjiKPF+Qra4LLoB+2W
 yzLZOI1ble1YBadGpP1irEusK9fNJscdhYh/gXRBJ5IEGEHjRjD3kYoixlYzHLAzQi+cHbTsq
 5AcpQYrRXzc1ffl7CPGk7UBfUwHemlasUdshXrxCASHQn3YES2Dak1dOuQAHCuWZ0in4Jmszy
 FzJcR4LpQoOUXuBqHxD7nrzSXikUFeAK+Wu7bj0TUsthLnBGvYMHHmiNRk1MozJU7HxZDnGlF
 gFypEKrlSKCYVBQHlQ2GrfGOn6OfKQWzvrA/onkItSy+cqftutL5p9N+dkbsr1yr4FDOXyjK4
 dDlg24aefVPeqWYm4DGT6RKwNcr2l1rWn7bh3IL2ay2uddQmmfbhQSxWqRTR5zDlHgGwLBEzh
 rYcBQ/uh6J5AwVegKxvGnxLGdRCu+fL+cXGKFm0V+vtMgmFDdIhRyEl79sav/OI9NlJNn094W
 9NvT/sNEmluO9/SRVNEoXM9IkhYxuadl9sLh06Y7PXEgbVlXPTP3Gs1CKXLYLKVNWc0xQ+hcv
 iaUdINixqiAQD3cxfcWc+GYrHe0wXjmse9nkk1Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 Jul 2020, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
> > Of course, the _other_ option is to revert xl/upgrade-repo-format
> > from v2.28.0 and take our time resolving this issue during the
> > 2.29 cycle. I'm not sure how disruptive that action would be.
>
> Yes, that is becoming very much tempting at this point, isn't it?

It did cross my mind, too.

> In any case, I've pushed out 'seen' with the "these extensions that
> used to be honored in v0 won't interfere with repository upgrade"
> patch I sent earlier, and I am hoping that it would be a reasonable
> middle ground that won't regress things for users while making sure
> we do not honor random future extensions by mistake.

Given that we still have -rc1 and -rc2 to make sure that things work, and
given that your patch on top of Stolee's two patches looks like it is
Doing The Best We Can Do, I am optimistic that your reasonable middle
ground is the best way forward.

Thanks,
Dscho
