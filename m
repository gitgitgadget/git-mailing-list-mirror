Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEA2FB969
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424754; cv=none; b=aKA7fYnedV9dQO09rO1i4RozLpBkhdHVXMYQ/mapotJDm1t/8DYIjElt2fZeBrQCG+iMHwNpyjAgRNHbRFO0Y4tfujEii3ag5IpwpkR3YiWIAJMPznexM2POJC916wJJkmrJHrl8U0dnf/wLQb4CCtWNAmZw6JzmUppViGLcaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424754; c=relaxed/simple;
	bh=a/JsaL9HbmGJKnYseS/bZEjzWdcHiL/zj3ImuyvA36c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Aq4XBIRX2D5mYDdpTBj1fLVipaHw+1mbpbrmJQinQqly/kCrdP0N1qzh4JMiS5LWZfBkcp63id563POEsBSsJry4T5JUUZZy95U4Wa7MH/j4Oa3FlBt2cMU9bAbgl4phROpEWYv8x/xQOVIb2HTnaf86TO762p9PK45ZOsJYmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DHTiIG9N; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DHTiIG9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783424745; x=1784029545;
	i=johannes.schindelin@gmx.de;
	bh=c4BEjNvKeXtRKzsHSQYf4xgbpFW46voypVWaZAxPsLk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DHTiIG9NGojA1+yzpFisW5Y97QKqOVYEdTB6gfcYIDO7TuOifAZpf9kcBN+J9P+p
	 MQpZrH6rfJ8Du54mr7N+i2095ihmLbk0inWxNgP+YMPv2kRZwi1oInpRkBu/RNIa5
	 CDJB9rlxC08Pzyy1JVcu5LSXR7QM6Nu2TqDEp2tE9hinvk0uCaaOOsnuNO38SmODZ
	 D0cM2Nsoz2VSA5P0Dt309BQNb0whJMuqeU/PXmYzPZNwzBazc8GUCOfYd9vMn6NHK
	 nAitw9cJMGQsXbn8AkNmHqRM73hZ8WcejcB6yP0/n/X0k7MXrWlv47CwYXwSt5rpZ
	 +MKKuT7AitsY9aFkeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1x9AZi27Sh-012SgU; Tue, 07
 Jul 2026 13:45:45 +0200
Date: Tue, 7 Jul 2026 13:45:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: grawity@nullroute.lt
cc: git@vger.kernel.org, =?utf-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sideband: allow ANSI SGR with colon-separated
 subfields
In-Reply-To: <20260513070803.163546-1-grawity@nullroute.lt>
Message-ID: <8addf7c0-ae39-f1c0-20ab-52114702aaf6@gmx.de>
References: <20260513070803.163546-1-grawity@nullroute.lt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=832332820384756851783424746183989
X-Provags-ID: V03:K1:SrgSjUhsWHKAOCU4oe491a/5g13IKlWBkLyrAO/rM9fHGWnaRyZ
 Hroe+xVSy5ILfYQ7HxQEP+YtnCWy+DP91Z7BE9iqy6B/UHc4P5Lb1ZjPZu4nIC13vF3QUn5
 V/PvK8Wc1lNbLGaNosV376FxyTrUqNanYnLwKJ5xxW55AjHQ705NDQk8Jf4BdQqM6QLB5W9
 Jqa4Vpfil4kwWiIKmGzWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CYOkmVGg0+w=;v+yKgWlI9Kd8YzzwXOzCc5kbHGl
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332820384756851783424746183989
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mantas,

On Wed, 13 May 2026, grawity@nullroute.lt wrote:

> From: Mantas Mikul=C4=97nas <grawity@gmail.com>
>=20
> The SGR values used for 256-color formatting are officially defined to
> be a single field with :-separated subfields (e.g. "\e[1;38:5:XX;40m")
> despite the more common but kludgy use of separate values (which then
> become context-dependent and lead to misinterpretation by incompatible
> terminals).
>=20
> See also: https://github.com/ThomasDickey/xterm-snapshots/blob/6380a3eae=
d857c182ea6cfa78cd706966b2628d0/charproc.c#L2047-L2118

This change seems well-motivated and well-executed to me. Just in case
anybody was waiting for my objections, there ain't any coming ;-)

Ciao,
Johannes

>=20
> Signed-off-by: Mantas Mikul=C4=97nas <grawity@gmail.com>
> ---
>  sideband.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/sideband.c b/sideband.c
> index 04282a568e..6cf70ef6f6 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -163,6 +163,10 @@ static int handle_ansi_sequence(struct strbuf *dest=
, const char *src, int n)
>  	 *
>  	 * ESC [ [<n> [; <n>]*] m
>  	 *
> +	 * where <n> can be either zero-length, or a decimal number, or a
> +	 * series of decimal numbers separated by a colon (for 256-color or
> +	 * true-color codes).
> +	 *
>  	 * These are part of the Select Graphic Rendition sequences which
>  	 * contain more than just color sequences, for more details see
>  	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
> @@ -210,7 +214,7 @@ static int handle_ansi_sequence(struct strbuf *dest,=
 const char *src, int n)
>  			strbuf_add(dest, src, i + 1);
>  			return i;
>  		}
> -		if (!isdigit(src[i]) && src[i] !=3D ';')
> +		if (!isdigit(src[i]) && src[i] !=3D ':' && src[i] !=3D ';')
>  			break;
>  	}
> =20
> --=20
> 2.54.0
>=20
>=20

--832332820384756851783424746183989--
