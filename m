Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDD27E7FC
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099510; cv=none; b=GaPT+skSQQZAnKacMLkyZWh0nznL74WxHz0tjy3sYKaAX1O55sJEnj3bPn3aDCeKVbA1zwINXs8x7wiZ35RhZox4gJSSgoBOJE46GwftgYbElp6zRcdVcc4PRAzlSY+ef1iX9vvT5QVst1hwG81Qu48BcM6yU/+ZTjzdcuDOYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099510; c=relaxed/simple;
	bh=FtqP/pSF8NTJ8lFX5DJQKkDMFpSOZuXqKDB1KVnNSbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PN+5vL6R+BznPY3pQsO4XsuNvI+vb6xxhW6EwhruFiD2rxbhpAUOxGhAzPEiDROpdu91IbXcggeQ9mgvFdsfV6BRJnpREb7ubHTcA8TAUSP+Ig5SiYUu1XLa6jrw8TFw7jnKIxrUadVUuFct2WujjGO+25TasWnBPkkFe2+YCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-82b19440a50so51821185a.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099507; x=1758704307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSMaBGE/794++0ixNDQPi4XZZ7m7OtyocTAQc6DYKT0=;
        b=YEuuwIu+7FGQbkUrK7XJEa1r4jp92VTtITkkukCcFvg5iVIPVpdzhndHeKn/OZxMeg
         FiKxnG9VwnSNLjPS2OOD0itlgyCUa54wqhv5IBXtkSVOkaZ55H0jnlwE5okJyNPNojB0
         ye/1MSHVDP7pChF0bT9BRUsHucdMElEtfzFDaZp8kVMmj5/ENYJrXdsH5fE4gznHX4U/
         l2thS66845/dNLTjQgmH5gjULsxgEZuYAEs9EIIq2DXV+iz3nToEhzm5RtykbaTL1eM1
         Xs5hDfntVxSd0qGZUxX1Yr6inTjVXQpIPEpRAEgXgOGLVIZWfsM0CmZR3V2dX7mXyhrQ
         ekvg==
X-Gm-Message-State: AOJu0YxJVP19YK1kbrrONSifeTAg+yREU9TyuffD0skfh88V8sUHeiSw
	FVL/epX6Lygcy5oVPA0xMX4PM0X+uITcNXmWzuCbpHpkp/cKausVg8Fj79FQ/8w2uuNqv86qRM9
	GwAizOZR/BrKFyviDPjUhS1K2cz1XBZ7VlQ==
X-Gm-Gg: ASbGncu8G070drljhr1HNEJ4f+kl385OJ3SdeDxZDjunVn6MfpGxIcDh1rUkBAxW08C
	blbrWI/Ly+CT2gznD7dzGxDvVN1OekdcCpTRN/lCcjVBCGxifLTh05ti0QNzizFFONxiJiw2wuC
	58zCSOIq67VsAN2VOYvNxOqelH7HznWViBOXcIFxLMSWaPm5goqINFZrEuMWb9AtkOF2NX8KrhB
	fw1uAyDtRrk9EXhqq5/qv003Hj96el5JYeeBqAyxAB1uYJ9YZE=
X-Google-Smtp-Source: AGHT+IEPER4qFOZJZ9VYs3mjwpY/LZeMZ+LsRy+DoZ3DmxTsFDT4J7ncKhxOoqJMyxjVUu4UaKky5i/SvFud0IlOdYQ=
X-Received: by 2002:a05:6214:1d08:b0:736:261c:d636 with SMTP id
 6a1803df08f44-78ec9a1a070mr8929246d6.0.1758099506944; Wed, 17 Sep 2025
 01:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <1c923a71f27ba204ea17a725daf45576d0aa3ec5.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <1c923a71f27ba204ea17a725daf45576d0aa3ec5.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 04:58:15 -0400
X-Gm-Features: AS18NWCqoiVtoSPPTU5385OgDAzSCfwtYJC0mP-hoHZ4z4NRAhhJ8UQTexMNPIk
Message-ID: <CAPig+cS+=OVNBBZ6Yq7s_ihWjkDO02eMH14P1xny4qAeT9ynXQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] build: new crate, build-helper
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Make a crate that takes care of the boiler-plate code that most
> build.rs files would need to write.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
> diff --git a/.gitignore b/.gitignore
> @@ -257,3 +257,4 @@ Release/
>  .idea/
>  /rust/target/
>  /rust/Cargo.lock
> +

This seems to be adding an unnecessary blank line (for no apparent reason).

> diff --git a/rust/build-helper/Cargo.toml b/rust/build-helper/Cargo.toml
> @@ -0,0 +1,7 @@
> +[package]
> +name =3D "build-helper"
> +version =3D "0.1.0"
> +edition =3D "2021"
> +
> +[dependencies]
> +

I believe I saw a later patch make the sole change to this file of
removing the unnecessary blank line at the end of this file. It would
be better to fix this patch to omit the line in the first place.
