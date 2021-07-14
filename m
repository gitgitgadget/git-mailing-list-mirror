Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ABEC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EAB6044F
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 10:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbhGNKMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 06:12:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:39605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238359AbhGNKMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 06:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626257360;
        bh=OAZF3uCjx+FggsLcPvz5VP7Eu7Wy01IOpLy1gV7WJvw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L9rKQBhR2i29d195JHRdCVUEKKTB/0ncLGCCyPkZd7KN5G31WZ/bQsOw/lA8Dqfvg
         DwaRcAzw41q4YlYZ/tcbPYvq6eZByeYu3rehYcCYwvEbWp/Ud82V++MwwY2KyFEE6q
         Ar9ObVUMovns5ZIiTbEFgXtKh8fvf1NhhV4AxVRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.219.153] ([89.1.215.141]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1lSM8X1zEv-00br4M; Wed, 14
 Jul 2021 12:09:20 +0200
Date:   Wed, 14 Jul 2021 12:09:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
In-Reply-To: <xmqqbl7525w7.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com> <xmqqbl7525w7.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pR6BS4EEIKTODv5bBvZb8POAwcWtH2Yt2dotK534i3XOPeOBYrw
 k0myONR+FX7HWYAJj1jeDe5QhQ86cUauWp7YNXb4dvaw7/vgCt3jQfSrfCmT8BLY1RyvbEP
 WTgekBnA7O2025L5uqIuf53HUZk6ZGbjv/vzHcesymqrYf06sAXA4WFqrzdJTLCeLIqcMQo
 qb6YkOnaiiVr5X4CSu1ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AWRmIs8SZsU=:aprlzQURHYtZkHYv/P6G0I
 /Fg4k5hPiQ6nQaXXgTwt+D4D+SoNeEJle3dfWLdKQISDfiWZmA6cStcGvoU+wcZGwl2PbHnDj
 l6c8cQjkvEqSVrDByaDCDbEV/8trgQYspFElKGU7M3dI2D1yLU6w6i2bFPUTd0V596YBo/uiV
 e72dzeCM9Amy3BonW07dK7nKqkmSG+b9jbT35AqGc5RrNU09ht3342DlmgoujnkBoqKD1IFyS
 PgeZyUvU2cGHEaFxZWp1q3ObYxrQKBLiKioFl1Yy4rSR8CHxc0u3QRf8jHy6Yc6BHcdAOE7yX
 M051UWJicchpAaAd3S21ZjCPXrb1HrBSQGEYfHF7ryGhqgYfHhQrAvW8G9Mb43C9u78BhXhQV
 ERJFCpA4VaRiy0ce0arKfwz5ts3fL7VBVXnoLHouGNiRFWWRTqxzhXmWBtLpi93bU+zcDwtA2
 zNwzdiyygXa1vuZHKfJ6wwQlwN6HrHPSUfIFMa1f0X7UwVG4x4TioZhrpbYRjrD3pxdiWMd2k
 ok7lFe5aZ2P+jjAtBbThkIstut/E6o6xAG5yaVwmCEm5CefzCHGV2f0d5YNhrq+igh39Rjob+
 EcsUuviVp58l27hsOFQHJLSKnglgnQibs3kM4807ZRRF2t0yTcWBIyeqjxqu0QEYwTqkupLRX
 yrIjJDMTrJlCbZUafwxczOKV2vI6qYjhFBKkAA3N7ocFjMuQUPhj3ysdMtRoSKDJh6V0U9BEc
 Fg7kzcQD9Hrwp1zUPC4Ix06IRFQVJDotuP0mVFtdDq5uuLbcV9iVmkA/H48uyBdfdhIwyzy+a
 XMwawL4FdSRbboyxtXB0TsG2nXzKAqQQeJkUG6sHmR1UCY4GhLHkK9SJAz2Ta3jjk0LskteEx
 metqqJolHkd/aF8NpfAl9dvsNFdDII6/qiIw/caEiDJNmMta2bWyscAzZ8WUWGk1dxbV4zPUA
 sn+D6tYhgFHe7HeQHpCEinfdr9kvqYb5VXPUAyfVkt1a4Pj2PCxZm0ZX52mu8uOuLqfv1/FXW
 PcTor+ol2/rQIRrA6ABgQ5Yqenjgpr11M6DI/RHPOUkasTOY3UyMWBFAPr5QATZnTv09OEcmE
 Tn3Uqo16UBbm/FNqknLorzrqGdVUxoj+y0ld3JFpyDd4HTqIt/dbBll6g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Jul 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> >  .github/workflows/run-sparse.yml | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 .github/workflows/run-sparse.yml
>
> We choose to do this as a separate new workflow not as part of the
> main one because this is more like check-whitespace where there is
> no room for tests over the matrix of compilers and platforms play
> any useful role?

Ubuntu's `sparse` package was historically not up to date, not enough at
least to support Git's `make sparse`. Hence I created an Azure Pipeline to
build an up to date package, and since v1 used the GitHub Action
`get-azure-pipelines-artifact`. As a consequence, I thought, that this was
inappropriate for `main.yml` because we still try to _somewhat_ keep that
in sync with `.travis.yml`.

However, I realized that there are already too many differences (all the
Windows builds for example, which our Travis CI definition did not follow
suite, even after Travis CI got support for Windows agents).

So I folded it into the regular GitHub workflow.

There is one really big downside to that, though: currently, there is no
way to re-run only failed jobs in GitHub workflows (this is in contrast to
Azure Pipelines). You can only re-run _all_ jobs.

Which means that the likelihood of a run to fail increases with the number
of jobs in said run (even innocuous problems such as transient failures to
download an Ubuntu package), and it also makes it much more painful to
re-run the entire thing because you may well end up wasting a grand total
of ~370 minutes even if only a 30-second-job would need to be re-run.

Having said that, I think you're right and the upside of keeping things
together may outweigh that downside.

Ciao,
Dscho
