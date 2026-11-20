Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187347;
	b=SLHmENpdftjyutc0vNYZLDuHC1UCUu/02EjTAp7KC68fjFs5plnV5YxXOrO3XHYmhfHi
	 BhPOf9WpUu3wYh45Xtejg3Hd/XrjfPW3Rpy/evuU81zsEmW5wU2KYdfkGG1vZvhosUh/9
	 uJHkx1Cgv6PoRdBubr89s3HX5oCgaMIbBsWJYDHZlDeezTXy6yJKCxwyHBAF7crkJ2xQc
	 nTYvB2qoqAD4BlLmhoR8RNMXkJ10XKyKoEJG6YbNNEwvR/Ea3uOBXz8SvczJNPuTy1vKm
	 2TRlts+I5lLBKiTjs3BskUTVQLTSeOlKiTno9M2lz32kcL9LjtRRPTH8SiHY0FApJqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187347;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XJWz0AYpy0+57+HFVNyruqsT7+UY4LVs9NMEIo1/+XA=;
	b=dBTKG7ZwPaY1wZReqUl8VEfG9v+0ln/fFlJfEgciBlId2FFO3tkRoO38kiOGyJVTxHFY
	 EY8nvwpePuiRERQHyNPrd8oOSHxOExLI5dpQTfhHRXdL5gkLxL9YZnRaQRK4Xo3dqIJap
	 0qniCcKwxbXEXPnYQmam5ceAHziinpses37TBDmI9s+Cle2ZfCntkqlV5uKJIh8/+Ku73
	 D88owiEE4ZFGJNuZsTY04Ia1Aoh/S10AnjrsiNkYZzxACP7vPONnNWfeHxk3jkCOmeApD
	 U1igp3B82fAI+pilRUbpnTV1eMhRJ/jaKiD+X3dI2131zm1PhMEErev4Qus9VeU4r0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=IESW2ynN;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935B606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9935B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=IESW2ynN
Received: from localhost (ip-109-41-49-183.web.vodafone.de [109.41.49.183])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AKF902b2082093
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 20 Nov 2026 16:09:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795187340; bh=XJWz0AYpy0+57+HFVNyruqsT7+UY4LVs9NMEIo1/+XA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IESW2ynN8p5y5a9pbun57d26It0ewYahxRkUSxhEwNomAsFffjyYIl+1wwXDrDOoC
	 gtOtwNhboRsAmckM5UGPA2vM1KqZwZcoi37s10SK9xQ15yoXS/uLxfzZtAdb8uCFVk
	 BhRTdff/zmP9cdFd20yTQ9tlXw080VCZjTBi/cNE=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH v3 0/4] utf8: bounds-related fixes and a doc fix
In-Reply-To: <20261120-master-v3-0-d28e8c75d26d@gouders.net>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261120-master-v3-0-d28e8c75d26d@gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 20 Nov 2026 16:09:00 +0100
Message-ID: <gh1p8fo7zn.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I used --reflect >5 times but with the final "simple" polish I squased
two commits -- and did not --reflect one more time...

Please disregard this series.

Dirk

On Fri, Nov 20 2026, Dirk Gouders wrote:

> A patch here on the list made me look at
> display_mode_esc_sequence_len() in utf8.c and I found two details in
> the file that are perhaps worth a fix:
>
> 1) utf8_strnwidth() disregards the given len argument when fed
>    with proper string and len.
>
> 2) The comment for utf8_strnwidth() is incorrect: it states the
>    function returns strlen() for cases when it actually returns its
>    len argument.
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
> Changes in v3:
> - 1/5: * fix sorting order in t/meson.build
>        * fix risk of O(n=C2=B2) degradation:
>          drop the wrapper function and introduce an end pointer to
>          display_mode_esc_sequence_len()
>          (I was so used to len arguments for string handling functions
>           that I only now realized the beauty of optionally optional
>           end pointers for string handling. I know: beauty is in the
>           eye of the beholder ;-))
>        * try to fix an overly long line
> - 2/5: also fix a further error concerning "null-terminated"
> - 3/5: * drop excess SP in if-statement
> - 5/5: this actually is a POC, not fixing a bug:
>        users of display_mode_esc_sequence_len() often need the length
>        of all leading SGR sequences and here is a function that does that.
>        I mentioned such a function in the discussion for v1.
> - Link to v2: https://patch.msgid.link/20261118-master-v2-0-3f2aaec15d31@=
gouders.net
>
> Changes in v2:
> - Add a patch by Junio that introduces a bounded function display_mode_es=
c_sequence_len_counted()
>   I added some tests for this new function.
> - 2/2 became 2/4
> - 3/4 is the modified 1/2 and uses the new
>   display_mode_esc_sequence_len_counted() so that the while loop stays
>   within the given bounds.
>   The commit message was adjusted.
>   One of the tests was wrong: "\033" has width 0, so the sum must be 3 in=
stead of 4.
> - 4/4 is an addition to fix a similar problem with utf8_width().
>   That function is used without its optional bounds argument and
>   can violate boundaries as well.  Test for such cases are added.
> - Link to v1: https://patch.msgid.link/20261116-master-v1-0-dc2a50ce0aa0@=
gouders.net
>
> ---
> Dirk Gouders (3):
>       utf8: fix comment for utf8_strnwidth()
>       utf8: respect string boundaries after skipping ANSI escape sequences
>       utf8: respect boundaries in utf8_strnwidth()
>
> Junio C Hamano (1):
>       utf8: introduce bounds for display_mode_esc_sequence_len()
>
>  Makefile                    |  1 +
>  pretty.c                    |  2 +-
>  t/meson.build               |  1 +
>  t/unit-tests/u-utf8-ansi.c  | 85 +++++++++++++++++++++++++++++++++++++++=
++++++
>  t/unit-tests/u-utf8-width.c | 20 +++++++++++
>  utf8.c                      | 78 +++++++++++++++++++++++++++++----------=
--
>  utf8.h                      |  3 +-
>  7 files changed, 165 insertions(+), 25 deletions(-)
>
> Range-diff versus v2:
>
> 1:  60979dc4d6 < -:  ---------- utf8: add display_mode_esc_sequence_len_c=
ounted()
> 2:  b8dbf5c5bf < -:  ---------- utf8: fix comment for utf8_strnwidth()
> -:  ---------- > 1:  5b938b3fa0 utf8: introduce bounds for display_mode_e=
sc_sequence_len()
> -:  ---------- > 2:  5ef8308d51 utf8: fix comment for utf8_strnwidth()
> 3:  12a99d1c8d ! 3:  bd7c9b0b01 utf8: respect string boundaries after ski=
pping ANSI escape sequences
>     @@ utf8.c: int utf8_strnwidth(const char *string, size_t len, int ski=
p_ansi)
>       		size_t skip;
>=20=20=20=20=20=20=20
>      -		while (skip_ansi &&
>     --		       (skip =3D display_mode_esc_sequence_len_counted(string,
>     --							orig + len - string)) !=3D 0)
>     +-		       (skip =3D display_mode_esc_sequence_len(string, end)))
>      -			string +=3D skip;
>     -+		if (skip_ansi ) {
>     -+			while ((skip =3D display_mode_esc_sequence_len_counted(string,
>     -+									     orig + len - string)) !=3D 0)
>     ++		if (skip_ansi) {
>     ++			while ((skip =3D display_mode_esc_sequence_len(string, end)))
>      +				string +=3D skip;
>      +
>     -+			if (string >=3D orig + len)
>     ++			if (string >=3D end)
>      +				break;
>      +		}
>=20=20=20=20=20=20=20
> 4:  471c3d6888 < -:  ---------- utf8: respect boundaries in utf8_strnwidt=
h()
> -:  ---------- > 4:  a6cf4c99dc utf8: respect boundaries in utf8_strnwidt=
h()
>
> ---
> base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
> change-id: 20261116-master-69b171612823
