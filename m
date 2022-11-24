Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA6C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 08:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiKXIMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKXILv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 03:11:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88E1DAD01
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 00:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669277476; bh=OnKgl2TtU9geV/EuveKkzflV8c7On6PWvYxGJGfx/DQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hFm7k3nHPtOIUTFSaKFcn8hKrD/3u9BMUCIMLWOtA1OQKewoFPcxYhapdD5K65E38
         tHL9CQJMCuh/CS6YRmBpkspqnE0ngVPlJiyeaTweVNPEUu0/mqkzsZg3l21vy5dsSV
         PTVw185+Q74h2tatJ4lbSVRVoDCOdOfKvPQOgX5s/6u4iSGu/kpHpZ+C6LmdrrW1T5
         rhOcspzrNgPNmOakVhbqJp1L8NP66P9louOkSrCuY7AnK4w1i8BCEvDRehOjeWGdPq
         Y9hbeHcbrwBlPm1TTbBy/YwuC2lGhw9O7wrDcdfRqgsOQ3/y366iNrDhLVw6/3pZoL
         SW4ZZbPnJ2Izw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.58.20] ([89.1.212.70]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmfo-1oV0gQ26l0-00TAvE; Thu, 24
 Nov 2022 09:11:16 +0100
Date:   Thu, 24 Nov 2022 09:11:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] github-actions: run gcc-8 on ubuntu-20.04 image
In-Reply-To: <20221123150233.13039-2-worldhello.net@gmail.com>
Message-ID: <p646ro03-7n48-5202-9075-p7srso008417@tzk.qr>
References: <20221123150233.13039-1-worldhello.net@gmail.com> <20221123150233.13039-2-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XjsQkTV+09ij5rgsMj7MJJbaQPzozWv06L2wCTcSQk2QcxQpjp3
 c0v5qIx1lCSrCOh7eWahJrk3LRS/zcsGKdoXvWzb79AZmZLILiu21qePA1tMR1TgLcKrkTj
 BK6I5cSFbuolWICnCPIDt89T6zsrIjfaX9nVfz7L9sWDGVPeUKKpVbhPQzaGbdgAs/8VVU+
 rtjYi+VrkYtV5G+VzN3KA==
UI-OutboundReport: notjunk:1;M01:P0:GVFPDafgiOA=;lajOQhPt4JhIb9SJyDB3o+u3hv/
 Vaef2e2CeW9JFOdODnZEM4y6bIc8trwOsBHd3bCI5LeDwV2OIOm2A1SYukyqo6YP8k9HhSTNd
 xPL5G3NerOTCMrKhwzKB3Stjm88fpjOI5e97OMiDROBaJDL+WacKc48JteEzLnfnt90okayv1
 e6E2sFO7XtoZ9QUJ3GEc2+HxDWqWWKMQE6lxWc54NNMKs7lAldHxhSPgo2nEtuuxILRGpfPni
 utXtoHFQwpKRHZ9RTi9t/oHtHJGawfTZDpLdVA1/X/EVSkqb/VNPm89V6dMUld8vDSQXfkyWY
 T6PjYj6zNVyBvRVCnZTQ5wmBsq4t0kVDI9jYVjNXwvCYPfOtpuTzytUQFN8TJ8eUQnESYIdnQ
 /JxmSKmyX0Lkvb0sB8iakFp1i3sweVflaNq9u8bR4O4sYfZTht1ZppJ0cGjESPnKzAWAIhX/j
 PNzl62jl+e50Dk/zP0SPOBEE187iYpfv8GWnqW2oFYtPecUWUDI7XOx/hWRuz3YzS2/br+Wef
 ICntOIkAh0JWruXA9VuYJrubvd8Gf33/TM01eK9zJYeuFvaQSg2t6W1luEwfPAc4BCC34i7lo
 hJokzGwSdlWpASCXVC+Gh1Z5K3NKLzyBVL1V9QGd5JvODg9q4I33YiM0mnWFyt0ZG+ajR3U5/
 ryI8mSnBCK7aEtQeCd6sX0eTFXS1A7idUTpooRbK80AGn4uXGh0sE9vFBjsrjUQc9HMQE/Tqh
 PTSMbGx5COGf/zTMQqhz5pTKqiz3IpacG1DX7zkb0sJEMw/NyeX2d9TDkg17zG6cNyju7qGYd
 XfZMCPd1RPcTODR7iIHdN7DY47l8d4AeE8qb3aNtVaHeledYG0I070MuHdpbfasTwvM/oO+qW
 /ZvKIWwiVmhtMT6npvn9OIEs3rAMUf0zyVXoW3J2obRa8raMqnuQUK7yCm5nhvnkrNbPMLRyz
 Ocjo3g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 23 Nov 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> GitHub starts to upgrade its runner image "ubuntu-latest" from version
> "ubuntu-20.04" to version "ubuntu-22.04". It will fail to find and
> install "gcc-8" package on the new runner image.
>
> Change the runner images from "ubuntu-latest" to "ubuntu-20.04" in order
> to run with "gcc-8" as a dependency.
>
> Instead of use the environment "$runs_on_pool" as below:
>
>     case "$runs_on_pool" in
>     ubuntu-20.04 | ubuntu-latest)
> 	;;
>
> we can reuse the os field in the matrix, and use a new environment
> "$runs_on_os" as below:
>
>     case "$runs_on_os" in
>     ubuntu)
>         ;;

While this is a bit more refactoring than I usually recommend when trying
to fix an urgent bug, the outcome does look nice and correct.

Here is my

	Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you for working on this!
Dscho

>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  .github/workflows/main.yml | 16 ++++++++++++----
>  ci/install-dependencies.sh |  6 +++---
>  ci/lib.sh                  |  6 +++---
>  3 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 592f9193a8..da0d8ab0bf 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -224,6 +224,7 @@ jobs:
>          vector:
>            - jobname: linux-clang
>              cc: clang
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-sha256
>              cc: clang
> @@ -232,36 +233,43 @@ jobs:
>            - jobname: linux-gcc
>              cc: gcc
>              cc_package: gcc-8
> -            pool: ubuntu-latest
> +            os: ubuntu
> +            pool: ubuntu-20.04
>            - jobname: linux-TEST-vars
>              cc: gcc
> -            os: ubuntu
>              cc_package: gcc-8
> -            pool: ubuntu-latest
> +            os: ubuntu
> +            pool: ubuntu-20.04
>            - jobname: osx-clang
>              cc: clang
> +            os: macos
>              pool: macos-latest
>            - jobname: osx-gcc
>              cc: gcc
>              cc_package: gcc-9
> +            os: macos
>              pool: macos-latest
>            - jobname: linux-gcc-default
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-leaks
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-asan
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>            - jobname: linux-ubsan
>              cc: gcc
> +            os: ubuntu
>              pool: ubuntu-latest
>      env:
>        CC: ${{matrix.vector.cc}}
>        CC_PACKAGE: ${{matrix.vector.cc_package}}
>        jobname: ${{matrix.vector.jobname}}
> -      runs_on_pool: ${{matrix.vector.pool}}
> +      runs_on_os: ${{matrix.vector.os}}
>      runs-on: ${{matrix.vector.pool}}
>      steps:
>      - uses: actions/checkout@v2
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 107757a1fe..f639263a62 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -11,8 +11,8 @@ UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl=
-dev libexpat-dev
>   tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-pe=
rl
>   libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
>
> -case "$runs_on_pool" in
> -ubuntu-latest)
> +case "$runs_on_os" in
> +ubuntu)
>  	sudo apt-get -q update
>  	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
>  		$UBUNTU_COMMON_PKGS $CC_PACKAGE
> @@ -30,7 +30,7 @@ ubuntu-latest)
>  		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
>  	popd
>  	;;
> -macos-latest)
> +macos)
>  	export HOMEBREW_NO_AUTO_UPDATE=3D1 HOMEBREW_NO_INSTALL_CLEANUP=3D1
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 24d20a5d64..0c0767d354 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -225,8 +225,8 @@ export DEFAULT_TEST_TARGET=3Dprove
>  export GIT_TEST_CLONE_2GB=3Dtrue
>  export SKIP_DASHED_BUILT_INS=3DYesPlease
>
> -case "$runs_on_pool" in
> -ubuntu-latest)
> +case "$runs_on_os" in
> +ubuntu)
>  	if test "$jobname" =3D "linux-gcc-default"
>  	then
>  		break
> @@ -253,7 +253,7 @@ ubuntu-latest)
>  	GIT_LFS_PATH=3D"$HOME/custom/git-lfs"
>  	export PATH=3D"$GIT_LFS_PATH:$P4_PATH:$PATH"
>  	;;
> -macos-latest)
> +macos)
>  	if [ "$jobname" =3D osx-gcc ]
>  	then
>  		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
> --
> 2.39.0.rc0
>
>
