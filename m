Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5DD1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 10:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfJ1KOS (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 06:14:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:41071 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732270AbfJ1KOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 06:14:18 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iP22P-0007DE-CI; Mon, 28 Oct 2019 10:14:14 +0000
Subject: Re: unpacking error
To:     lyle.ziegelmiller@gmail.com, 'git bug report' <git@vger.kernel.org>
References: <004101d58d24$4daab5b0$e9002110$@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <91e5f3d8-d2cf-363c-2407-4b4dfb75e5a8@iee.email>
Date:   Mon, 28 Oct 2019 10:14:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <004101d58d24$4daab5b0$e9002110$@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/2019 00:11, lyle.ziegelmiller@gmail.com wrote:
> Hi
>
> I almost always get this error when pushing from my PC to the bare
> repository on my laptop. I'm running Cygwin on Windows 10. I've tried
> everything! chmod -R 777, chown -R <my user id>, etc.
>
> A few more details: I have a Git repository on my PC, and from that, I've
> cloned a bare repository on my laptop,

How did you clone that bare repository? In particular, how did you 
provide the path to that repo.

If I understand correctly it must be in a URL format (e.g. file://) to 
ensure that you get distinct repos, rather than two interrelated repos 
(thought the docs discuss the issue as being the transport mechanism).

The same issue probably applies to the subsequent clones of the bare repo.

Perhaps focus on the error message and decide if "." is the correct way 
of thinking about the path.

>   which I then used to clone a regular
> repository on my laptop. The error occurs when I attempt to push changes on
> my PC into the bare repository on my laptop.
>
> If I delete the old bare repository on my laptop, I'm able to create a new
> bare repository on my laptop from my pc, but then as soon as I try to push
> to it, I get this error again. I've tried disabling the anti-virus, etc.
> I've spent hours Googling solutions. Nothing works! Many others have had
> this same issue. I never had this type of problem with SVN.
>
> It would be nice if Git would say what's failing when this happens, and it
> would be nice to get this bug fixed. It happens with all my git
> repositories. I don't think it's a network issue or I wouldn't be able to
> create a new repository on my laptop from my PC, as that would encounter the
> same permissions issues.
>
> The two machines are connected with an ethernet cable. I've done everything
> I can to make sure all the Windows permissions are set correctly, etc.
>
> $ git push
> Counting objects: 3, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 331 bytes | 331.00 KiB/s, done.
> Total 3 (delta 2), reused 0 (delta 0)

> remote: fatal: not a git repository: '.'
Why is the remote end of the connection reporting the error that it is 
looking at "." (as opposed to a proper path/repo)?

I could easily be wrong - I haven't double checked the man pages at all, 
but thought a comment may help your research.
> error: remote unpack failed: unpack-objects abnormal exit To
> //lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-repositor
> y.git/
>   ! [remote rejected] timestamp_testing -> timestamp_testing (unpacker error)
> error: failed to push some refs to
> '//lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-reposito
> ry.git/'
>
>
> $ git --version
> git version 2.17.0
>
> ------------------
> System Information
> ------------------
>        Time of this report: 10/27/2019, 16:53:09
>               Machine name: LJZ-DELLPC
>                 Machine Id: {39BC0826-743F-4ECA-AFBE-66A14FBE533C}
>           Operating System: Windows 10 Pro 64-bit (10.0, Build 17134)
> (17134.rs4_release.180410-1804)
>                   Language: English (Regional Setting: English)
>        System Manufacturer: Dell Inc.
>               System Model: Inspiron 3650
>                       BIOS: BIOS Date: 06/17/16 21:14:07 Ver: 05.0000B (type:
> BIOS)
>                  Processor: Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (4 CPUs),
> ~2.7GHz
>                     Memory: 8192MB RAM
>        Available OS Memory: 8096MB RAM
>                  Page File: 8076MB used, 7243MB available
>                Windows Dir: C:\WINDOWS
>            DirectX Version: DirectX 12
>        DX Setup Parameters: Not found
>           User DPI Setting: 96 DPI (100 percent)
>         System DPI Setting: 96 DPI (100 percent)
>            DWM DPI Scaling: Disabled
>                   Miracast: Available, with HDCP Microsoft Graphics Hybrid:
> Not Supported
>             DxDiag Version: 10.00.17134.0001 64bit Unicode
>
>
> Regards,
>
> Lyle Ziegelmiller
>
>
-- 
Philip
