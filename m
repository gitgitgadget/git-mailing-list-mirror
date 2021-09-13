Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC71C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C3060F92
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbhIMLwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:52:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:43173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239719AbhIMLwV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631533862;
        bh=Upj2O2bd6TrbchzzoPr+V33i0+6jHgQUOau7E8tYBpA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GjiQF80a060xfzM3y6rH33qwxgcmiTp2nGPGegDeES4fiHrokQ0D4+pLPyFVzca2I
         UufVeHE5eQ8ynmqendka2Y6b+VYk9BQtUkNK8T93OXNpFHjRSeyce+hyvrBsmleZm2
         +9iE6uF/38ptZJJYhlceSmxi84Vv5Mz+gWZaxyP8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1mSWBf3FYM-00WVIQ; Mon, 13
 Sep 2021 13:51:01 +0200
Date:   Mon, 13 Sep 2021 13:50:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, bagasdotme@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 1/3] t0301: fixes for windows compatibility
In-Reply-To: <20210913085600.35506-2-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131343440.55@tvgsbejvaqbjf.bet>
References: <20210912202830.25720-1-carenas@gmail.com> <20210913085600.35506-1-carenas@gmail.com> <20210913085600.35506-2-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1412209830-1631533861=:55"
X-Provags-ID: V03:K1:2gksVUzz7c5DHbYm1whurgZUOlpHfYAI/sAvVGeDeBfl7OOFT3A
 BZDtFahyyfQmk9HPSYxALlkoltD9XHwwBIF8Au1Ii0oYqKtbZjQrnyeYU3OhMVhvn1CKB1C
 P16zhhe9rY8t0lKeEaABfYjZkJQ5eT58fUAxPxtZdI01JkTLZdpRRXlP4qrfOGlUn53M/sl
 ADOmgbuzCIRddi7XWry7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xgoDG6ucU1g=:jBq+LgMrgaY4t/RE9ko1nL
 VYmYapEEyHeVUorIA7b8xXKSgCo2mUz5JStZ5DP/7uNoDdm/XXqN/oMUH8PTmEMh/av7hsSd5
 XjF1LfPTimdEA82S5XCNZjqOamk6YFvFshKgwKQ+simGQrg4IxeKPHEw4CdCkVplysbq4Isll
 u0+1uAJ7HJffsNO1Bd0OLNvgrL5DysSPdAuFs7kQOfcKkGCHowwJtrs09408kGHhsPUjFS671
 8bvd1I+s2hNW+w4QrYL6ydLjGh6yGzcV1AxD/zXX6k6dFJt122ChN+CS+MVsK75Js33c6Q3M6
 xYHC11AeVGEqP7gqO2C7JUXo8uklogFHF4+E9JTf7Tqxma+M2c3VnjaLHgqGCowvhYgHFHF74
 BqSEoD5XuKyDmEFowlDt2h3nYBwrUFgOYRdr8gXEeNeCtaJxn+ADRQzr+jhr7i9UK9zPV+l9q
 PPm7PobSxp2f3TdhlGtnppnv/G+seNme6C6LGZim9FQ5KlxE071fA1lGdpLzKhl9o5qRbLQNP
 /2pWWT4Mbh1f3HcvbUKziZ6UAA4IobgMgdcF4gDVq1J1PqMgC0Mea4RUm9wZdhm6ks6lD+rxh
 sW1cswO093V4S8swBAqeAGSdmgOxFgCLBwqW8VorN/BE9X7IBZmdOunqhQnYFmM5Dc2ymoy9U
 GL0pTdO+F5M6jizSbJ6vInGXCgclvZnOwEzwb0b9oYVsLxd686b117h/ijENBdzms1DA24NKc
 kXfCiBRbHF2WLAbJjUxAYWaRKNd/Gn2o9KhJk/roByxJbr1sZNbBiXOiRYw6DX/NkLA7Jp/wF
 VHoD9Mq4H6JgpihCGvUZsXctDTVO99emDpytJDtz/dZkmSqh0AodXKoxHajOEBtdBn/N5vqgB
 Afk/IXY+j05YaljYXALbYDJ9iHRkzffYaNAFV4thtWBY+oJCUAUxNm1MpgJd8YIC7F/vjeNGo
 ADCfKx1AfUiZ/CBM0qmysa3dXyqLvg8mnjpo5F5bNIaUXRpDdY7ePab2KX1hGO/ukPLKLEfNU
 d3o++ulsYvE35T9C24oZ8XDF8sshGu5PhpVbviFFQn34SidsS0qjGhSAK+FYr3HpN7lMQldeQ
 mKNe2P9phSgSio=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1412209830-1631533861=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 13 Sep 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> In preparation for a future patch that will allow building with
> Unix Sockets in Windows, workaround a couple of issues from the
> Mingw-W64 compatibility layer.
>
> test -S is not able to detect that a file is a socket, so use

Is that really true, even with recent MSYS2 versions? I thought I saw some
patch flying around on the Cygwin mailing list that added support for Unix
sockets...

> test -e instead (through a library function).
>
> `mkdir -m` will always fail with permission problems, so instead
> call mkdir followed by chmod.

Maybe explain that Windows' permission model is a lot more sophisticated
(using Access Control Lists) and is therefore unable to interpret
permissions like `0700`.

And we probably need to mention then, too, that it is funny that `mkdir
-m` complains while `chmod` does _not_... Ah, historical reasons...

Thanks,
Dscho

>
> The last invocation of mkdir would likely need the same treatment
> but SYMLINK is unlikely to be enabled on Windows so it has been
> punted for now.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> v2:
> * avoid the confusing -f test as suggested by Bagas
> * try to help casual readers as suggested by Junio
>
>  t/t0301-credential-cache.sh | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index ebd5fa5249..1f7b1e29e6 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -9,6 +9,21 @@ test -z "$NO_UNIX_SOCKETS" || {
>  	test_done
>  }
>
> +test_path_is_socket () {
> +	test -S "$1"
> +}
> +
> +# in Windows, Unix Sockets look just like regular files
> +uname_s=3D$(uname -s)
> +case $uname_s in
> +*MINGW*)
> +	test_socket_exist=3Dtest_path_exists
> +	;;
> +*)
> +	test_socket_exist=3Dtest_path_is_socket
> +	;;
> +esac

A more canonical way would probably be to imitate what we do with `pwd` in
`t/test-lib.sh`:

	test_path_is_socket () {
		test -S "$1"
	}

	case $uname_s in
	*MINGW*)
		test_path_is_socket () {
			# `test -S` cannot detect Win10's Unix sockets
			test -e "$1"
		}
		;;
	esac

> +
>  # don't leave a stale daemon running
>  test_atexit 'git credential-cache exit'
>
> @@ -21,7 +36,7 @@ test_expect_success 'socket defaults to ~/.cache/git/c=
redential/socket' '
>  		rmdir -p .cache/git/credential/
>  	" &&
>  	test_path_is_missing "$HOME/.git-credential-cache" &&
> -	test -S "$HOME/.cache/git/credential/socket"
> +	$test_socket_exist "$HOME/.cache/git/credential/socket"
>  '
>
>  XDG_CACHE_HOME=3D"$HOME/xdg"
> @@ -31,7 +46,7 @@ helper_test cache
>
>  test_expect_success "use custom XDG_CACHE_HOME if set and default socke=
ts are not created" '
>  	test_when_finished "git credential-cache exit" &&
> -	test -S "$XDG_CACHE_HOME/git/credential/socket" &&
> +	$test_socket_exist "$XDG_CACHE_HOME/git/credential/socket" &&
>  	test_path_is_missing "$HOME/.git-credential-cache/socket" &&
>  	test_path_is_missing "$HOME/.cache/git/credential/socket"
>  '
> @@ -48,7 +63,7 @@ test_expect_success 'credential-cache --socket option =
overrides default location
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$HOME/dir/socket"
> +	$test_socket_exist "$HOME/dir/socket"
>  '
>
>  test_expect_success "use custom XDG_CACHE_HOME even if xdg socket exist=
s" '
> @@ -62,7 +77,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if=
 xdg socket exists" '
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$HOME/.cache/git/credential/socket" &&
> +	$test_socket_exist "$HOME/.cache/git/credential/socket" &&
>  	XDG_CACHE_HOME=3D"$HOME/xdg" &&
>  	export XDG_CACHE_HOME &&
>  	check approve cache <<-\EOF &&
> @@ -71,7 +86,7 @@ test_expect_success "use custom XDG_CACHE_HOME even if=
 xdg socket exists" '
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$XDG_CACHE_HOME/git/credential/socket"
> +	$test_socket_exist "$XDG_CACHE_HOME/git/credential/socket"
>  '
>
>  test_expect_success 'use user socket if user directory exists' '
> @@ -79,14 +94,15 @@ test_expect_success 'use user socket if user directo=
ry exists' '
>  		git credential-cache exit &&
>  		rmdir \"\$HOME/.git-credential-cache/\"
>  	" &&
> -	mkdir -p -m 700 "$HOME/.git-credential-cache/" &&
> +	mkdir -p "$HOME/.git-credential-cache/" &&
> +	chmod 700 "$HOME/.git-credential-cache/" &&
>  	check approve cache <<-\EOF &&
>  	protocol=3Dhttps
>  	host=3Dexample.com
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$HOME/.git-credential-cache/socket"
> +	$test_socket_exist "$HOME/.git-credential-cache/socket"
>  '
>
>  test_expect_success SYMLINKS 'use user socket if user directory is a sy=
mlink to a directory' '
> @@ -103,7 +119,7 @@ test_expect_success SYMLINKS 'use user socket if use=
r directory is a symlink to
>  	username=3Dstore-user
>  	password=3Dstore-pass
>  	EOF
> -	test -S "$HOME/.git-credential-cache/socket"
> +	$test_socket_exist "$HOME/.git-credential-cache/socket"
>  '
>
>  helper_test_timeout cache --timeout=3D1
> --
> 2.33.0.481.g26d3bed244
>
>

--8323328-1412209830-1631533861=:55--
