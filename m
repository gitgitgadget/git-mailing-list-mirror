Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2721F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfACVWO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:22:14 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:10722 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfACVWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 16:22:14 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 16:22:13 EST
Received: from [192.168.1.12] ([92.29.14.220])
        by smtp.talktalk.net with SMTP
        id fAJXguEFOdJAefAJXgtiVW; Thu, 03 Jan 2019 21:14:05 +0000
X-Originating-IP: [92.29.14.220]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=iGBlNkCVnKJDjRvOkgwXUw==:117
 a=iGBlNkCVnKJDjRvOkgwXUw==:17 a=IkcTkHD0fZMA:10 a=r73MmyOISDTR41KxDtEA:9
 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
To:     Junio C Hamano <gitster@pobox.com>,
        "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20181231003150.8031-4-ischis2@cox.net>
 <xmqqva37j595.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <a5412274-028f-3662-e4f5-dbbcad4d9a40@iee.org>
Date:   Thu, 3 Jan 2019 21:14:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqva37j595.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfHPiVvUf5MsRLHXr2tzsuamwkG784f+Qumzp0sxIhYgTJhswPBguKuXYf6U1sXBxZlGDrV8+EN4O7xW143HZWwFjOkUkNwP19NFFg4rLm4ESfhbr/Twm
 9M3bwXRa1UyNeP3p7b7dVJrGR0jIVMNXDdnJVsyQKQBeXU5xOiqNTBXJFSYR4LVASC+GdKslRaGYskhzHHitQnak3OiZHZwIfftMOvV22pj/kdfNXm7gcJYC
 7No/a2ZgTHpMzIO4abz450ykTZF/yFRKWP5XHvL4BBbJGiKbqsDPbfYWUt7UjhzM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/01/2019 18:15, Junio C Hamano wrote:
> We perhaps can use "test-tool date timestamp", like so
>
> 	check_human_date $(test-tool date timestamp "18000 seconds ago") ...
>
> or moving the part that munges 18000 into the above form inside
> check_human_date helper function, e.g.
>
> 	check_human_date () {
> 		commit_date=$(test-tool date timestamp "$1 seconds ago")
> 		commit_date="$commit_date +0200"
>                  expect=$2
> 		...
> 	}
>
> which would let us write
>
> 	check_human_date 432000" $THIS_YEAR_REGEX  # 5 days ago


Just a quick bikeshed: if used, would this have a year end 5 day 
roll-over error potential, or will it always use the single date?

(I appreciate it is just suggestion code, not tested)

-- 

Philip

