Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC75C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4664264F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhBCAgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 19:36:54 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42666 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhBCAgy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 19:36:54 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 311C41F4B4;
        Wed,  3 Feb 2021 00:36:13 +0000 (UTC)
Date:   Wed, 3 Feb 2021 00:36:13 +0000
From:   Eric Wong <e@80x24.org>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
Message-ID: <20210203003612.GA22793@dcvr>
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
 <YBkUJP2u4NcldpOp@coredump.intra.peff.net>
 <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
 <YBkZZrDzBo0UC+SQ@coredump.intra.peff.net>
 <CAGP6POJStLEGwiU6yobaA6ag1q1ametFoe2AVkOAs6zDQ5bk3A@mail.gmail.com>
 <20210202222339.GA20119@dcvr>
 <CAGP6POKb4uPFECJ7Ghu-jZ+fe_S2oR_OdPDVQeMwnswp7KX_=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGP6POKb4uPFECJ7Ghu-jZ+fe_S2oR_OdPDVQeMwnswp7KX_=g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hongyi Zhao <hongyi.zhao@gmail.com> wrote:
> Thank you for telling me this. But why the content can't be directly
> print on the stdout as shown below:
> 
> werner@X10DAi:~$ curl -sSf -d '' 'https://lore.kernel.org/git/?q=tc:hongyi&x=m'
> werner@X10DAi:~$ curl -sSf -d '' 'https://public-inbox.org/git/?q=tc:hongyi&x=m'
> werner@X10DAi:~$
> 
> As you can see, nothing is shown to me.

Oops, leaving out '-s' for curl would've shown you the error.
It's gzipped for bandwidth + I/O savings and truncation checking),
so you can pipe it to zcat or "pigz -dc":

curl -Sf -d '' 'https://public-inbox.org/git/?q=tc:hongyi&x=m' | zcat
