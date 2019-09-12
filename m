Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFC01F463
	for <e@80x24.org>; Thu, 12 Sep 2019 08:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfILI5H (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 04:57:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:37433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfILI5H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 04:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568278622;
        bh=9W4/j1JgSzqWEtWNP8/Jo0nQ0n61sD7AsfRqkvZSEvc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z+1YLl2zhsJa2rEs5Xx6VAFH/94kRw1KE7YUFtPPiu0F5aGlvw1ssCBZDMY9p1UHX
         IB/nxdLC7MZNndeUx0ivtRW4OOetFwZNQsdpSU6EQJvOTSEiukcLN+wYBifzQrBWTF
         lbmKuuO4Xn5z58042sw3oTgH48F38D9pKXnSHYG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1iPasW2xKE-00rcTL; Thu, 12
 Sep 2019 10:57:02 +0200
Date:   Thu, 12 Sep 2019 10:56:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Dominic Winkler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dominic Winkler <d.winkler@flexarts.at>
Subject: Re: [PATCH v2 1/1] contrib/hooks: escape left brace in regex in the
 paranoid update hook
In-Reply-To: <0d762cfb503fef081af9aa3cb0fe373863237745.1568238440.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909121055580.47@tvgsbejvaqbjf.bet>
References: <pull.335.git.gitgitgadget@gmail.com>        <pull.335.v2.git.gitgitgadget@gmail.com> <0d762cfb503fef081af9aa3cb0fe373863237745.1568238440.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cxyU4I4nj7nueED79W9EC0PazewIWzeCX9v5znSuq6kuH5WayUy
 Xyx/BJDD45i4nUwsyO7mWcQzdhYDgtf3xlwA4JIxeQ1+Sn79VtripmWSNGd2UpSAFzmWYjH
 0FIqAw1GhuRBKenP7kSdqIdg5s0hnGagMtppMVLyLzifkYHaQiD6cSwj2Z1urxj7k7cqToL
 vr9iin9Bo8rWqdnGVO3Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGhHjXwkPoY=:Zlek3kqsU5sKw7HWq87G0H
 0y3cP7ykjH1uQWvnrHEQCg06f9GStLi5S0H3axUo8rcU9Z2jLXXxOqF7k51RCL9GNxzOSVasX
 pVDFJmmvDogmQNIWhfpBiieUELyxyg/6FiDbaSXpNcOfCUD3SK30L+iVNly23pEfriw+4+5cy
 1ZrDu0wm1WIxFjocPvjQQU4ZiRq0XtUuVvKdH2+CUsENaa08PkKa5Cp+f/pmdzuHb0xVTnNt3
 lo6CWhcl7+VZmESaMORrJ6/pJtsPRsUq5QWNRAgc9kU54KVnvftSHzbNSXif+nI7qGz4/apZl
 4/bDUARW1YH8BHX9DYSqH7yl1mVGS7PNWGTdU0ELY2QuOCVWwQm9fjoGGE9s6XhbCfUpKuk+E
 rJdHUOphgNW1pU0ZyoDdJWOF1wGAXE9JBLIGrc3SZbGGHKhMdYhw4ptyoaKBKuD2oPUa/GcRi
 ti3CcNP6EyRiU+dAHVIycOk4o7//8wdJySWvulCFSqqNeUO/yXma0QbZmD0MxLiKa+OLfMrSZ
 Voaog26bwXtdfiecife8hUIkDG66LhsVkcNqLt+Mj0LUFPuH6R+UD7mBs69a9XwYvbsIStWpy
 +3EJIPlTo8Dtmktds4KTdo3CUSzQqfj/WlYVZ46/GwN5l3jAUKOGar06kAOMrue89fxvlQ574
 eVnFZRklG1+3sfm34YbG0cRNceJy6vk6llk4D/+r8JkEnD6j4onRB2sZwzfsShJmJpwt8hUfS
 l3DJ5/ESkFwHxuzHBNohQZOxamHy/hE20HSOqTd6oA6dP/IdWn/CUAGZ7PTATYjrAncUm1Ehs
 G+kfymM2o/WO9cm7bdd5QmvtfwbTfkQ/1S1gAFQzN69WPDrWkeK3gNYn9S94bFJTwGMVsbx1j
 AvE29YHiSwNyvCmGfbCyxZwmtxMm9b/bn3Xcv8DLJqsYkvdIUM6rbCwcJ+lWnzqqa7mqixvAx
 70ttGvLyG93KSnCdI3TtufKLitRv2fB20QYIYWqBX5DGD6gZ9mLQOH087po533ndz5eIyKmkP
 GafEppnq7gRMftx0A7Gqu1BtQfIAGFbG5TAzX6gJ3fHCAYfY3AKVKIHt/tNs2ysDJ7ERKKm4o
 NidNRyrcYB6StNByE/BcRlsX3gSzfNr6/Y7wq9Ft0yyjoeIf3Tz7isp94309vOTaNf1QJZoyw
 GHWLX9A5Ps8OAawv2LJfUyl81iSPDigOQRKXi1wioyLFKG0rhe9+IXj0P5Ex3Ggj+u3DXyTBh
 NEsyvrC5RPt+wSmWa
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dominic,

On Wed, 11 Sep 2019, Dominic Winkler via GitGitGadget wrote:

> From: Dominic Winkler <d.winkler@flexarts.at>
>
> A literal "{" should now be escaped in a pattern starting from perl
> versions >=3D v5.26. In perl v5.22, using a literal { in a regular
> expression was deprecated, and will emit a warning if it isn't escaped: =
\{.
> In v5.26, this won't just warn, it'll cause a syntax error.
>
> (see https://metacpan.org/pod/release/RJBS/perl-5.22.0/pod/perldelta.pod=
)
>
> Signed-off-by: Dominic Winkler <d.winkler@flexarts.at>

Thank you for addressing my concern so promptly. I am far from a Perl
expert, so take this with a train of salt: the patch now looks good to
me!

Ciao,
Johannes

> ---
>  contrib/hooks/update-paranoid | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-parano=
id
> index d18b317b2f..fc0a242a4e 100755
> --- a/contrib/hooks/update-paranoid
> +++ b/contrib/hooks/update-paranoid
> @@ -302,13 +302,13 @@ $op =3D 'U' if ($op eq 'R'
>
>  RULE:
>  	foreach (@$rules) {
> -		while (/\${user\.([a-z][a-zA-Z0-9]+)}/) {
> +		while (/\$\{user\.([a-z][a-zA-Z0-9]+)}/) {
>  			my $k =3D lc $1;
>  			my $v =3D $data{"user.$k"};
>  			next RULE unless defined $v;
>  			next RULE if @$v !=3D 1;
>  			next RULE unless defined $v->[0];
> -			s/\${user\.$k}/$v->[0]/g;
> +			s/\$\{user\.$k}/$v->[0]/g;
>  		}
>
>  		if (/^([AMD ]+)\s+of\s+([^\s]+)\s+for\s+([^\s]+)\s+diff\s+([^\s]+)$/)=
 {
> --
> gitgitgadget
>
