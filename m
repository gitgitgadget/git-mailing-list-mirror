Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3741A87
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721132483; cv=none; b=IindR8uZsfs2qx+0YNQVPNDxh7cRr+dCl1EqDOgqwNfTwynqRJ10qjfeHDbvp0GwW+mdtWWvr6ObtHSpOKTCHTqMZKCNYs9WzhARWT1wQLQggG3+IVnAnTzQvyDSOUJFvRrQk6WFsJY7jELK0wSlF8W0E6Q/TVXP2N807uwIeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721132483; c=relaxed/simple;
	bh=ZIubQHsPYkEqj5EhaEoKm9yllpo9kMerlEU3aNvtlmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2cUiQkTH+cLux5+ZpqtS+fwXZjLvIw0JAdGxsHlNasDPfmPzUMCg5CEgoARyIgTNv6o7l//Qj2/YSESE1rWIXulA34hvywg/D2CpzMNz9l+hP94OPyVng2HM7Bl0DXXxwzBQ1j71b+vZ3XhEZxW7V0cV0iAWXLOXMQ9OFhBB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4R8XaXt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4R8XaXt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc2a194750so20142125ad.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721132481; x=1721737281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWDeAt8Tt1rCcn6+PHlu6NHz0h5ZnbtBARRYEZN4cOQ=;
        b=D4R8XaXtv/v4rNkm88py/8r5pbHXkO04yKrPNBFdJ3QozV2M5w8OSW0Y2kTCVXVRo4
         SaDWHay4G03EJLkJFJ2hFqjCUrGHkNpS3orzidIvxM/aDE8pTzv129RNmx94Q1nOOkeY
         sLIH4KtUrfzMHSigC1nHhQPa+tBlQjx1L+Y8L6obhs6SJah+13LW02fL67xZMmM3+SHv
         wYXWuOTnT6z6LI7IMR7YH0iwcQ5zHciVhPg0FGZn8+8Dld5zA889C/Zy+GjKT5f5agVL
         IQhvi9DHvUAqsG8OS7jsQQnObymEGpmMsYO1Em82RtdpLuPoGYcEJRpmuTeiUW+naNG0
         HCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721132481; x=1721737281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWDeAt8Tt1rCcn6+PHlu6NHz0h5ZnbtBARRYEZN4cOQ=;
        b=wEH1hgCCHKt/jlB/00PUZmRqF1KNmSlCVamVFUt+0/rZuzi0Vud66geENBf3WEl/nl
         5lBjP84K2HCQTZvmZUz4Dw/3Q+M5LJ2JgmBVJC4PvAUhWltgG/eRbqDW4U7NN4qSJ8//
         H+jgJuE6v8Kp/hbNO0KIFcK1RGng0EJnCH6edBVRWl/7fxL1hEhUcIY/rNsqJSIsfDud
         lq2X7waXKLFv//feYvQtL8m3mLbnSY8QtXQA3SNje18mj+KT4lEQym+ECKzBT6ccJmwt
         LQGJgK6f7LDLS7J7/fbTcE3v5sILfbYZV0XC9ZgJEvoFWA1CCb0GGQDygGjN75jkdO8M
         mGfg==
X-Gm-Message-State: AOJu0Yxw16KfiCSOQI5sIed8O7YqtFlNLi2biBj1mY02lzQtJWeGXzjC
	v1zP3/ZDSk2/yIW5kYqbMF5gu+Ag+8yO5XQoNz44cvwnPZJB4VaU
X-Google-Smtp-Source: AGHT+IE6Zq8RP+9bU6bCInbCCIdb+UXoZGp7A2RztesMdeQU77ms6f5EQ0GRAZXm+8V0ww+PHr/PmQ==
X-Received: by 2002:a17:902:c947:b0:1fb:8e98:4452 with SMTP id d9443c01a7336-1fc3d9342edmr14067945ad.15.1721132480952;
        Tue, 16 Jul 2024 05:21:20 -0700 (PDT)
Received: from archP14s ([193.32.126.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4ff41sm56938545ad.272.2024.07.16.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 05:21:20 -0700 (PDT)
Date: Tue, 16 Jul 2024 13:21:12 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Matthew Hughes via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for TypeScript language
Message-ID: <20240716122112.zqauqgxmng2tk2j6@archP14s>
References: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>

On Mon, Jul 15, 2024 at 04:33:38PM +0000, Matthew Hughes via GitGitGadget wrote:
> diff --git a/userdiff.c b/userdiff.c
> index c4ebb9ff734..7247d351cde 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -333,6 +333,17 @@ PATTERNS("scheme",
>  	 "|([^][)(}{[ \t])+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>  	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
> +PATTERNS("typescript",
> +	"^[\t ]*((class|constructor|public|private|protected|function|interface)[ \t].*)$\n"
> +	// arrow funcs
> +	"^[\t ]*((const|let|var)?[^()]*)=[\t ]*\\([^()]*\\)[\t ]*.*=>.*$",
> +	/* -- */
> +	"[a-zA-Z_][a-zA-Z0-9_]*"
> +	// numeric constants
> +	"|[-+0-9.e]+|0[xX]?[0-9a-fA-F]"
> +	// operators
> +	"|[-+*/<>%&^|=!]"
> +	"|--|\\+\\+|//=?|<<=?|>>?=?"),
>  { .name = "default", .binary = -1 },
>  };
>  #undef PATTERNS
> 
> base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
> -- 
> gitgitgadget

This needs some updates. For the arrow function, definitions can cover multiple
lines e.g.:

    const bar = (
        name: string
    ) => console.log(name)

The funcname pattern should also consider the `export` keyword, since both of
the following are valid:

    export const bar = (
        name: string
    ) => console.log(name)

    export function foo() {}

Some docs: https://www.typescriptlang.org/docs/handbook/modules/reference.html#module-syntax
