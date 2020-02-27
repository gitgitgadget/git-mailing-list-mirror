Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431E8C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 19:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E80024699
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KpW0+Uet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgB0Tqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:46:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:59725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729940AbgB0Tqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 14:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582832788;
        bh=pCbQWbeti7JghEKn+RofCLQxJthsfMKBGp+nO6CAruI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KpW0+UetaHIF/Fj1SsqW2My6nVivQMc6iH/BW4a73QedXS5esstc3/nVGWHcot+Ev
         ZpEITuByywnSdr6wbSLwQnhOqBIFtcuNRUS622kC8RA35UZMchkt8NL92YDtJ70e9Z
         WBgqnz/LVI8Ldx0txmCHGWDS+dYVsBCfi2DKVKAc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1j29Np0Xlt-0084Jo; Thu, 27
 Feb 2020 20:46:28 +0100
Date:   Thu, 27 Feb 2020 20:46:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ed Maste <emaste@freebsd.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
In-Reply-To: <CAPyFy2BZoJAuugAbmgsrbzjM1pNu7o9Wzusz1qV7No8Hr+T4ww@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002272046060.46@tvgsbejvaqbjf.bet>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com> <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com> <CAPyFy2ArnEFe33GFLsbcOEV37DZ=VJpF-Sckn-V_tJUrToir=w@mail.gmail.com> <nycvar.QRO.7.76.6.2002271640320.46@tvgsbejvaqbjf.bet>
 <CAPyFy2BZoJAuugAbmgsrbzjM1pNu7o9Wzusz1qV7No8Hr+T4ww@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ox77M4XB1wPZ/Eo/Cas5IPSpmyAp4qkhtm4V+veUBtTHRbGyLDl
 ekJs9Si6bqPb7B0L70kjsPLPcqyy0ItV4Rs7WZusl4u+iFhZt191xBjC7hbFa+3HOgv05QW
 IUp+RsdhzKPEiDT06Un6jwNlfY8FEgHC4uhdqr7uPEBqw9MlPijbl3rXmnxu6kqTqjQxvUP
 yprYl8yZ89B4mR8fl7VEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NPGVhDv0ufc=:RVLj7qQmBW62+v6pK+6PCS
 /Zjxhfk3h5cQTPs/aPe/8hoxEzsolUlkuZWeWAcdIiyAk/Ogb+trztWKL+liH2iIy3ko7fqh4
 kOw1AfTrnVMnJ+5IYvmEQynyNEQhhtgOQaUTuTW/X5y6HJPZ9j+IOJFlU31sruXubF6bjoPpY
 lN6+2rXrUd3u5N76JBePrKch7Vh/UD1BjHvtTaXUu9/RXBhk5meGTBVyIBSs3J95oj3ei2Xfv
 gJGZR+FA5QXfchiHBu4yQ0KmYQwJQ4XEKECndUgWdLtQ5B6ZpLXx6pXyDccUY7JwdF3QkILvZ
 JPlMoWGH7UYrcSBnItAMzjq+PHc1CmoNe7Zp335h/kFXMarA5WFy1cp53myO7Ad1YUtayyGCB
 x67VcDGqlaji65VaJxXWQp3GuEkTNi6/Xh9kxkZGYAcFszpANxX8RV2JdPIBsZXiYyfxHjz7+
 Vk/Bs4UAM9xsu0gIr7lSI+uXRd2V+CFQjf2TrDwretADXyH2bna+FLvAHXK8nJd/q7a8GsPY/
 cJ1JtxdhPMvefSdLVdumJxJ9k9nqJiM0aBKUBk0buXBIkxeEKIN8rmjez7F/+TiuhIPLoYBg8
 L+g8WusFYQF1jF6wvfl6wpb/EfK0TrovktimGBMawbBP7FY0vI7B9gDiZVZY7WYei7XrT7Dw6
 wqAdW/rXm2Es9Nb1t4Osi+jDpoD88O77pSKjBLEdW3EWMQXTXjap1ItWS5z4H6DLg42+LEtsK
 dOgbdAZ2EdL50Q1Y8prPJ5qN29bpFMjM/mEpwWZ42wASL+witbfyE8NvVhSXsWu9oNpVd+IMH
 EEAxz6oMhsMqKjztu3I6wSVLJH8tC8WNT+QHrdxASekNqGQrX3TSmR5YDF7nvXhkq9rMcj2ku
 iWYx9uJxi6KQnre8jhA8QTmgsHr9XJVg5GDDMHpRnjaF7FUXFzNCIoj97grhQy7RLelHe8RJt
 LWcvEU3Dls+6u6jtIt8gOSL5JB0rt9js5UI/0k0EN4KFjCioOgnqY4Y0f5GcNYOVQvKdnqcDt
 wGTrJdGi20/KVEXZCuBm5KpmYSIq0VQm+gGxZtP9+zBtWpUMyMda00vpB7GEtF/UFlCT5EbLU
 k8TviXE8FXbMW7PyhK+xc5C4GcP+7760aKVphJD+vmEHfvL4D6C2wADyuZ4iucqdeei9u7G1v
 cZOirLz/tR+7eN8G0Zhy7c0fn4w3BvFGYoLSI3ys8PE12uRGt3iYeemUodsM6zFUEqbVn4NW0
 ZLVX0QtMzur8GKJzg
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

On Thu, 27 Feb 2020, Ed Maste wrote:

> On Thu, 27 Feb 2020 at 10:40, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > My bad. I looked at StackOverflow and there the claim was that all BSD
> > seds behave that way.
> >
> > Of course, SO always lags behind by a couple years (although even such=
 old
> > threads are often very useful), so it is possible that _old_ BSD sed
> > behaved that way.
>
> Yeah, I wondered about the different behaviour, and asked on Twitter
> about it. You're right, it is historical BSD behaviour and NetBSD at
> least still appends the newline. FreeBSD changed this in 2014 -
> http://bugs.freebsd.org/160745.

Thank you for digging into this!

> > Related, I saw that Cirrus CI offers FreeBSD builds, maybe you'd be
> > interested in supporting that out of the box in
> > https://github.com/git/git?
>
> Indeed - there is a .cirrus.yml in git now which builds and runs tests
> (on FreeBSD 12.1). I'll look into working with the GitHub organization
> owners for git and gitgitgadget to see about allowing Cirrus to access
> the repositories.

Oy, I had forgotten that you worked on this. I enabled this in the git and
in the gitgitgadget orgs. The next pushes/PRs should benefit from this.

Thanks,
Dscho
