Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981491757E
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723420595; cv=none; b=Crt+oqOMSdUecZGTCWFaXQWMn4zcXxYU03KkMWOuzjqeJn7dx7UFaHbcIBjkcD0vKS5m5wEG4Kg+taTCIqrkQV0WY9RQwpxZAIrhq0IxVp5TcgEYGY3HRHg2UltmalTzAfbqYdptgvyAmQmYEQpNHkjK9nGXEleTSsNKQ8C8bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723420595; c=relaxed/simple;
	bh=yKEwf1OMN8CG9mE931gNv9BTGLRluaoMuuTBTgZSKUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHpyXc59fFZCoDMTusVP9g+IT1sfWfEGrTxLCU6QIjbmrF99YnVh7/chPMtGekChomsTnXrAzy0RbgeCUx6PlFTvAWV1H1hkCTLAHzrgc+PiHgDhTw5HLdxFI43qxfVVummy//K6ruVqkTrSiKxn5NzHYTFfLe6QqG5T0lq7ddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so1273066241.2
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 16:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723420592; x=1724025392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1IA6I+9ZT8/KrjWhizjPqoN+bmdLEOimFLQj/SXR/Y=;
        b=eCuFBgN6aB/UHofA7nXLh9YVCuJACtFW4ZFaBbj0iDVKDGCROsUMmWd+D/5l6/8pqD
         ReUxCCmAnv6nAlIPiRrS7SMAMNobQhIiQkq5xOkqnpsBOu7YmbarJ2wyPNyeGs8mt6qr
         Dh4WPYuuRgjIBVZcrzCzSbEKGxpZL/7k5VnOOqMq/Ro46NUJBCg5/2TOl+itCV6zJUFs
         eI/zeqjYk2QKfhmrJjYCsZOwK9K4aCsfUXtXkD7bH5E2t0Offp4gF8JhZPY7AxkN5/wU
         KDpgJCZl4lxqkLxrlxThRZD79KUmrDVIbJSJcXwCXysx9gXu5yVvlf7QJ8cGBrXOX4h5
         HL7Q==
X-Gm-Message-State: AOJu0YyP9IW26tX5sK5HmuqKCAPsKLMcyQX/odRubXjF9XrG6a2YScGj
	1rogK9kJNGS/T41Imdtt/bhXc/HLr3kIJ06Rq1jgwFkRLqhIMGo0wekDYEeM3bovI9+pHdMpxyP
	VQ/ZMcoGvGAOdgqFV3Gviq3RkOHnhCg==
X-Google-Smtp-Source: AGHT+IHRYi64I5Gzf7ZmoUL0l5nPdcKMHWveDXfpnDg/wOJz3qcGTSPDkt41zLeUtyXkIkWnTkt5mz/FlEBR84BHSSY=
X-Received: by 2002:a05:6102:54a6:b0:492:9e3a:9f48 with SMTP id
 ada2fe7eead31-495d83cd655mr7905370137.2.1723420592388; Sun, 11 Aug 2024
 16:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
 <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com> <92f3121cf4e719d1bd6f85e3af454a3ea7547930.1723389612.git.gitgitgadget@gmail.com>
In-Reply-To: <92f3121cf4e719d1bd6f85e3af454a3ea7547930.1723389612.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 11 Aug 2024 19:56:21 -0400
Message-ID: <CAPig+cSGeExca0d=o0jewFERTx30+EgR5HccTO_gOsKtnXxuwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] doc: update the guidelines to reflect the current
 formatting rules
To: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 11:20=E2=80=AFAM Jean-No=C3=ABl Avila via GitGitGad=
get
<gitgitgadget@gmail.com> wrote:
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -746,70 +746,72 @@ Markup:
>   When literal and placeholders are mixed, each markup is applied for
> + each sub-entity. If the formatting is becoming too hairy, you can use t=
he
> + s:["foo"] formatting macro and let it format the groups for you.
> +   `--jobs` _<n>_ or s:["--jobs <n>"]
> +   s:["--sort=3D<key>
> +   s:["<directory>/.git"]
> +   s:["remote.<name>.mirror"]
> +   s:["ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>"]
> +
> +Note that the double-quotes are required by the macro.

The closing `"]` is missing from the --sort example. Is that intentional?
