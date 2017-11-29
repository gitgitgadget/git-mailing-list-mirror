Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0D720A40
	for <e@80x24.org>; Wed, 29 Nov 2017 21:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbdK2V3T (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 16:29:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:58758 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdK2V3S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 16:29:18 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgbvP-1eVVwB05gN-00Nwbs; Wed, 29
 Nov 2017 22:29:16 +0100
Date:   Wed, 29 Nov 2017 22:29:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] pathspec: only match across submodule boundaries when
 requested
In-Reply-To: <20171128232237.54453-1-bmwill@google.com>
Message-ID: <alpine.DEB.2.21.1.1711292221060.6482@virtualbox>
References: <alpine.DEB.2.21.1.1711260210060.6482@virtualbox> <20171128232237.54453-1-bmwill@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9EWBKRPWfFfWxO5wF47e5zyYbVqrJ4+0nMc3OwBYVBMmkSu5Xke
 G8gJGSi5/4J80RTMrADoj545fRc2BxwCqAsJrCmgTC5S6XZsPPWCNe6KgN42JMEZyH1QsbL
 Wk6KmXwyRpDZddLywalMXVx4c6ETYvdhkcc6Qi9FBqEoaU1swOoMyURpEBtHoz/q6QyRzii
 phVdQgPPFZDgGmhuSbj2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kGb48qYAlqg=:jrXaPo0JmMJDM0/vZT8r1O
 XQmafiVsg2Y456hNNSIp55594nZ2lZz7zgi8sqLhM8AHimF6QuUvO9iMb69w0/pCVef7g1U5T
 fpEL4VFQEi9gcJ/hHc9SZBilSVDl9QeptqtbjbN0Hhi+tXQnosjwCIKFVUImsBgKIxPVFCktF
 7kS3C1OtAXmzk5KRi+dOuSC6YdtOzr0jr+VdA0Bd91yIzAFfU4CuceBddk/T602pjG2ZliB3H
 lgKQ2FydZ9N4MQsvrghh1c6AiobJeOs7ZAeDO0a82xIIGHaVj+i5vqf1gazRu7DSxl+Pc2YeU
 L465RW/j0vxbgtAQSaUGcgEPwBYm5JHkir2MNFiofa7wUBUTDN/sRVeYOD+UrbZkmiOKh02Z3
 kILn9ISuZgFbKJno4GEUGuu2gfxxldip8dm2jUDElGQg2X0ha4mkOvkhndah5zRX05OvLWLlT
 b2GlXV8XYpB2ZMuVmlBCvlewkLxjEe/GANSuB3mTwlV0rfvpONkF322PPP+MTN3zAvFsFU5rk
 j/vamwm00Y1OgzVMvvFM7yaSGhabKFVHRk7Cdn7eYAE8Y/NwsrfA9g4pPr+dEqBHjY2TlW3fP
 PfMLu7B4NgB0QbvKD4bTYDWTtr/XuWw3qsWGX7HWXHL8Z4plUd/lf7CMQLzXm2t+EZQsEem+t
 DLPgIlj+Dt7PyxGl2psNdSaMlbX3+otrLgnSRU2jkwEBxzngxbKzmc+x/uFiIku2GWMF6o1qW
 Jh+IyBV/SGFee94KESaA5ERYRbRxsMUlrPf4Lvprq6w0QTXJJzNHBvA0gWVOamLfp5z3EadPv
 /8r8yLMfeB2oX9R4+E/3C96XK1ZWAxCS+O9NVsU4WM02K1+j4DzDPxo1VkaC5tjVKALUYAy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Tue, 28 Nov 2017, Brandon Williams wrote:

> Commit 74ed43711fd (grep: enable recurse-submodules to work on <tree>
> objects, 2016-12-16) taught 'tree_entry_interesting()' to be able to
> match across submodule boundaries in the presence of wildcards.  This is
> done by performing literal matching up to the first wildcard and then
> punting to the submodule itself to perform more accurate pattern
> matching.  Instead of introducing a new flag to request this behavior,
> commit 74ed43711fd overloaded the already existing 'recursive' flag in
> 'struct pathspec' to request this behavior.
> 
> This leads to a bug where whenever any other caller has the 'recursive'
> flag set as well as a pathspec with wildcards that all submodules will
> be indicated as matches.  One simple example of this is:
> 
> 	git init repo
> 	cd repo
> 
> 	git init submodule
> 	git -C submodule commit -m initial --allow-empty
> 
> 	touch "[bracket]"
> 	git add "[bracket]"
> 	git commit -m bracket
> 	git add submodule
> 	git commit -m submodule
> 
> 	git rev-list HEAD -- "[bracket]"
> 
> Fix this by introducing the new flag 'recurse_submodules' in 'struct
> pathspec' and using this flag to determine if matches should be allowed
> to cross submodule boundaries.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

Could you also add something like

	This fixes https://github.com/git-for-windows/git/issues/1371

at the end of the commit message, to keep a reference to the original bug
report?

>  4 files changed, 22 insertions(+), 2 deletions(-)

Phew. That was much smaller than I expected.

> +test_expect_success 'tree_entry_interesting does not match past submodule boundaries' '
> +	test_when_finished "rm -rf repo submodule" &&
> +	git init submodule &&
> +	test_commit -C submodule initial &&
> +	git init repo &&
> +	>"repo/[bracket]" &&
> +	git -C repo add "[bracket]" &&
> +	git -C repo commit -m bracket &&
> +	git -C repo rev-list HEAD -- "[bracket]" >expect &&
> +
> +	git -C repo submodule add ../submodule &&
> +	git -C repo commit -m submodule &&
> +
> +	git -C repo rev-list HEAD -- "[bracket]" >actual &&
> +	test_cmp expect actual
> +'

Nicely prepared for a new hash function, too (no explicit SHA-1).

I wonder, however, why we can't `git checkout -b bracket` and
`test_when_finished "git checkout master"` and void those many `-C repo`
options. But then, it is actually one of the shorter test cases, and
pretty easy to understand.

However, I would still like to see `test_tick`s before those `git commit`
calls, to make the commit names reproducible.

Thanks,
Dscho
