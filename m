Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D42AE68
	for <git@vger.kernel.org>; Mon, 12 May 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056402; cv=none; b=PvNekZaesiWVnDheSlSpTbeFiJl463nfPymadF9/9FXSA579vH/tFhtvTWDyEGx0MeshfRmr5+BL4xkT2GUWwOB1jjUG4ymsQ5YeNiOnN2h9inxRnQCcneggqYHUlh4gL0faeNUHH5o6f2Ss+OCFZ76MoFwQPqw1cJtOVvlnhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056402; c=relaxed/simple;
	bh=pDlS/OhdhpmYOco0pBkD2uXnPkWvGG4JZ783JtJuuHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBklHf/34B+IemypTVlxJeRv3BoL9N3zWMoZlaheecgNFRk13ZaPBCNzVorwuvglPBADD76P1dfH46+rHO0IS2EDbDz5WtjnKUaliZZM2YbYsNfLcJU5eCdqagMUNd4zyLkEv9G+XriDnSS8KW1fY4iYyTPk3dQvee89/Xroi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED1ewD1V; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED1ewD1V"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72b0626c785so4021969a34.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747056400; x=1747661200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVE/lRszhGWV7qNNRDvo2Kc6cjullVI+F1Jv9nnakzU=;
        b=ED1ewD1VZtcbbISzRiggzB0f6Twi/tsGGtAlpDjIPhJKZmwklTuuGBr4esWokxsREM
         6Fpui/ah9P3bxtFyaXl3ie4Ei/PfF9UW5HtF8bZj9kQ373KNDXoAMYL3bYMnc/DgbNab
         7AEo+n914TpKAWqu2kqMChxuHvmt3EVMHI6AgjR2zGvZaDIxSZxuZgi1Xw2ySWcfVMSs
         KXuoiIRh9DolDti5ylL4BtwVP1yN06P5/U9LYZEtTYdIXXL/9U8K5VJozbzsGBIBSxWP
         E7QyIvAKgWXLjn240DihlK/wfErEalVrKUqlLLM491xNRpBYQY74c1Jf4xr6cNcVy+06
         YAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056400; x=1747661200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVE/lRszhGWV7qNNRDvo2Kc6cjullVI+F1Jv9nnakzU=;
        b=mLR4BXJR2AIYVGO45VnS5zT7Q0n+AlfSzubi9xFSSOkEw3PEH1F0XUFGlPrMmuD4oh
         INuZJDL07bbj9JvC6amC5tAQz/mQKyIFS75udyQMmlPedkA89G5PsNgkeeI/wzQ0ERiF
         Qft7GG4Nd932/KjvYl7z8P0KlxwarswruZRxxSVA3d/EQV15IUTwBOtOOqYOiERzfBgL
         r6a4MIeT/LMeoWFt4y9YmCnlPWzqPRx9pPJYGMiDlrpIg7i1rXnd48vCp091SfcYqTBA
         rZte7l6qalN6Jp4vYd7XSDofLw0++psDsgkDMIHFl/dREpcUnyh1+4nj9hLhmiA883CR
         SBBw==
X-Gm-Message-State: AOJu0Ywuux0d4XguTQFKU8G14+bEdH8OrQ8XjMRCOxZSYRY71xiVgUjK
	cpen9UxXV2DftcbEPmIk9Mad3eO6b4LkSUx7n2ffZHGo+dHqdy7TmMDxV94e4KBcPwFozx7ISDc
	4Jdbd8gHG2CoAhrR5kKwitIu8eFYijkMZKa4=
X-Gm-Gg: ASbGncsMrBToH7tDNkmsu9VugMUssk8bCyUzR5zmcet3dBz6PCfUYnpE5BwiPAMphdW
	CSlfBc9hpvatEN43FsgUoDEJcP594cJQE5enL3m4x/r//09mx2EnMlnJpZUcS1CZW3/q0m4hlVt
	CQvdZbBXRmcOm01D2mIjKkHbXM64rfN6ERo2HzEGLXGLlIiVnrOgNdiCzWWl2dX+/n
X-Google-Smtp-Source: AGHT+IHB4FGmkftyNam+VGxJdbvcwp5u7tDf6vvFlQ9VsnD83M//xswaVOhOpc5dHF7gPWBUu58gxKVl42PC9tWiPXU=
X-Received: by 2002:a05:622a:2612:b0:494:7e51:acce with SMTP id
 d75a77b69052e-4947e51b4acmr29457071cf.39.1747056390008; Mon, 12 May 2025
 06:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510054542.556401-1-jayatheerthkulkarni2005@gmail.com> <xmqqbjryxb5j.fsf@gitster.g>
In-Reply-To: <xmqqbjryxb5j.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 12 May 2025 18:56:19 +0530
X-Gm-Features: AX0GCFvZ2KblxlgmImiMsMuFUpbtmidREag1eyzkyiNWV9X7J3Vn2HgdpMBauJM
Message-ID: <CA+rGoLdzT01jLigX=Z+_tw715O0BibgVA+Sj+65Qwee7i5gLfg@mail.gmail.com>
Subject: Re: [PATCH] submodule: prevent overwriting .gitmodules entry on path reuse
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > When a submodule is added at a path that previously hosted another subm=
odule
> > (e.g., 'child'), Git reuses the submodule name derived from the path an=
d
> > updates the corresponding entry in .gitmodules. This can silently overw=
rite
> > existing configuration if the old submodule was only moved (e.g., to
> > 'child_old') without renaming the submodule.
> >
> > This patch improves the `module_add()` logic by checking whether the
> > submodule name already exists in the config but maps to a different pat=
h.
>
> Quite sensible description of the problem and the proposed course of
> improvement.
>
> I do not think `--force` that allows the same name to be reused a
> good idea at all, though.  We shouldn't encourage its use to resolve
> such a case.  If what used to be called `child` now sits elsewhere,
> perhaps because the tree structure was reorganized due to mass
> renaming, but if it still is being used in the project, there is no
> good reason to nuke the configuration recorded for that existing
> module.
>
> The module name used in .git/config is purely local so the user
> should just give a new one a name that does not conflict, or even
> better yet, perhaps the tool should pick a unique and nonconflicting
> name automatically, no?
>


That makes sense
I see the point in using --force to resolve name conflicts might not be ide=
al,
especially when the previous submodule config may still be valid and in use=
.

As a potential improvement, I was thinking of mimicking how duplicate
filenames are handled: if the default submodule name (derived from the
path) already exists and maps to a different path, we could
automatically append an incrementing number (foo, foo1, foo2, etc.)
until a non-conflicting name is found.

-Jayatheerth
