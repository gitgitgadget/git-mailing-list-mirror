Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B628C0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1BB2051A
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 02:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Dp5WK8VP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCOCG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:06:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:35177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgCOCGz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 22:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584238014;
        bh=jiWF1rbbkDfrHwSm+1lzMdCXa6s3AnP6406lA7Sux4I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Dp5WK8VPFPYlBfOnwxhZ01XUYiwgw2VqtQbl00Q5+8KDUVh2lddZtaFhkeYvBPTs2
         hIkF/lRR3fG/GSdPv5TuPWml0KNnE0zBzNTMwJLJvmyYXva0koXUCAyXBsG4JN3ocz
         dbxLr21hJLpzST3sa3m2VmrngG5xtJub/0va0C90=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.200]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvK0X-1jUeO521WD-00rHaJ; Sun, 15 Mar 2020 00:25:40 +0100
Date:   Sun, 15 Mar 2020 00:25:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Hans Jerry Illikainen <hji@dyntopia.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/2] t: increase test coverage of signature verification
 output
In-Reply-To: <20200304114804.19108-2-hji@dyntopia.com>
Message-ID: <nycvar.QRO.7.76.6.2003150020010.46@tvgsbejvaqbjf.bet>
References: <20191127174821.5830-1-hji@dyntopia.com> <20200304114804.19108-1-hji@dyntopia.com> <20200304114804.19108-2-hji@dyntopia.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UzX+ubV3Bf7R6BqahyASQOhmC0vw7lbWSXbgjaSdMZVDn8iuf1e
 6sUHYcKL6Snon1487LIUNHX9hAZ+2TlhNYdZcEDtEdVPN9dP7a2yN8Ld4kWLQBYK1fcUDnx
 3IsrrN1nG48ADE/nqG3SD0Vlj6jL8t9m1Y0DwYanYAjfJeu61PWivBzJGCPAL2+q2berlDk
 Cp2deT+wp35Zn7VNI7Mkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJRrmGq1sq8=:O4qAK0QKfQ6WqmuNwQEFKt
 pIxz2is9zeO7A23dSlmWUwkgxKzlBvxD0wnJVVopEQaYk0iFdZbyrn0UsniBO0Q2h8NU6HDtj
 IY0Kg+E5Gw4WZbQPiBLkHc1xrXqjFQRLZMqp1HcGURoCNkPcK9/T4BCrbpak8iW5MO5fKoRZ4
 R9x2us3Vzo+bno//PzO2I5cX7On90di+HxtYnWJxP5zgLnrWJAULxOFv5abdCG12zdEBL6BBL
 YbWLBgM8y+0GMjkJI43y2uLdxVuBlewYxIkTRViIdADbcsGltIfPSh0ao8bY4glCiJDHm8y5M
 BMc1T7WbWnLLYx/dMS9NN1JJI4mNGllTCqZL0fdrVOnu+Ijkk7qd+cHntmhcCpx+jUH6fDNBZ
 B2lAPAKsnJfHTFJfDkFSAcf98j3nVYE2PZjiaNazQ6Zb1BjK0wDSRgcnfuUIscy+xTc+tl7S8
 YHAqFZk72GzMfkWsIImtv3aCPaOu/RE4CWMNHle9zvpc+0e7lXQpRxafzrN4CaJnUJQ5yr+pw
 xbwRMk6UHzNnBA3c5IZ4Bp1VJaa2q6wu9bq21ElUVBuu1tCflzZzEf8N8BkHfY+4Y/5aBttpW
 VWa+ksn+2tik9/nRDms+H/Hum1p9x+LCj6oPQ6a3aa5r/yH8/k3HXLfmz9Sf9EoqY0FSqGgJE
 x1b7y6xQD6bNVRqhzIO/bgU/inp626M44Xn5P7FN+yWg0p3gtqpx+2mre6PgLYmdQl5RhUFTT
 oELWB/dSqZIaclFI9kfA647N7oQ6FN3e6JdagldJxLTWIjHXFFt3L6sprrGDD9A0unvwWIMqP
 V07uc0jRwzZNuOxL0QlHaiOSljpW/0EOecrsvYBH1twtgCskLhqqDWcPOP6Ck8WTa5zoU95pE
 IDNA2JGaKjQKiVsrd0lnY3qZUcWYvnM7dKMSjv2qd2FeUn1k/zCMDXzqKUyR4zhDzBRZzRB21
 PjcSNkbL63cNEK1uwndczBgXfuDxRgrudDQ8hj9A5Vx1phyryX76YOfydp5LOKpPKV95KlF2H
 5c6JxtDI/Zll4pKTMyZljdEnDdTBvml4r2wW5+WU/sdNByGqV7wuVN2PXKT/TSKks/W2u2EbE
 UE59QOg0Lb6VqSNalfSGohLuHo4+maIQiw8HISMzcJ1oSg/fZkjyG+FluNCUYkzY3YdlByYyw
 L9Ht9Gy9eGO+seU6CpUynKcchABOwNh+dHzx1nbBPjd4n7tWUSrqt6/Litq5nrvdDDlQxNciJ
 Zf5s14l2yy8N275GL
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hans,

I was wondering why your patches made the CI/PR builds fail on macOS and
Windows. This was a pretty hard thing to figure out, see below:

On Wed, 4 Mar 2020, Hans Jerry Illikainen wrote:

> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index 8a72b4c43a..1922c1c42e 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -6,6 +6,7 @@
>  test_description=3D'fmt-merge-msg test'
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
>
>  test_expect_success setup '
>  	echo one >one &&
> @@ -73,6 +74,10 @@ test_expect_success setup '
>  	apos=3D"'\''"
>  '
>
> +test_expect_success GPG '

For developers who are very familiar with Git's test suite, it is really
hard to spot what is wrong with this line, and I was fooled for quite a
few days, too.

The thing is that this `GPG` looks like an innocent prereq and it is
correct: this test case really depends on GPG being present and working.

But it is not a prereq.

This is used as the _title_ of the test case. And on the macOS/Windows
agents, the GPG prereq is not met.

The reason is that this `test_expect_success` call only receives two
arguments, so it does not interpret the first one as a prereq. But I think
that this `GPG` was actually intended as a prereq, so the test case's
title is missing.

Could you kindly change this patch so that it adds a title, e.g. `set up
signed tag`?

That should let the CI build pass again.

Thank you,
Dscho

> +	git tag -s -m signed-tag-msg signed-good-tag left
> +'
> +
>  test_expect_success 'message for merging local branch' '
>  	echo "Merge branch ${apos}left${apos}" >expected &&
>
> @@ -83,6 +88,24 @@ test_expect_success 'message for merging local branch=
' '
>  	test_cmp expected actual
>  '
>
> +test_expect_success GPG 'message for merging local tag signed by good k=
ey' '
> +	git checkout master &&
> +	git fetch . signed-good-tag &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
> +	grep "^# gpg: Signature made" actual &&
> +	grep "^# gpg: Good signature from" actual
> +'
> +
> +test_expect_success GPG 'message for merging local tag signed by unknow=
n key' '
> +	git checkout master &&
> +	git fetch . signed-good-tag &&
> +	GNUPGHOME=3D. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
> +	grep "^# gpg: Signature made" actual &&
> +	grep "^# gpg: Can${apos}t check signature: \(public key not found\|No =
public key\)" actual
> +'
> +
>  test_expect_success 'message for merging external branch' '
>  	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
>
> --
> 2.25.1.709.g558d21736a
>
>
>
