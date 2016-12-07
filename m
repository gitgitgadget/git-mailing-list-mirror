Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398AA1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbcLGUnM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:43:12 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:27308 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbcLGUnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:43:11 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tYr6h6ySyz5tlS;
        Wed,  7 Dec 2016 21:43:08 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 356631CFD;
        Wed,  7 Dec 2016 21:43:07 +0100 (CET)
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     Brandon Williams <bmwill@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jacob.keller@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7d968fd8-a92d-efd3-ce67-7de6049b6d56@kdbg.org>
Date:   Wed, 7 Dec 2016 21:43:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161207001018.GD103573@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.12.2016 um 01:10 schrieb Brandon Williams:
> This function should accept both absolute and relative paths, which
> means it should probably accept "C:\My Files".  I wasn't thinking about
> windows 100% of the time while writing this so I'm hoping that a windows
> expert will point things like this out to me :).

;)

With this patch, the test suite fails at the very first git init call:

D:\Src\mingw-git\t>sh t0000-basic.sh -v -i -x
fatal: Invalid path '/:': No such file or directory
error: cannot run git init -- have you built things yet?
FATAL: Unexpected exit with code 1

I haven't dug further, yet.

-- Hannes

