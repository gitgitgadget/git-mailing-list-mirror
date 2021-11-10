Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF091C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE047610A0
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhKJTMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:12:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:55023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhKJTME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636571351;
        bh=WEsIEuMODEll7aKenllvWQVLZh4OIbkTqT0pR1ELHUc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aZrqvrZku3j9qBO+aeBtXj7a2/+Is//TmszLx2BpfuBd07rlSApFvab9YSSO9GZeY
         NnspmK2bBD7nmh/SC10xN1Mt/th4aInHWwsnqtgpSckRNXsLQRiBJslv3gxx8Bzbry
         5E8owOvfE+/rTEsYHkkyAK/0rIkddzbokDZYnrlM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1mJYyR0qFo-00jJSt; Wed, 10
 Nov 2021 20:09:11 +0100
Date:   Wed, 10 Nov 2021 20:09:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: jc/fix-pull-ff-only-when-already-up-to-date, was Re: What's
 cooking in git.git (Nov 2021, #03; Tue, 9)
In-Reply-To: <xmqqpmr8x6zn.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111102000250.21127@tvgsbejvaqbjf.bet>
References: <xmqqy25wygek.fsf@gitster.g>        <nycvar.QRO.7.76.6.2111101402240.21127@tvgsbejvaqbjf.bet> <xmqqpmr8x6zn.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5evdlGmFsAZvFtbEm7XCwMsohaY/bpLG8lLkwrnO4UgoPpusQZe
 CcApTNZ1rG7m9JO9egrFrn7XzODWMNXjQEZhs0RrJebqtzKNb3MtYZDecjT79hmZvcUr6C8
 jnLf4PEwCWtXXKNRYWLhr0hjSQ5DVWpsvoh37/r/Z1eY/i7vdZl1INtzml78iV3uSpNkhgY
 /6QrMQlq0xrcayxmOddig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ipCbxmiz+9c=:/ClsbYvHtbzEy1tb4IC+qu
 VUq0pM1R33Hc4ZLqjsW9iLcS9Zvxf5ezhbRH6Ks1rhn9+hV3m+x2iDOCLbXdRUz9htcYJ+pYF
 hu3qV7cNzjhS06cw395K8k9tAkZ2+8fAD9D+JR0Ino1/ZzJuvcarTETdZtFsF1szo+MvKyAvz
 UWs8PPT+c+vM6S3PeweBpeLevRJfYUMCiJixa90+RroRWyoUfhaQVaHVcjUa5kPhRYTBlQeRC
 HCzG89/9F8KzzYn0t56ndMbxlveIyMv6NFIAtTiOp9drOY30lQgTt9/cFAvWPbYm17lwZN4wA
 9JrW1bZaTdUWoEOsnI97rtgHrvCO9orcNMoS0ryy1/U0fCbJjl7JX4W9DJQMlK5wKObr+I3ws
 FMPi9mC0VzL3RIuTwrYizSbGHCgyfhRVp8h3l1ngctN5j99fxfMtwYkWqR+lubNXBoQuA6lpP
 ATXqGExjX4P63RcFznwLtpbd/8W2KgNQLQSKLX3MRrdlZdVtyr5+XKTYlgPkYGZXqwMLF+jXH
 PPHrW5d4zsYGE+ijsiWXTG8WahPKKpmMLA3c1i5LYAHPVRZ8cfC80RRqsmcZztcfXiH/AJrsB
 QXhFjMDpFOXpdqdbKfZsFgyAP2u+VMHK1mdUXcr6JOzHJOToGtIxIO+0rFN5Zy2ujS71JG+jy
 /PWf65pKixgokxq3KZcrVdmOyc/h8xw3Bd+Xd9/WBcKKaHnYIv72sSUuz8328vHIhfr18G969
 EJ3us9Zkfb95C7bFAEuQOjfQTn4MLer3OCM1OSURYHntEaW9Bf3TxJV3R+8W3KGdy1JkUt/d9
 w1RliNBqQRPlMGqBOXVyrXuz4AxVpkbfGrANVr1Cszv0+vGwcb9zy0PSbDFFei8OkhIsvlwCs
 oHKbHb2xuhM3b/MDVBRF6/B/Y+DYgEkg7MFnSHR8oj5VXjkngakF4Woa0ek1GK05y690iKHhK
 9JcQ8ryajT1yuPHfSGQZDoda64MtLGt2hSiq6vO+KkfkC8EdW+BDyQ27i+t+Myy4Crv0k39cZ
 0sYAvOkS2l8S65+t7LVfuAk6qD1VhW/3jpFE2vm3v1ITTDXnyRAwJCuuv+otA023ZO016wpQJ
 NtcXQFCONTlmYk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 9 Nov 2021, Junio C Hamano wrote:
> >
> >> * jc/fix-pull-ff-only-when-already-up-to-date (2021-10-29) 1 commit
> >>   (merged to 'next' on 2021-10-29 at ad4753e668)
> >>  + pull: --ff-only should make it a noop when already-up-to-date
> >>
> >>  "git pull --ff-only" and "git pull --rebase --ff-only" should make
> >>  it a no-op to attempt pulling from a remote that is behind us, but
> >>  instead the command errored out by saying it was impossible to
> >>  fast-forward, which may technically be true, but not a useful thing
> >>  to diagnose as an error.  This has been corrected.
> >>
> >>  Will cook in 'next'.
> >
> > I would like to register a vote for advancing this into v2.34.0,
> > still.
>
> I didn't recall I did it as a regression fix, but as a fix for
> relatively old change that is already in released version(s) in the
> field.  If the breakage is new between 2.33.0 and 'master', I think
> it is a good idea to merge it down.

I can say with conviction that this is a very recent change of behavior,
as I needed this quick-fix on Oct 30:
https://github.com/git-for-windows/build-extra/commit/fb311a97cf82243ea1fe=
4036f1b180f5a3e6bc7f

I don't recall the particular details how this fix came about, as it was
the day of -rc0 (and I don't remember whether I needed this _before_ or
_after_ Git for Windows -rc0 was released). All I remember is that an
automated build broke because it created a local commit and then expected
`git pull --ff-only` to succeed (because the remote was not ahead, but it
necessarily was behind the local HEAD).

The change of behavior might have been introduced by v2.33.1, or by
v2.34.0-rc0.

So yeah, I would argue that it is a regression introduced in this cycle.

Ciao,
Dscho
