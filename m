Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E727A904
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759209; cv=pass; b=aGembbJoIkg7MSMjqZ+E2A3714WI5vliR2l+nhE9EdOsBkHPc++HbLNY3dmxvCtKplqkBG9JbifUTG30cpdY/Ei1JVUTNu+J7/NDdn+cnTE4dMgSOX7iZt6JSf594BbHANI3/BnKHXDWsVXZIT7oGpCd/j1GbpFrLlyNsm/AGNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759209; c=relaxed/simple;
	bh=ZBYrSRCNuuxoRi8+FCw1T9DzO7qqGDTKWhIcvef5IjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhpU9mtvPm7O/2AU72XOHbnOnR7wuoDdQpH5ylmK8/aFc+IfjwYNwLYRgOqa0SG86WqU5zstaZG0Pg1p5Ks3jSoaA5Ag2p/hlEul8v3PIDhd7m0Almx+9pwVYOGbomz3RH8DbFvZLBHkzwH1bNJMSh8vO1eLTjs2sakBukkNx7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLDssX/N; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLDssX/N"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a9057b2ec3so6302605ad.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:33:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770759208; cv=none;
        d=google.com; s=arc-20240605;
        b=Ny4F4a0c7v1NvvW7Fl6dPiSyPcvcprA5oqf4N3Kjm//ElCJJTN/g3/aYevgIWGvV3i
         hO5qi/Y8H6ssvQoioHjfG93LgnUNmpoASPpr8EbJP0CbIO6G4verel+CmDrtP3DoMNTA
         6T3UH3+rbF/VL957HKjHoUHKK6mr2uhSBR0FeVk7LbFfaAPA2uEeF0i/XgxqwTBAGMu9
         BYibpQlKndAFpuleZv92uQUl4rIDfpD9UJ+6LIUCTuYeR2P2V7fsUHMb7K7AN5ri+tFo
         k5aUr/8XsO255FVr93GZIuQaJ+z7V01CHKJT2WpRCuwr/aseWa6KXXDq6HstfIvy3ft7
         EAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CoxuFOYersjyKhYkCzjQ1KkWwwMfhSUihTJi+rBQtvE=;
        fh=mJbBesx+oRc26OZKm2CZILTBbLe8BCinXbh84KNv+5A=;
        b=Y+Xd9fiDwivGmTI8RGMdRE6WTkYa5GuYrJsoenjlV4faxTU8x/ERQ4SSZDZ+FigK2M
         72S/p6gos7BQ2T2am1HNYM8AfH5zmUumItRLmZVK+IpMRhkNpX2CyNlxZWctZkso8O18
         Ami+Q+vC+Mbr3EjbKIqtt0+2qBCUTYpZJIMAeBJQJ7fmDH6M1BGIIWu2Ihw0apgXPcFg
         l1hbXuPasf+aw3zwXBGT6p33roYCgs/DcFKzEnjJ18yHdqrIFKasU45pt+FaqgnGYLM+
         l7y6cIQwR8xGdP/Rw71OZDMHxSpHE7MqXnSNhFdQDGUw33jxgd3P6G1zDacjauWYtF5I
         OZ/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770759208; x=1771364008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoxuFOYersjyKhYkCzjQ1KkWwwMfhSUihTJi+rBQtvE=;
        b=hLDssX/NVrecML5Rt2sxblOfmVazXYKzTCHI9JjuGGO7VYyvNdBrRWRQdmh6NATHl7
         REcfatAZcFt6iT6DwCK/zur5Nx8xWYxf138s3klkK6F4CEmmhSAZViqBWIi9ywBTtJ9F
         cJE9EcE5i5db7XEnbcKb2WMCmr5614xhXfa0apHukeSwGJFdjy4XAoUm1G1AuTUUlJrL
         9Na620ROxO4SAFeDNA4Iap00cXmgIHq1IUO8WSoABYvJOsCQzwX8O7PYvTd2X5ECc67e
         TIjPeOHQMloBX+8JB/Ju3eg5tfQ3wlRyfRh97G5auI08XaaAWE2jq8PkmIrJxp/raYH5
         8+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770759208; x=1771364008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CoxuFOYersjyKhYkCzjQ1KkWwwMfhSUihTJi+rBQtvE=;
        b=SgG/BpQyB5KbJBLmgydpbYuSKuTfMKkq4hoYYL1c9LOi2AGlKZJzwg/nqGw/bRy7hl
         eD0Xtatcvt0QM1bONartdrkdauu3kXJ97xrk2BrgZAYPD8bE9zoF69pZ1FdqRAGI+OaP
         xoqw0RCZOJQhhSmP+9TNMCw2j+pCz7UZQjZq29BRR8MX4vvzy4mloqE3UGcgJRI/pa8J
         SHLw0EwuIP/hcoPsUPozndYo9fvHhQpRVKEp23+Vd2UM8mWXZ093VzoFqg+dwUJHjPMT
         5h76bjsOmApxhUkA6hu96teqdx2doOJpfuJFMe8tYr3t9HDYBuxFaCB+d4ra5yr9FjAx
         WgtA==
X-Gm-Message-State: AOJu0Yy3DYxYuYRoyzmpBGPAkq9DOLyk0NXl+BvXWLkGx4h7AyBPIiwk
	Wp6ACZYUKJnDW6P5Vp9S83dt5uwWhurMrG76D1cXHhEiPF2HJRPgzFTqIxNLOqKIWDnxNfb5CBb
	TDjFV7ciepxvTrABk5y2Q1tVrm6lanXc=
X-Gm-Gg: AZuq6aKMkCUKUs/nmIQhWwH1yBrpyN7bHvPE9rd3S/rqMVP0vEvRQzO9j6l7EnjNayG
	lXE/6M9bKYoP96JPPpl9ehRJBioN46uxLT+8apya+gnNKdyAm6kTGpT/0eTl+gI9RKCMDE7acto
	dh/VyJE7GvW7o6In7TWFpjBj/OtWk82NvUZZCJlirqSTH3Qcal1Aqe+U9acQVlEsksxxIflYeQj
	i165QHJ7lj8SthmytPG2RdtnlYMSpfhnrIEQOqIz0Qc4e5wVJgOAomXPqsxrNln23dM8Y/cCMF5
	ClLd1WT58YaNzGhk3I8BhctCGhIYiFiZ480nMhkBSebD/H1EehaQNLPVr3+bqLgE0bejX+xtF63
	/DX5cTVhX/ELVWkg=
X-Received: by 2002:a17:903:1ace:b0:2ab:1eef:0 with SMTP id
 d9443c01a7336-2ab1eef03c0mr20460295ad.51.1770759207721; Tue, 10 Feb 2026
 13:33:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <doc_link_rerere.328@msgid.xyz> <V2_doc_link_rerere.34f@msgid.xyz>
In-Reply-To: <V2_doc_link_rerere.34f@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 10 Feb 2026 16:33:15 -0500
X-Gm-Features: AZwV_QjA2Jmui44uiWWovrCqMpJM0qCABW10uTLSXANYWjNOtrqVnB185VdQQIM
Message-ID: <CALnO6CDxOPXuFMp4Us8cvbF5FZeT74fSKDFy5Wd7D4jmF9=QAQ@mail.gmail.com>
Subject: Re: [PATCH v2] doc: rerere-options.adoc: link to git-rerere(1)
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 2:57=E2=80=AFPM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Five commands include these options. Let=E2=80=99s link to the command so=
 that
> the curious user can learn more about what =E2=80=9Crerere=E2=80=9D is ab=
out.
>
> It=E2=80=99s also better to consistently refer to things like
> e.g. =E2=80=9Cgit-subcommand(1)=E2=80=9D over `git subcommand` or `subcom=
mand`.
>
> Also apply the same treatment to git-add(1).
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Topic name (applied): kh/doc-rerere-options-xref
>
>     v2: Same for git-add(1) and expand on the more general point of it al=
l.
>
>  Documentation/rerere-options.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-opt=
ions.adoc
> index b0b920144a6..4395fe05356 100644
> --- a/Documentation/rerere-options.adoc
> +++ b/Documentation/rerere-options.adoc
> @@ -4,6 +4,6 @@
>         the current conflict to update the files in the working
>         tree, allow it to also update the index with the result of
>         resolution.  `--no-rerere-autoupdate` is a good way to
> -       double-check what `rerere` did and catch potential
> +       double-check what linkgit:git-rerere[1] did and catch potential
>         mismerges, before committing the result to the index with a
> -       separate `git add`.
> +       separate linkgit:git-add[1].
>
> Interdiff against v1:
>   diff --git a/Documentation/rerere-options.adoc b/Documentation/rerere-o=
ptions.adoc
>   index 115882edab1..4395fe05356 100644
>   --- a/Documentation/rerere-options.adoc
>   +++ b/Documentation/rerere-options.adoc
>   @@ -6,4 +6,4 @@
>         resolution.  `--no-rerere-autoupdate` is a good way to
>         double-check what linkgit:git-rerere[1] did and catch potential
>         mismerges, before committing the result to the index with a
>   -     separate `git add`.
>   +     separate linkgit:git-add[1].
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> --
> 2.53.0.26.g2afa8602a26

Excellent, thanks for also including the rationale. LGTM!

--=20
D. Ben Knoble
