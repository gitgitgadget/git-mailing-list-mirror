Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1B51F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 07:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeCYHg3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 03:36:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36762 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCYHg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 03:36:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id 201so726747pgg.3
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=LvgFBLH+Y9nAZ81DMELr0sLbC9kIooQ+WfjoJutHpfU=;
        b=chb9uKDOfDCrSUOkjlUz1aJih0bnDrTKXJqLEEt7nbnf0joJfz1v03T7+zrpumNYdF
         +bnLoqqQA08WMAz4q/B5iB7JprI1CzgohbwbIx+xUhLR6rvSSjMIHxsbjEfCw7pAbO3Z
         uk1sCl606QFn9djUb5kUBOcarngdPrD2kBmnO5CwUcv3dN0Y91sUlMLvp8BckEmQEKsS
         q85i8oGHSFbIMSzo4vUT3iuBz+aGVrmPRMIbXFjZMiwL9v4Rp5mJqwM/kFnKt5oiKiFw
         oPbM+eXHnraSUWC8YLb89MHMmn8BMfj/uD8SHalHMJtl/g7+t+DdxYA6a3YarcUrLQMl
         Vy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=LvgFBLH+Y9nAZ81DMELr0sLbC9kIooQ+WfjoJutHpfU=;
        b=FdDzi7j5kmdzoLTqCWDBWfOlv1E2F9IgW/afJh4clMxVEjYL3VXQ8wg/ORak8s1j8T
         DRLb3goRSmXLCkr/Y0xUVj4IcRa2BUSoyCq7LgvotpqJF1ByrZGAr6zP6RNDp06tLTEs
         1D6sE/ZzwvNezGdlanzjUiaW7Ka03ICaFUiWPjQBPwWXdfBWsKxxkqTUen3PWJoRRuBh
         hdA0E0BQgvlEi9Jo4wF9dhSc31e7qq7l/27wezwSYr7VBMAiKdvwcg/Aquge4OEWylRc
         sPie9O2FuhQKsngBn8b45dnG9cnbvqgpQe0K4NezzTzjMZiH5eriLBF2N2NNpUpT6ExG
         V9aA==
X-Gm-Message-State: AElRT7EOxMpH2Ekhm/7C5l5qe4/CEf+U0evlwyixCCMsLRtalz8McS2w
        YkHVAxkuEnTrx27i1HwZhuF7kfuM
X-Google-Smtp-Source: AG47ELuwBhkH5SFq2xiAi0ZUT6Ez7pfoSXS/V99dlGlqOnAQolkh2IhD3DHPLIorwD9vQO7xuaCqZg==
X-Received: by 10.99.42.209 with SMTP id q200mr17362516pgq.379.1521963387094;
        Sun, 25 Mar 2018 00:36:27 -0700 (PDT)
Received: from [192.168.206.100] ([117.249.137.56])
        by smtp.gmail.com with ESMTPSA id x80sm7153149pfk.11.2018.03.25.00.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 00:36:26 -0700 (PDT)
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
 <20180325054824.GA56795@flurp.local>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <42ca98f1-e916-a159-27fe-02137f73a525@gmail.com>
Date:   Sun, 25 Mar 2018 13:06:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180325054824.GA56795@flurp.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y6hLcRxww2KzHLjanWPvs5rnUgdL5KH8k"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y6hLcRxww2KzHLjanWPvs5rnUgdL5KH8k
Content-Type: multipart/mixed; boundary="796Ibjzu7NmXazp01CspPwAa8ob5IWDom";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <42ca98f1-e916-a159-27fe-02137f73a525@gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
 <20180325054824.GA56795@flurp.local>
In-Reply-To: <20180325054824.GA56795@flurp.local>

--796Ibjzu7NmXazp01CspPwAa8ob5IWDom
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Sunday 25 March 2018 11:18 AM, Eric Sunshine wrote:
> On Sun, Mar 25, 2018 at 09:11:34AM +0530, Kaartic Sivaraam wrote:
>> On Sunday 25 March 2018 07:04 AM, Eric Sunshine wrote:
>>> Can we have a couple new tests: one checking "git branch --list" for
>>> the typical case (when rebasing off a named branch) and one checking
>>> when rebasing from a detached HEAD?
>>
>> Sure, but I guess it would take some time for me to add the tests. I'l=
l
>> send a v2 with the suggested changes.
>=20
> A couple more comments:
>=20
> * Please run the commit message through a spell checker; it contains
>   several typographical errors.
>=20

Thanks for motivating me to search for a spell checker. I have now
discovered the spell check feature (:set spell) in Vim!


> * I wonder if it makes sense to give slightly different output in the
>   detached HEAD case. Normal output is:
>=20
>       (no branch, rebasing <branch>)
>=20
>   and, with your change, detached HEAD output is:
>=20
>       (no branch, rebasing d3adb33f)
>=20
>   which is okay, but perhaps it could be better; for instance:
>=20
>       (no branch, rebasing detached HEAD d3adb33f)
>=20

I just recently discovered that the variable used to print information
related to detached HEAD (state.detached_from) might also contain remote
branch names (origin/master, etc.) other than commit hashes. So, it
might make sense to distinguish detached HEAD.


> Anyhow, I wrote the tests for you. When you re-roll, you can make the
> following patch 2/2 and your fix 1/2.
Thanks a lot!


> (If you go with the above idea
> of using a slightly different wording for the detached HEAD case, then
> you'll need to adjust the 'grep' slightly in the second test.)
>=20
> --- >8 ---
> From: Eric Sunshine <sunshine@sunshineco.com>
> Date: Sun, 25 Mar 2018 01:29:58 -0400
> Subject: [PATCH] t3200: verify "branch --list" sanity when rebasing fro=
m
>  detached HEAD
>=20
> "git branch --list" shows an in-progress rebase as:
>=20
>   * (no branch, rebasing <branch>)
>     master
>     ...
>=20
> However, if the rebase is started from a detached HEAD, then there is n=
o
> <branch>, and it would attempt to print a NULL pointer. The previous
> commit fixed this problem, so add a test to verify that the output is
> sane in this situation.
>=20
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t3200-branch.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 6c0b7ea4ad..d1f80c80ab 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -6,6 +6,7 @@
>  test_description=3D'git branch assorted tests'
> =20
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
> =20
>  test_expect_success 'prepare a trivial repository' '
>  	echo Hello >A &&
> @@ -1246,6 +1247,29 @@ test_expect_success '--merged is incompatible wi=
th --no-merged' '
>  	test_must_fail git branch --merged HEAD --no-merged HEAD
>  '
> =20
> +test_expect_success '--list during rebase' '
> +	test_when_finished "reset_rebase" &&
> +	git checkout master &&
> +	FAKE_LINES=3D"1 edit 2" &&
> +	export FAKE_LINES &&
> +	set_fake_editor &&
> +	git rebase -i HEAD~2 &&
> +	git branch --list >actual &&
> +	grep "rebasing master" actual
> +'
> +
> +test_expect_success '--list during rebase from detached HEAD' '
> +	test_when_finished "reset_rebase && git checkout master" &&
> +	git checkout HEAD^0 &&
> +	oid=3D$(git rev-parse --short HEAD) &&
> +	FAKE_LINES=3D"1 edit 2" &&
> +	export FAKE_LINES &&
> +	set_fake_editor &&
> +	git rebase -i HEAD~2 &&
> +	git branch --list >actual &&
> +	grep "rebasing $oid" actual
> +'
> +
>  test_expect_success 'tracking with unexpected .fetch refspec' '
>  	rm -rf a b c d &&
>  	git init a &&
>=20


--=20
Kaartic


--796Ibjzu7NmXazp01CspPwAa8ob5IWDom--

--Y6hLcRxww2KzHLjanWPvs5rnUgdL5KH8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlq3UXMbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpBwQP/jcnrKuKWruHlWFzTajz
9eGhM7fdwvjNErxFbDhzMW1ztA+vV65npDwjksDxIdHllkSkkIfCHjNJAGbz2ldC
C33yfGoAWuOlQkI0Q49unAjgIxOu6zYeFa/+Y/Mn5/fpgp/5Y83duPgpQwEAjFwv
HtmqVa2bDczHQqsvmCQ42VQ5vRCEdsym3sLJMC0Uoj7zlMUk5eX9wcgLXUG/0rcj
T+H9PQxVMTWfLnIeF31Pbwj4ktFFnrp9R2kzz3dWWsMB4D/MDsb/ILXMzJ4EOneg
aj2mFfCg3zB/mRmjCsrm63ZHw7iS/fVAvth/5Z7QXb9HQw4bQLOEAMxjpW/X+U5B
iY8E23NXCevXrlu2+aGLrDpQ5yW1Psm3VN9yMiVfZ77K88rcody/TGEiUlhi0t95
K+q+wilcr9OeX/lEoABJshTwVCF9ssqhVfrj4B7cTP4AUKg6Pf87Ord63Obsl9+f
3/EAeYj/PJ2IPKFguR/jR8zFRdh1JfPd+nRRXmONMZ53KabLMbRK3Nz7qyAAQ8qs
92VhUQ//QbyPNMVdTsUn0dBO6wSYU25bl/I4wbufcpvlYom8/0xXPcg1F/7XDzDL
ThJS1Z34xObtBilkRZc6MpWyiUedwgO6nJ2bEBp1paGM2WALNErgODUwCCT/Ureq
HUc1dJN5/4Q4DW39uzyjZzIH
=rnOs
-----END PGP SIGNATURE-----

--Y6hLcRxww2KzHLjanWPvs5rnUgdL5KH8k--
