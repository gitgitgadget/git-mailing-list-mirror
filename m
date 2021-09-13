Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74565C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4D960F24
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbhIMMAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:00:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:43417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239719AbhIMMAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 08:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631534337;
        bh=ygHNx8ETjH5Dbt/ir9fyAvw0yyG+rCm8+gv86/h9hEM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SotHecY0za4Ui+RzdRSsGdU2oyoRaF8KlwZuJeRkcSyaYQJ+IKJ9KbpLovOgF2793
         wUVzppkbIIgixvypMqGL3GpwjLTX3AWS+pReqxvAG4szFZlm18PRqvV2iCYXGowNsG
         NDezrMYTzQCPtRwTMTAbrcpL+oyJBBMZXjvk3v2E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1mDsvC1iZ9-00BvDZ; Mon, 13
 Sep 2021 13:58:57 +0200
Date:   Mon, 13 Sep 2021 13:58:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, bagasdotme@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/3] credential-cache: check for windows specific
 errors
In-Reply-To: <20210913085600.35506-3-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131357280.55@tvgsbejvaqbjf.bet>
References: <20210912202830.25720-1-carenas@gmail.com> <20210913085600.35506-1-carenas@gmail.com> <20210913085600.35506-3-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-838569380-1631534337=:55"
X-Provags-ID: V03:K1:kIBP+Rxe6Mu1gHmFKpnVlxY5DfNp2spp+c2ER4fOdUUDRR0bh0o
 o0WAv4VZXTg0yR3o1ND5YUmYczBctGPJJQV8p0DJxaUAPDANM9IkmvHD4UUb1U4G1sxDGcN
 Bsmv3RDe1pOIPx4vfdDKaRpHECy0RzFBdCek53tfGZTencavoAkX7Iu0En/JFh/R03py282
 2Sj8hqdEUqXO3fOujZLxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6jWhUzDCVc=:c2Hi2LIA3lifUZuIwXWS/H
 1ws0XDETWKb+zWwMQ70Mhb77+mjQu0ELzR7OcfzUVuNQw9bO9n3xRVxgKvuQYmBOBR+i46ARi
 INseO/22zQ5n0tEIDRyLhNlFSsuxKkbDeEhUsU2hbL9EvnV6KHAqDePi6+F7r/1NrMxAB+RH5
 kidkcdQpolgdxjp5CY6y/EITwEwltgvecsoqcnyykWlzVpZynn1/AbMerxJ7pBo/jDdH3NuZm
 ek4iGCBqd8Ts7JFmPx2RObKG8UCgxFyWC0kgkAH273oa0tkAprsx6wblq11RywJtqo0bxh2X9
 JJi92CLgJsy189gKP2c4oTmLxotsnFBE63Zj6Qodv6nPj+/I6383L4Lzhv8lzFvw9MiIucf1g
 KvCzCo+d9um7fCkNwck7p12Sdr4a3OmTOle8OB+BZio5moPQ1+G+HzrB3YSFiq/c9ai4H2lZC
 Z77JV/pDzEJ39+Oq9AcZj5SeeM+MFpCphooolNO2xvzNJENy3EcNHSXt5gLsEqGx6WcToNQxa
 WwMeHed+J0n4JROjgk9cKfwwHMdStd+faNQ9zU4qP9z/rQ7mwPFYuaF6DhzuB/iYA956Ax4aG
 vsxQ3Vj5C9/SJ+WaXfXNNOWr6wH+RVfum+gxi7eGv7rsSm81/8UU04ZJTVSZiytaeE1aIka8v
 X5nN62hGY9yr1hYxt/xZJ7Q71EBlQb9wQcBXQGt/SO963F/sdPQb0h6k+mZ/+2/1NPh63bEzZ
 9Qudwr0yAyTDFZuDfpLf17UCytPuzYLt56UL8mPeHbsRRtP1tMiX4prfTBraZfgWLfx3OU8CZ
 MdGcSqZx85TKp3+pYfLOzasNDRYXj+z8HUvMv2wK/6mgQOCJHsTGVvZB0CumGTdFWurQItt/W
 O6CY8bIpDy/M2oB75C92XUvnSUZfeKJR9viwzGEUY6keSeETmL/uji3DAwqat4VqrPQ6B6RLj
 f60rW7EbSFYxGTW3q+DaYBu0IjuDSsKyZGjyXpRAl918ntxli92babOP/6CfWiSdDHp0fqwN9
 nPB4/Rek/HYan0ZuRARXIgthjN8lwM7IJNoloIg4/PEYKt1yaEpeJiBu6w/6PAokT2XQgsZoS
 J8cil37USweY8I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-838569380-1631534337=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 13 Sep 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Connect and reset errors aren't what will be expected by POSIX but
> are compatible with the ones used by WinSock.
>
> To avoid any possibility of confusion with other systems checks
> for disconnection and availability had been abstracted into helper
> functions that are platform specific.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> V2:
> * Use helper functions to separate error handling as suggested by Junio
>
>  builtin/credential-cache.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
> index e8a7415747..fd9f33d993 100644
> --- a/builtin/credential-cache.c
> +++ b/builtin/credential-cache.c
> @@ -11,6 +11,32 @@
>  #define FLAG_SPAWN 0x1
>  #define FLAG_RELAY 0x2
>
> +#ifdef _WIN32

While that works, I think we prefer `WIN32` (`_WIN32` is only used in
`compat/` and `contrib/`).

Other than that, looks good!

Ciao,
Dscho

> +
> +static int connection_closed(int error)
> +{
> +	return (error =3D=3D EINVAL);
> +}
> +
> +static int connection_fatally_broken(int error)
> +{
> +	return (error !=3D ENOENT) && (error !=3D ENETDOWN);
> +}
> +
> +#else
> +
> +static int connection_closed(int error)
> +{
> +	return (error =3D=3D ECONNRESET);
> +}
> +
> +static int connection_fatally_broken(int error)
> +{
> +	return (error !=3D ENOENT) && (error !=3D ECONNREFUSED);
> +}
> +
> +#endif
> +
>  static int send_request(const char *socket, const struct strbuf *out)
>  {
>  	int got_data =3D 0;
> @@ -28,7 +54,7 @@ static int send_request(const char *socket, const stru=
ct strbuf *out)
>  		int r;
>
>  		r =3D read_in_full(fd, in, sizeof(in));
> -		if (r =3D=3D 0 || (r < 0 && errno =3D=3D ECONNRESET))
> +		if (r =3D=3D 0 || (r < 0 && connection_closed(errno)))
>  			break;
>  		if (r < 0)
>  			die_errno("read error from cache daemon");
> @@ -75,7 +101,7 @@ static void do_cache(const char *socket, const char *=
action, int timeout,
>  	}
>
>  	if (send_request(socket, &buf) < 0) {
> -		if (errno !=3D ENOENT && errno !=3D ECONNREFUSED)
> +		if (connection_fatally_broken(errno))
>  			die_errno("unable to connect to cache daemon");
>  		if (flags & FLAG_SPAWN) {
>  			spawn_daemon(socket);
> --
> 2.33.0.481.g26d3bed244
>
>

--8323328-838569380-1631534337=:55--
