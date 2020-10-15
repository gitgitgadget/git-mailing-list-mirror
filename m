Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE6C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 12:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4392145D
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 12:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="D4NDC2CG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgJOMB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 08:01:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:44195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgJOMB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 08:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602763315;
        bh=M6HxrKofA+wO/P/gqUKFi7n9Y4Ym6RF6VmgGSXdItbU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=D4NDC2CGNR7Js9Mj50nHbZ/nP2o5O58juMqfCZbH/xXJYegOwHHPTQ7AuVtJDxfAD
         83ZYics3mqsP35xfB5/E0Q65SiHv8BkIEKkB37SpAyjJBcu2BKKFnv2tNuZjcqz4rh
         twkl/C3XXYVgXr9g+4Z5XINSLjS7gYdVxYeMWec0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.213.107]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1khol82Wmc-00EwEJ; Thu, 15
 Oct 2020 13:46:52 +0200
Date:   Thu, 15 Oct 2020 13:46:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <xmqqo8l6ku0y.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010151346060.56@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com> <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201002041214.GE3252492@google.com>
 <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com> <20201012152505.GB3740546@google.com> <20201012170527.GA21606@xps> <nycvar.QRO.7.76.6.2010131405380.50@tvgsbejvaqbjf.bet> <xmqqo8l6ku0y.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DBvGemsNXx9PXHUd/yADaahkHNn6IXRawA5/wNuO7m43HXYdWg3
 PAVJ1uyb6c/E8gRGZp1p46NcF87NtUjh1SRuS6ROJ0irlvLd8yENppgM62KfPBJLGCW8tbf
 sGdcBZ2Mfs49MRZ/JxL0kYlZF8ZpNT3fp8Bx+VeDxU9O7bkppOO7bDJAbusRVPp2DuLy66q
 hSgUxTbHV7E5Q7wJDyLtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NXjGqp9pZgE=:I70QesOHtEQ3BHlO9JvmMc
 IFoT2cvKAPYmcWkht6GZa+hHKngLDzFh7zep0oDmFl/rPYjaqlFDyZWt7MybJtuK5FKZbhe8z
 X/0q/FaEUgttU5wVtDtuUR5f9vkXWWF1EzwT2N6Drse/LTstNJfNz8SUvnuGrrkIXbAYVpBxX
 TFQqej0xHiwlTvK+HUk3+OvUyQI5vc7mpxupQoOf5v25m4HCabVFNbsCtaB8DRx78fKXphBkY
 YI4Sh4v2OSPbl3TqqJGK0UBISryf/cxKsmvX4lxX7U1ySy4Z+5O5tyRaZo4s+VA68afUgzEeH
 LYai6UWbPIQYHhz1oy3mGisJbZE4TRkctHpjb9Pbj3+AmJjtqtkX16IXvtUpypWbYkEkLfAld
 TDaJQrVOCl/ReQYqjOWoo3NR9tepiwPnJLLqWMFvzZ2PGN3QAXzZ4Nt0SJNJLV7AZlStYNZro
 u001tBv6qfKefzoZxLgVUWfPsQqr1H++x2dKXIykXj5Y0bzghHeKAbZ2A5zbvyU2QtL7Dy/f8
 Mw5ZgBmRmZVw6HMt3VwWIKwzhlnzrWfB26ExiJQ3kVlfXDRaZWjUEHPB2T5wr1liTcotyaylK
 O/09MJUdRQAsHBRSN6saJjNaQaABHABBeMHhSu5epKI/4tU2W1nFpokAaesjDBLIb4WesNtNZ
 L09mt97eMDhNoyBsA81qATiZuhmtxW9Xi9AlkJ+M6erhYeV4WH534ubkd+eKmzoWURIAYktM5
 pxUuYB8+IgLciYhZF70b29qWhhtWXBRt8iBtWhZFKsqgiuPu2sYtKF55D+m7/or6B9YNM4sWj
 uI9z/wjG5TrJ5xHrXcNKElrG5gB1yfk614dOh8OZ+KNBi+Q3c1mHi8pw2RdU7mb+wqm6NHUu8
 CgMUs+uSN3C9dZHCbOsMnQMCYQ62IiKlgyzrrollQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Oct 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Somewhat related: I was wondering whether it would make sense for git.=
git
> > to rename `strbuf` to `git_buf`? Would that make it easier to exchange
> > code between the two projects? Or would it just be unnecessary churn?
>
> To us, "git_buf" is just as descriptive as "buf" and does not say
> anything about the nature of 'buf' (other than apparently it was
> invented and widely used here).  "git_strbuf" I can understand, but
> why should we?

If it makes code sharing between git.git and libgit2 easier, why shouldn't
we ;-)

Obviously, if it doesn't make life easier, we shouldn't bother.

Ciao,
Dscho
