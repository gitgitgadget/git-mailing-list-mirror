Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C9C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 23:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905C1206D3
	for <git@archiver.kernel.org>; Fri,  8 May 2020 23:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b+jVkRpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgEHXyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 19:54:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:38227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgEHXx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 19:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588982030;
        bh=skDnAreOHdgM6XGcgpcCuU9n55fseejteblyL/n/KTc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b+jVkRpp8DLxK+kf/mjelqydKvdop/OwOyIm2FLFEKDVeGWWrGlTj21qgok1RARNE
         2nyJtedl1/RV2LAX1FP25l/eOb7mVRo1hcv+PL1IqesUjE9tdzUuilOAE4fltwzW9U
         StJIRNyJIv1v95WkRQ0m9Jo3iaeugKX8SZ1mzeEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.212.13]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mdvqg-1ixKMS0126-00b4kK; Sat, 09
 May 2020 01:53:50 +0200
Date:   Sat, 9 May 2020 01:53:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
In-Reply-To: <20200507175706.19986-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005090151350.56@tvgsbejvaqbjf.bet>
References: <20200507055118.69971-1-carenas@gmail.com> <20200507175706.19986-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-664812106-1588982033=:56"
X-Provags-ID: V03:K1:gzyM4M0cJ0qsguf4x/WvvYGjKtnyxv3ym5CGhtAqU/dLJz+yI35
 5IUHXOkh3GSHQvG8BLs9gJrf/gg0vJ2HDffJcDFYt/arM1/9b8k0Q14AmruWHYc7G35+lIN
 Lyiowmdlie5a2Aaa7h104bWkILnFnDKingRpqC6JdSxoAIy3QSPZcHmuH8yeq5f/IzZfpbs
 TXqw1PlJd9dW1fRuHr5mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJJcwtwaW3g=:I159PnDLlu9k9QQ+dWDFAI
 yuTkoHrsn++lrkPzPzZt3bNeEeczUkiBG2pERokJrCipfFKIt58IPL06M8GfwpgYxzdAf+UqH
 7reXfT63Ee2PzV5AZ0kmw51uN62Iu3hN0zEaGU7JIEV/OiiUOZ+xHswiWSrYiDLxL63JyhWj0
 epluwVH1QPZ93N/aNszBj6C7x+uif3Dbez0PmUXcnsk+Qsd9111ft5+vvZJ1Zhv7DKLFkDGZh
 +3uFG4UX4Z+wILEAKRHZ/4aEQl7ppQR1rY/4m5v39X+5+igqaFCW4XO8vTIVZ5NYVSwCUuW2X
 5HAIv5dYj8cxSNUz4QP9PL3eDSX7ELnvIwsIhz8VGF/IPK7B9TFTPhNEt7FQF/FKEyLvcC+35
 IrAjNw2Rp0DI1/a3iLXUb9iiE4A165ovd7m41lThJmTCPr+KpacIOhfYspkyEO3H1zGAfKiAB
 emoW2/NFju6qMon6Rjlm11U5jiYUmcQmIOiI7l4r2zdKAWypbZkzrpoTzf7wiVE/XR+zAjW4m
 qcQvOc8ognyrL+inqOtSdMg3a/8rw7yiaYbdTJAPLym+2LhC+4QsZagGxdJLKjbyYqlOvD1eD
 l1k0u20vqGn5sUZBsYcBV4ZJ82Sm1IYjbf5fug4XbkSDq8RfZpBuD9CNsGp0FCPUgVY5IkEI7
 QNF5554nA3g44I1c0V7weSKL47abFS0cFHE/Qz6OIbTsO6wiVp5PzFLk8Pq5rV+JtUVzHcLAp
 sqRgVBLqJz+eczAXVGMpJ1VoCYm1KqNIdiwxrcXCo5hkj6VWZyow80YToF2hqFugVyKz8Mw20
 ngZ23ugUHBFwP2liNYU9tgvLvGodwQSuF4W2ljdRilxjY8HBLkZC5Camch7oA8PQ78HyNaccI
 OGuD4a3Y5vax7BFCnCoS7b2rrv/M4dyREm8hmwp/WhOZwdoahD02GTWGVxZSk2l+i1xz+3ufD
 G7iXADBrW4Ql5Tt51L5eb6vj9CPbqkG5rHigw7M2uBHFHKgCBM628fkhRpwqbcS+zRZX2/7pA
 uflojXwSPmcaGSzktONdoaast1eyoXOk4TLw7MX5W52N+BiNIqJHQu77kb5COaW36Pu+iB6VD
 4Azomf7CPmEHDudmhg4tqH2JBF59NvbPGyImufqKr1dhRtt5hnh8SzTcK5JVioqqBFZletnM9
 J17xwVe+qghwlYwpwinojW9+u7ns/L6OfIJc2UiYwnFcfjuN5o2cBLvg8aids+sPYgwOIoofj
 PrXJDYvNyieOVjp9j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-664812106-1588982033=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

this is v2, right? The subject says `[PATCH]`, not `[PATCH v2]`, so I am
just trying to make sure.

It's things like this why I never use `git send-email` manually anymore.
Yes, sure, GitGitGadget helps others, too, but its initial primary goal
was to help me not botch my patch submissions.

On Thu, 7 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 662f9cf154 (tests: when run in Bash, annotate test failures with file
> name/line number, 2020-04-11), introduces a way to report the location
> (file:lineno) of a failed test case by traversing the bash callstack.
>
> The implementation requires bash and uses shell arrays and is therefore
> protected by a guard but NetBSD sh will still have to parse the function
> and therefore will result in:
>
>   ** t0000-basic.sh ***
>   ./test-lib.sh: 681: Syntax error: Bad substitution
>
> Enclose the bash specific code inside an eval to avoid parsing errors in
> the same way than 5826b7b595 (test-lib: check Bash version for '-x'
> without using shell arrays, 2019-01-03)
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

I still provided help, I hope?

> ---
>  t/test-lib.sh | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1b221951a8..baf94546da 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -677,14 +677,16 @@ die () {
>
>  file_lineno () {
>  	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> -	local i
> -	for i in ${!BASH_SOURCE[*]}
> -	do
> -		case $i,"${BASH_SOURCE[$i]##*/}" in
> -		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;=
;
> -		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: $=
{1+$1: }"; return;;
> -		esac
> -	done
> +	eval '
> +		local i
> +		for i in ${!BASH_SOURCE[*]}
> +		do
> +			case $i,"${BASH_SOURCE[$i]##*/}" in
> +			0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return=
;;
> +			*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: =
${1+$1: }"; return;;
> +			esac
> +		done
> +	'

This one looks correct to me.

Ciao,
Dscho

>  }
>
>  GIT_EXIT_OK=3D
> --
> 2.26.2.717.g5cccb0e1a8
>
>

--8323328-664812106-1588982033=:56--
