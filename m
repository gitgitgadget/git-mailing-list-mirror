Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDE7C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B4B6113B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhINTtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:49:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:55215 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhINTtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:49:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4EF7B3F40FB;
        Tue, 14 Sep 2021 15:47:42 -0400 (EDT)
Received: from jeffhost-mbp.lan (81.sub-174-216-120.myvzw.com [174.216.120.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 103703F40FA;
        Tue, 14 Sep 2021 15:47:41 -0400 (EDT)
Subject: Re: What's cooking in git.git (Sep 2021, #04; Mon, 13)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtuinc3tx.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6fce08a4-876f-62d0-ed4b-05327e452985@jeffhostetler.com>
Date:   Tue, 14 Sep 2021 15:47:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuinc3tx.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/13/21 10:02 PM, Junio C Hamano wrote:
...
> 
> * jh/builtin-fsmonitor (2021-09-03) 37 commits
>   - fixup! fsmonitor--daemon: implement handle_client callback
>   - SQUASH??? https://github.com/git/git/runs/3438543601?check_suite_focus=true#step:5:136
>   - BANDAID: sparse fixes
>   - t7527: test FS event reporing on MacOS WRT case and Unicode
>   - fsmonitor: handle shortname for .git
>   - t7527: test status with untracked-cache and fsmonitor--daemon
>   - fsmonitor: force update index after large responses
>   - fsmonitor: enhance existing comments
>   - fsmonitor--daemon: use a cookie file to sync with file system
>   - fsmonitor--daemon: periodically truncate list of modified files
>   - t7527: create test for fsmonitor--daemon
>   - t/perf/p7519: add fsmonitor--daemon test cases
>   - t/perf: avoid copying builtin fsmonitor files into test repo
>   - t/perf/p7519: speed up test using "test-tool touch"
>   - t/helper/test-touch: add helper to touch a series of files
>   - fsmonitor--daemon: implement handle_client callback
>   - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>   - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>   - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>   - fsmonitor--daemon: create token-based changed path cache
>   - fsmonitor--daemon: define token-ids
>   - fsmonitor--daemon: add pathname classification
>   - fsmonitor: do not try to operate on bare repos
>   - fsmonitor--daemon: implement 'start' command
>   - fsmonitor--daemon: implement 'run' command
>   - fsmonitor-fs-listen-macos: stub in backend for MacOS
>   - fsmonitor-fs-listen-win32: stub in backend for Windows
>   - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>   - fsmonitor--daemon: implement 'stop' and 'status' commands
>   - fsmonitor--daemon: add a built-in fsmonitor daemon
>   - fsmonitor: use IPC to query the builtin FSMonitor daemon
>   - fsmonitor: config settings are repository-specific
>   - help: include fsmonitor--daemon feature flag in version info
>   - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>   - fsmonitor--daemon: update fsmonitor documentation
>   - fsmonitor--daemon: man page
>   - simple-ipc: preparations for supporting binary messages.
> 
>   An attempt to write and ship with a watchman equivalent tailored
>   for our use.
> 
>   Expecting a reroll post 2.33 release.
> 

I have a V4 ready to send to the list.  This addresses the mailing
list feedback from V3 as well as feedback from git-for-windows users
who have been using the experimental preview that we shipped with
V2.32 and V2.33.

Unfortunately, the series now contains 58 commits.  I realize that
this is probably way to big to send in one batch.

Junio, how would you prefer that I submit this?  Would you rather
drop the existing series and have me send 4 or 5 parts (in a fresh
series of gitgitgadget PRs) that could be reviewed in parallel and
just sent to "next" in series.  And then maybe they all wait in
"next" until the last one is ready and all graduate to "master"
together?   Or would you prefer another approach?

Thanks,
Jeff

https://github.com/gitgitgadget/git/pull/923

