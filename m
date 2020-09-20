Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B4C4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DC223A5B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q2sdjoF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgIUWaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:30:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:46005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIUWaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600727399;
        bh=SaoHQbqByBMIapAsRqj/Buh/DmXwCUtKRKVoMD3zYCI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q2sdjoF9nlEuCYbYwdp0aAy39AdGsfF02GkVt/7qd1PvQi7uk8NGWvHNjl53yX1YK
         J6EuSR+gf9dbjmu5w4zViTYi85UlpVG08lh7jqaEJNWWvVv8uHA1Ml7wQTo4Pa+HxM
         NvzvYGXA+H4QGaY7Kd+5bY3NyTPWXdNsYyCx67Fc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1kAY9b0aZY-00CAoj; Tue, 22
 Sep 2020 00:29:59 +0200
Date:   Sun, 20 Sep 2020 19:15:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
In-Reply-To: <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009201914330.5061@tvgsbejvaqbjf.bet>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com> <xmqqtuvwoyz5.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet> <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7niQgDAZQIwu3ckeXcVb6Va8AyVfGz7ZwP3GnyJ/bbVMbTkV6gT
 urd8z1whJhg+22akdx/8/XZzuJzihgbLIJgX1jqbl27TPxPa/KKQ699Cfriyon+qeh7tPiW
 LvjkMkk+u2TLIPaJFkYSyk28LCkecNMNAwhHKpH2DCHu7fx9zO2NxWClxNrbw0h6QaNWAYZ
 dXeKbb/mSNKplck9zToFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jQrxBxKdWk4=:99a5m2dMJNaDyY/+IPjxW9
 di905EJLL8r7/VSyfT3GhSnpXXDfpJ6IaJp6E5pv25ohlPBlBjuJWzlYwAUf6KgpCFeyqogqI
 uhv8N/OTzPL0K0kuBaQcZARHNeNVNSFfPtJV+8JaaSdwH9staFhuk6pnpMudBsNtDziaeDdJc
 YASkbeqzxgAppsvYFDYv+s+NlCGWQi3PKtBXi3mxH815Xq8I/bzFsUMXE7u3LMm+FBSkyduWv
 N5eJpTUwLthsnUlLCmIyhWKaaG28ec8mtyaaq5JTv9MPqBYOcXIUf9gHf0Ongm0zA75yedfx7
 a3CSd9o34cN4Ir6+Ru+5ByLbLBiTr+jMO9EdOO3tGxxfn8S7aJTABxpzEs2XRKuiBtA3uIkfk
 aeL6JuR/t8+DVP8k4PbY/nFhmOn8AYmqR2EWAP9/5HTRjews9LqOWwDZU2RdlEQ+V5KGTjI3n
 fcd+bKCTUahcD0V4yJ5JAoBHOdTa9uQxCCFBOUsxUsu/v9QGRj3tgNSiOSyVwI2hs5LpTnhCf
 fSU79RqPDcXgyS/c8jabiU4O8/KMaZzGhj4YVby5nuRn9SpHTZD5pu1hT4RVvtvuX1t/EvBPx
 /LQwMYuyOIpk2G56Xv61VUEehAV1J5IbnWAg/bc0PMlJqHjlmLNFQ7QSpm4AHdaCocUYqXNRM
 6KeAnnDq7oXN+GcDSO+XvYV15GJ6QTKTAGyKCxtztcff8pgFDNuPLHWsWuTGorCV86cWMtn17
 EE+XljSEQgn8Rnk8EPTqzFjTER47UMZUrA2oDdr071GzcY0bySfv6tg6MxgFwnB4OBaLx5/TW
 qu3w81RxPe4fcMsr3fjCpiIdi38SPYac+PCEyL10l5yY2gYsc/odDw16VaGqNan3uaWdDa5j4
 8naDMBPw9nGVAC6KmSXsRDhZFm6PINOwdEbqDODh1dBIkej6JUQihF3cHJWJqYcoxCOd7Ss/T
 Aa8SGrB8SLZsnGLmE3VcOyy6CHI8tQJrGaynRViC5xCXIdj3C/tZpq8lyYMNDtv+AG/UDQCMa
 Fv3L3Xla3Nm6gHoKsSmkgdgg9uTl8fgASxZB1gV1z/YLX4NiMskNKItdbowCUZsgfE6HUrksI
 6oHdG96OZEpxccFsX6LZrREQOJtT3tUKMfCIr4VCHhjGG384htKEggxYAdWt77CV3mQhwm2pt
 dcTFEvOZ4Q8XNiW11tFiKNy/7i9X4rE7VZ0aczwvNujnmO+0cXfH1h95D43iZunMUMMJMCJxg
 fyozeUd/M2h7nXaM0UAJJGIW4NuGhh7/41HgImw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 18 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Good to catch these cruft.
> >>
> >> Does the equivalent of "make distclean" need to be updated to clean
> >> them as well, or is it sufficient to ignore the build procedure and
> >> just rely on "git clean -f -x"?
> >
> > Since CMake in conjunction with Visual Studio completely side-steps
> > `make`, I think it would make most sense to ignore `make distclean` in
> > this context and go for `git clean -dfx` instead.
>
> I think you misunderstood the question, overlooking the "equivalent"
> part.
>
> I expected that when CMake & VS discards build artifacts, it would
> not make literal use of "make distclean".  After all, it does not
> use "make all" to build, either.
>
> That led me to suspect that CMake & VS may have a build target that
> is used to discard build artifacts, the moral equivalent to "make
> distclean".  That is where my question "if we are making .gitignore
> aware of more crufts, don't we need to tell the machinery, which is
> equivalent to 'make disclean', came from.
>
> What I am hearing here is that people with CMake & VS use "git clean
> -dfx" when they want to go back to the pristine state, unlike those
> who use "make distclean", and there is nothing to adjust for newly
> discovered crufts we are leaving on the filesystem.

Yes, that is my understanding.

> If that is the case, it is 100% fine.  It was that I just didn't
> expect not having a "remove cruft" rule in the build procedure.

Thanks,
Dscho
