Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269F86330
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738635094; cv=none; b=PgDN9Y0cl3SdqMT6BAqD/6/T1pguW/WIGCUwuuT+CsuYTI7Qx3rNm5G/MDHG5Joj3it7AxmaDPGELN0XjAPeFJ/Ucazzplt5ignxquEZtipRmjdC+U86jc05BByTtmH+uDmIDJTIuACyTE0eexjFnQBtdtnBLPcKw8L0qpKw79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738635094; c=relaxed/simple;
	bh=D7b6cP9zx9bLwB1xFlphGD/gzgEmBgdog0xMCdGKdto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvzukFXW9Tl2NDirQ+btMdloSFaGwAdC/U6eq2P1hMYAeA84AlHKh4aMahiW3VbcwpqvcSIjYEoknP5+AGW3oA9ExAy05WxquJdAuOeXOc8igEOx8R2qPGiB9SzbrWeDu4LdTZmj5+IR1xosgSjeGpB4rQ77zA207Q7JTRNMoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEod/na4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEod/na4"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so838201266b.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738635090; x=1739239890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1rymZC3hEirThXAWvVg0G3FGaceZGQRfS2T6Bxq9L8=;
        b=WEod/na4wxvMK6p+fBSAnuQOY7igtR26y5oK3W1F79Hd3hmCcDSrGyTGrJVOxWmVjV
         VDS2isuAbKOA2JG7GV3sS79IXu6NltIAeGpYSp+WnA2xCdEm7t3Ehs+TjzQ7BzHR+jMU
         ctUXIwY8CTcYOckVtYzJbVt4DJOWrDqj4pYobKTHK94p4to7ZJNTIUqO/v0Nh/q9xwaW
         4S1tl6G6MHHJETMi2y7ngPft3VMnC4vE7IFFSjDFhM+fVPf+yRsYi6mzwa+5V2NoEApa
         eiMvm15B/TYuxunk+6yfkyVxsWJQJLKtHze5wQq+S8wPQXjqFCMRgQDH8C+Tr6DZrPmr
         VimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738635090; x=1739239890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1rymZC3hEirThXAWvVg0G3FGaceZGQRfS2T6Bxq9L8=;
        b=euQz1Pt6Pp1Tj2At+6bAIbw2z8kcjAZHqxy2xIpruv0pSZ7tL2BVbg6J5vjBLai/kP
         Hw4VpSAmLKX2hBLs8u+Ha7fSLWgocR3AMxcjii4jyLas1dFx/u1s79mkjPEDFR08OGZW
         sZYhUivlHRSbCHpMiGj695NWOFNR6lp/2z5ERoaLijrADyOj1w05/2aGCGANiVUtBNvP
         WdVNyERSaN9NUo+gV1N8FP9C2IjLl0UT81xEHa3FkrW/C2ANtvbmeT7UDKkdsJE8aJ7D
         1Y7cXmfoo8o/W1Nien2L9Qpeghr3Xr7ODwOgbFLDVeuB8VuNWLbCX5pUC7qbsw3VssMq
         9EBA==
X-Gm-Message-State: AOJu0YyPjU+03nHV1tQDED4eGV4/W8ULG1QkAuumlcgtp+5ngVzioyEK
	YnTSVjWK/Wgxufb9g/DJ5Ufg4vrKSMLQ7h8Z8wcgSnvyyqBVoQGh/9xIkk/HHza1wxPRWvZATN1
	brd0VmwwNJHbbzY8PMwk00Wyzry4=
X-Gm-Gg: ASbGncuwyhdpJAw8dA2ccbxxMg5cwF0W+RgCS4OYupaI6RR/jPBZ4cdcfBbXG+zp46Y
	DclGV12sZ+lNKesDVv2UdBNWkG9qCOIJ+NuqX4pEyK5SzAkh3ZWZtoIp+xloBMms97JL4Gruvt6
	krQRKUPUdRYCtVwjYOvBFZOThD9FY=
X-Google-Smtp-Source: AGHT+IFCLWj2M2zw8Qz+9nD7p9e+uUd7bpdqku117lo+I5qyhIZv8bjrdP2nBAfi8RlqxRGNinccmQDJC2J6AkiEP90=
X-Received: by 2002:a17:907:728c:b0:ab3:a190:6cb2 with SMTP id
 a640c23a62f3a-ab6cfd05a5cmr2621798666b.25.1738635090451; Mon, 03 Feb 2025
 18:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
In-Reply-To: <20250204014652.3509928-1-sandals@crustytoothpaste.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 3 Feb 2025 21:11:19 -0500
X-Gm-Features: AWEUYZnw36sZJOqmpJ6LQk1P-MSel_bKv9qKzIx_9gPCEC65XBDCfTA9tLa9Dk0
Message-ID: <CALnO6CAib-p1+1VHMfqo4VGLVvWs63z_xCjkCANJS-NLK5FpdQ@mail.gmail.com>
Subject: Re: [PATCH] thunderbird-patch-inline: avoid bashism
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 8:55=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> The use of "echo -e" is not portable and not specified by POSIX.  dash
> does not support any options except "-n", and so this script will not
> work on operating systems which use that as /bin/sh.
>
> Fortunately, the solution is easy: switch to printf(1), which is
> specified by POSIX and allows the escape sequences we want to use.  This
> will allow the script to work with any POSIX shell.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  contrib/thunderbird-patch-inline/appp.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I noticed this in Debian bug 772238[0], while looking for any bug
> reports that I might be able to fix.  It was reported in 2014 and has
> gone unfixed since then, so possibly this script is seeing relatively
> little use on Debian and Ubuntu.
>
> I have not CC'd any of the authors because nobody's touched this in over
> 9 years and none of those people are still active.
>
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D772238
>
> diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunderbi=
rd-patch-inline/appp.sh
> index 1053872eea..c55c2caa41 100755
> --- a/contrib/thunderbird-patch-inline/appp.sh
> +++ b/contrib/thunderbird-patch-inline/appp.sh
> @@ -31,7 +31,7 @@ BODY=3D$(sed -e "1,/${SEP}/d" $1)
>  CMT_MSG=3D$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
>  DIFF=3D$(sed -e '1,/^---$/d' "${PATCH}")
>
> -CCS=3D$(echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp'=
 \
> +CCS=3D$(printf '%s\n%s' "$CMT_MSG" "$HEADERS" | sed -n -e 's/^Cc: \(.*\)=
$/\1,/gp' \

Looks obviously correct to me (I once wrote POSIX-compatible echos
just to see how hard it was [1]), though I find it interesting that
`sed` can process input lacking a final newline.

>         -e 's/^Signed-off-by: \(.*\)/\1,/gp')
>
>  echo "$SUBJECT" > $1
>

[1]: https://github.com/benknoble/echocho

--=20
D. Ben Knoble
