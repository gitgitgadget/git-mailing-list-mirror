Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DBD31F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeJZFjQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 01:39:16 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:39104 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeJZFjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 01:39:16 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42h04p2Cksz5tmn;
        Thu, 25 Oct 2018 23:04:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 19EAC256;
        Thu, 25 Oct 2018 23:04:58 +0200 (CEST)
Subject: Re: [PATCH sg/test-rebase-editor-fix] t3404-rebase-interactive: test
 abbreviated commands
From:   Johannes Sixt <j6t@kdbg.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <94c0b5b6-ac31-101b-80a0-ac78196e0f62@kdbg.org>
Message-ID: <df45cad7-0290-f308-5463-e79cdd0ebea8@kdbg.org>
Date:   Thu, 25 Oct 2018 23:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <94c0b5b6-ac31-101b-80a0-ac78196e0f62@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.18 um 22:54 schrieb Johannes Sixt:
> Test each short command at least once. The commands changed here
> are chosen such that
> 
> - tests do not have a prerequisite,
> - the 'git rebase' command is not guarded by test_must_fail.
> 
> The pick commands are optional noise words in the FAKE_LINES
> variable. Test them, too.

Actually, this sentence should better be:

The pick commands are optional in the FAKE_LINES variable, but
when used, they do end up in the insn sheet. Test them, too.

> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
...
> @@ -732,7 +732,7 @@ test_expect_success 'reword' '
>   	git show HEAD^ | grep "D changed" &&
>   	FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" git rebase -i A &&
>   	git show HEAD~3 | grep "B changed" &&
> -	FAKE_LINES="1 reword 2 3 4" FAKE_COMMIT_MESSAGE="C changed" git rebase -i A &&
> +	FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" git rebase -i A &&
>   	git show HEAD~2 | grep "C changed"
>   '
