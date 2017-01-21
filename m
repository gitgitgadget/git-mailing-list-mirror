Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD66A1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 23:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750938AbdAUXSN (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 18:18:13 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:17333 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbdAUXSM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 18:18:12 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id V4vBceLfg46SJV4vCcflJY; Sat, 21 Jan 2017 23:18:11 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=uPZiAMpXAAAA:8
 a=CI7Vg7dG7XQm4T3drfEA:9 a=QEXdDO2ut3YA:10 a=svzibyHiZmA4t4YY0eFS:22
Message-ID: <7EEBBEA4046743C9AE04AE50EE30D72A@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Git List" <git@vger.kernel.org>,
        "Thomas Braun" <thomas.braun@virtuell-zuhause.de>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <8AED6D90D2B64AE3A63C6195CA983FE8@PhilipOakley> <0bd00cda-65d0-eeba-d8b9-a839e76d8e88@virtuell-zuhause.de>
Subject: Re: Idea: Add a filter option to 'git rebase'
Date:   Sat, 21 Jan 2017 23:18:11 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfLKqmYBvb+UQxawLiUMD3NrO6dYkqx+UaFsXfhQXTLoP/OZhXngYpiS7O006UFM50M1DcCUi6gz+zuCJj2zjklhxYFD66otS2ATdm5W3ZLjaiQTgUC4n
 HyAPKUWoRitiCgSknXCbtOG8EjjgadYLpW13M3dWgrteHR1BVcogyhqJR0kMNxl8YOr+ifnbiS5rykc0JYQ4Q6sDJKl/STRG7DbHAfVe4uUh+FStwHRhk8WM
 qujIoykGLHufdsWQog7GaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Thomas Braun"  Friday, January 20, 2017 11:35 PM
> Am 20.01.2017 um 23:28 schrieb Philip Oakley:
>> A recent question on stackoverflow
>> http://stackoverflow.com/questions/41753252/drop-commits-by-commit-message-in-git-rebase
>> sought to remove automatically commits that could be identified by
>> relevant words in the commit message.
>>
>> I had thought that the ubiquitous `git filter-branch` should be able to
>> do this sort of thing. I was wrong. (It was pointed out to me that...)
>> The man page notes that removing a commit via filter-branch does not
>> remove the changes from following commits and directs readers to using
>> `git rebase(1)`.
>>
>> However the rebase command does not have any filter option to allow the
>> automatic population of its TODO list with the appropriate
>> pick/edit/drop/etc. values.
>
> Well you can use an arbitrary shell command as editor, so something like
>
> $ GIT_SEQUENCE_EDITOR="sed -i -re 's/^pick /edit /'" git rebase -i master
>
> will change pick to edit of all commits.
>
> Maybe that can be mentioned in the man page of rebase?
>

I had been more thinking of a process that passed single sha1's to the 
filter on each pass through the rebase list, so that the coding was simpler, 
plus the --interactive could be used, if required, for final refinement 
(gitk being handy for that).

However, a mention in the man pages would be zero code cost, and could help.

--

Philip 

