Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B42BAFC
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710997901; cv=none; b=uRvJanlFrvy2GjOtQVwN88QuehmsFZMxb3uBU7kRYcg9NbkXoiPofjhwWpdlAI4WFbJ1bzwnu3l/lnG5/dtJ6jkAXR9SQEIP5jU/D3EQpXnSFX1aA4ioFu9GNt2Pe54OPvVWUkpgpDJUXmQy9SCi3b5Ps/0KBKMrXTjLu4yIhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710997901; c=relaxed/simple;
	bh=KZvV8xuByHL0rIDmLZctuJfHpGf1cSCFinaZdlGA/Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMb0uD1EE0DMBJ/PchCcbRXfkSr8ABrTsys1bJQ7ESqdapEFhJEiP9TBGILLpvKJGADBAoJBRa4zszeN2xd3kGK9XW59AgFDfV8+mHUpH1i2dNl/md29iFZ3FCKhXolL5JzDx+QwgrDmBfiGDRSrDENdDmfG/DvaFH/keTGCfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68f41af71ebso5394676d6.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710997898; x=1711602698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ8MGBtG8ozjYl6R9OFUGBdH2yeFcahoeREocHtjsOg=;
        b=T2bomhlkqLo89nitHHSg8zHSRezz+QZxXjGEC/UgfhE71//WNi4cigL+vKm5UVLtXg
         5ykr+qIv6mRBO5fEmFxZ4d2TGDQ7pzNZHNWBSMBN7xLyGFwUG5Gz7LIxxmEh/hT+aUHC
         uGDC0f+zxHnSCRU793z4qXkArEd7jQEXOZplxW5uzd/bSVCJBd4+8VuZQ0Ndsv8qq4Wt
         4fBpe/9CDgpxyRNMsBVnBMRSMRYYDI8+TbIzabmInUUeOVxfOWdOah+a0WXM+dk0fYab
         d+ciEQ4QyhkEkDGpZs+AYC9MzyLHPuCwvq9MJjyGs81iDI0YhaMEDKqT9gHCQGX3bYAI
         urAw==
X-Gm-Message-State: AOJu0Ywm6uLYgOeeBGhxlHKDBqotG5IiRDYghO39E1R//VdOi3nf41mB
	2dUY4iZzRiYAtNtYGyBTiQN6l8RI+0EnqXxEFQBd6MTnWn3Kv00LpOL4HqmRLjnCdL+HemPJoEn
	BTywGKZ31XxIdUVdgRlDvk+ae4tg=
X-Google-Smtp-Source: AGHT+IEMNWOhIxeGHLM4DjzY/PuJut7WRHW1oEYg8hbeH7YME0peF6V8gkf+IMXp+lnbYXB1mH1DbYCFP7MMetdCOnY=
X-Received: by 2002:a05:6214:5494:b0:696:42df:a4b5 with SMTP id
 lg20-20020a056214549400b0069642dfa4b5mr4383456qvb.38.1710997897870; Wed, 20
 Mar 2024 22:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710994548.git.dsimic@manjaro.org> <f84c5e8e4a90be3f9fe3cc853e0d40aed4e58826.1710994548.git.dsimic@manjaro.org>
In-Reply-To: <f84c5e8e4a90be3f9fe3cc853e0d40aed4e58826.1710994548.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 21 Mar 2024 01:11:26 -0400
Message-ID: <CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] config.txt: describe handling of whitespace further
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:17=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
> Make it more clear what the whitespace characters are in the context of g=
it
> configuration files, and significantly improve the description of the lea=
ding
> and trailing whitespace handling, especially how it works out together wi=
th
> the presence of inline comments.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -63,13 +64,15 @@ the variable is the boolean "true").
>  A line that defines a value can be continued to the next line by
> +ending it with a `\`; the backslash and the end-of-line are stripped.
> +Leading whitespace characters before 'name =3D' are discarded.
> +The portion of the line after the first comment character, including
> +the comment character itself, is discarded.  Unless enclosed in double
> +quotation marks (`"`), any leading or trailing whitespace characters
> +surrounding 'value' are discarded.  Internal whitespace characters
> +within 'value' are retained verbatim.

I find this statement confusing and ambiguous:

    Unless enclosed in double quotation marks (`"`), any leading or
    trailing whitespace characters surrounding 'value' are discarded.

since it might imply that the shown <SP> and <TAB> whitespace is
retained outside the quotes, as well:

    key =3D<SP><TAB>" string "<SP>

It should be possible to rephrase it to be more definite, while
dropping the final sentence altogether. Perhaps:

    Whitespace surrounding `name`, `=3D` and `value` is ignored. If
    `value` is surrounding by double quotation marks (`"`), all
    characters within the quoted string are retained verbatim,
    including whitespace. Comments starting with either `#` or `;` and
    extending to the end of line are discarded. A line that defines a
    value can be continued to the next line by ending it with a `\`;
    the backslash and the end-of-line are stripped.
