Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9EC12FF84
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238570; cv=none; b=Uv/X9yAFH9iKBQt52bLmyNDH277jp4PzHnrQ4Dt1RrNDQy4Cek8/hir58QK4N5q3PU0oRzJKUshxph/hC/DBMDPObVoBF1zXBGKuQcf4t6nlC5t2eOkaO0vrMxI5NMgN8DzKPoOfMR5LMlK2No5A/7tIhlI+paphxy0bEQzyVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238570; c=relaxed/simple;
	bh=lwLdgiJgVfn82EeLHi4muKZQBGI3sHD4skMcUQ95Eik=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DW7Ey1/iahPSUxONJ2r0pkp5DxedpgI224P9F8F3iflvN21jLIfwYmG6QlDAJrAbsiqUQf+UXA/KTrWhArDdh4Eas+uASu0CCFZf/crVeFQTat7eE1xz7YCegbDxrZYn8E3Eg81/U8Bxt0aaoqpzXMrylwGChanAKbxXIDd8vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Oe3SeSbq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Oe3SeSbq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719238553; x=1719843353;
	i=johannes.schindelin@gmx.de;
	bh=gON8k3JXDYyf4B4Dt4t1LjZpiQOpCNSlLfas6p1SeYg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Oe3SeSbquhqkTFws43jgGQKVuHlaKcMAh1pWxiYm1Nte0putivnnWcHySoTFZUPm
	 Bvsen8C9WjnliRGmxR8kIRR5vdsDtRqN3mpC3h2hepP8lrhfkhiYNzwL4/N6G5p4T
	 v8Mka2J1EgTmbGXg7aU8cSSW7FCk0H7WDdSVGYeMX1PA02CUxuOZznY3Xzz8wQT6f
	 uItDksJnffYig5RMbrHtDkNGfO9QJ4nTeI2e2ZlciHkiAzEeFNXpHp+tnw8KYDPx0
	 nz89Vl0P9JHNq2Ye/i3ZUJZ7ay+zbRFetF45+t9QnksM9NKgBwu4gqz3ozUSlaJt/
	 aMM5WxxdjsSrWgVszg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([104.151.5.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpru-1sgAjb0hw2-00aMiD; Mon, 24
 Jun 2024 16:15:53 +0200
Date: Mon, 24 Jun 2024 16:15:52 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>, 
    "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 2/2] Teach git version --build-options about zlib
 versions.
In-Reply-To: <20240621180947.64419-3-randall.becker@nexbridge.ca>
Message-ID: <80112f79-f2ec-28ff-3ced-9df9d7ea87f0@gmx.de>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca> <20240621180947.64419-3-randall.becker@nexbridge.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ts+N51e8WPSmnZH9+jIrErLQI2lwkXob0D69xVur6tFBvcYbUg5
 9niBWKw6343rWod/9VVNZnodYTvXaRSTEqXDwzfK7E+XMSG9fMU0Yx11xaAhcL7PKuIA04c
 kn5tjIEHF0JZWvjT+QIkDMrIkOo1bdpcgWelFPvXhE/UD4bwRVAQfeGfX9lAzYdcNkdMKka
 jkbvtt1Aes+oIDr6buZiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5EtNK/iw2a4=;dY8hF1Vfje+5NKIyxnqcaI/FRfo
 JftYFUILcg5xVt4eM907bwcbcJz7NAHyViIds5R1g30ZCEPGkrKKTrLHucoMFAEZyzxmOg0eI
 6ED8ZmH3STPbfL0UQxmFvmmmoMvRBVS1tg6YgLQQ+PvehTe5ttZuj4vParSxZ/rySuT2XlYeW
 38DQ1FnQCxWe4TYOcjZwXJrT9MXWDpeAVz6MbJlZFVCXhoUARLIZWq7Ta2CJXm3QNBAqRonqZ
 KhYmXt8lWbjbptuNNcNfm3P7i1fscERwdCnQjtOSDt9HijjCDZ7Je991ByiI4f1J2ucVYTFIz
 GLNR58SIcP8NMrludVpRiroGQTE329E58sxbdpi9I3E6hAfTvyKbAHewKm1BQQul/b30vkZI8
 MqhIAl5HUjzczzj35ccpAqHhsixPWw8ZTYSTnLI5efjYDclqDfTl5yu2Qral0tDIjZdgQSpuh
 huGjJKIGgiRE4ZdKYdDgX3zrYpY19lVyRv9zdeAl871AaGjBZ2lcOfkJGi7Hn20unDKcsA5/K
 bx0lcJ4Z20kIH//jIL+76R3lyjoH0/BNTBAz9IKfJPD9Kw1hWVd5AJCNKvge92tRC+qciBiug
 msgDhuUHArWCVV5iRqBinlzt00IBj0u1GPdEU8iq+E31On40wwNKT5FiL/FbdO7dg6UFvCbR4
 Q2cLT9fjzPeRsM5A6Kd2dpNHkGnL7StxtHtcChOfcYY2T27adDimZEv3+9imObdmJOXxID8xq
 OJGBXOY0/DwPTDw9A2gwM2JEzP4qXpjfwvPsYmVlAiySQZ7vVFt4n6HSTmP9IsUZJFgHVU5a4
 rcqjCIWM//Yhqj4Ap79lj44JQPamk7cYGEeWcK0F/824k=
Content-Transfer-Encoding: quoted-printable

Hi Randall,

On Fri, 21 Jun 2024, Randall S. Becker wrote:

> This change uses the zlib ZLIB_VERSION #define text macro. No
> stringification is required for the variable's use. If the #define
> is not present, that version is not reported.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  help.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/help.c b/help.c
> index bf74e935b9..f378750af4 100644
> --- a/help.c
> +++ b/help.c
> @@ -760,6 +760,9 @@ void get_version_info(struct strbuf *buf, int show_b=
uild_options)
>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
>  #if defined LIBCURL_VERSION
>  		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
> +#endif
> +#if defined ZLIB_VERSION
> +		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);

This reports what zlib version Git was linked against, at compile time.
That may be misleading e.g. when running with a different version that
has a bug. Would `zlibVersion()` be more useful here?

Ciao,
Johannes

>  #endif
>  	}
>  }
> --
> 2.43.0
>
>
>
