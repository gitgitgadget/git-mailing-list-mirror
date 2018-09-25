Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F191F453
	for <e@80x24.org>; Tue, 25 Sep 2018 15:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbeIYVr4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 17:47:56 -0400
Received: from mail.onyx.syn-alias.com ([206.152.134.66]:22036 "EHLO
        smtp.centurylink.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbeIYVr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 17:47:56 -0400
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=GapVpkfL c=1 sm=1 tr=0 a=yq6KBQdhjYNuzzW9wyfViA==:117 a=yq6KBQdhjYNuzzW9wyfViA==:17 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=JBFolyDoGHsA:10 a=s5tG97AM4P0A:10 a=Y4RQVEFPAAAA:8 a=C0Fo-xPT4J56Xb4HIDgA:9 a=nMUW6HVNqv1Rqol7:21 a=-cxLhGkVjTUl_8gA:21 a=QEXdDO2ut3YA:10 a=JlNcNiPnxhPThaunNiio:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: aGlnaGxhYkBxLmNvbQ==
Authentication-Results:  smtp01.onyx.dfw.sync.lan smtp.user=highlab@q.com; auth=pass (LOGIN)
Received: from [70.59.37.62] ([70.59.37.62:34698] helo=bifrost)
        by smtp.centurylink.net (envelope-from <seb@highlab.com>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=AES128-GCM-SHA256) 
        id EC/EF-05367-6C65AAB5; Tue, 25 Sep 2018 11:39:51 -0400
Received: from [208.185.63.8] (helo=[10.116.4.235])
        by bifrost with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <seb@highlab.com>)
        id 1g4pRG-0004rb-35; Tue, 25 Sep 2018 09:39:50 -0600
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <fd340f7b-61c0-2661-bdca-c239e51bc464@highlab.com>
 <xmqqefdir0tz.fsf@gitster-ct.c.googlers.com>
From:   Sebastian Kuzminsky <seb@highlab.com>
Message-ID: <dbd2dcef-c892-3628-119e-f688e74f3599@highlab.com>
Date:   Tue, 25 Sep 2018 09:39:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqefdir0tz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 208.185.63.8
X-SA-Exim-Mail-From: seb@highlab.com
Subject: Re: bug in 'git describe'?
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on bifrost)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/18 4:24 PM, Junio C Hamano wrote:
> Sebastian Kuzminsky <seb@highlab.com> writes:
> 
>> I've got two tiny git repos whose commit graphs are identical, but 
>> where 'git describe' gives different results. ... The histories
>> differ only in the timestamps of the commits...
> 
> describe does take the commit timestamps into account, so it is 
> expected you would get different results out of an otherwise 
> identically looking graph.

Thanks for that confirmation.

That behavior seems to me to be different from what the (2.11) manpage says:

> it suffixes the tag name with the number of additional commits on top
> of the tagged object


And:

> If multiple tags were found during the walk then the tag which has
> the fewest commits different from the input commit-ish will be
> selected and output. Here fewest commits different is defined as the
> number of commits which would be shown by git log tag..input will be
> the smallest number of commits possible.

All that said, if you consider this "working as expected" then i'm 
content to let the matter drop.


-- 
Sebastian Kuzminsky
