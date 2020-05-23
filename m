Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C531BC433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 07:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E2B206C3
	for <git@archiver.kernel.org>; Sat, 23 May 2020 07:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iXcAGiy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgEWHIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 03:08:04 -0400
Received: from mout.web.de ([212.227.17.11]:34969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387629AbgEWHID (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 03:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590217671;
        bh=yaFPdflKr+Nh9s7GgNllhG3DUH0cfSJNF6aSzKzF8uI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iXcAGiy7Iho8yXvNUzMRJJEBjvS/m9DK7k9XATRuDqu6JRGjsMR4f0k9mf+OIEOXQ
         PnqyQDktKUnbhs4Efu4V/0rGWpAjLfAS32ogEePy8uNExtldxOq5e+/I2NfvGekKFp
         QpVHMfy9AC5J1M4+SarJAl3HGBX6fzrmA1+qSI78=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lheqz-1jGZyo0NxB-00mpMf; Sat, 23
 May 2020 09:07:51 +0200
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
To:     Jeff King <peff@peff.net>, Dana Dahlstrom <dahlstrom@google.com>
Cc:     git@vger.kernel.org
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
Date:   Sat, 23 May 2020 09:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521191626.GC1308489@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:082gw/7Le9v+ZaJid9d8X4JB2THtqWF7VUnkOYUnTHwbxEBBvhA
 KkXszmiXwr/4xBjUkTKP97A/vJz+bW1nEEDMpK3oSKJompboRsSGngjnEJja0HElL9e4R4Z
 siNl+5tdv2NxBA810VkH5BzUUPzspl/2J/rftXVsVB1m1P3Mv/sK3mha8MXY/hYyKyb2l0f
 KPKFlfXj7PSu/vlps2Z0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lywRVBk6PXo=:CG3BTuKOi21zBZjtmOsNO+
 mD+pjvg2p3bfsD3aYiH8H6stXxV3PF4GHfVu3NbKPWdhx5UBDNUzk75naKhFLllRH9k1T6jEN
 HY/62D67YdE8lt/Rjpx3aXvSstTou0ltqISvCCPvesvW7+whkhVG84SLX2fF5GYU00LgPnhSd
 okslfN6aKm/XvlCpFaIUoTM33tLnHpuq8uDizJ1MSY0if8UvLjWx9JFcQeW1BKzs5MKjjOkGe
 nD30bjP37Vtxxxs3w4Tf6XYoaPj4HkE7FQgEHnmxxin/j8saHPM2ocXxcdo11YIAwt/aVs8s1
 WLVCc5StWvgJQeRiX03fOv+6ZebuhfuGp8G63D3EYzntxPKddItmlRtCrjft0JNPagHXw1Nd7
 Mvd8Urz4nr5d1tdAZmKW6dvLxZdQIry83tWxK9jwHSJfV0u+G+20hH1giL34Rps4gXExA0JHs
 DjBpvSfJmFLuRwC7uwoKGmyK2JaWa2K51E2ksm3NQLg1oishRPaWVv7Px/dq3+OV5W9+dAx7l
 KDFDeWYOFqv9H7XzoOS15vXv2EGc1kV20qaTyy1I/8gClOQH8J6f7kTSc9l806JfQx94SPHLF
 /uLNDFRUNobHPFrePnQGK7MmjcLVeY7MmHQDWBEsDnoa7+5gRn3EvyZwx4Fw15SEhkIceCyBz
 gjgzuGMqbCta1vcZi4/Me6+dHyG7EuqVkf+BtH6F4S+uSw6ENjQdW7ejLbp5lLcl2l97Y6adu
 RO81IvZPWVVpG1aex2JO+zw1ZMFjQTHYXmU8+azZdA0T6B5G8RISgMe2Z0gQdxK9av50ZzsI3
 zvAPlrhCnZczXaY9xFDCPV05sPDTDb1lk3Wcp8lS1NdcyW3Pxzd0auxdJiAu+lynAwh5OPJb3
 5CnpG1outNVWBK/awaHOWl/RA5yWnhOsDkeI+GVuRppqwa/2wJVb8O4L2ETTfPbUQD/tPky/S
 6PxYvOL/E1V1ahTZX3q0IJh3lDPda9Gs44DqxdkPKtZ9KsuRcwX7P/zrDZQabXzeaLKN3E2hB
 L40AksQ1Yox21CeKb4dzaUVRK57FMO984gTb5ZhW19ADR2Y2onedV88dFzaAWjzObZQJTmzsA
 bxMcVR3qdFZcVY+vAsvGyn93rwTnwPU7qhtCwJn2kMgHChDOjh/h7BiSeC/luuoBWitvGEbSD
 owwVv+ub/mb3EIc8D090YOPINF+pjGl3/Bgyq3GLLf7AchGs3XSY7l/Ojbj4xfDbhXgJi4UTT
 yM55K8tgZ9m0rTGUb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.05.20 um 21:16 schrieb Jeff King:
> Something like this works:
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e9d111bb83..6559ac666b 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1553,6 +1553,7 @@ static int checkout_main(int argc, const char **ar=
gv, const char *prefix,
>  {
>  	struct branch_info new_branch_info;
>  	int parseopt_flags =3D 0;
> +	int got_start_point =3D 0;
>
>  	memset(&new_branch_info, 0, sizeof(new_branch_info));
>  	opts->overwrite_ignore =3D 1;
> @@ -1661,6 +1662,8 @@ static int checkout_main(int argc, const char **ar=
gv, const char *prefix,
>  			!opts->new_branch;
>  		int n =3D parse_branchname_arg(argc, argv, dwim_ok,
>  					     &new_branch_info, opts, &rev);
> +		if (n)
> +			got_start_point =3D 1;
>  		argv +=3D n;
>  		argc -=3D n;
>  	} else if (!opts->accept_ref && opts->from_treeish) {
> @@ -1689,7 +1692,7 @@ static int checkout_main(int argc, const char **ar=
gv, const char *prefix,
>  		 * Try to give more helpful suggestion.
>  		 * new_branch && argc > 1 will be caught later.
>  		 */
> -		if (opts->new_branch && argc =3D=3D 1)
> +		if (opts->new_branch && !got_start_point && argc =3D=3D 1)
>  			die(_("'%s' is not a commit and a branch '%s' cannot be created from=
 it"),
>  				argv[0], opts->new_branch);
>
>
> to produce:
>
>   $ git checkout -b work -t master HEAD
>   fatal: '--track' cannot be used with updating paths
>
>   $ git checkout -b work master HEAD
>   fatal: Cannot update paths and switch to branch 'work' at the same tim=
e.
>
> which are both correct. I wonder if there's a more elegant way to do it,
> though (probably not, as there's definitely some heuristic parsing going
> on to determine which checkout mode we're in; the new switch/restore
> alternatives don't suffer as much from this).

Perhaps:

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e9d111bb83..24336e1017 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1689,7 +1689,7 @@ static int checkout_main(int argc, const char **argv=
, const char *prefix,
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts->new_branch && argc =3D=3D 1)
+		if (opts->new_branch && argc =3D=3D 1 && !new_branch_info.commit)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from i=
t"),
 				argv[0], opts->new_branch);

