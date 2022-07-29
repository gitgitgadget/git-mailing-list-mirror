Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3949C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 16:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiG2QAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiG2P76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:59:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A33787F60
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659110394;
        bh=gAjgn7ZzkIm+8F2WacwCHMxoac2gwHc7faNBSV6Hgh0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NIW4cPqfWtT0StSONvlCVEmZoalkWZf93/Wk3jgsRByQOKSwQGeOAg8YCQuxvnYVL
         5YJ6PThPCusz+n5jq3uOSJdO5QmDyzxXm/WsmS3gXeAAS4jEkxY6T+siJlRHtLk88D
         Bunxt/Djx8jm9GFuQkWTKl2aBV/XXDUxmFLESHMw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.244.62] ([89.1.214.237]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1nc76333qT-00kdYC; Fri, 29
 Jul 2022 17:59:54 +0200
Date:   Fri, 29 Jul 2022 17:59:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Kache Hit <kache.hit@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the
 index
In-Reply-To: <CAC7ZvyYGSa-sH1LZ8Lo=NRXbvJsujgFYGPOQR5ZwGHJHZgoDzA@mail.gmail.com>
Message-ID: <orr5573q-7148-84ro-9rpq-nr7411s894r9@tzk.qr>
References: <CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com> <CAC7ZvyYGSa-sH1LZ8Lo=NRXbvJsujgFYGPOQR5ZwGHJHZgoDzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-373861633-1659110395=:223"
X-Provags-ID: V03:K1:0HOmmmqZf49LlZZD17rejrlngKRs6y+kWqQcl0siz9Y6VHHzal4
 /UBD2B/HswZA8KRLa4loiuhESHdgqif5bYYiYtzva4wzohI6qgtYp6pUUQ5mS+JhaKxaU9v
 SSh/d6qI/a0hCWwg9CvZUqi4FUDs4a/FEgn89kdyQsAgWdCdboqDfm8INz/7C/KSx73kbvP
 bVguvPZWGyh/h2l34vQhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ELVfNaAPez4=:Ye22lrkUOHQ1HmDvpkzCCk
 hgg29j3dTfw3hkNFGUDw1O4ercs0v8E6jjiYTdkasBXv86CD+/o/QtWRYzqlXCATu3U8KN2XK
 efuJgAl/8dfrg/5JJaOncs36QlWGKVlV+UhEOdtS4SPaAWOBsn022i2xIztbqLoEzMfh0tNhL
 TTJbDO8Ji9o8rdR5CsKVywOaB11otF+sa/qRh401IqYawVxJSWFUOpxPMv0EQZcXP6GSBtxlq
 U/k9DrY7ZuJLdcAv/H2gWhxxJLdSwpk3Rmh41VZMKJWaf5p2gkRG+PNJ5zv4QemBGVcHLa/ya
 ZnlrgwPS8S1wydBrI6Tnvai92GJhPsH6F5O0MoszZ3Ga4qmzEkpBpfLnHRxsQ7WrdP4eY4qQ9
 QF3S51g/twIYSvqSiWs5ssuVoZJgXQ7VIphUdhH1znumn4T9KRPeSZUeNf2RFkEoyzzPQ7715
 brp4nJ9Olt5bCqVaqVz6gvN/QYZ4yj71ZWfvxNsflyQrPL/+yCXjx8f6an46MMGPtaBIKxpyF
 p2pbyeXCEok32ERYvMZYIdPJfNvNXg0AQ7CvShXO2musM/CyZmWbu/9QLffjVvoSHiW9Jj7SN
 Wnq7xD2rOSL2JPKes8DGv7SzOxY6YIirEbr7TUFgszKbR4eWKAMYPcilor5QDtvXyd0ldavoB
 XgKlPiU/Hhl2IAs0/WIFfO3F9q7/DkMvx6ArZzwaPPLUeIZURz3sHLjGMugdHJUXXLg2qusZ6
 2Mb7M4szW/C2sZVHlxdU8UQhTCpwgbrgtGaMss35JUqSwNbybGFd0iUmIvlSnD8xN/npv+SX7
 9qTYkQSi5AEm/KyWAXtgL/lnSFI2q2J/Z/dCGe0KvZdkXEEoHeQhIbduAI/3/Mo+l84AzlpxL
 N1WBAuHW0NtCjVqEwzLmxYiXgHyLVvoDpf7JrV+YGfSq2+yCKhVPlaHEX2wkX4YJG6HItXEn5
 3bv2qtGk6t/rOhHvjdJwBUax2cwNB+LTc0SIv5lkYIvyzLESAvmMrgCHoZU6b930DcwC9kzBY
 N95gRTvFixN9+xubs7C4RfVbnBorkTP9yUOlaDVCvxq4QTAR3mc4Qnk0ADv8xnrOhroUZEjd9
 VViZCD3UvHkvBm+Qg4YGhGytjYFv8lxFn1/w/Aj6xHevL9kT6Qc282NYg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-373861633-1659110395=:223
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kache,

On Tue, 19 Jul 2022, Kache Hit wrote:

> A thought: the 179457 is reminiscent of something else I did just before=
 this:
>
> I was doing some "code archeology" and was headlessly checking out
> some old SHAs in this large monorepo.
> During checkout, it said it was updating 174823 files in total.

Do you think it would be possible to whittle this down a bit, and maybe
attempt to come up with a reproducible example? Something like what is
described in https://stackoverflow.com/help/mcve.

If all else fails, and you _only_ manage to reproduce it in the original
repository, could you at least try to figure out a reliable way to get the
Git index into the indicated state (if I were you, I would start off by
switching to the pre-rebase revision, deleting `.git/index` and then
running `git reset --hard` and then see whether the bug can be
reproduced)?

Ciao,
Johannes

>
> On Tue, Jul 19, 2022 at 2:36 PM Kache Hit <kache.hit@gmail.com> wrote:
> >
> > Hi. Output of git bugreport:
> >
> > ---
> >
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue=
.
> >
> > What did you do before the bug happened? (Steps to reproduce your issu=
e)
> >
> > Wanted to retain git tree structure when pulling latest and rebasing.
> > First indication of error was the `rebase -r` of the merge commit
> >
> > What did you expect to happen? (Expected behavior)
> >
> > successful --rebase-merges rebase of my commits on top of master
> >
> > What happened instead? (Actual behavior)
> >
> > ```sh
> > =E2=9D=AF git rebase -r master
> > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > (179457 > 1040)
> > zsh: abort      git rebase -r master
> > ```
> >
> > What's different between what you expected and what actually happened?
> >
> > Anything else you want to add:
> >
> > I'm currently "stuck" in this state, not sure how to recover or repro:
> >
> > ```sh
> > =E2=9D=AF git s
> > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > (179457 > 1040)
> > error: git died of signal 6
> >
> > =E2=9D=AF git log
> >
> > =E2=9D=AF git d head~
> > error: git died of signal 6
> > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > (179457 > 1040)
> >
> > =E2=9D=AF git log # works
> >
> > =E2=9D=AF git status
> > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > (179457 > 1040)
> > zsh: abort      git status
> >
> > =E2=9D=AF git commit --amend
> > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > (179457 > 1040)
> > zsh: abort      git commit --amend
> >
> > =E2=9D=AF git checkout head
> > fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File exi=
sts.
> >
> > Another git process seems to be running in this repository, e.g.  #
> > All of this was run while git bugreport was running
> > an editor opened by 'git commit'. Please make sure all processes
> > are terminated then try again. If it still fails, a git process
> > may have crashed in this repository earlier:
> > remove the file manually to continue.
> >
> > =E2=9D=AF rm /Users/XXXXX/YYYYY/.git/index.lock
> >
> > =E2=9D=AF git checkout head
> > BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
> > (179457 > 1040)
> > zsh: abort      git checkout head
> >
> > =E2=9D=AF git checkout head
> > fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File exi=
sts.
> >
> > Another git process seems to be running in this repository, e.g.
> > an editor opened by 'git commit'. Please make sure all processes
> > are terminated then try again. If it still fails, a git process
> > may have crashed in this repository earlier:
> > remove the file manually to continue.
> > ```
> >
> >
> > Please review the rest of the bug report below.
> > You can delete any lines you don't wish to share.
> >
> >
> > [System Info]
> > git version:
> > git version 2.37.1
> > cpu: x86_64
> > no commit associated with this build
> > sizeof-long: 8
> > sizeof-size_t: 8
> > shell-path: /bin/sh
> > feature: fsmonitor--daemon
> > uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Tue Feb 22 21:10:41
> > PST 2022; root:xnu-7195.141.26~1/RELEASE_X86_64 x86_64
> > compiler info: clang: 13.0.0 (clang-1300.0.29.30)
> > libc info: no libc information available
> > $SHELL (typically, interactive shell): /bin/zsh
> >
> >
> > [Enabled Hooks]
> > pre-commit
> > pre-push
>

--8323328-373861633-1659110395=:223--
