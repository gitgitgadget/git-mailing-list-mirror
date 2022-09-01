Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FEBECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiIAJ40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiIAJ4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:56:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD110F0B3
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662026178;
        bh=pyCtQeWNJtNNw2ruHPL2k99GbB48XihiU2ImQ36hZAk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eWARbw71tzV00T2KD9WqG+Y3omgR+kR1K5XiOrZqrrlHOKm6cggM+gJDrksGYCdYX
         9TGf/YEsy/tpWP7HLIuK9Gwt5o5MB4D6ZvMQzQa8gH1G2uvfMh9nkZKUHPVD50iIoP
         lhw5Oogp6php3yAoWE/3VV9aignHi18y/MrHGrzs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ykg-1oQxuh48jm-0063Ii; Thu, 01
 Sep 2022 11:56:18 +0200
Date:   Thu, 1 Sep 2022 11:56:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/8] scalar: integrate into core Git
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
Message-ID: <21q1o4p0-opq8-31sq-r122-q2rq72732srr@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qkIcuSUQuj494RSiTeddqPu+ss4kfZXHHIN+CnL6fC4VjOmxReC
 UjrCV1+tZNmP6toMmRW1IRxCG27PtEYZGUHWbw6e9RYLZe7r5rgE+DEsf2YNnIxivYODg0P
 BLrZSBWy3x3unGLOfGJEicCzVcDnsM/PZRDSmICljwQyFO1EAZL6zAjSf+tqQASbNZY5lJZ
 NQ0s2gkL+GpcieRhatWdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EbX4sGk+5CE=:UcvohZ9nN/2+Mt/mEA1m2L
 ptxbqu1HnIgrnR7ujTKNzAUQxO7QRXRbwYDmvnDYKaFIKciZMX29NR37PPwpWwwfO2D02ZFsh
 kYAitWE3famTNsu49MxloHCZpEUOdSTkwvR5idbCYSqfByj+dkoavfc0Glm44MTR1qclXNbyK
 sd9z94yW+ngPQ1G0ZYHpG2SQfCgzEsHAt3MFuBDoGcKZB4igXAauuGl2eU+b9V83v0SIGL7qO
 Y+oN8XrNY9xji80mxTsAdSoXxBeaiTZy7t7SWx+iZIFsU4S6SD/utU4wfOzVyZh7u3tRprzMo
 CsfbDmz4wXV9SGSJ0gpbnu4U4UwmAo/W733Tr8hKjK0B+6XYITzQnaHipOiGWnC55hJ46i9Uc
 YnF1gmzlpfuMu9NsLKLzcumlPlOnJCwvbxF3gjfaa/zGQLGlMDNTIfpK5sNPiGD0eraCFxx34
 ggYkG9XKiCr2XaF1Lc/k9m89hSQ24owk6EiSFf59L4y2ndy+6AKmMD0yxUznKYrc0mqTPt/ek
 RaT8gfBnHga6TxWEoClhObdsGyPlxMuG3a/nISTmlP7BKmTn66JDdPpBiR71ocf3y96YYudWP
 fB7cKcsg08Hk2CA9F6Gpct2Uzvxw6m3xp0mf+wnMskXJYLhlbS4Xh1BFpBDO9IvQPA2HrFYyT
 je3r3ICyY85cbaPG31Agxptb3kelGl5vbanwPwcpUuTw2m5j3DKk9mxUnanPV4gtCZQwXP6WY
 tfhgxR4eF1qXX0HnnzgIYUjC6cmfChpezv9ofdyuub8x3AWa1OwsekysIsRvwJ91J5ZRTg0yM
 y7C47j+BplRWm0JaSoHX2VPQDdptOFShU+eqUvRMIK9U46i2s/oOiuSqz5ip2QFO65lmJ2NSY
 /EL0Sshsh5Tt0gXvdD0ssrcl6hgj8TPzXTYhXNlCkWYlCbc0X+RsJqLq6B76gY43bJlPIM3Ep
 Fgt+enQs7bX07ZYt59XLlHZoC6T0HLW4+TGk0/iBjgi68LBq4o90T/l0zZwEdX3mFLkd44yoT
 25sRU0nzlzwTtMRhMaxH8QBu/6Vaf2Hf1y5RahQjPHm+KHPUobt9RthDfIH3lHl5BmzRoBgtS
 0kNS7fa0KRfqfSQPFTDww83OIqT5eEyZQA0gBXuJsYZoCArg3K0kkZ6B2AKq85BiRffRx7DoT
 GocuX+EygcMfvSFAsL2FvwE5fU
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:

> This series completes the initial implementation of the Scalar command as a
> core component of Git. For readers new to the topic of Scalar, the
> roadmap/design doc [1] provides some background information including how
> the project started & evolved, as well as its current intent & high-level
> design.

Thank you for giving this a fresh start.

My previous attempts all got mired and stuck in "mine vs yours" contests,
and a fresh start was the best that could happen to the Scalar effort to
get unstuck.

I reviewed all the patches, provided some commentary, cheering on, and
also a few suggestions. Feel free to add my `Reviewed-by`.

Thank you,
Dscho
