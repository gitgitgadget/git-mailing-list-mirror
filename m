Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEA2C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiEYKRt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiEYKRr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:17:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DDD93990
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653473862;
        bh=8r/wvZRW1KG2TZ8pdR4KAKEmZBS2gvyPNsXbaQ7PMPY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R3b4WVRf0DkC45+IConpNDLneX3U5YI1E5zxFqQafdYW5ScPwLdrFY8B9pYp4wmK1
         SDt7wGI76AXAgvWvsW0L6mRU1iA9JAiUWDzCZmiRmpCCf65BYEMKHFYlLLz/vP1qe9
         6RjrbIIgl74WdwJAyybQsy1JPBMCmNIP9OZnUX1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1ndGht1ewx-00zVkr; Wed, 25
 May 2022 12:17:42 +0200
Date:   Wed, 25 May 2022 12:17:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Yuyi Wang <Strawberry_Str@hotmail.com>
cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        sibisiddharthan.github@gmail.com
Subject: Re: [PATCH] Remove (_)UNICODE def on Windows in CMakeLists.txt
In-Reply-To: <OSYP286MB0262561439C0C7F0265A749FF8D79@OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <nycvar.QRO.7.76.6.2205251216510.352@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2205242046470.352@tvgsbejvaqbjf.bet> <OSYP286MB0262561439C0C7F0265A749FF8D79@OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MT1Hzf/8WqR7cH/QThaBnHW++vagmcKyq4EflS4G/l+zIeb6Stv
 3wmVp7SANbbUdaqsD4YUM+Vl/T0KSplDbOYh5p77weqc9kLQqDzsQSXiEHtF2EtYD3U09OM
 /O0dei31tNyqV6QZHDg+r+t/gfuoeMQeg3xYKuwscEmzPN45eX4OT/fhqmVdPOLKJnw1gGe
 40sd8g05rY62t0yfdIv0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UtI3R04qRlM=:naKWIf8dsXrjwHXqd71ALH
 rgZZ4TJUcVsSka0pAitVqIC0oGMqXHm3dVROW1/3cAqC8m9IVWyf59vsQZMvUSsLTbPg6VBOp
 095Jphf8j+fR561Mqj/WbTWIZKqNqDtv6Wk/Mht1IenGZx/ehpgHIbXnsxScf0iUfMPuXl2E0
 HBs1E12LDMlasbh1MhugwgjN5kNbe0GbB39xUMVhAG46Gjvqa4q1OLKChXouqU+HMKa7pd4sZ
 Of3H2RC/H83z0D7ydX7KugDgH5QB1MgYmTb4TfP86pWRwtGh4aR33/NQFoISNybFIGmsEmArO
 tSDWdj9850x7VwjdHPK9hztMmB8SDhDdRdbp62i1Qo6ChanLwD7twj3ZCKx8vpdDSd9lTdEcZ
 bDN+4zRtESll5APf2w5uYeibSFUneJWgFbGcNE+/93bmoZf1aPvf2W3NpT2ADN5OGRF8A6EAC
 qOMstXN466oh58FgUgvLWFHAxVIED6/WdFtCeuiXQYa0VhQKH9y17izFMv9Uvzl6s9s8cnpVU
 3FcA+0j3rewG6URMt4d6eSqftHHbkqb6xnF3hGY5eB5x16qHWK5tC+WM0HssuN4lTADC/2lyb
 S3a+LV04y2BQD8IHK3vWwsmEy2YiBTkQHdmtfdrMq9z79d4K9u34wShEZSHRrJXAVEZIhQXP+
 57BCIj+Uo87mHEFJH1FywfQYkMyZcTfv1VjkqXBiUF2qKEalMYHy33ahsV5JpIDarBxgb3ufP
 R25yI4jNOURqOrTcBPX/HGYr33Dc7t3gD/494i66zNl8LYO5TAmKvcTFTaytmTrjU6k8O6Rk2
 +PFOqMcmtXiA+9zbKvFVSCH94M3qLfWP3+gmJBIxp/Fu42qSeiW8TmLfLYphhKXHJ8SJBTahN
 AJdX1TqOMom8lISQKFzfx1qWdCyzKOuznYEhX6Ow54wE1usPSKYKGyYKTX+4kxzXOojqbmeRJ
 qo60IqKIW9MAehWqavvqpoe8T28zFFOzaY9hg7TkApuBVlcKBIbuglwrfd+n4GZ8TtACbqf8i
 XqR/uLq7c6tiDHq1b1/7uZKMlGcQwEsQRk7GN1HHLC//T9DIDTKFuHLmEC+rtGaHK4jtaQWIj
 A89sHTUyRXtoH/FDMttE3LY1+OL11gcNQ5NI+y1In/2nenEfGyMprBh4Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 25 May 2022, Yuyi Wang wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > P.S.: Please note that the Git mailing list silently drops all mails f=
rom
> > @hotmail.com addresses, as far as I remember. Therefore, if you reply,=
 it
> > may never reach the list.
>
> Thanks for your remind! However, it seems that my reply reaches the list
> successfully with hotmail address.

Oh, that's good news! I am glad that this was fixed.

Thanks,
Dscho
