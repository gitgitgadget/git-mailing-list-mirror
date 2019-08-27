Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521361F461
	for <e@80x24.org>; Tue, 27 Aug 2019 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfH0JKn (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 05:10:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:38767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfH0JKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 05:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566897035;
        bh=RT4R6uOcTjQboqy20r4MQBzPoQO3++6F9fn2ymWfnQk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dio5TClWR/xuUac8HNtcM1ZwgsUme9GJ7lni7yXHfxxF1ALcfK07YaljXVaFtGSnS
         CBTnFuMowWewBv3zY7AADscYt4ybKYbkuylL9s0M7f79MKNDqSo3v5lH3Il7GGeDHu
         X2XvkuXufERAUpuQ02UfcIPBGwrqeflrFQTZP3uc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpbfG-1ifQxI3IxS-00fV24; Tue, 27
 Aug 2019 11:10:34 +0200
Date:   Tue, 27 Aug 2019 11:10:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 04/11] hashmap_entry: detect improper initialization
In-Reply-To: <20190826024332.3403-5-e@80x24.org>
Message-ID: <nycvar.QRO.7.76.6.1908271108410.46@tvgsbejvaqbjf.bet>
References: <20190826024332.3403-1-e@80x24.org> <20190826024332.3403-5-e@80x24.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N0L8xvKz1O1nNlJ82U8j6u5vZ8aCNeLbG9x58ecrvM2M+PlMjas
 OngcjzjUL+0KkWndkE0YiYdEHv847DqMQ3gVXeu6RbKl/3XwJ8U3LUoVxmRMpFzD5CQP6JM
 wSBpt/XCvLcjTKZmhxN7CMIozoHXXeT42wcEBcV69/SEqeq2cFVVmR5SPLHiuPrUAs17mc/
 bc7Ca+yWqV0DDu+Stn+IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wsh9GbiAoLc=:56q440Zhivyq5nY91GZk6K
 iJFtc2LSMbO6wGt8ZbJ/hMzImL/fW0zVJnxvyW/eJMni/eD0YFJhupxc/vCnpsb/ZLyl1nuK7
 CtKajUIr08hYgLw+Jrh5xQyQ6ouo2dq00dAWsMtHNn8CMJgEn/+ca7fwEgC66BFeER6vUHbST
 O+iD+u/aFGQOFPCNdZ/bvt/r5rzp/SoVb4zo8pYXRAlHwQU3Cu9MyhBOLSRzLvoMmtzrOqd3l
 KjtZJBSz5PhHGxvnOY3IPsuiFw5Sv0LH7M1g7fELwHmedNLICTYV4O/zVPyzZ19cpc2ai7L6n
 7w4Hxk61Wn2n6bD2OMAkKGF6ycN5gjggEXNOoYaDgtydWIeHXzx4UoKMbziiKvyjSl4g2QtrR
 kopIpZcqvNJugfSYKZ/cQ3rKghE+oMh5NmECy2NvIuvsRrXgaDIfHNS5sbwYE1UdVVpDmAWRa
 9QfQYF0JLBhrn2pef6pxGeEkYuOopc2wz7yox8S38rNYL16UOFiP6gUm7JV/7JqHWTNoRZuXj
 4dYRrKpLFIz+TSN99j3GRiVIkIywBt9pYpFkhb3xNJjHTAQVTq0l4n/dkuDrPVoU01oB6RlxA
 PlpDL0COkLZZAtFT/JUqHMyLQJM9ccCwOgNmd3mWWwgmbmQ/h8hlYD364AdiD+p1BQHucDVCC
 GjuAcHUDIgBlpLFCBFg5KU5m8b0JZgwObf/ZpF9BpH0LRta/19dpHzPEvZz1X6+6VbENFU0Fr
 qIn4n2HbH4MLAfERH7VjQBPgU7L/sW9PSh6wZmBtiFJ4zeKPDhZcEJlrRddN/xT0XsbPEb++1
 KICAg7QpmYhdQAVI5UBBA/Cuq4ksU5QB8nFicqQIZtnx4m3EH7VYnZRIQ7HX7J6o678pHye1+
 PzGBV632CGaL0WuKdzIdNC5B/AHBVjPC2rDBIzQPP5ggnqBU56baFCEe23bIZncopvd095VRR
 HfVhypxwg+HspLpDJsyEXOTPYNtht+gJcmkMwXH8wWsHyKpTYwxjt7Uu4IrwczcbIgjftvHkU
 L/kdfZzyKqwnTc3d4gkGKRDbYulwqjbIBeWNxh+YYXa5dgyoqMUEqaxBTQjS1fQIiuMlYocbL
 Eehpskcoryh5vuIseU0dSuV8yT6bL+tCwYmo1O0m3gVqgqoBjArkA+o5M0mzWHrD0p2ATFa22
 ucFXg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 26 Aug 2019, Eric Wong wrote:

> By renaming the "hash" field to "_hash", it's easy to spot
> improper initialization of hashmap_entry structs which
> can leave "hashmap_entry.next" uninitialized.

Would you mind elaborating a bit? This explanation does not enlighten
me, sadly, all I see is that it makes it (slightly) harder for me to
maintain Git for Windows' patches on top of `pu`, as the FSCache patches
access that field directly (so even if they rebase cleanly, the build
breaks).

Ciao,
Dscho
