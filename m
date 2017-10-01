Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D2420A10
	for <e@80x24.org>; Sun,  1 Oct 2017 20:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbdJAU6l (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 16:58:41 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:19161 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdJAU6l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 16:58:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3y4yM25j2rz5tlB;
        Sun,  1 Oct 2017 22:58:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C1FFC211E;
        Sun,  1 Oct 2017 22:58:37 +0200 (CEST)
Subject: Re: what is git's position on "classic" mac <CR>-only end of lines?
To:     Bryan Turner <bturner@atlassian.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1710011349560.23227@localhost.localdomain>
 <CAGyf7-H+1Djb_dmzfOO3qqM9+2VKvbqVedn4mof9Hq4huDTsqw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a8cb7c82-4598-5dce-0e0e-b0f18157cc56@kdbg.org>
Date:   Sun, 1 Oct 2017 22:58:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGyf7-H+1Djb_dmzfOO3qqM9+2VKvbqVedn4mof9Hq4huDTsqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.10.2017 um 21:29 schrieb Bryan Turner:
> On Sun, Oct 1, 2017 at 10:52 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>>
>>    sorry for more pedantic nitpickery, but i'm trying to write a
>> section on how to properly process mixtures of EOLs in git, and when i
>> read "man git-config", everything seems to refer to Mac OS X and macOS
>> (and linux, of course) using <LF> for EOL, with very little mention of
>> what one does if faced with "classic" mac EOL of just <CR>.
> 
>   No command in Git that I'm aware of considers a standalone <CR> to be
> a line ending. A file containing only <CR>s is treated as a single
> line by every Git command I've used. I'm not sure whether that
> behavior is configurable. For files with standalone <CR>s mixed with
> other line endings (<CRLF> or <LF>, either or both), the <CRLF> and
> <LF> endings are both considered line endings while the standalone
> <CR>s are not.

That's true, AFAIK. In addition, when Git auto-detects whether a file is 
binary or text, then a file with a bare CR is treated as binary:

https://github.com/git/git/blob/master/convert.c#L91

That basically amounts to: "it [is] considered not important enough to 
deal with" ;)

-- Hannes
