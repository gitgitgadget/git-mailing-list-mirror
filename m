Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA463C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558535; cv=none; b=Wrm8L45lQfU6uoFGD6ltB8MJKoqxC1aIKDMPnnRwfdtyOMqcyHq8jkGgi1Oe1+PqAMUf2xB5FVr0Nz+YnfGc4JNP/50SEWrt6IJjrgyd+z8+Oo2LZoeL8wC0KrWlOlOovOLUhdeRFfEoWZK5KsR9RfCjpA0Moz73OaCJpqiuqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558535; c=relaxed/simple;
	bh=Jlbc6HINfb2QjlsZQvBYi1DA6wN8+tFDTdHrqNJ3CmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfvSPX1CmXlDKXmVRRJ1dEdYwams5t44XXYCYTxgjH7z1gQN/fOSR/NOUHdDsjjw8+72B+mJTBvv7qR4+krZ/axLzk36L4kg+kPgxzmOCgqfp7W4pDEhfmM26RYf23N1RtbgDKVnGJxrQxs2NCH07zV8Kovt/G/1QpWScSTptyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d41bff2b8fso3486306d6.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 10:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732558531; x=1733163331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMhERh7CqCtoSpH/rsSa4peqkgfDsH1ZiCkRsUxUEHM=;
        b=bpHriJL/hZg93KETUe5i903hRNcA2mqWehnGKY8SUThV7ML8NCm+hxhSFO9rX8ExMa
         gtAcXxIuLOxIY6yFO3OLyudMLej0rReHQ0diiJmELgYMY8gmpE1HZ1pkxGMXXy+4bQBK
         Y6pQ4E3Ddzo4tqfCzER3QY++irUsZ6ktL5tefWkgOer8l7ab7IMrbrFooMt+lhuLuSBC
         7F4e42m+nHqYYdCCVbfi2gvB0lHUgfqEoklufbpvFtr8bo66Vrwp7/3PwiDuzOoxqscX
         4DYZSAAxGaCnOoVoBEtyqMJ7mLF0Zo0jcMzUS5ccSR4+eZ0gYbCSHDVEbqoYi8LtiAjV
         GikQ==
X-Gm-Message-State: AOJu0YzF8gwR336/xtDHaLpLv19FIjPVLQZjUlD8YjTIoEmEA6K9+lTn
	kd+6yKuVAVXSZWeKOaWXCx5fwt8Nr0Z+2L3fs9XS0JKIns5bITltC7N/3dayDbuFdpxUJfbWyft
	KE28CfcJPsnhVxs6H2OlESqvydWo=
X-Gm-Gg: ASbGncurdsSL+/IF1l6awv3kV89+7j1vMu0Uu/Naq0sh8jK+3LDdiPtTc7/4rnJutmU
	mKICyqfwQliwmuiFJcey0ZPXLr81iEA==
X-Google-Smtp-Source: AGHT+IE2ovlqKE39mjVfIm94JM/dPnGtTSXP/vFy/LAVLLj1T/hL+NG0WvZ0oBtQP4iYSilNw1PoPJMygoc2DRyYXSc=
X-Received: by 2002:ad4:5bc7:0:b0:6d4:29f7:f9cb with SMTP id
 6a1803df08f44-6d855844a69mr5626276d6.11.1732558531090; Mon, 25 Nov 2024
 10:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
In-Reply-To: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 25 Nov 2024 13:15:19 -0500
Message-ID: <CAPig+cReWbkomYYNAY_Q+6ezukSt8sZ+Q0MP=45DY4XeS3M==w@mail.gmail.com>
Subject: Re: [PATCH] fast-import: disallow "." and ".." path components
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 12:58=E2=80=AFPM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> If a user specified e.g.
>    M 100644 :1 ../some-file
> then fast-import previously would happily create a git history where
> there is a tree in the top-level directory named "..", and with a file
> inside that directory named "some-file".  The top-level ".." directory
> causes problems.  While git checkout will die with errors and fsck will
> report hasDotdot problems, the user is going to have problems trying to
> remove the problematic file.  Simply avoid creating this bad history in
> the first place.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> @@ -1466,6 +1466,9 @@ static int tree_content_set(
>         e->name =3D to_atom(p, n);
> +       if (!strcmp(e->name->str_dat, ".") || !strcmp(e->name->str_dat, "=
..")) {
> +               die("path %s contains invalid component", p);
> +       }

Probably not worth a reroll, but is_dot_or_dotdot() might be usable here.

(And -- style nit -- the braces could be dropped.)
