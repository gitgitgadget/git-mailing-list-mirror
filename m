Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF1C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE8D16102A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhHQVpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:45:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:33817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhHQVpN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 17:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629236678;
        bh=jhjd7smIxj05X+3d96AZMNy78z3C1HWLXZspyyrkxhc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jSWsP8iX/eUGos6clRR4pMiPeRDarWPnn2qc0MLRgIbrBQi58fzQWk7K/JRK2yTY/
         VwjlMTRyzKxDmUQr77A/jTEZmkhwqLZLtdg4tvZrA0CfCEvl/O+FVF+PXG3NSebarI
         89TCE/cO19nRyPRYt/JXvO0GKe2Nhxnk6O9Lv1G4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1nCZ4M0gcG-0137Gf; Tue, 17
 Aug 2021 23:44:38 +0200
Date:   Tue, 17 Aug 2021 23:44:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: don't run cat-file on non-existent object
In-Reply-To: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108172339080.55@tvgsbejvaqbjf.bet>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1986865315-1629236676=:55"
X-Provags-ID: V03:K1:1OFGK1xHGQBfkdPxjA62OscUNiz1pPVH4SPSiWeWcVSlejhISwg
 Yv6HtL41My9eTNLOK/TbgK03k0HOPks+l4OZ3X/FV+kiQzyk92XfN5d32OgDWJNwzV9IjhU
 S9KLEcedU8zZFXxv0NiLhJJHie5jgb0kkEr7D/+fuRmXp+sDkgDFuDoitqgqDLljIVwmxq0
 DRJkPwGFjUHBItXJtfovA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TQcYsB58d2k=:WwdsSjLeTb7HreOrbZGPlP
 XbQi770XRwXkS/DfAKk9hOdAeiKX2KNRiiyge+7Zzs4ALhDS6Ku+PxjK97sn0vNeYA/LsIARg
 mw5Z7lZO6/LErqjfO1itbel0hHwe80IhH2uDSGT0zvkOUcd1GFxjLCye/J2kDXSqddL6Agz7Z
 YrkHA0XzgLJpq9HvFLevA/8lp6F+TKBwEUzTEeDiLoaan6wbHHtEn6lCDTg7QwOrBXU+BFb4z
 77GHTOVtmVJm3LfRg6n5cRZEQk1bYmhsFFZf6jQMm5aOwOOs4REKwIsn7hCW9XkmIwQTSwOKg
 VY8QRBIXzAVFt3nvAEvNkfY348F5u0udvqxUUyFLtBwBSzcHcCFs3fLwTzOwk+kSZjc+d9aw8
 ooZ3Wnths5pwTohT2oDcV8DQm5ltfr5A+JAE0bO4rpR3FG0MyuU7scrY4tpDfU8yuX6CqhB1z
 Q47PPbQui3O02gkPKCFJ15Bw9hcHXwpuNErlThyr618rqE7FxHw/m3z/0qrlZbLs7m6HklhC8
 9uA8NOjQY/SZgoh6R9ajUsJyPtqZTTNZa056RbvnFNA/ptiqrzqxb0WGmM5/IaL36DfQsZ04/
 shwfPA+HqoVmfEMLOYxosFe8xKHer4zHqj0tpfB6T2QCLE7AIzP4lSBsYd6C8GmSgmV4nPDEj
 NYPmjRU521Lnx8viQvKyXzY2+helk/qqS2vA32LY7/Y6D2gK4UGoMuo+vKGDEbN1CS6xUAAju
 e41GOc3++fzDlYj5ifOtsRek+ClZOZxgwSzdU4irpKC/Zb+TM1potsqyT7vvkVPJUqlYws/Ng
 aBdT5bNknGl122n2SAQtSU5uNvWtOm0lIGGI+kf37UsfQojoM3bG1vw9hLojwGgyRNi8PwRO/
 ge82l1av5hut3yOAlsbYa2NvfXQn/s7urOVMX358CqxPC3PqrSGs4EwwSFtYAV5BGk7x+Yony
 pP9tS/DuMDBvUU3lsLnZ7QI2+Vzn07l0/eTXImehlGlsq63TB7KmQ9PegvNE18IXNMijxZwN2
 VibF0N59b/Fq9jkjM3iACm9KItGypcALRYexPT30WlKN9grHw1gDlCBec/5gRl3IeEnEQoIQ4
 U3HYis7e5jF00KGp1rWOiqcAvOZmtLSj6UaBaka2G6Yr/7E8mcA+eCrWQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1986865315-1629236676=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Tue, 17 Aug 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> In t6300, some tests are guarded behind some prerequisites.
> Thus, objects created by those tests ain't available if those
> prerequisites is unsatistified.  Attempting to run "cat-file"
> on those objects will run into failure.
>
> In fact, running t6300 in an environment without gpg(1),
> we'll see those warnings:
>
> 	fatal: Not a valid object name refs/tags/signed-empty
> 	fatal: Not a valid object name refs/tags/signed-short
> 	fatal: Not a valid object name refs/tags/signed-long
>
> Let's put those commands into the real tests, in order to:
>
> * skip their execution if prerequisites aren't satistified.
> * check their exit status code
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>

Makes sense.

> ---
>  t/t6300-for-each-ref.sh | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 9e0214076b..65fbed2bef 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -59,18 +59,23 @@ test_atom() {
>  	# Automatically test "contents:size" atom after testing "contents"
>  	if test "$2" =3D "contents"
>  	then
> -		case $(git cat-file -t "$ref") in
> -		tag)
> -			# We cannot use $3 as it expects sanitize_pgp to run
> -			expect=3D$(git cat-file tag $ref | tail -n +6 | wc -c) ;;

Here, we pipe the output of `cat-file` to `tail` and then `wc`. But below:

> -		tree | blob)
> -			expect=3D'' ;;
> -		commit)
> -			expect=3D$(printf '%s' "$3" | wc -c) ;;
> -		esac
> -		# Leave $expect unquoted to lose possible leading whitespaces
> -		echo $expect >expected
> +		expect=3D$(printf '%s' "$3" | wc -c)
>  		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
> +			type=3D$(git cat-file -t "$ref") &&
> +			case $type in
> +			tag)
> +				# We cannot use $3 as it expects sanitize_pgp to run
> +				git cat-file tag $ref >out &&
> +				expect=3D$(<out tail -n +6 | wc -c) ;;

... we break the _first_ pipe apart, redirecting into `out` instead. I am
not sure that this patch should change that as it does, I would think that
a regular code move (with re-indentation) would be preferable.

Besides, while it is legal and works, I don't think we ever start with the
redirection. Read: it should probably be `tail -n +6 <out` instead.

> +			tree | blob)
> +				expect=3D"" ;;
> +			commit)
> +				: "use the calculated expect" ;;

This necessarily has to be different from the original code (i.e. the code
could not have been moved verbatim) because it uses `$3`, which at this
point has a different value.

My suggestion: mention this in the commit message, other reviewers or
future readers might stumble over this otherwise.

> +			*)
> +				BUG "unknown object type" ;;

This one is new. Do we need it?

Thanks,
Dscho

> +			esac &&
> +			# Leave $expect unquoted to lose possible leading whitespaces
> +			echo $expect >expected &&
>  			git for-each-ref --format=3D"%(contents:size)" "$ref" >actual &&
>  			test_cmp expected actual
>  		'
> --
> 2.33.0
>
>

--8323328-1986865315-1629236676=:55--
