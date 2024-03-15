Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952445A0F0
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544253; cv=none; b=uSqIHK3F7WVAeSWjJaWlHqsq9FJf88Id2p/1GiU4YQut0I8hvvLU50LRvdputYdXtErcaB5h5qquOZLdp5quhi05xVWt0twXL6GHtNI9a8syG9ClIqTcVRouUjXST6eq55fR2mDSAuyYFi8yU9QPs7Y1gQD0MTYR6U8fP7htxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544253; c=relaxed/simple;
	bh=iHqf6opeQXRREfMKvtprttp/cIyTKSt7R3/fCqSzmnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUYjuXC6Wy9iWfRdz8J5dLeg+E2xQycEBwHN2JjYNFwevQVF4conR2bohzsN9mUN6naV02FQLC3cNgNYF0NX/yREZdD8IJKyz6nZ7OSIW35Fx2ysULPV8PrTfZoeB0LcsreK/b28Jtg1+EXY2l8CSmSnSA4di8M+OpuEEqlUIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c213690558so1306942b6e.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 16:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710544248; x=1711149048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7auyZ3YqI2A6njZ6lCEVo6kqgAvzm+lO0SFT4pT4dag=;
        b=QXmmK58zIVTw+itMO7CNByugTasCRch2UR+Vga8KbB/GRJg+fONL2pxkNs+hW3peus
         mOoEjBPrxYFMpUyiRYAmNdtdDAauvAo2D+uAJVvDRORSJ44NiG5EG4OuA4ZI7IXcs/Z7
         C1IXY8JoNlwFQM9ye5yjNkszBEh97aLfGCbEb26x+T611Jkjg7rFGO0RjZB8BMoq119D
         mq6LnhTNQXK+Ru7uzTF+Ja62ha+VtwjyFMmtmvpeHwRenr6f4+c1p+OvBmx0NI437u2T
         Z3VLYxj1B4Pb8rnOM2Eq5njb+tRafqhNeXPYbtogurel3FOVJaz+X83j/6ND/wTIQFFy
         +kCg==
X-Forwarded-Encrypted: i=1; AJvYcCU5rtYhWH5KBFaZsymdTkcTmsD87tHBACxr1hrMCaXmbqnA+Rd42HZFxSQ80dwD6084R+e5/QRz/7XlMngdF901TO+d
X-Gm-Message-State: AOJu0Yx+vdztjjO6WLazXOwlydQAymkX87iPsue+PEabG4KxnJ50nRYH
	hlE4EIO4mUET5cuurE3f58znjtm+GkDdoxLVC1o5pbL0vY7Otv2kvUM/JXywbei7EjvTJbpJnAI
	x432soqmzjaoEYSrCfpmC+atqgZ4=
X-Google-Smtp-Source: AGHT+IFQ5/4HoQCbL1oaE5s7YQ2pL1g6ebCLP+znFMQibX4YwyvCZvMBaC5p496qJB8f5M3BXreBB0n4hvAfJI9AyfA=
X-Received: by 2002:a05:6808:f0a:b0:3c3:69a2:4248 with SMTP id
 m10-20020a0568080f0a00b003c369a24248mr6096035oiw.28.1710544248652; Fri, 15
 Mar 2024 16:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <pull.1681.v3.git.1710280020508.gitgitgadget@gmail.com> <xmqq8r2jp2eq.fsf@gitster.g>
In-Reply-To: <xmqq8r2jp2eq.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 15 Mar 2024 19:10:37 -0400
Message-ID: <CAPig+cQwWu=FA4vnKK9+aLkTzAzMXp6h5aJedEh3FT+1bNTjAQ@mail.gmail.com>
Subject: Re: [PATCH v3] config: add --comment option to add a comment
To: Junio C Hamano <gitster@pobox.com>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, rsbecker@nexbridge.com, 
	Dragan Simic <dsimic@manjaro.org>, Chris Torek <chris.torek@gmail.com>, 
	Ralph Seichter <github@seichter.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 6:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> ---comment <value>::
> -       Append a comment to new or modified lines. A '#' character will b=
e
> -       unconditionally prepended to the value. The value must not contai=
n
> -       linefeed characters (no multi-line comments are permitted).
> +--comment <message>::
> +       Append a comment at the end of new or modified lines.
> +       Unless _<message>_ begins with "#", a string "# " (hash
> +       followed by a space) is prepended to it. The _<message>_ must not
> +       contain linefeed characters (no multi-line comments are permitted=
).

In an earlier review, you wrote about the potential difficulties and
issues surrounding comments other than the simple "inline" comments
tackled by this patch. Do we foresee a future in which git-config may
be extended to handle automation of comments other than inline? If so,
do we really want to lock ourselves into having the generic option
`--comment=3D<message>` be restricted to only inline comments? Or would
it be better to plan for the future by instead having some sort of
annotation which indicates that we are requesting (or dealing with)
only inline comments, such as `--inline-comment=3D<message>` or
`--comment=3Dinline:<message>`?
