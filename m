Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB211F462
	for <e@80x24.org>; Thu, 25 Jul 2019 20:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGYUCx (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 16:02:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:35433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGYUCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 16:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564084968;
        bh=uZui6ZdQZgy/Lb89Ofz6GX6hR0Il2pV6V115moNe6Ik=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hWnBS/KJ0KSqCjp1D/Gfgqt4Kf3axKMaHQwUIW77I4fk5Usz5IwCHbogtsxTgXcLl
         XZiIqRGJz/QsxKHxVo3LBpQPennloHs5RMlKYPHbKwjwzKvibz8dXv1WXDxJMqygpQ
         9B47T8GUFe798Z0vfY8VxDJuhQZOtc73/jpetvkY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1iWliB44Sm-011yfK; Thu, 25
 Jul 2019 22:02:48 +0200
Date:   Thu, 25 Jul 2019 22:02:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/19] merge-recursive: rename 'mrtree' to 'result_tree',
 for clarity
In-Reply-To: <20190725174611.14802-11-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907252159250.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-11-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fHD9x6XKdC9I3FGD9NGqZY9+kZNqFzTRy2yU45x+v7YWxnsT8s0
 qdK7bWyNr7zvak/dKqfCxhkdmrBfRtlag8disxiGF/0y9TMZ5dkheDbjslloBf6JucZzgOj
 BqI97B4scbQ/m8PH7fZX5dN8ILP57KV9zvyTg9sEeClnqkOl4tTnJqKvpyDNpdx7RqWuwck
 j7KOhYdkAHghScxkY5Ebw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yje6DAJXevo=:8dLG3Iuhlri8nCv5Unh0ec
 jXKI6R80EbYP6RL/3/HrisiDLMmxHvZ07E/ZPiIf+M0GHfCHpGsBdV/ADo6axoSFRbifk77QS
 z2B9M57jOI81nmYxFe62kcV8VIfVELYm6Sf6gaZV6sxxwIaCzFxvcduX/RMY5W8wA0ilSIe52
 a4Zf9ZWkWXqZdQ6eSCyYnrxyp3ssIvosI36DKCR+S/qxOnIX7c11Pt6pLgs8PYhbuLOBYSnll
 /0U81i2CJBpnFioRCS3HljjZjUBKrXHNsJpell8esxzdmAS/G+uDvA/b6yTXTpL3gq+udKarr
 bXMXm6JHpzlvu1zfipzpCQwjoViCHVo1eYLEN+OxvbXdNHKkc3wU1D29XIedJxdmOARo2Hs4p
 nHeU2q9DLiZAczjLHlb0cnNzzguL4TE5MtCp03gzov62+T0rddSKRvSfQtNYmw7udS8yTsuoR
 IX+ueoYkQ67+tdwA/tG8kawXmWnk10omnXspbvCna5xKUv1Xdd5czGRRYAl+EO5iCiV6GM1Jv
 UJNLy51eS/q56ufxV5l3pCFFcDWHkmfrjJEfjp3Vgs13+zp+28anzrYlfsF9NaLHuqvGU8/h+
 Tv/7NGJQr54n5aq2bVP8Tvj5zwUSlK/+hX9eHs8wTihB3fqgpIHTV7nB3lPtfKRPPuQioP3du
 T+rtLW1GIgGGk/VQMi5oeWF/3UT+UGEH/8JNR6QcrSWn09HTR1p548YpncS4H62sYNXlvMVtT
 bxZWcx2eje9KL5GvkrXWS7BEbbYajGV3Vb0FjoGsgAeCJW7wGjJQ//3thpN6Hk0Qzbz4ZKu/3
 DWRnz0ZsLd2Vsz3BL98VXFMryPE/hykqxNBAtkt5T+5mj/zH/otuRH7a+tJeSAwSbsbXXoU5o
 URZXAGaWxwyyMc4rX36tIYNwBjam5uA3oTRpFhgMr8kMzmpd/FOdHESS//pYl3yq4jmTDj5pZ
 onp59lihOVhbBLhF9QfkAug8eGM7l8pxUqYtgRf5ELLhvNOAGbjzuhAjVStdGFDHkkYBz7rr6
 DVj2SoehGpUMgZ+77zG4tetsVVghoLcxDF6X1MKToZSLIuoQpvwo8kAoAVzrnue6uSkGnRAiX
 POsXhJ13WaXX1pat6WrGLqgR1gkCA4aYMzf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> It is not at all clear what 'mr' was supposed to stand for, at least not
> to me.  Pick a clearer name for this variable.

I got curious, and it looks as if I introduced this in 3af244caa82
(Cumulative update of merge-recursive in C, 2006-07-27), where I moved
the variable of type `struct tree` out of a `struct merge_tree_result`
(probably because I found the latter a bit pointless).

The best backsplanation I have for the "mr" is therefore "merge result".

I like `result_tree` better.

Thanks,
Dscho

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 0a90546824..61faa26c4f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3475,7 +3475,7 @@ static int merge_recursive_internal(struct merge_o=
ptions *opt,
>  {
>  	struct commit_list *iter;
>  	struct commit *merged_merge_bases;
> -	struct tree *mrtree;
> +	struct tree *result_tree;
>  	int clean;
>
>  	if (show(opt, 4)) {
> @@ -3545,14 +3545,15 @@ static int merge_recursive_internal(struct merge=
_options *opt,
>  				     repo_get_commit_tree(opt->repo, h2),
>  				     repo_get_commit_tree(opt->repo,
>  							  merged_merge_bases),
> -				     &mrtree);
> +				     &result_tree);
>  	if (clean < 0) {
>  		flush_output(opt);
>  		return clean;
>  	}
>
>  	if (opt->call_depth) {
> -		*result =3D make_virtual_commit(opt->repo, mrtree, "merged tree");
> +		*result =3D make_virtual_commit(opt->repo, result_tree,
> +					      "merged tree");
>  		commit_list_insert(h1, &(*result)->parents);
>  		commit_list_insert(h2, &(*result)->parents->next);
>  	}
> --
> 2.22.0.559.g28a8880890.dirty
>
>
