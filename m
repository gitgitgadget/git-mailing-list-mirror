Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85179C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiBXTRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiBXTRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:17:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E0DC1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645730217;
        bh=FNxQUA2Gq4n0v18oaRrcgiLCI/TWcLYm71Y5pTmVUtM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j90AZ/T/6L7t52xpc251tnd7MqYfX7kZVcKla7NzTPsUdq61rOcbKITV4hMvVQ2qV
         Vuzbp+sahsrlR+ATc02FMdd/5EMA9OLnoNinEjYvz4+3AUhA5Zn1cyaM56ONr3Gr5s
         +yGzL3cIMi8LqeFHvjM+hLgJbyPzUXQo1iDDW+HI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1o4vsn3MUT-00iUn7; Thu, 24
 Feb 2022 20:16:56 +0100
Date:   Thu, 24 Feb 2022 20:16:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
In-Reply-To: <4aa1293e-00b6-b9ef-efd4-cdf605db37a1@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2202242006020.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com> <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet> <37f54cd9-3e53-7d38-2c23-2fc245dc1132@jeffhostetler.com>
 <nycvar.QRO.7.76.6.2202241650200.11118@tvgsbejvaqbjf.bet> <4aa1293e-00b6-b9ef-efd4-cdf605db37a1@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UbBbFEmAsjBw5H05mtja/fjXA1IYO6us7gA4rA35mHocBdr8GdH
 NIsE82su/AzmJc2HuqklV0qriAWeMYiR5yLqz86GVzXFwGRML03qDY+Vi2e2z+r/Tdm6kLV
 mJNGjpWYXGQiiifBFXLHCNu3mMucoJ1JbmIqjUTVJFQr8rXYfskbwgQhASEvFIhVZOFpkYe
 deywwaSSeROyPqE4ZNiNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ErNmgbmApAY=:t2CTHh9MbCZ+m6YKIqv3Bc
 uvXJ/qo6NDyKAk2sdqYQIYD4m2N3qj5O3oQX+as3s2WM2+lh8cn6wRKM3evXH9voc/E1mq0Zc
 RSOzoM9ERrCfieGPOa+ZqlqSmHgNK412tFwiPGyQGEZvE8/C/p4kIfF/Czw8boKqGPxRm8TwJ
 aAAD8v7/JfRWDbwhu8903IgASyt09DhGgDKnaLRnU2ftuV5lptaR2eVSDC4rqJPhMdwVDE7xZ
 q+DNZmd5VKABzK6UnY3MKi40NzoQ2uYE3gxMiUAyA8tYdo7hO50F6He3V2+fecswVOYWFLunK
 w8aiQdAgk0uUQCynceoO1efGB1OALVCyYhTKlAAbeCjdFUgohC+m5WlPJVv5k5eP9vNxiOSui
 /q3Gc+GoFwCHsp5SAAqHXqIXtE2rxntYPp8vKy2nsVlLyeWNoHSoRnKWBo9hmfFKhfpRNNhSU
 oErVnha+/jCtj+6AVZa2QqBCnu5rTiqkScw5EjM4K/b+Zyg6s4H1R+5GgplCqswptqzI6wkaP
 5Zmp7cAAHFbsdHUb4k7jutGsv2N/cIFhHoeCa+cvsmN1dgUvxNnE/MX6Gfmfr0geEsixtWvJX
 eMF+OwynY6wNRb0F79dDXeF7xroA3nerFZWKi6Yd4RMFjyeDCE0BCRCTf8j5e+91sMNiOtX1d
 vWyRcj9etU3eKEkt+fXCynGvgZGI9RGfwpuqkriyt9M/iyraxYQlPsj3TVPA3FVdfTKXG8Jvq
 pjUcU2/jPvSbWpk3U9qDRZzAew/nEiIKxLhiB7R98i+D8yBbnE6mqhQotcqrVTbD5J2PUgNB3
 PVI8FaT3nXkpzszMNaIVM2ZfZ4k5GMP+kU9bzSBk/WDfcxeez2VM3lbpK2PqJFbfHhxJpeNSu
 Vx9NVlJbG9Nh1qBJItawf38sFUkxvdfMXRTS6Prn5Eq/ULzrRbBqBXc+sYSY6N52eG2oGjQAf
 hn8TPKEUDNYibIzdP7aMh7HS4opqYRmHaPBaNQss7BDsclye9encNzDmtJf9sulrNTQzq83W/
 VbXbEbI834Fy+MygWrxplCxZ34hVWRWCMq6nLn2DRQkmz0dZyVPbjI5xmMd8QeaIJWUBnLOPC
 w0tF/78QK8ORQY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, 24 Feb 2022, Jeff Hostetler wrote:

> On 2/24/22 11:22 AM, Johannes Schindelin wrote:
>
> > On Tue, 22 Feb 2022, Jeff Hostetler wrote:
> >
> > > On 2/17/22 11:06 AM, Johannes Schindelin wrote:
> > >
> > > > On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
> > > >
> > > > > In this version I removed the core.useBuiltinFSMonitor config
> > > > > setting and instead extended the existing core.fsmonitor.
> > > >
> > > > I am somewhat surprised that a reviewer suggested this, as it
> > > > breaks the common paradigm we use to allow using several Git
> > > > versions on the same worktree.
> > [...]
> >
> > I wondered about that for a while, and put that to a test last night.
> > I set `core.fsmonitor =3D true` and then modified a file and ran `git
> > status`. Something I did not expect happened: it picked up on the
> > modified file!
> >
> > [... describing how FSMonitor protocol v1 is affected...]
> >
> > However, after seeing how nicely your latest iteration cleans up the
> > code by simply interpreting a Boolean value to refer to the built-in
> > FSMonitor, I _really_ would like to make it work.
> >
> > Maybe we can declare that it is "safe enough" to rely on new enough
> > Git versions to be used by users who use multiple Git versions on the
> > same worktree? They should use _at least_ v2.26.1 anyway, because that
> > one fixed a rather important vulnerability (CVE-2020-5260)? At least
> > for Visual Studio, this is true: it ships with Git version
> > 2.33.0.windows.2.
> >
> > What do you think? Can we somehow make `core.fsmonitor =3D true` work?
>
> [...]
>
> I agree.  I would like to keep the current
>
>     "core.fsmonitor =3D <bool> | <path>"
>
> usage that I have in V5.
>
> It cleaned up things very nicely and it got rid of the somewhat awkward
> usage of having "core.useBuiltinFSMonitor" override the existing
> "core.fsmonitor" setting.

Yes!

> It is unfortunate that it might cause a breakage for users who are
> *also* running a Git version between 2.16 ... 2.26.  I have to wonder
> if it wouldn't be better to spend our energy documenting that users
> should upgrade, rather than trying to support interop with them.

That's a good point: I guess if you added a comment to the documentation
of `core.fsmonitor =3D true`, that should be good enough.

> [...]
>
> So anything still using the V1 FSMonitor protocol is going to unreliable
> and racy and users should not use it, so I don't think it is worth the e=
ffort
> to complicate our current solution to maintain compatibility.
> (I hate to say that, but they just shouldn't be using V1 any more.)

That's a really good point.

> On a slight tangent, the current code (before my patch series) does
> support a "core.fsmonitorhookversion" to allow the client to talk to
> a V1 or V2 provider explicitly (vs the default of trying V2 and then
> trying V1).  The IPC implementation does not use this config setting,
> but I could see adding something to emit a warning if it was set to
> 1 when using the builtin FSMonitor.  This might help users who are
> *also* running a Git version between 2.26 and 2.35 to understand the
> fallback after the true.exe warning that Johannes described.

How about making it an error instead? That should really be helpful: if
`core.fsmonitor =3D true` and `core.fsmonitorHookVersion =3D 1`, just erro=
r
out. That way, users will more likely fall into the pit of success.

> On another slight tangent, I'm wondering if we want to officially
> deprecate the V1 hook code and/or remove support for it from the code.

Oooh! That's _also_ a good point.

Maybe we can keep this deprecation out of this here patch series, though.
It would be good to get this finished and into `next`, I think.

I spent some time (in two separate thrusts) to review the entire patch
series, and hope that my feedback was useful to you.

In particular with your idea to document the incompatibilities of
`core.fsmonitor =3D true` with Git v2.16.0..v2.26.0, I am really eager to
see (the next iteration of) this patch series advance to the `next`
branch, and then into an official Git version so that more users can
benefit from it.

Thank you for all your work on this,
Dscho
