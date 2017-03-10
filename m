Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC031FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 16:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbdCJQUt (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 11:20:49 -0500
Received: from mout.web.de ([212.227.15.4]:60294 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751316AbdCJQUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 11:20:47 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MISsx-1cpPXt32wJ-0048J0; Fri, 10
 Mar 2017 17:20:30 +0100
Subject: Re: [PATCH] blame: move blame_entry duplication to add_blame_entry()
To:     Jeff King <peff@peff.net>
References: <11b8ad3a-cd3d-2fd6-4b06-b442099c2709@web.de>
 <20170310083238.hjfnkmcgufi3oehq@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bcb26ae4-ea18-b232-a0e6-2877cda7ccc8@web.de>
Date:   Fri, 10 Mar 2017 17:20:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170310083238.hjfnkmcgufi3oehq@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:D3ziTLyF41vaA2SgNdQnNEEohnl5YLdU5KvSjUuXh1lhTHW6Twf
 M1zQhppPm+Z+yzFMoMBQ3fyl6MsQPu9TtN67QueyAY8/e8+zRcUTGZDlKJ8XvCTlsl6lrBq
 jgQhYil34KjOBmRxF5RH9XSew9U0gqdmZ6+y8MR9M11XP6a16vte9u9SICi6M+Hu/Q/TiLN
 /k/ssMexJYtDheD6svkIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H80nCvnta24=:U6Y1umWab5si72OFNo9a9w
 yxoKm9xn+BXx2FQFxjfP7Aa9eMzgjxlYSHwGThATwUMmdMCb2qMPmyHYKyGl6LEuZpCPTEGsJ
 oK8w3njK7MEfyfSfzHgGoADEgguYEjCYmt8iJcARTz1oqU0S4XlZHMjquhJcsmoW5H9ZA0Yk8
 kkTkVVCYTeHQDWZ4McRt8dDDF3o2ppQMkUQsmYcble+zti21DTkvHW2epDsq4xcNFQar+1rfR
 S92mfN4AeIcvFe9CCopCF8kyGDrOvQCHJm4etKraPhidBb9Kd8+mbQJ8djEo8DC2NI8NEq6wU
 Uv7zUo/Z6gajrsRLNka2MC8nIgiAi64QxQOLDM8Okf1nOnRPoefUCHDNEgBp3ofFXW+2YuZAG
 WmktbfMvY5nlsCq7oVCjjJDYEpy5GASObgm3sM8NuRFvXyJN7ZZJQ6tA/H24vBnRiR6v7R+9J
 H6Ln6R0dS4f+YE/sX+ir68jjpla0ATFB8+tJhckE9rz/nFXQpbdEdef01z3SWNIvbwR/Vnx9p
 tnO8EwPD2s5S0V7yKQtJmYqXIwqMoRETKRxVQ5P8PcCt+uVVCW9D3gZ/dK6BvL6ebi10bLl7S
 PzYTDQg3hBo4934C6qaFrv4eYn0D0EHBQWhF3S11xleEIIe83VDnioy1NtGE9DADBRfhfxeI8
 z6tKeKHBSgfHuwUll3JAoAkd5H2DzNflmtqReExZFQNfyAnlQfsmWX+uqls63jeFaC5OJktH5
 1oBj7iEgvAUMJWASYu6ARIwwsHM+wSVXYibC1JfYPIP4EfZrh+wdusyPziQGS4iRwUrftjwHg
 8PpPHze
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.03.2017 um 09:32 schrieb Jeff King:
> On Fri, Mar 10, 2017 at 01:12:59AM +0100, René Scharfe wrote:
>
>> All callers of add_blame_entry() allocate and copy the second argument.
>> Let the function do it for them, reducing code duplication.
>
> I assume you found this due to the DUPLICATE() discussion elsewhere.

Indeed, your grep command in that discussion showed them.

René
