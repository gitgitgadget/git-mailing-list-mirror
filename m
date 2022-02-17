Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F4C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbiBQQGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:06:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiBQQGu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 11:06:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4756547
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 08:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645113988;
        bh=91kS9BbJPbsWHEyO8OVL0XpCo5gif0S2XutenC82Y7w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cgv+ZQNo76GsjVwuXkCGtrTehzILuRv0YAJXWpBDSEeCjVTnHjVVcWThS2cw6rEDL
         BTYdDI3L0fvynfQxOlj3xhNDki58TpTEeNy6lJat/4bvwLGpIUJgOWHZwswRBAiFiP
         u33ejUhXdL1dw6zTxWyxiUAV9irLRV8yWU8UNyHw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhjF-1oGFlq41nF-00vg1M; Thu, 17
 Feb 2022 17:06:28 +0100
Date:   Thu, 17 Feb 2022 17:06:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com> <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MFVb5M4KK0SGB6I6MmtiOHeAU3h2fLa8pew0lAeatmVoZM5mVTc
 +3c3MN1Qrs9dOnu1p2R8AhqdfsUd444ojqTyx0s3SG9ggOyPY0ajCMhLAclhxHxY9aue8ry
 pRTh+YKjFiFQWU6AoHuGINVGNJxS15PxQ+Zw+k3UqGgUl7cWQUpAwC+f+/1rQSThnmgA3gh
 MuJnZIxjuahpNCJ5b1eZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRm4HdyW5dc=:OYH+IhRygMVRbnKfJ68nKs
 MlCViU2ZZ7SNQBE0k99HR08GzlFUW3WzkRxP1E0XU9EJcCSrlvCHJjvtexxgQPTfzb1G+/6Rx
 75f/POxCdJ2jhw7DqQ9alb/BAHI5oNB84quA09nWBFFydZPrm+ULJLwZWtaQe6956QhEJmXUY
 49lYFu+j3M2IXquLBZMunF6wjzVSkOOu2K18KkIy+NsZptVAk7ja5tAr1XJRot6vlGOnEXfK6
 fO4VNVuA7g4U8KS4p7U3OXcwVhbQ96NJy4eCTeE/1ea4by7hetslKFtE58ht4q0U7/BP6aOgw
 /gjSRFFhWXhe1d05+tyi12nG3c1iEi0GK8+MDlSSdAzzybjBIIxYZX2zpX39/5aq2vSkc7H41
 VXRuWjWG5uv8CUWat1309T1G8pjqk7VA9wRH21t/Qv1d+yl6hv+owWfyThTKQAgnP7y/UvflV
 DZ+htR4xwx3hf2RN/sjb6uQWomNN2/ot36o/a/ziJfFu/ipK4uZuXW+yWr65haPJ7ZYlMXtHe
 b3P0ROvokVJFA/FDPFj8q+qdwNZfzjw4VTudJTweh/cNMDPk1ca8oT2E6/SsFnSgn+8eJLltp
 b+QX8+AVywY0lDxZiAmmYeVqeJXRqx2VAXKXw3bInIyt8D9h8xfhci/Bh5vCWKq5Pr67Mgx/B
 K44U57goHipa3CY8DhcowKAMahnJmxRbp9EmQJqnATy6AwljeAQ8KxFAmcQZxdDOPEy77ISLz
 IXw9qvPNWcJKi09bbhIlmwRvMEu/pynJTcWnkHQ35gvpDX+tpoC9w9mRebqBMJrNv9quYrlkb
 gORT0rlqNHG2OSQgEwgV2wgIRcNNbkFQftRlhH+AG4KcDE3kuFjn2hs8roemEG6nWX/1Su22t
 IKryStJ7etOiB/qnjqE//S6PIVK7QMB67vT21YZBuZbl3nTQqVuigjvOGO4wqGJlEdngaqPT0
 w876FTVmXJe44bOabmLhZd22lzOTBM7wFqskuw3RovOtVDTcI3mbWAge2ZMcRvspH4eCXUAgC
 5fZRYw+UMVKnH+mm+A93NDITCSPDW1xjcAXtSVgLMc3vZLGAP6Paa5cE77+o9VZ3VY8b2qkJE
 G5cjMo4vhmxWH8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:

> Here is V5 of Part 2 of my Builtin FSMonitor series. I apologize for the
> delay since V4 that I submitted back in October. (Insert the usual $DayJ=
ob
> excuse...)
>
> I have rebased this branch onto the current "master" branch.

Thank you for your tireless work on this. I do see that it requires a ton
of effort on your part and just wanted to let you know that I appreciate
it very much!

> In this version I removed the core.useBuiltinFSMonitor config setting an=
d
> instead extended the existing core.fsmonitor.

I am somewhat surprised that a reviewer suggested this, as it breaks the
common paradigm we use to allow using several Git versions on the same
worktree.

Imagine, for example, that you run a Git version that understands
`core.fsmonitor=3Dtrue` to imply the built-in FSMonitor, while you _also_
use an IDE that bundles a slightly older Git version that mistakes the
`true` for meaning the executable `true` (which is not a FSMonitor at all,
but its exit code suggests that everything's fine and dandy). The result
would be that the IDE does not see _any_ updates anymore, but nothing
would suggest that anything is wrong.

We can probably warn users about this, and we can also work around the
fact that Git for Windows already uses `core.useBuiltinFSMonitor`, but it
makes me somewhat uneasy nevertheless.

Thank you,
Dscho
