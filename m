Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD85C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1652176D
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ye+tWTYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK1MzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:55:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:36865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1MzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574945702;
        bh=2CttFXkHI51U8Ec/bO5qiXmoyNwPNO7uiwd2vcn8Kdw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ye+tWTYIDB2Z+wsdx6A2gKD8Xt5AG3BI5bF1TgYBXUYco3gF3uTgOBnk3FmofFYBj
         fsZQ6GWPV3uPaYzBg9FBNNUMu9uA0lpSvg0nCrEw1l1Wh91Q9q+OUojuFmFFjXVzDT
         +mACUb87gjc9hlUf87vw+dKZCUFpH6RbHFwLYn94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1hnTzI3mcL-014TC0; Thu, 28
 Nov 2019 13:55:02 +0100
Date:   Thu, 28 Nov 2019 13:54:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] git-p4: python 3 compatability
In-Reply-To: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
Message-ID: <nycvar.QRO.7.76.6.1911281352130.31080@tvgsbejvaqbjf.bet>
References: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JTD6Q/nLvrWFkLEebmBvOMfmaAb4IJ4sB9B5b1vpRWd0/fnHozU
 K8L4k3sJhE3CW5mn96+FWlzq9LQKffb5/r1UHGU0/9PV/CCuXvfdCw60z3FBCWdFkACpswK
 WOmk5uGxCYhjnYVC+FNqld537lGqiYq57apUGehlWuikFHqG4aKkK0oYCDFSnSB+10xNOp+
 2cOKVCGGocfzQyjKtENQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S+u7ADHPhKM=:a6EwaWfIXcJF48Jl0HuWEy
 LvcDuvL/RVrzDUf8i2pCUSH2NbWZaJVhpDBwvUYQu1a3lkhfAO3Z1X0/TNwtPWt1Dmt1xhe8u
 XY0eWphFZXiiQVVK5sGQBXaOCk/zuds/sqltIzIdfmXySccjGZf9fY2KrrRJT36yVpWx2eAhc
 /PRNfH6LlpWuxxYaYYsyCZpa4XnXqGUIwFlwFGTHf8XdvA93znqtGgRaI8VMMVZV0JMvp1hsM
 pKZ3tE5Bnheo1KSKDd50H5ePmlhJsF+Gu6N87S0yfVUrrf8A1l5k/td+akG9wezKrt5d3FFa3
 l2uC37rc/Z2ro/WWTFDDK7RMQj9j/ariYAwfBzj73IuUztS4uTQbaA3lc92AoQIOObQde6qiu
 Y01Zhao2LGhQoNFWtVAy4W7Ld6EoaP7eZjCDRgxKWPL2TinQv4YAAiUfpaXxN2rfhAQS6nzl8
 veRx4Zkkr6WYzfv3ohfOxG2e7PdVufrnZfCtwsMuJck6gBhbRGe/1CkgWZJuokeR7UBB+m5Bl
 POUbfh2AS0quDDYwcMhTLD+l/eiXE8jtybXHNkBoO8dVn4v1rttVhCHFrCPilueQ7N9CRsv9S
 /AT9UA2vhh88rG6LFqu6+X+h4qoVUolmxSSvo0FBtOLeKa1sqrjQyyrJhdoFKEnZtB/whfQ27
 tLxE+lUPxsdCkdYPDTChDYBMP/xzqCik2YFV4UZ+D9Hu71gTE/wK9B88aKJqTbTG9T4al1nar
 cA9EHGprXwEr5+hMNm9mh8T4ZMOukwBgCVcbQVOBHZnbnzbfc/j/93vIjG7F0FFRap7FXrgbc
 3Gv3CCRJeL3TWk5M6VmGG0hM1mXPgCw1hRjStBF0rALVcbbgXUMw7FAO136jf/HQCCfqWqU7s
 S9a3OVQE2BS/Xg0q5iaz7jIXC/N7x9ECwNgn2hPKPShO90+xNMyV2aC0WFJGcTxR4bs4fSTMD
 QLfGN/x6GI6WACmKYP6FyQoVOeeHeRouDi0PehuktdPCnsoZtk22GdBQ+icCbKza9E1DR0WNf
 gMJxN4khiTBTa9JzzxgsYzu8BsV6zpiMIH5XXJyICjLNu0xtogJzBfmeRavc08Cp1uURXBDfJ
 kTnavdc20o0OJ7gDkDctvveI7746OF7i/DQtkfRjgN2dwpqGsr0OvwDtwYyKCJ3vayiQTLTos
 ftLYtlUHxMekHwGNRMI1D1kT1axQFIcb5bRx8nYQRmhmlP9c5b2HRPfcJrJBEC1h0MVnmR6Pg
 rpnNuXCF2zbNKvE+29OYt+HDIt4bVcvRAc4PJJP1o0Ttq8ifHK8+g28bibeI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 27 Nov 2019, Yang Zhao wrote:

> This patchset the necessary changes to have git-p4 run under python 3.
>
> I'm submitting this as an RFC as the changes are not exhaustive. I do no=
t have
> p4d available, and therefore cannot run the tests locally. I have made
> best-effort attempts to test the changes against a repo I do have read a=
ccess to.

How about opening a PR at https://github.com/git/git? This will run our
Travis and Azure Pipelines builds, and I am sure that you can add a
debug-only patch to force-use Python3 on the Perforce tests (and if I were
you, I would also restrict the run to those tests by editing `.travis.yml`
and `azure-pipelines.yml`, both of which files should be easy enough to
understand without additional documentation).

Ciao,
Johannes
