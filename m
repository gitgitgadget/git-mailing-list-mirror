Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D36ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiIAJjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIAJjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:39:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0D625B
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662025185;
        bh=ty6NUO+kCxD2QTyePYPklhrY1U/UZoVb3OMwA4GKY6o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UY1uFjgCvpGYJ+l9NgFSJAcRRvANpnKhhI97KuBrGiQf/b2PFvata42NwCqieglGS
         bJ+R7dTvWGWGju1Et4gZDPYkCCYMFu8p1kgdqcVEaRLM9rbTyUdHec9lDk1GaZpznI
         SVjnnzVkGg6BmRwe1eTIksK60LDyK6zlFuKMk+u0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1pAvmP3RtN-00qEfM; Thu, 01
 Sep 2022 11:39:44 +0200
Date:   Thu, 1 Sep 2022 11:39:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 6/8] t/perf: add Scalar performance tests
In-Reply-To: <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com>
Message-ID: <59s7o8n8-5797-q2qo-4q0o-93qppnr92q52@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/UWFGlsO0HshFsHpCpcpaGkSZxf4lF3ty1UYbJySYN7DJUxECAb
 DcDFf31qDmCn1UwXTptffkcp8m75FosiJIcaIAWQd1XCkq2Z5xHbMy1ijQcXVRK7VdS/Pm3
 IIpk2Hp1uEtZk7ZrjU4/P9nMx1Obri5nn24/zoXZxO8RuAOiQz/6cBBQpiASQxnZWqgJWxm
 xt5IykQr4OuJHXjMA7Sjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0VcED5sRYnw=:Y0c7z6KuFneaUnIfZjXiif
 tXQCtESsXTi0Z0gXrOHa0k+eY38pZVzyO+3JAyhrLvBdtdGbZs62FQ2nFkrg5IVUO9fGv1qxL
 KJKBt9p3ZgaOf3sYqwBRrWde+S/Q/Lob3TQOZ03e9TIhCb9JgDHu4lJaT7Appe9Z7MV2eD6st
 13KS/JS+tLWXVN9W8qH/TubbHv40GMUMemuGpt0IF9I15lPUrX30g+lipQpZ+RseGybziWu4q
 iMIhKj/CJ2ITeid/9N1Z0RsAfpkn9QQ8ua4PrwNCtcmqiB4F81Y8t2nTyfKw2Mxauckm/f1J2
 tDJUCtsvjodS9Qk74LTlIiLO0/P9iMbyPc5lUoJgqXpo6UCn4GmD2U6JBFYmsBLNjGc0PqQoi
 lGGISlcGJb96G3zFYWXOrkmvHr8cWsF6rPCHkM5yIMd9dT9Rkb0WIAND9dxXrLdmsICXbcjY3
 KyH4Ij+wsd2InyWJqjCenEATpFovaS9s6DK1VNJHj7YOAptFgzlhiVmdADqC9XjELLzzhXG2g
 tMEMKSZ0D8df+fkP2w44m9Hu2lQAMf/ROPFQyl2sS779aj7Sf65Q4CYxcTM+JEiGdqZDzD4ny
 tVTEKsVcRR7rLw6+6SfVZPx4lCzwxXDk1DXSN+5IAh7ajBmjGBTtzDZxQBWNBMuKxf0zukjzO
 qHwqyk6vu+4c/2WXj++TYyPxWQNsAOq2JEkutKF9pEL2DYMEM5j5Sm0KL6vLU5HlSiKB0OJkC
 9xIH7JLqD82AV9a88FoRJNsIF7y7Xg3Hhw2lKaAFuxtZo6XrZ2xYg6BBIDFYUVeuBzLy5Podr
 ZVy+Hm0MUJ+PLwc4WmPt85r98cAzAOGnUOZeqU7HlqZGbk0Ug7QiCqPGlEb9a9Jl3CE+Qn1rt
 raHfrsO6heBMr7lHIQtWIpNEemL0A771ziJdO/2swDt3bS1XolKjJf2rwt5B2GAJHzINT0+JE
 qWAPDSroW2fhgSA6Tjk106/SZZICg3MzAUaR+kT/1TjsQIbCBaPBwI1FY/9xH0fTz2q3ZOVBK
 asOOWHnEtueP+Z0Ow2Qpuf5pqPCq/6nYPP43qV1xHQyK0MAKTpf6Z9A7gQqNvVf0RZwa0Rpxg
 l7NyLEbO0gEZPe7I6aAuIfe2SQCJgI9FykbuB/BLCxpBE6Xmp3PtFvduHSD9a/Sq4DdjexO9H
 cPBJ6ZM0lgqtvXic21CDdDJ10j
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Create 'p9210-scalar.sh' for testing Scalar performance and comparing
> performance of Git operations in Scalar registrations and standard
> repositories. Example results:
>
> Test                                                   this tree
> ------------------------------------------------------------------------
> 9210.2: scalar clone                                   14.82(18.00+3.63)
> 9210.3: git clone                                      26.15(36.67+6.90)
> 9210.4: git status (scalar)                            0.04(0.01+0.01)
> 9210.5: git status (non-scalar)                        0.10(0.02+0.11)
> 9210.6: test_commit --append --no-tag A (scalar)       0.08(0.02+0.03)
> 9210.7: test_commit --append --no-tag A (non-scalar)   0.13(0.03+0.11)

Excellent!

> [...]
> +
> +test_compare_perf () {
> +	command=3D"$@"
> +	test_perf "$command (scalar)" "
> +		(
> +			cd scalar-clone/src &&
> +			$command
> +		)
> +	"
> +
> +	test_perf "$command (non-scalar)" "
> +		(
> +			cd git-clone &&
> +			$command
> +		)
> +	"
> +}
> +
> +test_compare_perf git status
> +test_compare_perf test_commit --append --no-tag A

Given the small numbers presented in the commit message, I suspect that
even so much as running the command in a subshell might skew the timings
at least on Windows, where subshells are very, very expensive.

Given that both `git` and `test_commit` understand the `-C <directory>`
syntax, this variant would resolve my concern:

	test_compare_perf () {
	     command=3D$1
             shift
	     args=3D"$*"

	     test_perf "$command (scalar)" "
	             $command -C scalar-clone/src $args
	     "

	     test_perf "$command (non-scalar)" "
	             $command -C git-clone $args
	     "
	}

What do you think?

Ciao,
Dscho
