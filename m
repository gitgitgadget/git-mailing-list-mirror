Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68121C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C3F61438
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhEMHuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:50:21 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:9384 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhEMHuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:50:17 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4FgkLp0zSWz5tlG;
        Thu, 13 May 2021 09:49:06 +0200 (CEST)
Subject: Re: Git pathspecs difference in behavior between linux (wsl) and
 windows
To:     Alexandre Remy <alexandre.remy.contact@gmail.com>
References: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org>
Date:   Thu, 13 May 2021 09:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.05.21 um 08:57 schrieb Alexandre Remy:
> Hi,
> 
> I do not understand why the same command works on linux and not on
> windows. Is the pathspecs syntax differ or there is a problem on the
> git windows version?
> 
> * On windows (git version 2.31.1.windows.1)
> 
> git status -- 'src/test.js'
> On branch master
> nothing to commit, working tree clean
> 
> 
> * On linux (wsl: git version 2.25.1)
> 
> git status -- 'src/test.js'
> On branch master
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
>         modified:   src/test.js
> A classic git status gives the same result between linux and windows
> (with correct file detected).

Which shell did you use to invoke the Windows version? If it was from
CMD or PowerShell, then you must not put the name in single-quotes:

   git status -- src/test.js

The reason is that the single-quote does not have a special meaning for
CMD and PowerShell like it does for a POSIX shell.

-- Hannes
