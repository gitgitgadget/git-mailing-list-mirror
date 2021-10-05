Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C0C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6332610A5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJEIps (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:45:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:39149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhJEIpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 04:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633423435;
        bh=m3dliT8xmIsOZ7MN5m8Wqc2DWtw+npezPhES/HIT7Ds=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J5A0ikMHQjcRp/lFQ2dTjhr00hocfmWleR/2B0S5Wgfn0Ax2yfj6w8lpqNMXAIwEA
         Yk8dTuo89jPHyJm3Cv31dcoHcc3TNX1D3QGioQgVSV8tzHIUKmStA1d37pHyxXagwQ
         ZoCXSWdAX001HsQ4yW/5VnJSP4sI+ocbP18rU36g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([89.1.214.13]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1mwOwc2mgD-012Fm7; Tue, 05
 Oct 2021 10:43:55 +0200
Date:   Tue, 5 Oct 2021 10:43:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tao Klerks <tao@klerks.biz>
cc:     git <git@vger.kernel.org>
Subject: Re: New built-in fsmonitor: messages accidentally on stdout?
In-Reply-To: <CAPMMpoic0Dt=5Z7GB7BG7CqwxAs49SPPDkdasUPvasvsPhr-tg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110051043110.395@tvgsbejvaqbjf.bet>
References: <CAPMMpoj-oiD1yDHx6WS_1uiPOXMLj7FcfBPZm-q4vO30kpE_ow@mail.gmail.com> <CAPMMpoic0Dt=5Z7GB7BG7CqwxAs49SPPDkdasUPvasvsPhr-tg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UTOe2AFioUVTr903Ef9iJeLTU5OkrBKAN5bU3w0EKeFA1wv6dah
 Nw65OfWWKEsvbzDezvIW9GfdNHSckkVYwJhblKLD0pkTYcW+dKsHjXiV3tYk/mkV+I3P1rY
 PjZpp2k8MtFfIJWVR2kf3KkGCyHI0UnsoxcwnxSqRsA3gWpXKwV/1qiA20srcpEJ05jBGVO
 xbSNnod+5shuJnmZbYA/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PpnnkAojPPI=:PHIsWft6EtFoObvTy4Ks6i
 bpwu8SZHpubaDWQijXdfDv8PHs8409o7XOhwspLsOnlUllnlYj6dXHhp6UHrSmprieZZrow9a
 latPMbwWf/0+7Go7t6DNWwIKorfw1QyqGrQCaP7Soh7cu3Tw1zwciRwmQSJtlXwYSchsqRTpK
 aiY/xRtlmmphJjzuMlxKAm0aamP1jDNkuehEsc83m/z8N4VASGwiAYJx5EHz73pxr5OoGlZC6
 zZtfEelRcd2H2nqcsP04qeCF78UBJdZCmuLeCbc2UDVEWMAfnSSxWkdfWRfIeFPql3Vej2cnL
 tdto9ZWFYZ3VWQSbqH30ewHPlqoVZDRoyhYlGdFJeVuwSs/9o+B8I6ljICmY69t2DJgHa8TqI
 A51yRaREtwY3B7oWH0Dt4Fn8uFQZhq78y21uVp7ppLxGPe+0rV3m1O/WrtAD2uoWvpxowACWc
 xv2JiMT3hGaRYb4zGEs2A5WCxPNVRqWXJoa5cEDu8J8YSrwUGsRh/zhJcu9b/Y3BrrHNbFesx
 bLnW5n62ZhgOnKtgIXuPcild/vl3sBrHfukgjEvqs7ZRMLmx1df9L40IMCn34Kwt97hSscvs+
 Jf2gpA/nb504VjmxvZelRFtb5DirVf35Q4kWH0eJWg/ryfxWdl/aOCfnm741+P51pyT18BR/q
 XXLITyuS+Q0b320o/jVcqNda9dsrSbRFb/w2b8u44fi3jM4bynuTzO8vj0TcJdV4WRIiOxQSa
 iyylw4p5v0DcqaSYvj+rrEZM5nv7TQiUnHmC2049l1odByPkWAq1MxINUUBPU4uBB78NHuU7T
 FFJn+ibdZcr31nVG9wlS5lWt1VRR0qeyet4XFq75VmjhYMURSpi0vinXusjD2fvYuEk2o0sVP
 zOfEzur3a9chQIKihET9ZqZ1LImE5fIo2xcyuzSEdBIdtVMbbujQUrJjcQRp6iFtgr3tE148/
 1nUq9KJqQ7/nbd/unpCKWotzq4mlC7qg9ePka90DP/JJZlsP2YvRBOfn/ADS3/iabRRhHMhqb
 JtB8IF1zXneTmKMhWb/a1BC90fhcK7902H4tOVse89q5vM4VwgWzsz4OtqgDkby3kzG5ttOQ8
 61/2T56O0tFMQU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao,

On Mon, 27 Sep 2021, Tao Klerks wrote:

> I did track down where that message was being issued onto stdout in
> git-for-windows
> (https://github.com/git-for-windows/git/blob/main/builtin/fsmonitor--dae=
mon.c),
> and I see that in the the latest version of the patch series it was
> already switched to stderr
> (https://github.com/jeffhostetler/git/blob/f08a63e197a0efe4d8f0452893238=
b0d3156e669/builtin/fsmonitor--daemon.c).
>
> The only remaining thing I can ask for, I guess, is that the next Git
> for Windows release ideally include this change/fix, even though the
> built-in fsmonitor is not in "regular git" at all yet?

The latest snapshot at
https://wingit.blob.core.windows.net/files/index.html should include the
latest iteration of the FSMonitor feature.

Ciao,
Johannes

> On Fri, Sep 24, 2021 at 8:02 PM Tao Klerks <tao@klerks.biz> wrote:
> >
> > Hi folks,
> >
> > I've been testing the new "core.usebuiltinfsmonitor=3Dtrue" capability
> > in Git for Windows 2.33.0.windows.2, and came across something today
> > that threw off my scripting:
> >
> > In general, git "informational" messages are always output on stderr;
> > this caught me out initially, but is a godsend for scripting.
> >
> > However, with this new functionality, the "starting fsmonitor-daemon
> > in 'C:/whatever" message is being output on stdout!
> >
> > This interferes with scripting around things like "git status --porcel=
ain".
> >
> > I understand this fsmonitor stuff is still somewhat in-flux (patched
> > into the windows port but not yet "regular" git releases?), and this
> > issue may already have been reported and addressed in the latest set
> > of patches - my apologies if that is the case!
> >
> > Best regards,
> > Tao
>
