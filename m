Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DE27702
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784813; cv=none; b=eCOLwdI4VkFhSrorVhp7pKNRB0LkT7gUsiTm5u9PUCQE4MGypzIXWw/rccLoFQjCXWr/+A+P6AYBdxfOQvgmqDcRV/auhUZWMOjsELZffRZA1UKnpoBFriE66zh9y0fezADZCPWeQGd2l8lYNWA0rd0SKdOcrQ/N+5q9tN+w+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784813; c=relaxed/simple;
	bh=BHxJVpp/eShKfLBNOtoRo/9drHIW11yDoGGzSQTT0M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4nlAbveM6T9Et/WZ2Qod1DW129zV82+WcuLPWv8oVA8dKT+1gPWzf+PBBDLkNnTUvvgoELLUTVZS5GMdIGjIKwSW+vb/Nfc3v7spk4DEKlhguWFn3HoHEPX6giEbVlEf5LclwKNnGZX3pPR+YZPp+wVpt+ZNL0HfJDmHr6xdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqVknTMj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqVknTMj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso15780055e9.2
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743784810; x=1744389610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVzWOJe6GdbJkggo62YONpIEZPD511gu8q/aML1m1t8=;
        b=YqVknTMjw/xuPx6Sd0xTkmwR/J32o8cF8WubH+ej9t3/FcfRzVmYzgK4K7IGlwgx6O
         NnyksUcYPWB3dgfvLzmtDQKn63WMXSSmykXw3JEu0kFYMnfqmFDf3Bvb+8UtzTOqOhe4
         Vx2tRermjg5Jw9XwkUfqqQbL2+WTct1oTf/15WdzJowJheMrCEsF8/Nx9y55WGUkuZKw
         vVevemvOtMS2XgEQc8QGmDXPDvx3xhBL1Szsev2N6cXmQ59lW/L0HsgeqrgrLklRbJhi
         d3LlruwNT9SlDLCXVt43UNd96uxoOdY84AkolVggzm4L+J7DFCnG88bAjHycG4N0g4pF
         eB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743784810; x=1744389610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVzWOJe6GdbJkggo62YONpIEZPD511gu8q/aML1m1t8=;
        b=NgEY2riB9p22MuyGn2zCBgV1OU2C9wWotZUYY8GZvOYWQGAp/JoiMvvQbnDgjB6bcT
         s9ZfFsbWV8nL5pK22dTl3G21cPTzDOYDHhqhrLXhwVnClKOWeu7DfOmVFS2xHAbIWYnC
         drNbVK8V3KOXpvTfIOarlyjT6sfIYujry+AdGgQxfh38Vy1iURY/ZZT9Hoq2tPk09q2J
         VSyyb0qpw54bxRVu/uGC2zPWlTO7mC7EoUjvF7FqYnG4kPDgdr6IcpsUEPSHN/Yp5Tgn
         xVx4K6Y5bXfoiSXNZ1futAYcpDiFV6LoFPA7DmeLETwurcLIq054Wh7asury/leEZeoy
         Vydg==
X-Gm-Message-State: AOJu0YxkbEpz9n+SC6IznrPswyjQVyKjLYYeG92iO/H6bd8OkU2drO2H
	/GyKNYHRkyTvshhyeNVDl/lIQA3zzV6zg6LyDvOoDEpbn2efWKvVqlvMAbnNyIOLo6zT6jngODC
	XI7OKRSODZNrIc3WdL6iopadOVqmktg==
X-Gm-Gg: ASbGncuTZAdh9lzwP5ZvP9s24qNPUmkftnWVr1hSiNlqMy/1DRUnSDc/irzNAyKNiwM
	sL5DuafKgg/hlWKIND5vLlfraqCdevSEEdFQuPzR/OgbGks95Ugk1ndXAQS7hysfBZuQgO8GDLM
	bM8/KuumVony192TYDf3zcv2P4b1s=
X-Google-Smtp-Source: AGHT+IF5LFHaWaU96XfSA5+XEiGZADNw6fsO80uaYwFnsP5KwXSwtW8HvqFu8y0302dOBoMiJSZ7msVJlX/IOsmeCfk=
X-Received: by 2002:a05:6000:4210:b0:390:e1c5:fe2 with SMTP id
 ffacd0b85a97d-39cba975cb2mr2799186f8f.38.1743784809769; Fri, 04 Apr 2025
 09:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com> <6206e65ac4d50e174ad7e3dbafaa590b632f214b.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <6206e65ac4d50e174ad7e3dbafaa590b632f214b.1743354964.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 4 Apr 2025 18:39:56 +0200
X-Gm-Features: ATxdqUG309NDqAezS7btKCBB4Q54oXfa4Z5hAr4snwJpUu38Mb07NfuE5y8E-qQ
Message-ID: <CAN0heSrfQMZ8=pFNuaqn_0bpLxhMtGiO8Vg2hXTo6aqq3rF4yQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] doc: fix synopsis analysis logic
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Mar 2025 at 19:16, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The synopsis analysis logic was not able to handle backslashes and stars
> which are used in the synopsis of the git-rm command. This patch fixes th=
e
> issue by updating the regular expression used to match the keywords.

> --- a/Documentation/asciidoctor-extensions.rb.in
> +++ b/Documentation/asciidoctor-extensions.rb.in
> @@ -50,7 +50,7 @@ module Git
>        def process parent, reader, attrs
>          outlines =3D reader.lines.map do |l|
>            l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
> -           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=3D~@,/_^\$]+)}, '\1{em=
pty}`\2`{empty}')
> +           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=3D~@,/_^\$\\\*]+)}, '\=
1{empty}`\2`{empty}')
>             .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
>             .gsub(']', ']{empty}')
>          end
> @@ -72,7 +72,7 @@ module Git
>            %(<inlineequation><alt><![CDATA[#{equation =3D node.text}]]></=
alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
>          elsif type =3D=3D :monospaced
>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2'=
)
> -              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,/_=
^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
> +              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,/_=
^\$\\\*]+\.{0,2})+)}, '\1<literal>\2</literal>')
>                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>=
')
>          else
>            open, close, supports_phrase =3D QUOTE_TAGS[type]
> @@ -100,7 +100,7 @@ module Git
>        def convert_inline_quoted node
>          if node.type =3D=3D :monospaced
>            node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
> -              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,/_=
^\$]+\.{0,2})+)}, '\1<code>\2</code>')
> +              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=3D~@,/_=
^\$\\\*]+\.{0,2})+)}, '\1<code>\2</code>')
>                .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')

This seems to introduce some extra spacing in the rendered man pages, e.g.,
"The bundle.*  keys" or "Fileglobs (e.g.  *.c)". (Asciidoctor 2.0.18.) I
haven't dug into the regexes so see what might be the cause.

(I only had time to have a look at the first patch, then briefly trying out
this one.)


Martin
