Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DF3803E1
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158630; cv=pass; b=HlLs4/gdYyuXvanANMnqq+UkjsPcfB05OZxskU3Fa62LvfMuVMxg7xULWbDt8EDzDlv/WMLN2h0Iq9lN8csmPJBf8GzCaunJutlEwxOPbzreHc/Q3A6WJM4TgnOk79Dpv/P1JUUnXjMe9my864xBHCyZt9r5gccl++LpDujx/Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158630; c=relaxed/simple;
	bh=NPsrwvyzEScMtdyQH/DIQDMuW5Vamhrh/gZUWXYVmRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2n0TFAMYJXQpDlNbnVT+2HWP9IsPji18Nl9h6hJXI+ByhRjNC40Egw8MiHN/MFNlgeJzFkmk0GQu/m40LkOhuWu0L0RVfV2nCtO9hdL7DSJe2FWsvYSdU86UgQqlyuEwU/Dis5FqzwT/WKAtYNYAffCpSAtjRaAo2AsertAsp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSqHeUGM; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSqHeUGM"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ee37dc91f5so680000a34.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 09:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787158627; cv=none;
        d=google.com; s=arc-20260327;
        b=JDgu7xCkhy4Jk/B+E7ycI/CR+MqCVA/tvwTS7TNRJrscyb9NMqGcfQlNqekB3CJSP8
         O48z5VesGmMSpHWZogKN7Khtzr9NDJVj7RXfmHTuTYxJ38O6UCLmPjyyRWfoSXkwZnAz
         ABc2e0UorGb9Ao7ln5xqLTfJMm+vQ269qCyIJhcFnVa9kxzCifCXyciXbQevaBXdjzXG
         OoenVBm48chJn+27kLcsZvaPSBeYMv+9FbK3BrgIw3fzv4NzRTr5p7P9Jlwo2UdiLITU
         3SqSEsF3jTjFZti1hkYuvySLZqWFOEs+/0HIwpUPOzstx3Zwu3JW6AoZxHzIwkgZv53n
         vO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6RcJ/1+TVT1aTzvTq7oIgN5FCcvD5e9sCpgbrmbZ7d0=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=SNCl759HLvBFbzZCE4pX+3cAkGQcy8W2/LHgCDm+j4mRgYqQJLMcSJGzZiBV80VDtV
         48kz7OavoZHSdKu3tOyYTOTY3hqhwwlZ8IRWe5b8A6mL5V6Z+7xIecyNRePR65cQGSgz
         pzTCpYiBS0xJxRs0RSkS8pnuEosH14BM30KeVihy88xckTaOJgy7WaW26bUeCVJZfLsA
         CG91XEu2L4Mlz8OlpEkaCMnXK5SXQk03/5wlfIN9uTPVUebocPsfhwjf9MF6Ff5CYkC/
         owjteZxARC0VFVSK8t0/jZpeWld6Y737qdGR7QAmqNlGWL3KlcXR/uj89vQWmSe/3Vdm
         68rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787158627; x=1787763427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6RcJ/1+TVT1aTzvTq7oIgN5FCcvD5e9sCpgbrmbZ7d0=;
        b=nSqHeUGMquNyQVjKCnZl1bGinvLlC/uxpTWm2a9yQ9RMqJOVvSgGRLYu6NO8n/BrtY
         S5EWlwm04LqEcm2EyoROF+ODbGJhqrLttwM4rCvv0XahNvfcbtktXhdshBLTEyU3J2X0
         C8XeeMJooW2GvdqQsKeywpsEMUPsVvbNjE7V5apZRpQ1YUBMVf/beFiwvPtMscshPeZo
         YXWibqPmrKC7IMeQxbMGpqY/nj6uwJlbLwk48Ocvcw5/dPmRTLILMHWFGqKf53XfrQtX
         hFV0IrUZ/bwXUV/dZ7KxA3zj8Pl7tiiKffRVwF+im748JB/QI09mn4blGdhi2FEoGobA
         RB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158627; x=1787763427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6RcJ/1+TVT1aTzvTq7oIgN5FCcvD5e9sCpgbrmbZ7d0=;
        b=JBeJCVyqve+dgLqbkJcGgUHfsszxsg0xra12Q/LRMW8KiVPsMVLhYljRYqKVCrMpYh
         qpWI1vga8UlNl3i5zBrGxjexyXYm9ykyco4N6F1KCcfRL8DBohFoIzjEJ6OO4PzWAj0b
         VMjwBtbTUmGoAmqNqezu+HWajX74gNjATy+vjgRbx/usN1SrZn/X3jv/FAJWJIvx/nA5
         y9d0xFSWuOYjSaly1booZj9nF7UR4EQbspr/TlA7WMGGp8FhKCasXCRqzGN/fMlPbimt
         VzZwoyhp1dLu1BuUvIVHbCAXRHyw1KFPYetd3GUCicIfzJwypyE3iPuQ+HIOj6nuWhxM
         m3Yg==
X-Gm-Message-State: AOJu0Yxp5vtdcQQY+BV1TioS4VTtarCYj1lltgqCT/1jx1aCscD8RRgh
	heOyXOHODqyNWiiNGZmsmBF3oqfc9ofb04tipDGQ94d3NhxwxeLNfMh9wU3vHw9AOet70Wu2diG
	PY6vDxWWfwcniBNwD+/SoSNszf48ZimlSgoSU
X-Gm-Gg: AR+sD10D81UNVcsHOE2QD8mI6GKHbTX19brc/m//PS94jWPLoI2NEyuODmP+l1ks19L
	3isQND0ShNIvh7+mZH2/RX+TEn0T7Gsd3Tepb8rTIZgid+ushbhZIOUFp2DI5dvsf57A4YMM01l
	Id/FZe5XsEhHA+t21AlU5qgy+wZyVQ/BMzzWADYpEeBaCwdUlCeO8ApZ/n3FxbJ9m+LqLGCjSvs
	ZRv5zt8LXrUYewP11mhYmUGgVQDB/uTdLuCm0zOXp7YI7VQig7dMne3/MoQn+vafaReVE5+/A2u
	pvCeXnfYiCf2LZ30Vj6Ea9fI6jqLgnMGwOkFrk55/j/YemB6redmsVqtZZE6gdCcFoliHAnjHqo
	DwaDHxELnZPd3a0Trdg1fCsr+xeoFhkyGWWz0RBxr4BAxs76i4JeaiOGXy4FTn/w5uTC2NtEu
X-Received: by 2002:a05:6820:2d05:b0:6b1:3804:306 with SMTP id
 006d021491bc7-6b13c69ae85mr5313983eaf.32.1787158627286; Wed, 19 Aug 2026
 09:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im> <20260817-b4-pks-odb-generate-pack-v2-1-4c8a96ccfdb3@pks.im>
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-1-4c8a96ccfdb3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Aug 2026 09:56:56 -0700
X-Gm-Features: AcwNN1UM3ji1YnDWv3v0Bdq3e5QppIhEPHEq3AZLIAi---O8AshcXA1I4-c1vSk
Message-ID: <CABPp-BG3_xvbXtt5BucyOy-dHXqX569d4FBfyZwbLiAb-qRPXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] odb: introduce interface to generate packfiles
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 10:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> +static int odb_source_files_generate_pack(struct odb_source *source UNUS=
ED,
> +                                         struct odb_pack_generator **out=
,
> +                                         const struct odb_generate_pack_=
options *opts)
> +{
> +       struct child_process cp =3D CHILD_PROCESS_INIT;
> +       struct odb_pack_generator_files *generator;
> +       FILE *in;
[...]
> +       cp.clean_on_exit =3D 1;
> +
> +       if (start_command(&cp))
> +               return error(_("could not spawn pack-objects"));
[...]
> +       CALLOC_ARRAY(generator, 1);
> +       generator->base.out =3D opts->pack_fd < 0 ? cp.out : -1;
> +       generator->base.err =3D opts->progress_fd < 0 ? cp.err : -1;
> +       generator->base.finish =3D odb_pack_generator_files_finish;
> +       generator->cp =3D cp;
> +
> +       *out =3D &generator->base;
> +       return 0;
> +}

Does this have a use-after-scope bug lurking here, due to the
combination of clean_on_exit =3D 1 (which makes a copy of &cp for later
use), and the fact that cp is a function-local?  If I'm reading the
code right, start_command() calls mark_child_for_cleanup(), which does

    p->process =3D process;  /* where process is &cp */

and then cleanup_children() accesses various fields under p->process.
You do copy the necessary fields from cp to generator->cp, but
&generator->cp was not passed to start_command(), so p->process points
to the function-local cp.

I think the normal teardown path happens to be fine despite this
issue: when odb_pack_generator_files_finish() calls
finish_command(&generator->cp), it clears the child by matching pid
(which was copied separately from p->process), so the stale pointer
never gets dereferenced in the successful path.  But with an
abnormal-exit, which is where clean_on_exit comes into play, then
cleanup_children() will be called and start attempting to read
p->process, which now points to some long-reclaimed function stack
space.
