Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD62BE043
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121509; cv=pass; b=gtTJBjjFWEvOoH2MK/Ec4XKwtFITeV32pFvab0ZNIa5nWf1S81JoY20i6ln5qaNxkeaXLnVX2Pzap1MA8KS7Zhy/ToFU8BaG3RshyxDjEAonzfiqQjlNqiJB/me2Grsn+EpkjWRUtkk6kQoK03/DikGTldhxqtafTBRwGO9Li3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121509; c=relaxed/simple;
	bh=jxukiBD4Vsb3am2uelb24ZaUvU92r3aVHIsKj4DJzso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZuoc/aH/Lxo1iVlPeNrS0tFDPdDluLnNL3ikJ0Qr1EtdZEtmfQdbLl7XAYY3rczwd6xHXR+XAMFm3Rj7F9VVby48WaJigrLLOjQBnp/fmlX+vjQ8GeNkCqm8Lu1AmtbSOksp5KUu2Ox/IvHyFXna/Qy35LW1nl1NN9Z+9WkkaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deLvAk1/; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deLvAk1/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so2147568a34.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 09:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786121506; cv=none;
        d=google.com; s=arc-20260327;
        b=fWEu3bC6O4UrICTp67DPNRJFB6/REpE2BNEuZ0CLobTffK4QP/onmQFFdEbVwTz0JG
         lzjUMYA31oF3H3ibHClfsmXn6wKBLDUZTPfhwinIMQdxUJrgPixr9myJlqBedjny2HiZ
         J+urHjjZod9aHuTsWbziUtCGiYmXxyKFpITbQhw5pwcdUbUvDMgA657O4og7xNqg3DHA
         9E36K5Jt34eFzDZCitgJuMWAqlUxNmTFY3G0+idHTv76lv06IEHSVPfMdo62ffEZww+r
         zYeZHuBN6199ZwyD4iJsNlHzr9erFNEjvd7FOiSSFWXbkYJIPhHIVrqKtblU60P0OLQG
         +f0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZWHBUopfb0QJOFeq1FbaLthwwHPyGYG4XTNXdVRxmgg=;
        fh=pbmrmLYvkXWAWYuZGAWmR41k0wm7lT9DpwbWm1jYiwY=;
        b=EmMI1pi/iMKl8+ikjRHOxzT/rZWsqS6hkZ2jcxG9OAk0mQihky0gqtWmcYRL7dkGR9
         U0tMYpUw6FS2q/722exPrXBCodCgWIqDAMrjqTgYjycmrMCD+7C0AetK4FPa36MNnvMr
         t//rd+ClVUdWGzg1WaSIqMPw9tkcP/HTlp7otLMs+R4QA9XNiLQ9sYrUj5i0jg9EYgvU
         BqgSYQTB5tHkNodhoXwFmm+ytCQNHB3CxrWSPY+ct91ZBSanNmLtcCDzpkoJNu2BsUJ3
         lgxpRDnTaQXFVCB24SAg0hB7PFIf+kCcsaOmZvt3bpvxqDgsOB6UPKLF5wNnyeqgi2Xf
         KflQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786121506; x=1786726306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZWHBUopfb0QJOFeq1FbaLthwwHPyGYG4XTNXdVRxmgg=;
        b=deLvAk1/FjgubLnk04MVjx1bJ0mRwH41ZElxpWWP21OJCqHhjDFvHAbLKpxfDlKl3k
         Cw+9Cc7tqU5Y6pMBU0FgD+ZJ6Y6HkdyVdmX/V7ILx12gMqFlig/V/CKw+CwvmjuSrz8v
         a+dmEokBtkJ40Pe61D0qk38BPUYVBhccbIaYhvty7uKlIuFJPu1v6Jz4wzJO0MJ6YwlG
         CbDByMPBv6ZjJWanuujORnwC+k95W38Hg91kwYz0Uwi1kcpLnKV26pwfo/lVbeWgH2Qy
         /nt5s/ybp4kJ/cM4B4X9gcM5P6RwP2+cyUF0fdnhOaIGO/Ztv6GokHbIHBBPeQNFU2jH
         PsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121506; x=1786726306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZWHBUopfb0QJOFeq1FbaLthwwHPyGYG4XTNXdVRxmgg=;
        b=Bx3i8O6tiUdAof9rWoig7FdkfwOe12W09/zas2w17kF+aEAlfldV12QwDJYK9608eD
         C2I5SJkdtkjU5m2jcaY8pezEqI7huoutP0KTFxvIb//j8iN809jx2WCvNpPX0KZTKjFg
         MC2805aEhaOpLObi/y9frwOggY5sjbodo+U7GuuLj4nlL8yaFNewAh6Tf5vDJZ0H1A4F
         YEykIROuHCq8ZWUfGXgdwCerM440DNQlgHQ21bReZmbz05eiPkH9AdgTJeV6AuKQ8Kfo
         K0e5RlHeXFksCNrp7ONsYC9WmdPK2Bz/NFPitTTdUubno/Ium9hlJBlYHmatfKa7E8VH
         viPg==
X-Forwarded-Encrypted: i=1; AHgh+RqgsXKoSpzUWV/sbU94JdKvKItwl1e8P+6r67kPx/E2DGEXt3ecqHYaCm1q/TEUIs+98ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMF8pcxGsuq3KTea/zquDbvg9s/4BGe8OLmjtj/5ohtHVB6UVZ
	AoIeBsF14Gy7343mcLqgOYqmiNEopXo5WVd5ZWKjgTie35j9P2zr3kouIrL12XXoKXVddl562R8
	55HIsjzXHbodyOpLK0as0gROq9ia1zaA=
X-Gm-Gg: AR+sD13EjxujjsJludtEV1CghM00SeYw5i5z/ou2NuFg/SMTnbiAFyhai/nYsAD2hTK
	PqLUTQOcugA0OQDlFOKQATcYxBp3CNoCyzlpVpZmhpl9s1srV+SVFBOHzsr+3WYuVhEBlF5dGO/
	CGPns9QJ8+w0d9wdsFoDpokaK2lqiqSl9M2jbG0q78ujAAba2Ejq2vBQAtmiaFzkmMuCeLVZsBC
	uwSYApVm1Uxb+P67K59CerKY8fc49fxrc0HeJoojQcGqCZpkph/JTcfP9HE6Lm6oqYnI5+jOYBL
	4XuID6yzkGH9fydU7NRf8ntDcQ1uwSqRD1O8HqiCRyc6Mb05Z/rpROxkH64Q9Y+f2tJ6eSLHvep
	I6j568LypdKB8IAe1EH0v4tws0vwyGNA4D3P5O5+8YKwRdj67kKu8yaYtOeqM+bw=
X-Received: by 2002:a05:6830:2e01:b0:7e9:e8a6:6389 with SMTP id
 46e09a7af769-7f1e5c9713dmr14783893a34.4.1786121506486; Fri, 07 Aug 2026
 09:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com> <f158e1f92e9c586fca34faecaef23f9581d65478.1783704657.git.gitgitgadget@gmail.com>
 <anGcx4lRyy3jyS1D@pks.im>
In-Reply-To: <anGcx4lRyy3jyS1D@pks.im>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 7 Aug 2026 09:51:34 -0700
X-Gm-Features: AUfX_mzp5qvxBFK5fHb3PJj0B_1EMoDF5FfGkYsWwD4CYdHB7oTOPlu9mHVK7Xc
Message-ID: <CAC2Qwm+Jni+xU=gaef1AWCMj9+GUQhMrCWX9DFpS3y757pxv=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t/README: document writing concurrency-safe helpers
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> >
> > +Writing concurrency-safe helpers
> > +--------------------------------
>
> Nit: this paragraph is quite specific to lib-httpd, so it would make
> sense to mention it in the header here. E.g.
>
>     Writing concurrency-safe lib-httpd helpers
>

Originally, I did just have this as a blurb in t/lib-httpd.sh. I ended up m=
oving
it here and trying to make the advice apply more generally, though the only
other existing example I could find in another domain was the
make_symlink() reference. My intention was to make sure someone working
on a test helper with concurrency didn't skip over the section just because
they saw "http" and thought the advice didn't apply to their use case.

I'm inclined to make the language in the section more http-agnostic rather
than changing the title to be specific to http, but I do not feel very stro=
ngly
about it. If we were to frame this as http-specific advice maybe it should =
go
back to t/lib-httpd.sh instead of t/README?

>
> A simple "rm" (without "-f") should work as well, right?
>

Yes, definitely. I think I over-corrected in excising "rm" from the test he=
lpers
and the advice given here since I associated it with the flawed patterns th=
at
allowed for the race issues. I will redo the treatment of "rm" in the serie=
s
including reverting where "mv" replaced "rm" unnecessarily in the helpers.

> > +A "$$" suffix on per-request scratch files keeps concurrent invocation=
s
> > +from clobbering each other's fixed-name files.
>
> Nit: it might be a bit easier to read if we explicitly mention PIDs
> instead of assuming that every reader immediately knows that "$$" will
> expand to the PID. E.g.:
>
>     Appending a PID to the per-request scratch filenames keeps...
>

Agreed, will fix.

> Thanks!
>

Thank you for taking a look and your feedback!
