Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757020322
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100622; cv=none; b=KcjBUCsSaZFgoyqwNL7aOgO0YAbSexBLJ/h527jv8JE52TvCwcHX1xulKnOGxswk+ZdFoX/D/v4NETvB+LUnNiWlPXAKQzQ+usP1hyNGQMdnlp4Ixfb+oVXFkyOLPciN42Whm99Hf/nZ3oI+PToxCjzGiGDvKTjdYodBe29bReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100622; c=relaxed/simple;
	bh=UWbq23vv/jSqVEfqbsuTsYg7XAuP91vNLDYw74UVchc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwJwfDr2avk2o+PQfPcT2khmvv2a/1YAbThPnPjFxO/c/HkrbqphCS6tC0eVs0mN/GmaeL+Pp00up4P0O0bR9ZRM6qwkpYbR9KAXNKU3nXHCfxmuldbhPrlUQrdIusm8OzZ8jaRuUgXgz2koMJcesit2Qg3Nowrk+Dj8QpiGkD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b606291fddso8592791cf.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100620; x=1758705420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWbq23vv/jSqVEfqbsuTsYg7XAuP91vNLDYw74UVchc=;
        b=ETqZXEI9HJCRYRMdQSPiEsGne9SUF0dmE71ngpPIZ+CeTG53PeNfoWQ3T5frCxVaMf
         75iE0z7B33vEzYRZVTnRZIoBfD4Y95S7JRuuTUMqzzszcLZ/8oFJIBTMyZtBXF6t8yb8
         nM0KoEHNADjbC1tW6HrHLfDTeHPoSKd2Kx7wgBrGj5iuXueOA4FFf5l1ps6Aa4O66J3v
         W+gbIenHUBbAIffI6nqlz9YDB8oDPbNyZhOvSPdA4fnj3m6R0MSroKy4L/tJSpC3seeq
         LNNAtxlRxUP6L5xJC/Adf454TWD46ZRL2x44stfX02N3UvG/3H772BmTAdLXiGoOEmqw
         qUww==
X-Gm-Message-State: AOJu0YxkCr3IOHhZ8qg92cVFewtJie4ZzaBOCBxq5SfbiwR0K7raEAPA
	DigF7+OgU3m/J6MNABYaf/NQBtsshiSPa89/btXsKUW1kzBztwtjD52mXficerxIpA48qgQlIDc
	jsXE/RYdUDyElQns/M5xqhgVZn78mZzwG3x2c
X-Gm-Gg: ASbGnctWeEa3JLKrqZK9RATqymnj60Ho6TDlPyd7zYYE7oXPRlEu+yTASUU7IEBekbW
	FOHULNYAzcNsDiMeEzBQnq2WVYzEpDf0ejTBh4b0SFeGbIOLzelYGf4cYElogtdvBJuqh8bWjhJ
	dGMjrQHohYWWQ9cvrGT0CjrjWge+WRRorrURBFLywoeeRrCWJBWg0363NdvGIkIorq6MuaEu+yu
	A0FbsUr8Qbe0yiSNIPoz/GH4vpx1MrM5yLiQ+tT
X-Google-Smtp-Source: AGHT+IEGefFnknD5AvfZpFRvBgvSGzOQ1NbZftR5eTG2AfWrVdUaCQ33xByixrW0OLZZ6Ln0LDmt3Hf7C/Kv/q2u4/M=
X-Received: by 2002:ac8:5e53:0:b0:4b4:9175:fd48 with SMTP id
 d75a77b69052e-4ba5fdec15cmr10296051cf.0.1758100619976; Wed, 17 Sep 2025
 02:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <17143ced6feea5927b66c0578f1c2fbb07378504.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <17143ced6feea5927b66c0578f1c2fbb07378504.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 05:16:48 -0400
X-Gm-Features: AS18NWDKT8A-dLGvZy8xMHbRDPKUpZRLlq6ylgTQOPaDF4fNcALV8xFmsC7vEZs
Message-ID: <CAPig+cRD84WZy3V0bCEwHpz=LpXSHH+ao8GZnn5ibcG8Cp4=PQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] build: new crate, misc
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> build: new crate, misc
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---

Please extend the commit message to at least give _some_ information
about what the "misc" crate is all about since it is not at all
apparent based upon the name.

By the way, is "misc" really a good name? It sounds like it's going to
be a dumping ground for anything which doesn't fit anywhere else.

> diff --git a/rust/misc/Cargo.toml b/rust/misc/Cargo.toml
> @@ -0,0 +1,14 @@
> +[lib]
> +name =3D "misc"
> +path =3D "src/lib.rs"
> +## staticlib to generate xdiff.a for use by gcc
> +## cdylib (optional) to generate xdiff.so for use by gcc
> +## rlib is required by the rust unit tests
> +crate-type =3D ["staticlib", "rlib"]
> +
> +[dependencies]
> diff --git a/rust/misc/src/lib.rs b/rust/misc/src/lib.rs
> new file mode 100644
> index 0000000000..e69de29bb2

Do I understand correctly from the comment that this crate has
something to do with "xdiff", yet there doesn't actually seem to be
anything here referencing "xdiff"? Am I missing something?
