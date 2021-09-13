Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA76C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C38460F9B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 12:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhIMMKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:10:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:34709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235453AbhIMMKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 08:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631534932;
        bh=TWWQllqqrpmRN5LeUxsUZwBpM8qUJMjoxn9Rdh2ek8I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KFj8qYYE1lRM9aACC4jSZ/BdNX3hlphiPhRpuI+osTaIRGarogA+CC/J+bEasCZnm
         /C5r9pJLQ0dH2fX3uQRmUqIC1YPdpjwMPCwPZHigHEbsn0wNbiDaFVHwHWq1As+VuN
         iRuFFiNz1MK/CD7jXa2icQJcwSHMMbyzULbhzsGA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwbz-1mER2Y3HKb-00BKrY; Mon, 13
 Sep 2021 14:08:51 +0200
Date:   Mon, 13 Sep 2021 14:08:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/3] A pair of git am --abort issues
In-Reply-To: <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131408030.55@tvgsbejvaqbjf.bet>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com> <pull.1087.v2.git.git.1631269876.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:joFFSZhgA/CeL1BUG9z2AXEByZrrBZv9oSPKJtWHC3L3h78JfVm
 f89vtX/owtb1LOCI/jhpNEyrSRZ8ybRMIWxZLFl2SowivPF/TMC71NO4OSvuvsPO4Ffech6
 UvPr8V03eZLfjGm0BAB8mharR/6rcSaZPP5LGk5nrcMSLha+4/cWWpvBFJJXoQdpkR2GV/k
 7wbSAA3vHUVoiQFrdKcWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tZcnNvusLok=:r+MRHxjql9RxUpB97/tmDo
 RjOfm8wR6bv2NtXC6Bdsttx+2wEOds7WHJr0xgY90Myg4pI36robcB1g7wd8EIDPy7zkVX7Cf
 A3MKnk1KMf1xUM8AgzutBBvMNhXzCdgMawmYPO+WqMoAYkG0v447Sf7Y8mAPyJjG/Iq1ygqd+
 p8xFkZz289N0Ljw61z/RjRxVW9X9MgQB8JEsMUGNI4q790PdFbElwCOvLdWphi7DY/rw6V6kV
 Wjbz6WNFqIjy66gC7U+HtUdHkBLRaxNtmnCdzIDBa5jSfkiccgSxGz8lxNIFuM2ZPD2wlBEz+
 GL7PwFQ1Hd6wDQt2EhoNWyCDg/tSnl95ciPE5mMIAVYndnR5M+1JoyQqh542qiogzUG4xpa7q
 cqSW+9/EJrfbek6Iaa1O1zg0IFKpjOwZ1tvmvibv2yaL0rg5jhmd5l+UGomXf4c0ndRax2RQq
 xRMJNQZkcSUuWh6aF9KZ1bbAMH3iY6zn+QmG7phXB+Mr5sl3DJLlAGRt/BTtEurZ3NIjE0MLO
 a2vf1fxh4pdjbaU9jIRr7TTtL85H/my2NxdhO3VOEKvtaJWeDAeBUrqHY0Enbjvxv0nqroSJm
 tlfXJPmlnKbfv+W5GIQYhj9BeaOgRvNtb6KqD+WVTrjnSjH+fUDKa713YPPkSOJWzeP5DyR/a
 tM2KjqqWSwUHNnlL7rKmvB2CMRAmL55ZUYe0m21TE397XZOglwzFY3sPG/Y8Elr0sgmnKyYD+
 VOhm+z9yYxNh0kEO8lI32sf2mmoDSmY7hbxqdhvdDuzpxZ5myCANNp4mbEVeb5PxFgkewB1gk
 VsGSIXOr81QxSmWrVHVesaa5dWJWAnadu/rxIHKlH3L5+crzRD44Ghu7UwQWL4bRYrMy+cXan
 4+zoG29XsKCWe0Yi68qP2jgKii3bJBYJd2OimJXdvBOnYEneQkN0S4ElPTUhjPZn1k0u7swko
 dFLRVzN9PHIrknT5XGCl0VR15pjh3FYJZzVj3Hljsm8Let1pkihqXt5PgvuJO43lvxAx0OCtP
 XEo/PpXhRtpPaAycsQ+X2YnpvXRhdb2T8FPiBXwxTTFgNJnArjklYan1GVCcZCusp+vuxlrc3
 YPNrmgSF2K0GSo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 10 Sep 2021, Elijah Newren via GitGitGadget wrote:

> This series documents a few issues with git am --abort in the form of ne=
w
> testcases, and fixes one of them. However, while I was surprised the abo=
rt
> left the working directory dirty, I couldn't find any documentation to
> confirm it should or shouldn't be, and reading the code led me to questi=
on
> if perhaps it was intentional. Anyway, if it's intended, let me know and
> I'll drop that testcase.
>
> For frame of reference, these were some issues I found while working on
> unintentional removal of untracked files/directories and the current wor=
king
> directory, and I'm just submitting them separately.
>
> Changes since v1:
>
>  * Added a patch to tweak the documentation to clarify that partial clea=
ning
>    of worktree is expected with --abort
>  * Tweaked the second test to be a test that unrelated dirty files are k=
ept,
>    as suggested by Junio

FWIW I gave this a light read-over and am happy with it!

Ciao,
Dscho
