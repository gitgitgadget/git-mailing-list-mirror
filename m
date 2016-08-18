Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63E11F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 03:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbcHSDFS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 23:05:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:65410 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbcHSDFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 23:05:17 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LmOLO-1b1c0K3Ws6-00a0Xt; Thu, 18 Aug 2016 16:42:30
 +0200
Date:   Thu, 18 Aug 2016 16:42:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Ben Wijen <ben@wijen.net>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not inherited
 by child processes
In-Reply-To: <CAPig+cR4=kEUb5PsZfoz3=W+R61wER=vHos5uX02kEVM8YETgA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608181642200.4924@virtualbox>
References: <cover.1471437637.git.johannes.schindelin@gmx.de> <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de> <CAPig+cR4=kEUb5PsZfoz3=W+R61wER=vHos5uX02kEVM8YETgA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RnbgnIrFp1DVMcj6V5sfzaeSWtfY0tvCXhpRK7teVegk8ZoZmRG
 egKQBzuVT3TJoAgJZAPCN4EYzLPDr24wKSGvsRazihDBcrWYhF2oflUcM0JOItQWbQ9rjgC
 MM+XEpd7d3pyHUzdAyaLmYPYUsqTXbPE3ZxWXf5rWCJhd3vFAmR3WIxmKYxIsCtlE5eGqUt
 /b3QOjsrhIoC9htUFm+vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vmH9gKDDGS0=:9UFdVIVm8T6z41Ei6BJ3Vn
 OeUC0gxfHn4A0w8xBJHtiERlHqi+2oZw8NrpUdRQvWFM0KzABd1PUs+sTfQZTRIksGzxmxSL1
 AuP6uO1EI3Gjh+rGHfOi/Wj1vFZoqzyy78E9SMrUxzhuuPrTCeHkPYs3Mkofdot6lfyRu0Swt
 pKC43BrpBLc6DCNGddS/ntxQ+qE+ZHM04Q++HyXf40XnnmoVf1IjYNlCMDOfZhaYA/+BMPc1k
 6sRGxOMQotJJzLLj4qqewMi2X5rlGyZIUYmj1AJMJcok6TKBKUvjKnQXuRw5bgHjxUk8XrzlK
 krf5bUnGJL5WAddgdC6O8XXqgpW74aBxd7ewhH+zDRlCm/JC/HUWLcwVkPU028Hho733nRV1s
 F2r2KEjQXKxqrl0QLVhJEk+fNhpGTAY/N2qxPuvo6Xfj54pJVjjqMn5xW/T4CjNU3XBQZt2sg
 vFFoBR+lLknpFCM+aewnYtE5z90c7BG3S+kZhWVaRYge5Zu+wAegBH8WCYtwyjvv0n+gx6G8j
 YyRa7ZsDUfLtz+rx6uRls4eSEYKfBfzDNSnqNiym13s/bQIlEVXzWMXgtgboId6i87d4orqE3
 93BP+jsayPUaUdDSWkfqA/ES76XTqBRr5lPbiMWPmIZVFEyp5uLzEJN9gIK0CIMUg2DIQinwt
 bcw2ovLwAve3m5L+UUj2C1Ef74PDapD1hJ0udTmMIdjOBIHegVG0CDz5EhwxpeSJlis1DWjyJ
 kr75vhjbUL9SeT4gAg7joa3yK6no4pnZ/pXKAzZPnvqXbnUJ3LlbR5Y96AloyBvDkQmT0Us7W
 aTNwdPr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 17 Aug 2016, Eric Sunshine wrote:

> On Wed, Aug 17, 2016 at 8:41 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > When the index is locked and child processes inherit the handle to
> > said lock and the parent process wants to remove the lock before the
> > child process exits, on Windows there is a problem: it won't work
> > because files cannot be deleted if a process holds a handle on them.
> > The symptom:
> >
> >     Rename from 'xxx/.git/index.lock' to 'xxx/.git/index' failed.
> >     Should I try again? (y/n)
> >
> > Spawning child processes with bInheritHandles==FALSE would not work
> > because no file handles would be inherited, not even the hStdXxx
> > handles in STARTUPINFO (stdin/stdout/stderr).
> >
> > Opening every file with O_NOINHERIT does not work, either, as e.g.
> > git-upload-pack expects inherited file handles.
> >
> > This leaves us with the only way out: creating temp files with the
> > O_NOINHERIT flag. This flag is Windows-specific, however. For our
> > purposes, it is equivalent our purposes) to O_CLOEXEC (which does not
> 
> s/our purposes)//

Thanks!
Dscho
