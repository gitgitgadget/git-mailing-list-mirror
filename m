Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F38C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926DF20722
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XY0b8M0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCTWif (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:38:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:56767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgCTWif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584743907;
        bh=7tP+yqaKMrB3zvypE6nSMmVcWou+Gzjz6tpn/omPNRg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XY0b8M0UAMrXdf5siJFsAo2NAFc7uO7eYgpXVqgi0fZGC6HLsCfnjWEg2svTQcYwO
         zUXrDQ8qZtagsJR6Vq0+rdZN0Wo1vwA/m0+cWsqD9M4rbbBhNTf7wedj7MUaGwOo3q
         2xL+6TbFvUttCyAWh5LIZ2gDscWSBbesH640Imgs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.160]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MRTNF-1irzaI2S3x-00NSkY; Fri, 20 Mar 2020 23:38:27 +0100
Date:   Fri, 20 Mar 2020 23:38:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <xmqq8sjudirm.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003202336390.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <20200319213902.GB45325@google.com> <xmqq8sjudirm.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fSkFu63rHZwOox92o7UazoOHYZNacUU7p9RJ61qPQNFxvruwfaC
 g9ZzDid1KxoUWEA+2vBmIrIp3cBEWJHSp0c1bMFvvz5Pxw1g1i+n9EZnAJAejXn5QnHMiiq
 Zin4W3hjhzQ9zm9gqyF+ijtMLBsHvQFIS9V3c+p/ZZpGdeLtuB5+Sp1w79P7HJ5yf19++/S
 0dccJvFm3cEZXgNhMLQmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VhmkOipdbZo=:DLiNMawVzf7ysWEEOL9NXo
 gNVFN9cbSgAS5OwTuQVVXEHXP0A6o4iI94Ld5l9wmMzZ4Al6bc4PXpqSVdIlNVde9TzTqzGdz
 KVRfw7BlNWNOk+cVZowA0g5lipwGiUYuoEpEqi5D3dI78eSP7PaMA5JhztTnp3np1Pe3b2xOP
 bbP0J31iQLUIUlmRaX8MSk1bbMms0gQd5cKq6CS4CBs05tMP+2dtbwuhe19Ye5nUkz06HjMZA
 VHwZgl75h4FtAic9LwFGgFu1+tupgFqc4esfafHn9DL/Wj2fiv+n4EoEykaPPNpz6rEZa6WyY
 RFFtVHlR1GyeOCOlRjVswOXPyhxICgVekRWKOXE9jDYqyeFFea36/PGAvw7SOSMRd3sxaqUiL
 G6dZzq1rcjK/5epy3PbGZzohBUvtigCXZy7GFCagjoerncxKyZK+Sp7dmMZzt9ZB2/qrGITVW
 lkIRuBTL4fnfSBZFkAh6BU5O+0aFuJw/N9sfPfqdJZ0EE08dqEYnIX7Ht25PmvibNc4jK+xt2
 AaE6VhiLJyfzb/m1MxrFD6VEuKROqA7WN8LEivo6ESlF+s+ZfBA+aWOBqOt8GiFlGwzoXAroV
 z8zAbgOEvE0Y/lGUhbZdLLH6aSC8d8ssF8BRmrbWvLj+AM/DVniMPHjAN+NId/D0zeGXkmp9m
 Bak8lo3Up5/iMHpCqYLaN9PBfSH6vnIp54vcfjmfDm9Y6Eg2qSSUlpxKjME2Wl1WI7WQzgck1
 +axY9WBtMe+l3bEK+N8/nWd73BX1hNK5bR4LqyaJvd8Hasn7jg7/uMRPXAB7CwCq6Qr2wUZvT
 TIinaq+ex6hgysC8v1XusrmXbJmCR3uuxXMMwoJF5BcwB0NIYGhf3W0iMsQwpmochIdvrholv
 VBUka9sFCnKz0QKR08lgS4TPCanl+6MIS1wbB2KZfqNMgkt7+a0OD4BeK1ysVcnM1YY4idzEf
 h/NHN+EoOJ9HQ6RqRD5Nv4I6BxaHkT5bISI1xedtHCCfEQ58M/NYdxAbAaGCDUcwEbjKyJYc4
 9s4DZ5jsR3dkC6XtAq9zhctV7/0W8YH58u9wuPMUK3ancyoBCfGUio+16LadpyIDAtou7fKCn
 k17p6c5fLiz1r8OlRMnw3m1V2dHuaYlNZnaetlLclMjKBLQOLEvsNORLPfMwR73bHBR6xn0Er
 GnBsZJwldzl0XGQE+kauxfu0HMXkHHpeR8bFJkzzOdu+o4NS5Aef55MnOVlBy6tpU4EPcn3aX
 xcB/IfxlD8uSu2px0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 20 Mar 2020, Junio C Hamano wrote:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > This is the kind of stuff I really wanted to get straightened out by
> > sending the smaller changeset, so I'm glad to be having this
> > conversation (again, and hopefully for the last time).
>
> I actually have a suspicion that "git bugreport" that is spawned via
> "git" wrapper is a bad idea (in other words, /usr/bin/git-bug that
> is totally standalone may be better).

The obvious downside of `/usr/bin/git-bug`, of course, is that it has no
way to provide accurate data regarding, say, the cURL version in use.

That's a pretty severe downside if you are truly interested in helping bug
reporters and bug receivers.

Ciao,
Dscho

>
> The thing is, anything launched by "git" as its subcommand (be it
> standalone or builtin) sees an environment already modified by
> "git", so inspecting say "$PATH" from "git bugreport" (be it
> standalone or builtin) does not show what the end-user, who may be
> having trouble, actually has.  The mangling of $PATH alone happens
> to be simple and (we may think) we can easily reverse without losing
> bits, but there would probably other differences that we think is so
> subtle and insignificant, right now in this discussion without
> having actual end-user who is having trouble in front of us, that
> having "git" layer in between may hide from us.
>
> Having "git-bug" a totally separate tool, that does not even go
> through git.c::cmd_main(), would also allow (and force) us to treat
> "git" just like any system component on the end-users' system whose
> versions and configurations may affect the use of "git" by the end
> user.  The tool, instead of relying on git_version_string[] that is
> determined at the compile time, would ask "git version" just like
> the end-users would when asked by us "what version of git do you
> run?"  It also means that "git-bug" can be updated at different
> cadence and the mismatch of versions between it and "git" does not
> matter at all.
>
> Having said all that, after suggesting to make the tool even more
> distant from the remainder of the binary, quite honestly, I do not
> even want to see us wasting any more time on builtin/standalone at
> this point, and instead would like to see reports from the end-users
> produced by a lets-start-small version of the tool and measure how
> having the tool actually helps.
>
> Thanks.
>
