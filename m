Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD5DC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A82417D
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LnpFf0qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899386AbgJVNLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 09:11:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:47107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899383AbgJVNLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 09:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603372309;
        bh=FVWTrK0LlU/gYzcb/QsVrcQouZbiQmuKRkqpWy+Dh74=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LnpFf0qphUDBStOTK8/TeqzdTe8JG8lM2/7JXKsjIVYD+6hZfrRjvUKNySRJ4AVHH
         qcPDFOPq1/hKXW9bNxe/910PfVYE8jYvIr+BCPwBgT+msXmnJ/+RymU0ys5hHfQpaM
         CflXmxCCO9SSHaEmqDTKuuI0uUPJHTklI/xu8sas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1kMkk92ofw-00zjYT; Thu, 22
 Oct 2020 15:11:49 +0200
Date:   Thu, 22 Oct 2020 15:11:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/10] Prepare for changing the default branch name main
 (last manual part)
In-Reply-To: <xmqqblgv5jfk.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010221509430.56@tvgsbejvaqbjf.bet>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com> <xmqqblgv5jfk.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yI7GbZ4vDMgaC6UtkwDEfOd6/Um5M0VPz3AhZZ+5pNbry2uXTKx
 lul9NXfG90avPmyO14o5d2lOvKhaJVq0qbZ6cwt4S4Kg+PJGv3QM2drGT6x4oy5f3Gdaylx
 S6helKXyudU6n/+kYhil0OVMpUkXjYXN2Inp86FEhWVNrY/yEAabByQITBAmP5JxTMSlYSD
 u5JaYP944pJG34LYHh/ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fnwIywFYdwQ=:WPTrB6lXIlGyqe2NVIwGaP
 j07vPKhrqJSGqQoohCb3xJVEdSKTa5tu4yOrA+7tDNZtJnyk0dev516WKFhgZf3NrTvwIU59G
 kZSZ/EsljZKYh3RuYH6bwdO5y+ISLhX51d9mikMbkw0HcrhMyOwB1cltg11GCE9NIFTQv41NK
 sZvn8EAZsxZZp+Rmsd26Ivg0AECSIsbG+GHpEq8AMCsD7hnYt0MsfOWWP2Vt+qleIg+pqJhoi
 v/ooNvFdf9cWtgwQi0hJFGc1Tmyfkd/W4lx29ssUhTrDzeTlA1NpGNcZaRN97Y9mWoG5aAK/A
 ksmoQRwENpi6oXGcQrFCWiXYsotP0zgxiEbLGsGkyWyiDGrFZ99NQupT92m4Ssi3F7NYFYuQu
 cV2YUz3RbNFT6dutODg5nLGfkJy5W6oJjvvNWk0X7QnUdIW1zzCFpWtgOPI8RcCrBwcpENtEf
 cCom07PaHAJSGJibw/HCpukgTWM2221VyV1cy5FYJgyHjwZ6KHKupFustHK+NwO+KZ15P2vrC
 eVgZOxtgPBi0XdaKq4JZN1c3L34mcL2rEj4rDPKEo0Y93bay1l8ruatTtCNxsyH8b10loz1hR
 eNJ1k5mfjOPFFy+/KWHzlPak+NUDeDTe8mJKtWT/v9O7upkPryuRzLScsGAvinx0Qejk84RpM
 Or/Ind9gHP6me9O+QGd6vSjcrRyc5DypXwMMk/3Wtxeix7ANE72fGIHUK8mgAiSHwx8P8JeQy
 2OhNUArDtj+/+JzSU6iDGPaiaeHk8HipV7KPKBJYcQR1ZlwnIkQqrl5fl5OuPUVn1iPGVUbE8
 zhDpyyANbZuy5yflVxh95rr1P0UMcdtVaKknZPFk/C8KLuCNs0LyZ0KGNsvkgAavXOePdcHRh
 mpHDhz65tJj/u93emqlBnqi2tcLAHdnoKlzC7rR7o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Oct 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > In preparation for changing the default of init.defaultBranch to main,=
 here
> > are a couple of manual adjustments that cannot be automated (i.e., the=
se
> > adjustments are not mere search-and-replaces).
> >
> > This patch series is based on js/default-branch-name-part-3, and is pa=
rt of
> > the larger effort tracked at https://github.com/gitgitgadget/git/pull/=
655.
> >
> > The next patch series will be largely automated search-and-replaces;
> > Obviously, the search-and-replace was the easy part, the manual inspec=
tion
> > whether the changes are actually correct was much more involved.
>
> Yes.  That's always the pain-point of a tree-wide change like this.

To help with such a huge change, I tried to minimize the manual patches,
and wrote the exact shell commands into the non-manual patches. Hopefully
this will help us with the transition.

> > What to expect next, after this patch series? Essentially, there is th=
e
> > large patch series that adjusts the entire test suite, with two patch =
series
> > extracted from that effort: t5411 and t5515 simply require too large
> > patches, and will therefore be presented as the next patch series afte=
r this
> > one.
>
> This one is already a bit too ambitious in that it collides with
> stuff in flight, by the way.

Okay, I will leave out the t4013 changes from this patch series, and
re-submit once `mk/diff-ignore-regex` advances to `next`.

Thank you for reviewing this patch series,
Dscho
