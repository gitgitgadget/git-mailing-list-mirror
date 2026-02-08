Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B7346E71
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770566835; cv=pass; b=jmV9a+vGFEvmZPRreSKUPf/RjDG8wf2GjvDMJXTzqekW8jRhk/MzMEb19qOnusVPJ3NpyMVNrR4cpq0CELCXipHRgiERTZtCRLNy/mdqIkJdFIo14g9PMPHjLoVGC6P6TfLcjskMPQZOaKZbLsje4KAtitj7GjH/mTHXoblJr60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770566835; c=relaxed/simple;
	bh=/pDG6Dc2d6pUSp2KxLOPpmfgGK3TQWDM460RGVsY+QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELcznO1o1Y9H/cW15Vpq/SamYROTXXXN9N3ShQXXfR2Zl46L6v+h3tYJJJSqbSam7G5M6aACTYwZ93uBA5gsFaQptGFj+sQsIqPBQgdNF3uoU/I0X1ffiaTjDQHJXNVggGRQjKdunsGJjaFz4bs1Avkhx7TA+DNYqahxn3cQoHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/b3055H; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/b3055H"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3562258142fso525231a91.3
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 08:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770566835; cv=none;
        d=google.com; s=arc-20240605;
        b=XZtkpi0d1kvphxsX9uwznUNl4A3y1kCHy14mAXCU+TgvqhYkQ4M2guz6I6cbdCYUgV
         Jd6++9V2HpL1uvt8dgBmlhy/3vv2MWqU+bElLOU7pmyXT2lPlVWD6f6rB+CTkwbWdVH1
         0nRFZoUNBlSirWVjCWJsexh3cjbLIqRc47WClI5ms11HbhO115YyYU6Bn8tFxvQWfYHd
         KhV+oyfobktwBr8gNjfcOYS09Qi2vlWL+/U8dxysrQVoyhtBNSbdDWevt4SANgsSECvE
         ujpfX3fZ0/9j2+xjuTj6EOjNVASPGNSOAmkKK47vYemw2JGk1pnd+vdSibNOVGeOEU8o
         Lszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q7GjVxUkv3c2NB5/RKHjBVC/QuTCz29P0sx04I9ZNdU=;
        fh=v8ULrFKnpR0siQZehbIQ4qcK5uZRAB/YmlCRP2IJwlA=;
        b=WRixujpNtx9FjkRO3RkBCwgIQvDOJ7QathHnYW7X//54j40lo7HPgYwTGwPPHeyObe
         QobTvV9Jes+Pe1YgpiPTViYIQi4A7IJyMEOQiA3qSnElLyAKQT9eQ8vYjuhNR6unbpLw
         beRNZPucqZPI2seUQ0m1W5aroeZ08ey7FDi3fvSgdd+RQiAkFdirFgaBAjbWOCP5NxW8
         DGgmIOUx5JwR2TGyE3S8eeNqblK6wPtK4ICcbgaESWDlZ23wPBPvOzGFAQ/JcRabS1ml
         ojcaLdqC0PAl1Kfh3vxLlP+TO59UigvjPSlx3qXO/7c4KlD0P2esMMXhx2TBIjwhSWG2
         ZBXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770566835; x=1771171635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7GjVxUkv3c2NB5/RKHjBVC/QuTCz29P0sx04I9ZNdU=;
        b=F/b3055H8BhjR7BcpSqIktTxa7JfklyFSJMc5HfMQyzww8EcbiGohhqnfRXFu3I3Nm
         vPSFSrrTAFUo84A1zVYZln5GM3Klee/3WFBfYI+s5RCgiM2N76VZhSekLz3vXKQ5iePa
         mf/rVA+HcLo4vu6pIaLHuXGkNSCa4Id3V3CSsmhNSPbeNyzq4p2YuB4g63q4ixzdQdT+
         0fAWQe/6k+HG9uu9Fcq1yGliEgY15fywJxm/GqxSzJcJGIa0gBwlGhHX2oegMBrHFybL
         ffBaCMK74iXh8SaZ9nodPWXL9vnFDYHJs2Wa/373p25CVEYiplovotBhF/Ivuy0OMIg3
         vqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770566835; x=1771171635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7GjVxUkv3c2NB5/RKHjBVC/QuTCz29P0sx04I9ZNdU=;
        b=CVw4z3bP3SWFC7yccuv3hxhfPMPDvLKS7rOgVSwd4SnP/+/qm6JK8PGKYbJQFsfsMZ
         hBSvapHjxP9fVl64WRsOvO8P4HEIo6BF0HSo3mTRJPcC6PQ0NPQGZ+7nu1j1WD7SH3lB
         I4N+Smy0uATdR9dHnOC1Iw8VdevfQgtuUi5OG8aItiRIR6ExzPeDGYlyBhhje8KGYPkJ
         KS3R6sjCOD40Y4DqvmZNO/WMJKhRE7/eHJ5ghkVHyNf3Ql/vx9amH2Lf5+r1+mTQrENW
         onh165J+KZ09weVu36NjoHxTpmWLqK1VPv/GYOUC170c/XIBNWcMR7MbqeK1j8XDPeIi
         YSbQ==
X-Gm-Message-State: AOJu0Yw4IbhmYHdvUPHf0U/hftN4du5IABq4XTlh+k41njUNq/BOYXr7
	qPMtUaWxSSEaG1xtPhd/lGLO6OGFHxpfCJhzRPumJlyYiELVCG1HMu9p5UutmO6V5FhsP6wOLqK
	/1m/m87RpxvpNxPR0z+gPLe0BBUpV9DGIW0f/
X-Gm-Gg: AZuq6aJ+21xThusOsshnk8UGGny2wlIhqs4gywv9yx8ggBAYtqPbQuXfnOreXEwDpuX
	CYkpGSCq32jpIprOguLZwdMYCejCB8eUr5fWiCzYB0gKR6JpJtnwK7vLc19fgCQ7aSLe+T3MRZt
	4PAbvSloGa0p0caA6aO3fJiHex7WjgMHWFqwxaN+RiUNPK68cImGlp2wfJRm4eShcy0zLdx+DEM
	vNbhkwz33JM6pBcIIKctU3EJeDxzL77F+/IhH0uD555fdu+OFntwIWM3KRMk1iDdLh66d+hZ+bb
	YS0uIwKPdBWFpMgpDWIk31ys6oyXnjkntMBY/T4oMe01gh3iZzk8aN1cEodPqmpHbDrc
X-Received: by 2002:a17:90b:3945:b0:356:1edc:b64 with SMTP id
 98e67ed59e1d1-3561edc1183mr4042826a91.8.1770566834614; Sun, 08 Feb 2026
 08:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 8 Feb 2026 11:07:03 -0500
X-Gm-Features: AZwV_QiJY-Aj02b9qmQJ6VqhUAi6A1TkSiO9hLhLROzwba6A8oaAGegscUhYZ_Q
Message-ID: <CALnO6CCDazixno6Of8ufEV9=EYcGFdawmv5X2J9TNerW6CZMJw@mail.gmail.com>
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 10:37=E2=80=AFAM Jonatan Holmgren <jonatan@jontes.pa=
ge> wrote:
>
> Hi Git developers,
>
> I'd like to propose adding support for UTF-8 characters in Git alias
> names to better support non-English speaking users as these are
> currently restricted to [a-zA-Z0-9-] which prevents users from creating
> aliases in languages with other characters. Shell aliases do not solve
> this as the best you could do is "git-f=C3=B6rgrena".
>
>
> This would allow users to set aliases such as:
>
>      git config alias.f=C3=B6rgrena branch # Swedish
>      git config alias.=E5=88=86=E6=94=AF branch # Chinese
>
> etc.
>
> The restriction comes from iskeychar() in config.c:526-529:
>
>      static inline int iskeychar(int c)
>      {
>         return isalnum(c) || c =3D=3D '-';
>      }
>
> The function in question validates all Git config keys, not just
> aliases. The git_config_parse_key() function (same file, 543-598)
> enforces this validation and uses tolower(), which only works for ASCII.

In particular, this comes from sane-ctype.h and ctype.c, which I could
not easily rip out of the build :/

It looks like Git's ctype definitions are ASCII-specific even though
isalnum(3) on my system is documented as using the locale, so I was
hoping that if I could build Git without it's own ctype.c I could test
your aliases. Bummer.

It looks like this goes back to 4546738b58 (Unlocalized isspace and
friends, 2005-10-13). I don't have an amlog note for it, but searching
all of lore turned up
<https://lore.kernel.org/all/Pine.LNX.4.64.0510130838240.15297@g5.osdl.org/=
>.
In the same thread, [1] suggests we'd have to use more complex logic
to parse UTF-8 config, right?

[1]: https://lore.kernel.org/all/434E8650.7060604@zytor.com/

Anyway, my opinion (not that it holds much weight) is that user-facing
parts of Git ought to support international languages. (If the `diff`
line for git-apply(1) has to be ASCII, that's probably fine [2]; it
should definitely be parsed as a byte-stream.)

[2]: https://lore.kernel.org/all/7vachd6hdx.fsf@assigned-by-dhcp.cox.net/

--=20
D. Ben Knoble
