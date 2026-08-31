Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C692C0294
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206790; cv=pass; b=XNTNPHe7N7wDbl5q02DSGW3fqfI5EOfT/l4n8wxT51iaooAt9brmXr0ZZqrflcrgSUlFiCzJTCl0gOQMvvHWbv4Bcf12A/vRP4b2qSnO84wFw3+ndpnQtfu013zexLev8WpI1Af7kAzM9/S0zEdVIwOWm21Sz4/u57TRiZ5y/UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206790; c=relaxed/simple;
	bh=N/+PEvtzq8S3XqNK7P43H4Hlxb73BM4FvcvfqKUVtpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OT3F+fiYHYNE+AnK7MunmF3ajhM1m8weOvg2ordy5kGxNoExlKdNEAZmR1FxKsz7O8YMVfo4N5QW4yrRdPgBrrMLnuEk8KXQ8g9O48ev/yxzouhqrId4RFxshduc53tCgVMt1m0/c9KiJ314ZQa4bjrX/S/UaA89duakeD5lfJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9MfcSL7; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9MfcSL7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485b358552so4036728b3a.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788206788; cv=none;
        d=google.com; s=arc-20260327;
        b=aYx8TrwFZ6k/dD8nyONFO0+zuAVs0gV9uYmGz9mvL3DHEDyCWuVIHsIVsjaqVNx38t
         YLVHrsrsI365xElV7dygKzZkYVgwGTxGXIaiarBMeRTmjG5WQ/3ZPinptRWuWAJsG+1V
         fB1nEAdzgaUSe0dP89Osw1bPqDA0mAJIE1yLsxOyIFALHZgkCAkd/WAXk4ELCuvmvaeR
         SWyc0YM0KnWa9tb/pOsu5Xw7/imcjN6+l5MSVwEWtYM89XhGegv1OUUrNEpHZcvwKPxe
         3mf3p+hzCObHhrn2dcMovGQpUEhvlmS531ZrNMvwl4FykBlo/3hUk6ff2QPyKtnz83ju
         aFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZoO0yWdbl7A//LNSQeYOfJqmCtlsNINi7l5bc1ZekU8=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=nNIsRvL7+wSm4hvIzPgVvM2c8Fm2zJIcrm+Z0D/OuW2+jsXjIsRp5t6ftUVQKWjUJs
         5K8taZD3B7eImnK2E7ttLg1bRXK6njhbip2wMRdV9dcyAaH1iteXZINRSwe08Xq4CKFm
         B7Xe48DM4udGiVpvWGp2SDg9OipCB8dfleYExnnFyBMgSQj74MLsHBhpc959PUdaVktX
         8Mp2q708a9bSf0HVs3+8ZODmzhVO7+SDtllEiBI1yxUy5O40T5gC7jeSb8MC3wWRCD//
         misxlAceB7DtBnUlkKnph0QvpkRcEhvsIeYwwJuRedm4jHln20sCrFntb9b8VFI+9m3M
         S0cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206788; x=1788811588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoO0yWdbl7A//LNSQeYOfJqmCtlsNINi7l5bc1ZekU8=;
        b=F9MfcSL7CWknSaHLg1b9bwknFGADHWiiTwoWHWSoQdb0Cnvw7Yc8AZS7FCXTSsLIjM
         8MTCetZsig1OocUc4Nha3SGU631dD2DHztq/Ha3FBiy5cr/8zqs+ClekwDT2il7UCi7c
         hDia1D1QJyKFq8uEymjafAbJ7h0ZwjMMlvhZQHfkajYhnSYPFFBDu7gl3xmxBwPYQfIe
         NCLGYlgeIHFSpKE/oxAqKk6kHDyqnaboth4Mf6GZp3yw1IIrBcG7ibdNfA6H1JkvKYqv
         kjUOjzZbwPQDIkQ8QJDAJ24Rp/RzRAlylZiRRhDW1/UTvPPEuHb1hvG2SncIcFBHghOU
         dipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206788; x=1788811588;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZoO0yWdbl7A//LNSQeYOfJqmCtlsNINi7l5bc1ZekU8=;
        b=D2GJ55zRtB5oipy7T5WrjYiQXpnd0GGXvDDnVZKVlC9Orl51q55D9imL8Alc7Z3g9J
         zIPUN/o2LZM3J/kW2hfxzW7v2eK/CP9hSTIPWK8ifiwKXPYWoNkJYOLrzqIC+JHCe5pu
         fyix0t0sa+2Vkqltr0I/qjuX3S/lib11kHQ4bA5VLPwZCRDsRo4ECQvPbT6QHqVrDCKa
         2JE/4zEbVtih7bWtY6a+UfzbXohbu1eeN0W4Syby/eImSHzUz6GXCm8eeH9BE8SiEpGS
         gOnOKWXYwsFnfmoGtrKjN70jLw+Duw3ceyNaI/6jf7Uf+/15ygksxf/4oJIPNa7eKHvc
         OdmQ==
X-Gm-Message-State: AFuF++lPUgIlXJojkR8og83aMhEcNqbBoWMh18yK7xlost2RwtbjsglE
	QcI5PVzYq77y3u6ooZUxPrp0SuoOw95GiBsF9qe4HMWL0faYEGE47Dg+NeAqQ5f4Zz7BTqyR9aO
	Wp7LXszL2n3ne9I0BEMc64X7f8GpJoMg+LtnX
X-Gm-Gg: AR+sD11S9eBeJjlrvnBR/D1qN0soVoZ0EoCZPgY1foORlYduW6caXIRAM3VGK5UyTrv
	91IojrDds0vM98gwmGemv6lJXYH3rMMFH2MOOEtWlDR1/nbfqUk5vq+78ybPI5Ec6sD1Ee3bisE
	nDCrTtlNc0NELFyRW9NyeRfxAXXiISinGNbTGNECY6ot8O33ZegkUc8SyodKc305w2Qn79Q/W61
	Pzxv0KcYcsYtuJfIe+rybgMG3Rba7sSM7BED2nfSpI0cUmQZZVNu2e/PkFWz0xJn/CPS6CO63jS
	W49EPp1buWQnF4rWXXFfIGU4iCIGRzLONMj9iW2TxZsLBGnJvqaZ2m+auDa7supm1lGVP/phCoA
	VORB5zqVw31/J5uN2G7fd8+nGcOM6Ip2bda1GSt4y4Ns+yC87o0/k+otF7MsDVQ9E1EXvV24L
X-Received: by 2002:a05:6a00:800e:b0:84e:d5e6:a085 with SMTP id
 d2e1a72fcca58-85b56940463mr5239950b3a.0.1788206788222; Mon, 31 Aug 2026
 13:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788206466.git.ben.knoble@gmail.com>
In-Reply-To: <cover.1788206466.git.ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 31 Aug 2026 16:06:14 -0400
X-Gm-Features: AcwNN1Xfoq5PiyBrgdQGpGV4qwCqVPDw5Pt40aGnl6XCHc2fPf-6LMjDHXlJi_I
Message-ID: <CALnO6CDCqACYpR=GoaNR28wwxYOEQUJBA1U9sX-xDhO8-4_n+g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Convert USE_NSEC to runtime config
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Erm, woops

On Mon, Aug 31, 2026 at 4:02=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> Topic name: dk/use-nsec-runtime (applied)
>
> Topic summary: Expose USE_NSEC as a runtime configuration, since
> build-time is too early for distributing Git [1]. As a result, common
> index-related options, like git-diff, are less likely to hit "racy git"
> problems on supported filesystems.
>
> [1]: https://git.github.io/rev_news/2026/07/31/edition-137/
>
> Built on master (2c78326f81 (The 11th batch, 2026-08-05)).

Changes in v6: slight comment tweak

> Changes in v5:
>
> - improve message flow in patch 2

[snip]

> Diff-intervalle contre v5 :
> 1:  d612de6c2d =3D 1:  d612de6c2d meson: expose knob for xmlto relative l=
inks in manuals
> 2:  12974e07d0 =3D 2:  12974e07d0 environment: align repo_config_values_i=
nit with struct declaration
> 3:  01cd487cd2 ! 3:  0a611f6140 core: convert build-time USE_NSEC into ru=
ntime core.useNanosec
>     @@ builtin/update-index.c: static void xrmdir(const char *path)
>       {
>         /*
>      -   * not use if we could usleep(10) if USE_NSEC is defined. The
>     -+   * not use if we could usleep(10) if core.useNanosec is defined. =
The
>     ++   * not use if we could usleep(10) if core.useNanosec is enabled. =
The
>          * field nsec could be there, but the OS could choose to
>          * ignore it?
>          */
>
> base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
> --
> 2.55.0.860.g4b6b3295ed.dirty

Thanks

--=20
D. Ben Knoble
