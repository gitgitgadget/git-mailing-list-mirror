Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34A451FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 06:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdFJGzz (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:55:55 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35802 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdFJGzy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:55:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3wl90l6ZV4z1qsF0;
        Sat, 10 Jun 2017 08:55:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3wl90l5d7Mz3jR9h;
        Sat, 10 Jun 2017 08:55:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 6AowzzO1tQ4W; Sat, 10 Jun 2017 08:55:50 +0200 (CEST)
X-Auth-Info: Nk6mIazj/tpnDbjaNgXX+36ySBAolCKIkYgruHFlGgJYFMpdn7/n2qjPSOuuCuUO
Received: from linux.local (ppp-88-217-7-34.dynamic.mnet-online.de [88.217.7.34])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Sat, 10 Jun 2017 08:55:50 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
        id A18D91E563C; Sat, 10 Jun 2017 08:55:48 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around free(ptr); ptr = NULL
References: <20170609085346.19974-1-avarab@gmail.com>
        <20170609220420.4910-2-avarab@gmail.com>
        <20170609222738.GF21733@aiede.mtv.corp.google.com>
X-Yow:  While my BRAINPAN is being refused service in BURGER KING,
 Jesuit priests are DATING CAREER DIPLOMATS!!
Date:   Sat, 10 Jun 2017 08:55:46 +0200
In-Reply-To: <20170609222738.GF21733@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 9 Jun 2017 15:27:38 -0700")
Message-ID: <m2vao4jpql.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 09 2017, Jonathan Nieder <jrnieder@gmail.com> wrote:

> That way side-effectful callers like FREEZ(func() ? a : b) would
> work.

Except that you cannot take the address of a non-lvalue.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
