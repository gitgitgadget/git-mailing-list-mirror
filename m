Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC10C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C77761185
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhFQJkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:40:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:50135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFQJkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 05:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623922685;
        bh=7Q3n1dlFloN6fvTQLY38+QQ5Foy291LBLFzdwQyLjYw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MV++VNu4Q5yeEo+miunjT6HHkXLlAyvZmZGh21JQR/dguw8+dN77Ft1k5zVOrKMGS
         bhOtpn3Mt/4kZmiqpcd35810AywyqtVoMpQynIMEOqqwgbpeREHVYTesFwUrwSnYKa
         TZwpb9Rx48tclfvWi6IZWPXS92URMoMQkgS/dltM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1lz0zw1ZVF-005pid; Thu, 17
 Jun 2021 11:38:05 +0200
Date:   Thu, 17 Jun 2021 11:38:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: jh/builtin-fsmonitor, was Re: What's cooking in git.git (Jun 2021,
 #06; Thu, 17)
In-Reply-To: <xmqqr1h1mc81.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106171135530.57@tvgsbejvaqbjf.bet>
References: <xmqqr1h1mc81.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7d4k+lMuIKaiP+X3+xuSGBOpD6kt8Z0dyAhv1iKx0i7FqcElsAy
 NlurfcJMaeOmrQPVcT05yDni9345rF0RA54w1xR1z5xrzoaXnaawkYhCy5NrqKV8vqiQiWv
 NNSk8INZ34LPjQaRGsPPxF38O5uBc44WkTN9uWIQ48bh9reUACu4aOVbsxWJ15A5NFB3etX
 81LUT6s/CB2OfbVZJ2kLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q8R41cQ1rxU=:V6e502TcY/CzBp8tyS+6GP
 sMMvE2pjyUktbNATP61PzwFEFl8f0Q4ZuIu/6OfRJ+cHfnEHevxT7CO6psKNQsgMAg6UqmxfW
 vDIKQU0ah4r+jQq2L/Y3APuv1Rk7sYeSjKWfqAP2mfGmpeC5m5WCuVmeMooRxWbXmtEcsUr5E
 cS5q3eDsGck9pfu+fKGLtcehBQ0Qca3qJjy2ljzBvCm0kU+Ovh2Py4KeFcxtojdM/7NqVkjwI
 qY5A7NZFxAWv3tGYo/L3m/z3hXyef3Q2X/HOx45+FBLTcHXKrzTKHWIpYYirA1Y0XZgi8cdlo
 yU4s4GLmYst+5gALaK9lBmHeZy91Nn37Sf84kX+KJUMNgs8uz5cSC5e5+2TI3kSOaCp5ENqtS
 wH5tzTv+iQmDv79yFrHFb0krtpj9H37j33qma0uWzfN2MQsuPRGFDTb6RBR4suDBHXYxHxq4I
 Gucjy8jzkb2neYq4rFfwVF6MEO3AbOITbVqpJjA1DAi4LPrYpJ2Hu8dVUG789SagSFa67tr4P
 eH7qX/7UtB139daXTOzEfJn9/ixhPp1ZSlvwB7dGnhyTD4qTuqXgAbvYBGa158Zbgo07NGvxN
 JfRb0vCYbqehA+n7UNm8Dlv1+GUF4hmRiBisWSq5a6uKOcpBjTQjrULUc7uW+Dx53uIZ35xgu
 TcNApQAgxvLDC0td9ZHXQNt61BCoQ1QAwI7bLHK2RBqvnOlhz59MfWBwLGH7wywKxq4pSyEcR
 WU+W7IfpsDpO28ihCA2s7S8YmqaCA602wekr4dj+J0VGjgD6BOYYvgyL5rfX3behJaxHxaQQt
 m9BD7vlqG20tvOPnf/fQg9J47g1WVdEB6TnhNR4RJTDz8tcIi4aXNswGC7Y5npZsXjkTicbes
 Kd5/QFGj+3/+pEwMzjGeRI/cKew7exAkpLKhkE9cWw3YhC/7tbsOlvOyrxp215nN0/Mm6M0vN
 zRE+PvMKKB/XdZhC3u+SrQ8DVx+xokdQjtvfD/Z1kO6fgWzZDREe3PRC1Z4Wo4MLXiK/+yAU2
 aMg5yN8iSple9vMmFKZOqWu6UMe6GryuOj3AqEuq3J4qGkXuQFRWba6pGMMirEHDB/uzVXnAv
 6riapLdt6EQtqWuqbKHIjG/Rx1umlaDQ+gy0pw91tuVMcHeXQi0x/0NAA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Jun 2021, Junio C Hamano wrote:

> * jh/builtin-fsmonitor (2021-05-24) 30 commits
>  - t/perf: avoid copying builtin fsmonitor files into test repo
>  - t7527: test status with untracked-cache and fsmonitor--daemon
>  - p7519: add fsmonitor--daemon
>  - t7527: create test for fsmonitor--daemon
>  - fsmonitor: force update index after large responses
>  - fsmonitor: enhance existing comments
>  - fsmonitor--daemon: use a cookie file to sync with file system
>  - fsmonitor--daemon: periodically truncate list of modified files
>  - fsmonitor--daemon: implement handle_client callback
>  - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>  - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>  - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>  - fsmonitor--daemon: create token-based changed path cache
>  - fsmonitor--daemon: define token-ids
>  - fsmonitor--daemon: add pathname classification
>  - fsmonitor--daemon: implement daemon command options
>  - fsmonitor-fs-listen-macos: stub in backend for MacOS
>  - fsmonitor-fs-listen-win32: stub in backend for Windows
>  - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Dae=
mon
>  - fsmonitor--daemon: implement client command options
>  - fsmonitor--daemon: add a built-in fsmonitor daemon
>  - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon vi=
a IPC
>  - config: FSMonitor is repository-specific
>  - help: include fsmonitor--daemon feature flag in version info
>  - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>  - fsmonitor--daemon: update fsmonitor documentation
>  - fsmonitor--daemon: man page
>  - simple-ipc: preparations for supporting binary messages.
>  - Merge branch 'jk/perf-in-worktrees' into HEAD
>  - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor
>
>  An attempt to write and ship with a watchman equivalent tailored
>  for our use.
>
>  What's the status of this one?

I am not Jeff, but I know that he is busy getting back to it, and plans on
submitting a third iteration.

This is an important topic: it allows working with quite large worktrees,
i.e. it is a crucial component in our endeavor to make Git scale better.

Ciao,
Dscho
