Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD5C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiHLVJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiHLVI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04AB56E0
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660338534;
        bh=HfKqlJ1b/v6ixmMTWPRx3SbGsWa6pyrJ5y+tcT+4Nf0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z2MusjdAbX5p5qFoRpmDl+07T/ll3SZiD++DU3E9FgjZr5YOWBuxn3sevR7SWmQwK
         qLBG6ITz/pobZAU4Hh3Xe01j0p9HMQoRNFsCi5wvs5uj/LntOlnoXULNargKt1QgYK
         Pt/vlmoAhKRlooyLFqtNfFuLjRt7ZSIMB503h6ZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.191.7] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1oBweV1t9t-00FhkS; Fri, 12
 Aug 2022 23:08:54 +0200
Date:   Fri, 12 Aug 2022 23:09:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Niklas <git@nwuensche.com>
cc:     git@vger.kernel.org
Subject: Re: Bug: Git-Alias is callable from outside a git repo
In-Reply-To: <20220810170319.mxd6h2p5tm6y5xx3@imap.mailbox.org>
Message-ID: <s08qq38q-26po-r066-soo3-po7165167s31@tzk.qr>
References: <20220810170319.mxd6h2p5tm6y5xx3@imap.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ONAnK4yGCR9/UEPGkcnmoZga1pp9j6UTrM9ycguW2eRt7HmKPby
 CDGffUlS4wGvg1qUvcoLSXf8qfFCjN2gGk3d+jEEj5PwvJXklT+UwiHLGOOUj+rXU2V8X3f
 VT4rdAp7Qj5hrBOrXG/86vt7sv/u/rveFTu4qVaZIHyFCgG1KQtKtPxhWXtDKYdg0kQ5ziW
 gLxHBWzGWVI/nxlETAp0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2tV9G2IX31M=:jB3FT1wWzO5WgAOjtzI4Ww
 8fTQeBsYwtyiXMQ7pbT8tkO4CJeXoY8F/aEVdwaHH/ARuEZdiXqzbl2BK3XAMdxl8bavJ1vfH
 Fu/Z7p9tPcTU6uSQWVw60mdG745B/ztyR/WHszYsm00IMiPN4mCR3gUtqRkOubhQtIPuBy4br
 3EGFEy3o0OypnHam6rtS+yAq9f8SCsLxn0tlHqp22205kUdy3r0jlIoOhnI2K1gPbS3BmGDVE
 tCfPYGk3VXcNeoWtitJvXIJ8srxyO6cH982uwTI1rh1/ufdsDDbSvIBHz05ydRji/CZMuo3YJ
 G0VZ22B8FgToa/6jA9lFntlZBhPwFxolyRWC5s9kjqgUCc4zMdkHoY9Nl51tv6FIwwBHs6EnY
 afKd20QVOPe3a4mF607znfyf8VNg+3SULT1nfBAHDfhHviRoa4F3/Tlr/QHHkj/RfhxUZwXZg
 d5vw/EGQUotILhjvjco6Fx+7pZaK00lb3UyL9xbi2A9mqIPPRqq0uRtwnhf1uUHVo774UADNf
 78yVlNBDRIp5Ez66usQWiC87xZx1N4WN8B5AszOzA43SLs7S1RlPSB/SvL5N5I9dj3y/2flOV
 /1G4KdLbhbeqWlq/48+sAaT46FHk64FiNG0/TSQbvoY5KgU7+lk02J87lv4t1YHQM9thbwwhY
 NboBISRwTyElwt/aq/ENuYNimGG0sZSEfQsz3RskmrGP/NUkLV1j57D59aEndIBlBv+kGjyBi
 Q5E5M3NKe29gGUyal7/Hk6dwEM7z6qt9vI2IqJp89bpzOMHDIADS1iU+35DF2dkNjh8sTL466
 CyjtvLtxY9TRApFmZ+Sri7er4k8025DuPTdgzdSQr9rXOLHN4MjBLTi+FhmZhvIbVMhN6LvFZ
 I/f1doQEHf+S+cJC9K8QYDIgZ0QH+LNVTaWSvKEV4GlLn2350Rw1aUErl87dHuS1xiVGPKk25
 weOzA8DRCR/fysrUbi8gTnKqmPSW5JVr+4jJOokh9yHnnP81LYSVRLd0FlFXfsImXVMSNu+IJ
 27ov4h2ZOu8uzhmqg3BsAqbSy0bKBx+Nt8os3fVaId0xe7kCPd1wBRRFy9cOSbM580aOaafS0
 7GbtKRnBi/u42worVuWTT0RIHduQJo+lZdu4PCwIoDZc4xpiPzblKvlRw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Niklas,

On Wed, 10 Aug 2022, Niklas wrote:

> Steps to reproduce:
>
> 1. Having the following global .gitconfig
>
> [alias]
>     f =3D "!echo "test""

That quoting is a big bogus.

>
> 2. Calling `git f` in a folder which does not belong to a git repo
>
> Expected Behavior:
> Seeing some message like like
> `fatal: not a git repository (or any parent up to mount point /)`
>
> Actual Behavior:
>
> Prints "test"

This is by design, and definitely not a bug. It even allows you to build
relatively complex aliases that work on multiple worktrees, or even no
worktree at all.

Why would a Git alias have to be bound to any specific Git repository?

Ciao,
Johannes
