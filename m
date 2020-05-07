Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428E7C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFA8208E4
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="G4E/UTuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGTwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:52:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:55377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgEGTwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 15:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588881132;
        bh=QcXh5xQ4L12Dbenr//UbpziZ7IByJ9u8pigX8bc2x/0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G4E/UTuFIKoEXoxT67vKP4dcx0db5xZPE1zgjE2rctgmSC+RK2HKxoc1x6fx1HETJ
         b1KjJuLBjC2p30a7uiEnd4+F14JfzpnTsFPe75DDZgi93XuXBgZtqpuAV1H5s4ZfQG
         g1PwK8/TGJ/Vl+X+g5hTCJ1naCvgpo26moLZCX8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.213.71]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1jqExH205f-00LluI; Thu, 07
 May 2020 21:52:12 +0200
Date:   Thu, 7 May 2020 21:52:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, congdanhqx@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
In-Reply-To: <20200507055118.69971-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005072139300.56@tvgsbejvaqbjf.bet>
References: <20200507055118.69971-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-355874495-1588881134=:56"
X-Provags-ID: V03:K1:uAGDewT2S6HbyoTLgz8x9CflNROBhCeTO9Zx3f4NWbll+UxE/TI
 sbuRTkNJGcnL+soM94rXMW+i+Bq5huGPewKKZDTl4N3rZZLLNTKJlrXxj1ynyDY+QP5zK4o
 PSIRJ95qQuUmeoBVawtUKEmegCbyWC0W16RaqnqDH5NCx7TPe6OfOQoFiqHL8dvZ2CXSoEu
 qInIPSaLgIRwTY4Ni04Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FrvmhYLvdwk=:9sm/zG3Uili7Y1vQj8Dr7y
 8Qo1dUTCPgeHBE/xX0Bqg1GhEh6f3GTxoDFEhzA9WXW4z/4IPnTynJLfMMqAkWYj9CD/AwPaB
 J5SLroxv2WIOB/N7VjeGHU0hCcUObj6pt1VjAch5ZyY0a3TTCPM7Bx/wUPZ49iv9pUrvM+p8s
 4xETEhChKOJWzTglykGDGOA/6CIyhHga66ST7kR/Z4IXmGhn9hidV4OiOsYnI9AWWepCAY9DJ
 xp05uYCJ9MM2WCecpeHBnsCc1Ml5cWKHyY7MmhaIoNV1fTy2jE0rB+H2PWH7NS4sCSc/VECMm
 ESHZHFrJP7KdOUR7wGCIeJ893VxpNsw6QRrnMENxst9FqAdqlNS0E4V5PvbMpWp8f+9yhOc2C
 9lRccr9VOYGq/9EHn/c0lk34VGWEl1j3aTeq06rXaGrFhfICRduQRjNJLbOS8H+wgGqfxTpf4
 yh9izGnkHBmw2xixFLoRDCZXCLVh1lCMHCLSC0EXqYA4Y0jqJ8qvqmWrdtZkUdFnw19jRH+Va
 aK5fcR24Unv5FIfMHJ4yuqdOg+X676UENhZHQ68ZxoubT98iLad5+084tSzhwtXAyZ73oziOd
 InvVzF+GBmOfVvLPPgvYYZxERaRKlRaGPGC0eCYTcaewzUfRZk8bB+szl3EjNyRLFK/rbQVsK
 i1HI85JKleWoGCv8Ays0rfjsPvx4RQYsJyQTkpIoKgiKjgJjr6UZDZEb90p6KB+FvKF89ZIoZ
 ukRmgr9+XcFS5liAUkDXw3yT2i0Py/0NHXTkvA/aHgX3TNXQUlBRAzH9QuRo83oIjLq5YAcEH
 MvbMSh2vXBqz3LSURF65mez+Jse/WGDcd4xdM0gJWI9DDlloXx4dWxeHMzFy16SJdH/e7oCbZ
 3ywwsPzwkYCP7URpa9pyKCEV191Hhlz1RZZFK1Qm0jv2pSIOMZCeKbX17A7tGS5Fa8KJynZ28
 zJii3gj5y1MT+57cM3Sl9tVUv8nC7fPvTL0OGR6dFOXAdLchXzyTTOkquSaK03I8pNb0c9HFq
 q+KqDS/qw/0EjiBQduNhqCecKqM10EiDak9FG68CuuY73wp7hwksY50vDt8mMsiN319GT1DDs
 QIocdvznrXKprIe9nc2LRjPw/YkkWyX2YDQD8qQiEhZbJP3EkYS/8z5deQAjft6ezYJB5jA9e
 YYkPS8hlYKyovwzeJDeOOrBx3TulnEcLIkj7sKNVS2d3KgHEgRsUujkKuxd2q1mroDBRN+qWn
 BlKafjwbCLItVVCe0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-355874495-1588881134=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Wed, 6 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 662f9cf154 (tests: when run in Bash, annotate test failures with file
> name/line number, 2020-04-11), introduces a way to report the location
> (file:lineno) of a failed test case by traversing the bash callstack.
>
> The implementation requires bash and is therefore protected by a guard
> but NetBSD sh will still have to parse the function and therefore will
> result in:
>
>   ** t0000-basic.sh ***
>   ./test-lib.sh: 681: Syntax error: Bad substitution
>
> Enclose the bash specific code inside an eval to avoid parsing errors
> and while at it, simplify the logic so that instead of traversing the
> callstack just pop the two topmost entries that are required.

I would be okay with that, but that's not what the patch does:

> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/test-lib.sh | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1b221951a8..60b8e70678 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -677,14 +677,13 @@ die () {
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

Note how this `for` loop stops as soon as it finds a `t/[0-9]*.sh` in the
backtrace?

> +	eval '
> +		local n=3D$(echo ${#BASH_SOURCE[*]})
> +		if test $n -ge 2
> +		then
> +			echo "${BASH_SOURCE[$n - 1]}:${BASH_LINENO[$n - 2]}: $1: "
> +		fi

This loop is completely lost here.

Now, you could argue that your version is better because it avoids the
loop and always shows the ultimate caller in the backtrace.

However, I would then immediately point you to `t/t0027-auto-crlf.sh` and
ask whether it is all that useful to the `commit_chk_wrnNNO` call rather
than one of the five `test_expect_success` calls contained in that
function.

Besides, you simply replaces `${1+$1: }` by `$1: `.

Again, you could argue that your version is better because there is now
only one caller, and it always passes `error` as first parameter.

I would not be _too_ happy about losing the logic that allows calling
`file_lineno` in other circumstances (I found it valuable for debugging),
but _in the least_ you need to talk about this change in the commit
message. Just changing the behavior without even describing, let alone
justifying, it in the commit message is a bad idea.

Ciao,
Dscho

> +	'
>  }
>
>  GIT_EXIT_OK=3D
> --
> 2.26.2.686.gfaf46a9ccd
>
>

--8323328-355874495-1588881134=:56--
