Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6F3064A3
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100149; cv=none; b=mq9oyRCTvz8gSjCz2NRhokymWl39iVt9CSlg3J8HB8t6ZSjTUZIWD1N4V4TVxEg660FzLvaM/uIqjqB/5vlbUmfIN+JEknEK3VcI/eTPFeLPSmqPP02PNs5q4OUIYTfQXUQOgnpFmp+foxiuccGje57NyjYsIW8ywy3ybv7ZFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100149; c=relaxed/simple;
	bh=TErPtQ7yNn4lOkKiz5Cc7NHjdUJzx89A/K37hH7GBYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGhZSci6AtU5rOoW0AVAVnB0YzMuxAQIZ96KsBwERpnM9xzAQL53DNTuPTRxIIgakoLJ12jhVxqBEmW2ffO488J2MWlgSFDwti7Jb/WfAwZYaE1ThLmIf15pi1v08dKGrV3PFGuBErNbQoEHhXlvl+jMz3Gjem5CVk0WpS1j+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-74fbeef1c6eso2056266d6.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100146; x=1758704946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TErPtQ7yNn4lOkKiz5Cc7NHjdUJzx89A/K37hH7GBYs=;
        b=dDeIwF6EKXG1dEBSN2PFnvCJveVv4l16T0S6naTXWtS4zzj7HQEmG3QmpCwu9GqRvq
         qzuPmYybLre3H5KtLkDg8lnRFKWVZeJTzTbFgQdNUPVbeEHxGp++PNlnRXXmJ6yDl6bn
         90gkiBqx17+1Q5XKhilkExpB6LJIam0KMpvm5na1n1qkfTy3Zn5Tece8HSmW9DVQzuCJ
         EusIyW94zrFbJELrm4kt5qWEEx4dhSwRC1Kh/BagM2200JUVmDrW4ukzDBn8zhuGqHgW
         P8wB3cGSys276U3ZLwfkhVwRnEuYMpko7mV9R3VIJHPeYrZUgJx5KxSP8OTfOF5kx0eY
         rgtA==
X-Gm-Message-State: AOJu0Yz2tgjwrcGKPi3rAWCyi9emnTXozlSL3lGxcuI1vFxXSlrzh5QV
	yvFfcxSEXlArL1PI6gYKdmQm0wCFCV4LoaXWV+YTlZfdeqDnjW9PtRT2BMbGtqHlEknC3sEnqsr
	a/MdsVILZO63ipGHAM+xehjH+AXS8JqM=
X-Gm-Gg: ASbGncsn1fj1KqBs2Dn5Z+GLxYTsnGfVn+FULxbUwDC2qlI2VKjwra6ufy4lm+5S6G+
	3LtoH9bbouY4sseAO/2IbNy1k0OtJwz1wxutzmx4IYe2tQb9ol4Qpplj2vhPOh9SldO8BZya/3W
	EajiWu70+SLJh8XA+vdtOGAb4UrzQVgOhF0EPi7Y69xwF2mPkyLkRzwfQVF1oE81tbaVKm0yRzM
	S65SqOCCJ2+BBDDfSxBx+4RH1vCUB1Bv1GDKojjpCDu/cjz8+4=
X-Google-Smtp-Source: AGHT+IGtAqXe55JafPDD/6L+6hSzQU62mp2+XMkJFx44YiesG2QAgtcJpnwNIGRQ7ezXor6k1OyzYkYLI6UDb6ZO7uc=
X-Received: by 2002:a05:6214:dc5:b0:784:4f84:22f6 with SMTP id
 6a1803df08f44-78ecee1a3dcmr7235496d6.5.1758100145806; Wed, 17 Sep 2025
 02:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <fa334405686a329dd1508bf8d8cbfa12dc5dc7bb.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <fa334405686a329dd1508bf8d8cbfa12dc5dc7bb.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 05:08:54 -0400
X-Gm-Features: AS18NWDGrJd5rbvuj66QMZECQGYKIWijdgbzYwbYq2yAr54hKMiPxUd5uHe7n_M
Message-ID: <CAPig+cQP-7z_TNvq7mM=kFqxeZYDg4CzvJLLV+UGyebywcbuGQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] build-helper: cbindgen, let crates generate a
 header file
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> build-helper: cbindgen, let crates generate a header file
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---

It would be nice to have a bit more explanation of what this patch is
doing and why. I presume that this is adding boilerplate functionality
but that there are no clients of this functionality yet. Is that
correct?

> diff --git a/rust/cbindgen-template.toml b/rust/cbindgen-template.toml
> @@ -0,0 +1,16 @@
> +## compat/posix.h includes stdbool.h where git-compat-util.h does not
> +## this is mandatory for correct bool C <-> Rust interop. Though the
> +## 'includes' (and all other variables in this file) can be
> +## overridden in build.rs.

There seems to be some missing punctuation in the above comment, and
the final sentence seems to be incomplete, both of which make it
difficult to understand what is being said.

> +sys_includes =3D ["compat/posix.h"]
> +
> +autogen_warning =3D "/* Warning, this file is autogenerated by cbindgen.=
 Don't modify this manually. */"
> +
> +language =3D "C"
> +no_includes =3D true
> +usize_is_size_t =3D true
> +style =3D "tag"
> +tab_width =3D 4

It's a minor thing and probably not super important but I'm wondering
if it would be a good idea to follow project guidelines and make the
TAB width 8 rather than 4. Doing so might be appreciated by people
reading the generated header files.
