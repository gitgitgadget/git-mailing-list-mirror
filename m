Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C4C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226B7610A3
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhIHHyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:54:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:57581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345419AbhIHHyL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 03:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631087582;
        bh=V1fTWjymuCKIAAQmho0Ss2u1bXWZbBc4VCNWc/R7t7A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XLtn3S1uPH6hBPZscNcKTb3GT3Mx/SslWv0xMsKYQfSgbXKF9t1AWAnnYrtCuqsd2
         cDUv27pJivA/qjNPxdXLI9dhkh78rjFNLnab0wf7rTjKW4pzQlMoAaxNApHMaUWIxV
         Uhl44xAON0rb4FRqriHOocQz7nzQ8GtuHEpr/53Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1nBjiN1yWj-00wjR9; Wed, 08
 Sep 2021 09:53:02 +0200
Date:   Wed, 8 Sep 2021 09:53:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] tests: remove leftover untracked files
In-Reply-To: <pull.1088.git.git.1631076472457.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109080950540.55@tvgsbejvaqbjf.bet>
References: <pull.1088.git.git.1631076472457.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DmSfYpWJEwbXq+SDv1qjrmduhuTpX/qC/A1k0SHnRx/wHHbIZ0C
 mSbUwse+16p3vtv+BrxHoJ/1Lb/w7nsJIHu3Ib5MK4EpWJUnau83oKDudjdym0WLvBxNwYe
 SlCf37bOEcD8NPdNAjC9W0/Cf5BzWsGoaMtpxMomwG0eivlfGSxjwoOaTXKI8DO5sASl0r2
 YA5RxiCO+8nwJkeDTi2+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VkXFPe6/taI=:QXZUZbdVC42CkzPUsV8vLt
 LsIssijMhdzaztFSerpsbPqbULYXgDrgmiQ5ROtoSZ6s9+YfyBST0NOgZoDyxqJZNXtwNN41x
 ZGv2HMlY+5s8E1HoewXt1wtdeJy2ezZFxAFXoXwn6vP9sx98iyPPW+AvJbu3tAMcvDnYERC+V
 55/VBocWon2UGrz4eWNi9q2rlmsMssNK2KgAhN2NzuEpvipbZkUziWSoz4EVBoDUCL+VlD97e
 AEgchFRU/WbHHOYrQyyWrRCkYlsWCwr9B0xs3K3OftSS/wQYiyjF2zCdia+YmhKE8DmK2rzxT
 PkBP8CxBmsFspyySSrkJPVVfb8XpjR3TfXAeDCTdp2duNsoZHki9yiNQbU/Il3ZNTGepGMN7T
 jmgdVorwqLNmnYZOMpZDOCdTLbvoab6YECv5dqqop38VAVR04wdcaYI6NwUCZ1HQsN/G0Z6Y1
 dcx8aM014QCsbowFiw6+CT9yik/4sv1zpqp4pfmEMQdbt/UMWv8tm9wZIqYu/PVgoz6UIH05d
 Mh7AAd+KwlFO/YkeRpfm0X28OLtyWCkidPcEp/38gsPLExPuPoSCfHk1s+dXCRFF5uBVUfkRO
 c7p+NBq5abf7d169YmUOiQx7kAPrpn8jNBN7v+qncffDNJJh562HOveBPU2FTZbBXpVd4gV/C
 5fmNdh/vOia59Jg5Io+C3cg6tSI3vGtqfyXvKOLESOeJz0bpWsO1RdM3uHPXJy6oL3tT13w5F
 vmrRHY3cMykiZUl7tzMsPJuEVzh+MF1kV+Pe3kLEewavHKSMWF++Dwcsr8Q/NCeJuGRJ1qZor
 Djj9cd8Yd+cICASTMvKDLADuWXaYnacFRXTnr0c/O4Xh2Y6LI20DsxF+PRw0VCxdjg/hwbvF6
 SWYzWi0+YIDe6+pNpI/0tjMTmJLnHUZJRbHVhGhbUdqiNmVAPEKj89EWC1sEFPRttWmHgmqwl
 IYBeDz+TUTIAJNl+YC37bKWlyg7VwPMpG3+ymaC3ZKnDN6phGY1S4Jk3LnHtxXhT7xhl3qFIB
 5C/XtnXpxlPH3gdqiwm4ylkzL/XoF3S9Wpl6FPpvmAgYTG5gZv9CxqfuMnvORMGHHgfT+Yh1k
 hFoKNKKbPUCtiUipS0B11JpyPw/29mF8SVxdvFuxAu7+nccbjnicBvAUg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 8 Sep 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Remove untracked files that are unwanted after they are done being used.
>
> While the set of cases in this patch is certainly far from
> comprehensive, it was motivated by some work to see what the fallout
> would be if we were to make the removal of untracked files as a side
> effect of other commands into an error.  Some cases were a bit more
> involved than the testcase changes included in this patch, but the ones
> included here represent the simple cases.  While this patch is not that
> important since we are not changing the behavior of those other commands
> into an error in the near term, I thought these changes were useful
> anyway as an explicit documentation of the intent that these untracked
> files are no longer useful.

While I find it a bit distracting when things are getting fixed that are
not exactly broken (there is enough that is broken and needs to be
fixed!), at least this patch is not disruptive and since you already did
the work, I am in favor of integrating the patch.

Thanks,
Dscho
