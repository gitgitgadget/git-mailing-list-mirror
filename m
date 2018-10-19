Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0B61F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeJTCCS (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 22:02:18 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:43446 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbeJTCCS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 22:02:18 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42cD8Z2tsDz5tm2;
        Fri, 19 Oct 2018 19:55:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9D2F01AB5;
        Fri, 19 Oct 2018 19:55:09 +0200 (CEST)
Subject: Re: What's cooking in git.git (Oct 2018, #04; Fri, 19)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2893a226-cbde-9ca6-fa97-cfc981bd57bd@kdbg.org>
Date:   Fri, 19 Oct 2018 19:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.10.18 um 08:02 schrieb Junio C Hamano:
> * js/diff-notice-has-drive-prefix (2018-10-19) 1 commit
>   - diff: don't attempt to strip prefix from absolute Windows paths
> 
>   "git diff /a/b/c /a/d/f" noticed these are full paths with shared
>   leading prefix "/a", but failed to notice a similar fact about "git
>   diff D:/a/b/c D:/a/d/f", which has been corrected.

This patch isn't about a misdetected leading prefix, but about
incorrectly truncated absolute paths. How about:

   Under certain circumstances, "git diff D:/a/b/c D:/a/b/d" on
   Windows would strip initial parts from the paths because they
   were not recognized as absolute, which has been corrected.

>   Want tests.

I've sent v2 with a test.

-- Hannes
