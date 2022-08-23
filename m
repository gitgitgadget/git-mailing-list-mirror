Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67700C32774
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 07:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiHWHer (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbiHWHeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 03:34:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A732F62A9A
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661240082;
        bh=GIyJs0vx6/XXCngv42KHA3Fd0BfhN3o8KjtzT6nUmoA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GtA0g1arGv6CSaySQm+6T3tfLwQx4jrP01E4D+6hTxl8cSTAyElrJE0aHl+5zsac5
         yqZRy7JhDS08xBopnRTfLO7qCNZ+CYbxMTqdfI+y83gVcc/61y7gIU8ntdM761vwX+
         AtTcnWarBL/cZvogmx2o3p5sG+bU9UXXOBaQdeb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8XPt-1pUe8p1vGr-014VdS; Tue, 23
 Aug 2022 09:34:42 +0200
Date:   Tue, 23 Aug 2022 09:34:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] tests: explicitly skip `chmod` calls on Windows
In-Reply-To: <p79ppo86-022r-7sss-41q1-39n499n3266s@tzk.qr>
Message-ID: <2553p8p9-q04r-75r6-5spn-8n9npno6q8p3@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <79abfa82c32ea686469cfe2417bc491c04179623.1660143750.git.gitgitgadget@gmail.com> <220811.86wnbfowbg.gmgdl@evledraar.gmail.com> <p79ppo86-022r-7sss-41q1-39n499n3266s@tzk.qr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-836148870-1661240084=:205"
X-Provags-ID: V03:K1:L2JtwcQMSQi3qSigIeXLZqPJ4dNVuWomyTwHPerp02CKT569YiP
 Bk4TqEnKdWs1UfS6HMdjr4TmfMrFGKzXdLsy5Y2t9+vS+3EnMaGG5XC4EaNjxUO6X4gZ+B/
 tOEcTwzwqAADnaEebLALjWtt8+us+17m7u8xrZ03jfn7QV8nQSHpIKJOTFfjzv+KH5QGUDQ
 EHoIuVdM2eENsHoYs4FJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xoCe2Nn0c2E=:jM8RoZJ2W+zjUPUzyT8swl
 l3ms8jU7bi7XK4i0t0tP4AQ70mpIYZHfSF8XWAwEfuW/4TmeblQnHH1F14C6pVcwYhO8VgXfN
 RY1PfuEy5x5Ag1zOkDNz4LnQ68h5Jvm85CwsJR0x26o+SyDlWMPZR3zG/ipZuzWL3YQVnnPhj
 tRP8y6uUt4dh4tST6FA0w+WQrjqkgfMuN6A2WthUMePGRQp/uQFQOhazGagCPL2Lk9oky9xkm
 N0IKZr++d7NunXe3R8JajYfVYaieFUx1LszTNGFv8FBxU5TfTQDQpqKBtw/eXxpeUP5sewq/M
 hAzUa8uN+Vru0baSiib65CZO/fCbTqSOerQdMk1ZNwZ8pWTeB/OsR7KfzI3IYQltXJ/yTuPy3
 E9EhsBPmAH0Ow4o9ag/ZjNIqViHHRQmUs+ylWhutm5f+WfhoChPQVKQUrOzgdK177eiV+k+5d
 4J2qbYwTFRbtr5bP2ff2RXkdXqF8ocHtl1IFJjbIuyeH800t1SppqyHr6yvrY1LyhZhdDJUnR
 qAJNWad+r4t5ah/jGcIApE8OTP7tw4nzoSzGUBCNgkAULScRSBoOWDQZraCMqW11fSCxH/yT4
 dS5j7CqR/hpAcqDqoSl1ajZLwy+hDl/lYZD7yewtQMWdzyVy9PVOMbnzNCBqqLQM3DUehWHo7
 oyykYbaV5AHrBUaInaaNh7mVKnLeFv26JechWbBr3+VxS3/8HOi9kEdv7laHSGoMXLYvkWC/m
 RjiUtxjPvlTrAP40YQcBrDeVuHa2Sppk8kk/8oqCWfV7W2ZsK+WhjTZ9J8Ed4LTEHG2azE8Vo
 hK/dm9n6Kwx8ZmxXPbKNGm6/XpY0AXOARcNAATv/iLhH911hc9dOZumFs0uv49Y1Y/6tJEq4v
 h0EFLu+9C31uCOWgOvHRfAbyKxFtfjD1U6dvZcHmRp6io8DURwarXY2itcADgb6dRVn5TYldt
 zwMOYG3fHzqagp1hR20i0GpGP8LbyoBueDqLNw8f5MAzx48im1qPiloqB4KqcWA8wLHbTiJL8
 ypaxWM0mWpQs5wdFEGymRw6y7Q4hd4maBsAkn2f2cIKqTYJgf3fh8Yt6E3TThH83mxsZ5MUr5
 B3G10QWoIMuln/6MGH+k3yxYJo26SJVpEDZ1N9o6wVYalBM5xWTqzsdGA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-836148870-1661240084=:205
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 22 Aug 2022, Johannes Schindelin wrote:

> Instead of wasting the run time (even on non-Windows platforms!) to
> determine whether the `MINGW` prereq is set in order to skip the `chmod`
> call or not, we can make `chmod` a no-op explicitly in that `case
> $uname_s` block.
>
> I will make it so.

tl;dr this patch needs to be dropped, without the suggested replacement.

Gaaah!

After struggling with this for much longer than I care to admit, and even
debugging inside the MSYS2 runtime (which is a level boss if there ever
was one), I found out that all about this patch was wrong.

The suggested patch (making `chmod` a no-op) was wrong: the test suite
started failing left and right. Why? Because `chmod` is not a _complete_
no-op. The test suite does not use the `-o` flag you suggested (which
would not make sense in Git's test suite, whether or not you remove file
permissions for "others" than the current user or group, Git behaves
identically), but it _does_ use the `-w`/`+w` flags, and those _are_
respected, even on Windows.

The way the write permission bits are translated to ACLs is admittedly
somewhat magical or all kinds of wrong, too, depending on your point of
view.

But my original patch was also wrong. Why? Because it claimed that `chmod
+x` does not work outside of MSYS2's pseudo Unix root directory tree. And
that's simply not true.

Whether you call `chmod +x C:/Users/avar/my-file.txt` or `chmod +x
/tmp/avar.sh`, it "succeeds" (by silently ignoring the flag that is
inapplicable on Windows, whether or not a file is executable is determined
by its file extension, and yes, that means that shell scripts are never
executable and we have to live with a nasty hack in Git to pretend that
they are, based on their contents starting with a hash-bang line).

So why did I claim that the `chmod +x` invocation does not work outside of
that pseudo Unix root directory tree? Because it actually did not work, at
least for me! But it worked on the build agents. Why? Because I have a
command in my `~/.profile` that mounts several of my Git for Windows SDKs
as "short-cuts" like `/sdk64`, `/sdk32` and the likes (think of these as
bind-mounts). And those `mount` commands did not specify the `noacl` flag.

So what's that `noacl` flag? It is magic, I can tell you. It basically
makes all this pretense work where MSYS2 pretends that we are in a Unix
environment with Unix permissions when we're not actually. The details are
too gnarly and involved to explain, I won't write them up here in order to
avoid putting even more readers to sleep than I must have done already.

So my analysis was based on observation instead of inspection, cutting
corners, and I dearly regret that now. By default, MSYS2 "mounts" the
system drives as `/c`, `/d`, etc with that `noacl` flag, the same as it
mounts the pseudo Unix root as `/`. And that is why the Git test suite
does not throw up every time `chmod +x` is called. And it was a simple
pilot error on my part that caused it to fail on my system, and I did not
realize that the problem was confined to my system, and the bug was in my
`~/.profile` and not in Git's code base.

Working on Git for Windows is never boring.

Ciao,
Johannes

--8323328-836148870-1661240084=:205--
