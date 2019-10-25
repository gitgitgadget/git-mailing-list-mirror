Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAC91F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 13:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440385AbfJYNKM (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 09:10:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:53517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439018AbfJYNKL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 09:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572009009;
        bh=ZnF/12eJ/x637Q0OsjfdCD1J7cTjgev9AgjjuPQUdlk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IEGceLoa3vlS7bSBZi23jHiHhYpPfeD2fv5yjWND600I9PYkOrOUTL20wo64TNyiT
         rYpBfsiNqmhHKKh0l8FACyXuNphe1nigZsduS4HofdzH+K8DIfaiZuSFD+C+KK9xOT
         uZOkV6Xul+zvtL+c0u3iQIFff/SFKHUe/q012fHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1iZiXe33AF-00Ub5N; Fri, 25
 Oct 2019 15:10:09 +0200
Date:   Fri, 25 Oct 2019 15:09:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     ydirson@free.fr
cc:     git <git@vger.kernel.org>
Subject: Re: [BUG] "git rebase -r" lacks sanitation on merges with arbitrary
 reference syntax
In-Reply-To: <479118979.-772834452.1571913751603.JavaMail.root@zimbra39-e7>
Message-ID: <nycvar.QRO.7.76.6.1910251508100.46@tvgsbejvaqbjf.bet>
References: <479118979.-772834452.1571913751603.JavaMail.root@zimbra39-e7>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FAU4wexJ6fvsx4oCJKOhc5Pg3wvpaCi0Zt/m7VwoLbUwkxzgiV+
 Tcoc9h5QHJZh1cF246jkpqqCoejnfYgetfkPUba7NtTwDZOIwtbsX/oCuAHECZHE/pSNH1J
 X3Zt7y3WcyXepRBU5Glj4J3oKZ+msRZ3N/ioX4OYKLKu9p3QzZlnLIFUIzp0UQTJiO1FZ6C
 pRP1SJe7xjGp1KTCpE4Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2yBDQaIKZrY=:lhb5ln8DnX+91dRCtyT8be
 psfamkeTAxVYIpspmCL+C2FnuFR1fOJQCI8UTn2+RI2rFLt1l+L9mbcOLaUjeAXLzq2GdtkCu
 Qhi3oVHwsIrOSF761afZnjgn11JWPVOOEfkMb52LKKJTS8ljO5BExzC5NlJg6s6lS9feBYeUO
 /dylyCG0oB0RT7lSTRHMYYtfflj3rX3I3ENKKoCpBFrn/shcpFbJ//yxQJh6uUzTfwifqfmAJ
 e7DztHJ/cs6FTutZmtW+sUvXhjxGNPIdHGjRke+AP3z9CAA7fGZGV+/u1Td5dWKzg8DXFtyvy
 CS4gOLDP2WipxxaYDL8QWcDR+xTuqLf6I7eUB/DDXspCzbb8bW9DyfVE/EPQ7fJqS1reZHjm1
 xKAm8iG7MfzqEB7KIUMj9I8MaPUSqOvtrly99vQLRJa7vQhoCXbXEiTQsvNXY4LIHsvdrlicB
 IlPLOn56u7ZeydHWI58JE+6FNjkeZla3nDQ4ZyuHu4r0U4z/aWBDQAlkmW9xU94G0nvCMqTtA
 FYpE9Ru77Q1Z/j9XKi4U+mRZtIjQPuQGsbw/yXxAVRNFtCyUErSAZi96FYHuKyms8o4Acmjp2
 9uH1ZqGssjw35HH+WG/RZ5QyOBe+zr1gjcr48E3X02/lebMZQk4UUf5FshaKVfP9PX894uXJx
 tRaKMTiGfX3VnVXFmVm6mNbgwTOzm/Qo4mMdYSBS9I/KqZEWKD2PP4GeYKZywY7u1zSut2uq3
 hg+f2iobBYSpgR+cv8WQUxYQlkMVvWp7lo25Akd6gexBiQMcoGh2AaDnih7q4/oSREgWhTUhn
 72TTyGCgYidVGTfdv3+FaLGwXLBT/XPM0SdsfCWcY3C6SFPq9KElg1mijuFDG5c7qCjPr6Hgm
 OjQ5gZ47hAP4pvi03CJi0J4FDf/xttvwROhcyG6wvI1/vxvmPBw45O5Dei7/w8rw5KjuXOVGt
 VU3Nm8MUBVrqlGgGcqutY4LxCK3nJB5DoTx10Khi4Y395XdLDC2QIStnCRp8C5GNKwIzt1msK
 MPo2klDGGgbaS29KtQhHpq8A+nOSjswT/JyQUGvfzcmi3P1QyFnPMv8oBdltDAZmcxZef0XnI
 GYSYrHnkC6WDarmOnt2LPdFEgjU/bzdHQbbD5yB1ced6sea/MFCZqxXLzV4tFWDv9GP19T12r
 rOVYAtRonECea+5BhDhx9gnQ3EYYt67LBcpHE6j35PrkuOdz+75tF/QWWHnlCQa0wI1UCrcLU
 nHFpNfR+C7bFIdXFEPpBf7bFa85NzTjPzy8EGfh7G/PTNBQ1jz2CpHiYOgm0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yann,

On Thu, 24 Oct 2019, ydirson@free.fr wrote:

> I have a branch which does successive merges from a vendor branch, like:
>
>  git merge vendor/poky-intercepts^{/warrior}'
>  git merge vendor/poky-intercepts^{/zeus}'
>
> Now if I try to use "rebase -r" across such a merge, the result is:
>
>  error: refusing to update ref with bad name 'refs/rewritten/vendor/poky=
-intercepts^{/warrior}'
>  hint: Could not execute the todo command
>  hint:
>  hint:     label vendor/poky-intercepts^{/warrior}
>  hint:
>  hint: It has been rescheduled; To edit the command before continuing, p=
lease
>  hint: edit the todo list first:
>  hint:
>  hint:     git rebase --edit-todo
>  hint:     git rebase --continue
>
> If I manually sanitize the label name, everything's fine.

The patch series is stalled a little:
https://github.com/gitgitgadget/git/pull/327

Unfortunately, we are deep in -rc mode for the upcoming v2.24.0, so I
don't think that this bug fix will make it into that release, there are
more pressing bugs.

But it is still on my radar!

Ciao,
Johannes
