Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE4C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 15:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbiBXPbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 10:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbiBXPbm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 10:31:42 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978491BE4DB
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645716666;
        bh=NKTDE5eBcO47O3x5i25++NvnaPUO54c/tq7a5ZFEB7g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b58PgazVI8uLhQV3j/S0r/mPV3AMMldmYNBRlMw+d8Ovkv6T+fO9VgtBPab6e2fQx
         2FKuBGTMwb7TwpXKl4MC+SFnCeD9BkAONo3zj9eXQDVc93hahnT9eUcCKMo49sUGE3
         gjsRfLyfH1mRmNXm/MRvkylGcx+yLApIfflXZ6Kg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1nJQrH48XW-008Jgj; Thu, 24
 Feb 2022 16:31:06 +0100
Date:   Thu, 24 Feb 2022 16:31:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 10/30] fsmonitor--daemon: implement 'run' command
In-Reply-To: <6e03d1e0-8765-a474-f69f-b1ce63146b6a@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2202241630450.11118@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com> <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com> <6fe5a2bc79eec132b6455d53196906036d0f4a80.1644612979.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202171744410.348@tvgsbejvaqbjf.bet>
 <6e03d1e0-8765-a474-f69f-b1ce63146b6a@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EMSaWJxNrex19GntnbWAqHkuG2AR91lJ1JNP9H+HTlYIM+sdplE
 xWrP14UYi1PrLkJz4sKNdC8XBfAQant4qp7ZvI8HcY6vJksWFq3D7+MovCVuv8/WBm7+CWH
 LVCaEdoeYis4ZQDFNf3KCQmlBVh5zYgufoUYaywLgTN/uwYbThgOCEAqsg5ssgV4FwMDKkX
 LinCZwlbFdkotauWDDtpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lhx2V9vOjq4=:Y6ksdsIYkeW2fNAPgUhIus
 gzvcAubLGPDNavorZYO2BqLWNjJuDu5EPfWMLQWKrQODOuM+E7Kbd/gI0M5Btbt5RnZjJONOb
 qH1sbvtaE+E/31dwVl+H1mGMVLe4XxSLs3f//JTpYxjUGLNZ1RS/KfAVoI7efo7YA1GmDEsLo
 Oi0wIL141kAt4k/zfFClrjfuOTzd4m3krZVjO7ySEmteOgdu2Fv4WS9WwH3cqx6lVtsTqtERT
 94lPCNSbasy31umy9YiwUFa1kOtJurdqXRHCGv9xkJjvOlQcLQNw+tjzCc30a35JVZpArCDHR
 V/O9gMWaLb3Z0J33WkiEww6KlEX/Fcnw1+z94G0Jg+YrmeuqOdLcerRyZd5XPVsvmgW092EKH
 eVs8PblombfHd06q41AOtm+A9uGnVbiZMvJwhladg0hCNHKxCDUgHuaj4cUQB8Tht3a0rSub2
 wCgJ83/sSyQF96pRbP2cXARZCZaExE+gWHTu7pcBxfoZsLdHvcwJCkW40IrYDKhvFWEEeAHGA
 ISLOA+5iwp9YTBlU9bgEFVgoRDVXWcfMjOFqZ3FvKC/C5D7BmygPTUs8FPKsPIhi1aV6USh1X
 VqcqcaPXBwWx+HmBxoKq5YsofSfjb8SMVM0BxwjkiY1AFIr1O3sVEzGnOGoD7LsVDupT/kYzE
 6FKt60ywtyS8uOMvS4iTWeqVgRjDnv6bQSCkorLtwGscAIuNGOpHHIXi1qz+SNWamu51NsLs8
 ijPZNmQ6JAYbKpY0FFRjxf7GnQ36kjcuQ8ZQAl1apWG+boOjnxCFFRfNGwwx9idmicM+feICM
 CgEfS/fb/4Z+GXrsCkK3ysOdfH2M/awlcoh2u9wBfE8oozQkB65RUgDVFaawpHQ6vw/mu9naQ
 wusWz9YfmU3odYnM0PA7PXrq2760f6hHwLAwh1AavOan0GIPWsKG1K2mqLXWJPI/kn0cwyKXZ
 F51urX5+mfaJVEvYb8ES8XtcQfQwD5Nkba4yx/6xIBDakNbo6aT858r8POfluxGcY6DPpg9/y
 6chVnWR27e2axPmt3ThV22aZdwLUVH39Uzmor1f12VMwYMoTvqd/glVbp0TDgHIDdkRgISGQT
 s8LHcL+mHbWjnA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, 17 Feb 2022, Jeff Hostetler wrote:

> On 2/17/22 11:46 AM, Johannes Schindelin wrote:
>
> > On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
> >
> > > +static int try_to_run_foreground_daemon(void)
> > > +{
> > > +	/*
> > > +	 * Technically, we don't need to probe for an existing daemon
> > > +	 * process, since we could just call `fsmonitor_run_daemon()`
> > > +	 * and let it fail if the pipe/socket is busy.
> > > +	 *
> > > +	 * However, this method gives us a nicer error message for a
> > > +	 * common error case.
> > > +	 */
> > > +	if (fsmonitor_ipc__get_state() =3D=3D IPC_STATE__LISTENING)
> > > +		die("fsmonitor--daemon is already running '%s'",
> > > +		    the_repository->worktree);
> > > +
> > > +	printf(_("running fsmonitor-daemon in '%s'\n"),
> > > +	       the_repository->worktree);
> > > +	fflush(stdout);
> >
> > Do we want to print this to `stderr` instead?
>
> Yes.  I have a patch in part 3 that moves it to stderr
> and only emits it if a config setting is present.
>
> fsmonitor--daemon: print start message only if fsmonitor.announceStartup
>
> Wondering if I should squash that in here instead.

I would like that.

Thanks,
Dscho
