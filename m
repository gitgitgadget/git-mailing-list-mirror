Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CE92018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbcGOKpi (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:45:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:63348 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932187AbcGOKpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:45:36 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnOve-1asUTq1cT8-00hayX; Fri, 15 Jul 2016 12:45:16
 +0200
Date:	Fri, 15 Jul 2016 12:45:15 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Mike Hommey <mh@glandium.org>
cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] blame: Allow to blame paths freshly added to the index
In-Reply-To: <20160715024254.29186-1-mh@glandium.org>
Message-ID: <alpine.DEB.2.20.1607151242020.6426@virtualbox>
References: <20160715024254.29186-1-mh@glandium.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:E1633/15tZbLdnd+lgHxFSjO3ErrqTxuPhxjDZLoF2a4x0n3ScZ
 rrtVwjCg5iyxmkDUbIlUETi0XV6pN0RlNK3oenRiddWYdCv9Dx6AZgqk7FzX/fkpRZZyM8v
 MWBLk4m9O3eyD1b0zsRuxdknsty7iX2KE+vaHBCKLNDrk9SIf9JTqMY0tjfJCg5SOl6s0+X
 lukx2bc7+Ej0/bylAoPvg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YsNXEhYIjdM=:n0TrzATea4zkwOEQYxMKTX
 Lmj4h88B3v3TVMEC6+482vCjB0YYsadvTAjXyaDptXjU4E4dGQcgm8hoTJx6cljS1U5M2aSGe
 TpGw+Nrk9s6mGQfNAdbM0XPI8+qNmKEMHYCLz07f0oF16GqbMhyBiAIVo6NQPKREIs8iNB0d4
 cjaF/RxGSrLjfCDGjmZ0Vf5I4idJC2jtMgWweX10HVwfo6DgwHnEdMA8WfpZoUgXJWQ5bbyfj
 +f8C0uhcIKJVT4WqEWFw149YnDTtC6jUjepJRG/Oz9PxkKp1re50LVLbBBW4hPOwZMYB2Wnqt
 3Ak5B5LhExn6dvxy2+0XTOrbgKnJazO7IDCbHH267WmeeX2oRPNNExcY4BNc+uNF4U1fb+05K
 lfuvi9eOnqifm7q24CCg5y9yymJ+L/trAafA7gM8fJ9dqHG90XS1sm/89d9doWkNA1tuIeL1E
 vsAUsxn/0VStQv3gPssnI4Iyxj2s3EpwBR7MYiR2L/uWwjWPst2IPVCXbBrszDyV11uFHI/wi
 8Q+RRNkki8UUGrw+cB/6JXaXLTs1tTdkx7zHBLyf/mOoa370ZRSewkTXN/MEYhG68dg3px7xz
 aF+z1D/VoSMhpS2j0qF0hwiThgWaps7MoyXRSWfDfNMiztqHGJ4gFvWy8+b17+MB8kVllh58h
 9+h8xXh5+B2qy47eaTQon0dzuETnQAddkHnpRPiYe+czPYoWDJoulW6rP2JkgfPD5QWGNY919
 j+eNNyFnsALcxTGCuokRTyue1++hO35K6GA0F21tfllz3cPxjbPxYeJgAAcfdCepT4Z9Bh7PJ
 m11FCKN
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Mike,

On Fri, 15 Jul 2016, Mike Hommey wrote:

> When blaming files, changes in the work tree are taken into account
> and displayed as being "Not Committed Yet".
> 
> However, when blaming a file that is not known to the current HEAD,
> git blame fails with `no such path 'foo' in HEAD`, even when the file
> was git add'ed.
> 
> This would seem uninteresting with the plain `git blame` case, which
> it is, but it becomes useful when using copy detection, and the new file
> was created from pieces already in HEAD, moved or copied from other
> files.
> ---

Well explained.

Please add your sign-off.

>  static struct commit_list **append_parent(struct commit_list **tail, const unsigned char *sha1)
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index a9b266f..a0a09e2 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -137,6 +137,29 @@ test_expect_success 'blame wholesale copy and more' '
>  
>  '
>  
> +test_expect_success 'blame wholesale copy and more in the index' '
> +
> +	{
> +		echo ABC
> +		echo DEF
> +		echo XXXX
> +		echo YYYY
> +		echo GHIJK
> +	} >horse &&

A more common way to do this in our test scripts is by using here
documents. However, in this case I would suggest

	test_write_lines ABC DEF XXXX YYYY GHIJK >horse

instead. The equivalent applies to the 'expected' file below:

> +	git add horse &&
> +	git blame -f -C -C1 -- horse | sed -e "$pick_fc" >current &&
> +	{
> +		echo mouse-Initial
> +		echo mouse-Second
> +		echo cow-Fifth
> +		echo horse-Not
> +		echo mouse-Third
> +	} >expected &&
> +	test_cmp expected current &&
> +	git rm -f horse

Should this not be a

	test_when_finished "git rm -f horse"

at the beginning?

Otherwise it looks really good to me.

Ciao,
Dscho
