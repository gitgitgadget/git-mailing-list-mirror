Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC44C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B300246CA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 20:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="J7NefKD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKRU4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:56:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:43171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRU4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 15:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605733002;
        bh=ixYZaLzXdFBBWQcDtcZRTMkVgHKAGjIZB/qyNsMqQ3Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J7NefKD0N0r2kZgoN+o4MUaGmNMw+K3s/BujfS7VIJbF+HrHuAE7QIOq1lrNM5PP5
         KoMMLBwnb7nzha2vbUREdT5sWb8rLXBFHMqpwKK/T+yCXGcwJrBtqQh1S4wH/Y05+p
         WZHNcPPbBghsN3dtFBQ/K+l8GaEZ9UFKcyqsnROQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1jrucY0SgO-00ngUp; Wed, 18
 Nov 2020 21:56:42 +0100
Date:   Wed, 18 Nov 2020 21:56:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] t2106 vs. the default branch name
In-Reply-To: <xmqq1rgq1jgf.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011182152580.56@tvgsbejvaqbjf.bet>
References: <pull.792.git.1605710947.gitgitgadget@gmail.com> <xmqq1rgq1jgf.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vil4JAmcdaY6aFVsalGhDFPKl+c9kRe4g78z1C+qgOG+0TrcKiA
 80rsxpaQexOlLm0h26SIfRdkQ61IyF+biHNqk95PTX2yepUvkfaaNcwd8q2RrOt2EJdG7vL
 dgEHVYI43H5kOVvg6UoZ3eBaokQTDuQ1ZRQkKdMANKGP/EiqxweCQi7uM98laXwKAPMyX4o
 E7gzz3DgKe9juUNm65yIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j0mrxwblOoc=:Rd2Gz+D6RBoKMtQZxeZXmP
 1bQ0Xd2rbdqPpsbWP9P3SCcg5hGTpuuSU1at2p91dpfXp/AvU6jPzIHblOCLXBXwGDyhlm1vW
 2xkKGd7SO5Gx4BeMZObRNoju0h3NKBmImb7HTYbqG0fH2nXELNDg3nQiaH+w6e4sMYAqMCobL
 w5jKv6LSgj3QImQv8gwniKYsKtgTs7rnKAQieQ0ItvdlWvJPcYW+Z5wGIRExtEW12sW/hdf80
 L6D7I8gWdNO9myCsHWWK/TdbWLrcy73kxBfabTUA/oI2y5/HwcH7NW1Rcfix28n94EiP9TyjJ
 KKFFugmFs0eZP79e0UCqhcwD4Reb5WtoOy+A76gkEMr+TvsTgvsEffWRjLcj9h3lvzW2mmAEQ
 WIwBpeTnDlxWoAr+kk+4y6RMk6xs9yK0SVOwPY/ec78KQI6V8zhmJzUtGFf8jx2r/z2BAehQk
 4hCm49LT6XFuYoehMRoOfto3nw2mZXx3qtDTsLBwxn0EWNPQ+fToE7KcTOO5VpUidCO56BjUi
 RiTqMh4vedoEuoAwp18k5aJ4cZ/gGdYQFXLXNUFG4MQq8OoaJfPbYxTOM6268R2GZT7WGtZmt
 LLTxaRteXCHU1GrApdRRogjovz18EcmAC5dy36BvOUy7iYa6Cgq7Y7RDUfQ5yHPSWYiqjZA+o
 kKFxTYbdHPXCfrK5t+s6zvY7lhI4SG/FHs3tnWUWKjqhf8qo0FN4x/cItesa/jHzGQ9Z+ukNA
 W98Ig6SyUwa9iRrQfvFHUVecl7cwiwTNCxtE7PrI2k/oMGgdNEcw3K95/MLF3u3A0GvOu6YwK
 T/jZVjg1jZ4m/yKO/QRFvfRx3R880CdVZ6iKT1ABhSg05ccsu2gh8KrZOKztLpdf8kdgVlHbz
 iKUbCKGllz+3a07+zCVV/06Q+ApsawpwnD3u5Q9l4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Yet another thing I noticed while working on
> > https://github.com/gitgitgadget/git/pull/762.
> >
> > Johannes Schindelin (3):
> >   t2106: adjust style to the current conventions
> >   t2106: make test independent of the current main branch name
> >   t2106: ensure that the checkout fails for the expected reason
> >
> >  t/t2106-update-index-assume-unchanged.sh | 31 +++++++++++++----------=
-
> >  1 file changed, 17 insertions(+), 14 deletions(-)
>
> This seems to partly replicate and partly deprecate what is in that
> final stretch 27-or-28 patch series does to the same test script.
> Are we taking this and then removing a patch or two from that larger
> series?

Sorry, I meant to explain my current thinking: for v3, I want to
accommodate your wish (to mark every test script with the hard-coded
default branch name individually, and only those test scripts that
actually need to hard-code it). It is not only to fulfill your wish, I got
genuinely curious what would actually be needed to make that happen.

The four test scripts for which I sent patch series in the past hours to
remove the use of the name `master` won't be touched by v3 of this here
patch series at all (because it won't be necessary anymore).

Ciao,
Dscho
