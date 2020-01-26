Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03248C35240
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 10:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBA92071A
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FM6NTyDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAZKZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 05:25:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:53925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbgAZKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 05:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580034333;
        bh=AxO0wcUHVJU2+D+guWRsdCRBaSUAiu6eDEgTSNBfiQ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FM6NTyDHXOtX2rWNyRNKq3E4OFUDtbyt9jDTOOZeHkwqYuHHc5LMlZ2Y3D7NLWp4U
         0mVddF5p4QZraIcdJBTlmqBccdbyFS5cdz3gJxjX60awrQbOZ1Kk46RmaruEA2aWrk
         pyaElXBvHCOBKcyiup+5cZ/zo6aXF37ue368wHRs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1jeFLz2TZ4-010M6L; Sun, 26
 Jan 2020 11:25:33 +0100
Date:   Sun, 26 Jan 2020 11:25:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/23] SHA-256 test fixes, part 8
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001261120430.46@tvgsbejvaqbjf.bet>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LcygxpXZivinXi1Sd2R9dfS0IfQA5teqAzagKI9UD/zreELF0t3
 41rexiOnEG4PmTu61EN7W64w4+tzFpT3+wOWhJlc268TEGTGDGiOn+Y0uB1AKz96Dq2gCQH
 LV2jrP3Fj7P7YjRV2XN4iJQM/fcJkhBBrXbNahnbRf+BCGh3WvZZABLjCgZd8dsWncRe3Sr
 P3ZuR3C5OLz0Gnt7a5e/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VI3MRmv717w=:UBGsAVhYD+SCj3RnghyPNG
 YFMYgG4rQ0y8zmZX+JKQPrK2/yk7Z8jgvsspCig89k3UyxuCT9wdF+Ch6YFrLKSYKxymgV5p5
 vuqr2e4GWULR89d3VeLJGZmIJcYAeEFUS673uk03gubHkr5TSgYe5rsLGuP8BpHZGQcyQS4p/
 4/Yy1bVhNz71ryi+hypnWDlnRgEVgMYXKBORP8EkN+WNOVKbLBhgeIIp3FmhzuRmCKRf1RP4/
 Mm9iJVCsQX42KX4f9/a6R+l5Jy/eaY+YLKnau/4WScRTqWEE9fWCxMYTfEz8VIT4nbYXtaOeS
 6YITPOZtYSFXLdnxMoNkES+09ih8Ky501NaQ8ojM9MRxFt/hKlkD28FE7RzMzF29nRUV+W0vm
 tKVr0ss5fSz248MkWGRvDua6UKXjan76fLKtPRofqmWYm7sS1Q6oN+Is4vQZBWSqDmVaMLvum
 y6GOPKfa9f3QIYTxKsqGnDwHwxCxe6QVP+hoP+UsqJ8AsEen8jCvNMu4xGFCOLwsMfMnGd9XN
 qTsonIKbODAs+DIKmqw7+s+3oyX8vslQhAWxFcnUGpWMooLiMWbZUlU4qQC1NceM87rufSeJm
 Nb/WiDFrUhdWtJPVgKWhmZrWXl64a/nr8RU64aSHPg8tkm9zT2FInAQfYoPZ4JFtrfQ6Ch2CZ
 JGiAn65xe14L4js/lKqi8tgcEm89n9DEY+MpfaI++LanAC+1iBGRp+lrcwzvn2Dki9BpkcAg3
 gfChnoCBle78CRuda9+AZyDJfnoUHQoYXsZKJoXzwRecgfFC10z7Y6JCGjhHvDVvKuyXIwsdB
 z5HLavKVUM1wke3cvWhFbeLwvz42sfFvnJ9vvY2kQmrLcmJSwROzdRj6N0/p7lGOpujyVSazW
 BRAr/MU0ktgc3Jh2/6AL7r+jlNnuB5CzKCpl1vsnrX/P/LAIIgHj9fzVHS+73LSL+PwP03sc5
 mzpzf0i4xJqoqSlNW0osCuvL+rPCbxtXXL+qRckoU7oWzzY5P76FPhYeqkZY8/3dTA7J3NIbT
 a6QKrG8w9JLr9rZqkHV1lOIOrE+DDt9dVZYoyMe/Okt+0dZgnzXSg0vJ4s1A5ETyRyBzPaaHt
 +E6c/LyFU+t9VL8xVe9rs9W4NlQS+ps8f7pub4oHtjDObNyFQAuZVWTSQSnnA2bArRX0aCZ1d
 AbEr/cFtV3w0pSrtXizaZf6CQawbR+ypJ46qaOj9P83TQ/tC3vI5SxMEWuvcuhxx1N8yGI/bA
 dMGU2SHuVTa9sRhV1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 25 Jan 2020, brian m. carlson wrote:

> This is the second-to-last series of test fixes for SHA-256.
>
> As mentioned previously, the patch for t3305 seems to indicate a bug in
> the notes code and I'm not familiar enough with that code to apply a
> fix.  This is a band-aid to get it working with SHA-256, but any
> comments on a more robust approach would of course be welcome.
>
> Changes from v1:
> * Drop patch for t3404 in favor of Dscho's fix.
> * Drop patch for t5616 in favor of Jonathan Tan's fix.
> * Add missing sign-off.
> * Move test_oid_init into the correct patch.

Would you terribly mind pushing up your local branch to a public place? I
used the apply-from-public-inbox.sh script I maintain at
https://github.com/git-for-windows/build-extra to apply your patch series
on top of v2.25.0, but I got this:

	Applying: t5607: make hash size independent
	Using index info to reconstruct a base tree...
	M       t/t5607-clone-bundle.sh
	Falling back to patching base and 3-way merge...
	No changes -- Patch already applied.

(I want to have a look at the notes fanout. Will keep you posted on my
investigation there.)

Thanks,
Dscho
