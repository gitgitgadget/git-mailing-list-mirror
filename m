Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD2CC4363D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117EA206FB
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 14:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="F/7zM0Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIWOma (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 10:42:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:33795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgIWOm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 10:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600872148;
        bh=8GeU16ayQ9g9b7f3YtULAw/bgttRoILbb5m4Gvka5ek=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F/7zM0QjNI5vWD3Cj+9NV+Cg5k9oqT8J5lBAO0jDQ3yVcYI+dNRWg2o+CroUj2dhP
         XSSqo7L7n0F8dzGgnZJmZeVovoGa/r7vYGwyKvCc51wB1oRZr6kBtalFPswP+tSk8Q
         b9gXhahFTW8NPpEbmzKn78Oea/fenCinO1jmR6qU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKUp-1k1UMN0aeF-00Lo40; Wed, 23
 Sep 2020 16:42:28 +0200
Date:   Wed, 23 Sep 2020 12:40:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tao Klerks <tao@klerks.biz>
cc:     git@vger.kernel.org
Subject: Re: Question about fsmonitor and --untracked-files=all
In-Reply-To: <CAPMMpoj+UhKCW_k34-cGkiWFghOOu13GhPgA0V-y4ZpLVppuiA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009231238560.5061@tvgsbejvaqbjf.bet>
References: <CAPMMpoj+UhKCW_k34-cGkiWFghOOu13GhPgA0V-y4ZpLVppuiA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5+ZO83peEUxWTjVA0a1wwfHqUiVOnsXl+v8X3ISA7Ib2b5c/QCd
 Fh7KAS7KDfZ1pk/iGqw06IzxynyIXOKWezce2N1T/0Er2N3wbXFxuC2wghPfEvY8n9vTQj8
 lLGik/Lipqd+j5fX4b9tnloSgYhftKqhKBb4eMzPbE2lTCyisMv7po7DXjcU0UojgRsN2zI
 DV0+6E/BUkNT1l2TtfHDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50x+l+VJAKs=:dnWyvhElVpJ4YU9fyfy9sa
 7w3clv8vOVcBgAeVITuzk2T5MsF9yMNBKDrO6OYHzaCPqIkVobid2pccVt1zLKbuXHi/OQVr3
 wGIZQt9nKCKcsBvlKS70dhRfvDhg1OR1jowfSxnssCJKH1GAtQAh32VsroiZYn9rrSCaFd0bX
 a+bpfXb/zph2tJL3WY4gFm1dKTjZ7fD+Ad7nR82c71ZFQA+AuvgW/nX6TPkipODIdJzXqg48x
 0EwwW6ltEL5/g4I0lcbK7Jocm9EsHfHRd6u1VDZl3QoApWm1EkYg9O/oRXYGtckmr239W4d+A
 Vkz0vsOryoh0v+K/kJFWn59LJyJbAJAFWOigCpuk2/PbfxYkIkOfJtCPezlVG7sLzZH6kXq/S
 CNDB8q27ZajQKhkPNu2mSe2KKSu5GJLlBILt+DKNU0tmEJskgtbyqRpDAJ7OHOUw+vX6zZA3h
 kemcB9xTr/BZlfQmUWx6qKHE5M/XmmQh3z9NTg8pvWBKCioGL9cMH1CSQJ8HDYVukbDATcFya
 quY7BiSbylyjeVC6trCF0wxnqXTqAfDMP+hF9f+w7+uJcJdUI02K0PylDWQmUvsDY9xpWQi+O
 phimJ/ctA90CzwsAMsq0nNBLK6nV3zD0uEdT51lu0ZynbSwDO5Ht88bz33OMVM8dkfj2SuN+g
 8lOOGarsZGCym8SodefaUpkYqPcZ/JaH8qsLw9NOJqg8uiO6uk++fQbyRPDj3fLxgjL/FyAsG
 KqAhXZ+C/DqQfF9eS/8KTRi0Rkp0xpLcIIE66+GG9We3Yi/SyHrxlEh3UhjOS9/Twkg5AN4j1
 5//E9pcZe4O8RMkkKZW888x/YGtIcSVmJrT9X/rjhKvNKgKS56zuMmcnkOT7Wwj6UiQIDRbSQ
 YS2BR22OBnfS0kwmWDGGqjjRZhYohgCIuFsdNQTalozzyIq7mudrFIphOxu+gpmMz19PfEkY8
 Lve7SHOjiuRWXmMJdrNWfLOeeu/mOWzuChCfQTao3pO/FzJrI1CmJ7FwWC5cOlfZNNgywHThl
 GaEkrbgxIVjoQDxRJLEhkFvlBggIXNwbSUix0l/yZRmZTzBU4OK3OsmlrckQy5Cm9waOj9Sx0
 v9fmuyPWGOuXVru2BdcE7pFnD0QTgzW7pCGB3Q6utw8aainJeCqLHhUdiwAA7MEXgbLC58SNt
 3+r7ob7pxSZbUYqU0YDHhqerYiK1Poeca2cs2tBTnW+XeGn589ZMyRNAvX98EAfBUtcHrHG9B
 qiQXPUe2UJxUdo2PxXe7VdmCvp2JalaN7xNCa6Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao,

On Tue, 22 Sep 2020, Tao Klerks wrote:

> I've got a couple questions about the "fsmonitor" functionality,
> untracked files, and multithreading.
>
> Background:
>
> In a repo with:
>  * A couple hundred thousand tracked files, and a couple hundred
> thousand .gitignored files, across a few thousand directories
>  * The --untracked-cache setting, tested and working
>  * core.fsmonitor set up with watchman (with the sample integration
> script from january)
>  * Git version 2.27.0.windows.1
>
> "git status" takes about 2s
> "git status --untracked-files=3Dall" takes about 20s
>
> When I turn off "core.fsmonitor", the numbers change to something like:
> "git status": 8s
> "git status --untracked-files=3Dall": 9s
>
> Using windows' "procmon" to observe git.exe's behavior from outside, I
> think I've understood a couple things that surprise me:
> 1. when you specify "--untracked-files=3Dall", git scans the entire
> folder tree regardless of the "fsmonitor" hook
> 2. when you specify the "fsmonitor" hook, git does any
> filesystem-scanning in a single-threaded fashion (as opposed to
> multi-threaded without "fsmonitor" / normally)
>
> These two things combine so that with "fsmonitor" set, normal
> command-line git status performance is great, but the performance in
> tools that eagerly look for untracked files (like "Git Extensions" on
> windows) actually suffers - it takes twice as long to run the 'git -c
> diff.ignoreSubModules=3Dnone status --porcelain=3D2 -z
> --untracked-files=3Dall' command that this UI wants (and blocks on, when
> you go to a commit dialog).
>
> Questions:
>
> 1. Is there a reason "--untracked-files=3Dall" causes a full directory
> tree scan even with the "fsmonitor" hook active, or is this
> accidental?

I have a hunch that this might be related to a performance hack we have in
Git for Windows: did you enable FSCache perchance?

If so, I _suspect_ that turning it off would accelerate `git status
=2D-untracked-files=3Dall`.

Ciao,
Johannes

> 2. Assuming that the full directory tree scan is indeed necessary even
> with "fsmonitor" (when requesting all untracked files), could it be
> made multithreaded?
>
> (my apologies for the simplistic "outside-in" observations; I don't
> feel qualified to attempt to understand the git source code)
>
> Thanks for any help understanding the optimization opportunities here!
>
> Tao Klerks
>
