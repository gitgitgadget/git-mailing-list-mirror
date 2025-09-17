Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11997242D6E
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092185; cv=none; b=hadE3cdET6ZNQj4Kd0C1Mm3jrV0dQz11K3vhkWrlgg0wHeOb+ay4wmSGX6WU5s6fjr3PGFhbtNRf6y7vINUBRA+V+G2gKP7X2z39KX9lRIiDhLheC3eX3lTaSFitdURSgH1mbVR4yybnMJ5EYFBYtOVZ2uAgUxzbO69/Ae4X+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092185; c=relaxed/simple;
	bh=PE1j5dIqqPUHga8Fvu/D/p5UpQlqpK8PDXPBumR7mqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUkEQKdQziUfzszSaXxjQO0Bylxbm/47D38LhAMhL39nExht3Cuo5bD3wN9c+ZW9eqPE6B5a1vRAVj36EVFm/FXzqiJ1E5v0cpMSigrLsvxuNqvguWZql3thCvd6w5/CbZNTyKUch1jFQFp3yefnBYFvbOFe8I87bR8+59AI28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b78f4aa547so11400401cf.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 23:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092182; x=1758696982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAxt83HvQGHmvItBwY2cdPZdZR63i9LbPKdyG7luQt8=;
        b=A8fRD8F+OdyO+bLRWybqgycvFIrWL13R9sKpP7OyEOnPug9XrcqtUtaUhejdLiUHyE
         taLJ3X+XLDiOUmEl4yJ0XE1cCsvdTE+zTV+tFuBABXol9VLXUNbeSlL+iBsHXuPn5oS7
         k4ff1AX/vSPd9mqE7dAHyD/kmzTiiG0hUvlbQ/6czNydlVTuWqn2t3SGOaL3O7in0QH4
         RupfDslAmD3OewfKcszpRewGxUBanQ+D13l65RjIAE1xAbt3G0s9Li7uSyYvrbW+8njW
         6iNo/KKXGn8m1V1+CEM6k60NFKHWzGfUDU15QXyFi2evp/Ds6Gb6BwQ46UVqwN7CzPYo
         DuAw==
X-Gm-Message-State: AOJu0YypZv6FgYEFR7h2lptAJn13uUMO/IDb9qgNkU1xUn2chOneqXHU
	CEulFAPBpC005lyZIDaDoVmk6bg3l5Q23RNzoM+y4imJCtwYwurDnOT7/oNGz4dnFCy6xyQlTBx
	Ph/IMnUCZjr7epcKy5QVPgVg4AVKNaIE=
X-Gm-Gg: ASbGncsAvm68av52AU3bY8iELiQi/RiKtR6sV+GtrNS+X0yrPmW+zzv2k5LO/aV8+sd
	JBUrn6wo4O9GzFBDB4cus5YY0lOTOVCKwSdAwhPf/hVoPAEwpnFn9bcOzFnCTgPftBZwdkS7FL0
	WST+0eAIaVUmlz2r2y54MbzNVkf3yxQLLAg9ty4XUds+UEWgvyeube8WRiMIU0TlyPAKkWss6Ri
	+vhYCcDX0WLIOhBoJ+3V0giRh3hUtfwlgIsr1uU
X-Google-Smtp-Source: AGHT+IEl1hGZecrXV1VwF18sjZkujf4v+wahBTJbuDVucuSOop9y8yIGiKg1mW+BGtwVpTsj8DFeyIV8hkwfLrtPJLM=
X-Received: by 2002:a05:6214:262b:b0:78b:684e:88ab with SMTP id
 6a1803df08f44-78ecc72a478mr5723206d6.2.1758092181728; Tue, 16 Sep 2025
 23:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175809074627.1696783.67425889158412786@noble.neil.brown.name>
In-Reply-To: <175809074627.1696783.67425889158412786@noble.neil.brown.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 02:56:10 -0400
X-Gm-Features: AS18NWDGld9Rwxz3uSZ85uFsGIhun3wyafr3oiMB3YbdYvLU4XmcDaAF2F00Tvw
Message-ID: <CAPig+cSZ5aazWp9vacw7FBX4-b+PAKwRY-WfJL2HhjLOA3NUiw@mail.gmail.com>
Subject: Re: [PATCH] send-email: don't duplicate Reply-to: in intro message
To: NeilBrown <neil@brown.name>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:33=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
> If I run
>
>   git send-email --compose --reply-to 'ME <my@address.net>' .....
>
> and edit the intro message, then it will get two copies of the Reply-To
> field.  gmail.com rejects such messages.
>
> This happens because send-email reads the edited message examining the
> headers.  For recognised headers the content is extract to use in
> constructing the final message and for possible inclusion in the patch
> emails.  Unrecognised headers are gathered (in @xh) to be passed though
> uninterpreted.

s/extract/extracted/
s/though/through/

> Unfortunately "Reply-To" is not recognised in this process so it is
> added to @xh as an uninterpreted header, but also generated from the
> $reply_to variable in gen_header(), resulting in two copies
>
> So:
>
> Add parsing to the loop in pre_process_file() to recognise a Reply-to
> header and to store the result in $reply_to.  This means that the
> intro message will not get a second header and also means that
> any changes made to the Reply-To header during editing will be
> incorporated in the $reply_to variable and so included in all the
> generated email messages.
>
> Signed-off-by: NeilBrown <neil@brown.name>
