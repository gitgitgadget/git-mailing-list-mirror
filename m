Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28639C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 08:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKXITT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKXITE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 03:19:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701BCF003
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 00:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669277887; bh=5g0+PQtfbtcO4gWyfL5xT97PQ+z/n9Qsnhy7UrKVwy4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LuW95Q06bELQalFA6FkhOsSDOTgntq9g01iGCKmLkSUoyheLMdMYw/WZMZnV6y9vY
         eL6sKnumA/Dt5nlhHtFp02AgbLdTB+1Ehk0oevPZD24AxCBroRhxOXM35dq79Rq1E9
         wu+hpVC7FGJsC69ePcOOPcOT9w4dV67AKNGVZaQBSWqtNDZtUVI/qHRtmCfosAXqqq
         LOiFCJE3/nx+NfsB9oXjLO96dR/vNr382iBdgcDUCXdIlbxhnc7gO6dqsQy6TKvFJv
         ig0Ryp0ymww882WrwlZxMZx6cYBSnFpnBtuTsGka8goZUxCyPlE9t57MZsj7w8uQG/
         iTDAZpI1upMtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1oZAzE14kl-00P3ac; Thu, 24
 Nov 2022 09:18:07 +0100
Date:   Thu, 24 Nov 2022 09:18:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 0/2] Use fixed github-actions runner image
In-Reply-To: <20221123150233.13039-1-worldhello.net@gmail.com>
Message-ID: <53qnqqr9-2r34-0804-003p-335q4s884822@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yMMlA3cZBnyuZZ23K2glFtRyxlM5VP9jWaViMgFK2ytZP6jeogl
 5dttqYYBI4TFbCZ18QJb6txpAO6Bi57mrEj0Lwl1IrPD+wbrrazdwKDsFjQak8e2TkY/1zh
 +0MZsj+NEt5JhjoB7We7iAMYa82KuutCqpLwgQ5qNd7JhAAYYsajLBiYgVeFTp6F5Ls4k4y
 8WGV+2ciqIQQGzYxZvbDQ==
UI-OutboundReport: notjunk:1;M01:P0:gxI/zsVfeXs=;rHw80KAc44w4T4EwgYRgoQ7jc+J
 IGv5h7ftvdY6GnOPCHhJFL8iq6dV7813AWceHAXhl1S9HavngoF5aGTThOqv9x5/a+XNguA4f
 EaxTuAsKo08CuyUN2NnPDQyDOAteCx2zRFSdX1qRWJn/hAFgdoM/EPTJA9G1i2BvByqmSFn4G
 7EvzM/GTAuS/Q+sAO9RTzi92oUjgcmsg9CEOJBgjOjZkYpfyq8ficiXV5ROTZVstrRFQ0xWYQ
 SPLepNLKBiPUAEMkDbj2EzsFbQCnquTFUk4a7bgrc5IHibhuFT6XqBQgB+wse07m7sY+/+N58
 HfdJ1r9p80fBUAyNE8JQPQdzeTQwIVoPZQIT4iSjMHkAMH9AWD3ycCwwlj6H206pkmPrnDnco
 hawpdYytmW+vXEz42Kl5BbKAEvFa/oafrRiZNL1V+YcHjxmhsH+FOq1fkMm8IG8ntEEcErNaQ
 5j/424+/1yQmdPDKN+WpmCU5R/x6dnnEYoOg9bjLNerxglN8JL1FWel4vUqh4I/Q2pYPCMQVs
 CqSELGsE9QLNABZvny5Td9OguJ6pHnbKiWgit9DUU8P/VR+s89CGPEyfIOBkerF+qEsMFYPgJ
 ETfUtn9kA0vkGwUkXhsOeonAIhsiuR7fYOsOAC48oVWMUvUKFEjNC44GYWSeYmDRhbHD/WzPG
 PrhGZT7BN0muqiA6EC4vhl9OXz6ORq2IUo0ayMO696EL2bpQkdZCjPKNcFl9F1eqTRU9hzQy3
 YIu296MvSu/wIL4uRxmyLTINR6Kp/iXnu6BORRDyXaJfUYHb2Z0zkvlLE13mdILJGw5qsxVzO
 OAJ8+OcgIdTdQS/UcksrKgkzn7pmmAbM1Hgd0VwFpVrRE5afX8fdvihVMZHYIdkBu9tfRv7Xq
 0F02uy+ULIaufXSkX8lSJS5nm4z51kha0r2rAcTTm31GWPQ6Uc+5BuxkN/Xy2I/K8Xwk1PbpF
 RiTY34U56tKvQJi0FR5TlpLCneM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 23 Nov 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Today I found lots of CI errors of my private host git repository
> on GitHub. It is because the runner image "ubuntu-latest" of the
> CI jobs is ubuntu 22.04 (jammy) instead of ubuntu 20.04 (focal).

Excellent timing! This is indeed what I, too, ran into when adjusting
microsoft/git to v2.39.0-rc0. Here are the relevant links for the failing
and the succeeding runs, for the very same commit, but in different
repositories and with different `ubuntu-*` images:

Failing (ubuntu-22.04):
https://github.com/dscho/git/actions/runs/3533530319/jobs/5939252441#step:=
1:8

Succeeding (ubuntu-20.04):
https://github.com/microsoft/git/actions/runs/3532815597/jobs/5927646267#s=
tep:1:9

Having said that, I applied your fixes on top and pushed out a test
branch, but `p4d` still segfaults for me:

https://github.com/dscho/git/actions/runs/3538788474/jobs/5939977231#step:=
3:387

I hope that we can get this fixed very soon and am _very much_ in favor of
fast-tracking the patches once we confirm that they fix the CI builds.

Thanks,
Dscho

> The upgrade of runner images is in progress, and my public forked
> repository still use 20.04 (focal) as "ubuntu-latest".
>
> Two patches in this series try to protect our CI in advance.
>
> New CI instance see below:
>
>  * https://github.com/jiangxin/git/actions/runs/3532978329
>
> --
>
> Jiang Xin (2):
>   github-actions: run gcc-8 on ubuntu-20.04 image
>   ci: upgrade version of p4
>
>  .github/workflows/main.yml | 16 ++++++++++++----
>  ci/install-dependencies.sh | 10 +++++-----
>  ci/lib.sh                  |  8 ++++----
>  3 files changed, 21 insertions(+), 13 deletions(-)
>
> --
> 2.39.0.rc0
>
>
