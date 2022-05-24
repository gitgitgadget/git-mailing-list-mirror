Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE1C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 11:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiEXLxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 07:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiEXLxL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 07:53:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04065C772
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653393174;
        bh=v+0au89zmdAr9bB+RPZ6nu26jNu4K6C17Cn0CpJKdRg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c+FYIpxIUbeqtiZifroykHG477dIwNb/VjziDEkcowBT7pc7NXzwt2nfWTYo6YLR9
         Aerf78D3JhcrGBwIkkv+6XoCbnJAm2gK7DW24K/y1vW3+tCpjnzUhTVLTzWoQk2+1n
         dmcu3sL4JDOG6rfKu7/DDB4p3gpBw6C8imear5vc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1nxbQ90tkN-006S1e; Tue, 24
 May 2022 13:52:54 +0200
Date:   Tue, 24 May 2022 13:52:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Torsten B??gershausen <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/28] fsmonitor--daemon: stub in health thread
In-Reply-To: <d2c909df-44f6-bc2c-ebbc-13ea51cf62fe@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2205241352130.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com> <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <32fc6ba74378cda7a5060d63066d16333765973a.1650662994.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2205121622030.352@tvgsbejvaqbjf.bet>
 <d2c909df-44f6-bc2c-ebbc-13ea51cf62fe@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HFNCovYDrAtN6m6eZKqWz4lJ4x0zhA7iaOgJYTM3591a0jMz2uE
 JPMWXpdZmtDIzhrh2m5116M3JBGCzVabvH70Mc8IBjiTG8v8wfRHNY6g93egBovTYq+uxKk
 XqmSsI71Ci/vT1D7nBeOy5riCpAnqCU666rPQrznF4Rac0cEr4JSrPdan2lT7WLEHTpiDrs
 QtcWrDGv3IqoKRU2P5ROQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bl8Tkdw42do=:ssBWmVKpFo/KW8OOHCrqSE
 V+rTC4VTai+qSaUef4a3aySBuiVe9iOW4PAwjikZzqFkzOwslz2KRfiEggHXN+stMHrLMw5dd
 dhffmnYWbrCW8jq1zzPP7EwaflUrPuUj381W9cpZpGdvFnuvl1dDaal9Jaq53Lgmgu2/JgEPG
 6UVm6bUkXN1UcRit0c7H80YERcZ+Jo9ri5+tWML8h9dr1lq4I9BhSmsWYvfU75kt31dRLdU8l
 aeU5ARDTX3A4tb0WYdLa3XOVXxHckEfonVFZbZztw4405NMt4xKruVdbgaxNXwnJHwse0i9vk
 1wPbD5DD1oac0l/YLmv+kqwgcqHjy3JtpIiru3a6VCvQV3JCjJMOwyjPV+e5yeUSlR8UElLHv
 LyhTgNEprfLWAOZH8HQiYgbat/Cj511VMHQq46SPIZ5juHTYfoJsHtarI+Iw68YvkTkmg3X+t
 v2RSJcgn9Yd0fzSuE3DBziQftW022Mukxd41R3cCBrBHgx5G8n5c3sYVOARqkZOXud7vk3G3t
 3y9/m1+WaLhZbiCXZT9BpFXZ/XdviFQ8D6+DJZ1GUqPsF2B1rJ8A1twllBFr1NyysmHxO6vLb
 JjkEbYnsWA6CzW0WoBtAQ8SGeay+0avz/uDcCTB9/5egXXU8PVcWPM6tWWJX+/tSDiaW/Gtz/
 Vc0pDftlAKHSd7ActKt0Iv5/MBUqzW1X1qZq8bt9jcGSwiLKQO2eIHQuHGqQBZKro1aJXrvT5
 qmG0F55r2GsHGysO1UMhvyd2sHlHCWSPTa65Du54INVA3QsaKlepSBPu3TNVqi87vtEx2RV9E
 0fkByNs5wUfaIcmYKkpwnM8ls1grKx04nnYhAbBlmb2cXAxKbsCgVotv+7YmpWucT62oU/+yL
 A5OAvQa2ep11NUq3/tRXR7/tA+KKSvVrC3a2Sf2lyVNurqlYsQJ0tWkPzp0eS99rklv4Cq/jR
 pyKYqRMYeTX1C9f/MpzccXQUCvJlyqmu4+ePf7e966jFur1c3INeYFsmY+KUn8Z9G22ZA4yUM
 mxM3inBnYCKjcjr4NqDl3y7Yoa225cgAqA8N4ubX6mR6xl3c/yIWlDWYjUldibG7112XVl2W/
 nO7NX822K0hzgoRVIAOI9I38E6g9ixVSlH5BqN0P9jntxbHuK+PZgXnDw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Tue, 17 May 2022, Jeff Hostetler wrote:

> On 5/12/22 11:05 AM, Johannes Schindelin wrote:
> >
> > On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:
> >
> > > From: Jeff Hostetler <jeffhost@microsoft.com>
> > >
> > > Create another thread to watch over the daemon process and
> > > automatically shut it down if necessary.
> > >
> [...]
>
> > > The platform-specific code for Windows sets up enough of the
> > > WaitForMultipleObjects() machinery to watch for system and/or custom
> > > events.  Currently, the set of wait handles only includes our custom
> > > shutdown event (sent from our other theads).  Later commits in this
> > > series will extend the set of wait handles to monitor other
> > > conditions.
> [...]
>
> > > diff --git a/compat/fsmonitor/fsm-health-win32.c
> > > b/compat/fsmonitor/fsm-health-win32.c
> > > new file mode 100644
> > > index 00000000000..94b1d020f25
> > > --- /dev/null
> > > +++ b/compat/fsmonitor/fsm-health-win32.c
> > > @@ -0,0 +1,72 @@
> > > +#include "cache.h"
> > > +#include "config.h"
> > > +#include "fsmonitor.h"
> > > +#include "fsm-health.h"
> > > +#include "fsmonitor--daemon.h"
> > > +
> > > +struct fsm_health_data
> > > +{
> > > +	HANDLE hEventShutdown;
> > > +
> > > +	HANDLE hHandles[1]; /* the array does not own these handles */
> > > +#define HEALTH_SHUTDOWN 0
> >
> > How about defining `HANDLE hHandles[HEALTH_SHUTDOWN + 1]` to indicate =
that
> > the constant is used as an offset into `hHandles`?
> >
> > > +	int nr_handles; /* number of active event handles */
>
> I think I'd like to keep this one as is.  It matches the style that
> I used in `fsm-listen-win32.c` where I have 3 listener handles.
>
> Granted, it does look a little odd when there is only 1 handle in the
> array.  But the idea was to allow new handles to be added as we want
> to watch more things.
>
> It might be clearer (in both of them) to define the array in
> terms of an enum rather than a local list of #define's.
> But I'm not sure it matters.

Your explanation makes sense to me, I have no objections against keeping
the code as-is.

Thanks,
Dscho
