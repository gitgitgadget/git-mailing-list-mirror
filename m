Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A69C3F2CE
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05C1207FD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 20:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hx5EiTIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbgCDUlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:41:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:50855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgCDUlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 15:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583354460;
        bh=Kuz450OgyLMHtawFAC7VMZWi/9zEKW8JMUmzBL9q2N8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hx5EiTIMW8cibk0J5K9ESodcYPOhlUhlip7acYCS48Sff/590UG8Iqcras2fia9aN
         FtiIpB02df1ikrGtCupoZRyEzqLlim2PL9kwC0eeLE3mIGYbjquxqZdFJWDxyi08pj
         EeNDx0fa0pkidaLfEUwr4gGMkABO5/op2cTppqK0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.189]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MrQEn-1jgTTH2zzD-00oURy; Wed, 04 Mar 2020 21:41:00 +0100
Date:   Wed, 4 Mar 2020 21:40:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: hv/receive-denycurrent-everywhere, was Re: What's cooking in git.git
 (Mar 2020, #01; Tue, 3)
In-Reply-To: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003042139530.46@tvgsbejvaqbjf.bet>
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UCzhC5tM0lOfwi1Sni3HjyobXEmwPPL7ktvumYy9AW8RRnK68ck
 EAkBkPJKtVVbBFTQVC4JX9Wam1NuFeCRG9OB/UkH+1jgFqtiWK4uRbwgwKIRG5WMutH+lYA
 WZcde3xn8q8zCKL6ebr8qt/TozxN35DAcYb12b7WXZ8DMMAj2Eg99FGDch71yw8qzgqbiQU
 KIk8JFoaC+VlcygYK8j3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7wPkBG9Pw30=:PZMBUOg7HWR8PhzRR5MFRh
 k3bHXKQuFKqapwjBhheklB6FG9cGlHxUMJxYCAj/Vp09z/SANmzrqEFmddmqRdq3v+FkjZ169
 CUH9bFJ3/hPXcNDurU2/kLH3gUeb6zvev3tNiKpla/7megJey7XLlEimStqsnzhR8pM2sY8+I
 487jmOrSCspgMIwLXq0HBQ0Alopkn6QdYY6iI76jnVttGNC+t1OvinU9gtD9kp/f+BQ74WyRr
 OhKhwP7SvihJCypqZIttLgVRNWC4Sa2M0mHyQ0DPfmOywwQc/6MjbQsz7QxqfAeuD9ScUWvq1
 01rKB/+3K2S55gwOjmi0cyqJuiSEmpkrZaX76tuiINHKKXbYOzNKbAMFwSbQwIgoDYuLLyLZY
 7mHFMkxgff3zoksflyW22UmxLozLVUZWn6+CBQJGEkikb//O2Lu2OkeS4tVSiPV7w+7l8ip3x
 IaIiyTPhY4tUrFlZZO6H8zjUk0Gd4Udu7jdFfAqyoaAtHsMccwbnrOz9Jmi3hB/gIIRXqmuKm
 lFw5BBmddv8L2TxSjsKDnzV32G3L9mfR6blfe1Cc2Z6iKprL467vRgmCXyqwyol/Mze7x1FuJ
 IU+uDCUcNlDKoKVnWwVBANGfU10bdC2yBERGlOAyiS3s+zUnhYMz6Yq6X0jzsA+f4C1EuoSks
 opB2/9KdowuuBG+Iu3/2Opra0RLDI2zfQncrP1C7tSCXJCicHxDS18inROGx+YWO/vefQdLC4
 vRgNS3elXzT/BqU+dDQIkMgkV1JzxtqAOcauX6NYBi9Nj8WkZf5lh+Rcwd1FbMSFTSXGKMuUP
 j+ti5ySF5XN64SNnI9HgoEoE/fSkhBLs4+dFZ3IDGDFBtkBxd0kDRe31qG6o5jPzBteLQX8Rc
 atF1CgKG/hqr63SeLYldyUS9ezTAaPAc+hx5ruJ4lrdUZSu5U27vpjC7GgPitt2Eno7HqLAo6
 tqnkv0ssjpEtNptMvdQaSZlyiTCDY2SpsD9RTDyQDLV+7lOtZtCxWmfPmsXNkwlLCdaKqcxno
 gGuqlnpDIVl79g93E856HkIXhX2oC4+AZnwGx+Lby4kAL0WVw4izhJaf3g1Y3SOd2ziQPlHQ/
 IfKGSnw8cCHU+ism8CcPxQoinf5TWLV2SVXdc0qQunpiAsJj82MJf+Wy1XA+SB+L0l4xz7Htt
 ayIoQ6qRoYaDelw+bKHKGEMISf1Xz5tsBffV/T6O5x8ltZ4SXZwwxzNPPr+QEEl3zE0gvmWbL
 4OuVY2zvnLEjInBAa
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 3 Mar 2020, Junio C Hamano wrote:

> * hv/receive-denycurrent-everywhere (2020-02-24) 3 commits
>   (merged to 'next' on 2020-02-25 at 84e35c4980)
>  + receive.denyCurrentBranch: respect all worktrees
>  + t5509: use a bare repository for test push target
>  + get_main_worktree(): allow it to be called in the Git directory
>
>  "git push" should stop from updating a branch that is checked out
>  when receive.denyCurrentBranch configuration is set, but it failed
>  to pay attention to checkouts in secondary worktrees.  This has
>  been corrected.
>
>  Will merge to 'master'.
>

Could we make sure that
https://lore.kernel.org/git/pull.570.git.1583305200143.gitgitgadget@gmail.=
com
is also integrated into this before it advances? It only adds a regression
test case (which according to the PR build passes just fine).

Thanks,
Dscho
