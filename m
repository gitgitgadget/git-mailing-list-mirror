Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB192141C
	for <e@80x24.org>; Mon, 11 Feb 2019 23:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfBKXT7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:19:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56095 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfBKXT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:19:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so977548wmh.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/rb05sGTkyf/dL8n2dnAj3rKSYJmllvk2YBGoy1l0BY=;
        b=FJZs+xivfTla80bsiJHNIvA0W1qiIhiBZkfnwwd9dKYKL8ZXnCuC2/5pHSntB3GeV6
         /GjrcUatLED1deL4b8U0BmEFy4Mt48BMswA/8640uDjQCCmG8WheE9mVTWXfwCQJ+eRj
         MeoMTojHNwkO6eKbv5DdSUy6Of3FQfx0LJ9Cqgio+t509ni6amK8toFyko7EZGGJlL98
         MNwMRFVQUT4UzVLCDTwdlkoDD8VmHWe7NO0T85WpKFkLeUNwbPuVQA98vJFt8avU0rQ2
         EKXcn6iX2dikibbkAol1brc4m9njaY6t9OebjOpNOuG3s6CZeMOvP4a08QYmzunXg74Z
         k2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/rb05sGTkyf/dL8n2dnAj3rKSYJmllvk2YBGoy1l0BY=;
        b=CasVh9eonxWGb7dj1H9h+HMAdUaT/JxRb7e2Ng+28Uqf8RoNZpxsFUlUy39GERpFcI
         SoZ33gANABgLevGEN5mB2AjgHr08vZP/un+2satvRdWEj9iPYhbhLLYy7UJzwLa2+2yD
         16WmUSxTFwna7NGt4ZVUQFaqHWGyqvpEmJEh+BHXiu1lZzq8TSJinDUip/PECFRa5zUs
         ZMsqH6bz/mbs14LYBjasS5Joimtfc7OTL2tQerp/vRPwr3t5zjikB6XbQvCBOJosyWL1
         593E90U+nyG2fl/2w0b/dVsu8RA8P4hwQZujRuSBQwrkqy0QVxKNA95YJfODt/ZNG4rv
         ID6g==
X-Gm-Message-State: AHQUAubmgIUnIHApHqPlKWhTXhFao7cP3Yn4MSWtSUS9ECKKJp8O4ES0
        SZ4Zh0apdi6zZEBTokoObjQ=
X-Google-Smtp-Source: AHgI3IawytIKCduWu4nRS0IL6GY9H5SHtmUUT0YZS4FVonwYozzcSk0sZMRfbgVdUlSLw8EZNPu6eQ==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr474084wmh.126.1549927196034;
        Mon, 11 Feb 2019 15:19:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a12sm21829086wro.18.2019.02.11.15.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 15:19:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/1] fixup! trace2: collect Windows-specific process information
References: <pull.123.git.gitgitgadget@gmail.com>
        <6af9ad6fbbd9ebeb4077ad2167e4e60674b1df75.1549912358.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Feb 2019 15:19:53 -0800
In-Reply-To: <6af9ad6fbbd9ebeb4077ad2167e4e60674b1df75.1549912358.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 11 Feb 2019
        11:12:40 -0800 (PST)")
Message-ID: <xmqqy36lgbfq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Guard against infinite loop while computing the parent process hierarchy.
>
> CreateToolhelp32Snapshot() is used to get a list of all processes on the
> system.  Each process entry contains the process PID and PPID (alive at the
> time of the snapshot).  We compute the set of ancestors of the current process
> by repeated searches on this list.
>
> Testing revealed that the snapshot can contain PPID cycles.  This causes an
> infinite loop during the set construction and causes the git.exe command to
> hang.
>
> Testing found an instance where 3 processes were in a PPID cycle.  The
> snapshot implied that each of these processes was its own great-grandparent.
> This should not be possible unless a PID was recycled and just happened to
> match up.
>
> For full disclosure, the Windows "System Idle Process" has PID and PPID 0.
> If it were to launch a Git command, it could cause a similar infinite loop.
> Or more properly, if any ancestor of the current Git command has PPID 0, it
> will appear to be a descendant of the idle process and trigger the problem.
>
> This commit fixes both cases by maintaining a list of the PIDs seen during
> the ancestor walk and stopping if a cycle is detected.
>
> Additionally, code was added to truncate the search after a reasonable fixed
> depth limit.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  compat/win32/trace2_win32_process_info.c | 32 ++++++++++++++++++------
>  1 file changed, 25 insertions(+), 7 deletions(-)

Thanks.  Will queue for now, but shortly after the final, I expect
the whole topic to be eligible to graduate to the 'master' track.
At that point, you may want to help rephrase the log message of the
original when this gets squashed in.  Alternatively, we could leave
these two separate patches.


>
> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
> index 253199f812..751b366470 100644
> --- a/compat/win32/trace2_win32_process_info.c
> +++ b/compat/win32/trace2_win32_process_info.c
> @@ -3,6 +3,8 @@
>  #include <Psapi.h>
>  #include <tlHelp32.h>
>  
> +#define NR_PIDS_LIMIT 42
> +

;-)  

Any backstory about the choice of this number we want to share with
our future selves?

>  /*
>   * Find the process data for the given PID in the given snapshot
>   * and update the PROCESSENTRY32 data.
> @@ -21,13 +23,17 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
>  }
>  
>  /*
> - * Accumulate JSON array:
> + * Accumulate JSON array of our parent processes:
>   *     [
>   *         exe-name-parent,
>   *         exe-name-grand-parent,
>   *         ...
>   *     ]
>   *
> + * We artificially limit this to NR_PIDS_LIMIT to quickly guard against cycles
> + * in the parent PIDs without a lot of fuss and because we just want some
> + * context and don't need an absolute answer.
> + *
>   * Note: we only report the filename of the process executable; the
>   *       only way to get its full pathname is to use OpenProcess()
>   *       and GetModuleFileNameEx() or QueryfullProcessImageName()
> @@ -38,16 +44,28 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
>  {
>  	PROCESSENTRY32 pe32;
>  	DWORD pid;
> +	DWORD pid_list[NR_PIDS_LIMIT];
> +	int k, nr_pids = 0;
>  
>  	pid = GetCurrentProcessId();
> +	while (find_pid(pid, hSnapshot, &pe32)) {
> +		/* Only report parents. Omit self from the JSON output. */
> +		if (nr_pids)
> +			jw_array_string(jw, pe32.szExeFile);
>  
> -	/* We only want parent processes, so skip self. */
> -	if (!find_pid(pid, hSnapshot, &pe32))
> -		return;
> -	pid = pe32.th32ParentProcessID;
> +		/* Check for cycle in snapshot. (Yes, it happened.) */
> +		for (k = 0; k < nr_pids; k++)
> +			if (pid == pid_list[k]) {
> +				jw_array_string(jw, "(cycle)");
> +				return;
> +			}
>  
> -	while (find_pid(pid, hSnapshot, &pe32)) {
> -		jw_array_string(jw, pe32.szExeFile);
> +		if (nr_pids == NR_PIDS_LIMIT) {
> +			jw_array_string(jw, "(truncated)");
> +			return;
> +		}
> +
> +		pid_list[nr_pids++] = pid;
>  
>  		pid = pe32.th32ParentProcessID;
>  	}
