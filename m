Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A42BC4332F
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiCVS1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiCVS1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:27:02 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917C92D16
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:24:59 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B32AA3F47F4;
        Tue, 22 Mar 2022 14:24:58 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9188C3F4161;
        Tue, 22 Mar 2022 14:24:58 -0400 (EDT)
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv8wcizi4.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <eb10fee5-d6ea-b660-e339-d55a4b669c3c@jeffhostetler.com>
Date:   Tue, 22 Mar 2022 14:24:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqv8wcizi4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/17/22 7:34 AM, Junio C Hamano wrote:
> 
> * jh/builtin-fsmonitor-part-2plus (2022-03-13) 16 commits
>   - fsmonitor-settings: simplify initialization of settings data
>   - fsmonitor--daemon: add _() to calls to error()
>   - fsmonitor--daemon: add _() to calls to die()
>   - compat/fsmonitor/fsm-listen-win32: add _() to calls to error()
>   - compat/fsmonitor/fsm-listen-darwin: add _() to calls to error()
>   - fsmonitor-ipc: add _() to calls to die()
>   - t7527: delete unused verify_status() function
>   - t7527: fix && chaining in matrix_try()
>   - t7527: add parameters to start_daemon to handle args and subshell
>   - t/perf/p7519: cleanup coding style
>   - t/perf/p7519: use grep rather than egrep in test
>   - fsmonitor--daemon: refactor cookie handling for readability
>   - t/helper/fsmonitor-client: cleanup call to parse_options()
>   - compat/fsmonitor/fsm-listen-darwin: split out GCC-specific declarations
>   - update-index: convert advise() messages back to warning()
>   - t/test-lib: avoid using git on LHS of pipe
>   (this branch uses jh/builtin-fsmonitor-part2.)
> 
>   Various small fixes and cleanups on part-2 of the same topic.
> 
>   Needs review.
>   source: <pull.1174.git.1647033303.gitgitgadget@gmail.com>

I have squashed this into part 2 V7, so this series can be
discarded.  Thanks (and sorry for the mess).


> * jh/builtin-fsmonitor-part3 (2022-03-09) 28 commits
>   . fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
>   . t7527: test Unicode NFC/NFD handling on MacOS
>   . t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
>   . fsmonitor: on macOS also emit NFC spelling for NFD pathname
>   . t7527: test FSMonitor on case insensitive+preserving file system
>   . fsmonitor: never set CE_FSMONITOR_VALID on submodules
>   . t/perf/p7527: add perf test for builtin FSMonitor
>   . t7527: FSMonitor tests for directory moves
>   . fsmonitor: optimize processing of directory events
>   . fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
>   . fsm-health-win32: force shutdown daemon if worktree root moves
>   . fsm-health-win32: add polling framework to monitor daemon health
>   . fsmonitor--daemon: stub in health thread
>   . fsmonitor--daemon: rename listener thread related variables
>   . fsmonitor--daemon: prepare for adding health thread
>   . fsmonitor--daemon: cd out of worktree root
>   . fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
>   . unpack-trees: initialize fsmonitor_has_run_once in o->result
>   . fsmonitor-settings: remote repos on Windows are incompatible
>   . fsmonitor-settings: remote repos on macOS are incompatible
>   . fsmonitor-settings: stub in macOS-specific incompatibility checking
>   . fsmonitor-settings: VFS for Git virtual repos are incompatible
>   . fsmonitor-settings: stub in platform-specific incompatibility checking
>   . fsmonitor-settings: bare repos are incompatible with FSMonitor
>   . t/helper/fsmonitor-client: create stress test
>   . t7527: test FSMonitor on repos with Unicode root paths
>   . fsm-listen-win32: handle shortnames
>   . Merge branch 'jh/builtin-fsmonitor-part2' into jh/builtin-fsmonitor-part3
>   (this branch uses jh/builtin-fsmonitor-part2.)
> 
>   More fsmonitor--daemon.
>   source: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>

I just sent a V3 of part 3 that builds upon V7 of part 2.
The fixups from part 2.5 have been squashed in.


> * jh/builtin-fsmonitor-part2 (2022-03-01) 30 commits
>    (merged to 'next' on 2022-03-08 at 5f9d385483)
>   + update-index: convert fsmonitor warnings to advise
>   + t7527: test status with untracked-cache and fsmonitor--daemon
>   + fsmonitor: force update index after large responses
>   + fsmonitor--daemon: use a cookie file to sync with file system
>   + fsmonitor--daemon: periodically truncate list of modified files
>   + t/perf/p7519: add fsmonitor--daemon test cases
>   + t/perf/p7519: speed up test on Windows
>   + t/helper/test-chmtime: skip directories on Windows
>   + t/perf: avoid copying builtin fsmonitor files into test repo
>   + t7527: create test for fsmonitor--daemon
>   + t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>   + help: include fsmonitor--daemon feature flag in version info
>   + fsmonitor--daemon: implement handle_client callback
>   + compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
>   + compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
>   + compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
>   + fsmonitor--daemon: create token-based changed path cache
>   + fsmonitor--daemon: define token-ids
>   + fsmonitor--daemon: add pathname classification
>   + fsmonitor--daemon: implement 'start' command
>   + fsmonitor--daemon: implement 'run' command
>   + compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
>   + compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
>   + fsmonitor--daemon: implement 'stop' and 'status' commands
>   + fsmonitor--daemon: add a built-in fsmonitor daemon
>   + fsmonitor: document builtin fsmonitor
>   + fsmonitor: use IPC to query the builtin FSMonitor daemon
>   + fsmonitor: config settings are repository-specific
>   + fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>   + fsmonitor: enhance existing comments, clarify trivial response handling
>   (this branch is used by jh/builtin-fsmonitor-part-2plus and jh/builtin-fsmonitor-part3.)
> 
>   Built-in fsmonitor (part 2).
> 
>   Discarded to be replaced.
>   cf. <33a9f751-6254-9b3e-6eb7-7844ac664e00@jeffhostetler.com>
>   source: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>

I just sent V7 of part 2.  This has the fixups from 2.5 squashed in.


Jeff
