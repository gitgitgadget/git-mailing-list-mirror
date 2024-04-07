Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345476FC3
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712455515; cv=none; b=VZgNfXz+qvvXBBPopHDasfadph+EbuTJ9G5uX0SefXOtEPjoVunBkKVgBZlH4kwNh4rWRd6UPO3Y/ZD/MsNO/rGqlgHfhEOWukGIOF9dpDt04UjnLeVXqPQ08fY4DLnMou7k65JUrP5WT1CljI1usao9aSpHOR0ICl30F/hDjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712455515; c=relaxed/simple;
	bh=8IYQCf62qy2KIPbHwInTpjnYD4sLhHhunuHsULhT8d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2HA4oIh5LyRfPZP+s75AcB7fViDeWyyDRVDtH63HC1ck3XRZTQf8hEr2RM2H6tVwCThS26Sc+npzrUYYn10TObVIDhZequ9RmWd/7jfMYAErYrZvLOS/jS3vbSbujZM3pf67cJrbWCTafBh9xkuLMLkXGv4n/N1HJuhPzFcXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b10ead8f5so2552816d6.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 19:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712455512; x=1713060312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqXBkiYwM7CL4LQFYzodgI7gEeUUiMhIplu0n4axg0w=;
        b=wwrzED8RzbceP7sRq5fIc/eGaRzPUJ0kzyBFoHSP2Rd4Frbg89AlJqhH8w25BwycPc
         NyN2e7d3/coI2XrBEO5v2wAORG9lyRtNEXsDweq4HGekBq9tg+Zu4jG+b5vM2owyGBfZ
         SaJhOjMcjUiw4qTNYRwZ520d5APUXRQmQLyP8v3TZqW8CfaSSCEwneellbvW75K3swbR
         vevKU+M8SWfrXuMY900lesErqSXDTIVTQIXyTFc5QFoYy7Q3VfxvStu5EOaK68fE30Ui
         H5N5UtA3wijzkOa2UCr4S/ppXDFCv59aI0Rk6AjORTSckmWbw79Yf5A8zNsDCe2ledc8
         0xpw==
X-Forwarded-Encrypted: i=1; AJvYcCXSsGyPYUhi5psN4flRrwWmrSws4Lv9NqqxlDucl51sUc3eK8HcOnq1VPRUrvJM/hYLnEtUovd7KzTPgjsLGjBxbr1d
X-Gm-Message-State: AOJu0YweFa8MyyF82V+rde2aYRRRtPAalB/oOimHd0C7Qs2iZA13cElB
	cYYrDt+1w6atXDIttGIqgCSOnND9yUESjwlhMyHBfNfV0IRM4kFX6odIgxZK0BlYXC2PSkuM9Ov
	Suf9TdNSOMHjRpP52ZLsuOGku2n94hhgy+HE=
X-Google-Smtp-Source: AGHT+IGlhNoEyiz8es15MNSyLhfVySnfyBg4DnUSbsRwstB/dBGD2DrMbXS9mhytFk4h2uUN6qYqvOknzNmNm8qZiE0=
X-Received: by 2002:a05:6214:5293:b0:699:2523:65a9 with SMTP id
 kj19-20020a056214529300b00699252365a9mr6069993qvb.3.1712455512083; Sat, 06
 Apr 2024 19:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407005656.GA436890@coredump.intra.peff.net> <20240407010228.GF868358@coredump.intra.peff.net>
In-Reply-To: <20240407010228.GF868358@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Apr 2024 22:05:00 -0400
Message-ID: <CAPig+cST40pM5PdGA==o8aGFwv8kStzzC8=28NULUtV8OFJmLg@mail.gmail.com>
Subject: Re: [PATCH 06/11] config: use git_config_string() in easy cases
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:02=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> config: use git_config_string() in easy cases

Did you instead mean?

    config: use git_config_string_dup() in easy cases

> (like the one above), we can easily convert them to use a variant of the
> helper that frees the existing value before writing over it. That works
> because free(NULL) is a noop. What we can't change, though, is cases
> where the pointer is initialized to a string literal, like:

Fun historical (historic?) fact: On NeXTSTEP operating system,
free(NULL) and realloc(NULL,n) would crash the program, so getting
non-native (open-source) code to run correctly often involved more
than a little effort..

>   const char *foo =3D "some string literal";
>
> In that case it would be incorrect to free() the original value. Those
> cases will take more refactoring to make them leak-free, and this patch
> punts on that for now.
>
> In each case we switch the underlying variable from "const char *" to
> "char *" to indicate that it will always point to allocated memory (and
> our git_config_string_dup() interface enforces this).
>
> Signed-off-by: Jeff King <peff@peff.net>
