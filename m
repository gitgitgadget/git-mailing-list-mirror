Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBE19479
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380591; cv=none; b=jeV4pvY9RmAFGsNXevoCzV9aVffgM7pcj1QBe4r+qTZ7QTG7f0fX/koHHDGcLSzvsMZKmDcsQp+AQboOCZeEJKW1zcvGarqb+ZF4cEECLQS3u9FJOkee+BLFEo7cD8nOxm85K5lMqFcBmqLYTo8C3YuSLFrYFyiLu6uNvPyeplE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380591; c=relaxed/simple;
	bh=7rEFb6/07ivibav8QPFlP7af2b+SsC7VVplv5fQzDxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EskkVbeNVsijfHbqpdf8f3w+JmzBK4zdyx3UZZ0Ty8gMF82NtRljO/df5bHQqLUr0fLHKB8Gyl2saAX5HQNP30wMH5FqSXWxZyCw8dXQYWYWJRGrevbyWr6LWFJyCmcfkWBr9cphCiKsXXDdrZsBnzCsgIcc8V94RDeBvooetwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-696315c9da5so19264666d6.2
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 22:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712380588; x=1712985388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoTfGtldp0oZLH4tWOMrOEsAk8O8Uw43f19ubBFvboA=;
        b=JenHLwZXg6zMjrflmgANqjYwNmdsxKfzxZmVVjcf8AitMYQ5rXzbEnqHbiSSrA276j
         +Zn6TYc/8iNCrk3+S90XH0QpTgQszxq60txotX5NWTWiL3jh4j8vn32XL/YIHefRgzsA
         EfJaxlKgHHqAgXzchW8YHxvzNo380bhp/NR0Y6GcQubhjUld8qLgpzQIaJFRP80JhbZu
         A+l0w36iODKSQKkMBCOXVkYS14OJLB5h/jMdcNFGoghUP7d3w7yjnDlx70YF8Pdyp34E
         3OgbLeOQ9+vy06aZ5t/rjTIo2MWm4rIFbuSNiLE6Gdy4JVsi3cssOl6mUW2uLuU3+K7r
         pVlA==
X-Gm-Message-State: AOJu0YxcGGQbz0TjAHBiEVd1lqjaaedlhGsbihJQIRcOot+ZKsPqX+1l
	4nX0UYqZ31sVRwK8/l2N+FMZEk0k2jaLOcPVJ6l0VoDPbj7qhnwptVGZJYMb5ea5xaN5YoUxnmS
	kYyvV8aK3/GS9ocK2P0T9JCajmDs=
X-Google-Smtp-Source: AGHT+IFen8XV8HdoVje8lJaI3b45LjqE8h6y/fru/qGLBPZxHPciEY9yt4WuG67A+4pSPcKBPqD+8spePa6F4WOwj0Y=
X-Received: by 2002:a05:6214:2629:b0:690:d21c:abe1 with SMTP id
 gv9-20020a056214262900b00690d21cabe1mr3563073qvb.62.1712380588543; Fri, 05
 Apr 2024 22:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406000902.3082301-1-gitster@pobox.com> <20240406000902.3082301-3-gitster@pobox.com>
In-Reply-To: <20240406000902.3082301-3-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Apr 2024 01:16:17 -0400
Message-ID: <CAPig+cR8HxO5ZeZrJQ4PtpgsqM__cvieZ6g37F1m_=ng6xvSPA@mail.gmail.com>
Subject: Re: [PATCH 2/6] CodingGuidelines: quote assigned value in 'local var=$val'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Dash bug https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
> lets the shell erroneously perform field splitting on the expansion
> of a command substitution during declaration of a local or an extern
> variable.
>
> The explanation was stolen from ebee5580 (parallel-checkout: avoid
> dash local bug in tests, 2021-06-06).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -194,6 +194,20 @@ For shell scripts specifically (not exhaustive):
> + - Some versions of dash have broken variable assignment when prefixed
> +   with "local", "export", and "readonly", in that the value to be
> +   assigned goes through field splitting at $IFS unless quoted.
> +
> +   DO NOT write:
> +
> +     local variable=3D$value           ;# wrong
> +     local variable=3D$(command args)  ;# wrong
> +
> +   and instead write:
> +
> +     local variable=3D"$value"
> +     local variable=3D"$(command args)"
> +

Every other example in the shell-script section of this document is
written like this:

    (incorrect)
    local variable=3D$value
    local variable=3D$(command args)

    (correct)
    local variable=3D"$value"
    local variable=3D"$(command args)"

Should this patch follow suit for consistency?
