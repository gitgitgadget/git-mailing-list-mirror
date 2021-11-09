Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1114C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0233610FF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbhKIS4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:56:41 -0500
Received: from avasout-ptp-004.plus.net ([84.93.230.250]:42069 "EHLO
        avasout-ptp-004.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbhKIS4k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 13:56:40 -0500
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id kWFXmIU3m4GJ1kWFYmyaCN; Tue, 09 Nov 2021 18:53:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1636484032; bh=+XQHOrxbRQM1b5LjM8j9F05kwA7bRIM1VSAnN+Zxxww=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LuDp1c/8HnBzISbxDZ0e4mouNtuJBFDAy7QrPELvxSlzyo55/d4ZG9ia8pmBvmyNF
         +Tq33qkrh+9KXu+Y1qP7H7UNNY2gy677A0WlxUe4zW7h06IlicHsaDiaTyjRiBW4XH
         8AHXfiVWHnsQ1ZpkdHQO+j99po8Jmtk53KHmMy9ggBnBZ2L+ZtsjBewl2sCAzDEDGj
         14oMbudc7cCmkar+pusyjwG/ggJGwKLv54Mk8X9l/OdmbQ4jko0kq1FMNjEeSj1RCY
         At63LPr4V1UfzAtsb1sS9tJrZ/duvac4EV9LufS4xhXmpd+fbSf6/FLNbXRWv8svzZ
         pXLkcWUynj87Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=fsi/2H0f c=1 sm=1 tr=0 ts=618ac3c0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=bjnRR2OyqKr6h4M0H9gA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org>
 <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
Date:   Tue, 9 Nov 2021 18:53:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMM39Qg0j8spLaElfdB7qK0E4IX9FAQCYXpld56+o80AbmOpBrwMvo4nqO31XMio2Xui8+bgHufiR0AgVvIaO2M/tvyP9EvDNHEFvAwU7b2+BN9R2xfa
 MHuxLdRJB/8HtVWrO8UfQ6hP5Ugik4f7lsSrm+4KCu25GiwSlfIBBfuZnHSdSq6JSm8rCwTgSI4w/qJlv5NkiHKXFHimsJm5uIg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/11/2021 23:59, Johannes Schindelin wrote:
[snip]
> I had a look at this and could reproduce... partially. I only managed to
> make it fail every once in a while.
> 
> Digging deeper, it turns out that the `lstat()` call in
> `ipc_get_active_state()` does not receive an `st_mode` indicating a
> socket, but rather a file (in my tests, it was usually 0100644, but
> sometimes even 0100755).
> 
> The reason is, of course, that Cygwin _emulates_ Unix sockets. What is in
> the file system is just a special file, it is marked with the `system` bit
> (which only exists on Windows), and its contents start with the tell-tale
> `!<socket>`.
> 
> And as you might have guessed, there is a race going on between Cygwin
> writing that file _and_ flipping that `system` bit, and Git trying to
> access the Unix socket and encountering an unexpected file.
> 
> Now, why this only happens in your 32-bit setup, I have no idea.
> 
> In my tests, the following patch works around the issue. Could I ask you
> to test it in your environment?

Just FYI, I just tried the patch below (on 64-bit cygwin) and this test
now works fine for me. (well, run 5 times by hand - not with --stress).

This is on windows 10 21H1 and cygwin:

  $ uname -a
  CYGWIN_NT-10.0 satellite 3.3.2(0.341/5/3) 2021-11-08 16:55 x86_64 Cygwin
  $ 

[Yes, I updated last night!]

ATB,
Ramsay Jones

> -- snip --
> diff --git a/compat/simple-ipc/ipc-unix-socket.c
> b/compat/simple-ipc/ipc-unix-socket.c
> index 4e28857a0a..1c591b2adf 100644
> --- a/compat/simple-ipc/ipc-unix-socket.c
> +++ b/compat/simple-ipc/ipc-unix-socket.c
> @@ -36,6 +36,23 @@ enum ipc_active_state ipc_get_active_state(const char
> *path)
>  	}
> 
>  	/* also complain if a plain file is in the way */
> +#ifdef __CYGWIN__
> +	{
> +		static const int delay[] = { 1, 10, 20, 40, -1 };
> +		int i;
> +
> +		for (i = 0; S_ISREG(st.st_mode) && delay[i] > 0; i++) {
> +			/*
> +			 * Cygwin might still be in the process of marking the
> +			 * underlying file as a system file.
> +			 */
> +			sleep_millisec(delay[i]);
> +			if (lstat(path, &st) == -1)
> +				return IPC_STATE__INVALID_PATH;
> +		}
> +	}
> +#endif
> +
>  	if ((st.st_mode & S_IFMT) != S_IFSOCK)
>  		return IPC_STATE__INVALID_PATH;
> 
> -- snap --
> 
> FWIW it looks as if the loop might be a bit of an overkill, as I could not
> get the code to need more than a single one-millisecond sleep, but it's
> probably safer to just keep the delay loop in place as-is.
> 
> Ciao,
> Dscho
> 
