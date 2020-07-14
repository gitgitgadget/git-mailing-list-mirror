Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D97AC433E3
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DC9207DD
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Z/CiILH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGNUYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:24:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:47337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgGNUYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 16:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594758242;
        bh=/Y9DvJu8MAUya+5OJGEtl/60ReJgEVxqL2uOG6LNW8U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z/CiILH2c4zoGsBm6kP9G4EChLrWUXXEGGPTCPCzuaxXSlCYveRhNRamST7wUE1Or
         wHkkUv0ABFp5ozOIO6ccRU378vlaQu78SH6O6O8blyl1QsbU6AMmWxcaferXfRplQP
         dKQMzJVbAcVycIYLImmRBav6XzJm83z8GagJCPSM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([89.1.215.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1kaJeo12ya-00lXel; Tue, 14
 Jul 2020 22:24:02 +0200
Date:   Tue, 14 Jul 2020 22:24:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/2] setup: warn if extensions exist on old format
In-Reply-To: <pull.674.v2.git.1594690017.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007142223320.52@tvgsbejvaqbjf.bet>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com> <pull.674.v2.git.1594690017.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3AwuBW5D4azMfxFzKkJX9sI0+8UEcC2ntz9GM/MCVqz03XfE3+F
 I9HKjJ0RrTAcSnqsj9SSDmiafH3FGfq9dQo1uaMryBlUmn7P5P4NvPwPMja9O4Ezo/gsfwz
 8DG3xA1LMCvHsjsByYaGNIx9QBa0moBub+/v8vx4Ie1h+WBQlyFnpu1FCydrwBf1Te6yhuR
 BTd/MlS+puw9Qux5KdoCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g7DEUOER0Wo=:6smVVVjLMDwvQxCtOZpZ+U
 oWnhEGiyxeqkJH8x6hZFm3JULfRwQ94GtEXabIuET8wUq/xC7GRtUwrU1jfnul4NCVB6pMJEy
 n1XoH5gnR9XZJYgw63n2hMjbNMg+g4DFYTTK4KvbQbzp4ea5xBy6D1fPncXri/vBzgvJcY+Sj
 H5KSxZY7GXim/cwhSlG9hyJ70XyK5zSBgTyzE6YuDT7xJiI2NlzraoDMPIOA8Mkedlny/DHUq
 2vH29/ceOIliYEWnOD8R20GwQUTpSLBhxyFP4J+Ji6jhkmubieta/lOEYwXVuvtmMaIWOeSRG
 VM36Qk3Vpmg2SBZ9yfVKMwuMOdg3a+uoUbNCu+47yrFj2gu8Pwjj96ngq1NuRkVop20PBxojk
 A9AiOmvF4z4Qs9396oIaQvzrrsGMFkgugAd4J3YkWElzTntyUDnCqvKgnNdiUZMXZbc1bvmz5
 5LZry/xpdqwPNQqopvqxgPV+Bw4xWm1ByL5iHhcoHKm+Hpzusm0xzBo/edZO3tT/ZAV5e4012
 w3P6MS1oariFSYSm6rNqyy0X8upHKp/m5+4b5q+hqzdRMulAYKxBu+vdrKtHaeADZqRszPkL7
 28OS9cv07x2SNCtPl9bXfK51xXpFaBO/YkNowDuagPSU01/nB2kKB5xnIXaMHvIh1FvKPhQq9
 zcBjOwoQKeMy1gSc5/WcRJ9VJSsbYf+l+Sn6/nED4+GXFXJ6FL5Zk8gP1LiEx68VKbIjFwVGl
 WJjNrQhWKt765aQ+6SCynjS7qDIvB91HqZ52RsurTEIncYLtE3FL7Vj+h5GRdKQDIFEh02JrO
 PGiqHQs8aJNDscQV7TXD61G4xlDFq5fHXiUuZmKEWGo6/aOYqk+RXQoN5eZqwTZR61nWT5MJK
 rHJL8JbG5wwGlICGcpgdrqgbtfK4eUguQuH7nf1Ib2ZyWB4XEB6TF7eybrAwflG5dcG2rwcqU
 dfc0g1Jv7odglAZwy8u3m1llCHFNK+zEIExx5HhXUoXROrtK4HCHgpA3AtHcy3YsyLzhpqnpn
 9lU5WcpRlnk0Zi2wG2v2pgc9F7rHGTHjwRPt/hzisMzEn+wzK7rPGVpIgysCly1BiwMWlV1BI
 e6+1kuLf+2ifkIt6iSb3U91YZ5vVRkOQ0N3l6ZnvD4xO+2u34PiCjvwwUSsfIb1gTd57Ig/T1
 KL9CYpYiPGOPv02C1JznN1gvuSGkyTCPjpKikcuauaQC74w8xPXPpciGeELR6DCRy6H4GPkrC
 usq2FB5XYAOENBIa8STA/qgAmGt+zqfkdBnnCrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 14 Jul 2020, Derrick Stolee via GitGitGadget wrote:

>  2. A second patch has joined the fray, hopefully answering the concerned
>     raise by Johannes [1].

It answers my concern!

Thank you for providing these patches,
Dscho
