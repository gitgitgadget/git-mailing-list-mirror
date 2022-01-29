Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE8BC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 08:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiA2IXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 03:23:09 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:45757 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352490AbiA2IXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 03:23:09 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Jm6lZ4kblz5tl9;
        Sat, 29 Jan 2022 09:23:06 +0100 (CET)
Message-ID: <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org>
Date:   Sat, 29 Jan 2022 09:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
 <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a heckling from the peanut gallery...

Am 29.01.22 um 07:08 schrieb Elijah Newren:
> On Fri, Jan 28, 2022 at 8:55 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Meaning: Even if stage 3 is missing from the first conflict and stage 1 is
>> missing from the second conflict, in the output we would see stages 1, 2,
>> 2, 3, i.e. a duplicate stage 2, signifying that we're talking about two
>> different conflicts.
> 
> I don't understand why you're fixating on the stage here.  Why would
> you want to group all the stage 2s together, count them up, and then
> determine there are N conflicting files because there are N stage 2's?

Looks like you are misunderstanding Dscho's point: When you have two
conflicts, the first with stages 1 and 2, the second with stages 2 and
3, then the 2s occur lumped together when the 4 lines are printed in a
row, and that is the cue to the parser where the new conflict begins.
Dscho did not mean that all N 2s of should be listed together.

-- Hannes
