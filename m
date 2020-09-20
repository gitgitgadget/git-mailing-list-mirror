Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008CC4741F
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3494723A60
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="F6WXfdbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgIUWSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:18:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:60741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUWSE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600726672;
        bh=y+48euRU/4tYWiKxEpwVCUdiIox43ssj7ml7e+yvsiU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F6WXfdbdXi/jV9EFOn4fbLGI0jXQs5PShdpgbQZ2sfGqc7DTO4Unm4+byn4AZQTrD
         gDWYfiOlUs97MajMz02f11FwLXklOk2M+ghFRWb+904HgDeUYqH32dirWwgPJFxY0y
         SgiKWADo8TpkC5chDxXr14/aMm0zwVbuH2bwuokg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.93]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDJX-1koa5v2zaZ-00qiwd; Tue, 22
 Sep 2020 00:17:52 +0200
Date:   Sun, 20 Sep 2020 19:02:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #04; Wed, 16)
In-Reply-To: <xmqq363gqdzq.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009201846040.5061@tvgsbejvaqbjf.bet>
References: <xmqq8sd9t679.fsf@gitster.c.googlers.com> <xmqq363gqdzq.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W5KRajqXyDENR7LMTHkamGXEVZtMA/5jX2jYYAu0MZ/+Vo9j8KF
 gZNcyoCZuV5jkmGwSbakKj15yQCEzNMNISZGOWUw1/c9HPylCse7fkSPehZ/toVzDKBXhJb
 faNNrfj7UMSlcPY2vE4vOyW4H1HSaWdxi9//eV198lh0j3jLbaPzfFTx7gLqKwpgGf2gwFr
 bnJe5uyy3X/pMEQs+gFmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hfHi8/giuP4=:VqKIV52ASbMyxHPg/6fNY7
 LZqosd8UGp1p6xfMt0eKAQZMDYe1InLzVlLuhAp3DmnTQGneb/GxX0RRDldb7un0Ti5w018Yc
 /FVvqcn/LLewlmXxFJcPyA4VWRsGG0XJX++HJ1xgBmmqujCOwLLUiO7fj6+7FFqzl0t22nBb5
 ykecFKybR1SYyF9SBXx+5qmWlq3wJqOnIMZf66lpKzkVQtkLYImj8kwxA0QGqsvpOi9PdKcbG
 n9by/v7AAozqFe9HYahbgH8YFjQZUFlCp2gNNe8jvN0BsOwot/utjKXYkpidTO99G1gr1lNAm
 uBMDRV+ow7ErCAPALCqyXRVB+QnKB64G04LHnVMYWoFQeneR+LxDsJsRXWW/+DcK0xntOn/NU
 jv/tGswNe72Xiy910tOzdFxqkMut0XyYIsarK1QZnT9g4GKuGY7r0+UOk3IEayQwiGCjHfsN3
 9nl5E220F7EGxcI54bJFg2M4LfO9MB8R+s27J0JWuo2/Tej/W9fZR2MwB5U6oqPixpAzhU6bp
 TFTG+s1tJB0sbntToh6t+kIDF+uBzBIgq2KkDC1AdAz0/XzLNFGFyPFVkMP98OC8P/BDdN1x0
 bOae3aJu0PDPZn/ARCq4jHq2Hw14wTJDgwfA7LXrVpvUYZecJ60j3eMNIPsGbrcMV4wNFCu4L
 +n3bJFAdnrF1oyLI5J2ny01n5yEqvKwR/WREq5rvBTx18bb03Rjy4dEnLRTyKNngt2Cld/cpR
 7ZF8k41g0dNzdL7vAw0RksV4MVZd7m29eXxkI3eIDQrer2scDoHm30MJh7DI6nfSzjqwjsOzu
 g4ZcVMoeT/fsBGCkAhiAMeCSTmrnwIHZGPaXw4DdGHdIedOQ+02WdGscE4a3E9FW7agXkklFN
 ruMvbGLmzc07V73kVlm2XNGBw2PSwA6xxKEVZW55tX+ESVbQSYR9ap7wJpq/HhaP72eHa+AhC
 hbjItNUpHscKaHib79w0uxE7CbPg+ayyW+vFBQ3Z7d1z+QvxAFTXUUvQqM/Hsbj1hvPGNUdag
 YPRe+pUwyukpUAA0WW3fJzAEIhSe/W74cueVGU6udzbzO1GcUC0zXvOwkUXszI7vrLCsFlYvg
 nnnRu4rQXwJdHIzb3sB7Nvy69YVv3JifXQXuz4srfdf+yguJ8O6+OlFQPxAXbegg5jSIHtIBB
 3lg2Nzi+4fggahkxfxg2Dhs0t46uUYenTQx11lWb0HnQdH6Ups0kfs9KtTyCmkBg5ppMSSnyd
 Fjt4n7X2tHvM1XrjEkD9ztQJY8ixa4nTClGHSaw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Sep 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > * js/no-builtins-on-disk-option (2020-08-24) 3 commits
> >  - ci: stop linking built-ins to the dashed versions
> >  - install: optionally skip linking/copying the built-ins
> >  - msvc: copy the correct `.pdb` files in the Makefile target `install=
`
> >
> >  The installation procedure learned to optionally omit "git-foo"
> >  executable files for each 'foo' built-in subcommand, which are only
> >  required by old timers that still rely on the age old promise that
> >  prepending "git --exec-path" output to PATH early in their script
> >  will keep the "git-foo" calls they wrote working.
> >
> >  The old attempt to remove these executables from the disk failed in
> >  the 1.6 era; it may be worth attempting again, but I think it is
> >  worth to keep this topic separate from such a policy change to help
> >  it graduate early.
> >
> >  Expecting a reroll to update log message for the last one.
> >  as it confused at least two reviewers.
> >  cf. <xmqqwo1baop3.fsf@gitster.c.googlers.com>
> >  cf. <20200903104537.GA27325@szeder.dev>
>
> I think this is more or less good modulo the way the last bit is
> explained.  No rush, but just trying to make sure it will not stay
> stalled forever.

Thank you for the gentle reminder. I fixed up the branch locally (and had
to rebase it, to resolve merge conflicts with `jk/slimmed-down`) and will
send out v4 soon..

Ciao,
Dscho
