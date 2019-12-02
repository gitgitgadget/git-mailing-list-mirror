Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F2EC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 09:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55F52231B
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 09:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LSPTQAhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLBJFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:05:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:47991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBJFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 04:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575277523;
        bh=IRUQHf1evG3UE0BKxCa8RTTBdZaxoMkgUwFd5ngajy0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LSPTQAhSLzoJH3pyeAIMdZqrdvYW0cVZ8PoKx4M49OrYH96qMu9e/SeDv1FSz7mB3
         c05CTzR6YoxolfW4n3NfoIFkb13eS1dkRzFSYs0ubyf3eKf48db3HZYyuZpPsr6u3d
         GIgWQGD8JhGkgrZ/1ue7mj65qktv03fUNgTfsREk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1iK2Ed1sxc-00HiTu; Mon, 02
 Dec 2019 10:05:23 +0100
Date:   Mon, 2 Dec 2019 10:05:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of
 js/mingw-inherit-only-std-handles
In-Reply-To: <xmqqk17fz2e7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912021001510.31080@tvgsbejvaqbjf.bet>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>        <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>        <xmqq5zj12qc2.fsf@gitster-ct.c.googlers.com>        <6beaf25f-1369-3e77-fd54-fdb5a1e63707@kdbg.org>        <xmqq1rtp2k01.fsf@gitster-ct.c.googlers.com>
        <xmqqfti41rz1.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1912011042460.31080@tvgsbejvaqbjf.bet> <xmqqk17fz2e7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Aex2hro2Fh206Ngm6cwNUvrwMFviesbXp/EbGQ5sKRncOwQ0l8a
 vP6aiy7jkhDkvrmvJot+zl9Ccz2AaH53hicXJ4OKVmBf1rT1VZujhul9Vfpc9yTwEyiAW/Q
 9TIE0qNYV8c9YEQZPR8mC09xM0Eza+2LkdqToVQYoBKbe9xAkO7uFh1tiU48glVfkFIO3XG
 tI9VAwJisGezhSpD7Mrag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pMaQJyfjbU4=:CUatM+yfVRBEXc+45fZtKn
 iEACvsaYw7Z/wzuBwA1pS8+zXV9lNWoxkSII5NWjVfSPjwEwUcaY5JHbD6emZvfHo1aHJHlUD
 y9+mHX97qgjIA5RT9iOXe64ftGfIjpFefdqgcWaaFqXvtKyG6cM4helo0tvruWmKtQjc1l3AZ
 xYdW0mJ8qFKppB2sH3/C6xYgiGGrAvTMxXSoIsQntZLzdOzMt9LtxbOVrMQxmjvSmVTqfnFFo
 IqRVpnZi5X00zouMw4sfJuMZlh1SnKhKdLtJCQp5i7IlgdY5XsfLmQNHQSZNe+zGtARIaDWA4
 J5N7c7OED+D5yQrudH3DuQCxXlXq5gLTfztlQXOWR7Eikfhs0dSsAxyxaQEjm2fvu5bO3qIli
 SkpaAibWtQw/pw+kbLlSyZGiJSZclefBk+wnomk9i5IFadFvF9dJZ2tlbUOGTg0twFnDaUTms
 TMZ7ym/1PTYlXGqWhhzbfdUKozmtou63BPvcPr5EuTMpa/51LO0jH7MZIL7ZAhardaMvxIfKn
 ZFnucowwcryavRMckKEjzUyK+WAdlK6OuWlooKTMtZ2RfeN+J+te5RNGqmYha6ewYx7uxgvgv
 RhK9edtz9CbV90D0Njo/BXDmIs7e9bSjPJVE7z/BHbWxEthnrbOtgjo4q3//Vzls8nfki8l2c
 JnmMkYpEu+yeenRPrwEVwEeRrQZfGTqgiYcp8APqSSWqMYXEGgtBNCKTTyrnla3z6SkB2GUZN
 Q+DG8ATiJMF9TjCmx4FqnCeqL8ORf4Nu8g1eX36X3/eM4DRyAgdPySHANA9C5i4oWq7T9jeV8
 NkUk86OgTFO9kt7Pp2bfMGjILeEzN2kFjZYHPP5A7xf94fL+qmWiN8WBgomFyruVzzxlm/fYd
 b7nQqLuLNrUx8u4VUPRZt+lf/VoPTUTjaGDf4PYeoXCeAwfYhd9wyq75A4ou6/naUykCYV1Bj
 J21McMuMqbjzO2UhJxRELN9PZYWd646sEM0es8uVhnhFqgQw2HdIVQ6Le7mX24MSwo8+tS76N
 rurwBt3aHrFB+KGCAHf+ZgcLrBXazhdr+tfPxP8oFg1EzpssG8ytmZ2gLgFESTD4Csjbi9ZT8
 S77bOK7gMLiJVwdfOR6jgs20Fls1hZrP1rZw9UogoqKQ0/Y3PGg6NCHjcO1UxEIHVCSZweLFE
 n3QiBaeukFUWwW25W7HwzpJDWrhbUn/s8Qi/m3weirGQov5sYXCedd3c4PEKMpd8E79n9BskY
 ierDY3/opr6Xtrv7b8C5zKkbazIxVW0pVtTLifbmDHEv5jcJvCFYmknWUcWw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 1 Dec 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > But the intention is not to help correct callers! The purpose of mappi=
ng
> > `ERROR_SUCCESS` to 0 will help _only_ callers that try to report an er=
ror
> > when none happened. On Windows, which is the only platform where the
> > discussed function is compiled and used, `strerror(0)` has the
> > well-established behavior of returning "No error".
>
> But is the caller that ends up saying "No error" you mention below
> by calling strerror() exists *only* on Windows port somewhere in
> compat/ directory?  If the call to strerror() is made from a
> codepath that is common to all platforms, then that caller *is*
> wrong to do so after seeing *no* errors.

Yes, that would be a difference between platforms, but _at least_ the
Windows side would help diagnose the bug better. I'd prefer such a half
solution to having no solution at all.

> So, no, sorry, but I do not understand the above line of reasoning.
>
> > Now imagine that a user encounters a bug where a code path does indeed
> > incorrectly report an error where no error occurred (or where Git is
> > looking for the error too late or something like that). You probably a=
gree
> > with me that we should really avoid reporting "Function not implemente=
d"
> > in such a case and rather say "No error", which will help figure out t=
he
> > bug much quicker.
>
> Not really.  A BUG() that catches a call to this function that
> should not be called when there is no error would help identify the
> problematic caller a lot faster by being louder---those users who
> get hit will raise their hands more readily than those who see "No
> error" and wonders "why does Git give that error message when there
> is no error?".  IOW, "No error" sounds like sweeping the issue under
> the rug.

This is a very good point. It _is_ a bug to hit that code path when
`GetLastError()` returned `ERROR_SUCCESS`, and having such a `BUG()` call
would have prevented the bug that I fix in 1/2 from slipping through.

Therefore, I changed 2/2 to raise a BUG() and am currently waiting for the
PR build to finish before sending another iteration of this seris.

Ciao,
Dscho

> The argument could be "I do not want to be pressured to hunt for the
> problematic caller, and taking the approach to be less loud than the
> BUG() approach would allow the end users keep operating as if
> nothing bad happened, so that I can hunt for the caller iff/when I
> feel like it, and with no urgent need I can just ignore the hunt
> altogether.  Not hitting with BUG() is a service to the end users
> who shouldn't be made a guinea pig---that is why we want to sweep
> the problematic caller under the rug.  It may delay the discovery
> and fixing of problematic callers, which is a downside, though."
>
> I would understand such an argument, even if I might not think that
> such an argument makes the right tradeoff between not hitting the
> users with BUG() and not being effective in finding the problematic
> caller.
>
> Thanks.
>
>
