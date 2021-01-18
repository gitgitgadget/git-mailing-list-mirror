Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FDCC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4961B22228
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 16:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406533AbhARQQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:16:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:44207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406436AbhARQQm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 11:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610986510;
        bh=ApyVocl6wnXSppZFxKOWpMvpapR9PkobEkedq2EyZzA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GKzN62vLoGvavA5k/3vE05ccm0P4WYKptu2vMuXC01H8Ko4CZTuMWYiltAPb7pscI
         QHaTJMNQFRUsW1swl4IDF51K/Zp6DJp1wq6ec+5epxoW59y3ZtvURiUEak4TBuAmvZ
         oZPnqeX0xE68ef5CYgq4SjeYUNHs17sc5OpHEgjI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1lD3mG2Wyo-00BfrJ; Mon, 18
 Jan 2021 17:15:10 +0100
Date:   Mon, 18 Jan 2021 17:15:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Finish converting git bisect to C part 3
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101181714370.52@tvgsbejvaqbjf.bet>
References: <20201221162743.96056-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lcMDLnfStyRwD2nmTLVE2Zke1a1+INRG96ZHbBX2OL5/CsUC6M5
 thSseIfw12A8qAX0XZOVaLbMMCDZrOxf5R5orb6/2UdbidRfvmZgE9huT2TsvoJWkOUNU4k
 VX+jnpecm+UZGPoGO6LAl48KKMny2U0Z7BKo3YGpMp9iTaTdK+BPlc/uDq6koG3JtlA5EW8
 Acz1BQ8wf8S7ylSBv8Lfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jp9pGhRl85c=:7Nj/DkBRTdxdao9+PUqDVP
 3FzuMW8XjY1u0JoLvPutigjMjxuidjSZGPVSwuxy9Jo4o8iLoog1+wsZzkSjtzv+ofSHq98ay
 69TFUMIpXDkq6C06grWZ4cpleRUwM3ITlnY9c1/JLSGdWZNXr9xxGQ4yv3bNTitfSZR8qtn+1
 H1jaPL6MMH3g8o8cAHpTBbH9g+9T2DKpblfxomAwRWjZzPXoG94JNLzQ7if4LvGhW3UN5V/BF
 gdIRhxRFHyjbrsBR5lRMFP8+uF9K4VEDJSr+ImJKhs7D+X/0AQTGtqK/2VK7mKb9ghouASZhv
 i73bRDelvcNn3MeVTH+8+PrY4kDD21IZaexIJHil3EIjOiFlgluQ+smMqTAOf1WzMh9Ylopdp
 KmUfHmTlyerhHHfzq5eJmnOiGV6+mYSs4PyWi8BTgo7h8KHJ+KX4voGVTskGvypdpiVlEkUbJ
 R4KNYX75yDvBKmcBtKTNu1gynhCUN8RRgcOF4OTzFMDJKm1DYpW1z1iyxS9V5jNKxXvNARo1R
 GKvszvVah1AFnb5U5hbq5pW89qrNdUHfld5qf8bPqw2F2BU/9Vji3szybOl9KChR0vMhscGOZ
 BxQphfMiEyWG54rnE2XMtVJvBGNWC8akEWnyVzcyv/Hpcit7x8IXNVzGnSOeqVxOyhDR7tAmC
 7uUr3S/dUD/UudmqVNTB0mtrYMnGNlbf84m8quEIy79HymqcjlYu8iU/O4B69Lf5nunvDgz2w
 W7kky8mhNb8nr5ZzFSEjLDM9E0EtIKsXTNDjFsJhlOYYDK0474sFTyH13xnaFiWmCcwJOMIWk
 0wc/5zQVttzrGJ2gPg6PtWrJVBlAFiczxAe+x3zxov5J7Q0YgmuCjUh7RjC7/Qk+OqVGVnDy2
 cdAoag6QH46EJmhcxTrMK2DLkjALfI5zSfLcMymI0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 21 Dec 2020, Miriam Rubio wrote:

> These patches correspond to a third part of patch series
> of Outreachy project "Finish converting `git bisect` from shell to C"
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> This third part is formed by reimplementations of some `git bisect`
> subcommands and removal of some temporary subcommands.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part3.

Nice, thank you very much!

I offered a couple suggestions how I think this patch series could be
improved even further.

Looking forward to the next iteration,
Dscho

>
> General changes
> ---------------
> * Rebase on master branch: 6d3ef5b467 (Git 2.30-rc1, 2020-12-18).
> * Change argv_array structs to strvec.
>
> Specific changes
> ----------------
>
> [1/7] bisect--helper: reimplement `bisect_log` shell function in C
> * Add `|| exit` to bisect_log call in shell script.
> ---
>
> [2/7] bisect--helper: reimplement `bisect_replay` shell function in C
> * Add `|| exit` to bisect_replay call in shell script.
> ---
>
> [6/7] bisect--helper: reimplement `bisect_skip` shell function in C
> * Add `|| exit` to bisect_skip call in shell script.
> ---
>
> Pranit Bauva (7):
>   bisect--helper: reimplement `bisect_log` shell function in C
>   bisect--helper: reimplement `bisect_replay` shell function in C
>   bisect--helper: retire `--bisect-write` subcommand
>   bisect--helper: use `res` instead of return in BISECT_RESET case
>     option
>   bisect--helper: retire `--bisect-auto-next` subcommand
>   bisect--helper: reimplement `bisect_skip` shell function in C
>   bisect--helper: retire `--check-and-set-terms` subcommand
>
>  builtin/bisect--helper.c | 223 +++++++++++++++++++++++++++++++++------
>  git-bisect.sh            |  58 +---------
>  2 files changed, 195 insertions(+), 86 deletions(-)
>
> --
> 2.29.2
>
>
