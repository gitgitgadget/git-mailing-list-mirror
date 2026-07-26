Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13B1D5CC9
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785073298; cv=none; b=DbWS12yEKdC33Xws5uA8ddMMvc1ISRF3doXamQ0P1NGfywdS/6brz2Qvkdql0E3P+iKvadAhAhSjO1S/kQTvVbWrRYlHQgA4b4Fgjh+2ZTr/ArdwZt+OKXtOwmitn1xbuvzNy15cssZgnFYvamS3F9yNqdkyy0DSH0qU8c2xdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785073298; c=relaxed/simple;
	bh=3fBTTGAuO6vz4Z7EASUT3vx6EzeonXtBioBr33lL0Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FZPjBJ9JKGCMZ9Obx7HE7LrVF07Vp8wlPslecu/Vu9X7qBuJWvlaHJIk2XoeAMscJrhLXtedtFzgovvB/0oCivGy1fxqusrSjLr+smlTD4TRgjAxdGuuU4NJiIW2/mSRoHYFAai3d0cQumZsoeCPcH2UQN21weyk9K2PqkOXa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HPbm777t; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HPbm777t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785073293; x=1785678093; i=l.s.r@web.de;
	bh=oa/J5n19Enbk7XM8ZikzPpOHaEZOUNsugx4lwI7w200=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HPbm777tZX1fW1zrlwce9vL/sEJu7Pzk2Gn7chNnX/24lJJOqkwHwD8xYpxv+gig
	 PsI/U4LQh+dWM3N0ksiiBkITGyqkGnsYj69M0a7lci7/e0+I/o2dEKiBTDiSuQF6T
	 KndIKZtnwaBAVP5TM+L/XKZof+oLZ6YAtHK0eEJT6+RpSgyErTO59uBcYNvidWsm8
	 nDbbCQWaH2Q0bztEyi6VAcIJGwVZMwtHasB+ZzyvBA3l2biBXCYafs+Z0jIdP3Kr6
	 jrZUNd9DEoEuUrPW5XXNsi7nXvEIkkignzSd/WbGKq6W6FAQAeL9Qwf17KgTXJmyE
	 7bCmaMOtIDkmrzK+GA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1xC7bK2sCh-00xNlQ; Sun, 26
 Jul 2026 15:41:33 +0200
Message-ID: <a85b5428-df17-447f-9d84-03fb433711a1@web.de>
Date: Sun, 26 Jul 2026 15:41:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] change utf8_strwidth() return type to size_t
To: Hardik Kumar <hardikxk@gmail.com>, git@vger.kernel.org
References: <20260726123427.173877-1-hardikxk@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260726123427.173877-1-hardikxk@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ol6XaUnSJKTBS5MofecZjMtUtfRB1QA2LF1Eukfwfv7zU60uASM
 oCDVnqz2RGSNxvylRtVangm+LI7/ekQhm/DVaFY9EGM+WEXUvZWrsh4qljwNTr3y8ABBYFo
 hbIeT+4afscf+Oi6kB/0hf8gPM3ziYzUp3+8CA3IZZ0gBzeIAHA9560jXXqk0TNh93sSpsN
 J16KdQqdvLWTlw76DRDqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rbbsoL+LBvQ=;ZGDjZ5csG1R3klsuQIAhpq1GASu
 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
 G5iUNeTcs7ehidqfbUWQj

On 7/26/26 2:34 PM, Hardik Kumar wrote:
> The patch changes the return types of `utf8_strwidth()` and
> `utf8_strnwidth()` to `size_t` (implementing a //TODO). Both functions
> have been updated in the header file also.
>=20
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
>  utf8.c | 13 ++++---------
>  utf8.h |  4 ++--
>  2 files changed, 6 insertions(+), 11 deletions(-)

What about callers that still expect int?  Are they all safe without
cast_size_t_to_int()?

>=20
> diff --git a/utf8.c b/utf8.c
> index 96460cc..1081573 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -208,7 +208,7 @@ int utf8_width(const char **start, size_t *remainder=
_p)
>   * string, assuming that the string is utf8.  Returns strlen() instead
>   * if the string does not look like a valid utf8 string.
>   */
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  {
>  	const char *orig =3D string;
>  	size_t width =3D 0;
> @@ -225,15 +225,10 @@ int utf8_strnwidth(const char *string, size_t len,=
 int skip_ansi)
>  		if (glyph_width > 0)
>  			width +=3D glyph_width;
>  	}
> -
> -	/*
> -	 * TODO: fix the interface of this function and `utf8_strwidth()` to
> -	 * return `size_t` instead of `int`.
> -	 */
> -	return cast_size_t_to_int(string ? width : len);
> +	return (string) ? width : len;

Nit: Why the parentheses around "string"?

>  }
> =20
> -int utf8_strwidth(const char *string)
> +size_t utf8_strwidth(const char *string)
>  {
>  	return utf8_strnwidth(string, strlen(string), 0);
>  }
> @@ -821,7 +816,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_typ=
e position, unsigned int wid
>  		       const char *s)
>  {
>  	size_t slen =3D strlen(s);
> -	int display_len =3D utf8_strnwidth(s, slen, 0);
> +	size_t display_len =3D utf8_strnwidth(s, slen, 0);
>  	int utf8_compensation =3D slen - display_len;
> =20
>  	if (display_len >=3D width) {
> diff --git a/utf8.h b/utf8.h
> index cf8ecb0..531e968 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int =
*/
> =20
>  size_t display_mode_esc_sequence_len(const char *s);
>  int utf8_width(const char **start, size_t *remainder_p);
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> -int utf8_strwidth(const char *string);
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> +size_t utf8_strwidth(const char *string);
>  int is_utf8(const char *text);
>  int is_encoding_utf8(const char *name);
>  int same_encoding(const char *, const char *);
>=20
> base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca

