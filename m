Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4974CC64E90
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D1217A0
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgLBNNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:13:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:39317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730071AbgLBNNn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 08:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606914723;
        bh=wzTELedO6Zb8vqmPdDJdj8qbSTVo4ZYvnGmQbagXtnk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KQ+YL2TIoINuuG+Um6kpku3zuR04A945A4AQbP1as84CNnMe3XrRVBs4GPBMXDkpE
         U0t02t1lKbhMtpI2OsWa5w4f5IZTKChTDFws1RKAhmurLVNcN+YJGZD18GeEuqAFwW
         jbBP2GYC3h73i42j1xlNzcxiBkk4gr7EVUQr0RfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1jz4yV1HyO-00yhbR; Wed, 02
 Dec 2020 14:12:03 +0100
Date:   Wed, 2 Dec 2020 14:12:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 0/2] rev-parse options for absolute or relative
 paths
In-Reply-To: <20201127231916.609852-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2012021410560.25979@tvgsbejvaqbjf.bet>
References: <20201127231916.609852-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:u49n06zeuv/SaufIds3rPJDMsMOW9dnBABUeB2fUNggJ93zT3Bs
 en60LTpZlsvIn3hYqymYX2K2WLr7/WOZTZF/SUr3IyJavS+1swAfdpaV9HZqzfeewWKF/TP
 vx99kpRtn/axEJ/rgwdDxacLrPkTLQshIgkV5ys8QwDh51N7Gg+Bsr5KsRU7ztfZRwb304/
 9+R7inPVMOvZ3CWaKGMsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hi2VB6n+ZoM=:jvdmDjkYvoucQ7yzFxywZ/
 I0Osk0q+Dq/sHB2nK9fcyq2+dujwWkIuAFLpXZzcFSPHP1Nydd6SxOsLZJfT1buY2AXmxfWFz
 C4HlHz/nDww00BGHSZYbaWrqjb8BR62KX1tJ7vpOqdQo2fUUop10l65T18yJF1mj2h757iaNq
 ILPDWuWUVCLYD3ZM7AD/sI9tYL4eCxdlzsGVXRyWsYv0tDBw2B2dU+k0CibLqAMEG3t0JMAsO
 XUHLyXzcLiklvEKSB//DPwJR2Xxi3sHJS+X4F8ofRGFvlTnSEx1xffbU2PP+7py5+faFpr5+C
 uYAXOx1COlLNID7nSA0w3MvpzFa75d6v9xQn8NjkR7zrE55NgghMTFGQ3xoqgO7GSHgMPghBn
 BBWyT3HNmt4GdsoAf7ztUmXJv1hWt5rZ3umnhONN48oxhpVu7Qmop+dec2sm9gXXwrv/fgttQ
 mj0SLJHkJJDPzrzzlZZMaxSBW1gLceK/HjsoSpTxoJeFyJXn44HRVGFMgiX8ppgad+QEOj2QU
 /4x1QjRMa7cd+Qlm4wjnGxhcBz6agXlRWP+7oD1yzZN7c8MmlTmKM3PbGAY1DWcXBZ1o1LRzc
 mjGIHqBwuEfAEJMPumQGly2zT5e9gGyucCdBcMhlbE9/KN2GkWaB0puAA4lExYEeOPtagoSwn
 rJ3Y65f9qQByUcYW9i0fsw42IDFiXgAbVP0xaiXRMezH+lDkrPYRL57dXFTKZN7iRKF21yGF/
 Qi80mS6uHkhUqW5Qy0jrBvclNyizCbKY/AY9M0s6Kg0ThCakTa2Q9asaG1VuLMgNQdnroalTP
 X+IUXHZ+8ZpcC/IPUUX1XGlwt7VsUKQPHlu3EYYm10zgM3/x7R7jsU0wZUt329tqVzfnEc+Db
 bIlMl4Uou23Mst2ukP7T99d5nWgzkpxMgr6dZjmWE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 27 Nov 2020, brian m. carlson wrote:

> There are a bunch of different situations in which one would like to
> have an absolute and canonical or a relative path from Git.  In many of
> these cases, these values are already available from git rev-parse, but
> some values only come in one form or another.
>
> Many operating systems, such as macOS, lack a built-in realpath command
> that can canonicalize paths properly, and additionally some programming
> languages, like Go, currently do as well.  It's therefore helpful for us
> to provide a generic way to request that a path is fully canonicalized
> before using it.  Since users may wish for a relative path, we can
> provide one of those as well.
>
> The primary impetus for this was Git LFS, which needs paths to be
> canonicalized in the same way as Git in order to function correctly.
> See https://github.com/git-lfs/git-lfs/issues/4012 for more details.

Sounds good!

I offered a step back that would allow us to do without
`count_dir_separators()` (or `count_components()`) altogether.

Otherwise, this patch series still looks good to me.

Thanks,
Dscho

>
> Changes from v2:
>
> * Incorporate multiple missing segment support into the strbuf_realpath
>   code.
> * Switch some invocations to use DEFAULT_UNMODIFIED, which should not
>   result in a change in behavior.
> * Rebase, resolving some conflicts.
>
> Changes from v1:
>
> * Add a function to handle missing trailing components when
>   canonicalizing paths and use it.
> * Improve commit messages.
> * Fix broken && chain.
> * Fix situation where relative paths are not relative.
>
> brian m. carlson (2):
>   abspath: add a function to resolve paths with missing components
>   rev-parse: add option for absolute or relative path formatting
>
>  Documentation/git-rev-parse.txt |  71 +++++++++++++---------
>  abspath.c                       |  33 +++++++++-
>  builtin/rev-parse.c             | 104 ++++++++++++++++++++++++++++----
>  cache.h                         |   2 +
>  t/t1500-rev-parse.sh            |  57 ++++++++++++++++-
>  5 files changed, 223 insertions(+), 44 deletions(-)
>
>
