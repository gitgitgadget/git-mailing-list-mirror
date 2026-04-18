Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29B13AA2D
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776549309; cv=none; b=ajbP9/ddp39M5wq6chqmK77RTbFm+tz+LQbUqlyd1sevccbxjWbkd9p80hthKFZeJ6C7gIpQb3SBv+WfLWoJgwP8qPD8kWiEHD3E4Qko76hx3u7Qj3Q/Uacq7oGPEpp/yM56mc1gfr05GWmAfGLz9o2swpvpbjgQMbCniSWa0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776549309; c=relaxed/simple;
	bh=PpamzeTBg5r2KpNjsWfQclW9pmrVmmM+paVT+2CLuGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGLiyOsDHI9IgkXcrG1M69CayieD0NJsbo8w36cvqklthHPgARK1V12Br6kF9CeDlM74IRqPgKSl7IbNorppiiDwqo8DhowdiJx1FnPFlNeABsd9T2+V7GTzl+zomVR3QLK8pB6PS9kSIbGBK7KSA2kvUYMLq8JNQvQnDoCkdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zRJo0huW; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zRJo0huW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776549299;
	bh=PpamzeTBg5r2KpNjsWfQclW9pmrVmmM+paVT+2CLuGI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zRJo0huWprSWgqY45qgbuymAhkHzrpvvjEwsP1nQwiaiU06G06F8gz6pDhY2SicF/
	 YQ02p23tLn16RG51XwMOSzLjApjWmjzUODxe4xx7q8Vj4JsE+ZEd2h7crgI4HYVrNF
	 NXkdDsjsqKQcdsx3+BLdQumsS/yYlg7p27NbWHHBINjDLP0V4cOOOUiVEhbievmbR5
	 1Wj3mKyXkomNMGSbq/tUwLH8VrrnsvZMBX8v6d/YA5Y7s9fcUjT9mA898L8OEI8A1I
	 urNg19110+GFPTdc25lEpWVMW4NlQ4OvpP5/YXLn15UQxGUIViQFfpVerr6fIng+oB
	 UyKnz5LVcdpslnYREppJwNOh9mUWpE5SlNl7lxnd1KMVqJ0VUWQjWLfCyIgiDVoMlz
	 XlAdzntpjfzAQSXd9xgX2Wz6n0qFIP8l26YGZRq6t+nX6vH8u8yNJ9Hr1x2EEFLuH5
	 biW4XGi3kIvgrGLKmU+UNOOpZxLHwhQMa2BVnyw0DLxT20F4ykF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:595b:551b:bb54:42ba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9DEF6200FF;
	Sat, 18 Apr 2026 21:54:59 +0000 (UTC)
Date: Sat, 18 Apr 2026 21:54:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Ben Knoble <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <aeP9stvssuTv0FD7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
 <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
 <aePY1x9uO39p6WDI@fruit.crustytoothpaste.net>
 <20260418213043.GB9632@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hZ6kf2Pny/Grdu60"
Content-Disposition: inline
In-Reply-To: <20260418213043.GB9632@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hZ6kf2Pny/Grdu60
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-18 at 21:30:43, Jeff King wrote:
> If check_fsck() were run by itself then yes, this would be a problem.
> But it is always run inside a test snippet, and there "set -e" should
> always be suppressed because test_expect_success does:
>=20
>   if test_run_ "$test_body"
>=20
> So we are inside a conditional, and the usual global "set -e"
> suppression should happen. It sounds like it is not happening in your
> version of mksh, but I was unable to get t1410 to fail at all using mksh
> 59c-43 (from Debian unstable) or 59c-41 (from stable).

It does fail with 59c-43 under `make prove` or if you do `sh ./t1410*.sh
--verbose`, assuming that `sh` points to `mksh`, but since the script
has a `/bin/sh` shebang, you need to invoke it explicitly with the shell
in question, or it will use the system `sh` (dash).  (I made this
mistake when reproducing the problem.)

Note that the test in question does not exit, but returns this (with
`--verbose`):

----
Checking ref database: 100% (1/1), done.
Checking object directories: 100% (256/256), done.
not ok 7 - corrupt and check
----

and this:

----
Checking ref database: 100% (1/1), done.
Checking object directories: 100% (256/256), done.
not ok 8 - reflog expire --dry-run should not touch reflog
----

It does seem like this _is_ a bug in mksh, though, which I've reproduced
with a test script, so I'll report it there.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--hZ6kf2Pny/Grdu60
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmnj/bEJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZzPvBdVnNAEX2uxZUr6pdRkm7nxQNtzVtfFz6icoQ6H5
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAH2YAQC1s/MH/h3iaHv9WvcVotRAXbEV
tTqQEkdYK4z9j5qe5wEA5SS+V8HY8fZfCII01falcTbn303IKo8UXbWu1W41lw4=
=Z49d
-----END PGP SIGNATURE-----

--hZ6kf2Pny/Grdu60--
