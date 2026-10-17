Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D3345EB0
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792236179; cv=pass; b=S28CT+AuK6LbRP2WW1PIZSPWTNZcLWvdr8QMhGj3+40xDqjRYYLJdtk6g2AuPBVsdD8XKTcNyP5VgXiSzTaaE/UQe/976wa5y41OeEgJwE7kBuExMpcWSmyK15t4rN8SXkAV5VaxmcsxEqPlBhD5hW03AzfU5n4WMGyh+HgwkAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792236179; c=relaxed/simple;
	bh=bLQEoYqDXXTmwhHwJRuV6IFtaZjOWSXyuyrxZmA41UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHSyIKkTemigakF8cgRQa2rD17UXlREsAdo5ehRTKPqQVp56XI5E8iROQr8te7x5W9lAL7QZuNEPvdR4IpkH/OSKF96XMv+Cq3SWNM3tOdtyTNBeapf+hSqprvQm+yUA4z1DkDMBM4A71Ad93N/MsDPB/vY30jfRyJoQ+FOz+UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2GRkC0z; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2GRkC0z"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e3846d1caso96190366b.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 04:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792236176; cv=none;
        d=google.com; s=arc-20260327;
        b=lfZrUcJnEvuzY9Qv+bmps6pLlQ2P0DV5CaSwT8e1fB9Nr+zSgR1uJkuhEFZXMuzUBq
         rtT0CkpJkblPUe2/tRkcYDZQjjyoIsm3xK6nULCsIRvwf49DouuNhSbFSBftnRnLvooO
         SOuhj6nt4H0VxoRZppDHRXw/au3P4nqOGTplufxuqQvSMZpXz6+Al1JiZcPX4FL6E3E5
         jHH5sZJCzw4DmWTq8Ba+/2fZTK63GZbNwr9AjuQlbny+kxHkd514bUJHvkyjl/hOj1t2
         y7iaAAM3/uqsVjr30sAn2bZq6CbMvnhekgLprY5QqU1JAYkcErEqWvUelv6JuiNCXrZP
         +ukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLQEoYqDXXTmwhHwJRuV6IFtaZjOWSXyuyrxZmA41UE=;
        fh=sN6O2JCRwpHrneUaNj2g9oHtSA2M4ci4W6BT6Cypqx0=;
        b=pzJjQlptMoJbE5ICfSte94GGv06sc7VNItrVWpOIeawfxErCE7Hbiazx1F93qYVDBa
         uJsJpMyJngJkyO+J5Q8xTgN/fAr+ONReZvOhxkfBlJ+6UiFD+iHxrfgS0KNINPEM7+r9
         8y+XqgrQrER83jHXidJ+is9/qA/r6FwYKxJds9qILQYv++g/CdxtAXfKd4PyYpkNJ9Wy
         Vz8OzCFTa8Yp7M9CsWSB4Zfny53UP1lWXhgJlMXGnv360U6AZzkCRgj+qKGk/mIhfy9Z
         IQsc4SlX8QgjWm54AAaK1QqsKYrucNMjI2KBVK0cV6R4lztq93ySOxZuHLyGyKuIlrFS
         9ygA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792236176; x=1792840976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLQEoYqDXXTmwhHwJRuV6IFtaZjOWSXyuyrxZmA41UE=;
        b=p2GRkC0zckctJE3DKZDIxWJZyoI57QAD/5xDTS3Ncee4iFQuD3Ncgs9GDpwr3G/fzp
         DEQN45rHjZjZG/h3mRgipfkcRfMfX4PO2+kqxN2ftfo8CB/OtbRP388iFI3iQe9BMPEt
         tMy3zfi1iab+MKTQEkaECKwbWZB7/qZI4YLtk7MHA8zOlnrN4OrGJVy7oS7NsZJii7HX
         0OPJH8/Qnc6X6LuSe0drfNz1mFlRkt+aq3DIBtPo9ZOorH3g4mlpMfhqRtML6JOLUWi7
         ciflDBmSVnqpEyyCCtwmXjuIJ1HIcDcPsBP2so39b2MTmXS5nUv+8tXIG0SjMkA1e1Nv
         DV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792236176; x=1792840976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLQEoYqDXXTmwhHwJRuV6IFtaZjOWSXyuyrxZmA41UE=;
        b=b3HikOGJ0OjBzwbe3pk2+MnLjhCw2x90GFYlm57SsL2I8gOhcFPlE2Y7hsj23QZUpZ
         KwGoF+dplPro1DjIu8w9YtTIKOw+e0Fhobpn820Omn/5py1K8GD1X7Aq1cyHtmSaRYqJ
         wUiJdET+03Qe+WXRmpYmcxKY1Yn35b8Cx5KAZj2yj7eLn2dY345rN++R66Gqyw7RU+Mv
         sXRup71J8vXLhyqvyYyOw1026sNOMoZHmoR1V0fhua0YBNsmacqTtkgW/Awyt1lKTGsJ
         R/6xcjTBFSxRpTUBscqCoMSyncdtjVQOxAm6Nz7SbhuCxGHOXCezFPRLDNbGH4aLMOhR
         qsYw==
X-Gm-Message-State: AFq9FYI6RWzw1OKk6JRhrACdht/aDitZSzgQsqo8Q9ND+x2ofdcMUWG0
	0KxZY7iquPleu3AKmVGqf2n5XL13Blm7/cPVShU14vUnRN2KabZ7cxz0PNPwh20egYdEAu+bl9+
	wxQVP3dAYyMlIK+vhWAyFsslgBzvWGSk=
X-Gm-Gg: AYBFou164nM6xdV3LCS8JR5BcuXCYpfYEFEr2HrRhUiPR+PtFl1BvIl2+QOfJLouMXo
	zkgfGtCFvTQyKwi2PSkeKDtcAgMzgHVNgXalBAm2zlyIeyxrP9EVXLkpUkduCV23R+PTtliNNy1
	MamQ6M9NQrbIjj3Pbdp3X7JEnqbolR1y4YOAwUBywIxbWZZrjRUfp0+q9hW14XKkLBUFuRI7fLS
	u5cFjySLwCIqr0/C7ckK7ZFEWEG1RmAGDO2FrM85BYs1pd6IApPdgUiToZ2X50cT/YqY1X7Ckef
	TUe7nSJetdOqExV33JFdOKP4tT1142VjJAuDrE0QxDigs0Ro/V1Sgni6jfl4sLz5dRm5Kb9IOFD
	mDl4uZtqyfNHpvpRhBkhW/2hN
X-Received: by 2002:a17:907:3fa9:b0:c3f:c10c:216e with SMTP id
 a640c23a62f3a-c419a9434f3mr181469366b.6.1792236176201; Sat, 17 Oct 2026
 04:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO=0-S4jSCbYvLPVdL9U=6PPn2w-apMaGpQaOF_AuDN7n1v3JQ@mail.gmail.com>
In-Reply-To: <CAO=0-S4jSCbYvLPVdL9U=6PPn2w-apMaGpQaOF_AuDN7n1v3JQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 17 Oct 2026 12:22:16 +0100
X-Gm-Features: AclHuK9nhjgRwj0GkJzbgRtBImEVnqfNNRnOpIHWIC-VJPYvb5ViYC1502A0hf4
Message-ID: <CAPSxiM9_fv4cBzOEqLCz8AKM774S0-JQmssH2z_yRmpAyno8yw@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Muritala Mudi
To: Muritala Mudi <ibnmuhyideen95@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi everyone,
>
> I am Muritala Mudi, you can call me Mudi and my pronouns are he/him.
Hello Mudi,
>
> I am an Outreachy applicant for the December 2026 round, I meet the
> Outreachy eligibility rules and received an email approving my
> application on October 14. After looking at the projects available I
> got interested in the =E2=80=9CImprove how command arguments and options =
are
> scanned and parsed=E2=80=9D under Git.
Thanks for your interest in the Git project.
>
> I first learned C when I started learning to code with ALX Africa and
> that made me want to go back and learn how low-level languages like C
> work.
Good, did some C at ALX Africa also then.
>
> I built Git from the source, I ran the parse-options tests (t0040) and
> worked through MyFirstContribution up to the parse-options section.
> I=E2=80=99m now looking for a microproject related to option parsing and =
I
> will share my plan moving forward. I=E2=80=99m happy to be part of this G=
it
> community.
Good, happy to have you also and we are looking forward for your patches.
>
> Regards,
> Mudi
Thanks.
Usman Akinyemi.
