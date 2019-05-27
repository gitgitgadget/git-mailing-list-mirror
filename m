Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825671F462
	for <e@80x24.org>; Mon, 27 May 2019 20:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfE0UWo (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 16:22:44 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:45320 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfE0UWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 16:22:43 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id VM8mhGS0SnuQZVM8nhHmwB; Mon, 27 May 2019 21:22:41 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aulWLQ49AAAA:20 a=uPZiAMpXAAAA:8 a=anyJmfQTAAAA:8
 a=272ucciLAAAA:20 a=ncthPEse3oiWa_h6qGwA:9 a=QEXdDO2ut3YA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Subject: Re: git filter-branch re-write history over a range of commits did
 notwork
To:     Johannes Sixt <j6t@kdbg.org>, LU Chuck <Chuck.LU@edenred.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <75618ca1-748d-0761-9108-c7deac63cb53@iee.org>
Date:   Mon, 27 May 2019 21:22:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfLUhoWQBWYQnfejCV3d2x1YPj8Z8Y2mF6XMkX5t45kPWsPbB0qlxhAJmxUfCmohlvXwkqv5cAGuc6kXwZ6S3C3ghMe5fvhCwPcHaGTcHigWcotYlJnTz
 43jbfnO0CXK2NhLOi9AU8HKow8N4hCHDYFQ0h0UUGXGDReINWpLyrsCAQXBhvEI6/+TMDthBEbBFu13xKJgrRVmfZdDzunfNb+yGTHBxrMhGFXgyaAKy8hHZ
 6Iw67eWS23qXTwYOSgjR5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chuck,

On 27/05/2019 19:21, Johannes Sixt wrote:
> Am 27.05.19 um 10:01 schrieb LU Chuck:
>> Hi team,
>>
>>      The issue comes from https://github.com/git-for-windows/git/issues/2206.
>>
>>      I want to re-write history by filter-branch command over a range of commits, but the command did not work.
>>      I have referred to the following three documentation about how to use git filter-branch:
>>      https://stackoverflow.com/questions/15250070/running-filter-branch-over-a-range-of-commits
>>      https://stackoverflow.com/questions/28536980/git-change-commit-date-to-author-date
>>      https://git-scm.com/docs/git-filter-branch
>>
>>      You can reproduce the problem by the following steps
>>      1. clone the repository https://github.com/chucklu/LeetCode/
>>      2. checkout to the temp branch
>>      3. run the command git filter-branch --env-filter 'export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"' ... 67d9d9..f70bf4
> Did you not tell us everything because you write ... in this message
> when you cited the command you used, or do you say that you used ...
> literally in the command?

The three dots is provided in the literal EXAMPLES section of the man 
page. That is probably an error, as I think it is meant to be an 
ellipsis to indicate 'insert other options here'.

Simply remove the three dots ('symmetric diff notation') .

Not sure what the correct change to the man page should be, but clearly 
it has caused confusion. It also takes a moment to properly realise 
which commits the two dot notation will refer to in the example which 
may further compound the confusion about the three dots.

Philip
>
>>      4. You will got the info "Found nothing to rewrite"
>>   
>>      However, it was supposed to overwrite the history from commit 9c1580 to commit f70bf4, make the commit date same as date.
>>      I am not sure if I am using the filter-branch correctly, or if there is a bug in git?
>>
>>      Anyone can help me? Thanks in advance.
> -- Hannes

