Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83181231C96
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099901; cv=none; b=HUteq7t7r1lSwgXHtzsYZrsbiOobAHbLibjMhuZwpE4RpZTyUa7M6X0Yf5g7lGzJIR6HxGH8WUIteQRX98LxVA79B9To/4SwHyNZGAzg+y2kp/fz184F48tRcXI46yDkQ2K6NvM0G42eQdaklKNQrzNykIckZ6urLzsiMvzEdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099901; c=relaxed/simple;
	bh=eKcWQjQeTUjUkkbrsNa4zIGE/06YyQWSntEd1xiuBTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyJ9Gv4fT3pUUErO5064RsUbfp+i07YMHRwvZKxm7E/1qL7UH/mMacy9X0SoZgjDebHhLkNUwyQon0R3dXzTnADTVhl8JAByYEDz0l3N1UzPxCJPCj1nZurgVZsdIvvygp0KPlDy9nTInuhoyQdBGxPPgviI9QWosYr7F/t4zwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb22ac1a11so3590876d6.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 20:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099898; x=1728704698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRLCBz1rFmyBXB16RcPvb0SDPqENpbuZlQzACx0j/Ns=;
        b=AtUbNijvonotMXx735mFeHGJEjGtg6zq2DB0Z4sXHowxa+bYSMJWCALLlalp0cfOc5
         jabjdZiqw3/J775xbptSxthEaNsU9JQYW2VPIBC8D+U5+jDzpEtZ3/neLhSjyRJNgg6C
         LLdJ0imk/0a22TsuZ4k2HktOuB10R4Jb1kxaVq+prD1Ap58FOBUBiJdvRIX7YdxmtSBl
         +0qLcHhcUEjeJRz6ltQjU/gn9B7mT6vkvzg2uw9IYoFAe+fi48uPezn2fex7TuXX/5UR
         YsQFaSYrvPTO3qgc/yG3pKORQ/UycCNzkWnr6vRtpYOz69Fr3ZvdBCx5do3n3S/VTBs0
         4y0w==
X-Gm-Message-State: AOJu0YwpyL1EvfBUM4uLhAX62eYP2T3r/ZR9nMGVMmWVETwenU49/Cbu
	45tTLVMNqBpzT0+k6zO+5TsaYWD7/Sg6c3lJAGy836JPtdIiWE0YY2ygc4w1vReoKYg89Qzjmqk
	Qez55Isp9EiJll+NJosabJz2haAs=
X-Google-Smtp-Source: AGHT+IFKYxRU4dpAHYnrgfhnU/s4mgX0mNasFE12+4caFKkCrpv8IyXyS5syhHEyX6fsDmsmGvrQnWJF0EkUkGUXYU0=
X-Received: by 2002:a05:6214:b6e:b0:6c3:5f4c:4ffc with SMTP id
 6a1803df08f44-6cb9a32ecbdmr38470706d6.6.1728099898514; Fri, 04 Oct 2024
 20:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1784.git.git.1726943880.gitgitgadget@gmail.com>
 <pull.1784.v2.git.git.1728084140.gitgitgadget@gmail.com> <167418d10d137cbcd278a98c95168150df10627d.1728084140.git.gitgitgadget@gmail.com>
In-Reply-To: <167418d10d137cbcd278a98c95168150df10627d.1728084140.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 4 Oct 2024 23:44:47 -0400
Message-ID: <CAPig+cT9dofoAPbRCzp-VGHDK9qpy2r2f09aExN=WYFbR0n8aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rebase-update-refs: extract load_branch_decorations
To: Nicolas Guichard via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Nicolas Guichard <nicolas@guichard.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:22=E2=80=AFPM Nicolas Guichard via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Extract load_branch_decorations from todo_list_add_update_ref_commands so
> it can be re-used in make_script_with_merges.
>
> Since it can now be called multiple times, use non-static lists and place
> it next to load_ref_decorations to re-use the decoration_loaded guard.
>
> Signed-off-by: Nicolas Guichard <nicolas@guichard.eu>
> ---
> diff --git a/log-tree.c b/log-tree.c
> @@ -248,6 +248,27 @@ void load_ref_decorations(struct decoration_filter *=
filter, int flags)
> +void load_branch_decorations(void)
> +{
> +       if (!decoration_loaded) {
> +               struct string_list decorate_refs_exclude =3D STRING_LIST_=
INIT_NODUP;
> +               struct string_list decorate_refs_exclude_config =3D STRIN=
G_LIST_INIT_NODUP;
> +               struct string_list decorate_refs_include =3D STRING_LIST_=
INIT_NODUP;
> +               struct decoration_filter decoration_filter =3D {
> +                       .include_ref_pattern =3D &decorate_refs_include,
> +                       .exclude_ref_pattern =3D &decorate_refs_exclude,
> +                       .exclude_ref_config_pattern =3D &decorate_refs_ex=
clude_config,
> +               };
> +
> +               string_list_append(&decorate_refs_include, "refs/heads/")=
;
> +               load_ref_decorations(&decoration_filter, 0);
> +
> +               string_list_clear(&decorate_refs_exclude, false);
> +               string_list_clear(&decorate_refs_exclude_config, false);
> +               string_list_clear(&decorate_refs_include, false);
> +       }

Same minor style nit as previous patch:

* use 0 instead of `false`
