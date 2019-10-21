Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768A71F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 19:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJUTfS (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 15:35:18 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:55358 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfJUTfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 15:35:18 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46xn0f63rRz5tlB;
        Mon, 21 Oct 2019 21:35:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 37AF520A4;
        Mon, 21 Oct 2019 21:35:14 +0200 (CEST)
Subject: Re: [PATCH v3 4/4] git-gui: allow undoing last revert
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
 <20190828215725.13376-5-me@yadavpratyush.com>
 <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5b62b4a7-67ad-9e5f-d4a1-9dce7bcfcb6b@kdbg.org>
Date:   Mon, 21 Oct 2019 21:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKPyHN0Kh8eKjzXink3YtE6wRrOgpzTYyPmLnbpbxPt3LFsvig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.10.19 um 11:16 schrieb Bert Wesarg:
> Dear Pratyush,
> 
> I just noticed that the 'Revert Last Hunk' menu entry is enabled in
> the stage-list. But I think it should be disabled, like the 'Revert
> Hunk' and 'Revert Line' menu entry.
> 
> Can you confirm this?

Technically, it need not be disabled because the hunk being reverted
does not depend on the contents of any of diffs that can be shown.

The entry should be disabled if reverting the stored hunk fails. But to
know that, it would have to be tried: the file could have been edited
since the hunk was generated so that the reversal of the hunk fails.

Not sure what to do, though.

-- Hannes
