Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2833C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BCEA206CA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 11:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MMYTTxzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJBLRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 07:17:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:40491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgJBLRl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 07:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601637449;
        bh=mNH9IdHHoA6GKC5mPRE0FFY/3R0t0v57n16johW78iw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MMYTTxzls/qiKJF7mPx8SeopIHLx/DNJBRHjDcEkVI8UqV2zAH+88fA7QyNp1Y7cA
         s4TQtrn8K0QN1UJ8zOQp5/vnW5axabOty3QaaHM3haRVxP1qz4SDyZmwSanFk9miXk
         rAiJgUm+rTRg8tjOSatDRCKjef8jjOGSavNjPry4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.8]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1kDtDK3pA6-00AX0T; Fri, 02
 Oct 2020 13:17:29 +0200
Date:   Fri, 2 Oct 2020 10:07:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows
 compatible
In-Reply-To: <xmqqpn62c5q7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010021004080.50@tvgsbejvaqbjf.bet>
References: <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com> <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com> <20200929003000.GA898702@coredump.intra.peff.net> <xmqqwo0difdh.fsf@gitster.c.googlers.com>
 <20200929004448.GD898702@coredump.intra.peff.net> <xmqqsgb1ier6.fsf@gitster.c.googlers.com> <20200929030043.GA905754@coredump.intra.peff.net> <xmqqeemigawq.fsf@gitster.c.googlers.com> <20200930223913.GB1908000@coredump.intra.peff.net>
 <xmqq5z7ug9gk.fsf@gitster.c.googlers.com> <20201001135417.GA3145610@coredump.intra.peff.net> <xmqqpn62c5q7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nubllBrEuHj3P8ZgJiujB78wF3aBVgK57++BpK8ygbwLM+jvikU
 DEqkYdobwPr782IToRea+Eplu2SIODk+OwN1DFdFLPJ/lUT5A5pi2CZYf2Dz3AeMzi8tu9O
 4466ijwupDMl50pGrkdJDwBW606dHMmWdclsGy2D7uf9uNu1vkoTyaCURB6Q4jkPpcvBGIy
 G17G2DllsO6o1I3x81Dbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mh2fC45JmaA=:11oUg/NBfv08PuFyIIrkoI
 43IcheDodaGbF/8lv7wL2UpCWY0DKtQGTR6TvuTFxVK06IQxo3EGug8M2OH6EcLzTUY92jAlD
 jPA3u5srQ6yQj51gVcq4YBrEoGfw8nHMC/IN9U5fVoXDY43vuU9CqA26HU0ew4xrNuVuzWkrO
 4L7WVurSh31ok14lFrClWWECNJR/4sxqCij8qT+puanHNXrPurLc8L0i3effKxVr7Qb5r9XhI
 MKwTPyU1Rb83UMjt2eY+MGR/7mh00is4Dsecg5hnUTIUzsemXxJBYAFWR9fV5LoFZg+mvJKsU
 18qYwk7mt3o45keWOvhirIVvuU7HF3CU5f5UDpgTsdK2rG4dx+TcOP66KwHIeIcFQoHN0n5rH
 TY2vIj8txgv09NNryzY/qvRKWvNyPq9LlEuqPsLJWBJ9Q1hpr1yVz48qDnrjEwor3J48A1Y2i
 vwpznlok4z4e0fYpiHcHeOeaH82ioZ73oc91qYvSq70mb+7p5AKatZnq989w4amgljzhI6x1G
 pSUdXBbwluIlPcgyDwz+uhqzfX5fh4KDHWUTB0OsQ2484Fd/MBPZ0xWEV6iEB9eYRGaZmuzEH
 Tq5HyCBaSCVTjn945bdy/i1E0wOfUZLPGJvfPJRj3EU8mKbkWG66QG5I0LYFOd5C6CgSmYky8
 ZR6GuMunze7lgM9GbQncH966b6pLR+ImrzyfXhJgxtBDedQiZILGPfzsso+J6/yD5Gl+cKZrQ
 3Bv/MbsTfGwTzUjHt0NBVM6KbckaUTMMGlf5xkp3JrigKhrP7yqepdwGGNKDNjxqDVgcsq+sV
 NzB+5se7IYG4RRimoo8ge32HW4sEQ0wgbYCMLMDjSCqhoAqbygnlg9XOi4jqnHWUztzG04rXk
 RWElxAYp50j7xtAfW9cHQOEmJ2aZ9B4+rOITG5ersm5F4hf6g47XSfG3ik+ceJ37nxzccUIF/
 0Cx1BR2243Tqn8l1zAQW33JEJNI3FN5GiWNMsT3Ceu0/PgXlE0skGTkNK4LpiChpbOJx/e9Dk
 fwi1nQGadk35AXbAyD9RlxChzQ1n1RGid0F1RLJpTTi8Cwqv8nxnF1faMDFPtBud5cSo6SrLI
 3XAg1QDLt7JUV4F3+jlAw2KP9P+64Zc6gW4xKT9dGx8kHXwIYnBsX5VPlsCB18SM6AI6PyCkZ
 6woSdFMIf+2Dh2+ffnKjxYtLfLJfjGaZVEm66Q78r6dCrrwzCtlx2DTctokFqYuN5Z8DqmocJ
 xVWpm4zRatJAxITZctfoZWEuRTlMnlj3ovdavkw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 1 Oct 2020, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > Yeah, I agree that just teaching git-credential's stdin to handle CR
> > would be an OK stopping point. I don't have a strong opinion on
> > credential-store's on disk format. At least allowing CRLF there is
> > _plausibly_ useful, unlike credential-cache--daemon's pipe. And I doub=
t
> > that making the change would hurt anybody.
>
> I agree 100% with all of the above, including the part that says it
> is also OK to let credential-store read from its files with line
> ending converted to CRLF.

After mulling over this, I am more inclined to drop the credential-store
changes, too. That file _is_ an implementation detail, and not intended
for interactive editing. And as Carlo pointed out so correctly, the
regression tests were not introduced "just for fun", they really want to
make sure that we keep handling CR/LF the way we currently do.

So I will drop both credential-cache--daemon and credential-store changes
from the next iteration.

Ciao,
Dscho
