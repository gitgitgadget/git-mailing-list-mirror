Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F2F1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 14:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbdFJOF6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 10:05:58 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35870 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbdFJOEh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 10:04:37 -0400
Received: by mail-qk0-f194.google.com with SMTP id r62so3032194qkf.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLA/usUUYuZwwbqHW0cuQdfpFsRKKCHTLl4ofhLNDUw=;
        b=QN8RGRn7JTDgI36K9tSAS1QCZS7OB2WBTXg+HnN5ahQq5d3pfnxgdQ3TBdlaxfbjeR
         PuPKFgaz0DeWEH/HxvwNwZ/EAj/kOkAx3W9WywaF1+RR1Na1i2xo0XeVlqNSowAu4WeY
         QHr/+UzfH9mQAldBFmUP36sPwWiv9UqCjJC8urp/MsqeH8MMqrCH8B6DwkBzZG4y7y+m
         WafCyQjakxkNAj/I8Od2ysFNuJicS0e3XMvNWs4sp8GN22fHeGt9sueGSFINLBFbkhua
         J1vBkXGxkwGKUhSY0PugX3aWyZP8p8aD6tQkYAheg2J+lqZArtk/7vuoOa2gEF2ZvPk+
         lj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLA/usUUYuZwwbqHW0cuQdfpFsRKKCHTLl4ofhLNDUw=;
        b=KGekzByk2IzivNnBFeqa6/XR4cJ/j1rk6ZXCLbxx+lrDPMs8qE1v05jj0t39Fs/XfZ
         0DhCW7ZbIT5MvTWJoE9qjJlwWbvoissaG7ikGYA42GFg0ELrguQniEXcWd+v5z8mRbAS
         B+ulqoy8LMR6iQffU3a+lIwo1GHe/9ZUufGuSTT60PT1yfLoUVtk3gGTDoHxq2A/N5XD
         5r0TMqZdGR/okZlQHyxX2+mq2owDiGGh8GIJ+gN9NoUt3r6PUXwcOeZLz1JknxlSipPm
         wlLJf6k41ypQUwN3kCwi+1fw+sTkNqotv7IJ5jBBdrAjYQlBpfi+P0xuwsbRtL8ZDyxe
         KDqA==
X-Gm-Message-State: AKS2vOz4yXC/W16YYFotEmlUOCFWjIhYVN+6wz/J4vs/TNIF1tetFb9Z
        iYF1Kj6oVHl8JngqV6o=
X-Received: by 10.55.73.88 with SMTP id w85mr22331433qka.126.1497103471030;
        Sat, 10 Jun 2017 07:04:31 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o49sm2882232qta.34.2017.06.10.07.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jun 2017 07:04:30 -0700 (PDT)
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170610134026.104552-8-benpeart@microsoft.com>
Message-ID: <5d0d07a8-c47c-e596-5ea2-4ca1e041f77a@gmail.com>
Date:   Sat, 10 Jun 2017 10:04:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170610134026.104552-8-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some perf test results for repos of various size generated with 
many-files.sh.

Comparing cold fs cache times on a fast SSD running Windows:

# files		preloadindex	fsmonitor	reduction
=========================================================
10,000		0.69		0.46		33%
100,000		3.75		0.7		81%
1,000,000	35.07		3.24		91%



10,000 files
GIT_PERF_REPEAT_COUNT=1 
GIT_PERF_LARGE_REPO=/c/Repos/gen-many-files-3.10.9.git/ ./run 
p7519-fsmonitor.sh
Test                                                              this tree
---------------------------------------------------------------------------------
7519.3: status (fsmonitor=false, cold fs cache) 
0.69(0.03+0.06)
7519.4: status (fsmonitor=false, warm fs cache) 
0.45(0.01+0.06)
7519.6: status -uno (fsmonitor=false, cold fs cache) 
0.53(0.03+0.04)
7519.8: status -uall (fsmonitor=false, cold fs cache) 
0.57(0.04+0.01)
7519.11: status (fsmonitor=true, cold fs cache, cold fsmonitor) 
2.16(0.01+0.06)
7519.12: status (fsmonitor=true, warm fs cache, warm fsmonitor) 
0.36(0.01+0.07)
7519.14: status (fsmonitor=true, cold fs cache, warm fsmonitor) 
0.46(0.04+0.06)
7519.16: status -uno (fsmonitor=true, cold fs cache) 
0.46(0.03+0.04)
7519.18: status -uall (fsmonitor=true, cold fs cache) 
0.76(0.04+0.04)

100,000 files
GIT_PERF_REPEAT_COUNT=1 
GIT_PERF_LARGE_REPO=/c/Repos/gen-many-files-4.10.9.git/ ./run 
p7519-fsmonitor.sh
Test                                                              this tree
----------------------------------------------------------------------------------
7519.3: status (fsmonitor=false, cold fs cache) 
3.75(0.01+0.04)
7519.4: status (fsmonitor=false, warm fs cache) 
2.74(0.06+0.06)
7519.6: status -uno (fsmonitor=false, cold fs cache) 
2.88(0.01+0.06)
7519.8: status -uall (fsmonitor=false, cold fs cache) 
3.24(0.00+0.06)
7519.11: status (fsmonitor=true, cold fs cache, cold fsmonitor) 
17.90(0.00+0.10)
7519.12: status (fsmonitor=true, warm fs cache, warm fsmonitor) 
0.59(0.00+0.09)
7519.14: status (fsmonitor=true, cold fs cache, warm fsmonitor) 
0.70(0.00+0.07)
7519.16: status -uno (fsmonitor=true, cold fs cache) 
0.69(0.01+0.01)
7519.18: status -uall (fsmonitor=true, cold fs cache) 
4.51(0.00+0.06)

1,000,000 files
GIT_PERF_REPEAT_COUNT=1 
GIT_PERF_LARGE_REPO=/c/Repos/gen-many-files-5.10.9.git/ ./run 
p7519-fsmonitor.sh
Test                                                              this tree
-----------------------------------------------------------------------------------
7519.3: status (fsmonitor=false, cold fs cache) 
35.07(0.01+0.03)
7519.4: status (fsmonitor=false, warm fs cache) 
26.58(0.03+0.07)
7519.6: status -uno (fsmonitor=false, cold fs cache) 
26.46(0.03+0.06)
7519.8: status -uall (fsmonitor=false, cold fs cache) 
31.55(0.01+0.03)
7519.11: status (fsmonitor=true, cold fs cache, cold fsmonitor) 
193.15(0.01+0.04)
7519.12: status (fsmonitor=true, warm fs cache, warm fsmonitor) 
3.03(0.01+0.07)
7519.14: status (fsmonitor=true, cold fs cache, warm fsmonitor) 
3.24(0.01+0.04)
7519.16: status -uno (fsmonitor=true, cold fs cache) 
2.99(0.03+0.03)
7519.18: status -uall (fsmonitor=true, cold fs cache) 
35.07(0.03+0.07)


On 6/10/2017 9:40 AM, Ben Peart wrote:
> Add a test utility (test-drop-caches) that enables dropping the file
> system cache on Windows.
> 
> Add a perf test (p7519-fsmonitor.sh) for fsmonitor.
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   Makefile                    |   1 +
>   t/helper/test-drop-caches.c | 107 +++++++++++++++++++++++++++++
>   t/perf/p7519-fsmonitor.sh   | 161 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 269 insertions(+)
>   create mode 100644 t/helper/test-drop-caches.c
>   create mode 100755 t/perf/p7519-fsmonitor.sh
> 
> diff --git a/Makefile b/Makefile
> index 992dd58801..893947839f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -648,6 +648,7 @@ TEST_PROGRAMS_NEED_X += test-subprocess
>   TEST_PROGRAMS_NEED_X += test-svn-fe
>   TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
>   TEST_PROGRAMS_NEED_X += test-wildmatch
> +TEST_PROGRAMS_NEED_X += test-drop-caches
>   
>   TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
>   
> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
> new file mode 100644
> index 0000000000..80830d920b
> --- /dev/null
> +++ b/t/helper/test-drop-caches.c
> @@ -0,0 +1,107 @@
> +#include "git-compat-util.h"
> +#include <stdio.h>
> +
> +typedef DWORD NTSTATUS;
> +
> +#ifdef GIT_WINDOWS_NATIVE
> +#include <tchar.h>
> +
> +#define STATUS_SUCCESS			(0x00000000L)
> +#define STATUS_PRIVILEGE_NOT_HELD	(0xC0000061L)
> +
> +typedef enum _SYSTEM_INFORMATION_CLASS {
> +	SystemMemoryListInformation = 80, // 80, q: SYSTEM_MEMORY_LIST_INFORMATION; s: SYSTEM_MEMORY_LIST_COMMAND (requires SeProfileSingleProcessPrivilege)
> +} SYSTEM_INFORMATION_CLASS;
> +
> +// private
> +typedef enum _SYSTEM_MEMORY_LIST_COMMAND
> +{
> +	MemoryCaptureAccessedBits,
> +	MemoryCaptureAndResetAccessedBits,
> +	MemoryEmptyWorkingSets,
> +	MemoryFlushModifiedList,
> +	MemoryPurgeStandbyList,
> +	MemoryPurgeLowPriorityStandbyList,
> +	MemoryCommandMax
> +} SYSTEM_MEMORY_LIST_COMMAND;
> +
> +BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
> +{
> +	BOOL bResult;
> +	DWORD dwBufferLength;
> +	LUID luid;
> +	TOKEN_PRIVILEGES tpPreviousState;
> +	TOKEN_PRIVILEGES tpNewState;
> +
> +	dwBufferLength = 16;
> +	bResult = LookupPrivilegeValueA(0, lpName, &luid);
> +	if (bResult)
> +	{
> +		tpNewState.PrivilegeCount = 1;
> +		tpNewState.Privileges[0].Luid = luid;
> +		tpNewState.Privileges[0].Attributes = 0;
> +		bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpNewState, (DWORD)((LPBYTE)&(tpNewState.Privileges[1]) - (LPBYTE)&tpNewState), &tpPreviousState, &dwBufferLength);
> +		if (bResult)
> +		{
> +			tpPreviousState.PrivilegeCount = 1;
> +			tpPreviousState.Privileges[0].Luid = luid;
> +			tpPreviousState.Privileges[0].Attributes = flags != 0 ? 2 : 0;
> +			bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpPreviousState, dwBufferLength, 0, 0);
> +		}
> +	}
> +	return bResult;
> +}
> +#endif
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	NTSTATUS status = 1;
> +#ifdef GIT_WINDOWS_NATIVE
> +	HANDLE hProcess = GetCurrentProcess();
> +	HANDLE hToken;
> +	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
> +	{
> +		_ftprintf(stderr, _T("Can't open current process token\n"));
> +		return 1;
> +	}
> +
> +	if (!GetPrivilege(hToken, "SeProfileSingleProcessPrivilege", 1))
> +	{
> +		_ftprintf(stderr, _T("Can't get SeProfileSingleProcessPrivilege\n"));
> +		return 1;
> +	}
> +
> +	CloseHandle(hToken);
> +
> +	HMODULE ntdll = LoadLibrary(_T("ntdll.dll"));
> +	if (!ntdll)
> +	{
> +		_ftprintf(stderr, _T("Can't load ntdll.dll, wrong Windows version?\n"));
> +		return 1;
> +	}
> +
> +	NTSTATUS(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) = (NTSTATUS(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
> +	if (!NtSetSystemInformation)
> +	{
> +		_ftprintf(stderr, _T("Can't get function addresses, wrong Windows version?\n"));
> +		return 1;
> +	}
> +
> +	SYSTEM_MEMORY_LIST_COMMAND command = MemoryPurgeStandbyList;
> +	status = NtSetSystemInformation(
> +		SystemMemoryListInformation,
> +		&command,
> +		sizeof(SYSTEM_MEMORY_LIST_COMMAND)
> +	);
> +	if (status == STATUS_PRIVILEGE_NOT_HELD)
> +	{
> +		_ftprintf(stderr, _T("Insufficient privileges to execute the memory list command"));
> +	}
> +	else if (status != STATUS_SUCCESS)
> +	{
> +		_ftprintf(stderr, _T("Unable to execute the memory list command %lX"), status);
> +	}
> +#endif
> +
> +	return status;
> +}
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> new file mode 100755
> index 0000000000..e41905cb9b
> --- /dev/null
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -0,0 +1,161 @@
> +#!/bin/sh
> +
> +test_description="Test core.fsmonitor"
> +
> +. ./perf-lib.sh
> +
> +# This has to be run with GIT_PERF_REPEAT_COUNT=1 to generate valid results.
> +# Otherwise the caching that happens for the nth run will negate the validity
> +# of the comparisons.
> +if [ "$GIT_PERF_REPEAT_COUNT" -ne 1 ]
> +then
> +	echo "warning: This test must be run with GIT_PERF_REPEAT_COUNT=1 to generate valid results." >&2
> +	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
> +	GIT_PERF_REPEAT_COUNT=1
> +fi
> +
> +test_perf_large_repo
> +test_checkout_worktree
> +
> +# Convert unix style paths to what Watchman expects
> +case "$(uname -s)" in
> +MINGW*|MSYS_NT*)
> +  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,/,g')"
> +  ;;
> +*)
> +  GIT_WORK_TREE="$PWD"
> +  ;;
> +esac
> +
> +# The big win for using fsmonitor is the elimination of the need to scan
> +# the working directory looking for changed files and untracked files. If
> +# the file information is all cached in RAM, the benefits are reduced.
> +
> +flush_disk_cache () {
> +	case "$(uname -s)" in
> +	MINGW*|MSYS_NT*)
> +	  sync && test-drop-caches
> +	  ;;
> +	*)
> +	  sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
> +	  ;;
> +	esac
> +
> +}
> +
> +test_lazy_prereq UNTRACKED_CACHE '
> +	{ git update-index --test-untracked-cache; ret=$?; } &&
> +	test $ret -ne 1
> +'
> +
> +test_expect_success "setup" '
> +	# Maybe set untrackedCache & splitIndex depending on the environment
> +	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
> +	then
> +		git config core.untrackedCache "$GIT_PERF_7519_UNTRACKED_CACHE"
> +	else
> +		if test_have_prereq UNTRACKED_CACHE
> +		then
> +			git config core.untrackedCache true
> +		else
> +			git config core.untrackedCache false
> +		fi
> +	fi &&
> +
> +	if test -n "$GIT_PERF_7519_SPLIT_INDEX"
> +	then
> +		git config core.splitIndex "$GIT_PERF_7519_SPLIT_INDEX"
> +	fi &&
> +
> +	# Hook scaffolding
> +	mkdir .git/hooks &&
> +	cp ../../../templates/hooks--query-fsmonitor.sample .git/hooks/query-fsmonitor &&
> +
> +	# have Watchman monitor the test folder
> +	watchman watch "$GIT_WORK_TREE" &&
> +	watchman watch-list | grep -q -F "$GIT_WORK_TREE"
> +'
> +
> +# Worst case without fsmonitor
> +test_expect_success "clear fs cache" '
> +	git config core.fsmonitor false &&
> +	flush_disk_cache
> +'
> +test_perf "status (fsmonitor=false, cold fs cache)" '
> +	git status
> +'
> +
> +# Best case without fsmonitor
> +test_perf "status (fsmonitor=false, warm fs cache)" '
> +	git status
> +'
> +
> +# Let's see if -uno & -uall make any difference
> +test_expect_success "clear fs cache" '
> +	flush_disk_cache
> +'
> +test_perf "status -uno (fsmonitor=false, cold fs cache)" '
> +	git status -uno
> +'
> +
> +test_expect_success "clear fs cache" '
> +	flush_disk_cache
> +'
> +test_perf "status -uall (fsmonitor=false, cold fs cache)" '
> +	git status -uall
> +'
> +
> +# The first run with core.fsmonitor=true has to do a normal scan and write
> +# out the index extension.
> +test_expect_success "populate extension" '
> +	# core.preloadIndex defeats the benefits of core.fsMonitor as it
> +	# calls lstat for the index entries. Turn it off as _not_ doing
> +	# the work is faster than doing the work across multiple threads.
> +	git config core.fsmonitor true &&
> +	git config core.preloadIndex false &&
> +	git status
> +'
> +
> +# Worst case with fsmonitor
> +test_expect_success "shutdown fsmonitor, clear fs cache" '
> +	watchman shutdown-server &&
> +	flush_disk_cache
> +'
> +test_perf "status (fsmonitor=true, cold fs cache, cold fsmonitor)" '
> +	git status
> +'
> +
> +# Best case with fsmonitor
> +test_perf "status (fsmonitor=true, warm fs cache, warm fsmonitor)" '
> +	git status
> +'
> +
> +# Best improved with fsmonitor (compare to worst case without fsmonitor)
> +test_expect_success "clear fs cache" '
> +	flush_disk_cache
> +'
> +test_perf "status (fsmonitor=true, cold fs cache, warm fsmonitor)" '
> +	git status
> +'
> +
> +# Let's see if -uno & -uall make any difference
> +test_expect_success "clear fs cache" '
> +	flush_disk_cache
> +'
> +test_perf "status -uno (fsmonitor=true, cold fs cache)" '
> +	git status -uno
> +'
> +
> +test_expect_success "clear fs cache" '
> +	flush_disk_cache
> +'
> +test_perf "status -uall (fsmonitor=true, cold fs cache)" '
> +	git status -uall
> +'
> +
> +test_expect_success "cleanup" '
> +	watchman watch-del "$GIT_WORK_TREE" &&
> +	watchman shutdown-server
> +'
> +
> +test_done
> 
