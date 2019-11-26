Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C97CC432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0EB2080F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 21:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WPwQ1Md9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfKZVz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:55:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:39145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKZVz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 16:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574805354;
        bh=eu+edSBbnWMvHLKl5L+3Ngw2xNSFJHwfY8QHM8zj/y0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WPwQ1Md9eMtxKS8dpBcfCW1zvD6ckLWJLaSarpAOicpNcO2WIj6mQQ1hn9I2t4sEZ
         0C51DpMLztLqlmJxrBeS0xy+58zo5hyYJQdP3Vd5EIEwiwYWy0VPa6FWAiCW14ARg7
         6utp2vsqcoSE978MQ+Sj6RK1CSKjonNJFvliCDrs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1i9liC0LQ2-00iiJy; Tue, 26
 Nov 2019 22:55:54 +0100
Date:   Tue, 26 Nov 2019 22:55:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Robert Blenis <rblenis@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git rebase with rebase-merges option creates bad ref names
In-Reply-To: <CAPbTjvcPCZG---tkyQW8dCd5=LYhGmhpYg5MQSX5BPr+HEG2jw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911262254420.31080@tvgsbejvaqbjf.bet>
References: <CAPbTjvcPCZG---tkyQW8dCd5=LYhGmhpYg5MQSX5BPr+HEG2jw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F7RubbbA7gG/goS3GkA+V7iF1MsNraAAuo9FNXm37SDdK2E4KQW
 UKX9qXuUYBAYEQipAHlm8v6XcCFtaAsR+cEPCuh8Qned3tPuTwAHcQ/ER8j2U0rP6KgYJEq
 l+pdhPLHrAbL0gvpAPdc/+SOG6CqPNAb+obNO7/A0O9/qAs/Jhhz20Gt35MJHT3qv8NjJ2/
 1Et7e7yCfNn91fQ5CfQGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TK8uLvKrmO4=:K+p/+U6lM90eLMSmTTGwDF
 V/3FOuFRq9nEu1rL79OPAkCjEBxDNdU/7UokUR8yiWplnxLQBwdCl2LWtPXXWuzHpmKGzD+2Y
 nKOlAaV6kkDiqL1nobb1t8zW7ZEY5mLPffPINSE0Ghu9YoQLuUW+tZ6gY1jHXmQLhQRW51FX9
 WHHyEe8cA5w/gL8TxIYdies5z5aQBBlgzOGBpf2WIUtUGtDWS/25fz0UXHXmqsFr/+5J/9/zE
 BvkQ3i5r7aUymtFd4nHK0egruO5OBZ0Y63M6sioJyl5aZ/0mX0UpEW4g/2veT3XbTxaQcWGPp
 68KG2gej7S77/5Rdj2RLikfAlQgoTguaIFopkXk4Pm3QMWadvro6a2B/WSi6hBpp2Hf/hro6N
 6eXyVUcBVCPNAbJksz00UCQBzHzrRRzBijvJyixe6K+8GyCE7g/Ak4fDIwqoXnFGrNA2NnyV1
 OrUBhjTBdhhCeB/L0wrySXjMVLiVZR2bpQAXyPEcq9PqjKqfQIYrTYjEhlqXw0B6bf1GVBZmh
 YesmAIWiT0MF97n5ydLdMVaLIgpezeMoDzbozKclZ0rj0m/qCJqiZCLLB1+si9tVHwJErGKFs
 H8DrfKdLhf/H34nAuu4SVaHlgPmW/nTm6AeFaCK2xVJYVvT6IkbgoEw9uVIg+zC7w02MWM8Av
 XGt6JICe2v4axhfrVhw6KejCB1nqKTR5viRlF8hdyRRc5BhaFHpSDY6QA/YDAkfh3KGJhu4ZC
 pFBHrJ40EF29nh+39me0YR76tcYOun4y3BfWa/kWCxb0/ithxkQbZrsUebFLHypNH/oNetbcU
 qR4RjjbGRfs5j9ZsGJx2zU8DJm/CTS+cEe7nIdBmXoh4BuxaPDMYDbJuTDUl6aquBLrOqCAwb
 Hd25L0eIl5FxVFaktHM3wTRKSF23F26JcZZPLzQTlsklWOUWFsrDIHOVALQB9cmlGIR3+xOMm
 zr9CMfY1+w/bu8RTlazyEPQHhtJM8pjCwSMwXQxYfYZcgAei0z8fqtxLqB8JHD44HrM7ZHIWE
 tgOHJuDPFk9ONcHNmI3QnetFaXnldZob/JmnFgUcqATxQz8sY/1QwGqROsjcwyxxvcFyn4Cea
 6Nx+6ELDGFJxBJ55zLYVthJwqab8on4nzXdaufeXDkExtPKeuJClJ1RZ4pmOPj55pdImdmwK4
 q6jTht9QuFqDhkVwEyu4S9t1gd5Jnrpnv4OS/J2UKeJE14W5ethb0Tzfn97QYywfU9oGCXOxW
 PbnSbfk1kAPozMQ2LsiUAl4S9SefoWhg36uIV5Xx2rLSaa8QWeQ8Ztmk74qM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On Mon, 25 Nov 2019, Robert Blenis wrote:

> using command 'git rebase -i -r DEST' fails with "error: refusing to
> update ref with bad name 'refs/rewritten/Release-170-1020-Rev-D.'"
> git is taking the commit message and turning it into a reference name
> that is not valid (because of the period in the message)! This
> requires a bunch of manual editing of the todo list. git version
> 2.24.0

Could you verify that the patch under discussion at
https://github.com/gitgitgadget/git/pull/327 fixes the issue for you?

Ciao,
Johannes
