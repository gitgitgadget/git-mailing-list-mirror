Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC53CC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BFE2074A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bMMM/csY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHZPJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:09:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:43385 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgHZPJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 11:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598454557;
        bh=4Ykzgnri+8Zts1NRSmnrgJAI6Q2XT8jcFJjTYJ2nVnQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bMMM/csYSCEL1ZqBzyc8xLUBtycTDPWuTLUzFx6MhocHiXrKvhWS6zcU1KV9MtvZ0
         Sx7QvnUpDkZuY1+Wz2o7IHErO8tirUv6DYyJU7yhCXH0mGdqzpbLtkB76D0WYkHMAT
         5uZrdGfMV5ZQXZrwh4r1FjU9bAVGOaKrg1+bwFg8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.212.143]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4Jqb-1kBE200fDt-000L0D; Wed, 26
 Aug 2020 17:09:17 +0200
Date:   Wed, 26 Aug 2020 10:09:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 0/3] War on dashed-git
In-Reply-To: <20200826011718.3186597-1-gitster@pobox.com>
Message-ID: <nycvar.QRO.7.76.6.2008261007100.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c84kvIDgUVdPiyYKp7dOZ4LMtMAskbQlnqWliAXO0RqB7Qm/THz
 zae4/wW8j4RS6sOrQjZ4W23f90eh2o8yHgnBlOQ67XfodPygQkxH+0bTBR/lgsRix0OlSDM
 dPB6xqOCpUYgij/0c48BAfl+S/Oges6uPWFD1VoejN1PsAsISpW6VIyYuDqCzrcjjJQlDLx
 F64gy94aruA9QYWIMuufA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L2kEGCZ8ado=:Ezh7IeoJIsFos+hJ6LutZ6
 NhuvC1Rc2esljCKp+yyHuxw9Hf/gU0+uANJh/FMDBu0dIpW8B13V/oBMx9MuJrQ4OHHxfqsIK
 cbn9ft55NevDYXQobPqxhnIJwFcyEUjfJxT14VWVrVqraWx5EAcVjqB1bq4AQGJRIrDivYH7m
 0zjkjACoPsgCyk5Nrl/fylIuU+I8HvX14iX6xccdXxaEVrKXB8z2JO2tlC98QsSoe6M4nDSBb
 xQBqE0OigXjTsLbX3AyWMq+sVi1sCWYqFvYGcrYJ4pl3DQ6UOjqlcqkEv1U24hSJjbX0vFEcb
 zggbn4JDDL1GGvZQJypb4Q+URFnX1M5319om+OJQEBG7yB4GTA05nnK+tGPiW+oJVgZbhp+xa
 qq90yUSedzEsRAU24Y9nuByPYI2Mi5RHMLPaMeoAxbotYrE5q69Fd5EyHj5gq5j2+HcCmXM9k
 nXakI4JrUxVjc8ZtXgCXqHpm+3gJxON4QrlUzxkugDl9Rs9EzaaFdOc0s3uijMjWAomCpoC3V
 3zfHvjtUP7TLrPSBruCVuIFiFbD09yWI1rvIL4aorX3/BZkmYhHtEPX+H5WU8OJDI/Ojnqt56
 spZMG6L71GOHPffZ4NBzIezAfXuKia4xdqwQElOUqC4LuKGAhoUP5vtjOFw/IEElcsRxiQY12
 1LiQmJHpL3Mc8QhgGRQBdLSjrXO5c8ivP8fQmRqDKCgU1MzXcYRr4uRbUDp4GRz5gOdn15Ur2
 xyFP5O3LRrlVadF601VjZlpjMEk3IVGiymGc43FQG9GmlHA08dcsApPzUwBpjOX/0CDP/niWB
 DW1QDPE/LAODCtRxj7h1flE0B1zRM7pLC6kLOn34xqf3f7SKB53cUI0GSeu3fqV0JdqQIqOrv
 Yc45lyUkcSS+AuCmOezcIOEx+RIUOk40LXCFTgFPYDyQ6c1PwxLLTD/Ipup2VnGXoIRd6H0z0
 pdjcottBhggbLkkJdn8LOVrwfSRIt98J/6w5bGT2fvdQqOhxo0hqv8ZqjR0zN9K0iE5tmK8LG
 XOoIkRBPdA7DH5Q+PLAJ3TXJgiy6+78XkTVNuKHFn2WhbZUPLClC11tS5k4DD1+e1GBHq6Ubk
 I19kxr3CrBMX/sUvGdwzTmFdszAcE5A+rKxOMA2oWEHmGBYISdu3999S2CPQC/0RPo1DHlfHg
 o5+4a5Q1J/2DdEhmTBn1Al19DcAZ92teE4xuw3DON3LsTJJ/I5K5c0yl0PBrGAJJyqI5ppQTe
 Mz81XlBSFSE1TcR+zldvkILwdIEJZR9p1t/lKnA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Aug 2020, Junio C Hamano wrote:

> If we were to propose breaking the 12-year old promise to our users
> that we will keep "git-foo" binaries on disk where "git --exec-path"
> tells them, we first need to gauge how big a population we would be
> hurting with such a move.
>
> So here is a miniseries towards that.  The third one hooks to the
> codepath in git.c::cmd_main() where av[0] is of "git-foo" form and
> we dispatch to "foo" as a builtin command.  In the original code, we
> will die() if "foo" is not a built-in command in this codepath, so
> it is exactly the place we want to catch remaining uses of "git-foo"
> invoking built-in commands.
>
> There are a few legitimate "git-foo" calls made even for built-ins
> and those exceptions are marked in the command-list mechanism, which
> is shared with the help subsystem.  We might want to see if we can
> unify this exception list with what we have in the Makefile as
> BIN_PROGRAMS and what Dscho introduces as ALL_COMMANDS_TO_INSTALL
> in his series.  These have large overlaps in what they mean, but
> they are not exactly identical.

As it happens, I discussed a scenario the other day where dashed
invocations might still happen, and the consensus was that nobody looks at
the output unless things are broken.

So maybe this patch series would be a good first step, but if we truly
wanted to break that 12-year old promise, we might need to have another
patch on top that _does_ install the dashed commands, but into a
subdirectory of `libexec/git-core/` that is only added to the `PATH` when
an "escape hatch"-style config setting is set.

Ciao,
Dscho
