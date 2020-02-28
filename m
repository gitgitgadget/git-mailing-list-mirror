Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF3C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 23:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04882469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 23:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eEpFAgc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgB1X5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:57:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:45551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgB1X5P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 18:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582934227;
        bh=L73sIvrcsnNcrMqzPU8qdn2GCR3kBIVyLbFFALhxcxg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eEpFAgc+5hDlbYHK9Q8ufm+EB1vjZGnye0GpTJr29bZCt86IxDH1SydCk2VK/FN0M
         M6NYw3Frs6h30T0UnZODZkF/kVzmrPfERONjzC+7wwDFo76hiZ3quoeCij1ureJWFw
         12n/AtIsQ2oVlosd/CXwpwyF6E7r2QLP9RbTSslM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1jkAT136yq-00pvcL; Sat, 29
 Feb 2020 00:57:07 +0100
Date:   Sat, 29 Feb 2020 00:57:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ed Maste <emaste@freebsd.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git mailing list <git@vger.kernel.org>
Subject: CI/PR builds on FreeBSD, was Re: [PATCH 1/3] t/lib-httpd: avoid
 using BSD's sed
In-Reply-To: <nycvar.QRO.7.76.6.2002272046060.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2002290054540.11433@tvgsbejvaqbjf.bet>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com> <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com> <CAPyFy2ArnEFe33GFLsbcOEV37DZ=VJpF-Sckn-V_tJUrToir=w@mail.gmail.com> <nycvar.QRO.7.76.6.2002271640320.46@tvgsbejvaqbjf.bet>
 <CAPyFy2BZoJAuugAbmgsrbzjM1pNu7o9Wzusz1qV7No8Hr+T4ww@mail.gmail.com> <nycvar.QRO.7.76.6.2002272046060.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fu1fh3VIt4ceZBOANSRMnooqn8bdP/NUYRVjw1pOWzSpQ0f+vHS
 ibjy8rJL/21A2cpDPj1imf9KCl0cgp+wmwgHKpsV2ewGXqAIlAEgNAkdPM+hZj9+SwKuzbn
 VQFcCIvwmOphLzhpEiMsQ7NoVy5xQjg/S+t+/x/NewClBdyuq7OKW2ufc2W7Mq8KemRra1c
 mNX19cxuUOoxU8Z5Yov7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DkRXdre1++0=:/HRYw4MTecqRS/OgJnH7Uy
 4zEoqabGxTiR2Dl9cegsH1/wVOhqb93jyfDtXa4a3s0Ay+qBCCrGapdKbafrUPOlTclxXjbFC
 MRtb+Jh90GiD+VVgjyXD4duY7pHE2UD2vRo7pFwWqAHFvL62TsonQ2eLsrl+seXr8v/nH11Ac
 ytaw6PGRbHE09TcQZe0OaHxxmBdHBUM0TzD1YC187zyfjaGp8/SACXn3KKezC/Bdj3SDjpGPb
 sPLVOZMiZUKYlVx/aZnQahLzWnVCjgTDwC4yr0A8aX4sNIyBDbNwIVoFhu13upcIRsz5PXR5Z
 51BxQHDBCXh/FEMXsP71nEv599awt0GnWY4r0ASLiqiv59DYf66ur8/fxfMi+DUtBTx5JkCLW
 Y5TO42JXwimrHZaQZhWJNvUHDDR6GfcXM4t6Fr5Nh5f2J/hFYGhtKIbIM4t63Z3qNar9jSIuy
 zpNqHgX9Xw8HqpEeaLlztE2hdRE+tXxj2qkBvpHnZ/5N1ZCkr9BnNUksLYYB6UP+5QNorGqBv
 hZFn+/1GhuIQ1qfaHSS0Qnb2pVWnmVtyJpKzgk9Nfy2jcCtKPIURdedC5m+mwls6YBDynhpDW
 KAU69bktoyEIqU3wSRjPHSqVoU5/PVvO9+hyNJwxxVPtSNY4f9saMuwcb8sEpuOKsVN2ynK1c
 zFpsQ+y+XRVJE0l1HjvKMmk4FjwDgfiHHWWxFwPSybZk4OZArlSru++9tZwpJ56/y8YfXxUe+
 /ein2K434pspA9TpZZvHs8Lyk7QOnHjlbNNa5x9nOtKfN+s4jcSKTO0g/zlqSYaJ0B7EyE3e0
 XtMyRPpqqpOJ4ytERxRPuPoffPz4r2emzbIyHg+Jxs+CJy1rqMGrtfgA+YWEVPOPXdoVZd4QW
 wB23aDgb34w6MoxDTtAC/E67GmSCx2tyZlCiIl0Dk4Kzwe4tJe/e/mrOvxyyra2jTJFCWwDSs
 CETyuFmH+tsoy5/l+hvOF7n4fxuoNcgpyGBOOv5opiuu2Yhfd/H+YPxJWnatbAAVi/8wl9etO
 yobLnuHqvSc12Cq0jxsmNj3U2kWtB3+QHiszeowKYmqoPs7V+YkRiDXjRsHom0TIWAKU2Su3r
 pE333VnFKN3bFfPv/nWxYfr7rjv/Cjw6D5C1HX/WKEFbUvunvDDOuY/5eq3pp941CgKUrHzkt
 u6fF1pjxH7QTaXtstN3UuG5JmGq0wADhE2cbJwVLH6gYBmY6u0uVgr7Ah36ars1Z1E46OAF1V
 bsP07T6y4txQQiHrW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

On Thu, 27 Feb 2020, Johannes Schindelin wrote:

> On Thu, 27 Feb 2020, Ed Maste wrote:
>
> > On Thu, 27 Feb 2020 at 10:40, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >
> > > Related, I saw that Cirrus CI offers FreeBSD builds, maybe you'd be
> > > interested in supporting that out of the box in
> > > https://github.com/git/git?
> >
> > Indeed - there is a .cirrus.yml in git now which builds and runs tests
> > (on FreeBSD 12.1). I'll look into working with the GitHub organization
> > owners for git and gitgitgadget to see about allowing Cirrus to access
> > the repositories.
>
> Oy, I had forgotten that you worked on this. I enabled this in the git
> and in the gitgitgadget orgs. The next pushes/PRs should benefit from
> this.

This works now. When you click on the green checkmarks (and the one red X)
at https://github.com/git/git/branches/active, you will see the
`freebsd_12` build.

Ciao,
Dscho
