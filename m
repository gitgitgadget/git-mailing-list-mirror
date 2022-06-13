Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AFDC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348713AbiFMV0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351758AbiFMV0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:26:02 -0400
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9CA12AAE
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:15:21 -0700 (PDT)
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4LMPVJ20P6z5vFn
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:15:20 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4LMPVC6Lvnz5tlB;
        Mon, 13 Jun 2022 23:15:12 +0200 (CEST)
Message-ID: <c2f49b4f-8588-bae1-97cf-91a36b3f16f9@kdbg.org>
Date:   Mon, 13 Jun 2022 23:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: git filter bug
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Udoff, Marc" <Marc.Udoff@deshaw.com>,
        "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <101027c97a9b40ce97192b1cee203b07@deshaw.com>
 <442e3166-4f18-3ee0-e3bc-d24687471d5c@kdbg.org> <xmqqsfo879r7.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqsfo879r7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.06.22 um 19:29 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> git status does not compute differences; it only looks at the stat
>> information, and that is by design for performance reasons. So, IMO,
>> this is working as designed and not a bug.
> 
> Hmph, is that true?  I thought "git status" did an equivalent of
> diff.autoRefreshIndex just like other commands like "git diff" at
> the Porcelain level.

Is it true? I don't know; you tell me ;) git status certainly does
autoRefreshIndex, but is that based on a diff computation? I thought git
status looks only at stat information.

> Is this more like the commonly seen "after you futzed the attributes
> to affect normalization, "--renormalize" is needed to force the
> index to match the cleaned version of working tree under the new
> clean filter rules", I wonder?

Not in this case. The modified file that git status reports happens long
after git commit -a has already applied the new filter.

-- Hannes
