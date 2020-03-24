Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D1C54EEB
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D9420719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WV7sNMHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgCXVmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:42:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:57299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgCXVmI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 17:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585086120;
        bh=HQXI5rwS9+ByD0vcBDyu3R3cRRyPvZPVQhpw/TnQGdo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WV7sNMHN7+Z3VmRK14IUYWJFJNdMQh3ia/48OCgnkSwZuSEl7tI4RuDyCV2SPGtU9
         7T6/FLrJ4aNF9z2YMy9XfBaSgDl5hYBqNxqbXDgNSIgDAZQCPIr8webmenwtCBU70Z
         Zpy9gANMuVSl6JghMdfOLzHTkv7rqBBuF8jX5BM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.32]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MjS9I-1jebCX3RQA-00kt0E; Tue, 24 Mar 2020 22:42:00 +0100
Date:   Tue, 24 Mar 2020 22:41:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
In-Reply-To: <20200323213109.GA44297@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2003242239300.46@tvgsbejvaqbjf.bet>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com> <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com> <20200323173258.GA3977@coredump.intra.peff.net> <20200323180445.GA31401@coredump.intra.peff.net>
 <xmqq8sjq6fob.fsf@gitster.c.googlers.com> <20200323201547.GA35429@coredump.intra.peff.net> <xmqqzhc63gmd.fsf@gitster.c.googlers.com> <20200323213109.GA44297@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z1oJEwnT7S0/JDpwF3INzGcEQUEuK/ydSuNY7xXslhgD6aZsbdm
 HxNNuMOg5rwyKKLKSCcasFSip4kET0i0dwlxZ82UvOs/qePyuKu/IjGqnFySECQNVD8KcqB
 u5+ahVdxXVbEojnzYhT6Xbz8+66CQ9C5EKnD54UbtZlK7BORLJhUKyPRsukDLiCpQh2t9+r
 gCu9H3AzvbZu7H7yBgR4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ggAOan7BHsA=:R/8kR89Xs8xleX5rGOAir9
 +qvaVpvqfdj2WqTEtDVRubQ3koOuf3iQgM+/qq2smA62Kd8YNDSJwfJnjsFS95sr9q10+9V57
 W1fuVdM+lX5XWnwb94dnLCAR7+fszaXxsLXgBCikTmg6WjzJSoShCuUubY60yXynbR98ISmD7
 cz/DgAJcxnyscozwQh4YwcI96qpuJjNm+q5u9W86PikjsR0tKEBc9wDxmtXJEdbLNGbVHjkPm
 TkyYrk74JJ4uJRFaA0yVC9ixXyLbf/Sl6TamLh88ZCZSE0gMLjuXzbu2Ev1RS9g0Iu9ErGvBP
 1KtOIAuqwXyo+JNI4g92qVOnZMF0v1OwEFXEdukKBHRrtLC9xyE3MoDrPCOUmplp5qH7Jszkg
 BCcnrClZeE8kBX1rQKMSF7aoSsQh7Q4pAO6VVOLJ7GDTcUAuwNwZfYYKkpT4j86q4h2BvbeXY
 mmFICash+mn0RMuhYkd8V5y0LsEu32ZmP0sakHXNg2830qbKsEW8ksbIpto8hZgYEH82JadGZ
 k7M+70kQNDlRDCL9OyAjWZQ8IhCyiY/978McVQFUoZXQQpJMZE9skkMSzmVP14fcCOFKuoaFK
 lgzZNL2m98zm8OUpwjo3uSI5XIyPnSYXU1RqjdWsHdWe1Q0NQclSshOYXVFu4pMCtxOvhlhRW
 QdsjIoULKB1Oj3R4DFgguYhBqeyoAo4aZ/1gjrdHzhh9TEbW0jsNvNzF4+NwqrL6beGKxO4RL
 1aFQnl2adc0RI0pYUk9bDk/krOtBVtFM0UnICHRoxEGqzYNyUS8c4w0IIuCKxOEPbORPHM0bq
 Onek2q2DzE64DP6aP8EcL4wvcOVlEyqgMSOaIHDR/EC5KTv4blqpE5EaP7jD0v5ASYr5YOstI
 iwZ/1fZiU/gdBhmkRNAG+Pxzjj9NSvbmUHFVdJetDN6148y6cfn6xjP2mrgG9tJH2JPPW9zsX
 ycZ8ApEdcg7yVQOqlp2dj655SpV6rxkgOF3bodFWfINqubXsL06pnZqtQbVSFsgsztkgEzlth
 ZPwVKnGfiN4eGucLg6X3pU/cpgpAW50ADtI94ITWZrEEej90ukWWIGmHACILWnAp4CCVwdNTw
 Z1JDzc3PbTbxNcUKPkfRn4bx7JJLCTGlqhulY5nm2wHrS6e6VxBRdqAZoKRSBzIVicR3MJB95
 D/Iq6bAe5do9tJAAFCMjJwH7AMMBr3Q/o8cxtOM/cljNzHrtzLbUgVOG2GGL0DdUOHkwUeaT1
 pZDDBACdI8C9N2PJm
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 23 Mar 2020, Jeff King wrote:

> On Mon, Mar 23, 2020 at 02:28:58PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > Here's what I came up with that I think is suitable for applying (th=
ough
> > > if you find the GNUPGHOME thing below too gross, I can rework it as
> > > indicated):
> >
> > I actually think it is perfectly fine to mkdir and set the
> > environment even outside test_expect_success; that way, even
> > GIT_SKIP_TESTS cannot omit the necessary initialization.  And as you
> > said, leaving the environment pointing into the trash repository's
> > working tree should be fine when we fail the GPG prereq.  We
> > shouldn't be running GPG at all in such a case.
>
> I have a slight preference to do it in an expect_success block, because
> then we'd notice the error more readily (and it gets the benefit
> verbosity and tracing, too!).
>
> The thing I was more worried about is that it's technically a behavior
> change to set up GNUPGHOME when we're not going to use it (as well as
> create the directory). But I find it hard to imagine a test that would
> be affected where my suggested solution wouldn't be "fix the test".

It is _half_ a change in behavior: in case that `gpg` was found, and does
not have a known-bad version, we set up the environment variable, _even
if_ the test-signing fails. In other words, we don't roll back the
environment variable.

As such, I figure that setting it globally _before_ even evaluating the
prereq is okay.

Therefore, it is relatively easy to turn this thing into a set of lazy
prereqs, which is better, conceptually, I think. I am in the process of
making it so.

Ciao,
Dscho
