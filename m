Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C8C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361CF206F0
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 22:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BNl2O+R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgAZWI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:08:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:39683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgAZWI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 17:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580076499;
        bh=Fu+D1NVROL+hETHMobmAd+peE9yvDJjEvW+UTu4yDjs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BNl2O+R1qINjiYjDpZ/cztfODc10+vc/vRu4IpG0wdohI7WW9WEI2YKXfgOWQ8rTs
         4iwUZpCjxYBHYqUOgjhO9H27a4BOvopKogQtfwx7y4CwqI4VftzrTXeIAMsLv5clPK
         byzBCSXP8pt0z++pFaqfTUxuWJ0Ct8TWExvHzQMI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1jLrRB0uFW-00ikr6; Sun, 26
 Jan 2020 23:08:19 +0100
Date:   Sun, 26 Jan 2020 23:08:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/22] t4013: make test hash independent
In-Reply-To: <20200125230035.136348-9-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001262303530.46@tvgsbejvaqbjf.bet>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net> <20200125230035.136348-9-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:248YGCSYDZOEzRXAp+RbTprNbdgQ0POylLgsf31DIxtYwPt2l/q
 lKM75joX/igKv6ukbcjbF786DExybE4mQKuHB8aIvSet4TMELlaEx3B9fOIlySWAfxsAdRs
 ham3XIzjRaik7Nc2e2LRB/Ed4+kfbqhgurSfmiI9p4B7PqUEKPBOaYoHg84CHzkZoJ0jzvm
 jydgCBTG2m+Oq4T2He0CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9qdP6eqHE5E=:r2WWx1hW6FA64QAXb808Ms
 3I1yiBVSIveiy8Pf1b97MY5bT7wSYcJjqfSYEQS7MsQg6sJYvL/xwouJxcKPO6qrWn3d/vwbj
 ER3g2MX8sxkvd1KbSqgGan7nwrEQe4CQXZE44WDKB+mOeA+9peDEtM8bj4D0vrf7N5+lWar6V
 gvGQEXwEZZLSnSJtNozz/XDj4jYBF5vwryuyDxz/WedZoGaY70N3BQiNZQFXrQckmfabTkyzR
 uCit5nyToVNvO1WXB77pjrN5ej2NtFZMzMTEXFNK1zUir29BvR6jaNcgLCjqIRyj1eBJqlUPa
 qSgLEXz2Lnk0GZjSnDMRhcknNBmf0bSQD+KBDx2ciCzdxUjqXcEfhB9HZN6Qe4CUYP+mb+5ow
 w4/+dXgGDtLiYvxQl9z9XnIhsjrP08ndjll+RK7RgM8FsLEyB5vk6slqb2B7/+xGEmqIsRmxd
 0vMHaQOTqg4b5fBiUOwAz52gRYx1OcRNrfsS4xTc/Jpi9BFDKcY37g1vSSxZVF4BBcsmmsIxJ
 g/r1Zv9aO1eLzqwNLShRTejTpFmnayHO+JgRq6LQcONeaI+NZ83pcRinJ7rFaMc1+kntjyYim
 ZV1LsUKVuCEubncgYAbZQL3MIikfwrIv3UZxgLS4D9pfGqb0JcrAvSTZb66YbPwKUm/NdHMU5
 mhLTuom8lQ5B9yDQoKKMxC5LA+wiv4utiRWCzcv7T711RUhpfauIek+LYc1x+FGMescdhnLMh
 rpQvRZg+zMqxiagWl4lZOwxlj/FHvtlDVN5W4xCz1JLegmjvpEDyh7VeeGLv7h10kFW8ftOIs
 Z/bEYJGDxmKeK5v/6rgnmKUIWnZE9IfEt0m1excgzSEXgw5sNezEr2qoG0Ro+ETC7asd2dypi
 OMgK9hMG1sjCDVMkI6tTqSrDpDwQemgpwHsKFA7mQi8b/tR+v7AFXTMpm/F9AWPX5/wJjxD4l
 PxUJN/FkryDcvTmTc4X9/c6V6RuoY9fFaPDHyEGSZO3MVNxiHqsvankq8/E+z8QKT1E6Mo/Z2
 RH5HEYJXrGU1Z1DMhQfjtqaSkhFTA3XzcE8TwWf7Lxjew07fbqcrPYvg5G7wZK2Z93WvhciYt
 cRJU0RGgH9VWdWbYJbcNsuCdGaKdRw1QlFDfu65QW0WCb8cWWyKWySjLEXWBEcldDFy682x8e
 AJLNjKBxuoHPcnTnddoYLCM5Fpev2Dkoi6i1ivaZRr6fBwiL2nbObB0vWfyiAqr23loFEiSaZ
 yhfXhi6FkEqb4O5NN
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 25 Jan 2020, brian m. carlson wrote:

> This test produces a large number of diff formats and compares the
> output with test files that have content specific to SHA-1. Since we are
> more interested in the format of the diffs, and not their specific
> values, which are tested elsewhere, add a function which uses sed to
> transform these specific object IDs into generic ones of the right size,
> which we can then compare.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t4013-diff-various.sh | 44 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 5ac94b390d..6f5f05c3a8 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -120,6 +120,30 @@ test_expect_success setup '
>  +*++ [initial] Initial
>  EOF
>
> +process_diffs () {
> +	x04=3D"[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
> +	x07=3D"$_x05[0-9a-f][0-9a-f]" &&

Any reason not to stay with the convention, i.e. using `_x04` and `_x07`
here (with leading underscores)?

> +	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
> +	    -e "s/From $_x40 /From $ZERO_OID /" \
> +	    -e "s/from $_x40)/from $ZERO_OID)/" \
> +	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
> +	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
> +	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
> +	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
> +	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
> +	    -e "s/^$_x40 /$ZERO_OID /" \
> +	    -e "s/^$_x40$/$ZERO_OID/" \
> +	    -e "s/$x07\.\.$x07/fffffff..fffffff/g" \
> +	    -e "s/$x07,$x07\.\.$x07/fffffff,fffffff..fffffff/g" \
> +	    -e "s/$x07 $x07 $x07/fffffff fffffff fffffff/g" \
> +	    -e "s/$x07 $x07 /fffffff fffffff /g" \
> +	    -e "s/Merge: $x07 $x07/Merge: fffffff fffffff/g" \
> +	    -e "s/$x07\.\.\./fffffff.../g" \
> +	    -e "s/ $x04\.\.\./ ffff.../g" \
> +	    -e "s/ $x04/ ffff/g" \
> +	    "$1"
> +}
> +
>  V=3D$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
>  while read magic cmd
>  do
> @@ -158,13 +182,15 @@ do
>  		} >"$actual" &&
>  		if test -f "$expect"
>  		then
> +			process_diffs "$actual" >actual &&
> +			process_diffs "$expect" >expect &&
>  			case $cmd in
>  			*format-patch* | *-stat*)
> -				test_i18ncmp "$expect" "$actual";;
> +				test_i18ncmp expect actual;;
>  			*)
> -				test_cmp "$expect" "$actual";;
> +				test_cmp expect actual;;
>  			esac &&
> -			rm -f "$actual"
> +			rm -f "$actual" actual expect
>  		else
>  			# this is to help developing new tests.
>  			cp "$actual" "$expect"
> @@ -383,16 +409,22 @@ test_expect_success 'log -S requires an argument' =
'
>  test_expect_success 'diff --cached on unborn branch' '
>  	echo ref: refs/heads/unborn >.git/HEAD &&
>  	git diff --cached >result &&
> -	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached" result
> +	process_diffs result >actual &&
> +	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--cached" >expected &&

I was about to suggest letting `process_diffs` work in-place, but this
line makes that idea moot.

Another idea I had was to implement a `test_cmp_diff` that processes the
diffs and then compares them, but I guess that would be _less_ concise
than this patch.

Looks good,
Dscho

> +	test_cmp expected actual
>  '
>
>  test_expect_success 'diff --cached -- file on unborn branch' '
>  	git diff --cached -- file0 >result &&
> -	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" result
> +	process_diffs result >actual &&
> +	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" >exp=
ected &&
> +	test_cmp expected actual
>  '
>  test_expect_success 'diff --line-prefix with spaces' '
>  	git diff --line-prefix=3D"| | | " --cached -- file0 >result &&
> -	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--line-prefix_--cached_--_fi=
le0" result
> +	process_diffs result >actual &&
> +	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--line-prefix_--cached_=
--_file0" >expected &&
> +	test_cmp expected actual
>  '
>
>  test_expect_success 'diff-tree --stdin with log formatting' '
>
