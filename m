Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E31C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FE920747
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Jp/Z60cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgGAKmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:42:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:59575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgGAKmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593600166;
        bh=mZdsSx7JD3g+8mu86IVTTBE/ECEfpvSwBy1CbpZWK6o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jp/Z60ccHoDSjDFXk5klSwb9Y/94UxwL+TPTGYKZLy0AQgnGa2u8EnxdoFJImNH6X
         fPjxWUsGjnnbpnCy5xCxvH21h7o3x3ISalz4YJ0KGpwxdO1zytZ7PkueWqmYDSrGkq
         TbWcsnaZa7cBRGaWV5rcaJBJ6J4jttgfDhGnFb4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1jQuT03y6N-00RFSe; Wed, 01
 Jul 2020 12:42:46 +0200
Date:   Wed, 1 Jul 2020 12:42:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 0/3] Accommodate for pu having been renamed to seen
In-Reply-To: <xmqqpn9gee2l.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007011241560.56@tvgsbejvaqbjf.bet>
References: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com> <pull.668.v3.git.1593087539.gitgitgadget@gmail.com> <xmqq366j5d57.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006291606060.56@tvgsbejvaqbjf.bet> <xmqqpn9gee2l.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1BZ0b5GhdIqZbDg8TMoYxp3KXXqPK+h6rmS606o6CRU3K4zikTJ
 ZdVH2eVQXW5JoSqAKh6K5QVFvhZDdcUnJ36UyS6vFNJw3y3zmIe4miIAdzLOGxlxM9iaCuf
 BDtaArLtB3eX4SuiQ6XPBT8AIdJkcBGhARiK/zrgjyyrZjJRfDAFpa7/q7uo6uYQz+8A6vK
 mpseIfDMETi6siflsxdOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L4fVAeD84AE=:XSDYqqnhdYh3aSApeIy33U
 EFMHD4Gb2dQCkN2MfOtJAygQOj+0o80BusyWds7sgjZyP+en36KECiN+30UFctsKUnqhrHb/i
 4HGfP0+mIv6DxOcN1bxOjkCKYko6eI0aKx39iYGFMPjZNmfBxCuNrKUl8Tdqk4dEfUEUkCRUv
 ev/6+pybUIhgJVo4dvf4QAKv7GA23uTKXMFmUDOzEKcFcJy3/QLMAzDyds5+60XmHQ3n9WOM8
 uVxyIVvA6gsn73Xn/dssL7MBIcg70+asgZY6UOjqBQNiwAWybTNJzxGltkEPI6g5zlCanZHoW
 5o98bHl0Q6yh+QVEPn3LWG/yC6Np67POOEHs3itUpD2OoUQeoEvZGA6FRHrnohXwJsqUj5iNJ
 /iVpMzNpEDdoyjFW8FLt/KYYbRghf6eMRSp3GpHOrsiCtgvCzUyCFC9lljHYjYUqbIwxZhh1Y
 An7jlWlSw4Cqpup4kzUEuc0mnvvOB341YLsitAMao5pgBijflbIPPpEgeaNR3hiwM+sPLcF7a
 NaqTF/u8m8SPW/urUJtaU8jB3DM6y3b0FqRJKBTVdATHl3dgEbscV7adZVST62QGsyV3wvoFx
 h71TW3lm4DAN6ztP7PCe18im2G4TCPTAqME3MkgeHJ71YVuY+d2aOtlvUQx5eQ+HdOaU8avrK
 /eIe7H9X0hVLPsFOv50TB75PjvonjnI8bleBEhg/9UPIvbd0s3nEnsX/Dvwt2uSA01o4vV+1m
 jz5sDSFs8CP409z6tx5KJfol/EYSgha4veiKLgeOTc5q9y8suOHZ+hUfXF3A1JejCMk8cx/og
 xKg8k9ug7e7f10ecXGjjJarlZnh5aWyzy2JCVd5ivk2/5VLCC2yeY9Myja+9pceywiLBPmXI2
 e2qQa2Lqcl9HgZNyePuseyEOKDhFlCadzZSyjPxyCMNTExYhHcr2GkBJhUfzN+tqQV3TIA+zu
 eTPxhstzCM7M3yl9Di/FQ0BQUfP+Kk79pEEkk6a/BO7YlKQlFo0AMoN3F1B+maiGFddfzzFHj
 QXIxZd6yIMr8KFTyMEy4NX5+6qV9iSPszNRwEwXkamEkpxetpM16ULPmdKhrb70MhQrZHlCA5
 rZxlMFkew1P6gKOTQab+q6M9I9glYPAxmNCVlj3P6Ktl0m9hCtlVkfjYdp9A593Hty+A7fAnc
 WciM3P2WSijEG9f7eKpGNGHU6ofajn5+6hTNxU+4Y0mX23ZUAXqjbh0lfMnISnziNaby0ds+N
 MBwF6t4anmdsQTKpf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> You could have just told me that the fixup queued on 'seen' looks
> >> good to you and squash it in the first step instead to save one
> >> roundtrip, but replacing with a new set of three patches is not so
> >> bad, either ;-)
> >
> > To be honest, the GitGitGadget-based workflow makes it quicker for me =
to
> > just submit a new iteration.
>
> I do not mind seeing a new iteration that gives easier time for
> others to comment on the version that is closer to the final than
> the previous round.  The offer was only for contributors who find
> it easier to just say "yeah, I am happy with that change" than
> submitting a new round.
>
> > In fact, I did not even see your fixup until I read your mail.
>
> This I actually would mind a bit more.  The reason why I publish
> 'seen' is to make it easier for authors of individual topics how
> their work would play with other topics in flight, and it diminishes
> the value of it if contributors do not pay attention to what is
> queued there.  I expect contributors to fetch and look at what is
> queued in origin/seen.
>
> There may be evil merges that reveal subtle interactions between
> topics, some of which may involve the topic an author may care
> about.  There may be fixups for problems that were not found during
> review but only found during the integration process.  I try to
> communicate these back on the list when possible, but the thing is,
> a day does not have sufficient number of minutes for me to always do
> so.

I understand. And I am trying my best to accommodate.

Ciao,
Dscho

>
> Thanks.
>
