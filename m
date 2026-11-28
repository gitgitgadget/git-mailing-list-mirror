Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795843500;
	b=f5OyZ+Ag7w7pvFhZtsBVFxusdXQmBbVkPEnCKREB1zVUlMwYhi/mxcLcUY8pZL5tF5YP
	 eiJ4+RNTvU5r9Q/GnykyfNEwqRTPJN/p6T2LPcqbIFXpJAQ0pPBS4uGBhNqfXJEQbbY1b
	 uo5jaTtXLrt928pioKbEKPc4YT5gpyjD4oWuJMHej4saWWiq8rfYxt9NrVn9F6cy0cGUl
	 CZBTega7yl2LDalPBPJv4m6magGmnti6yRc4K35G8IAMXATHVwGoTEB4YxDavtO0vYTZR
	 i18LNvgU9ww14H6KAPfI/JIDt/O/mQ90anQnfssPFyyO+XUPyOdq3PwAj/o8BKfAz3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795843500;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=UhTuH32sMQCiE2Y1Z6OHLI5NDHucmzOtYU+alWW45t8=;
	b=2xJCubTc0qGjWoA6/u44C/44USCwsHVBlH1weknD9SFiesxF7+v4sevZurGYeXfUHPp4
	 vKH5mtEowPShcebKga2Ps5HVO4l/mvJN/STtGEyoJkGZqElIB5ewqHYjkhA071a10SOZ/
	 Qs/Cjkga7t4DEvfdWPWdfceIaYv2aemoOrZ3FK2fZxkSVqEYSP3SQHh3q/N9voDEIvk0w
	 SsC8BEwa3JWi3AmPWbFVcMfUq5dER7Fi4eokvMm7qgFSCyICjLRaSTElnQgp8ggtmM2dN
	 V+V6Hit18dABs54ie5LZTKuGre5oNZ9F1YcU6zrQvqPI4O8Gf67y9rhERAhbX0Dj+Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b="hI/BGbjM";
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E6606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 05:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 926E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=hI/BGbjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1795843491; bh=5oYCRbFMD7CqQtNhkp8Ld41OqTYJeFmyZNZODXyaHwI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hI/BGbjM+nYI7KxI2Qj/b2fjOGMDy8auGLfQOkJxiS7B1Zld2UCKa7B/no3feD8PP
	 GxOEIxleCH9xXBH4hD3nBHy8NSwFWhlDZWbphv4oqcU/YY/2797zOIfekMo/6LAmDQ
	 QQmIeC1cXc2KPdHy6hDxcXuyAh+Nd0yCJY86L+dg=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id A1054600E7;
	Sat, 28 Nov 2026 05:24:51 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 00:24:25 -0500
Message-Id: <DN6LDMN4UVPP.ZUG3AO2YOIZG@lfurio.us>
Subject: Re: [PATCH] dir: do not turn blank ignore-file lines into patterns
Cc: "Junio C Hamano" <gitster@pobox.com>, "Mike Beaton"
 <mjsbeaton@gmail.com>, "Phillip Wood" <phillip.wood123@gmail.com>
To: "Aniket Gupta" <aniketgupta3001@gmail.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com> <20261106182945.1316297-1-aniketgupta3001@gmail.com>
In-Reply-To: <20261106182945.1316297-1-aniketgupta3001@gmail.com>

Hi Aniket, Mike

I've been looking into this patch as well, but have been slow to
respond, sorry.  Just a couple of thoughts below.

On Fri Nov 6, 2026 at 1:29 PM EST, Aniket Gupta wrote:
> A blank line in an ignore file matches nothing. But
> add_patterns_from_buffer() only skips a line when it is completely
> empty. A line that holds just a carriage return i.e a blank line in a
> file with CRLF line endings or just spaces, is not empty at that
> point. Once the carriage return and the trailing spaces are removed,
> what is left is an empty pattern, which matches any path that ends in
> a slash. "git check-ignore -v foo/" then names the blank line as the
> pattern that ignores foo/. Skip the line when nothing is left of it
> after trimming and add a test.

Given these two points from gitignore(5):

    - A blank line matches no files, so it can serve as a separator
      for readability.
    - Trailing spaces are ignored unless they are quoted with
      backslash ("`\`").

this definitely seems like a bug worth addressing.

Something that initially confused me while attempting to reproduce the
problem was that git-status and git-add behave correctly.  Even running
'git add some-directory/' with the trailing slash present, stages the
expected files.  I went back to the original bug report and saw that
these details were commented on.  It would be helpful to mention in the
commit log message if the problem is specific to check-ignore.

>
> Reported-by: Mike Beaton <mjsbeaton@gmail.com>
> Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
> ---
>  dir.c              | 3 ++-
>  t/t0008-ignores.sh | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index d896e7be4b..5a8a28afef 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1249,7 +1249,8 @@ int add_patterns_from_buffer(char *buf, size_t size=
,
>  			if (entry !=3D buf + i && entry[0] !=3D '#') {
>  				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
>  				trim_trailing_spaces(entry);
> -				add_pattern(entry, base, baselen, pl, lineno);
> +				if (*entry)
> +					add_pattern(entry, base, baselen, pl, lineno);

This avoids adding a pattern which becomes empty after stripping a
carriage return and any spaces.  I wonder if it is also worth fixing up
the parsing responsible for interpreting such "whitespace only" patterns
to match ".*/"?  Either way, I think this patch is an improvement as-is.

>  			}
>  			lineno++;
>  			entry =3D buf + i + 1;
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index ed95faf327..199abbcdf3 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -875,6 +875,13 @@ EOF
>  	test_must_be_empty err
>  '
> =20
> +test_expect_success 'blank lines are not patterns' '

Should this test description be more about the spelling of the
(inadvertently) ignored directory?  That might better explain the
specific check-ignore assertion that is made.

> +	mkdir blank-dir &&
> +	printf "\r\n   \n   \r\n" >blank-ignore &&
> +	test_expect_code 1 git -c core.excludesfile=3Dblank-ignore check-ignore=
 blank-dir/ >actual &&
> +	test_must_be_empty actual
> +'
> +
>  test_expect_success !MINGW 'quoting allows trailing whitespace' '
>  	rm -rf whitespace &&
>  	mkdir whitespace &&
