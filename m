Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B722EC4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKXJpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 04:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKXJpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 04:45:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A053E9176
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 01:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669283092; bh=47RabXlCDbCQgsBFhzbPgYOyZIRAoaroiL2+UeuBPns=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S/o84t5NzJ/NqB7lX4VgCB5raqYxAr9a9Y/5AQZXEbSCQ2kzHZR9gqSwmNCXQD4R5
         AIBCt0bJeyge54kRGVumsPV1l+izkLmXlBLYsNFLfXfYDjj/yisZdvXBhLV6SsSYHI
         1nayyrGPMRFCl7YwffibH3ZO/fFVTMcscY5r0OPA6v9oRO9XHsOj+g/uhka7PuoLXT
         2daYcoJgwEEFvXNm3xU0Ud3FqyYkbbnjSGYVtSIBR9HfO1SP6o+yx2c3EJbft8hZMa
         sHcK1GqAZb+7kW8/WDN4pFjAX/xdXGkAf+waO42wdaAR59wd7aPAQDViagZegTMeNA
         q3xAKR/aTxlSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1pBoI042zX-00v981; Thu, 24
 Nov 2022 10:44:52 +0100
Date:   Thu, 24 Nov 2022 10:44:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 0/3] Fix broken CI on newer github-actions runner
 image
In-Reply-To: <20221124090545.4790-1-worldhello.net@gmail.com>
Message-ID: <2219s80r-q7s3-391o-o3or-7q70sn37ooo9@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com> <20221124090545.4790-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:45yF3rZBfeQ6OYyWQQHG8x/2vtK46Da1B9t69twf5gTBFNDzUAE
 0EIxA36I87PnmAF8fvJBVzCXSEIpJ0RHblVHh8KjjADl3UYb2Q6yeO5Q9OODYJZZ4QvH56K
 ZpRQrXuBnL7vD+TmQm2Y1fplh5SkWCWxHM69cvN2fXCPts0Fw+b++in5qMFkKAleOMeez8Q
 LgxETV9JTkV8bE2FYOoJQ==
UI-OutboundReport: notjunk:1;M01:P0:NBsH8+N7wKU=;D7KBoiVF3Oj1VaLwU6zonqCOasq
 aEgL/2U39eBaqhHQyDAlaAPU4XyiIDPU7hMJlbPVJJYU6To5ulR9u0yLuZGoF4PTkIlf9rFja
 sBhoo63HA0naEQla4KEMxuibhYIJdfzaG44AWeyY/8orryoTRbNA68Z6y2KxO30CmojwnGsNP
 CIqpfK5aYY1hrFaI95Mq9QWCbqrFYWpTWi+voR5A55VAFygb8eVEpMXCYQVAVNe5l4QoQvZ8W
 kqenhWZYv4mNp8xEMSU7X2R0P57/uFuo3IJdHNLxIRVvj9OfELePK5YPUCji4uwUfa9+9yRR0
 045PyJDvXngE2G12UHwN4Vi8yVNbR1u51fXMM0+X0armS0dmlk+vnqGN7awPvj+fE6QvphL2A
 s3tCA3dncfNiLwHyb+Zp2UOsL0k52em7w3m9V5R4BQCasrRyUrakx+h0Jy/Y5XT7Ow6PhLeGD
 2jvFlI4PpdS/cVYax0u+sAU9wufj8Fo+p7J+TQ2A0gSp1Xj8YrPHf4lLEeCVG3M7Oxd8n69vd
 45XWT5SmiLZ0Yx7nctxDboJRXjdKVuqDlII+xw4HrzadWYYdAxghD+KhbR1p0l7WJ+8es95jt
 byhPhU2bnn/anCI8gTsIaMt5CcXpUU0XRdLArO3jiE3SCUZnJ21a8KU+VaRXpHFO1KdLWUdyt
 bYcW42e5YbsFcsau0U8gqd1jwHX9I5wgkWaN0KvNZkH309mDIvWjdWizJb2q/9ana0msS8AKD
 ExHNklhHkUECKfl2ZaR6gYTwLAa5d4W4WVYpajd5suOo4XjmEqVVgWdPQBnsK+pmjxsUn/E/5
 MyIokA7QbLK+fvplnyVu6V5wS2iAK8CkjBnRD+NroY5cm40Jc8cekwz8OFDbKnMhzGENFVb58
 BQmvZcldpCLAi8KujWjjZagFy9C8n1MQFYuColjNLRbudRKUZXKYbEYqjPtWKp3xvINU1E/AE
 86DTsZP8WklgbPzUnnEzFkL7zig=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 24 Nov 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> GitHub CI runner image "ubuntu-latest" will upgrade to "ubuntu-22.04"
> soon, and the CI runner image of my private host repository has
> already been upgraded.
>
> Our CI will break on new runner image because there is not "gcc-8"
> package in ubuntu-22.04. See log of CI#2:
>
>  * https://github.com/jiangxin/git-ci-test/actions/runs/3537628107/jobs/=
5937769957
>
> This issue is fixed in patch 1/3 by downgrade the version of the runner
> image for jobs which need "gcc-8". But there are still some CI errors.
> This is because p4/p4d version 16.2 cannot run on ubuntu-22.04. See this
> log of CI#3:
>
>  * https://github.com/jiangxin/git-ci-test/actions/runs/3537650146/jobs/=
5937813922
>
> This issue is fixed in patch 2/3 by upgrade p4 and p4d. But all p4
> related test cases failed becasue python was missing on ubuntu-22.04.
> See the log of CI#4:
>
>  * https://github.com/jiangxin/git-ci-test/actions/runs/3537695959/jobs/=
5937929695
>
> This issue is fixed in patch 3/3 by install python2/python3 on ubutnu.
>
> If install p4 version 22.2, will break several p4 related test cases,
> see the log of CI#7:
>
>  * https://github.com/jiangxin/git-ci-test/actions/runs/3538795233/jobs/=
5939989823
>
> So we choose p4 21.2, and the final successful log of CI#8 is below:
>
>  * https://github.com/jiangxin/git-ci-test/actions/runs/3538946849

ACK!

I verified that this patch series does the job, by applying it on top of
`microsoft/git`'s tentative rebase to v2.39.0-rc0:
https://github.com/dscho/git/actions/runs/3539338333/jobs/5941122554

This run was restricted to `linux-clang` and the p4 tests. I care a lot
about not using more resources than one's fair share, therefore I wanted
to avoid using build minutes unnecessarily during my debuging.

To build even more confidence in the patch series, I will now start a full
run (which will take *a lot* of build minutes, unfortunately).

Thank you so much!
Dscho
