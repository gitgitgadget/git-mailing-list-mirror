Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C2C1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 16:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbfIEQDc (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 12:03:32 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:36666 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbfIEQDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 12:03:32 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1i5pSp-0002yg-9F; Thu, 05 Sep 2019 12:58:07 +0200
Subject: Re: [PATCH 1/1] reset: support the --stdin option
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.133.git.gitgitgadget@gmail.com>
 <017945a55a64ebe1913d64919b699adb3f9d5d96.1567633109.git.gitgitgadget@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <fd300972-4fe7-54e4-3701-061ab4769c10@syntevo.com>
Date:   Thu, 5 Sep 2019 12:58:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <017945a55a64ebe1913d64919b699adb3f9d5d96.1567633109.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes, thanks for working on this problem!

In the previous discussion, there was a suggestion to change
'--stdin' to '--paths-file', where '--paths-file -' would mean stdin:
https://public-inbox.org/git/066cfd61-9700-e154-042f-fc9cffbd6346@web.de/

I believe that was a good suggestion for a few reasons:
1) Supporting files in addition to stdin sounds reasonable for its cost.
2) '--paths-file' will support files and stdin with the same "interface",
    avoiding the possible need for another interface later.
3) '--paths-file' sounds more self-documented then '--stdin'.

Later, we intend to provide patches to extend the same feature to
multiple other commands, at least {add, checkout, commit, rm, stash},
and I'm merely trying to avoid possible design issues for this
larger-scale change.

If you don't mind the suggestion but not willing to spend time
implementing it, we'd like to step in and contribute the remaining
work.

