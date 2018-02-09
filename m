Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95AA01F576
	for <e@80x24.org>; Fri,  9 Feb 2018 07:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbeBIHNL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 02:13:11 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:21906 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeBIHNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 02:13:10 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zd5r4565xz5tlB;
        Fri,  9 Feb 2018 08:13:08 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1BFF61D17;
        Fri,  9 Feb 2018 08:13:08 +0100 (CET)
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
 <87k1vpqq85.fsf@javad.com>
 <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87o9kyitf7.fsf@javad.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ec5c7aa2-b36b-aca8-d82f-9d131ac83b41@kdbg.org>
Date:   Fri, 9 Feb 2018 08:13:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87o9kyitf7.fsf@javad.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.2018 um 07:11 schrieb Sergey Organov:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> Let me explain the scenario which comes up plenty of times in my work with
>> Git for Windows. We have a thicket of some 70 branches on top of git.git's
>> latest release. These branches often include fixup! and squash! commits
>> and even more complicated constructs that rebase cannot handle at all at
>> the moment, such as reorder-before! and reorder-after! (for commits that
>> really need to go into a different branch).
> 
> I sympathize, but a solution that breaks even in simple cases can't be
> used reliably to solve more complex problems, sorry. Being so deep
> into your problems, I think you maybe just aren't seeing forest for the
> trees [1].

Hold your horses! Dscho has a point here. --preserve-merges 
--first-parent works only as long as you don't tamper with the side 
branches. If you make changes in the side branches during the same 
rebase operation, this --first-parent mode would undo that change. (And, 
yes, its result would be called an "evil merge", and that scary name 
_should_ frighten you!)

-- Hannes
