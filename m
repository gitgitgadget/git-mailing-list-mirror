Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40B20AF7B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525143; cv=none; b=lKXfoQSy+84KlAcgMoFVPaiU2HDKGiYPsx7jlmFtFq+kk6LrnwmQG9Tam0i4C1mRpIkPKM+IRl70bxKhYHwq4RAsC4Fn07q7h2txV4r7G5kHxNzN3Pr7Xk1HiKZzAD3Dpo1JJs+1KspYawjkAkYnbQ5UN2ErhXUYtTyfSLEtUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525143; c=relaxed/simple;
	bh=cxS6ZywMqT/nnqtbn0mCyASzLShPIFc0zAGEz/fYcEA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NHeOmSn6f4gLMJOAZbqiSLxBjLJ/RhEO5b7ji7JPf6MAKJTgzb4LYADoeZROPSgHnp9q5fHGOkJXLaJpw6yTRYrPOvpJUa6smiY+rZeaF1mhrwPx3w5tgq/6tsMp5+6Z6wSOOMz5AK1SbiLG0doSLuUk0nw8r9jqgWiEDP4bH8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Ovau6m2p; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Ovau6m2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743525118; x=1744129918;
	i=johannes.schindelin@gmx.de;
	bh=zb/AYlwRSS7Azo9WPGKWXGM75ffzKoRpq2+u5+4nVYE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ovau6m2pyiveoAoLbxvs0D6m0hq3Si8q6Ys6h942n8ufR8foX4OBA2lrEl37WVfW
	 1a/RjUQg8mYFQcLRZDgCGH+N+NteOosJ6icQ+mbOecEh6fbtPWg1VrRnb3khen52c
	 AIicfrgD5JEEbYlZuDJJPWw5wiBzaWlJVA+xB4Y9Uq8Gf83AJ1W0YBD06SKbqIWxd
	 N577YLi8l4qsQir5rZ9G302JQMhuhoEfBMoi0+MsvS1N+Yb5bsPgUwIRxSXdGRNPA
	 R4NX0cbkBtlOeSB650aIu+4esT8wuvYmOsKJAjJC7LvRNksUnxnZzgTqipjovJ3WO
	 hR3kMdqWkZJzVbTUtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1tpWZZ17ff-0003je; Tue, 01
 Apr 2025 18:31:58 +0200
Date: Tue, 1 Apr 2025 18:31:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Sam James <sam@gentoo.org>, Eli Schwartz <eschwartz@gentoo.org>, 
    Thorsten Glaser <tg@debian.org>, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH v2 3/5] meson: respect 'tests' build option in contrib
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-3-6b06136808f3@pks.im>
Message-ID: <56435f95-986b-8116-2fef-9d6adfa1bc65@gmx.de>
References: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im> <20250331-b4-pks-collect-build-fixes-v2-3-6b06136808f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m5WvihTSZ0FYnQgJPm3jico6cDlAM9sW3JeRkZ4AHJgJJ7KWu2F
 gZ/dHkBFXAeUlf9WUY6XCQ3JVVZ/eTXqtWysFk5Ibltp+lY4mxbGqqdRfHrKmc5A4FFhDRc
 TfhJzeWkokozb3/hvG9fWjVNgsl1CjZu1eeGQ0Wc89u52OFM5clLIgvHDuEzXkV4KFSFkX6
 sdx5LBSVRFiIfUyPvzitg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:obWIUehvHbI=;QehfXvMbk2hD/yq3/aBBAKGItRo
 us2Cy/XpCssZ6/2AoQgFh5njJPoiBuF9CPV7eFi6IFQTGhBvMAhZoRUHASGXWgx204WSxi2hB
 xWJiv6eUXGBwrVTcRT60GLLSg3vRXZkrjAP/Vlk7KCok7LBbmWw+us5qbIn9YqIK0I+6KLv5Y
 RGogOh72d7juNxsrUQZagBg6ydRL1JKFgbHb1I3Bcb2sRQIt3M2KvdqCnnf1f1Cp3St/dUa0h
 Mjn2962TqUJZafsnIrUIjast+nq2EfXcvHQqecE27wnFRLD4H9FRR84kzlM4RobZTF9BU8JHj
 wk0gsqrnMR2l+QPTmWXnsaqK0cqjFJSFWgUrrXNBBZ2GfcUBv8Gi/Gocd+jYR5OBKavYVlMCy
 vpl2tJSz6rVy+OCDw544hfAbCeq3LBUjHMp0SERMoI5G2Z5Z8uNssZrJDTUqDvK2ltGXOapVn
 pmZVePU72OmrhotPYnAVYQ4zjGGs7/e9jSae1A6pstXgDsErMNHXrbVsTRaghq2989CedZeRp
 tRqzaKV3J7ZHRdRnnVYQOvr8X4nDwy4cZChQQ4UKJhug4SgvAE40ng9SZb5w6tc7kbPtzBtej
 EHlx1GdGlQCXYTVe3f/kCoQ6D4k372Wi9f/zEAXj0vYEgdWq1CgByDua4OxKLWgDBrbTkf4/H
 YnCdVAk/1nZKIeAuGd5c0qXQfk74hqjKSGsUEglCtIap23J7eWSfpBt2b1teYmAJ2C/u909wB
 OyXefuqVLWi6j+0OhT+yVYkvGWo420XCD6dlqgQRQErljeNQbGN9AXVT9XW+qUIy/QKrESgDk
 7ctnuZa6H6rb/kZ6zvIggo/6TR6PzUTh/foBNBFRbaBnooLevPH8g5QGIFo9ViZlIPId3LbXR
 LT1tnGQy6IqdYMW7WPLIL2sTpZulR0Pl2pBRAee5LrECO7/NZBS0bolbgEaKnerl+XXC57YqS
 NNgJvL2fz/mCqtqrAvVmSsTs8WJd9fzGdJj/0Ub2FNCQjYeq3QSOq3vjg7dzpCpYx5MrgGYyX
 MndIoVfuac+v3mPUAQ0PjmNa3LKnWvNjBo+cSzOgQfMX/1CTi996G2GoYlOI+zgJDSJX4GSIu
 KinD1ATrhv/R+/ZaZ6TSkx4uEIZY/vhNnxBcRr3cAShWFxBbCQGWJgmoqp1CIU/PNVJ4AOKI0
 ifqEaLYrzZTTaJUYtFxIt+Tq5nBUaX+JkkQR65h1frfM04mHa7XB3TKAY+fEstW/7ApOUYD4O
 pkFIgJqf+uWE2n01SwrVIU4q69oSDQNj1vp9n+/GMyKn8vlBJeadhERnQ56IvhydgKYGQ7DRI
 pIaSo7sC6yc88jkQ5rNzvOrT1G0DTDbu0rrYCpTCgsCDGPHPLlIi9VqpE7yW3zf+RUEY9iwoN
 nNQgRisPUFYGxGGDXoyXX3Cy/V4uo83lkEzQ1PkCoo1CsDrwzx1SaxEyORAHee1Ozw09uonSa
 1VjARG88tRdovBWCukgRpbvjn+H/47AT61lrViCZBT8AQlc0o
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 31 Mar 2025, Patrick Steinhardt wrote:

> Both the "netrc" credential helper and git-subtree(1) from "contrib/"
> carry a couple of tests with them. These tests get wired up in Meson
> unconditionally even in the case where `-Dtests=3Dfalse`. As those tests
> depend on the `test_enviroment` variable, which only gets defined in
> case `-Dtests=3Dtrue`, the result is an error:
>
> ```
> $ meson setup -Dtests=3Dfalse -Dcontrib=3Dsubtree build
> [...]
>
> contrib/subtree/meson.build:15:27: ERROR: Unknown variable "test_environ=
ment".
> ```
>
> Fix the issue by not defining these tests at all in case the "tests"
> option is set to `false`.

Sounds good, and the patch looks good to me (it would look even better if
I had proper code reviewing tools here where I could use the `-w` option,
but mailing lists do not offer such tools).

Ciao,
Johannes

>
> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/credential/netrc/meson.build | 22 ++++++++++++----------
>  contrib/subtree/meson.build          | 20 +++++++++++---------
>  2 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/n=
etrc/meson.build
> index a990dbb86da..3d74547c8ae 100644
> --- a/contrib/credential/netrc/meson.build
> +++ b/contrib/credential/netrc/meson.build
> @@ -7,14 +7,16 @@ credential_netrc =3D custom_target(
>    install_dir: get_option('libexecdir') / 'git-core',
>  )
>
> -credential_netrc_testenv =3D test_environment
> -credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.=
full_path())
> +if get_option('tests')
> +  credential_netrc_testenv =3D test_environment
> +  credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netr=
c.full_path())
>
> -test('t-git-credential-netrc',
> -  shell,
> -  args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
> -  workdir: meson.current_source_dir(),
> -  env: credential_netrc_testenv,
> -  depends: test_dependencies + bin_wrappers + [credential_netrc],
> -  timeout: 0,
> -)
> +  test('t-git-credential-netrc',
> +    shell,
> +    args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
> +    workdir: meson.current_source_dir(),
> +    env: credential_netrc_testenv,
> +    depends: test_dependencies + bin_wrappers + [credential_netrc],
> +    timeout: 0,
> +  )
> +endif
> diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
> index 9c72b236259..63714166a61 100644
> --- a/contrib/subtree/meson.build
> +++ b/contrib/subtree/meson.build
> @@ -12,16 +12,18 @@ git_subtree =3D custom_target(
>    install_dir: get_option('libexecdir') / 'git-core',
>  )
>
> -subtree_test_environment =3D test_environment
> -subtree_test_environment.prepend('PATH', meson.current_build_dir())
> +if get_option('tests')
> +  subtree_test_environment =3D test_environment
> +  subtree_test_environment.prepend('PATH', meson.current_build_dir())
>
> -test('t7900-subtree', shell,
> -  args: [ 't7900-subtree.sh' ],
> -  env: subtree_test_environment,
> -  workdir: meson.current_source_dir() / 't',
> -  depends: test_dependencies + bin_wrappers + [ git_subtree ],
> -  timeout: 0,
> -)
> +  test('t7900-subtree', shell,
> +    args: [ 't7900-subtree.sh' ],
> +    env: subtree_test_environment,
> +    workdir: meson.current_source_dir() / 't',
> +    depends: test_dependencies + bin_wrappers + [ git_subtree ],
> +    timeout: 0,
> +  )
> +endif
>
>  if get_option('docs').contains('man')
>    subtree_xml =3D custom_target(
>
> --
> 2.49.0.604.gff1f9ca942.dirty
>
>
>
