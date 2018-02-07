Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13271F576
	for <e@80x24.org>; Wed,  7 Feb 2018 07:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeBGH1S (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 02:27:18 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:33954 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbeBGH1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 02:27:17 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zbtFH692Lz5tlP;
        Wed,  7 Feb 2018 08:27:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6CEDF1D15;
        Wed,  7 Feb 2018 08:27:15 +0100 (CET)
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
To:     Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
 <87k1vpqq85.fsf@javad.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5b41a285-5c3d-52c8-23e0-3d8421bb3051@kdbg.org>
Date:   Wed, 7 Feb 2018 08:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87k1vpqq85.fsf@javad.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.02.2018 um 07:16 schrieb Sergey Organov:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> [...]
> 
>> +--recreate-merges::
>> +	Recreate merge commits instead of flattening the history by replaying
>> +	merges. Merge conflict resolutions or manual amendments to merge
>> +	commits are not preserved.
> 
> I wonder why you guys still hold on replaying "merge-the-operation"
> instead of replaying "merge-the-result"? The latter, the merge commit
> itself, no matter how exactly it was created in the first place, is the
> most valuable thing git keeps about the merge, and you silently drop it
> entirely! OTOH, git keeps almost no information about
> "merge-the-operation", so it's virtually impossible to reliably replay
> the operation automatically, and yet you try to.

Very well put. I share your concerns.

-- Hannes

> IMHO that was severe mistake in the original --preserve-merges, and you
> bring with you to this new --recreate-merges... It's sad. Even more sad
> as solution is already known for years:
> 
>      bc00341838a8faddcd101da9e746902994eef38a
>      Author: Johannes Sixt <j6t@kdbg.org>
>      Date:   Sun Jun 16 15:50:42 2013 +0200
>      
>          rebase -p --first-parent: redo merge by cherry-picking first-parent change
> 
> and it works like a charm.
> 
> -- Sergey
