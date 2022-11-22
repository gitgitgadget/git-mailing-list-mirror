Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F5CC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiKVWh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiKVWh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:37:58 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA0025C45
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:37:56 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4NGzfn3pVSz5tl9;
        Tue, 22 Nov 2022 23:37:53 +0100 (CET)
Message-ID: <271dd9e6-3575-a46f-4c92-fa202aaf95d7@kdbg.org>
Date:   Tue, 22 Nov 2022 23:37:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] t3920: don't ignore errors of more than one command with
 `|| true`
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <221122.86mt8iaamz.gmgdl@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <221122.86mt8iaamz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.11.22 um 23:24 schrieb Ævar Arnfjörð Bjarmason:
> On Mon, Nov 21 2022, Johannes Sixt wrote:
>> -	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
>> +	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true; } &&
> 
> Any reason not to make this:
> 
> 	-       grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true &&
> 	+       sed -ne '/Body/p' <.crlf-message-$branch.txt >.crlf-body-$branch.txt &&
> 
> ?

Yes: I have tested my version, but not this one.

-- Hannes

